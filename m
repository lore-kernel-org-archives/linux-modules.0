Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([125.16.236.5]:47874 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbcBLSbR (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 13:31:17 -0500
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 13 Feb 2016 00:01:14 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Dmitry Kasatkin <d.kasatkin@samsung.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 06/19] ima: provide buffer hash calculation function
Date: Fri, 12 Feb 2016 13:29:18 -0500
Message-Id: <1455301771-7703-7-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Dmitry Kasatkin <d.kasatkin@samsung.com>

This patch provides convenient buffer hash calculation function.

Changelog v3:
- fix while hash calculation - Dmitry
v1:
- rewrite to support loff_t sized buffers - Mimi
  (based on Fenguang Wu's testing)

Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_crypto.c | 47 +++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b7e7935..2c5262f 100644
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
index fb30ce4..fccb6ce 100644
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
+	while (size) {
+		len = size < PAGE_SIZE ? size : PAGE_SIZE;
+		rc = crypto_shash_update(shash, buf, len);
+		if (rc)
+			break;
+		buf += len;
+		size -= len;
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

