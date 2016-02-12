Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([125.16.236.9]:52794 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbcBLScG (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 13:32:06 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 13 Feb 2016 00:02:03 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v4 15/19] kexec: replace call to copy_file_from_fd() with kernel version
Date: Fri, 12 Feb 2016 13:29:27 -0500
Message-Id: <1455301771-7703-16-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Replace copy_file_from_fd() with kernel_read_file_from_fd().

Two new identifiers named READING_KEXEC_IMAGE and READING_KEXEC_INITRAMFS
are defined for measuring, appraising or auditing the kexec image and
initramfs.

Changelog v3:
- return -EBADF, not -ENOEXEC
- identifier change
- split patch, moving copy_file_from_fd() to a separate patch
- split patch, moving IMA changes to a separate patch
v0:
- use kstat file size type loff_t, not size_t
- Calculate the file hash from the in memory buffer - Dave Young

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Acked-by: Dave Young <dyoung@redhat.com>
---
 include/linux/fs.h  |  2 ++
 kernel/kexec_file.c | 73 +++++++----------------------------------------------
 2 files changed, 11 insertions(+), 64 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fb08b66..5256725 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2579,6 +2579,8 @@ extern int do_pipe_flags(int *, int);
 enum kernel_read_file_id {
 	READING_FIRMWARE = 1,
 	READING_MODULE,
+	READING_KEXEC_IMAGE,
+	READING_KEXEC_INITRAMFS,
 	READING_MAX_ID
 };
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 007b791..b696c3f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -18,6 +18,7 @@
 #include <linux/kexec.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/fs.h>
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
@@ -182,16 +124,17 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 {
 	int ret = 0;
 	void *ldata;
+	loff_t size;
 
-	ret = copy_file_from_fd(kernel_fd, &image->kernel_buf,
-				&image->kernel_buf_len);
+	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
+				       &size, INT_MAX, READING_KEXEC_IMAGE);
 	if (ret)
 		return ret;
+	image->kernel_buf_len = size;
 
 	/* Call arch image probe handlers */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
 					    image->kernel_buf_len);
-
 	if (ret)
 		goto out;
 
@@ -206,10 +149,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 #endif
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
-		ret = copy_file_from_fd(initrd_fd, &image->initrd_buf,
-					&image->initrd_buf_len);
+		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
+					       &size, INT_MAX,
+					       READING_KEXEC_INITRAMFS);
 		if (ret)
 			goto out;
+		image->initrd_buf_len = size;
 	}
 
 	if (cmdline_len) {
-- 
2.1.0

