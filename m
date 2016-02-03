Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:41857 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966073AbcBCTIX (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 3 Feb 2016 14:08:23 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 4 Feb 2016 05:08:21 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 11/22] ima: define a new hook to measure and appraise a file already in memory
Date: Wed,  3 Feb 2016 14:06:19 -0500
Message-Id: <1454526390-19792-12-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This patch defines a new IMA hook ima_post_read_file() for measuring
and appraising files read by the kernel. The caller loads the file into
memory before calling this function, which calculates the hash followed by
the normal IMA policy based processing.

Changelog v3:
- rename ima_hash_and_process_file() to ima_post_read_file()

v1:
- To simplify patch review, separate the IMA changes from the kexec
and initramfs changes in "ima: measure and appraise kexec image and
initramfs" patch.  This patch contains just the IMA changes.  The
kexec and initramfs changes are with the rest of the kexec changes
in "kexec: replace call to copy_file_from_fd() with kernel version".

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 include/linux/ima.h                   |  8 +++++++
 include/linux/security.h              |  1 +
 security/integrity/ima/ima.h          |  4 +++-
 security/integrity/ima/ima_api.c      |  6 +++--
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_main.c     | 45 ++++++++++++++++++++++++++++-------
 security/integrity/ima/ima_policy.c   |  1 +
 security/integrity/integrity.h        |  7 ++++--
 security/security.c                   |  7 +++++-
 9 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 120ccc5..d29a6a2 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -20,6 +20,8 @@ extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_module_check(struct file *file);
 extern int ima_fw_from_file(struct file *file, char *buf, size_t size);
+extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
+			      enum kernel_read_file_id id);
 
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
@@ -52,6 +54,12 @@ static inline int ima_fw_from_file(struct file *file, char *buf, size_t size)
 	return 0;
 }
 
+static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
+				     enum kernel_read_file_id id)
+{
+	return 0;
+}
+
 #endif /* CONFIG_IMA */
 
 #ifdef CONFIG_IMA_APPRAISE
diff --git a/include/linux/security.h b/include/linux/security.h
index b68ce94..d920718 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -24,6 +24,7 @@
 
 #include <linux/key.h>
 #include <linux/capability.h>
+#include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/string.h>
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 2c5262f..0b7134c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -19,6 +19,7 @@
 
 #include <linux/types.h>
 #include <linux/crypto.h>
+#include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/hash.h>
 #include <linux/tpm.h>
@@ -152,7 +153,8 @@ enum ima_hooks {
 int ima_get_action(struct inode *inode, int mask, enum ima_hooks func);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
-			    struct file *file, enum hash_algo algo);
+			    struct file *file, void *buf, loff_t size,
+			    enum hash_algo algo);
 void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 8750254..370e42d 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -188,7 +188,8 @@ int ima_get_action(struct inode *inode, int mask, enum ima_hooks func)
  * Return 0 on success, error code otherwise
  */
 int ima_collect_measurement(struct integrity_iint_cache *iint,
-			    struct file *file, enum hash_algo algo)
+			    struct file *file, void *buf, loff_t size,
+			    enum hash_algo algo)
 {
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
@@ -210,7 +211,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 
 		hash.hdr.algo = algo;
 
-		result = ima_calc_file_hash(file, &hash.hdr);
+		result = (!buf) ?  ima_calc_file_hash(file, &hash.hdr) :
+			ima_calc_buffer_hash(buf, size, &hash.hdr);
 		if (!result) {
 			int length = sizeof(hash.hdr) + hash.hdr.length;
 			void *tmpbuf = krealloc(iint->ima_hash, length,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 2888449..cb0d0ff 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -300,7 +300,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
 	if (iint->flags & IMA_DIGSIG)
 		return;
 
-	rc = ima_collect_measurement(iint, file, ima_hash_algo);
+	rc = ima_collect_measurement(iint, file, NULL, 0, ima_hash_algo);
 	if (rc < 0)
 		return;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 78a80c8..bead94b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -153,8 +153,8 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
-static int process_measurement(struct file *file, int mask,
-			       enum ima_hooks func, int opened)
+static int process_measurement(struct file *file, char *buf, loff_t size,
+			       int mask, enum ima_hooks func, int opened)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -226,7 +226,7 @@ static int process_measurement(struct file *file, int mask,
 
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
-	rc = ima_collect_measurement(iint, file, hash_algo);
+	rc = ima_collect_measurement(iint, file, buf, size, hash_algo);
 	if (rc != 0) {
 		if (file->f_flags & O_DIRECT)
 			rc = (iint->flags & IMA_PERMIT_DIRECTIO) ? 0 : -EACCES;
@@ -273,7 +273,8 @@ out:
 int ima_file_mmap(struct file *file, unsigned long prot)
 {
 	if (file && (prot & PROT_EXEC))
-		return process_measurement(file, MAY_EXEC, MMAP_CHECK, 0);
+		return process_measurement(file, NULL, 0, MAY_EXEC,
+					   MMAP_CHECK, 0);
 	return 0;
 }
 
@@ -292,7 +293,8 @@ int ima_file_mmap(struct file *file, unsigned long prot)
  */
 int ima_bprm_check(struct linux_binprm *bprm)
 {
-	return process_measurement(bprm->file, MAY_EXEC, BPRM_CHECK, 0);
+	return process_measurement(bprm->file, NULL, 0, MAY_EXEC,
+				   BPRM_CHECK, 0);
 }
 
 /**
@@ -307,7 +309,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
  */
 int ima_file_check(struct file *file, int mask, int opened)
 {
-	return process_measurement(file,
+	return process_measurement(file, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC),
 				   FILE_CHECK, opened);
 }
@@ -332,7 +334,7 @@ int ima_module_check(struct file *file)
 #endif
 		return 0;	/* We rely on module signature checking */
 	}
-	return process_measurement(file, MAY_EXEC, MODULE_CHECK, 0);
+	return process_measurement(file, NULL, 0, MAY_EXEC, MODULE_CHECK, 0);
 }
 
 int ima_fw_from_file(struct file *file, char *buf, size_t size)
@@ -343,7 +345,34 @@ int ima_fw_from_file(struct file *file, char *buf, size_t size)
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		return 0;
 	}
-	return process_measurement(file, MAY_EXEC, FIRMWARE_CHECK, 0);
+	return process_measurement(file, NULL, 0, MAY_EXEC, FIRMWARE_CHECK, 0);
+}
+
+/**
+ * ima_post_read_file - in memory collect/appraise/audit measurement
+ * @file: pointer to the file to be measured/appraised/audit
+ * @buf: pointer to in memory file contents
+ * @size: size of in memory file contents
+ * @read_id: caller identifier
+ *
+ * Measure/appraise/audit in memory file based on policy.  Policy rules
+ * are written in terms of a policy identifier.
+ *
+ * On success return 0.  On integrity appraisal error, assuming the file
+ * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
+ */
+int ima_post_read_file(struct file *file, void *buf, loff_t size,
+		       enum kernel_read_file_id read_id)
+{
+	enum ima_hooks func = FILE_CHECK;
+
+	if (!file && (!buf || size == 0)) { /* should never happen */
+		if (ima_appraise & IMA_APPRAISE_ENFORCE)
+			return -EACCES;
+		return 0;
+	}
+
+	return process_measurement(file, buf, size, MAY_READ, func, 0);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index b089ebe..cfbe86f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -12,6 +12,7 @@
  */
 #include <linux/module.h>
 #include <linux/list.h>
+#include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/magic.h>
 #include <linux/parser.h>
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 5efe2ec..9a0ea4c 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -49,12 +49,14 @@
 #define IMA_MODULE_APPRAISED	0x00008000
 #define IMA_FIRMWARE_APPRAISE	0x00010000
 #define IMA_FIRMWARE_APPRAISED	0x00020000
+#define IMA_READ_APPRAISE	0x00040000
+#define IMA_READ_APPRAISED	0x00080000
 #define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
 				 IMA_BPRM_APPRAISE | IMA_MODULE_APPRAISE | \
-				 IMA_FIRMWARE_APPRAISE)
+				 IMA_FIRMWARE_APPRAISE | IMA_READ_APPRAISE)
 #define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED | \
 				 IMA_BPRM_APPRAISED | IMA_MODULE_APPRAISED | \
-				 IMA_FIRMWARE_APPRAISED)
+				 IMA_FIRMWARE_APPRAISED | IMA_READ_APPRAISED)
 
 enum evm_ima_xattr_type {
 	IMA_XATTR_DIGEST = 0x01,
@@ -111,6 +113,7 @@ struct integrity_iint_cache {
 	enum integrity_status ima_bprm_status:4;
 	enum integrity_status ima_module_status:4;
 	enum integrity_status ima_firmware_status:4;
+	enum integrity_status ima_read_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
 };
diff --git a/security/security.c b/security/security.c
index 796a261..ad87e8d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -913,7 +913,12 @@ int security_kernel_module_from_file(struct file *file)
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id)
 {
-	return call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
+	int ret;
+
+	ret = call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
+	if (ret)
+		return ret;
+	return ima_post_read_file(file, buf, size, id);
 }
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
-- 
2.1.0

