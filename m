Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([125.16.236.7]:51130 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbcARPXo (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 18 Jan 2016 10:23:44 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Mon, 18 Jan 2016 20:44:01 +0530
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
Subject: [RFC PATCH v2 03/11] ima: provide buffer hash calculation function
Date: Mon, 18 Jan 2016 10:11:18 -0500
Message-Id: <1453129886-20192-4-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Dmitry Kasatkin <d.kasatkin@samsung.com>

This patch provides convenient buffer hash calculation function.

Changelog:
- rewrite to support loff_t sized buffers - Mimi
  (based on Fenguang Wu's testing)

Signed-off-by: Dmitry Kasatkin <d.kasatkin@samsung.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_crypto.c | 47 +++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index fb8da36..de53631 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -107,6 +107,8 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename);
 int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
+int ima_calc_buffer_hash(const void *buf, loff_t len,
+			 struct ima_digest_data *hash);
 int ima_calc_field_array_hash(struct ima_field_data *field_data,
 			      struct ima_template_desc *desc, int num_fields,
 			      struct ima_digest_data *hash);
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index fb30ce4..8d86281 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -519,6 +519,53 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 	return rc;
 }
 
+static int calc_buffer_shash_tfm(const void *buf, loff_t size,
+				struct ima_digest_data *hash,
+				struct crypto_shash *tfm)
+{
+	SHASH_DESC_ON_STACK(shash, tfm);
+	unsigned int len;
+	loff_t offset = 0;
+	int rc;
+
+	shash->tfm = tfm;
+	shash->flags = 0;
+
+	hash->length = crypto_shash_digestsize(tfm);
+
+	rc = crypto_shash_init(shash);
+	if (rc != 0)
+		return rc;
+
+	len = size < PAGE_SIZE ? size : PAGE_SIZE;
+	while (offset < size) {
+		rc = crypto_shash_update(shash, buf + offset, len);
+		if (rc)
+			break;
+		offset += len;
+	}
+
+	if (!rc)
+		rc = crypto_shash_final(shash, hash->digest);
+	return rc;
+}
+
+int ima_calc_buffer_hash(const void *buf, loff_t len,
+			 struct ima_digest_data *hash)
+{
+	struct crypto_shash *tfm;
+	int rc;
+
+	tfm = ima_alloc_tfm(hash->algo);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	rc = calc_buffer_shash_tfm(buf, len, hash, tfm);
+
+	ima_free_tfm(tfm);
+	return rc;
+}
+
 static void __init ima_pcrread(int idx, u8 *pcr)
 {
 	if (!ima_used_chip)
-- 
2.1.0

