Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:48163 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610AbcAHTXf (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 8 Jan 2016 14:23:35 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 9 Jan 2016 05:23:33 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC PATCH 4/5] ima: replace call to integrity_read_file() with kernel version
Date: Fri,  8 Jan 2016 14:22:03 -0500
Message-Id: <1452280924-28774-5-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This patch defines kernel_read_file_from_path(), a wrapper for the VFS
common kernel_read_file(), and replaces the integrity_read_file() with
a call to the kernel_read_file_from_path() wrapper.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/exec.c                       | 21 +++++++++++++++++++++
 include/linux/fs.h              |  1 +
 security/integrity/ima/ima_fs.c | 15 +++++++++------
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 4ad2fca..f79c845 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -902,6 +902,27 @@ out:
 	return ret;
 }
 
+int kernel_read_file_from_path(char *path, void **buf, loff_t *size,
+			       loff_t max_size, int policy_id)
+{
+	struct file *file;
+	int ret;
+
+	if (!path || !*path)
+		return -EINVAL;
+
+	file = filp_open(path, O_RDONLY, 0);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		pr_err("Unable to open file: %s (%d)", path, ret);
+		return ret;
+	}
+
+	ret = kernel_read_file(file, buf, size, max_size, policy_id);
+	fput(file);
+	return ret;
+}
+
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
 	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9642623..79b1172 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2529,6 +2529,7 @@ extern int do_pipe_flags(int *, int);
 extern int kernel_read(struct file *, loff_t, char *, unsigned long);
 extern int kernel_read_file(struct file *, void **, loff_t *, loff_t, int);
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t, int);
+extern int kernel_read_file_from_path(char *, void **, loff_t *, loff_t, int);
 extern ssize_t kernel_write(struct file *, const char *, size_t, loff_t);
 extern ssize_t __kernel_write(struct file *, const char *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 685fdca..80bc30b 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -22,6 +22,7 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
+#include <linux/vmalloc.h>
 
 #include "ima.h"
 
@@ -260,20 +261,22 @@ static const struct file_operations ima_ascii_measurements_ops = {
 
 static ssize_t ima_read_policy(char *path)
 {
-	char *data, *datap;
-	int rc, size, pathlen = strlen(path);
+	void *data;
+	char *datap;
+	loff_t size;
+	int rc, pathlen = strlen(path);
+
 	char *p;
 
 	/* remove \n */
 	datap = path;
 	strsep(&datap, "\n");
 
-	rc = integrity_read_file(path, &data, POLICY_CHECK);
+	rc = kernel_read_file_from_path(path, &data, &size, 0, POLICY_CHECK);
 	if (rc < 0)
 		return rc;
 
-	size = rc;
-	datap = data;
+	datap = (char *)data;
 	while (size > 0 && (p = strsep(&datap, "\n"))) {
 		pr_debug("rule: %s\n", p);
 		rc = ima_parse_add_rule(p);
@@ -282,7 +285,7 @@ static ssize_t ima_read_policy(char *path)
 		size -= rc;
 	}
 
-	kfree(data);
+	vfree(data);
 	if (rc < 0)
 		return rc;
 	else if (size)
-- 
2.1.0

