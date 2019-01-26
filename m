Return-Path: <SRS0=qw0B=QC=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A64AC282C7
	for <linux-modules@archiver.kernel.org>; Sat, 26 Jan 2019 11:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB83217D7
	for <linux-modules@archiver.kernel.org>; Sat, 26 Jan 2019 11:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAZLBx (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 26 Jan 2019 06:01:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfAZLBx (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 26 Jan 2019 06:01:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9741B8666D;
        Sat, 26 Jan 2019 11:01:52 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-117-34.ams2.redhat.com [10.36.117.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35F5B608C7;
        Sat, 26 Jan 2019 11:01:51 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>, ykaliuta@redhat.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH kmod] libkmod-signature: implement pkcs7 parsing with openssl
References: <20190125133808.27363-1-yauheni.kaliuta@redhat.com>
        <CAKi4VA+Zy==+=UzzghN261tcukcPBd0B5dyTjNXbCTEYyXyY5A@mail.gmail.com>
Date:   Sat, 26 Jan 2019 13:01:51 +0200
In-Reply-To: <CAKi4VA+Zy==+=UzzghN261tcukcPBd0B5dyTjNXbCTEYyXyY5A@mail.gmail.com>
        (Lucas De Marchi's message of "Fri, 25 Jan 2019 10:33:44 -0800")
Message-ID: <xunyk1ir8yxs.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sat, 26 Jan 2019 11:01:52 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Fri, 25 Jan 2019 10:33:44 -0800, Lucas De Marchi  wrote:

 > On Fri, Jan 25, 2019 at 5:39 AM Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:

[...]

 >> +
 >> +static bool fill_pkcs7(const char *mem, off_t size,
 >> +                      const struct module_signature *modsig, size_t sig_len,
 >> +                      struct kmod_signature_info *sig_info)
 >> +{
 >> +       const char *pkcs7_raw;
 >> +       CMS_ContentInfo *cms;
 >> +       STACK_OF(CMS_SignerInfo) *sis;
 >> +       CMS_SignerInfo *si;
 >> +       int rc;
 >> +       ASN1_OCTET_STRING *key_id;
 >> +       X509_NAME *issuer;
 >> +       ASN1_INTEGER *sno;
 >> +       ASN1_OCTET_STRING *sig;
 >> +       BIGNUM *sno_bn;
 >> +       X509_ALGOR *dig_alg;
 >> +       X509_ALGOR *sig_alg;
 >> +       const ASN1_OBJECT *o;
 >> +       BIO *in;
 >> +       int len;
 >> +       unsigned char *key_id_str;
 >> +       struct pkcs7_private *pvt;
 >> +       const char *issuer_str;
 >> +
 >> +       size -= sig_len;
 >> +       pkcs7_raw = mem + size;
 >> +
 >> +       in = BIO_new_mem_buf(pkcs7_raw, sig_len);
 >> +
 >> +       cms = d2i_CMS_bio(in, NULL);
 >> +       if (cms == NULL) {
 >> +               BIO_free(in);

 > _cleanup_() on `in` would make this neater. Same for all variables in
 > err, err2, err3, etc.
 > Just remember to set it to NULL on !error-path.

You mean

pvt->key_id = key_id_str;
key_id_str = NULL;

?

not sure that it is neater, but I can do it.

 >> +               return false;
 >> +       }
 >> +
 >> +       BIO_free(in);
 >> +
 >> +       sis = CMS_get0_SignerInfos(cms);
 >> +       if (sis == NULL)
 >> +               goto err;
 >> +
 >> +       si = sk_CMS_SignerInfo_value(sis, 0);
 >> +       if (si == NULL)
 >> +               goto err;
 >> +
 >> +       rc = CMS_SignerInfo_get0_signer_id(si, &key_id, &issuer, &sno);
 >> +       if (rc == 0)
 >> +               goto err;
 >> +
 >> +       sig = CMS_SignerInfo_get0_signature(si);
 >> +       if (sig == NULL)
 >> +               goto err;
 >> +
 >> +       CMS_SignerInfo_get0_algs(si, NULL, NULL, &dig_alg, &sig_alg);
 >> +
 >> +       sig_info->sig = (const char *)ASN1_STRING_get0_data(sig);
 >> +       sig_info->sig_len = ASN1_STRING_length(sig);
 >> +
 >> +       sno_bn = ASN1_INTEGER_to_BN(sno, NULL);
 >> +       if (sno_bn == NULL)
 >> +               goto err;
 >> +
 >> +       len = BN_num_bytes(sno_bn);
 >> +       key_id_str = malloc(len);
 >> +       if (key_id_str == NULL)
 >> +               goto err2;
 >> +       BN_bn2bin(sno_bn, key_id_str);
 >> +
 >> +       sig_info->key_id = (const char *)key_id_str;
 >> +       sig_info->key_id_len = len;
 >> +
 >> +       issuer_str = x509_name_to_str(issuer);
 >> +       if (issuer_str != NULL) {
 >> +               sig_info->signer = issuer_str;
 >> +               sig_info->signer_len = strlen(issuer_str);
 >> +       }
 >> +
 >> +       X509_ALGOR_get0(&o, NULL, NULL, dig_alg);
 >> +
 >> +       sig_info->hash_algo = pkey_hash_algo[obj_to_hash_algo(o)];
 >> +       sig_info->id_type = pkey_id_type[modsig->id_type];
 >> +
 >> +       pvt = malloc(sizeof(*pvt));
 >> +       if (pvt == NULL)
 >> +               goto err3;
 >> +
 >> +       pvt->cms = cms;
 >> +       pvt->key_id = key_id_str;
 >> +       pvt->sno = sno_bn;
 >> +       sig_info->private = pvt;

 > why do you keep pvt around if the only thing you will do with
 > it later is to free it?
 > AFAICS the only thing that needs to remain around is the str
 > so we can free it after the user used it (because normal
 > signature is backed in memory by the mem object, while these
 > are openssl structs)

I should keep them until kmod_module_get_info() makes the copies.

cms is openssl struct
sno_bn is allocated by openssl and must be freed later
key_id_str is allocated here since the size in unknown in advance
and must be freed later.

Or what did I miss?

 > I miss a simple module in the testsuite to make sure this is
 > working.

I'll think what can I do.

 > thanks
 > Lucas De Marchi

 >> +
 >> +       sig_info->free = pkcs7_free;
 >> +
 >> +       return true;
 >> +err3:
 >> +       free(key_id_str);
 >> +err2:
 >> +       BN_free(sno_bn);
 >> +err:
 >> +       CMS_ContentInfo_free(cms);
 >> +       return false;
 >> +}
 >> +
 >> +#else /* ENABLE OPENSSL */
 >> +
 >> +static bool fill_pkcs7(const char *mem, off_t size,
 >> +                      const struct module_signature *modsig, size_t sig_len,
 >> +                      struct kmod_signature_info *sig_info)
 >> {
 sig_info-> hash_algo = "unknown";
 sig_info-> id_type = pkey_id_type[modsig->id_type];
 >> return true;
 >> }
 >> 
 >> +#endif /* ENABLE OPENSSL */
 >> +
 >> #define SIG_MAGIC "~Module signature appended~\n"
 >> 
 >> /*
 >> @@ -167,8 +350,14 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
 >> 
 >> switch (modsig->id_type) {
 >> case PKEY_ID_PKCS7:
 >> -               return fill_unknown(mem, size, modsig, sig_len, sig_info);
 >> +               return fill_pkcs7(mem, size, modsig, sig_len, sig_info);
 >> default:
 >> return fill_default(mem, size, modsig, sig_len, sig_info);
 >> }
 >> }
 >> +
 >> +void kmod_module_signature_info_free(struct kmod_signature_info *sig_info)
 >> +{
 >> +       if (sig_info->free)
 >> +               sig_info->free(sig_info);
 >> +}
 >> --
 >> 2.20.1
 >> 


 > -- 
 > Lucas De Marchi

-- 
WBR,
Yauheni Kaliuta
