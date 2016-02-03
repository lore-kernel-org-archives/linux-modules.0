Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:37944 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965452AbcBCTHq (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 3 Feb 2016 14:07:46 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 4 Feb 2016 05:07:43 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 03/22] ima: use "ima_hooks" enum as function argument
Date: Wed,  3 Feb 2016 14:06:11 -0500
Message-Id: <1454526390-19792-4-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Cleanup the function arguments by using "ima_hooks" enumerator as needed.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h          | 25 +++++++++++++++++--------
 security/integrity/ima/ima_api.c      |  6 +++---
 security/integrity/ima/ima_appraise.c | 13 +++++++------
 security/integrity/ima/ima_main.c     | 14 +++++++-------
 security/integrity/ima/ima_policy.c   |  6 +++---
 5 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index fb8da36..b7e7935 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -137,9 +137,18 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	return hash_long(*digest, IMA_HASH_BITS);
 }
 
+enum ima_hooks {
+	FILE_CHECK = 1,
+	MMAP_CHECK,
+	BPRM_CHECK,
+	MODULE_CHECK,
+	FIRMWARE_CHECK,
+	POST_SETATTR
+};
+
 /* LIM API function definitions */
-int ima_get_action(struct inode *inode, int mask, int function);
-int ima_must_measure(struct inode *inode, int mask, int function);
+int ima_get_action(struct inode *inode, int mask, enum ima_hooks func);
+int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, enum hash_algo algo);
 void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
@@ -156,8 +165,6 @@ void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(struct path *path, char **pathbuf);
 
 /* IMA policy related functions */
-enum ima_hooks { FILE_CHECK = 1, MMAP_CHECK, BPRM_CHECK, MODULE_CHECK, FIRMWARE_CHECK, POST_SETATTR };
-
 int ima_match_policy(struct inode *inode, enum ima_hooks func, int mask,
 		     int flags);
 void ima_init_policy(void);
@@ -179,21 +186,22 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_FIRMWARE	0x10
 
 #ifdef CONFIG_IMA_APPRAISE
-int ima_appraise_measurement(int func, struct integrity_iint_cache *iint,
+int ima_appraise_measurement(enum ima_hooks func,
+			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
 			     int xattr_len, int opened);
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
-					   int func);
+					   enum ima_hooks func);
 enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
 				 int xattr_len);
 int ima_read_xattr(struct dentry *dentry,
 		   struct evm_ima_xattr_data **xattr_value);
 
 #else
-static inline int ima_appraise_measurement(int func,
+static inline int ima_appraise_measurement(enum ima_hooks func,
 					   struct integrity_iint_cache *iint,
 					   struct file *file,
 					   const unsigned char *filename,
@@ -215,7 +223,8 @@ static inline void ima_update_xattr(struct integrity_iint_cache *iint,
 }
 
 static inline enum integrity_status ima_get_cache_status(struct integrity_iint_cache
-							 *iint, int func)
+							 *iint,
+							 enum ima_hooks func)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index e7c7a5d..8750254 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -156,7 +156,7 @@ err_out:
  * ima_get_action - appraise & measure decision based on policy.
  * @inode: pointer to inode to measure
  * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXECUTE)
- * @function: calling function (FILE_CHECK, BPRM_CHECK, MMAP_CHECK, MODULE_CHECK)
+ * @func: caller identifier
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
@@ -168,13 +168,13 @@ err_out:
  * Returns IMA_MEASURE, IMA_APPRAISE mask.
  *
  */
-int ima_get_action(struct inode *inode, int mask, int function)
+int ima_get_action(struct inode *inode, int mask, enum ima_hooks func)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE;
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(inode, function, mask, flags);
+	return ima_match_policy(inode, func, mask, flags);
 }
 
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 9c2b46b..2888449 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -67,7 +67,7 @@ static int ima_fix_xattr(struct dentry *dentry,
 
 /* Return specific func appraised cached result */
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
-					   int func)
+					   enum ima_hooks func)
 {
 	switch (func) {
 	case MMAP_CHECK:
@@ -85,7 +85,8 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 }
 
 static void ima_set_cache_status(struct integrity_iint_cache *iint,
-				 int func, enum integrity_status status)
+				 enum ima_hooks func,
+				 enum integrity_status status)
 {
 	switch (func) {
 	case MMAP_CHECK:
@@ -103,11 +104,11 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
 	case FILE_CHECK:
 	default:
 		iint->ima_file_status = status;
-		break;
 	}
 }
 
-static void ima_cache_flags(struct integrity_iint_cache *iint, int func)
+static void ima_cache_flags(struct integrity_iint_cache *iint,
+			     enum ima_hooks func)
 {
 	switch (func) {
 	case MMAP_CHECK:
@@ -125,7 +126,6 @@ static void ima_cache_flags(struct integrity_iint_cache *iint, int func)
 	case FILE_CHECK:
 	default:
 		iint->flags |= (IMA_FILE_APPRAISED | IMA_APPRAISED);
-		break;
 	}
 }
 
@@ -185,7 +185,8 @@ int ima_read_xattr(struct dentry *dentry,
  *
  * Return 0 on success, error code otherwise
  */
-int ima_appraise_measurement(int func, struct integrity_iint_cache *iint,
+int ima_appraise_measurement(enum ima_hooks func,
+			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
 			     int xattr_len, int opened)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d9fc463..78a80c8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -153,8 +153,8 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
-static int process_measurement(struct file *file, int mask, int function,
-			       int opened)
+static int process_measurement(struct file *file, int mask,
+			       enum ima_hooks func, int opened)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -174,8 +174,8 @@ static int process_measurement(struct file *file, int mask, int function,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(inode, mask, function);
-	violation_check = ((function == FILE_CHECK || function == MMAP_CHECK) &&
+	action = ima_get_action(inode, mask, func);
+	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
 		return 0;
@@ -184,7 +184,7 @@ static int process_measurement(struct file *file, int mask, int function,
 
 	/*  Is the appraise rule hook specific?  */
 	if (action & IMA_FILE_APPRAISE)
-		function = FILE_CHECK;
+		func = FILE_CHECK;
 
 	mutex_lock(&inode->i_mutex);
 
@@ -214,7 +214,7 @@ static int process_measurement(struct file *file, int mask, int function,
 	/* Nothing to do, just return existing appraised status */
 	if (!action) {
 		if (must_appraise)
-			rc = ima_get_cache_status(iint, function);
+			rc = ima_get_cache_status(iint, func);
 		goto out_digsig;
 	}
 
@@ -240,7 +240,7 @@ static int process_measurement(struct file *file, int mask, int function,
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len);
 	if (action & IMA_APPRAISE_SUBMASK)
-		rc = ima_appraise_measurement(function, iint, file, pathname,
+		rc = ima_appraise_measurement(func, iint, file, pathname,
 					      xattr_value, xattr_len, opened);
 	if (action & IMA_AUDIT)
 		ima_audit_measurement(iint, pathname);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 43b6425..b089ebe 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -207,8 +207,8 @@ static void ima_lsm_update_rules(void)
  *
  * Returns true on rule match, false on failure.
  */
-static bool ima_match_rules(struct ima_rule_entry *rule,
-			    struct inode *inode, enum ima_hooks func, int mask)
+static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
+			    enum ima_hooks func, int mask)
 {
 	struct task_struct *tsk = current;
 	const struct cred *cred = current_cred();
@@ -289,7 +289,7 @@ retry:
  * In addition to knowing that we need to appraise the file in general,
  * we need to differentiate between calling hooks, for hook specific rules.
  */
-static int get_subaction(struct ima_rule_entry *rule, int func)
+static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 {
 	if (!(rule->flags & IMA_FUNC))
 		return IMA_FILE_APPRAISE;
-- 
2.1.0

