Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:47216 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630AbcAHTXe (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 8 Jan 2016 14:23:34 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 9 Jan 2016 05:23:32 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC PATCH 3/5] kexec: replace call to copy_file_from_fd() with kernel version
Date: Fri,  8 Jan 2016 14:22:02 -0500
Message-Id: <1452280924-28774-4-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This patch defines kernel_read_file_from_fd(), a wrapper for the VFS
common kernel_read_file(), and replaces the kexec copy_file_from_fd()
calls with the kernel_read_file_from_fd() wrapper.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/exec.c           | 15 +++++++++++
 include/linux/fs.h  |  1 +
 kernel/kexec_file.c | 76 +++++------------------------------------------------
 3 files changed, 23 insertions(+), 69 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 3c48a19..4ad2fca 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -887,6 +887,21 @@ out:
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
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 81d20e8..f7c3ce4 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -34,69 +34,6 @@ size_t __weak kexec_purgatory_size = 0;
 
 static int kexec_calculate_store_digests(struct kimage *image);
 
-static int copy_file_from_fd(int fd, void **buf, unsigned long *buf_len,
-			     enum ima_policy_id policy_id)
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
-			ret = bytes;
-			goto out_free;
-		}
-
-		if (bytes == 0)
-			break;
-		pos += bytes;
-	}
-
-	if (pos != stat.size)
-		ret = -EBADF;
-
-	ret = ima_hash_and_process_file(f.file, *buf, stat.size, policy_id);
-	if (!ret)
-		*buf_len = pos;
-out_free:
-	if (ret < 0) {
-		vfree(*buf);
-		*buf = NULL;
-	}
-out:
-	fdput(f);
-	return ret;
-}
-
 /* Architectures can provide this probe function */
 int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 					 unsigned long buf_len)
@@ -185,16 +122,17 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 {
 	int ret = 0;
 	void *ldata;
+	loff_t size;
 
-	ret = copy_file_from_fd(kernel_fd, &image->kernel_buf,
-				&image->kernel_buf_len, KEXEC_CHECK);
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
 
@@ -209,11 +147,11 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 #endif
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
-		ret = copy_file_from_fd(initrd_fd, &image->initrd_buf,
-					&image->initrd_buf_len,
-					INITRAMFS_CHECK);
+		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
+					       &size, INT_MAX, INITRAMFS_CHECK);
 		if (ret)
 			goto out;
+		image->initrd_buf_len = size;
 	}
 
 	if (cmdline_len) {
-- 
2.1.0

