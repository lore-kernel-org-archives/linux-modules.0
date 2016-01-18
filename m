Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([125.16.236.8]:49635 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939AbcARP15 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 18 Jan 2016 10:27:57 -0500
Received: from localhost
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Mon, 18 Jan 2016 20:48:47 +0530
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
Subject: [RFC PATCH v2 01/11] ima: separate 'security.ima' reading functionality from collect
Date: Mon, 18 Jan 2016 10:11:16 -0500
Message-Id: <1453129886-20192-2-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Dmitry Kasatkin <d.kasatkin@samsung.com>

Instead of passing pointers to pointers to ima_collect_measurent() to
read and return the 'security.ima' xattr value, this patch moves the
functionality to the calling process_measurement() to directly read
the xattr and pass only the hash algo to the ima_collect_measurement().

Signed-off-by: Dmitry Kasatkin <d.kasatkin@samsung.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h              | 15 +++++++--------
 security/integrity/ima/ima_api.c          | 15 +++------------
 security/integrity/ima/ima_appraise.c     | 25 ++++++++++++++-----------
 security/integrity/ima/ima_crypto.c       |  2 +-
 security/integrity/ima/ima_init.c         |  2 +-
 security/integrity/ima/ima_main.c         | 11 +++++++----
 security/integrity/ima/ima_template.c     |  2 --
 security/integrity/ima/ima_template_lib.c |  1 -
 8 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 585af61..fb8da36 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -23,6 +23,7 @@
 #include <linux/hash.h>
 #include <linux/tpm.h>
 #include <linux/audit.h>
+#include <crypto/hash_info.h>
 
 #include "../integrity.h"
 
@@ -140,9 +141,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 int ima_get_action(struct inode *inode, int mask, int function);
 int ima_must_measure(struct inode *inode, int mask, int function);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
-			    struct file *file,
-			    struct evm_ima_xattr_data **xattr_value,
-			    int *xattr_len);
+			    struct file *file, enum hash_algo algo);
 void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
@@ -188,8 +187,8 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 					   int func);
-void ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value, int xattr_len,
-		       struct ima_digest_data *hash);
+enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
+				 int xattr_len);
 int ima_read_xattr(struct dentry *dentry,
 		   struct evm_ima_xattr_data **xattr_value);
 
@@ -221,10 +220,10 @@ static inline enum integrity_status ima_get_cache_status(struct integrity_iint_c
 	return INTEGRITY_UNKNOWN;
 }
 
-static inline void ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
-				     int xattr_len,
-				     struct ima_digest_data *hash)
+static inline enum hash_algo
+ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value, int xattr_len)
 {
+	return ima_hash_algo;
 }
 
 static inline int ima_read_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 1d950fb..e7c7a5d 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -18,7 +18,7 @@
 #include <linux/fs.h>
 #include <linux/xattr.h>
 #include <linux/evm.h>
-#include <crypto/hash_info.h>
+
 #include "ima.h"
 
 /*
@@ -188,9 +188,7 @@ int ima_get_action(struct inode *inode, int mask, int function)
  * Return 0 on success, error code otherwise
  */
 int ima_collect_measurement(struct integrity_iint_cache *iint,
-			    struct file *file,
-			    struct evm_ima_xattr_data **xattr_value,
-			    int *xattr_len)
+			    struct file *file, enum hash_algo algo)
 {
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
@@ -201,9 +199,6 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 		char digest[IMA_MAX_DIGEST_SIZE];
 	} hash;
 
-	if (xattr_value)
-		*xattr_len = ima_read_xattr(file->f_path.dentry, xattr_value);
-
 	if (!(iint->flags & IMA_COLLECTED)) {
 		u64 i_version = file_inode(file)->i_version;
 
@@ -213,11 +208,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 			goto out;
 		}
 
-		/* use default hash algorithm */
-		hash.hdr.algo = ima_hash_algo;
-
-		if (xattr_value)
-			ima_get_hash_algo(*xattr_value, *xattr_len, &hash.hdr);
+		hash.hdr.algo = algo;
 
 		result = ima_calc_file_hash(file, &hash.hdr);
 		if (!result) {
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 1873b55..9c2b46b 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -15,7 +15,6 @@
 #include <linux/magic.h>
 #include <linux/ima.h>
 #include <linux/evm.h>
-#include <crypto/hash_info.h>
 
 #include "ima.h"
 
@@ -130,36 +129,40 @@ static void ima_cache_flags(struct integrity_iint_cache *iint, int func)
 	}
 }
 
-void ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value, int xattr_len,
-		       struct ima_digest_data *hash)
+enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
+				 int xattr_len)
 {
 	struct signature_v2_hdr *sig;
 
 	if (!xattr_value || xattr_len < 2)
-		return;
+		/* return default hash algo */
+		return ima_hash_algo;
 
 	switch (xattr_value->type) {
 	case EVM_IMA_XATTR_DIGSIG:
 		sig = (typeof(sig))xattr_value;
 		if (sig->version != 2 || xattr_len <= sizeof(*sig))
-			return;
-		hash->algo = sig->hash_algo;
+			return ima_hash_algo;
+		return sig->hash_algo;
 		break;
 	case IMA_XATTR_DIGEST_NG:
-		hash->algo = xattr_value->digest[0];
+		return xattr_value->digest[0];
 		break;
 	case IMA_XATTR_DIGEST:
 		/* this is for backward compatibility */
 		if (xattr_len == 21) {
 			unsigned int zero = 0;
 			if (!memcmp(&xattr_value->digest[16], &zero, 4))
-				hash->algo = HASH_ALGO_MD5;
+				return HASH_ALGO_MD5;
 			else
-				hash->algo = HASH_ALGO_SHA1;
+				return HASH_ALGO_SHA1;
 		} else if (xattr_len == 17)
-			hash->algo = HASH_ALGO_MD5;
+			return HASH_ALGO_MD5;
 		break;
 	}
+
+	/* return default hash algo */
+	return ima_hash_algo;
 }
 
 int ima_read_xattr(struct dentry *dentry,
@@ -296,7 +299,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
 	if (iint->flags & IMA_DIGSIG)
 		return;
 
-	rc = ima_collect_measurement(iint, file, NULL, NULL);
+	rc = ima_collect_measurement(iint, file, ima_hash_algo);
 	if (rc < 0)
 		return;
 
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 6eb6293..fb30ce4 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -24,7 +24,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <crypto/hash.h>
-#include <crypto/hash_info.h>
+
 #include "ima.h"
 
 struct ahash_completion {
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index bd79f25..5d679a6 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -21,7 +21,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <crypto/hash_info.h>
+
 #include "ima.h"
 
 /* name for boot aggregate entry */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c21f09b..d9fc463 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -24,7 +24,6 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 #include <linux/ima.h>
-#include <crypto/hash_info.h>
 
 #include "ima.h"
 
@@ -163,9 +162,10 @@ static int process_measurement(struct file *file, int mask, int function,
 	char *pathbuf = NULL;
 	const char *pathname = NULL;
 	int rc = -ENOMEM, action, must_appraise;
-	struct evm_ima_xattr_data *xattr_value = NULL, **xattr_ptr = NULL;
+	struct evm_ima_xattr_data *xattr_value = NULL;
 	int xattr_len = 0;
 	bool violation_check;
+	enum hash_algo hash_algo;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -221,9 +221,12 @@ static int process_measurement(struct file *file, int mask, int function,
 	template_desc = ima_template_desc_current();
 	if ((action & IMA_APPRAISE_SUBMASK) ||
 		    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0)
-		xattr_ptr = &xattr_value;
+		/* read 'security.ima' */
+		xattr_len = ima_read_xattr(file->f_path.dentry, &xattr_value);
 
-	rc = ima_collect_measurement(iint, file, xattr_ptr, &xattr_len);
+	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
+
+	rc = ima_collect_measurement(iint, file, hash_algo);
 	if (rc != 0) {
 		if (file->f_flags & O_DIRECT)
 			rc = (iint->flags & IMA_PERMIT_DIRECTIO) ? 0 : -EACCES;
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 0b7404e..febd12e 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -15,8 +15,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <crypto/hash_info.h>
-
 #include "ima.h"
 #include "ima_template_lib.h"
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 2934e3d..f9bae04 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -12,7 +12,6 @@
  * File: ima_template_lib.c
  *      Library of supported template fields.
  */
-#include <crypto/hash_info.h>
 
 #include "ima_template_lib.h"
 
-- 
2.1.0

