Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([125.16.236.6]:41545 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbcBLSbr (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 13:31:47 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 13 Feb 2016 00:01:44 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH v4 11/19] security: define kernel_read_file hook
Date: Fri, 12 Feb 2016 13:29:23 -0500
Message-Id: <1455301771-7703-12-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

The kernel_read_file security hook is called prior to reading the file
into memory.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/exec.c                         |  4 ++++
 include/linux/ima.h               |  6 ++++++
 include/linux/lsm_hooks.h         |  8 ++++++++
 include/linux/security.h          |  7 +++++++
 security/integrity/ima/ima_main.c | 16 ++++++++++++++++
 security/security.c               | 12 ++++++++++++
 6 files changed, 53 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 67816a0..78dfdf3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -842,6 +842,10 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
 		return -EINVAL;
 
+	ret = security_kernel_read_file(file, id);
+	if (ret)
+		return ret;
+
 	i_size = i_size_read(file_inode(file));
 	if (max_size > 0 && i_size > max_size)
 		return -EFBIG;
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 7aea486..6adcaea 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -19,6 +19,7 @@ extern int ima_file_check(struct file *file, int mask, int opened);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_module_check(struct file *file);
+extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 
@@ -48,6 +49,11 @@ static inline int ima_module_check(struct file *file)
 	return 0;
 }
 
+static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
+{
+	return 0;
+}
+
 static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
 				     enum kernel_read_file_id id)
 {
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7d04a12..d32b7bd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -552,6 +552,12 @@
  *	the kernel module to load. If the module is being loaded from a blob,
  *	this argument will be NULL.
  *	Return 0 if permission is granted.
+ * @kernel_read_file:
+ *	Read a file specified by userspace.
+ *	@file contains the file structure pointing to the file being read
+ *	by the kernel.
+ *	@id kernel read file identifier
+ *	Return 0 if permission is granted.
  * @kernel_post_read_file:
  *	Read a file specified by userspace.
  *	@file contains the file structure pointing to the file being read
@@ -1455,6 +1461,7 @@ union security_list_options {
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
 	int (*kernel_module_from_file)(struct file *file);
+	int (*kernel_read_file)(struct file *file, enum kernel_read_file_id id);
 	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
 				     enum kernel_read_file_id id);
 	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
@@ -1715,6 +1722,7 @@ struct security_hook_heads {
 	struct list_head cred_transfer;
 	struct list_head kernel_act_as;
 	struct list_head kernel_create_files_as;
+	struct list_head kernel_read_file;
 	struct list_head kernel_post_read_file;
 	struct list_head kernel_module_request;
 	struct list_head kernel_module_from_file;
diff --git a/include/linux/security.h b/include/linux/security.h
index cee1349..071fb74 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -302,6 +302,7 @@ int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_module_from_file(struct file *file);
+int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
@@ -863,6 +864,12 @@ static inline int security_kernel_module_from_file(struct file *file)
 	return 0;
 }
 
+static inline int security_kernel_read_file(struct file *file,
+					    enum kernel_read_file_id id)
+{
+	return 0;
+}
+
 static inline int security_kernel_post_read_file(struct file *file,
 						 char *buf, loff_t size,
 						 enum kernel_read_file_id id)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index bf53a70..80c24aa 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -338,6 +338,22 @@ int ima_module_check(struct file *file)
 }
 
 /**
+ * ima_read_file - pre-measure/appraise hook decision based on policy
+ * @file: pointer to the file to be measured/appraised/audit
+ * @read_id: caller identifier
+ *
+ * Permit reading a file based on policy. The policy rules are written
+ * in terms of the policy identifier.  Appraising the integrity of
+ * a file requires a file descriptor.
+ *
+ * For permission return 0, otherwise return -EACCES.
+ */
+int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
+{
+	return 0;
+}
+
+/**
  * ima_post_read_file - in memory collect/appraise/audit measurement
  * @file: pointer to the file to be measured/appraised/audit
  * @buf: pointer to in memory file contents
diff --git a/security/security.c b/security/security.c
index 81a4c3a..1728fe2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -899,6 +899,16 @@ int security_kernel_module_from_file(struct file *file)
 	return ima_module_check(file);
 }
 
+int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
+{
+	int ret;
+
+	ret = call_int_hook(kernel_read_file, 0, file, id);
+	if (ret)
+		return ret;
+	return ima_read_file(file, id);
+}
+
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id)
 {
@@ -1695,6 +1705,8 @@ struct security_hook_heads security_hook_heads = {
 		LIST_HEAD_INIT(security_hook_heads.kernel_module_request),
 	.kernel_module_from_file =
 		LIST_HEAD_INIT(security_hook_heads.kernel_module_from_file),
+	.kernel_read_file =
+		LIST_HEAD_INIT(security_hook_heads.kernel_read_file),
 	.kernel_post_read_file =
 		LIST_HEAD_INIT(security_hook_heads.kernel_post_read_file),
 	.task_fix_setuid =
-- 
2.1.0

