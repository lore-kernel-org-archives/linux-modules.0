Return-Path: <SRS0=iAAw=QU=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9CFC282CE
	for <linux-modules@archiver.kernel.org>; Wed, 13 Feb 2019 17:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4A32086C
	for <linux-modules@archiver.kernel.org>; Wed, 13 Feb 2019 17:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ+FeJSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391415AbfBMRxj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:53:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50947 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391376AbfBMRxj (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 13 Feb 2019 12:53:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id x7so3495217wmj.0
        for <linux-modules@vger.kernel.org>; Wed, 13 Feb 2019 09:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pYe0Cx/lQkULIk+a1kyMLus6deM++xihuy58GtfwkM=;
        b=EQ+FeJSdpS25BbOP9iO3A4RUyS0em869yYWdd44mltwvua0eIafdnZD5p1a71y6uFS
         Pyr0b+At5DlcF8HYta0YxbvMPUApoflVj6YdzUGYgq7EbTtqfDJBawWgFRa2y8jZwypw
         yBsShCv/FpP2ow2ylgWio0e1n+BoWXxEJ/Km03vMJgOX0dvxD/goTb6IKEwZS1jgkNhY
         staMzL1qOGxmcjHxU1HGAK6ER1wDp6DnynHQJFPikJ6HGODfYt2EpJPjDFzFhHvn9LOF
         6e9n5FXHj478Vk1qwIDo5/Z47p6XaU271/RrOVQiAOHfQhTRbwuPPEVLibOWR5IEZ+JT
         nS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pYe0Cx/lQkULIk+a1kyMLus6deM++xihuy58GtfwkM=;
        b=jRff6JcwGH7EygbeFMgIbZPwdL4bwIR45LNdbCPezb91wHrtmQbxxZ8kDLr4J6zYSL
         tXtoHLddPrpW+lMGrnC+885EvuthHihy4xeP3j6s4sT89MzFwbjIF/tKbA/0uqsSEZC5
         zFKoRVRDz4S6VNnlsTLGF6B4Oux9reMlfZLa86y8Z4eKoaw4XhmWGLRpIOmWLP2MI3gj
         ZFfcjHzgLwP/vcfEQemtgL2p7cD7qCIC9DMWOSbq72FzixAgQkuwQzdK5T+rEwQzYER7
         FJMGvFhijjq39DKZ4cfXFuGa1fuzJecq962LylBUvzvvMlJsDlcNK1J/Xy77pvi+MM7c
         541g==
X-Gm-Message-State: AHQUAua1PVu/EMlB/oPmMmTQQ1xnCi/kw//A4Eh+ulOWfyO3kLQ5nm7K
        D++fEeBKtwu7Gc6HaPMm3++CMPX3TdXci6MiWjECxuG4
X-Google-Smtp-Source: AHgI3IZquMNyQpRAI1w1eHy50jOZHqk2BDvrUrhw39RJY6ZPicCmfsyapE9OKLmiqw6MDUIVCSPhZA1ec3MfC6i89b4=
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr1198461wme.119.1550080417149;
 Wed, 13 Feb 2019 09:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20190213152751.9138-1-dreisner@archlinux.org>
In-Reply-To: <20190213152751.9138-1-dreisner@archlinux.org>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Wed, 13 Feb 2019 09:53:25 -0800
Message-ID: <CAKi4VAJeM2yiMbkxqMs8DQ1gzpiVfdF8GYpEmFog=nTMEgvHUw@mail.gmail.com>
Subject: Re: [PATCH] Link against libcrypto, not all of openssl
To:     Dave Reisner <dreisner@archlinux.org>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 13, 2019 at 8:02 AM Dave Reisner <dreisner@archlinux.org> wrote:
>
> In the previous build setup, libkmod.so would link to not just
> libcrypto.so, but also libssl.so:
>
> $ readelf -d /lib/libkmod.so | grep NEEDED
>  0x0000000000000001 (NEEDED)             Shared library: [liblzma.so.5]
>  0x0000000000000001 (NEEDED)             Shared library: [libz.so.1]
>  0x0000000000000001 (NEEDED)             Shared library: [libssl.so.1.1]
>  0x0000000000000001 (NEEDED)             Shared library: [libcrypto.so.1.1]
>  0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
>
> We don't need any symbols from libssl, though. This patch ensures that
> we pass 'libcrypto' to pkgconfig rather than 'openssl', getting only the
> library that we need:
>
> $ readelf -d tools/kmod | grep NEEDED

as per chat on irc, I updated the commit message to point to libkmod
rather than kmod.

Patch applied, thanks.

Lucas De Marchi

>  0x0000000000000001 (NEEDED)             Shared library: [liblzma.so.5]
>  0x0000000000000001 (NEEDED)             Shared library: [libz.so.1]
>  0x0000000000000001 (NEEDED)             Shared library: [libcrypto.so.1.1]
>  0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
> ---
>  Makefile.am  | 6 +++---
>  configure.ac | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index ddb25f0..758f4f0 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -35,8 +35,8 @@ SED_PROCESS = \
>         -e 's,@liblzma_LIBS\@,${liblzma_LIBS},g' \
>         -e 's,@zlib_CFLAGS\@,${zlib_CFLAGS},g' \
>         -e 's,@zlib_LIBS\@,${zlib_LIBS},g' \
> -       -e 's,@openssl_CFLAGS\@,${openssl_CFLAGS},g' \
> -       -e 's,@openssl_LIBS\@,${openssl_LIBS},g' \
> +       -e 's,@libcrypto_CFLAGS\@,${libcrypto_CFLAGS},g' \
> +       -e 's,@libcrypto_LIBS\@,${libcrypto_LIBS},g' \
>         < $< > $@ || rm $@
>
>  %.pc: %.pc.in Makefile
> @@ -89,7 +89,7 @@ libkmod_libkmod_la_DEPENDENCIES = \
>         ${top_srcdir}/libkmod/libkmod.sym
>  libkmod_libkmod_la_LIBADD = \
>         shared/libshared.la \
> -       ${liblzma_LIBS} ${zlib_LIBS} ${openssl_LIBS}
> +       ${liblzma_LIBS} ${zlib_LIBS} ${libcrypto_LIBS}
>
>  noinst_LTLIBRARIES += libkmod/libkmod-internal.la
>  libkmod_libkmod_internal_la_SOURCES = $(libkmod_libkmod_la_SOURCES)
> diff --git a/configure.ac b/configure.ac
> index ee72283..dffe278 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -110,12 +110,12 @@ AC_ARG_WITH([openssl],
>         AS_HELP_STRING([--with-openssl], [handle PKCS7 signatures @<:@default=disabled@:>@]),
>         [], [with_openssl=no])
>  AS_IF([test "x$with_openssl" != "xno"], [
> -       PKG_CHECK_MODULES([openssl], [openssl >= 1.1.0])
> +       PKG_CHECK_MODULES([libcrypto], [libcrypto >= 1.1.0])
>         AC_DEFINE([ENABLE_OPENSSL], [1], [Enable openssl for modinfo.])
>  ], [
>         AC_MSG_NOTICE([openssl support not requested])
>  ])
> -CC_FEATURE_APPEND([with_features], [with_openssl], [OPENSSL])
> +CC_FEATURE_APPEND([with_features], [with_openssl], [LIBCRYPTO])
>
>  AC_ARG_WITH([bashcompletiondir],
>         AS_HELP_STRING([--with-bashcompletiondir=DIR], [Bash completions directory]),
> --
> 2.20.1



-- 
Lucas De Marchi
