Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([125.16.236.3]:39325 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755471AbcARPX1 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 18 Jan 2016 10:23:27 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Mon, 18 Jan 2016 20:43:50 +0530
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
Subject: [RFC PATCH v2 05/11] ima: define a new hook to measure and appraise a file already in memory
Date: Mon, 18 Jan 2016 10:11:20 -0500
Message-Id: <1453129886-20192-6-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This patch defines a new IMA hook ima_hash_and_process_file() for
measuring and appraising files read by the kernel. The caller loads
the file into memory before calling this function, which calculates
the hash followed by the normal IMA policy based processing.

To differentiate between callers of ima_hash_and_process_file() this
patch introducees a policy identifier enumation named ima_policy_id.

Changelog v1:
- To simplify patch review, separate the IMA changes from the kexec
and initramfs changes in "ima: measure and appraise kexec image and
initramfs" patch.  This patch contains just the IMA changes.  The
kexec and initramfs changes are with the rest of the kexec changes
in "kexec: replace call to copy_file_from_fd() with kernel version".

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/exec.c                             |  4 +--
 include/linux/fs.h                    |  2 +-
 include/linux/ima.h                   | 14 ++++++++
 include/linux/lsm_hooks.h             |  4 ++-
 include/linux/security.h              |  6 ++--
 security/integrity/iint.c             |  1 +
 security/integrity/ima/ima.h          | 12 +++----
 security/integrity/ima/ima_api.c      |  6 ++--
 security/integrity/ima/ima_appraise.c |  4 +--
 security/integrity/ima/ima_main.c     | 40 ++++++++++++++++++-----
 security/integrity/ima/ima_policy.c   | 60 +++++++++++++++++++----------------
 security/integrity/integrity.h        |  7 ++--
 security/security.c                   |  6 ++--
 13 files changed, 110 insertions(+), 56 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6d623c2..211b81c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -833,7 +833,7 @@ int kernel_read(struct file *file, loff_t offset,
 EXPORT_SYMBOL(kernel_read);
 
 int kernel_read_file(struct file *file, void **buf, loff_t *size,
-		     loff_t max_size)
+		     loff_t max_size, int policy_id)
 {
 	loff_t i_size, pos;
 	ssize_t bytes = 0;
@@ -871,7 +871,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		goto out;
 	}
 
-	ret = security_kernel_post_read_file(file, *buf, i_size);
+	ret = security_kernel_post_read_file(file, *buf, i_size, policy_id);
 	if (!ret)
 		*size = pos;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 93ca379..9b1468c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2527,7 +2527,7 @@ static inline void i_readcount_inc(struct inode *inode)
 extern int do_pipe_flags(int *, int);
 
 extern int kernel_read(struct file *, loff_t, char *, unsigned long);
-extern int kernel_read_file(struct file *, void **, loff_t *, loff_t);
+extern int kernel_read_file(struct file *, void **, loff_t *, loff_t, int);
 extern ssize_t kernel_write(struct file *, const char *, size_t, loff_t);
 extern ssize_t __kernel_write(struct file *, const char *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 120ccc5..ca76f60 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -13,6 +13,10 @@
 #include <linux/fs.h>
 struct linux_binprm;
 
+enum ima_policy_id {
+	IMA_MAX_READ_CHECK
+};
+
 #ifdef CONFIG_IMA
 extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask, int opened);
@@ -20,6 +24,9 @@ extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_module_check(struct file *file);
 extern int ima_fw_from_file(struct file *file, char *buf, size_t size);
+extern int ima_hash_and_process_file(struct file *file,
+				     void *buf, loff_t size,
+				     enum ima_policy_id policy_id);
 
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
@@ -52,6 +59,13 @@ static inline int ima_fw_from_file(struct file *file, char *buf, size_t size)
 	return 0;
 }
 
+static inline int ima_hash_and_process_file(struct file *file,
+					    void *buf, loff_t size,
+					    enum ima_policy_id policy_id)
+{
+	return 0;
+}
+
 #endif /* CONFIG_IMA */
 
 #ifdef CONFIG_IMA_APPRAISE
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f82631c..4e6e2af 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -567,6 +567,7 @@
  *	by the kernel.
  *	@buf pointer to buffer containing the file contents.
  *	@size length of the file contents.
+ *	@policy-id IMA policy identifier
  *	Return 0 if permission is granted.
  * @task_fix_setuid:
  *	Update the module's state after setting one or more of the user
@@ -1464,7 +1465,8 @@ union security_list_options {
 	int (*kernel_fw_from_file)(struct file *file, char *buf, size_t size);
 	int (*kernel_module_request)(char *kmod_name);
 	int (*kernel_module_from_file)(struct file *file);
-	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size);
+	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
+				     int policy_id);
 	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
 				int flags);
 	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
diff --git a/include/linux/security.h b/include/linux/security.h
index f30f564..44d8832 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -301,7 +301,8 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_fw_from_file(struct file *file, char *buf, size_t size);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_module_from_file(struct file *file);
-int security_kernel_post_read_file(struct file *file, char *buf, loff_t size);
+int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
+				   int policy_id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
@@ -868,7 +869,8 @@ static inline int security_kernel_module_from_file(struct file *file)
 }
 
 static inline int security_kernel_post_read_file(struct file *file,
-						 char *buf, loff_t size)
+						 char *buf, loff_t size,
+						 int policy_id)
 {
 	return 0;
 }
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8f1ab37..a41e073 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -158,6 +158,7 @@ static void init_once(void *foo)
 	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
 	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
 	iint->ima_module_status = INTEGRITY_UNKNOWN;
+	iint->ima_read_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 }
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index de53631..06bcc24 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -20,6 +20,7 @@
 #include <linux/types.h>
 #include <linux/crypto.h>
 #include <linux/security.h>
+#include <linux/ima.h>
 #include <linux/hash.h>
 #include <linux/tpm.h>
 #include <linux/audit.h>
@@ -143,7 +144,8 @@ static inline unsigned long ima_hash_key(u8 *digest)
 int ima_get_action(struct inode *inode, int mask, int function);
 int ima_must_measure(struct inode *inode, int mask, int function);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
-			    struct file *file, enum hash_algo algo);
+			    struct file *file, void *buf, loff_t size,
+			    enum hash_algo algo);
 void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
@@ -160,8 +162,7 @@ const char *ima_d_path(struct path *path, char **pathbuf);
 /* IMA policy related functions */
 enum ima_hooks { FILE_CHECK = 1, MMAP_CHECK, BPRM_CHECK, MODULE_CHECK, FIRMWARE_CHECK, POST_SETATTR };
 
-int ima_match_policy(struct inode *inode, enum ima_hooks func, int mask,
-		     int flags);
+int ima_match_policy(struct inode *inode, int func, int mask, int flags);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
@@ -185,7 +186,7 @@ int ima_appraise_measurement(int func, struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
 			     int xattr_len, int opened);
-int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func);
+int ima_must_appraise(struct inode *inode, int mask, int func);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 					   int func);
@@ -205,8 +206,7 @@ static inline int ima_appraise_measurement(int func,
 	return INTEGRITY_UNKNOWN;
 }
 
-static inline int ima_must_appraise(struct inode *inode, int mask,
-				    enum ima_hooks func)
+static inline int ima_must_appraise(struct inode *inode, int mask, int func)
 {
 	return 0;
 }
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index e7c7a5d..b702e4b 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -188,7 +188,8 @@ int ima_get_action(struct inode *inode, int mask, int function)
  * Return 0 on success, error code otherwise
  */
 int ima_collect_measurement(struct integrity_iint_cache *iint,
-			    struct file *file, enum hash_algo algo)
+			    struct file *file, void *buf, loff_t size,
+			    enum hash_algo algo)
 {
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
@@ -210,7 +211,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 
 		hash.hdr.algo = algo;
 
-		result = ima_calc_file_hash(file, &hash.hdr);
+		result = (!buf) ?  ima_calc_file_hash(file, &hash.hdr) :
+			ima_calc_buffer_hash(buf, size, &hash.hdr);
 		if (!result) {
 			int length = sizeof(hash.hdr) + hash.hdr.length;
 			void *tmpbuf = krealloc(iint->ima_hash, length,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 9c2b46b..4edf47f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -36,7 +36,7 @@ __setup("ima_appraise=", default_appraise_setup);
  *
  * Return 1 to appraise
  */
-int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
+int ima_must_appraise(struct inode *inode, int mask, int func)
 {
 	if (!ima_appraise)
 		return 0;
@@ -299,7 +299,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
 	if (iint->flags & IMA_DIGSIG)
 		return;
 
-	rc = ima_collect_measurement(iint, file, ima_hash_algo);
+	rc = ima_collect_measurement(iint, file, NULL, 0, ima_hash_algo);
 	if (rc < 0)
 		return;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d9fc463..668cbc6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -153,8 +153,8 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
-static int process_measurement(struct file *file, int mask, int function,
-			       int opened)
+static int process_measurement(struct file *file, char *buf, loff_t size,
+			       int mask, int function, int opened)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -226,7 +226,7 @@ static int process_measurement(struct file *file, int mask, int function,
 
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
-	rc = ima_collect_measurement(iint, file, hash_algo);
+	rc = ima_collect_measurement(iint, file, buf, size, hash_algo);
 	if (rc != 0) {
 		if (file->f_flags & O_DIRECT)
 			rc = (iint->flags & IMA_PERMIT_DIRECTIO) ? 0 : -EACCES;
@@ -273,7 +273,8 @@ out:
 int ima_file_mmap(struct file *file, unsigned long prot)
 {
 	if (file && (prot & PROT_EXEC))
-		return process_measurement(file, MAY_EXEC, MMAP_CHECK, 0);
+		return process_measurement(file, NULL, 0, MAY_EXEC,
+					   MMAP_CHECK, 0);
 	return 0;
 }
 
@@ -292,7 +293,8 @@ int ima_file_mmap(struct file *file, unsigned long prot)
  */
 int ima_bprm_check(struct linux_binprm *bprm)
 {
-	return process_measurement(bprm->file, MAY_EXEC, BPRM_CHECK, 0);
+	return process_measurement(bprm->file, NULL, 0, MAY_EXEC,
+				   BPRM_CHECK, 0);
 }
 
 /**
@@ -307,7 +309,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
  */
 int ima_file_check(struct file *file, int mask, int opened)
 {
-	return process_measurement(file,
+	return process_measurement(file, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC),
 				   FILE_CHECK, opened);
 }
@@ -332,7 +334,7 @@ int ima_module_check(struct file *file)
 #endif
 		return 0;	/* We rely on module signature checking */
 	}
-	return process_measurement(file, MAY_EXEC, MODULE_CHECK, 0);
+	return process_measurement(file, NULL, 0, MAY_EXEC, MODULE_CHECK, 0);
 }
 
 int ima_fw_from_file(struct file *file, char *buf, size_t size)
@@ -343,7 +345,29 @@ int ima_fw_from_file(struct file *file, char *buf, size_t size)
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		return 0;
 	}
-	return process_measurement(file, MAY_EXEC, FIRMWARE_CHECK, 0);
+	return process_measurement(file, NULL, 0, MAY_EXEC, FIRMWARE_CHECK, 0);
+}
+
+/**
+ * ima_hash_and_process_file - in memory collect/appraise/audit measurement
+ * @file: pointer to the file to be measured/appraised/audit
+ * @buf: pointer to in memory file contents
+ * @size: size of in memory file contents
+ * @policy_id: caller identifier
+ *
+ * Measure/appraise/audit in memory file based on policy.  Policy rules
+ * are written in terms of a policy identifier.
+ */
+int ima_hash_and_process_file(struct file *file, void *buf, loff_t size,
+			      enum ima_policy_id policy_id)
+{
+	if (!file || !buf || size == 0) { /* should never happen */
+		if (ima_appraise & IMA_APPRAISE_ENFORCE)
+			return -EACCES;
+		return 0;
+	}
+
+	return process_measurement(file, buf, size, MAY_READ, policy_id, 0);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 0a3b781..595e038 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -53,7 +53,10 @@ struct ima_rule_entry {
 	struct list_head list;
 	int action;
 	unsigned int flags;
-	enum ima_hooks func;
+	union {
+		enum ima_hooks func;
+		enum ima_policy_id policy_id;
+	} hooks;
 	int mask;
 	unsigned long fsmagic;
 	u8 fsuuid[16];
@@ -92,27 +95,27 @@ static struct ima_rule_entry dont_measure_rules[] = {
 };
 
 static struct ima_rule_entry original_measurement_rules[] = {
-	{.action = MEASURE, .func = MMAP_CHECK, .mask = MAY_EXEC,
+	{.action = MEASURE, .hooks.func = MMAP_CHECK, .mask = MAY_EXEC,
 	 .flags = IMA_FUNC | IMA_MASK},
-	{.action = MEASURE, .func = BPRM_CHECK, .mask = MAY_EXEC,
+	{.action = MEASURE, .hooks.func = BPRM_CHECK, .mask = MAY_EXEC,
 	 .flags = IMA_FUNC | IMA_MASK},
-	{.action = MEASURE, .func = FILE_CHECK, .mask = MAY_READ,
+	{.action = MEASURE, .hooks.func = FILE_CHECK, .mask = MAY_READ,
 	 .uid = GLOBAL_ROOT_UID, .flags = IMA_FUNC | IMA_MASK | IMA_UID},
-	{.action = MEASURE, .func = MODULE_CHECK, .flags = IMA_FUNC},
-	{.action = MEASURE, .func = FIRMWARE_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .hooks.func = MODULE_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .hooks.func = FIRMWARE_CHECK, .flags = IMA_FUNC},
 };
 
 static struct ima_rule_entry default_measurement_rules[] = {
-	{.action = MEASURE, .func = MMAP_CHECK, .mask = MAY_EXEC,
+	{.action = MEASURE, .hooks.func = MMAP_CHECK, .mask = MAY_EXEC,
 	 .flags = IMA_FUNC | IMA_MASK},
-	{.action = MEASURE, .func = BPRM_CHECK, .mask = MAY_EXEC,
+	{.action = MEASURE, .hooks.func = BPRM_CHECK, .mask = MAY_EXEC,
 	 .flags = IMA_FUNC | IMA_MASK},
-	{.action = MEASURE, .func = FILE_CHECK, .mask = MAY_READ,
+	{.action = MEASURE, .hooks.func = FILE_CHECK, .mask = MAY_READ,
 	 .uid = GLOBAL_ROOT_UID, .flags = IMA_FUNC | IMA_INMASK | IMA_EUID},
-	{.action = MEASURE, .func = FILE_CHECK, .mask = MAY_READ,
+	{.action = MEASURE, .hooks.func = FILE_CHECK, .mask = MAY_READ,
 	 .uid = GLOBAL_ROOT_UID, .flags = IMA_FUNC | IMA_INMASK | IMA_UID},
-	{.action = MEASURE, .func = MODULE_CHECK, .flags = IMA_FUNC},
-	{.action = MEASURE, .func = FIRMWARE_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .hooks.func = MODULE_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .hooks.func = FIRMWARE_CHECK, .flags = IMA_FUNC},
 };
 
 static struct ima_rule_entry default_appraise_rules[] = {
@@ -208,14 +211,14 @@ static void ima_lsm_update_rules(void)
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule,
-			    struct inode *inode, enum ima_hooks func, int mask)
+			    struct inode *inode, int func, int mask)
 {
 	struct task_struct *tsk = current;
 	const struct cred *cred = current_cred();
 	int i;
 
 	if ((rule->flags & IMA_FUNC) &&
-	    (rule->func != func && func != POST_SETATTR))
+	    (rule->hooks.func != func && func != POST_SETATTR))
 		return false;
 	if ((rule->flags & IMA_MASK) &&
 	    (rule->mask != mask && func != POST_SETATTR))
@@ -322,8 +325,7 @@ static int get_subaction(struct ima_rule_entry *rule, int func)
  * list when walking it.  Reads are many orders of magnitude more numerous
  * than writes so ima_match_policy() is classical RCU candidate.
  */
-int ima_match_policy(struct inode *inode, enum ima_hooks func, int mask,
-		     int flags)
+int ima_match_policy(struct inode *inode, int func, int mask, int flags)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -595,23 +597,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		case Opt_func:
 			ima_log_string(ab, "func", args[0].from);
 
-			if (entry->func)
+			if (entry->hooks.func)
 				result = -EINVAL;
 
 			if (strcmp(args[0].from, "FILE_CHECK") == 0)
-				entry->func = FILE_CHECK;
+				entry->hooks.func = FILE_CHECK;
 			/* PATH_CHECK is for backwards compat */
 			else if (strcmp(args[0].from, "PATH_CHECK") == 0)
-				entry->func = FILE_CHECK;
+				entry->hooks.func = FILE_CHECK;
 			else if (strcmp(args[0].from, "MODULE_CHECK") == 0)
-				entry->func = MODULE_CHECK;
+				entry->hooks.func = MODULE_CHECK;
 			else if (strcmp(args[0].from, "FIRMWARE_CHECK") == 0)
-				entry->func = FIRMWARE_CHECK;
+				entry->hooks.func = FIRMWARE_CHECK;
 			else if ((strcmp(args[0].from, "FILE_MMAP") == 0)
 				|| (strcmp(args[0].from, "MMAP_CHECK") == 0))
-				entry->func = MMAP_CHECK;
+				entry->hooks.func = MMAP_CHECK;
 			else if (strcmp(args[0].from, "BPRM_CHECK") == 0)
-				entry->func = BPRM_CHECK;
+				entry->hooks.func = BPRM_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
@@ -766,9 +768,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	}
 	if (!result && (entry->action == UNKNOWN))
 		result = -EINVAL;
-	else if (entry->func == MODULE_CHECK)
+	else if (entry->hooks.func == MODULE_CHECK)
 		temp_ima_appraise |= IMA_APPRAISE_MODULES;
-	else if (entry->func == FIRMWARE_CHECK)
+	else if (entry->hooks.func == FIRMWARE_CHECK)
 		temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
 	audit_log_format(ab, "res=%d", !result);
 	audit_log_end(ab);
@@ -855,7 +857,8 @@ static char *mask_tokens[] = {
 
 enum {
 	func_file = 0, func_mmap, func_bprm,
-	func_module, func_firmware, func_post
+	func_module, func_firmware, func_post,
+	func_kexec, func_initramfs
 };
 
 static char *func_tokens[] = {
@@ -925,7 +928,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 	seq_puts(m, " ");
 
 	if (entry->flags & IMA_FUNC) {
-		switch (entry->func) {
+		switch (entry->hooks.func) {
 		case FILE_CHECK:
 			seq_printf(m, pt(Opt_func), ft(func_file));
 			break;
@@ -945,7 +948,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 			seq_printf(m, pt(Opt_func), ft(func_post));
 			break;
 		default:
-			snprintf(tbuf, sizeof(tbuf), "%d", entry->func);
+			snprintf(tbuf, sizeof(tbuf), "%d",
+				 entry->hooks.func);
 			seq_printf(m, pt(Opt_func), tbuf);
 			break;
 		}
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 5efe2ec..9a0ea4c 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -49,12 +49,14 @@
 #define IMA_MODULE_APPRAISED	0x00008000
 #define IMA_FIRMWARE_APPRAISE	0x00010000
 #define IMA_FIRMWARE_APPRAISED	0x00020000
+#define IMA_READ_APPRAISE	0x00040000
+#define IMA_READ_APPRAISED	0x00080000
 #define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
 				 IMA_BPRM_APPRAISE | IMA_MODULE_APPRAISE | \
-				 IMA_FIRMWARE_APPRAISE)
+				 IMA_FIRMWARE_APPRAISE | IMA_READ_APPRAISE)
 #define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED | \
 				 IMA_BPRM_APPRAISED | IMA_MODULE_APPRAISED | \
-				 IMA_FIRMWARE_APPRAISED)
+				 IMA_FIRMWARE_APPRAISED | IMA_READ_APPRAISED)
 
 enum evm_ima_xattr_type {
 	IMA_XATTR_DIGEST = 0x01,
@@ -111,6 +113,7 @@ struct integrity_iint_cache {
 	enum integrity_status ima_bprm_status:4;
 	enum integrity_status ima_module_status:4;
 	enum integrity_status ima_firmware_status:4;
+	enum integrity_status ima_read_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
 };
diff --git a/security/security.c b/security/security.c
index 293bb4b..49cacae 100644
--- a/security/security.c
+++ b/security/security.c
@@ -910,9 +910,11 @@ int security_kernel_module_from_file(struct file *file)
 	return ima_module_check(file);
 }
 
-int security_kernel_post_read_file(struct file *file, char *buf, loff_t size)
+int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
+				   int policy_id)
 {
-	return = call_int_hook(kernel_post_read_file, 0, file, buf, size);
+	return = call_int_hook(kernel_post_read_file, 0, file, buf, size,
+			       policy_id);
 }
 EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
 
-- 
2.1.0

