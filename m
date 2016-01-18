Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([125.16.236.1]:38108 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402AbcARP0m (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 18 Jan 2016 10:26:42 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Mon, 18 Jan 2016 20:47:24 +0530
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
Subject: [RFC PATCH v2 08/11] module: replace copy_module_from_fd with kernel version
Date: Mon, 18 Jan 2016 10:11:23 -0500
Message-Id: <1453129886-20192-9-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This patch replaces the module copy_module_from_fd() call with the VFS
common kernel_read_file_from_fd() function.  Instead of reading the
kernel module twice, once for measuring/appraising and then loading
the kernel module, the file is read once.

This patch defines a new security hook named security_kernel_read_file(),
which is called before reading the file.  For now, call the module
security hook from security_kernel_read_file until the LSMs have been
converted to use the kernel_read_file hook.

This patch retains the kernel_module_from_file hook, but removes the
security_kernel_module_from_file() function.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/exec.c                             |  4 +++
 include/linux/ima.h                   |  1 +
 include/linux/lsm_hooks.h             |  8 +++++
 include/linux/security.h              |  3 +-
 kernel/module.c                       | 67 ++++-------------------------------
 security/integrity/ima/ima.h          |  1 -
 security/integrity/ima/ima_appraise.c |  7 ----
 security/integrity/ima/ima_main.c     |  5 ++-
 security/integrity/ima/ima_policy.c   | 16 ++++-----
 security/integrity/integrity.h        | 12 +++----
 security/security.c                   | 12 +++++--
 11 files changed, 47 insertions(+), 89 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a5ae51e..3524e5f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -842,6 +842,10 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return -EINVAL;
 
+	ret = security_kernel_read_file(file, policy_id);
+	if (ret)
+		return ret;
+
 	i_size = i_size_read(file_inode(file));
 	if (max_size > 0 && i_size > max_size)
 		return -EFBIG;
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0a7f039..eec5e2b 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -17,6 +17,7 @@ enum ima_policy_id {
 	KEXEC_CHECK = 1,
 	INITRAMFS_CHECK,
 	FIRMWARE_CHECK,
+	MODULE_CHECK,
 	IMA_MAX_READ_CHECK
 };
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4e6e2af..9915310 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -561,6 +561,12 @@
  *	the kernel module to load. If the module is being loaded from a blob,
  *	this argument will be NULL.
  *	Return 0 if permission is granted.
+ * @kernel_read_file:
+ *      Read a file specified by userspace.
+ *	@file contains the file structure pointing to the file being read
+ *	by the kernel.
+ *	@policy_id contains IMA policy identifier.
+ *	Return 0 if permission is granted.
  * @kernel_post_read_file:
  *	Read a file specified by userspace.
  *	@file contains the file structure pointing to the file being read
@@ -1465,6 +1471,7 @@ union security_list_options {
 	int (*kernel_fw_from_file)(struct file *file, char *buf, size_t size);
 	int (*kernel_module_request)(char *kmod_name);
 	int (*kernel_module_from_file)(struct file *file);
+	int (*kernel_read_file)(struct file *file, int policy_id);
 	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
 				     int policy_id);
 	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
@@ -1726,6 +1733,7 @@ struct security_hook_heads {
 	struct list_head kernel_act_as;
 	struct list_head kernel_create_files_as;
 	struct list_head kernel_fw_from_file;
+	struct list_head kernel_read_file;
 	struct list_head kernel_post_read_file;
 	struct list_head kernel_module_request;
 	struct list_head kernel_module_from_file;
diff --git a/include/linux/security.h b/include/linux/security.h
index 51f3bc6..6d005b3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -301,6 +301,7 @@ int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_module_from_file(struct file *file);
+int security_kernel_read_file(struct file *file, int policy_id);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   int policy_id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
@@ -857,7 +858,7 @@ static inline int security_kernel_module_request(char *kmod_name)
 	return 0;
 }
 
-static inline int security_kernel_module_from_file(struct file *file)
+static inline int security_kernel_read_file(struct file *file, int policy_id)
 {
 	return 0;
 }
diff --git a/kernel/module.c b/kernel/module.c
index 8f051a1..7398d12 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2665,7 +2665,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_module_from_file(NULL);
+	err = security_kernel_read_file(NULL, MODULE_CHECK);
 	if (err)
 		return err;
 
@@ -2683,63 +2683,6 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
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
@@ -3602,8 +3545,10 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 
 SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 {
-	int err;
 	struct load_info info = { };
+	loff_t size;
+	void *hdr;
+	int err;
 
 	err = may_init_module();
 	if (err)
@@ -3615,9 +3560,11 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_IGNORE_VERMAGIC))
 		return -EINVAL;
 
-	err = copy_module_from_fd(fd, &info);
+	err = kernel_read_file_from_fd(fd, &hdr, &size, INT_MAX, MODULE_CHECK);
 	if (err)
 		return err;
+	info.hdr = hdr;
+	info.len = size;
 
 	return load_module(&info, uargs, flags);
 }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 520c7b4..fc31ba2 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -164,7 +164,6 @@ enum ima_hooks {
 	FILE_CHECK = IMA_MAX_READ_CHECK,
 	MMAP_CHECK,
 	BPRM_CHECK,
-	MODULE_CHECK,
 	POST_SETATTR
 };
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 57b1ad1..6b3e30a 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -74,8 +74,6 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 		return iint->ima_mmap_status;
 	case BPRM_CHECK:
 		return iint->ima_bprm_status;
-	case MODULE_CHECK:
-		return iint->ima_module_status;
 	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
 		return iint->ima_read_status;
 	case FILE_CHECK:
@@ -94,8 +92,6 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
 	case BPRM_CHECK:
 		iint->ima_bprm_status = status;
 		break;
-	case MODULE_CHECK:
-		iint->ima_module_status = status;
 		break;
 	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
 		iint->ima_read_status = status;
@@ -116,9 +112,6 @@ static void ima_cache_flags(struct integrity_iint_cache *iint, int func)
 	case BPRM_CHECK:
 		iint->flags |= (IMA_BPRM_APPRAISED | IMA_APPRAISED);
 		break;
-	case MODULE_CHECK:
-		iint->flags |= (IMA_MODULE_APPRAISED | IMA_APPRAISED);
-		break;
 	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
 		break;
 	case FILE_CHECK:
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1251882..107e6a7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -334,7 +334,7 @@ int ima_module_check(struct file *file)
 #endif
 		return 0;	/* We rely on module signature checking */
 	}
-	return process_measurement(file, NULL, 0, MAY_EXEC, MODULE_CHECK, 0);
+	return 0;
 }
 
 /**
@@ -357,6 +357,9 @@ int ima_hash_and_process_file(struct file *file, void *buf, loff_t size,
 		return 0;
 	}
 
+	if (!file && policy_id == MODULE_CHECK) /* MODULE_SIG_FORCE enabled */
+		return 0;
+
 	if (!file || !buf || size == 0) { /* should never happen */
 		if (ima_appraise & IMA_APPRAISE_ENFORCE)
 			return -EACCES;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index dbd7aa1..dbfd26b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -101,7 +101,7 @@ static struct ima_rule_entry original_measurement_rules[] = {
 	 .flags = IMA_FUNC | IMA_MASK},
 	{.action = MEASURE, .hooks.func = FILE_CHECK, .mask = MAY_READ,
 	 .uid = GLOBAL_ROOT_UID, .flags = IMA_FUNC | IMA_MASK | IMA_UID},
-	{.action = MEASURE, .hooks.func = MODULE_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .hooks.policy_id = MODULE_CHECK, .flags = IMA_FUNC},
 	{.action = MEASURE, .hooks.policy_id = FIRMWARE_CHECK,
 	 .flags = IMA_FUNC},
 };
@@ -304,8 +304,6 @@ static int get_subaction(struct ima_rule_entry *rule, int func)
 		return IMA_MMAP_APPRAISE;
 	case BPRM_CHECK:
 		return IMA_BPRM_APPRAISE;
-	case MODULE_CHECK:
-		return IMA_MODULE_APPRAISE;
 	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
 		return IMA_READ_APPRAISE;
 	case FILE_CHECK:
@@ -607,8 +605,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			/* PATH_CHECK is for backwards compat */
 			else if (strcmp(args[0].from, "PATH_CHECK") == 0)
 				entry->hooks.func = FILE_CHECK;
-			else if (strcmp(args[0].from, "MODULE_CHECK") == 0)
-				entry->hooks.func = MODULE_CHECK;
 			else if ((strcmp(args[0].from, "FILE_MMAP") == 0)
 				|| (strcmp(args[0].from, "MMAP_CHECK") == 0))
 				entry->hooks.func = MMAP_CHECK;
@@ -620,6 +616,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->hooks.policy_id = INITRAMFS_CHECK;
 			else if (strcmp(args[0].from, "FIRMWARE_CHECK") == 0)
 				entry->hooks.policy_id = FIRMWARE_CHECK;
+			else if (strcmp(args[0].from, "MODULE_CHECK") == 0)
+				entry->hooks.policy_id = MODULE_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
@@ -774,7 +772,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	}
 	if (!result && (entry->action == UNKNOWN))
 		result = -EINVAL;
-	else if (entry->hooks.func == MODULE_CHECK)
+	else if (entry->hooks.policy_id == MODULE_CHECK)
 		temp_ima_appraise |= IMA_APPRAISE_MODULES;
 	else if (entry->hooks.policy_id == FIRMWARE_CHECK)
 		temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
@@ -946,9 +944,6 @@ int ima_policy_show(struct seq_file *m, void *v)
 		case BPRM_CHECK:
 			seq_printf(m, pt(Opt_func), ft(func_bprm));
 			break;
-		case MODULE_CHECK:
-			seq_printf(m, pt(Opt_func), ft(func_module));
-			break;
 		case POST_SETATTR:
 			seq_printf(m, pt(Opt_func), ft(func_post));
 			break;
@@ -963,6 +958,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 			case FIRMWARE_CHECK:
 				seq_printf(m, pt(Opt_func), ft(func_firmware));
 				break;
+			case MODULE_CHECK:
+				seq_printf(m, pt(Opt_func), ft(func_module));
+				break;
 			default:
 				snprintf(tbuf, sizeof(tbuf), "%d",
 					 entry->hooks.func);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 75334cd..97fb5c2 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -45,16 +45,12 @@
 #define IMA_MMAP_APPRAISED	0x00000800
 #define IMA_BPRM_APPRAISE	0x00001000
 #define IMA_BPRM_APPRAISED	0x00002000
-#define IMA_MODULE_APPRAISE	0x00004000
-#define IMA_MODULE_APPRAISED	0x00008000
-#define IMA_READ_APPRAISE	0x00010000
-#define IMA_READ_APPRAISED	0x00020000
+#define IMA_READ_APPRAISE	0x00004000
+#define IMA_READ_APPRAISED	0x00008000
 #define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
-				 IMA_BPRM_APPRAISE | IMA_MODULE_APPRAISE | \
-				 IMA_READ_APPRAISE)
+				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE)
 #define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED | \
-				 IMA_BPRM_APPRAISED | IMA_MODULE_APPRAISED | \
-				 IMA_READ_APPRAISED)
+				 IMA_BPRM_APPRAISED | IMA_READ_APPRAISED)
 
 enum evm_ima_xattr_type {
 	IMA_XATTR_DIGEST = 0x01,
diff --git a/security/security.c b/security/security.c
index a391ce4..fa8a9e8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -889,11 +889,17 @@ int security_kernel_module_request(char *kmod_name)
 	return call_int_hook(kernel_module_request, 0, kmod_name);
 }
 
-int security_kernel_module_from_file(struct file *file)
+int security_kernel_read_file(struct file *file, int policy_id)
 {
 	int ret;
 
-	ret = call_int_hook(kernel_module_from_file, 0, file);
+	switch (policy_id) {
+	case MODULE_CHECK:
+		ret = call_int_hook(kernel_module_from_file, 0, file);
+		break;
+	default:
+		ret = call_int_hook(kernel_read_file, 0, file, policy_id);
+	}
 	if (ret)
 		return ret;
 	return ima_module_check(file);
@@ -1707,6 +1713,8 @@ struct security_hook_heads security_hook_heads = {
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

