Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([125.16.236.5]:48565 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbcBLSb6 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 13:31:58 -0500
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 13 Feb 2016 00:01:55 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH v4 13/19] module: replace copy_module_from_fd with kernel version
Date: Fri, 12 Feb 2016 13:29:25 -0500
Message-Id: <1455301771-7703-14-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Replace copy_module_from_fd() with kernel_read_file_from_fd().

Although none of the upstreamed LSMs define a kernel_module_from_file
hook, IMA is called, based on policy, to prevent unsigned kernel modules
from being loaded by the original kernel module syscall and to
measure/appraise signed kernel modules.

The security function security_kernel_module_from_file() was called prior
to reading a kernel module.  Preventing unsigned kernel modules from being
loaded by the original kernel module syscall remains on the pre-read
kernel_read_file() security hook.  Instead of reading the kernel module
twice, once for measuring/appraising and again for loading the kernel
module, the signature validation is moved to the kernel_post_read_file()
security hook.

This patch removes the security_kernel_module_from_file() hook and security
call.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
---
 include/linux/fs.h                |  1 +
 include/linux/ima.h               |  6 ----
 include/linux/lsm_hooks.h         |  7 ----
 include/linux/security.h          |  5 ---
 kernel/module.c                   | 68 +++++----------------------------------
 security/integrity/ima/ima_main.c | 35 ++++++++------------
 security/security.c               | 12 -------
 7 files changed, 22 insertions(+), 112 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9c85dea..fb08b66 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2578,6 +2578,7 @@ extern int do_pipe_flags(int *, int);
 
 enum kernel_read_file_id {
 	READING_FIRMWARE = 1,
+	READING_MODULE,
 	READING_MAX_ID
 };
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 6adcaea..e6516cb 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -18,7 +18,6 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask, int opened);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
-extern int ima_module_check(struct file *file);
 extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
@@ -44,11 +43,6 @@ static inline int ima_file_mmap(struct file *file, unsigned long prot)
 	return 0;
 }
 
-static inline int ima_module_check(struct file *file)
-{
-	return 0;
-}
-
 static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
 {
 	return 0;
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d32b7bd..cdee11c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -546,12 +546,6 @@
  *	userspace to load a kernel module with the given name.
  *	@kmod_name name of the module requested by the kernel
  *	Return 0 if successful.
- * @kernel_module_from_file:
- *	Load a kernel module from userspace.
- *	@file contains the file structure pointing to the file containing
- *	the kernel module to load. If the module is being loaded from a blob,
- *	this argument will be NULL.
- *	Return 0 if permission is granted.
  * @kernel_read_file:
  *	Read a file specified by userspace.
  *	@file contains the file structure pointing to the file being read
@@ -1725,7 +1719,6 @@ struct security_hook_heads {
 	struct list_head kernel_read_file;
 	struct list_head kernel_post_read_file;
 	struct list_head kernel_module_request;
-	struct list_head kernel_module_from_file;
 	struct list_head task_fix_setuid;
 	struct list_head task_setpgid;
 	struct list_head task_getpgid;
diff --git a/include/linux/security.h b/include/linux/security.h
index 071fb74..157f0cb 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -859,11 +859,6 @@ static inline int security_kernel_module_request(char *kmod_name)
 	return 0;
 }
 
-static inline int security_kernel_module_from_file(struct file *file)
-{
-	return 0;
-}
-
 static inline int security_kernel_read_file(struct file *file,
 					    enum kernel_read_file_id id)
 {
diff --git a/kernel/module.c b/kernel/module.c
index 8358f46..9554109 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2654,7 +2654,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_module_from_file(NULL);
+	err = security_kernel_read_file(NULL, READING_MODULE);
 	if (err)
 		return err;
 
@@ -2672,63 +2672,6 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	return 0;
 }
 
-/* Sets info->hdr and info->len. */
-static int copy_module_from_fd(int fd, struct load_info *info)
-{
-	struct fd f = fdget(fd);
-	int err;
-	struct kstat stat;
-	loff_t pos;
-	ssize_t bytes = 0;
-
-	if (!f.file)
-		return -ENOEXEC;
-
-	err = security_kernel_module_from_file(f.file);
-	if (err)
-		goto out;
-
-	err = vfs_getattr(&f.file->f_path, &stat);
-	if (err)
-		goto out;
-
-	if (stat.size > INT_MAX) {
-		err = -EFBIG;
-		goto out;
-	}
-
-	/* Don't hand 0 to vmalloc, it whines. */
-	if (stat.size == 0) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	info->hdr = vmalloc(stat.size);
-	if (!info->hdr) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	pos = 0;
-	while (pos < stat.size) {
-		bytes = kernel_read(f.file, pos, (char *)(info->hdr) + pos,
-				    stat.size - pos);
-		if (bytes < 0) {
-			vfree(info->hdr);
-			err = bytes;
-			goto out;
-		}
-		if (bytes == 0)
-			break;
-		pos += bytes;
-	}
-	info->len = pos;
-
-out:
-	fdput(f);
-	return err;
-}
-
 static void free_copy(struct load_info *info)
 {
 	vfree(info->hdr);
@@ -3589,8 +3532,10 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 
 SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 {
-	int err;
 	struct load_info info = { };
+	loff_t size;
+	void *hdr;
+	int err;
 
 	err = may_init_module();
 	if (err)
@@ -3602,9 +3547,12 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_IGNORE_VERMAGIC))
 		return -EINVAL;
 
-	err = copy_module_from_fd(fd, &info);
+	err = kernel_read_file_from_fd(fd, &hdr, &size, INT_MAX,
+				       READING_MODULE);
 	if (err)
 		return err;
+	info.hdr = hdr;
+	info.len = size;
 
 	return load_module(&info, uargs, flags);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 80c24aa..f6039f5 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -316,28 +316,6 @@ int ima_file_check(struct file *file, int mask, int opened)
 EXPORT_SYMBOL_GPL(ima_file_check);
 
 /**
- * ima_module_check - based on policy, collect/store/appraise measurement.
- * @file: pointer to the file to be measured/appraised
- *
- * Measure/appraise kernel modules based on policy.
- *
- * On success return 0.  On integrity appraisal error, assuming the file
- * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
- */
-int ima_module_check(struct file *file)
-{
-	if (!file) {
-#ifndef CONFIG_MODULE_SIG_FORCE
-		if ((ima_appraise & IMA_APPRAISE_MODULES) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE))
-			return -EACCES;	/* INTEGRITY_UNKNOWN */
-#endif
-		return 0;	/* We rely on module signature checking */
-	}
-	return process_measurement(file, NULL, 0, MAY_EXEC, MODULE_CHECK, 0);
-}
-
-/**
  * ima_read_file - pre-measure/appraise hook decision based on policy
  * @file: pointer to the file to be measured/appraised/audit
  * @read_id: caller identifier
@@ -350,6 +328,14 @@ int ima_module_check(struct file *file)
  */
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
+	if (!file && read_id == READING_MODULE) {
+#ifndef CONFIG_MODULE_SIG_FORCE
+		if ((ima_appraise & IMA_APPRAISE_MODULES) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE))
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+#endif
+		return 0;	/* We rely on module signature checking */
+	}
 	return 0;
 }
 
@@ -378,6 +364,9 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		return 0;
 	}
 
+	if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
+		return 0;
+
 	if (!file && (!buf || size == 0)) { /* should never happen */
 		if (ima_appraise & IMA_APPRAISE_ENFORCE)
 			return -EACCES;
@@ -386,6 +375,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	if (read_id == READING_FIRMWARE)
 		func = FIRMWARE_CHECK;
+	else if (read_id == READING_MODULE)
+		func = MODULE_CHECK;
 
 	return process_measurement(file, buf, size, MAY_READ, func, 0);
 }
diff --git a/security/security.c b/security/security.c
index 1728fe2..3573c82 100644
--- a/security/security.c
+++ b/security/security.c
@@ -889,16 +889,6 @@ int security_kernel_module_request(char *kmod_name)
 	return call_int_hook(kernel_module_request, 0, kmod_name);
 }
 
-int security_kernel_module_from_file(struct file *file)
-{
-	int ret;
-
-	ret = call_int_hook(kernel_module_from_file, 0, file);
-	if (ret)
-		return ret;
-	return ima_module_check(file);
-}
-
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
 {
 	int ret;
@@ -1703,8 +1693,6 @@ struct security_hook_heads security_hook_heads = {
 		LIST_HEAD_INIT(security_hook_heads.kernel_create_files_as),
 	.kernel_module_request =
 		LIST_HEAD_INIT(security_hook_heads.kernel_module_request),
-	.kernel_module_from_file =
-		LIST_HEAD_INIT(security_hook_heads.kernel_module_from_file),
 	.kernel_read_file =
 		LIST_HEAD_INIT(security_hook_heads.kernel_read_file),
 	.kernel_post_read_file =
-- 
2.1.0

