Return-Path: <SRS0=E4eM=QW=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91968C43381
	for <linux-modules@archiver.kernel.org>; Fri, 15 Feb 2019 08:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F9F206BB
	for <linux-modules@archiver.kernel.org>; Fri, 15 Feb 2019 08:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbfBOIEY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:04:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:11656 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfBOIEY (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 15 Feb 2019 03:04:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 00:04:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,372,1544515200"; 
   d="scan'208";a="134516831"
Received: from adlam-mobl7.amr.corp.intel.com (HELO ldmartin-desk.jf.intel.com) ([10.255.231.171])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2019 00:04:22 -0800
Date:   Fri, 15 Feb 2019 00:04:22 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Stefan Strogin <stefan.strogin@gmail.com>
Cc:     linux-modules@vger.kernel.org, ykaliuta@redhat.com
Subject: Re: [PATCH] libkmod-signature: use PKCS7 for LibreSSL or older
 OpenSSL
Message-ID: <20190215080422.hjl356xb7hui44iv@ldmartin-desk.jf.intel.com>
References: <20190215041340.29258-1-stefan.strogin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190215041340.29258-1-stefan.strogin@gmail.com>
User-Agent: NeoMutt/20180716
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Feb 15, 2019 at 06:13:40AM +0200, Stefan Strogin wrote:
>Linux kernel uses either PKCS #7 or CMS signing modules (scripts/sign-file.c).
>CMS is not supported by LibreSSL, PKCS #7 is used instead.
>For now modinfo used CMS with no altenative requiring >=openssl-1.1.0
>built with CMS support.
>
>Use PKCS #7 for parsing module signature information when CMS is not available.
>
>Signed-off-by: Stefan Strogin <stefan.strogin@gmail.com>

ooh, this ifdef is messy. Why do we want both libressl and openssl? What
distro is requiring that?

if in the end we end up with ifdefs for N different libs I'd rather just
add the implementation in kmod itself or convince kernel guys to just
fill out the struct they are supposed to fill.

Lucas De Marchi

>---
> libkmod/libkmod-signature.c | 78 +++++++++++++++++++++++++++++++++++--
> 1 file changed, 75 insertions(+), 3 deletions(-)
>
>diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
>index 48d0145..aa2a60e 100644
>--- a/libkmod/libkmod-signature.c
>+++ b/libkmod/libkmod-signature.c
>@@ -20,9 +20,16 @@
> #include <endian.h>
> #include <inttypes.h>
> #ifdef ENABLE_OPENSSL
>-#include <openssl/cms.h>
>-#include <openssl/ssl.h>
>-#endif
>+# include <openssl/ssl.h>
>+# if defined(LIBRESSL_VERSION_NUMBER) || \
>+	OPENSSL_VERSION_NUMBER < 0x10100000L || \
>+	defined(OPENSSL_NO_CMS)
>+#  define USE_PKCS7
>+#  include <openssl/pkcs7.h>
>+# else
>+#  include <openssl/cms.h>
>+# endif /* LIBRESSL_VERSION_NUMBER */
>+#endif /* ENABLE_OPENSSL */
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
>@@ -122,7 +129,11 @@ static bool fill_default(const char *mem, off_t size,
> #ifdef ENABLE_OPENSSL
>
> struct pkcs7_private {
>+#ifndef USE_PKCS7
> 	CMS_ContentInfo *cms;
>+#else
>+	PKCS7 *pkcs7;
>+#endif
> 	unsigned char *key_id;
> 	BIGNUM *sno;
> };
>@@ -132,7 +143,11 @@ static void pkcs7_free(void *s)
> 	struct kmod_signature_info *si = s;
> 	struct pkcs7_private *pvt = si->private;
>
>+#ifndef USE_PKCS7
> 	CMS_ContentInfo_free(pvt->cms);
>+#else
>+	PKCS7_free(pvt->pkcs7);
>+#endif
> 	BN_free(pvt->sno);
> 	free(pvt->key_id);
> 	free(pvt);
>@@ -187,7 +202,13 @@ static const char *x509_name_to_str(X509_NAME *name)
> 		return NULL;
>
> 	d = X509_NAME_ENTRY_get_data(e);
>+#if (defined(LIBRESSL_VERSION_NUMBER) && \
>+		LIBRESSL_VERSION_NUMBER < 0x20700000L) || \
>+	OPENSSL_VERSION_NUMBER < 0x10100000L
>+	str = (const char *)ASN1_STRING_data(d);
>+#else
> 	str = (const char *)ASN1_STRING_get0_data(d);
>+#endif
>
> 	return str;
> }
>@@ -197,11 +218,18 @@ static bool fill_pkcs7(const char *mem, off_t size,
> 		       struct kmod_signature_info *sig_info)
> {
> 	const char *pkcs7_raw;
>+#ifndef USE_PKCS7
> 	CMS_ContentInfo *cms;
> 	STACK_OF(CMS_SignerInfo) *sis;
> 	CMS_SignerInfo *si;
> 	int rc;
> 	ASN1_OCTET_STRING *key_id;
>+#else
>+	PKCS7 *pkcs7;
>+	STACK_OF(PKCS7_SIGNER_INFO) *sis;
>+	PKCS7_SIGNER_INFO *si;
>+	PKCS7_ISSUER_AND_SERIAL *is;
>+#endif
> 	X509_NAME *issuer;
> 	ASN1_INTEGER *sno;
> 	ASN1_OCTET_STRING *sig;
>@@ -220,14 +248,23 @@ static bool fill_pkcs7(const char *mem, off_t size,
>
> 	in = BIO_new_mem_buf(pkcs7_raw, sig_len);
>
>+#ifndef USE_PKCS7
> 	cms = d2i_CMS_bio(in, NULL);
> 	if (cms == NULL) {
> 		BIO_free(in);
> 		return false;
> 	}
>+#else
>+	pkcs7 = d2i_PKCS7_bio(in, NULL);
>+	if (pkcs7 == NULL) {
>+		BIO_free(in);
>+		return false;
>+	}
>+#endif
>
> 	BIO_free(in);
>
>+#ifndef USE_PKCS7
> 	sis = CMS_get0_SignerInfos(cms);
> 	if (sis == NULL)
> 		goto err;
>@@ -245,8 +282,35 @@ static bool fill_pkcs7(const char *mem, off_t size,
> 		goto err;
>
> 	CMS_SignerInfo_get0_algs(si, NULL, NULL, &dig_alg, &sig_alg);
>+#else
>+	sis = PKCS7_get_signer_info(pkcs7);
>+	if (sis == NULL)
>+		goto err;
>+
>+	si = sk_PKCS7_SIGNER_INFO_value(sis, 0);
>+	if (si == NULL)
>+		goto err;
>+
>+	is = si->issuer_and_serial;
>+	if (is == NULL)
>+		goto err;
>+	issuer = is->issuer;
>+	sno = is->serial;
>+
>+	sig = si->enc_digest;
>+	if (sig == NULL)
>+		goto err;
>+
>+	PKCS7_SIGNER_INFO_get0_algs(si, NULL, &dig_alg, &sig_alg);
>+#endif
>
>+#if (defined(LIBRESSL_VERSION_NUMBER) && \
>+		LIBRESSL_VERSION_NUMBER < 0x20700000L) || \
>+	OPENSSL_VERSION_NUMBER < 0x10100000L
>+	sig_info->sig = (const char *)ASN1_STRING_data(sig);
>+#else
> 	sig_info->sig = (const char *)ASN1_STRING_get0_data(sig);
>+#endif
> 	sig_info->sig_len = ASN1_STRING_length(sig);
>
> 	sno_bn = ASN1_INTEGER_to_BN(sno, NULL);
>@@ -277,7 +341,11 @@ static bool fill_pkcs7(const char *mem, off_t size,
> 	if (pvt == NULL)
> 		goto err3;
>
>+#ifndef USE_PKCS7
> 	pvt->cms = cms;
>+#else
>+	pvt->pkcs7 = pkcs7;
>+#endif
> 	pvt->key_id = key_id_str;
> 	pvt->sno = sno_bn;
> 	sig_info->private = pvt;
>@@ -290,7 +358,11 @@ err3:
> err2:
> 	BN_free(sno_bn);
> err:
>+#ifndef USE_PKCS7
> 	CMS_ContentInfo_free(cms);
>+#else
>+	PKCS7_free(pkcs7);
>+#endif
> 	return false;
> }
>
>-- 
>2.20.1
>
