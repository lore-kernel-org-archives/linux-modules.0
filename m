Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([125.16.236.8]:46996 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbcBLSat (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 13:30:49 -0500
Received: from localhost
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 13 Feb 2016 00:00:46 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v4 04/19] vfs: define a generic function to read a file from the kernel
Date: Fri, 12 Feb 2016 13:29:16 -0500
Message-Id: <1455301771-7703-5-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

For a while it was looked down upon to directly read files from Linux.
These days there exists a few mechanisms in the kernel that do just
this though to load a file into a local buffer.  There are minor but
important checks differences on each.  This patch set is the first
attempt at resolving some of these differences.

This patch introduces a common function for reading files from the kernel
with the corresponding security post-read hook and function.

Changelog v3:
- additional bounds checking - Luis
v2:
- To simplify patch review, re-ordered patches

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Reviewed-by: Luis R. Rodriguez <mcgrof@suse.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/exec.c                 | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h        |  1 +
 include/linux/lsm_hooks.h |  9 ++++++++
 include/linux/security.h  |  7 +++++++
 security/security.c       |  7 +++++++
 5 files changed, 77 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index dcd4ac7..6b6668b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -56,6 +56,7 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/oom.h>
 #include <linux/compat.h>
+#include <linux/vmalloc.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -831,6 +832,58 @@ int kernel_read(struct file *file, loff_t offset,
 
 EXPORT_SYMBOL(kernel_read);
 
+int kernel_read_file(struct file *file, void **buf, loff_t *size,
+		     loff_t max_size)
+{
+	loff_t i_size, pos;
+	ssize_t bytes = 0;
+	int ret;
+
+	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
+		return -EINVAL;
+
+	i_size = i_size_read(file_inode(file));
+	if (max_size > 0 && i_size > max_size)
+		return -EFBIG;
+	if (i_size <= 0)
+		return -EINVAL;
+
+	*buf = vmalloc(i_size);
+	if (!*buf)
+		return -ENOMEM;
+
+	pos = 0;
+	while (pos < i_size) {
+		bytes = kernel_read(file, pos, (char *)(*buf) + pos,
+				    i_size - pos);
+		if (bytes < 0) {
+			ret = bytes;
+			goto out;
+		}
+
+		if (bytes == 0)
+			break;
+		pos += bytes;
+	}
+
+	if (pos != i_size) {
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = security_kernel_post_read_file(file, *buf, i_size);
+	if (!ret)
+		*size = pos;
+
+out:
+	if (ret < 0) {
+		vfree(*buf);
+		*buf = NULL;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file);
+
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
 	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ae68100..9a83d82 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2577,6 +2577,7 @@ static inline void i_readcount_inc(struct inode *inode)
 extern int do_pipe_flags(int *, int);
 
 extern int kernel_read(struct file *, loff_t, char *, unsigned long);
+extern int kernel_read_file(struct file *, void **, loff_t *, loff_t);
 extern ssize_t kernel_write(struct file *, const char *, size_t, loff_t);
 extern ssize_t __kernel_write(struct file *, const char *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 71969de..f82631c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -561,6 +561,13 @@
  *	the kernel module to load. If the module is being loaded from a blob,
  *	this argument will be NULL.
  *	Return 0 if permission is granted.
+ * @kernel_post_read_file:
+ *	Read a file specified by userspace.
+ *	@file contains the file structure pointing to the file being read
+ *	by the kernel.
+ *	@buf pointer to buffer containing the file contents.
+ *	@size length of the file contents.
+ *	Return 0 if permission is granted.
  * @task_fix_setuid:
  *	Update the module's state after setting one or more of the user
  *	identity attributes of the current process.  The @flags parameter
@@ -1457,6 +1464,7 @@ union security_list_options {
 	int (*kernel_fw_from_file)(struct file *file, char *buf, size_t size);
 	int (*kernel_module_request)(char *kmod_name);
 	int (*kernel_module_from_file)(struct file *file);
+	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size);
 	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
 				int flags);
 	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
@@ -1716,6 +1724,7 @@ struct security_hook_heads {
 	struct list_head kernel_act_as;
 	struct list_head kernel_create_files_as;
 	struct list_head kernel_fw_from_file;
+	struct list_head kernel_post_read_file;
 	struct list_head kernel_module_request;
 	struct list_head kernel_module_from_file;
 	struct list_head task_fix_setuid;
diff --git a/include/linux/security.h b/include/linux/security.h
index 4824a4c..f30f564 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -301,6 +301,7 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_fw_from_file(struct file *file, char *buf, size_t size);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_module_from_file(struct file *file);
+int security_kernel_post_read_file(struct file *file, char *buf, loff_t size);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
@@ -866,6 +867,12 @@ static inline int security_kernel_module_from_file(struct file *file)
 	return 0;
 }
 
+static inline int security_kernel_post_read_file(struct file *file,
+						 char *buf, loff_t size)
+{
+	return 0;
+}
+
 static inline int security_task_fix_setuid(struct cred *new,
 					   const struct cred *old,
 					   int flags)
diff --git a/security/security.c b/security/security.c
index e8ffd92..ae50730 100644
--- a/security/security.c
+++ b/security/security.c
@@ -910,6 +910,11 @@ int security_kernel_module_from_file(struct file *file)
 	return ima_module_check(file);
 }
 
+int security_kernel_post_read_file(struct file *file, char *buf, loff_t size)
+{
+	return call_int_hook(kernel_post_read_file, 0, file, buf, size);
+}
+
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
 {
@@ -1697,6 +1702,8 @@ struct security_hook_heads security_hook_heads = {
 		LIST_HEAD_INIT(security_hook_heads.kernel_module_request),
 	.kernel_module_from_file =
 		LIST_HEAD_INIT(security_hook_heads.kernel_module_from_file),
+	.kernel_post_read_file =
+		LIST_HEAD_INIT(security_hook_heads.kernel_post_read_file),
 	.task_fix_setuid =
 		LIST_HEAD_INIT(security_hook_heads.task_fix_setuid),
 	.task_setpgid =	LIST_HEAD_INIT(security_hook_heads.task_setpgid),
-- 
2.1.0

