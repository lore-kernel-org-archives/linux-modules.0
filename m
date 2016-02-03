Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:58801 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966114AbcBCTII (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 3 Feb 2016 14:08:08 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 4 Feb 2016 05:08:05 +1000
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
Subject: [PATCH v3 08/22] vfs: define kernel_read_file_id enumeration
Date: Wed,  3 Feb 2016 14:06:16 -0500
Message-Id: <1454526390-19792-9-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

To differentiate between the kernel_read_file() callers, this patch
defines a new enumeration named kernel_read_file_id and includes the
caller identifier as an argument.

Subsequent patches define READING_KEXEC_IMAGE, READING_KEXEC_INITRAMFS,
READING_FIRMWARE, READING_MODULE, and READING_POLICY.

Changelog v3:
- Replace the IMA specific enumeration with a generic one.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/exec.c                 | 4 ++--
 include/linux/fs.h        | 7 ++++++-
 include/linux/lsm_hooks.h | 4 +++-
 include/linux/security.h  | 7 +++++--
 security/security.c       | 5 +++--
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 742de7a..cd2b5b2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -833,7 +833,7 @@ int kernel_read(struct file *file, loff_t offset,
 EXPORT_SYMBOL(kernel_read);
 
 int kernel_read_file(struct file *file, void **buf, loff_t *size,
-		     loff_t max_size)
+		     loff_t max_size, enum kernel_read_file_id id)
 {
 	loff_t i_size, pos;
 	ssize_t bytes = 0;
@@ -871,7 +871,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		goto out;
 	}
 
-	ret = security_kernel_post_read_file(file, *buf, i_size);
+	ret = security_kernel_post_read_file(file, *buf, i_size, id);
 	if (!ret)
 		*size = pos;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 93ca379..1458ca5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2526,8 +2526,13 @@ static inline void i_readcount_inc(struct inode *inode)
 #endif
 extern int do_pipe_flags(int *, int);
 
+enum kernel_read_file_id {
+	READING_MAX_ID
+};
+
 extern int kernel_read(struct file *, loff_t, char *, unsigned long);
-extern int kernel_read_file(struct file *, void **, loff_t *, loff_t);
+extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
+			    enum kernel_read_file_id);
 extern ssize_t kernel_write(struct file *, const char *, size_t, loff_t);
 extern ssize_t __kernel_write(struct file *, const char *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f82631c..2337f33 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -567,6 +567,7 @@
  *	by the kernel.
  *	@buf pointer to buffer containing the file contents.
  *	@size length of the file contents.
+ *	@id kernel read file identifier
  *	Return 0 if permission is granted.
  * @task_fix_setuid:
  *	Update the module's state after setting one or more of the user
@@ -1464,7 +1465,8 @@ union security_list_options {
 	int (*kernel_fw_from_file)(struct file *file, char *buf, size_t size);
 	int (*kernel_module_request)(char *kmod_name);
 	int (*kernel_module_from_file)(struct file *file);
-	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size);
+	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
+				     enum kernel_read_file_id id);
 	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
 				int flags);
 	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
diff --git a/include/linux/security.h b/include/linux/security.h
index f30f564..b68ce94 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -28,6 +28,7 @@
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/mm.h>
+#include <linux/fs.h>
 
 struct linux_binprm;
 struct cred;
@@ -301,7 +302,8 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_fw_from_file(struct file *file, char *buf, size_t size);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_module_from_file(struct file *file);
-int security_kernel_post_read_file(struct file *file, char *buf, loff_t size);
+int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
+				   enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
@@ -868,7 +870,8 @@ static inline int security_kernel_module_from_file(struct file *file)
 }
 
 static inline int security_kernel_post_read_file(struct file *file,
-						 char *buf, loff_t size)
+						 char *buf, loff_t size,
+						 enum kernel_read_file_id id)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index ae50730..796a261 100644
--- a/security/security.c
+++ b/security/security.c
@@ -910,9 +910,10 @@ int security_kernel_module_from_file(struct file *file)
 	return ima_module_check(file);
 }
 
-int security_kernel_post_read_file(struct file *file, char *buf, loff_t size)
+int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
+				   enum kernel_read_file_id id)
 {
-	return call_int_hook(kernel_post_read_file, 0, file, buf, size);
+	return call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
 }
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
-- 
2.1.0

