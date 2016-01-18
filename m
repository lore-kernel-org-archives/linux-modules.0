Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([125.16.236.3]:39417 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbcARPXb (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 18 Jan 2016 10:23:31 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Mon, 18 Jan 2016 20:43:54 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [RFC PATCH v2 07/11] firmware: replace call to fw_read_file_contents() with kernel version
Date: Mon, 18 Jan 2016 10:11:22 -0500
Message-Id: <1453129886-20192-8-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Replace fw_read_file_contents() for reading a file with the common VFS
kernel_read_file() function.  A benefit of calling kernel_read_file()
to read the firmware is the firmware is read only once, instead of once
for measuring/appraising the firmware and again for reading the file
contents into memory.

This patch retains the kernel_fw_from_file() hook, which is called from
security_kernel_post_read_file(), but removes the
sercurity_kernel_fw_from_file() function.

Changelog:
- reordered and squashed firmware patches
- fix MAX firmware size (Kees Cook)

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/base/firmware_class.c         | 48 ++++++++++-------------------------
 include/linux/ima.h                   |  7 +----
 include/linux/security.h              |  8 +-----
 security/integrity/ima/ima.h          |  1 -
 security/integrity/ima/ima_appraise.c |  8 ------
 security/integrity/ima/ima_main.c     | 18 +++++--------
 security/integrity/ima/ima_policy.c   | 26 +++++++++----------
 security/integrity/integrity.h        | 11 +++-----
 security/security.c                   | 28 ++++++++++----------
 9 files changed, 54 insertions(+), 101 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 8524450..cc175f1 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -29,6 +29,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/reboot.h>
 #include <linux/security.h>
+#include <linux/ima.h>
 
 #include <generated/utsrelease.h>
 
@@ -291,40 +292,10 @@ static const char * const fw_path[] = {
 module_param_string(path, fw_path_para, sizeof(fw_path_para), 0644);
 MODULE_PARM_DESC(path, "customized firmware image search path with a higher priority than default path");
 
-static int fw_read_file_contents(struct file *file, struct firmware_buf *fw_buf)
-{
-	int size;
-	char *buf;
-	int rc;
-
-	if (!S_ISREG(file_inode(file)->i_mode))
-		return -EINVAL;
-	size = i_size_read(file_inode(file));
-	if (size <= 0)
-		return -EINVAL;
-	buf = vmalloc(size);
-	if (!buf)
-		return -ENOMEM;
-	rc = kernel_read(file, 0, buf, size);
-	if (rc != size) {
-		if (rc > 0)
-			rc = -EIO;
-		goto fail;
-	}
-	rc = security_kernel_fw_from_file(file, buf, size);
-	if (rc)
-		goto fail;
-	fw_buf->data = buf;
-	fw_buf->size = size;
-	return 0;
-fail:
-	vfree(buf);
-	return rc;
-}
-
 static int fw_get_filesystem_firmware(struct device *device,
 				       struct firmware_buf *buf)
 {
+	loff_t size;
 	int i, len;
 	int rc = -ENOENT;
 	char *path;
@@ -350,13 +321,18 @@ static int fw_get_filesystem_firmware(struct device *device,
 		file = filp_open(path, O_RDONLY, 0);
 		if (IS_ERR(file))
 			continue;
-		rc = fw_read_file_contents(file, buf);
+
+		buf->size = 0;
+		rc = kernel_read_file(file, &buf->data, &size, INT_MAX,
+				      FIRMWARE_CHECK);
 		fput(file);
 		if (rc)
 			dev_warn(device, "firmware, attempted to load %s, but failed with error %d\n",
 				path, rc);
-		else
+		else {
+			buf->size = (size_t) size;
 			break;
+		}
 	}
 	__putname(path);
 
@@ -685,8 +661,10 @@ static ssize_t firmware_loading_store(struct device *dev,
 				dev_err(dev, "%s: map pages failed\n",
 					__func__);
 			else
-				rc = security_kernel_fw_from_file(NULL,
-						fw_buf->data, fw_buf->size);
+				rc = security_kernel_post_read_file(NULL,
+							       fw_buf->data,
+							       fw_buf->size,
+							       FIRMWARE_CHECK);
 
 			/*
 			 * Same logic as fw_load_abort, only the DONE bit
diff --git a/include/linux/ima.h b/include/linux/ima.h
index ae91938..0a7f039 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -16,6 +16,7 @@ struct linux_binprm;
 enum ima_policy_id {
 	KEXEC_CHECK = 1,
 	INITRAMFS_CHECK,
+	FIRMWARE_CHECK,
 	IMA_MAX_READ_CHECK
 };
 
@@ -25,7 +26,6 @@ extern int ima_file_check(struct file *file, int mask, int opened);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_module_check(struct file *file);
-extern int ima_fw_from_file(struct file *file, char *buf, size_t size);
 extern int ima_hash_and_process_file(struct file *file,
 				     void *buf, loff_t size,
 				     enum ima_policy_id policy_id);
@@ -56,11 +56,6 @@ static inline int ima_module_check(struct file *file)
 	return 0;
 }
 
-static inline int ima_fw_from_file(struct file *file, char *buf, size_t size)
-{
-	return 0;
-}
-
 static inline int ima_hash_and_process_file(struct file *file,
 					    void *buf, loff_t size,
 					    enum ima_policy_id policy_id)
diff --git a/include/linux/security.h b/include/linux/security.h
index 44d8832..51f3bc6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -28,6 +28,7 @@
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/mm.h>
+#include <linux/ima.h>
 
 struct linux_binprm;
 struct cred;
@@ -298,7 +299,6 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
-int security_kernel_fw_from_file(struct file *file, char *buf, size_t size);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_module_from_file(struct file *file);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
@@ -852,12 +852,6 @@ static inline int security_kernel_create_files_as(struct cred *cred,
 	return 0;
 }
 
-static inline int security_kernel_fw_from_file(struct file *file,
-					       char *buf, size_t size)
-{
-	return 0;
-}
-
 static inline int security_kernel_module_request(char *kmod_name)
 {
 	return 0;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b98dbd5..520c7b4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -165,7 +165,6 @@ enum ima_hooks {
 	MMAP_CHECK,
 	BPRM_CHECK,
 	MODULE_CHECK,
-	FIRMWARE_CHECK,
 	POST_SETATTR
 };
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3adf937..57b1ad1 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -76,8 +76,6 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 		return iint->ima_bprm_status;
 	case MODULE_CHECK:
 		return iint->ima_module_status;
-	case FIRMWARE_CHECK:
-		return iint->ima_firmware_status;
 	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
 		return iint->ima_read_status;
 	case FILE_CHECK:
@@ -99,9 +97,6 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
 	case MODULE_CHECK:
 		iint->ima_module_status = status;
 		break;
-	case FIRMWARE_CHECK:
-		iint->ima_firmware_status = status;
-		break;
 	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
 		iint->ima_read_status = status;
 		break;
@@ -124,9 +119,6 @@ static void ima_cache_flags(struct integrity_iint_cache *iint, int func)
 	case MODULE_CHECK:
 		iint->flags |= (IMA_MODULE_APPRAISED | IMA_APPRAISED);
 		break;
-	case FIRMWARE_CHECK:
-		iint->flags |= (IMA_FIRMWARE_APPRAISED | IMA_APPRAISED);
-		break;
 	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
 		break;
 	case FILE_CHECK:
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 668cbc6..1251882 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -337,17 +337,6 @@ int ima_module_check(struct file *file)
 	return process_measurement(file, NULL, 0, MAY_EXEC, MODULE_CHECK, 0);
 }
 
-int ima_fw_from_file(struct file *file, char *buf, size_t size)
-{
-	if (!file) {
-		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE))
-			return -EACCES;	/* INTEGRITY_UNKNOWN */
-		return 0;
-	}
-	return process_measurement(file, NULL, 0, MAY_EXEC, FIRMWARE_CHECK, 0);
-}
-
 /**
  * ima_hash_and_process_file - in memory collect/appraise/audit measurement
  * @file: pointer to the file to be measured/appraised/audit
@@ -361,6 +350,13 @@ int ima_fw_from_file(struct file *file, char *buf, size_t size)
 int ima_hash_and_process_file(struct file *file, void *buf, loff_t size,
 			      enum ima_policy_id policy_id)
 {
+	if (!file && policy_id == FIRMWARE_CHECK) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE))
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		return 0;
+	}
+
 	if (!file || !buf || size == 0) { /* should never happen */
 		if (ima_appraise & IMA_APPRAISE_ENFORCE)
 			return -EACCES;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 4711083..dbd7aa1 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -102,7 +102,8 @@ static struct ima_rule_entry original_measurement_rules[] = {
 	{.action = MEASURE, .hooks.func = FILE_CHECK, .mask = MAY_READ,
 	 .uid = GLOBAL_ROOT_UID, .flags = IMA_FUNC | IMA_MASK | IMA_UID},
 	{.action = MEASURE, .hooks.func = MODULE_CHECK, .flags = IMA_FUNC},
-	{.action = MEASURE, .hooks.func = FIRMWARE_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .hooks.policy_id = FIRMWARE_CHECK,
+	 .flags = IMA_FUNC},
 };
 
 static struct ima_rule_entry default_measurement_rules[] = {
@@ -115,7 +116,8 @@ static struct ima_rule_entry default_measurement_rules[] = {
 	{.action = MEASURE, .hooks.func = FILE_CHECK, .mask = MAY_READ,
 	 .uid = GLOBAL_ROOT_UID, .flags = IMA_FUNC | IMA_INMASK | IMA_UID},
 	{.action = MEASURE, .hooks.func = MODULE_CHECK, .flags = IMA_FUNC},
-	{.action = MEASURE, .hooks.func = FIRMWARE_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .hooks.policy_id = FIRMWARE_CHECK,
+	 .flags = IMA_FUNC},
 };
 
 static struct ima_rule_entry default_appraise_rules[] = {
@@ -304,8 +306,6 @@ static int get_subaction(struct ima_rule_entry *rule, int func)
 		return IMA_BPRM_APPRAISE;
 	case MODULE_CHECK:
 		return IMA_MODULE_APPRAISE;
-	case FIRMWARE_CHECK:
-		return IMA_FIRMWARE_APPRAISE;
 	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
 		return IMA_READ_APPRAISE;
 	case FILE_CHECK:
@@ -609,8 +609,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->hooks.func = FILE_CHECK;
 			else if (strcmp(args[0].from, "MODULE_CHECK") == 0)
 				entry->hooks.func = MODULE_CHECK;
-			else if (strcmp(args[0].from, "FIRMWARE_CHECK") == 0)
-				entry->hooks.func = FIRMWARE_CHECK;
 			else if ((strcmp(args[0].from, "FILE_MMAP") == 0)
 				|| (strcmp(args[0].from, "MMAP_CHECK") == 0))
 				entry->hooks.func = MMAP_CHECK;
@@ -620,6 +618,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->hooks.policy_id = KEXEC_CHECK;
 			else if (strcmp(args[0].from, "INITRAMFS_CHECK") == 0)
 				entry->hooks.policy_id = INITRAMFS_CHECK;
+			else if (strcmp(args[0].from, "FIRMWARE_CHECK") == 0)
+				entry->hooks.policy_id = FIRMWARE_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
@@ -776,7 +776,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		result = -EINVAL;
 	else if (entry->hooks.func == MODULE_CHECK)
 		temp_ima_appraise |= IMA_APPRAISE_MODULES;
-	else if (entry->hooks.func == FIRMWARE_CHECK)
+	else if (entry->hooks.policy_id == FIRMWARE_CHECK)
 		temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
 	audit_log_format(ab, "res=%d", !result);
 	audit_log_end(ab);
@@ -863,8 +863,8 @@ static char *mask_tokens[] = {
 
 enum {
 	func_file = 0, func_mmap, func_bprm,
-	func_module, func_firmware, func_post,
-	func_kexec, func_initramfs
+	func_module, func_post,
+	func_kexec, func_initramfs, func_firmware
 };
 
 static char *func_tokens[] = {
@@ -872,10 +872,10 @@ static char *func_tokens[] = {
 	"MMAP_CHECK",
 	"BPRM_CHECK",
 	"MODULE_CHECK",
-	"FIRMWARE_CHECK",
 	"POST_SETATTR",
 	"KEXEC_CHECK",
 	"INITRAMFS_CHECK",
+	"FIRMWARE_CHECK"
 };
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
@@ -949,9 +949,6 @@ int ima_policy_show(struct seq_file *m, void *v)
 		case MODULE_CHECK:
 			seq_printf(m, pt(Opt_func), ft(func_module));
 			break;
-		case FIRMWARE_CHECK:
-			seq_printf(m, pt(Opt_func), ft(func_firmware));
-			break;
 		case POST_SETATTR:
 			seq_printf(m, pt(Opt_func), ft(func_post));
 			break;
@@ -963,6 +960,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 			case INITRAMFS_CHECK:
 				seq_printf(m, pt(Opt_func), ft(func_initramfs));
 				break;
+			case FIRMWARE_CHECK:
+				seq_printf(m, pt(Opt_func), ft(func_firmware));
+				break;
 			default:
 				snprintf(tbuf, sizeof(tbuf), "%d",
 					 entry->hooks.func);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 9a0ea4c..75334cd 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -47,16 +47,14 @@
 #define IMA_BPRM_APPRAISED	0x00002000
 #define IMA_MODULE_APPRAISE	0x00004000
 #define IMA_MODULE_APPRAISED	0x00008000
-#define IMA_FIRMWARE_APPRAISE	0x00010000
-#define IMA_FIRMWARE_APPRAISED	0x00020000
-#define IMA_READ_APPRAISE	0x00040000
-#define IMA_READ_APPRAISED	0x00080000
+#define IMA_READ_APPRAISE	0x00010000
+#define IMA_READ_APPRAISED	0x00020000
 #define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
 				 IMA_BPRM_APPRAISE | IMA_MODULE_APPRAISE | \
-				 IMA_FIRMWARE_APPRAISE | IMA_READ_APPRAISE)
+				 IMA_READ_APPRAISE)
 #define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED | \
 				 IMA_BPRM_APPRAISED | IMA_MODULE_APPRAISED | \
-				 IMA_FIRMWARE_APPRAISED | IMA_READ_APPRAISED)
+				 IMA_READ_APPRAISED)
 
 enum evm_ima_xattr_type {
 	IMA_XATTR_DIGEST = 0x01,
@@ -112,7 +110,6 @@ struct integrity_iint_cache {
 	enum integrity_status ima_mmap_status:4;
 	enum integrity_status ima_bprm_status:4;
 	enum integrity_status ima_module_status:4;
-	enum integrity_status ima_firmware_status:4;
 	enum integrity_status ima_read_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
diff --git a/security/security.c b/security/security.c
index 49cacae..a391ce4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -884,17 +884,6 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode)
 	return call_int_hook(kernel_create_files_as, 0, new, inode);
 }
 
-int security_kernel_fw_from_file(struct file *file, char *buf, size_t size)
-{
-	int ret;
-
-	ret = call_int_hook(kernel_fw_from_file, 0, file, buf, size);
-	if (ret)
-		return ret;
-	return ima_fw_from_file(file, buf, size);
-}
-EXPORT_SYMBOL_GPL(security_kernel_fw_from_file);
-
 int security_kernel_module_request(char *kmod_name)
 {
 	return call_int_hook(kernel_module_request, 0, kmod_name);
@@ -913,8 +902,21 @@ int security_kernel_module_from_file(struct file *file)
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   int policy_id)
 {
-	return = call_int_hook(kernel_post_read_file, 0, file, buf, size,
-			       policy_id);
+	int ret = 0;
+
+	switch (policy_id) {
+	case FIRMWARE_CHECK:
+		ret = call_int_hook(kernel_fw_from_file, 0, file, buf, size);
+		break;
+	default:
+		ret = call_int_hook(kernel_post_read_file, 0, file, buf, size,
+				    policy_id);
+		break;
+	}
+	if (ret)
+		return ret;
+
+	return ima_hash_and_process_file(file, buf, size, policy_id);
 }
 EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
 
-- 
2.1.0

