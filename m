Return-Path: <SRS0=vj8i=N2=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7D2C43441
	for <linux-modules@archiver.kernel.org>; Thu, 15 Nov 2018 21:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3392087A
	for <linux-modules@archiver.kernel.org>; Thu, 15 Nov 2018 21:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3392087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbeKPHjS (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 16 Nov 2018 02:39:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbeKPHjS (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 16 Nov 2018 02:39:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E31E330821A3;
        Thu, 15 Nov 2018 21:29:47 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-117-20.ams2.redhat.com [10.36.117.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E66345D739;
        Thu, 15 Nov 2018 21:29:46 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     ykaliuta@redhat.com, Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH] signature: do not report wrong data for pkc#7 signature
Date:   Thu, 15 Nov 2018 23:29:45 +0200
Message-Id: <20181115212945.24690-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 15 Nov 2018 21:29:47 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

when PKC#7 signing method is used the old structure doesn't contain
any useful data, but the data are encoded in the certificate.

The info getting/showing code is not aware of that at the moment and
since 0 is a valid constant, shows, for example, wrong "md4" for the
hash algo.

The patch splits the 2 mothods of gethering the info and reports
"unknown" for the algo.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 libkmod/libkmod-module.c    |  2 +-
 libkmod/libkmod-signature.c | 69 +++++++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index ee420f4ec2bf..889f26479a98 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2273,7 +2273,7 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 	struct kmod_elf *elf;
 	char **strings;
 	int i, count, ret = -ENOMEM;
-	struct kmod_signature_info sig_info;
+	struct kmod_signature_info sig_info = {};
 
 	if (mod == NULL || list == NULL)
 		return -ENOENT;
diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index 1f3e26dea203..2ec2dc1a1a73 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -92,6 +92,44 @@ struct module_signature {
 	uint32_t sig_len;    /* Length of signature data (big endian) */
 };
 
+static bool
+kmod_module_signature_info_default(const char *mem,
+				   off_t size,
+				   const struct module_signature *modsig,
+				   size_t sig_len,
+				   struct kmod_signature_info *sig_info)
+{
+	size -= sig_len;
+	sig_info->sig = mem + size;
+	sig_info->sig_len = sig_len;
+
+	size -= modsig->key_id_len;
+	sig_info->key_id = mem + size;
+	sig_info->key_id_len = modsig->key_id_len;
+
+	size -= modsig->signer_len;
+	sig_info->signer = mem + size;
+	sig_info->signer_len = modsig->signer_len;
+
+	sig_info->algo = pkey_algo[modsig->algo];
+	sig_info->hash_algo = pkey_hash_algo[modsig->hash];
+	sig_info->id_type = pkey_id_type[modsig->id_type];
+
+	return true;
+}
+
+static bool
+kmod_module_signature_info_pkcs7(const char *mem,
+				 off_t size,
+				 const struct module_signature *modsig,
+				 size_t sig_len,
+				 struct kmod_signature_info *sig_info)
+{
+	sig_info->hash_algo = "unknown";
+	sig_info->id_type = pkey_id_type[modsig->id_type];
+	return true;
+}
+
 #define SIG_MAGIC "~Module signature appended~\n"
 
 /*
@@ -111,7 +149,7 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
 	off_t size;
 	const struct module_signature *modsig;
 	size_t sig_len;
-
+	bool ret;
 
 	size = kmod_file_get_size(file);
 	mem = kmod_file_get_contents(file);
@@ -134,21 +172,16 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
 	    size < (int64_t)(modsig->signer_len + modsig->key_id_len + sig_len))
 		return false;
 
-	size -= sig_len;
-	sig_info->sig = mem + size;
-	sig_info->sig_len = sig_len;
-
-	size -= modsig->key_id_len;
-	sig_info->key_id = mem + size;
-	sig_info->key_id_len = modsig->key_id_len;
-
-	size -= modsig->signer_len;
-	sig_info->signer = mem + size;
-	sig_info->signer_len = modsig->signer_len;
-
-	sig_info->algo = pkey_algo[modsig->algo];
-	sig_info->hash_algo = pkey_hash_algo[modsig->hash];
-	sig_info->id_type = pkey_id_type[modsig->id_type];
-
-	return true;
+	switch (modsig->id_type) {
+	case PKEY_ID_PKCS7:
+		ret = kmod_module_signature_info_pkcs7(mem, size,
+						       modsig, sig_len,
+						       sig_info);
+		break;
+	default:
+		ret = kmod_module_signature_info_default(mem, size,
+							 modsig, sig_len,
+							 sig_info);
+	}
+	return ret;
 }
-- 
2.19.1

