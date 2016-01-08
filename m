Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:46455 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355AbcAHTXa (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 8 Jan 2016 14:23:30 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 9 Jan 2016 05:23:28 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC PATCH 2/5] firmware: replace call to fw_read_file_contents() with kernel version
Date: Fri,  8 Jan 2016 14:22:01 -0500
Message-Id: <1452280924-28774-3-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Replace fw_read_file_contents() for reading a file with the common VFS
kernel_read_file() function.  Call the existing firmware security hook
from security_kernel_post_read_file() until the LSMs have been converted.

This patch retains the kernel_fw_from_file() hook, but removes the
security_kernel_fw_from_file() function.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/base/firmware_class.c     | 51 +++++++++------------------------------
 include/linux/ima.h               |  6 -----
 include/linux/security.h          |  8 +-----
 security/integrity/ima/ima_main.c | 18 ++++++--------
 security/security.c               | 24 ++++++++----------
 5 files changed, 30 insertions(+), 77 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 3ca96a6..4e4e860 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -292,44 +292,10 @@ static const char * const fw_path[] = {
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
-	rc = ima_hash_and_process_file(file, buf, size, FIRMWARE_CHECK);
-	if (rc)
-		goto fail;
-
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
@@ -355,13 +321,18 @@ static int fw_get_filesystem_firmware(struct device *device,
 		file = filp_open(path, O_RDONLY, 0);
 		if (IS_ERR(file))
 			continue;
-		rc = fw_read_file_contents(file, buf);
+
+		buf->size = 0;
+		rc = kernel_read_file(file, &buf->data, &size, UINT_MAX,
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
 
@@ -690,8 +661,10 @@ static ssize_t firmware_loading_store(struct device *dev,
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
index 3790af0..7cad2e7 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -27,7 +27,6 @@ extern int ima_file_check(struct file *file, int mask, int opened);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_module_check(struct file *file);
-extern int ima_fw_from_file(struct file *file, char *buf, size_t size);
 extern int ima_hash_and_process_file(struct file *file,
 				     void *buf, loff_t size,
 				     enum ima_policy_id policy_id);
@@ -58,11 +57,6 @@ static inline int ima_module_check(struct file *file)
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
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index bfe1cc3..62d609d 100644
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
-	return 0;
-}
-
 /**
  * ima_hash_and_process_file - in memory collect/appraise/audit measurement
  * @file: pointer to the file to be measured/appraised/audit
@@ -362,6 +351,13 @@ int ima_fw_from_file(struct file *file, char *buf, size_t size)
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
diff --git a/security/security.c b/security/security.c
index e979c2d..a391ce4 100644
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
@@ -913,10 +902,17 @@ int security_kernel_module_from_file(struct file *file)
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   int policy_id)
 {
-	int ret;
+	int ret = 0;
 
-	ret = call_int_hook(kernel_post_read_file, 0, file, buf, size,
-			    policy_id);
+	switch (policy_id) {
+	case FIRMWARE_CHECK:
+		ret = call_int_hook(kernel_fw_from_file, 0, file, buf, size);
+		break;
+	default:
+		ret = call_int_hook(kernel_post_read_file, 0, file, buf, size,
+				    policy_id);
+		break;
+	}
 	if (ret)
 		return ret;
 
-- 
2.1.0

