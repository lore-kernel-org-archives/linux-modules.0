Return-Path: <SRS0=Vjph=OJ=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3219CC64EB4
	for <linux-modules@archiver.kernel.org>; Fri, 30 Nov 2018 20:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CF92082F
	for <linux-modules@archiver.kernel.org>; Fri, 30 Nov 2018 20:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPToJ2LL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CF92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeLAHwd (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:52:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45195 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLAHwc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 1 Dec 2018 02:52:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id v6so6469463wrr.12
        for <linux-modules@vger.kernel.org>; Fri, 30 Nov 2018 12:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4CUmMxMzRHCPH84VYX6+dW0KSc66wetzolUOTxRXz8=;
        b=hPToJ2LLOqQsaqJmkwKmz6mnqQQdd62SEfg7P0gI/zBCv5bKzCqEDo0V6wihEUZXOH
         TeyIa9/iXjC05cJ8sUnUi9LDccdiqMzIE+VfTkXYD4rpJKLgX1LeWlbOzWGP62YOG17z
         17s+kPjYFRHvXNG4k+yNE1NDFhOPNQwR1qu0RYwz4eXsG/K0IULtbSZV7emS3h3PFnrc
         yhF3nRwFkkgSq9hFwmAY5l+k53CzhIkLrpFZVwQvbobKzgbs8GmEHk8fFbkVW4RWCiWm
         1N9kifuq4UNqXGvwgmhFbB+oG9R3tW5htayI1zAw3llmyEMGlRF/e9xpGxwKhJkp0FMs
         7J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4CUmMxMzRHCPH84VYX6+dW0KSc66wetzolUOTxRXz8=;
        b=VdPUlCPVIf85hYp2fy1ekB69uCkZEAC73pOmXa9CBFgevCPGWJi9M303sibTUdd4SP
         R+OhAu53k0wWKbqt6wfb9ieHgkVdnOKIujecibDEelshpen/DgRmeL7uTZf1oFTs2J1y
         K6UUDnxxirT5lBE6EE6uBoFKBUOEFJAtquRnSx2eEzcWxosqyOuxHHPLGpUWbueOlMDS
         Yr5ugtox0C8Sqghdldwh4ahkqFLJbllSH1vY0fN5aTtpR40Tnm68Wvdq7CX5g6Z9dR4n
         8wHq/Vrlwycrl/GyFSjg4pf4RyDRZ85jSlXIzPj4QcBz42wG9RxsQsVj4spR4/GxFWsm
         tKLw==
X-Gm-Message-State: AA+aEWaU+N4pIbBdGaAT5x6FjT8O11K66UbqiVhFeLcBvCcIcHvnAQIF
        Gkyl+O4BTwOwVk/KLWX1+whqHxNuxQW6/HLCqQU=
X-Google-Smtp-Source: AFSGD/Ux6PrQ7U6Gqts1I2uaoymsP9Hx8nIXO7etkY6AOf6AnszdmLq+QItqllajAP1B9/u/xJplIpETPAbM8t8S6N4=
X-Received: by 2002:adf:b716:: with SMTP id l22mr6506965wre.186.1543610519713;
 Fri, 30 Nov 2018 12:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20181119135958.18318-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20181119135958.18318-1-yauheni.kaliuta@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 30 Nov 2018 12:41:48 -0800
Message-ID: <CAKi4VAKbkNqvg6xOyid5rNPCxYUcJgXpAGryjy=h3UdzcCJfLQ@mail.gmail.com>
Subject: Re: [PATCH RFC] libkmod-signature: implement pkcs7 parsing with gnutls
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>, ykaliuta@redhat.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Nov 19, 2018 at 6:00 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> The patch adds data fetching from the PKCS#7 certificate using
> gnutls library.
>
> In general the certificate can contain many signatures, but since
> kmod (modinfo) supports only one signature at the moment, only first
> one is taken.
>
> With the current sign-file.c certificate doesn't contain signer
> key's fingerprint, so "serial number" is used for the key id.
>
> gnutls has LGPL2.1 license, same as libkmod.

but... why are you adding both openssl and gnutls?

Lucas De Marchi

>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  Makefile.am                 |   4 +-
>  configure.ac                |  11 ++
>  libkmod/libkmod-internal.h  |   3 +
>  libkmod/libkmod-module.c    |   3 +
>  libkmod/libkmod-signature.c | 208 +++++++++++++++++++++++++++++++++++-
>  5 files changed, 224 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 194e1115ae70..2fd44fca69f2 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -35,6 +35,8 @@ SED_PROCESS = \
>         -e 's,@liblzma_LIBS\@,${liblzma_LIBS},g' \
>         -e 's,@zlib_CFLAGS\@,${zlib_CFLAGS},g' \
>         -e 's,@zlib_LIBS\@,${zlib_LIBS},g' \
> +       -e 's,@gnutls_CFLAGS\@,${gnutls_CFLAGS},g' \
> +       -e 's,@gnutls_LIBS\@,${gnutls_LIBS},g' \
>         < $< > $@ || rm $@
>
>  %.pc: %.pc.in Makefile
> @@ -87,7 +89,7 @@ libkmod_libkmod_la_DEPENDENCIES = \
>         ${top_srcdir}/libkmod/libkmod.sym
>  libkmod_libkmod_la_LIBADD = \
>         shared/libshared.la \
> -       ${liblzma_LIBS} ${zlib_LIBS}
> +       ${liblzma_LIBS} ${zlib_LIBS} ${gnutls_LIBS}
>
>  noinst_LTLIBRARIES += libkmod/libkmod-internal.la
>  libkmod_libkmod_internal_la_SOURCES = $(libkmod_libkmod_la_SOURCES)
> diff --git a/configure.ac b/configure.ac
> index fbc7391b2d1b..0a6787fa9a36 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -106,6 +106,17 @@ AS_IF([test "x$with_zlib" != "xno"], [
>  ])
>  CC_FEATURE_APPEND([with_features], [with_zlib], [ZLIB])
>
> +AC_ARG_WITH([gnutls],
> +       AS_HELP_STRING([--with-gnutls], [handle PKCS7 signatures @<:@default=disabled@:>@]),
> +       [], [with_gnutls=no])
> +AS_IF([test "x$with_gnutls" != "xno"], [
> +       PKG_CHECK_MODULES([gnutls], [gnutls])
> +       AC_DEFINE([ENABLE_GNUTLS], [1], [Enable gnutls for modinfo.])
> +], [
> +       AC_MSG_NOTICE([gnutls support not requested])
> +])
> +CC_FEATURE_APPEND([with_features], [with_gnutls], [GNUTLS])
> +
>  AC_ARG_WITH([bashcompletiondir],
>         AS_HELP_STRING([--with-bashcompletiondir=DIR], [Bash completions directory]),
>         [],
> diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
> index 346579c71aab..a65ddd156f18 100644
> --- a/libkmod/libkmod-internal.h
> +++ b/libkmod/libkmod-internal.h
> @@ -188,5 +188,8 @@ struct kmod_signature_info {
>         const char *algo, *hash_algo, *id_type;
>         const char *sig;
>         size_t sig_len;
> +       void (*free)(void *);
> +       void *private;
>  };
>  bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signature_info *sig_info) _must_check_ __attribute__((nonnull(1, 2)));
> +void kmod_module_signature_info_free(struct kmod_signature_info *sig_info) __attribute__((nonnull));
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 889f26479a98..bffe715cdef4 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -2357,6 +2357,9 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
>         ret = count;
>
>  list_error:
> +       /* aux structures freed in normal case also */
> +       kmod_module_signature_info_free(&sig_info);
> +
>         if (ret < 0) {
>                 kmod_module_info_free_list(*list);
>                 *list = NULL;
> diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
> index 429ffbd8a957..326fa2ea776a 100644
> --- a/libkmod/libkmod-signature.c
> +++ b/libkmod/libkmod-signature.c
> @@ -19,6 +19,9 @@
>
>  #include <endian.h>
>  #include <inttypes.h>
> +#ifdef ENABLE_GNUTLS
> +#include <gnutls/pkcs7.h>
> +#endif
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -92,6 +95,13 @@ struct module_signature {
>         uint32_t sig_len;    /* Length of signature data (big endian) */
>  };
>
> +static const char *pkey_hash_algo_to_str(enum pkey_hash_algo algo)
> +{
> +       if (algo < 0 || algo >= PKEY_HASH__LAST)
> +               return "unknown";
> +       return pkey_hash_algo[algo];
> +}
> +
>  static bool fill_default(const char *mem, off_t size,
>                          const struct module_signature *modsig, size_t sig_len,
>                          struct kmod_signature_info *sig_info)
> @@ -115,15 +125,199 @@ static bool fill_default(const char *mem, off_t size,
>         return true;
>  }
>
> -static bool fill_unknown(const char *mem, off_t size,
> -                        const struct module_signature *modsig, size_t sig_len,
> -                        struct kmod_signature_info *sig_info)
> +#ifdef ENABLE_GNUTLS
> +
> +struct pkcs7_private {
> +       gnutls_pkcs7_t pkcs7;
> +       gnutls_pkcs7_signature_info_st si;
> +       gnutls_x509_dn_t dn;
> +       gnutls_datum_t dn_data;
> +       char *issuer;
> +};
> +
> +static void pkcs7_free(void *s)
> +{
> +       struct kmod_signature_info *si = s;
> +       struct pkcs7_private *pvt = si->private;
> +
> +       free(pvt->issuer);
> +       gnutls_free(pvt->dn_data.data);
> +       gnutls_x509_dn_deinit(pvt->dn);
> +       gnutls_pkcs7_signature_info_deinit(&pvt->si);
> +       gnutls_pkcs7_deinit(pvt->pkcs7);
> +
> +       free(pvt);
> +       si->private = NULL;
> +}
> +
> +static int gnutls_algo_translate(gnutls_sign_algorithm_t algo)
> +{
> +       switch (algo) {
> +       case GNUTLS_SIGN_RSA_SHA1:
> +       case GNUTLS_SIGN_DSA_SHA1:
> +       case GNUTLS_SIGN_ECDSA_SHA1:
> +               return PKEY_HASH_SHA1;
> +       case GNUTLS_SIGN_RSA_MD5:
> +               return PKEY_HASH_MD5;
> +       case GNUTLS_SIGN_RSA_RMD160:
> +               return PKEY_HASH_RIPE_MD_160;
> +       case GNUTLS_SIGN_RSA_SHA256:
> +       case GNUTLS_SIGN_DSA_SHA256:
> +       case GNUTLS_SIGN_ECDSA_SHA256:
> +               return PKEY_HASH_SHA256;
> +       case GNUTLS_SIGN_RSA_SHA384:
> +       case GNUTLS_SIGN_ECDSA_SHA384:
> +       case GNUTLS_SIGN_DSA_SHA384:
> +               return PKEY_HASH_SHA384;
> +       case GNUTLS_SIGN_RSA_SHA512:
> +       case GNUTLS_SIGN_ECDSA_SHA512:
> +       case GNUTLS_SIGN_DSA_SHA512:
> +               return PKEY_HASH_SHA512;
> +       case GNUTLS_SIGN_RSA_SHA224:
> +       case GNUTLS_SIGN_DSA_SHA224:
> +       case GNUTLS_SIGN_ECDSA_SHA224:
> +               return PKEY_HASH_SHA224;
> +       default:
> +               return -1;
> +       }
> +       return -1;
> +}
> +
> +/*
> + * Extracts CN from O=Org,CN=CommonName,EMAIL=email
> + */
> +static char *dn_str_to_cn(unsigned char *dn)
> +{
> +       char *s;
> +       char *e;
> +       char *r;
> +       size_t len;
> +
> +       s = strstr((char *)dn, "CN=");
> +       if (s == NULL)
> +               return NULL;
> +
> +       len = strlen(s);
> +       if (len < strlen("CN=") + 1) /* at least one symbol */
> +               return NULL;
> +       s += strlen("CN=");
> +
> +       e = strchr(s, ',');
> +       if (e == NULL)
> +               e = s + len;
> +       len = e - s;
> +
> +       r = malloc(len + 1);
> +       if (r == NULL)
> +               return NULL;
> +
> +       memcpy(r, s, len);
> +       r[len] = '\0';
> +       return r;
> +}
> +static bool fill_pkcs7(const char *mem, off_t size,
> +                      const struct module_signature *modsig, size_t sig_len,
> +                      struct kmod_signature_info *sig_info)
> +{
> +       int rc;
> +       const char *pkcs7_raw;
> +       gnutls_pkcs7_t pkcs7;
> +       gnutls_datum_t data;
> +       gnutls_pkcs7_signature_info_st si;
> +       gnutls_x509_dn_t dn;
> +       struct pkcs7_private *pvt;
> +       char *issuer;
> +
> +       size -= sig_len;
> +       pkcs7_raw = mem + size;
> +
> +       rc = gnutls_pkcs7_init(&pkcs7);
> +       if (rc < 0)
> +               return false;
> +
> +       data.data = (unsigned char *)pkcs7_raw;
> +       data.size = sig_len;
> +       rc = gnutls_pkcs7_import(pkcs7, &data, GNUTLS_X509_FMT_DER);
> +       if (rc < 0)
> +               goto err1;
> +
> +       rc = gnutls_pkcs7_get_signature_info(pkcs7, 0, &si);
> +       if (rc < 0)
> +               goto err1;
> +
> +       rc = gnutls_x509_dn_init(&dn);
> +       if (rc < 0)
> +               goto err2;
> +
> +       rc = gnutls_x509_dn_import(dn, &si.issuer_dn);
> +       if (rc < 0)
> +               goto err3;
> +
> +       /*
> +        * I could not find simple wrapper to extract the data
> +        * directly from ASN1, so get the string and parse it.
> +        *
> +        * Returns null-terminated string in data.data
> +        */
> +       rc = gnutls_x509_dn_get_str(dn, &data);
> +       if (rc < 0)
> +               goto err3;
> +
> +       sig_info->sig = (const char *)si.sig.data;
> +       sig_info->sig_len = si.sig.size;
> +
> +       sig_info->key_id = (const char *)si.signer_serial.data;
> +       sig_info->key_id_len = si.signer_serial.size;
> +
> +       issuer = dn_str_to_cn(data.data);
> +       if (issuer != NULL) {
> +               sig_info->signer = issuer;
> +               sig_info->signer_len = strlen(issuer);
> +       }
> +
> +       sig_info->hash_algo = pkey_hash_algo_to_str(gnutls_algo_translate(si.algo));
> +       sig_info->id_type = pkey_id_type[modsig->id_type];
> +
> +       pvt = malloc(sizeof(*pvt));
> +       if (pvt == NULL)
> +               goto err4;
> +
> +       pvt->pkcs7 = pkcs7;
> +       pvt->si = si;
> +       pvt->dn = dn;
> +       pvt->dn_data = data;
> +       pvt->issuer = issuer;
> +
> +       sig_info->private = pvt;
> +       sig_info->free = pkcs7_free;
> +
> +       return true;
> +
> +err4:
> +       gnutls_free(data.data);
> +err3:
> +       gnutls_x509_dn_deinit(dn);
> +err2:
> +       gnutls_pkcs7_signature_info_deinit(&si);
> +err1:
> +       gnutls_pkcs7_deinit(pkcs7);
> +
> +       return false;
> +}
> +
> +#else /* ENABLE GNUTLS */
> +
> +static bool fill_pkcs7(const char *mem, off_t size,
> +                      const struct module_signature *modsig, size_t sig_len,
> +                      struct kmod_signature_info *sig_info)
>  {
>         sig_info->hash_algo = "unknown";
>         sig_info->id_type = pkey_id_type[modsig->id_type];
>         return true;
>  }
>
> +#endif /* ENABLE GNUTLS */
> +
>  #define SIG_MAGIC "~Module signature appended~\n"
>
>  /*
> @@ -167,8 +361,14 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
>
>         switch (modsig->id_type) {
>         case PKEY_ID_PKCS7:
> -               return fill_unknown(mem, size, modsig, sig_len, sig_info);
> +               return fill_pkcs7(mem, size, modsig, sig_len, sig_info);
>         default:
>                 return fill_default(mem, size, modsig, sig_len, sig_info);
>         }
>  }
> +
> +void kmod_module_signature_info_free(struct kmod_signature_info *sig_info)
> +{
> +       if (sig_info->free)
> +               sig_info->free(sig_info);
> +}
> --
> 2.19.1
>


-- 
Lucas De Marchi
