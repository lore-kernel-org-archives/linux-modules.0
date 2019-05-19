Return-Path: <SRS0=8YKq=TT=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE2AC04AAF
	for <linux-modules@archiver.kernel.org>; Sun, 19 May 2019 00:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9692083D
	for <linux-modules@archiver.kernel.org>; Sun, 19 May 2019 00:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfESAmT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 18 May 2019 20:42:19 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:57208 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbfESAmS (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 18 May 2019 20:42:18 -0400
Received: from localhost.localdomain (pripet.hukot.net [46.36.39.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: steils)
        by smtp.gentoo.org (Postfix) with ESMTPSA id B821B344A54;
        Sun, 19 May 2019 00:42:15 +0000 (UTC)
From:   Stefan Strogin <steils@gentoo.org>
To:     linux-modules@vger.kernel.org
Cc:     Stefan Strogin <steils@gentoo.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Aaron Bauman <bman@gentoo.org>
Subject: [PATCH v2] libkmod-signature: use PKCS#7 instead of CMS
Date:   Sun, 19 May 2019 03:42:01 +0300
Message-Id: <20190519004201.7032-1-steils@gentoo.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Linux uses either PKCS #7 or CMS for signing modules (see
scripts/sign-file.c). CMS is not supported by LibreSSL or older OpenSSL,
so PKCS #7 is used on systems with these libcrypto providers.

CMS and PKCS #7 formats are very similar. CMS is newer but is as much as
possible backward compatible with PKCS #7 [1]. PKCS #7 is supported in
the latest OpenSSL as well as CMS. The fields used for signing kernel
modules are supported both in PKCS #7 and CMS.

For now modinfo uses CMS with no alternative requiring OpenSSL 1.1.0 or
newer.

Use PKCS #7 for parsing module signature information, so that modinfo
could be used both with OpenSSL and LibreSSL.

[1] https://tools.ietf.org/html/rfc5652#section-1.1

Changes v1->v2:
- Don't use ifdefs for keeping redundant CMS code, just use PKCS #7 both
with OpenSSL and LibreSSL.

Signed-off-by: Stefan Strogin <steils@gentoo.org>
---
 libkmod/libkmod-signature.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index 48d0145..4e8748c 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -20,7 +20,7 @@
 #include <endian.h>
 #include <inttypes.h>
 #ifdef ENABLE_OPENSSL
-#include <openssl/cms.h>
+#include <openssl/pkcs7.h>
 #include <openssl/ssl.h>
 #endif
 #include <stdio.h>
@@ -122,7 +122,7 @@ static bool fill_default(const char *mem, off_t size,
 #ifdef ENABLE_OPENSSL
 
 struct pkcs7_private {
-	CMS_ContentInfo *cms;
+	PKCS7 *pkcs7;
 	unsigned char *key_id;
 	BIGNUM *sno;
 };
@@ -132,7 +132,7 @@ static void pkcs7_free(void *s)
 	struct kmod_signature_info *si = s;
 	struct pkcs7_private *pvt = si->private;
 
-	CMS_ContentInfo_free(pvt->cms);
+	PKCS7_free(pvt->pkcs7);
 	BN_free(pvt->sno);
 	free(pvt->key_id);
 	free(pvt);
@@ -197,11 +197,10 @@ static bool fill_pkcs7(const char *mem, off_t size,
 		       struct kmod_signature_info *sig_info)
 {
 	const char *pkcs7_raw;
-	CMS_ContentInfo *cms;
-	STACK_OF(CMS_SignerInfo) *sis;
-	CMS_SignerInfo *si;
-	int rc;
-	ASN1_OCTET_STRING *key_id;
+	PKCS7 *pkcs7;
+	STACK_OF(PKCS7_SIGNER_INFO) *sis;
+	PKCS7_SIGNER_INFO *si;
+	PKCS7_ISSUER_AND_SERIAL *is;
 	X509_NAME *issuer;
 	ASN1_INTEGER *sno;
 	ASN1_OCTET_STRING *sig;
@@ -220,31 +219,33 @@ static bool fill_pkcs7(const char *mem, off_t size,
 
 	in = BIO_new_mem_buf(pkcs7_raw, sig_len);
 
-	cms = d2i_CMS_bio(in, NULL);
-	if (cms == NULL) {
+	pkcs7 = d2i_PKCS7_bio(in, NULL);
+	if (pkcs7 == NULL) {
 		BIO_free(in);
 		return false;
 	}
 
 	BIO_free(in);
 
-	sis = CMS_get0_SignerInfos(cms);
+	sis = PKCS7_get_signer_info(pkcs7);
 	if (sis == NULL)
 		goto err;
 
-	si = sk_CMS_SignerInfo_value(sis, 0);
+	si = sk_PKCS7_SIGNER_INFO_value(sis, 0);
 	if (si == NULL)
 		goto err;
 
-	rc = CMS_SignerInfo_get0_signer_id(si, &key_id, &issuer, &sno);
-	if (rc == 0)
+	is = si->issuer_and_serial;
+	if (is == NULL)
 		goto err;
+	issuer = is->issuer;
+	sno = is->serial;
 
-	sig = CMS_SignerInfo_get0_signature(si);
+	sig = si->enc_digest;
 	if (sig == NULL)
 		goto err;
 
-	CMS_SignerInfo_get0_algs(si, NULL, NULL, &dig_alg, &sig_alg);
+	PKCS7_SIGNER_INFO_get0_algs(si, NULL, &dig_alg, &sig_alg);
 
 	sig_info->sig = (const char *)ASN1_STRING_get0_data(sig);
 	sig_info->sig_len = ASN1_STRING_length(sig);
@@ -277,7 +278,7 @@ static bool fill_pkcs7(const char *mem, off_t size,
 	if (pvt == NULL)
 		goto err3;
 
-	pvt->cms = cms;
+	pvt->pkcs7 = pkcs7;
 	pvt->key_id = key_id_str;
 	pvt->sno = sno_bn;
 	sig_info->private = pvt;
@@ -290,7 +291,7 @@ err3:
 err2:
 	BN_free(sno_bn);
 err:
-	CMS_ContentInfo_free(cms);
+	PKCS7_free(pkcs7);
 	return false;
 }
 
-- 
2.21.0

