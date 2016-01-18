Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([125.16.236.2]:49836 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755455AbcARP25 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 18 Jan 2016 10:28:57 -0500
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Mon, 18 Jan 2016 20:51:14 +0530
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
Subject: [RFC PATCH v2 04/11] ima: calculate the hash of a buffer using aynchronous hash(ahash)
Date: Mon, 18 Jan 2016 10:11:19 -0500
Message-Id: <1453129886-20192-5-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Setting up ahash has some overhead.  Only use ahash to calculate the
hash of a buffer, if the buffer is larger than ima_ahash_minsize.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_crypto.c | 75 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 8d86281..82c4d3c 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -519,6 +519,63 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 	return rc;
 }
 
+static int calc_buffer_ahash_atfm(const void *buf, loff_t len,
+				  struct ima_digest_data *hash,
+				  struct crypto_ahash *tfm)
+{
+	struct ahash_request *req;
+	struct scatterlist sg;
+	struct ahash_completion res;
+	int rc, ahash_rc = 0;
+
+	hash->length = crypto_ahash_digestsize(tfm);
+
+	req = ahash_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	init_completion(&res.completion);
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				   CRYPTO_TFM_REQ_MAY_SLEEP,
+				   ahash_complete, &res);
+
+	rc = ahash_wait(crypto_ahash_init(req), &res);
+	if (rc)
+		goto out;
+
+	sg_init_one(&sg, buf, len);
+	ahash_request_set_crypt(req, &sg, NULL, len);
+
+	ahash_rc = crypto_ahash_update(req);
+
+	/* wait for the update request to complete */
+	rc = ahash_wait(ahash_rc, &res);
+	if (!rc) {
+		ahash_request_set_crypt(req, NULL, hash->digest, 0);
+		rc = ahash_wait(crypto_ahash_final(req), &res);
+	}
+out:
+	ahash_request_free(req);
+	return rc;
+}
+
+static int calc_buffer_ahash(const void *buf, loff_t len,
+			     struct ima_digest_data *hash)
+{
+	struct crypto_ahash *tfm;
+	int rc;
+
+	tfm = ima_alloc_atfm(hash->algo);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	rc = calc_buffer_ahash_atfm(buf, len, hash, tfm);
+
+	ima_free_atfm(tfm);
+
+	return rc;
+}
+
 static int calc_buffer_shash_tfm(const void *buf, loff_t size,
 				struct ima_digest_data *hash,
 				struct crypto_shash *tfm)
@@ -550,8 +607,8 @@ static int calc_buffer_shash_tfm(const void *buf, loff_t size,
 	return rc;
 }
 
-int ima_calc_buffer_hash(const void *buf, loff_t len,
-			 struct ima_digest_data *hash)
+static int calc_buffer_shash(const void *buf, loff_t len,
+			     struct ima_digest_data *hash)
 {
 	struct crypto_shash *tfm;
 	int rc;
@@ -566,6 +623,20 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 	return rc;
 }
 
+int ima_calc_buffer_hash(const void *buf, loff_t len,
+			 struct ima_digest_data *hash)
+{
+	int rc;
+
+	if (ima_ahash_minsize && len >= ima_ahash_minsize) {
+		rc = calc_buffer_ahash(buf, len, hash);
+		if (!rc)
+			return 0;
+	}
+
+	return calc_buffer_shash(buf, len, hash);
+}
+
 static void __init ima_pcrread(int idx, u8 *pcr)
 {
 	if (!ima_used_chip)
-- 
2.1.0

