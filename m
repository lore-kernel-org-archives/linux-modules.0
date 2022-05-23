Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A43C433EF
	for <linux-modules@archiver.kernel.org>; Mon, 23 May 2022 21:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiEWVEU (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 23 May 2022 17:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiEWVET (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 23 May 2022 17:04:19 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E16C0EA
        for <linux-modules@vger.kernel.org>; Mon, 23 May 2022 14:04:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j10so4177602lfe.12
        for <linux-modules@vger.kernel.org>; Mon, 23 May 2022 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOT6/IEEvL647FHmiCg7MRICtIFsZAtUMIfvYbPx3SA=;
        b=TB/AO84lC0LITUBGehrw8rhOuiDSejBSA9Qz+lEc73w+ju8dHPmXn5PMLWT3SRdJrU
         suS0JTx8GWUPOYH/AS5OeqGcjMJNPJXACAtcFXCFsCXYe6Wbnv4pDhnB44c73UUzHCQ0
         PeCR2iNZ4GvbK+YZKJ3VW+i/zlDerIASKR9O3+qm/zq5vRzAmqvEVuPlRypYI/469BWA
         EN03DN0SpFnK9+5MrULChGKPma7zq6vsVSYZroWCVM3zKA5Mx1xJRPnT8a7cmvOAag+4
         ZdTyJdVFRW+/HnPRZy9TJdVxANnzklWvZyv8mPVgMxt+deT1r5U3HKxECduTDfkAer/M
         Q71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOT6/IEEvL647FHmiCg7MRICtIFsZAtUMIfvYbPx3SA=;
        b=rte5Yzm8got4bxK2ewR3dwGIAGQEaodi/+erlvkzBlGvHB0n4ZA7s8noah8JvEMzKI
         /IVVxhidoB2eFrnlR2FiHiPZU4f87LWgSDCpPdwefdBb8GrIuFYJTKyRQHEDc5MvZYDR
         XFApAtXsZgusYPwPQnIEFUsJvtpAT44IiAWTzuwrSEYZvmHBWWoyllj7JNCevASJGwhk
         EoJcaKEZ+b4SXK+vcd+RilOZDAq0nadp6J4QRNQe1yIbBWFi0C2CMHQ8bueCfqLXyBce
         tRl862XPLR2Jz9O0qzqk/po0cNSkxGLVtQaUce44I89sIMc6KkqU0udWQ/D1j8d/JjMy
         SUaA==
X-Gm-Message-State: AOAM530cSUAwtWC3JRxzt1S0fVfg7/01VviPJmtnpqSIizrozIHYlsHU
        LVGwB/ivLmTcI2xmCzL6FWjGRp6ug80ovoZCjiWybQ==
X-Google-Smtp-Source: ABdhPJwiiG4XoO6s8TxJDH+8amPPG6CcR3JcQv0U+ZDwF04t01N4pXb7x0yQtfESBBKBxKqDAER8pmvL0qGIg+evkxM=
X-Received: by 2002:a05:6512:48e:b0:477:c024:1a1c with SMTP id
 v14-20020a056512048e00b00477c0241a1cmr17906274lfq.100.1653339855792; Mon, 23
 May 2022 14:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220522160117.599023-1-masahiroy@kernel.org>
In-Reply-To: <20220522160117.599023-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 May 2022 14:04:04 -0700
Message-ID: <CAKwvOdnTFvDKDr_tr5digM1HguSQw65Eq+TT=mhr_AUcVGVLpQ@mail.gmail.com>
Subject: Re: [PATCH] fixup! kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun, May 22, 2022 at 9:04 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I will squash this into
>
>   https://patchwork.kernel.org/project/linux-kbuild/patch/20220513113930.10488-3-masahiroy@kernel.org/
>
> Sedat Reported an error:
>
>   https://lore.kernel.org/linux-kbuild/CA+icZUWttwjhDNPO1VuVyiMoReH5e83nsYDd0rEoY8-Uwv6pHw@mail.gmail.com/T/#md82f561e348b7959b7270c33ac86fa3edb0d773a
>
> __used is needed to make the combination of
> CONFIG_MODVERSIONS and CONFIG_LTO_CLANG working.

Yep, vaguely reminiscent of
commit f3751ad0116f ("tracepoint: Mark __tracepoint_string's __used")

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  include/linux/export-internal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
> index 77175d561058..c2b1d4fd5987 100644
> --- a/include/linux/export-internal.h
> +++ b/include/linux/export-internal.h
> @@ -10,7 +10,8 @@
>  #include <linux/compiler.h>
>  #include <linux/types.h>
>
> +/* __used is needed to keep __crc_* for LTO */
>  #define SYMBOL_CRC(sym, crc, sec)   \
> -       u32 __section("___kcrctab" sec "+" #sym) __crc_##sym = crc
> +       u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
>
>  #endif /* __LINUX_EXPORT_INTERNAL_H__ */
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
