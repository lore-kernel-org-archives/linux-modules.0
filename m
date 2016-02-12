Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([125.16.236.8]:40547 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbcBLTKT (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 14:10:19 -0500
Received: from localhost
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 13 Feb 2016 00:40:16 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH v4 10/19] firmware: replace call to fw_read_file_contents() with kernel version
Date: Fri, 12 Feb 2016 13:29:22 -0500
Message-Id: <1455301771-7703-11-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Replace the fw_read_file_contents with kernel_file_read_from_path().

Although none of the upstreamed LSMs define a kernel_fw_from_file hook,
IMA is called by the security function to prevent unsigned firmware from
being loaded and to measure/appraise signed firmware, based on policy.

Instead of reading the firmware twice, once for measuring/appraising the
firmware and again for reading the firmware contents into memory, the
kernel_post_read_file() security hook calculates the file hash based on
the in memory file buffer.  The firmware is read once.

This patch removes the LSM kernel_fw_from_file() hook and security call.

Changelog v3:
- remove kernel_fw_from_file hook
- use kernel_file_read_from_path() - requested by Luis
v2:
- reordered and squashed firmware patches
- fix MAX firmware size (Kees Cook)

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_class.c     | 48 +++++++--------------------------------
 include/linux/fs.h                |  1 +
 include/linux/ima.h               |  6 -----
 include/linux/lsm_hooks.h         | 11 ---------
 include/linux/security.h          |  7 ------
 security/integrity/ima/ima_main.c | 21 ++++++++---------
 security/security.c               | 13 -----------
 7 files changed, 19 insertions(+), 88 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index c743a2f..dd588ea 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -23,6 +23,7 @@
 #include <linux/sched.h>
 #include <linux/file.h>
 #include <linux/list.h>
+#include <linux/fs.h>
 #include <linux/async.h>
 #include <linux/pm.h>
 #include <linux/suspend.h>
@@ -291,37 +292,6 @@ static const char * const fw_path[] = {
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
 static void fw_finish_direct_load(struct device *device,
 				  struct firmware_buf *buf)
 {
@@ -334,6 +304,7 @@ static void fw_finish_direct_load(struct device *device,
 static int fw_get_filesystem_firmware(struct device *device,
 				       struct firmware_buf *buf)
 {
+	loff_t size;
 	int i, len;
 	int rc = -ENOENT;
 	char *path;
@@ -343,8 +314,6 @@ static int fw_get_filesystem_firmware(struct device *device,
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(fw_path); i++) {
-		struct file *file;
-
 		/* skip the unset customized path */
 		if (!fw_path[i][0])
 			continue;
@@ -356,11 +325,9 @@ static int fw_get_filesystem_firmware(struct device *device,
 			break;
 		}
 
-		file = filp_open(path, O_RDONLY, 0);
-		if (IS_ERR(file))
-			continue;
-		rc = fw_read_file_contents(file, buf);
-		fput(file);
+		buf->size = 0;
+		rc = kernel_read_file_from_path(path, &buf->data, &size,
+						INT_MAX, READING_FIRMWARE);
 		if (rc) {
 			dev_warn(device, "loading %s failed with error %d\n",
 				 path, rc);
@@ -689,8 +656,9 @@ static ssize_t firmware_loading_store(struct device *dev,
 				dev_err(dev, "%s: map pages failed\n",
 					__func__);
 			else
-				rc = security_kernel_fw_from_file(NULL,
-						fw_buf->data, fw_buf->size);
+				rc = security_kernel_post_read_file(NULL,
+						fw_buf->data, fw_buf->size,
+						READING_FIRMWARE);
 
 			/*
 			 * Same logic as fw_load_abort, only the DONE bit
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 00fa5c4..c8bc4d8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2577,6 +2577,7 @@ static inline void i_readcount_inc(struct inode *inode)
 extern int do_pipe_flags(int *, int);
 
 enum kernel_read_file_id {
+	READING_FIRMWARE = 1,
 	READING_MAX_ID
 };
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index d29a6a2..7aea486 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -19,7 +19,6 @@ extern int ima_file_check(struct file *file, int mask, int opened);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_module_check(struct file *file);
-extern int ima_fw_from_file(struct file *file, char *buf, size_t size);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 
@@ -49,11 +48,6 @@ static inline int ima_module_check(struct file *file)
 	return 0;
 }
 
-static inline int ima_fw_from_file(struct file *file, char *buf, size_t size)
-{
-	return 0;
-}
-
 static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
 				     enum kernel_read_file_id id)
 {
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 2337f33..7d04a12 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -541,15 +541,6 @@
  *	@inode points to the inode to use as a reference.
  *	The current task must be the one that nominated @inode.
  *	Return 0 if successful.
- * @kernel_fw_from_file:
- *	Load firmware from userspace (not called for built-in firmware).
- *	@file contains the file structure pointing to the file containing
- *	the firmware to load. This argument will be NULL if the firmware
- *	was loaded via the uevent-triggered blob-based interface exposed
- *	by CONFIG_FW_LOADER_USER_HELPER.
- *	@buf pointer to buffer containing firmware contents.
- *	@size length of the firmware contents.
- *	Return 0 if permission is granted.
  * @kernel_module_request:
  *	Ability to trigger the kernel to automatically upcall to userspace for
  *	userspace to load a kernel module with the given name.
@@ -1462,7 +1453,6 @@ union security_list_options {
 	void (*cred_transfer)(struct cred *new, const struct cred *old);
 	int (*kernel_act_as)(struct cred *new, u32 secid);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
-	int (*kernel_fw_from_file)(struct file *file, char *buf, size_t size);
 	int (*kernel_module_request)(char *kmod_name);
 	int (*kernel_module_from_file)(struct file *file);
 	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
@@ -1725,7 +1715,6 @@ struct security_hook_heads {
 	struct list_head cred_transfer;
 	struct list_head kernel_act_as;
 	struct list_head kernel_create_files_as;
-	struct list_head kernel_fw_from_file;
 	struct list_head kernel_post_read_file;
 	struct list_head kernel_module_request;
 	struct list_head kernel_module_from_file;
diff --git a/include/linux/security.h b/include/linux/security.h
index d920718..cee1349 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -300,7 +300,6 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
-int security_kernel_fw_from_file(struct file *file, char *buf, size_t size);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_module_from_file(struct file *file);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
@@ -854,12 +853,6 @@ static inline int security_kernel_create_files_as(struct cred *cred,
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
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cfb508b..bf53a70 100644
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
  * ima_post_read_file - in memory collect/appraise/audit measurement
  * @file: pointer to the file to be measured/appraised/audit
@@ -366,12 +355,22 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 {
 	enum ima_hooks func = FILE_CHECK;
 
+	if (!file && read_id == READING_FIRMWARE) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE))
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		return 0;
+	}
+
 	if (!file && (!buf || size == 0)) { /* should never happen */
 		if (ima_appraise & IMA_APPRAISE_ENFORCE)
 			return -EACCES;
 		return 0;
 	}
 
+	if (read_id == READING_FIRMWARE)
+		func = FIRMWARE_CHECK;
+
 	return process_measurement(file, buf, size, MAY_READ, func, 0);
 }
 
diff --git a/security/security.c b/security/security.c
index ad87e8d..81a4c3a 100644
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
@@ -1702,8 +1691,6 @@ struct security_hook_heads security_hook_heads = {
 		LIST_HEAD_INIT(security_hook_heads.kernel_act_as),
 	.kernel_create_files_as =
 		LIST_HEAD_INIT(security_hook_heads.kernel_create_files_as),
-	.kernel_fw_from_file =
-		LIST_HEAD_INIT(security_hook_heads.kernel_fw_from_file),
 	.kernel_module_request =
 		LIST_HEAD_INIT(security_hook_heads.kernel_module_request),
 	.kernel_module_from_file =
-- 
2.1.0

