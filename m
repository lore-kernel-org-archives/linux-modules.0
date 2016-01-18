Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([125.16.236.2]:38383 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbcARPXp (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 18 Jan 2016 10:23:45 -0500
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Mon, 18 Jan 2016 20:45:07 +0530
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
Subject: [RFC PATCH v2 06/11] kexec: replace call to copy_file_from_fd() with kernel version
Date: Mon, 18 Jan 2016 10:11:21 -0500
Message-Id: <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This patch defines kernel_read_file_from_fd(), a wrapper for the VFS
common kernel_read_file(), and replaces the kexec copy_file_from_fd()
calls with the kernel_read_file_from_fd() wrapper.

Two new IMA policy identifiers named KEXEC_CHECK and INITRAMFS_CHECK
are defined for measuring, appraising or auditing the kexec image
and initramfs.

Changelog v1:
- re-order and squash the kexec patches

v3: ima: measure and appraise kexec image and initramfs (squashed)
- rename ima_read_hooks enumeration to ima_policy_id
- use kstat file size type loff_t, not size_t
- add union name "hooks" to fix sparse warning

v2:
- Calculate the file hash from the in memory buffer
(suggested by Dave Young)
- Rename ima_read_and_process_file() to ima_hash_and_process_file()
- replace individual case statements with range:
        KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1
v1:
- Instead of ima_read_and_process_file() allocating memory, the caller
allocates and frees the memory.
- Moved the kexec measurement/appraisal call to copy_file_from_fd(). The
same call now measures and appraises both the kexec image and initramfs.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/ima_policy  |  2 +-
 fs/exec.c                             | 15 ++++++++
 include/linux/fs.h                    |  1 +
 include/linux/ima.h                   |  2 +
 kernel/kexec_file.c                   | 72 ++++-------------------------------
 security/integrity/ima/ima.h          |  9 ++++-
 security/integrity/ima/ima_appraise.c |  7 ++++
 security/integrity/ima/ima_policy.c   | 27 ++++++++++---
 8 files changed, 64 insertions(+), 71 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 0a378a8..e80f767 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -26,7 +26,7 @@ Description:
 			option:	[[appraise_type=]] [permit_directio]
 
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][FILE_CHECK][MODULE_CHECK]
-				[FIRMWARE_CHECK]
+				[FIRMWARE_CHECK] [KEXEC_CHECK] [INITRAMFS_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/fs/exec.c b/fs/exec.c
index 211b81c..a5ae51e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -884,6 +884,21 @@ out:
 }
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
+int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+			     int policy_id)
+{
+	struct fd f = fdget(fd);
+	int ret = -ENOEXEC;
+
+	if (!f.file)
+		goto out;
+
+	ret = kernel_read_file(f.file, buf, size, max_size, policy_id);
+out:
+	fdput(f);
+	return ret;
+}
+
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
 	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9b1468c..9642623 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2528,6 +2528,7 @@ extern int do_pipe_flags(int *, int);
 
 extern int kernel_read(struct file *, loff_t, char *, unsigned long);
 extern int kernel_read_file(struct file *, void **, loff_t *, loff_t, int);
+extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t, int);
 extern ssize_t kernel_write(struct file *, const char *, size_t, loff_t);
 extern ssize_t __kernel_write(struct file *, const char *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
diff --git a/include/linux/ima.h b/include/linux/ima.h
index ca76f60..ae91938 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -14,6 +14,8 @@
 struct linux_binprm;
 
 enum ima_policy_id {
+	KEXEC_CHECK = 1,
+	INITRAMFS_CHECK,
 	IMA_MAX_READ_CHECK
 };
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b70ada0..f7c3ce4 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -18,6 +18,7 @@
 #include <linux/kexec.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/ima.h>
 #include <crypto/hash.h>
 #include <crypto/sha.h>
 #include <linux/syscalls.h>
@@ -33,65 +34,6 @@ size_t __weak kexec_purgatory_size = 0;
 
 static int kexec_calculate_store_digests(struct kimage *image);
 
-static int copy_file_from_fd(int fd, void **buf, unsigned long *buf_len)
-{
-	struct fd f = fdget(fd);
-	int ret;
-	struct kstat stat;
-	loff_t pos;
-	ssize_t bytes = 0;
-
-	if (!f.file)
-		return -EBADF;
-
-	ret = vfs_getattr(&f.file->f_path, &stat);
-	if (ret)
-		goto out;
-
-	if (stat.size > INT_MAX) {
-		ret = -EFBIG;
-		goto out;
-	}
-
-	/* Don't hand 0 to vmalloc, it whines. */
-	if (stat.size == 0) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	*buf = vmalloc(stat.size);
-	if (!*buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	pos = 0;
-	while (pos < stat.size) {
-		bytes = kernel_read(f.file, pos, (char *)(*buf) + pos,
-				    stat.size - pos);
-		if (bytes < 0) {
-			vfree(*buf);
-			ret = bytes;
-			goto out;
-		}
-
-		if (bytes == 0)
-			break;
-		pos += bytes;
-	}
-
-	if (pos != stat.size) {
-		ret = -EBADF;
-		vfree(*buf);
-		goto out;
-	}
-
-	*buf_len = pos;
-out:
-	fdput(f);
-	return ret;
-}
-
 /* Architectures can provide this probe function */
 int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 					 unsigned long buf_len)
@@ -180,16 +122,17 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 {
 	int ret = 0;
 	void *ldata;
+	loff_t size;
 
-	ret = copy_file_from_fd(kernel_fd, &image->kernel_buf,
-				&image->kernel_buf_len);
+	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
+				       &size, INT_MAX, KEXEC_CHECK);
 	if (ret)
 		return ret;
+	image->kernel_buf_len = size;
 
 	/* Call arch image probe handlers */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
 					    image->kernel_buf_len);
-
 	if (ret)
 		goto out;
 
@@ -204,10 +147,11 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 #endif
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
-		ret = copy_file_from_fd(initrd_fd, &image->initrd_buf,
-					&image->initrd_buf_len);
+		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
+					       &size, INT_MAX, INITRAMFS_CHECK);
 		if (ret)
 			goto out;
+		image->initrd_buf_len = size;
 	}
 
 	if (cmdline_len) {
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 06bcc24..b98dbd5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -160,7 +160,14 @@ void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(struct path *path, char **pathbuf);
 
 /* IMA policy related functions */
-enum ima_hooks { FILE_CHECK = 1, MMAP_CHECK, BPRM_CHECK, MODULE_CHECK, FIRMWARE_CHECK, POST_SETATTR };
+enum ima_hooks {
+	FILE_CHECK = IMA_MAX_READ_CHECK,
+	MMAP_CHECK,
+	BPRM_CHECK,
+	MODULE_CHECK,
+	FIRMWARE_CHECK,
+	POST_SETATTR
+};
 
 int ima_match_policy(struct inode *inode, int func, int mask, int flags);
 void ima_init_policy(void);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 4edf47f..3adf937 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -78,6 +78,8 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 		return iint->ima_module_status;
 	case FIRMWARE_CHECK:
 		return iint->ima_firmware_status;
+	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
+		return iint->ima_read_status;
 	case FILE_CHECK:
 	default:
 		return iint->ima_file_status;
@@ -100,6 +102,9 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
 	case FIRMWARE_CHECK:
 		iint->ima_firmware_status = status;
 		break;
+	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
+		iint->ima_read_status = status;
+		break;
 	case FILE_CHECK:
 	default:
 		iint->ima_file_status = status;
@@ -122,6 +127,8 @@ static void ima_cache_flags(struct integrity_iint_cache *iint, int func)
 	case FIRMWARE_CHECK:
 		iint->flags |= (IMA_FIRMWARE_APPRAISED | IMA_APPRAISED);
 		break;
+	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
+		break;
 	case FILE_CHECK:
 	default:
 		iint->flags |= (IMA_FILE_APPRAISED | IMA_APPRAISED);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 595e038..4711083 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -306,6 +306,8 @@ static int get_subaction(struct ima_rule_entry *rule, int func)
 		return IMA_MODULE_APPRAISE;
 	case FIRMWARE_CHECK:
 		return IMA_FIRMWARE_APPRAISE;
+	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
+		return IMA_READ_APPRAISE;
 	case FILE_CHECK:
 	default:
 		return IMA_FILE_APPRAISE;
@@ -614,6 +616,10 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->hooks.func = MMAP_CHECK;
 			else if (strcmp(args[0].from, "BPRM_CHECK") == 0)
 				entry->hooks.func = BPRM_CHECK;
+			else if (strcmp(args[0].from, "KEXEC_CHECK") == 0)
+				entry->hooks.policy_id = KEXEC_CHECK;
+			else if (strcmp(args[0].from, "INITRAMFS_CHECK") == 0)
+				entry->hooks.policy_id = INITRAMFS_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
@@ -867,7 +873,9 @@ static char *func_tokens[] = {
 	"BPRM_CHECK",
 	"MODULE_CHECK",
 	"FIRMWARE_CHECK",
-	"POST_SETATTR"
+	"POST_SETATTR",
+	"KEXEC_CHECK",
+	"INITRAMFS_CHECK",
 };
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
@@ -948,10 +956,19 @@ int ima_policy_show(struct seq_file *m, void *v)
 			seq_printf(m, pt(Opt_func), ft(func_post));
 			break;
 		default:
-			snprintf(tbuf, sizeof(tbuf), "%d",
-				 entry->hooks.func);
-			seq_printf(m, pt(Opt_func), tbuf);
-			break;
+			switch (entry->hooks.policy_id) {
+			case KEXEC_CHECK:
+				seq_printf(m, pt(Opt_func), ft(func_kexec));
+				break;
+			case INITRAMFS_CHECK:
+				seq_printf(m, pt(Opt_func), ft(func_initramfs));
+				break;
+			default:
+				snprintf(tbuf, sizeof(tbuf), "%d",
+					 entry->hooks.func);
+				seq_printf(m, pt(Opt_func), tbuf);
+				break;
+			}
 		}
 		seq_puts(m, " ");
 	}
-- 
2.1.0

