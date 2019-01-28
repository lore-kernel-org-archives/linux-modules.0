Return-Path: <SRS0=oa2h=QE=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D68EC282CD
	for <linux-modules@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FD72148E
	for <linux-modules@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7sb1fS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfA1SFj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:05:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38285 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfA1SFj (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 28 Jan 2019 13:05:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so15018435wml.3
        for <linux-modules@vger.kernel.org>; Mon, 28 Jan 2019 10:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kaZohd+tkzOR5rqBOjAxYnwK+Ryml8fEinTnl0qHF68=;
        b=G7sb1fS2HbjLqwdfGIGW+JSVvnPxsI8rGvR0kbUI6qSDJhcwQZXFIqx7mKe8gp9BfS
         e6ccekACvI5HimeC/fIzRh9bnwRI1JIAPNlflfE8Gy5NfE4l4/+1agj4yFSCdeyEwoWD
         8ydsa/VI3Pgtxjqw9+kk7y1sy7ysnWpW3kt/fsgeEsyBrPXLBGqVe4RBJawpnmQ3qKkC
         2h7mRF25GmSZkqYx/jBF96gt9bVMfA+cMC6DK2QkESP8Bi6efzVWwK66E7nL+p4BeeJj
         bwJXFEGqilEEjDZkRt4ZG0wvcLc0mdXjDiDGMHlfB5o6gai7Jcu3i0crwDQSi5rv3fgm
         NOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaZohd+tkzOR5rqBOjAxYnwK+Ryml8fEinTnl0qHF68=;
        b=TG0gekiW/oFAuTOinE6HsPvkEMAgp/0XYu7wQh/iRIqZfoMJNP6XTK9E5n0WbJmxDg
         DZwVAjJHPyvBSXz06Nxfy00VHbFbXYtyblUgFqmxS/yqrV/7B7UIDmkgt1uZGKgvXitp
         so4d0YMvzFOeVh6RHOelazpUp1TKaP2qLN9iKa0OUA++pWgXf46AJrpX5IA7hRHrlCap
         RjcvyIXuJO3BiiRRGxp4wYLqQ7mzec4doqCeVXc2gvqE8vtmpvhtXSLGV/e9I2lVILQs
         1mA8X+cXCZfriy28uEBzCWoWA+LscOIron8dXSb8XrfG3PRNQQGHziEbPP2fFy+jSj3U
         z1zQ==
X-Gm-Message-State: AJcUukcvC7zrIkazMM2Q01WhY3B0809/7nB6Xe8mPTC3/4kwu5atYbVM
        AFwe4XVq9wGxtZ4eV0vFZeQUjV47r65clBrOw/A=
X-Google-Smtp-Source: ALg8bN6LMeIl0GpaxQFvWDNnFoJSjG+F8Q4bMxzzjuFEmOlUoPo+N9mzj8mc5dSiRAi2AhZobmbKeWEGCT0q+6aSwqY=
X-Received: by 2002:a1c:a4c4:: with SMTP id n187mr18190329wme.15.1548698736549;
 Mon, 28 Jan 2019 10:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20190125133808.27363-1-yauheni.kaliuta@redhat.com>
 <CAKi4VA+Zy==+=UzzghN261tcukcPBd0B5dyTjNXbCTEYyXyY5A@mail.gmail.com> <xunyk1ir8yxs.fsf@redhat.com>
In-Reply-To: <xunyk1ir8yxs.fsf@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 28 Jan 2019 10:05:24 -0800
Message-ID: <CAKi4VA+YGwBqg6kDb9mrgxqm7X4UCQD-Tu9PqXhm6bbRrG5Uaw@mail.gmail.com>
Subject: Re: [PATCH kmod] libkmod-signature: implement pkcs7 parsing with openssl
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>, ykaliuta@redhat.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat, Jan 26, 2019 at 3:01 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Lucas!
>
> >>>>> On Fri, 25 Jan 2019 10:33:44 -0800, Lucas De Marchi  wrote:
>
>  > On Fri, Jan 25, 2019 at 5:39 AM Yauheni Kaliuta
>  > <yauheni.kaliuta@redhat.com> wrote:
>
> [...]
>
>  >> +
>  >> +static bool fill_pkcs7(const char *mem, off_t size,
>  >> +                      const struct module_signature *modsig, size_t sig_len,
>  >> +                      struct kmod_signature_info *sig_info)
>  >> +{
>  >> +       const char *pkcs7_raw;
>  >> +       CMS_ContentInfo *cms;
>  >> +       STACK_OF(CMS_SignerInfo) *sis;
>  >> +       CMS_SignerInfo *si;
>  >> +       int rc;
>  >> +       ASN1_OCTET_STRING *key_id;
>  >> +       X509_NAME *issuer;
>  >> +       ASN1_INTEGER *sno;
>  >> +       ASN1_OCTET_STRING *sig;
>  >> +       BIGNUM *sno_bn;
>  >> +       X509_ALGOR *dig_alg;
>  >> +       X509_ALGOR *sig_alg;
>  >> +       const ASN1_OBJECT *o;
>  >> +       BIO *in;
>  >> +       int len;
>  >> +       unsigned char *key_id_str;
>  >> +       struct pkcs7_private *pvt;
>  >> +       const char *issuer_str;
>  >> +
>  >> +       size -= sig_len;
>  >> +       pkcs7_raw = mem + size;
>  >> +
>  >> +       in = BIO_new_mem_buf(pkcs7_raw, sig_len);
>  >> +
>  >> +       cms = d2i_CMS_bio(in, NULL);
>  >> +       if (cms == NULL) {
>  >> +               BIO_free(in);
>
>  > _cleanup_() on `in` would make this neater. Same for all variables in
>  > err, err2, err3, etc.
>  > Just remember to set it to NULL on !error-path.
>
> You mean
>
> pvt->key_id = key_id_str;
> key_id_str = NULL;
>
> ?
>
> not sure that it is neater, but I can do it.

The assignment to NULL should be in the one place it exits the
function successfully.

>
>  >> +               return false;
>  >> +       }
>  >> +
>  >> +       BIO_free(in);
>  >> +
>  >> +       sis = CMS_get0_SignerInfos(cms);
>  >> +       if (sis == NULL)
>  >> +               goto err;
>  >> +
>  >> +       si = sk_CMS_SignerInfo_value(sis, 0);
>  >> +       if (si == NULL)
>  >> +               goto err;
>  >> +
>  >> +       rc = CMS_SignerInfo_get0_signer_id(si, &key_id, &issuer, &sno);
>  >> +       if (rc == 0)
>  >> +               goto err;
>  >> +
>  >> +       sig = CMS_SignerInfo_get0_signature(si);
>  >> +       if (sig == NULL)
>  >> +               goto err;
>  >> +
>  >> +       CMS_SignerInfo_get0_algs(si, NULL, NULL, &dig_alg, &sig_alg);
>  >> +
>  >> +       sig_info->sig = (const char *)ASN1_STRING_get0_data(sig);
>  >> +       sig_info->sig_len = ASN1_STRING_length(sig);
>  >> +
>  >> +       sno_bn = ASN1_INTEGER_to_BN(sno, NULL);
>  >> +       if (sno_bn == NULL)
>  >> +               goto err;
>  >> +
>  >> +       len = BN_num_bytes(sno_bn);
>  >> +       key_id_str = malloc(len);
>  >> +       if (key_id_str == NULL)
>  >> +               goto err2;
>  >> +       BN_bn2bin(sno_bn, key_id_str);
>  >> +
>  >> +       sig_info->key_id = (const char *)key_id_str;
>  >> +       sig_info->key_id_len = len;
>  >> +
>  >> +       issuer_str = x509_name_to_str(issuer);
>  >> +       if (issuer_str != NULL) {
>  >> +               sig_info->signer = issuer_str;
>  >> +               sig_info->signer_len = strlen(issuer_str);
>  >> +       }
>  >> +
>  >> +       X509_ALGOR_get0(&o, NULL, NULL, dig_alg);
>  >> +
>  >> +       sig_info->hash_algo = pkey_hash_algo[obj_to_hash_algo(o)];
>  >> +       sig_info->id_type = pkey_id_type[modsig->id_type];
>  >> +
>  >> +       pvt = malloc(sizeof(*pvt));
>  >> +       if (pvt == NULL)
>  >> +               goto err3;
>  >> +
>  >> +       pvt->cms = cms;
>  >> +       pvt->key_id = key_id_str;
>  >> +       pvt->sno = sno_bn;
>  >> +       sig_info->private = pvt;
>
>  > why do you keep pvt around if the only thing you will do with
>  > it later is to free it?
>  > AFAICS the only thing that needs to remain around is the str
>  > so we can free it after the user used it (because normal
>  > signature is backed in memory by the mem object, while these
>  > are openssl structs)
>
> I should keep them until kmod_module_get_info() makes the copies.
>
> cms is openssl struct
> sno_bn is allocated by openssl and must be freed later
> key_id_str is allocated here since the size in unknown in advance
> and must be freed later.
>
> Or what did I miss?

we could just duplicate the information that we want stored and keep
the openssl context contained
to just this function. I thought the only one would be key_str_id, but
missed that sig and signer
also need to have their backing object around.

Lucas De Marchi
>
>  > I miss a simple module in the testsuite to make sure this is
>  > working.
>
> I'll think what can I do.
>
>  > thanks
>  > Lucas De Marchi
>
>  >> +
>  >> +       sig_info->free = pkcs7_free;
>  >> +
>  >> +       return true;
>  >> +err3:
>  >> +       free(key_id_str);
>  >> +err2:
>  >> +       BN_free(sno_bn);
>  >> +err:
>  >> +       CMS_ContentInfo_free(cms);
>  >> +       return false;
>  >> +}
>  >> +
>  >> +#else /* ENABLE OPENSSL */
>  >> +
>  >> +static bool fill_pkcs7(const char *mem, off_t size,
>  >> +                      const struct module_signature *modsig, size_t sig_len,
>  >> +                      struct kmod_signature_info *sig_info)
>  >> {
>  sig_info-> hash_algo = "unknown";
>  sig_info-> id_type = pkey_id_type[modsig->id_type];
>  >> return true;
>  >> }
>  >>
>  >> +#endif /* ENABLE OPENSSL */
>  >> +
>  >> #define SIG_MAGIC "~Module signature appended~\n"
>  >>
>  >> /*
>  >> @@ -167,8 +350,14 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
>  >>
>  >> switch (modsig->id_type) {
>  >> case PKEY_ID_PKCS7:
>  >> -               return fill_unknown(mem, size, modsig, sig_len, sig_info);
>  >> +               return fill_pkcs7(mem, size, modsig, sig_len, sig_info);
>  >> default:
>  >> return fill_default(mem, size, modsig, sig_len, sig_info);
>  >> }
>  >> }
>  >> +
>  >> +void kmod_module_signature_info_free(struct kmod_signature_info *sig_info)
>  >> +{
>  >> +       if (sig_info->free)
>  >> +               sig_info->free(sig_info);
>  >> +}
>  >> --
>  >> 2.20.1
>  >>
>
>
>  > --
>  > Lucas De Marchi
>
> --
> WBR,
> Yauheni Kaliuta



-- 
Lucas De Marchi
