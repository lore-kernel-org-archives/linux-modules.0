Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([125.16.236.3]:41317 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbcBLSbv (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 13:31:51 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 13 Feb 2016 00:01:48 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v4 12/19] vfs: define kernel_copy_file_from_fd()
Date: Fri, 12 Feb 2016 13:29:24 -0500
Message-Id: <1455301771-7703-13-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This patch defines kernel_read_file_from_fd(), a wrapper for the VFS
common kernel_read_file().

Changelog:
- Separated from the kernel modules patch
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/exec.c          | 16 ++++++++++++++++
 include/linux/fs.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 78dfdf3..604f669 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -910,6 +910,22 @@ int kernel_read_file_from_path(char *path, void **buf, loff_t *size,
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
+int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id)
+{
+	struct fd f = fdget(fd);
+	int ret = -EBADF;
+
+	if (!f.file)
+		goto out;
+
+	ret = kernel_read_file(f.file, buf, size, max_size, id);
+out:
+	fdput(f);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
+
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
 	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c8bc4d8..9c85dea 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2586,6 +2586,8 @@ extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
 			    enum kernel_read_file_id);
 extern int kernel_read_file_from_path(char *, void **, loff_t *, loff_t,
 				      enum kernel_read_file_id);
+extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
+				    enum kernel_read_file_id);
 extern ssize_t kernel_write(struct file *, const char *, size_t, loff_t);
 extern ssize_t __kernel_write(struct file *, const char *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
-- 
2.1.0

