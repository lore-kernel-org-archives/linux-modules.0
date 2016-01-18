Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([125.16.236.7]:51889 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515AbcARPX7 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 18 Jan 2016 10:23:59 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Mon, 18 Jan 2016 20:44:22 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: Dmitry Kasatkin <d.kasatkin@samsung.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 09/11] ima: load policy using path
Date: Mon, 18 Jan 2016 10:11:24 -0500
Message-Id: <1453129886-20192-10-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Dmitry Kasatkin <d.kasatkin@samsung.com>

We currently cannot do appraisal or signature vetting of IMA policies
since we currently can only load IMA policies by writing the contents
of the policy directly in, as follows:

cat policy-file > <securityfs>/ima/policy

If we provide the kernel the path to the IMA policy so it can load
the policy itself it'd be able to later appraise or vet the file
signature if it has one.  This patch adds support to load the IMA
policy with a given path as follows:

echo /etc/ima/ima_policy > /sys/kernel/security/ima/policy

This patch defines kernel_read_file_from_path(), a wrapper for the VFS
common kernel_read_file(), and replaces the integrity_read_file() with
a call to the kernel_read_file_from_path() wrapper.

Changelog v3:
- after re-ordering the patches, replace calling integrity_kernel_read()
  to read the file with kernel_read_file_from_path() (Mimi)

Changelog v2:
- Patch description re-written by Luis R. Rodriguez

Signed-off-by: Dmitry Kasatkin <d.kasatkin@samsung.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/exec.c                       | 21 ++++++++++++++++++++
 include/linux/fs.h              |  1 +
 include/linux/ima.h             |  1 +
 security/integrity/ima/ima_fs.c | 43 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 3524e5f..5731b40 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -903,6 +903,27 @@ out:
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
diff --git a/include/linux/ima.h b/include/linux/ima.h
index eec5e2b..164d918 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -18,6 +18,7 @@ enum ima_policy_id {
 	INITRAMFS_CHECK,
 	FIRMWARE_CHECK,
 	MODULE_CHECK,
+	POLICY_CHECK,
 	IMA_MAX_READ_CHECK
 };
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index f355231..fe8b16b 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -22,6 +22,7 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
+#include <linux/vmalloc.h>
 
 #include "ima.h"
 
@@ -258,6 +259,41 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = seq_release,
 };
 
+static ssize_t ima_read_policy(char *path)
+{
+	void *data;
+	char *datap;
+	loff_t size;
+	int rc, pathlen = strlen(path);
+
+	char *p;
+
+	/* remove \n */
+	datap = path;
+	strsep(&datap, "\n");
+
+	rc = kernel_read_file_from_path(path, &data, &size, 0, POLICY_CHECK);
+	if (rc < 0)
+		return rc;
+
+	datap = data;
+	while (size > 0 && (p = strsep(&datap, "\n"))) {
+		pr_debug("rule: %s\n", p);
+		rc = ima_parse_add_rule(p);
+		if (rc < 0)
+			break;
+		size -= rc;
+	}
+
+	vfree(data);
+	if (rc < 0)
+		return rc;
+	else if (size)
+		return -EINVAL;
+	else
+		return pathlen;
+}
+
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				size_t datalen, loff_t *ppos)
 {
@@ -286,9 +322,12 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 	result = mutex_lock_interruptible(&ima_write_mutex);
 	if (result < 0)
 		goto out_free;
-	result = ima_parse_add_rule(data);
-	mutex_unlock(&ima_write_mutex);
 
+	if (data[0] == '/')
+		result = ima_read_policy(data);
+	else
+		result = ima_parse_add_rule(data);
+	mutex_unlock(&ima_write_mutex);
 out_free:
 	kfree(data);
 out:
-- 
2.1.0

