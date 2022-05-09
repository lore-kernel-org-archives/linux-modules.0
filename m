Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8409C433F5
	for <linux-modules@archiver.kernel.org>; Mon,  9 May 2022 17:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbiEIRX6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 9 May 2022 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbiEIRX5 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 9 May 2022 13:23:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4701BD730
        for <linux-modules@vger.kernel.org>; Mon,  9 May 2022 10:20:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y32so25001303lfa.6
        for <linux-modules@vger.kernel.org>; Mon, 09 May 2022 10:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xq5ml2d/MeiCgCuvTz1iX/vBFJV/Zf5wkHsF94chv1Q=;
        b=FoDLMQ1CUcXkPH5YH2WUvQkrh4wyHkUUHZHcdPJapmG1T0eHAY1wc8brR60ppGMa5J
         MvFXF3tuoDWJ6lkuzwDg+uXRKK1dpjzfA/uB5GQC4TIBsPxsrPlb2FDEA+M+F9oDz5r4
         vtrjLZL3T3cOwM7JK/DHccrk8RMKefToEtmE3ezQ84jzYnAtOuLgLmSS8SPIbwmYpL8e
         +569UZLjUuKlLJxuLia9HvqCZWJPaqW6wxZ2wKVmnB6sIpUzIEuoLVasYEAtGywHS+dy
         NOLgCVKyfJ/Tlp9jDY6Jr3DzFF11gOShM2S20Pm+kw6ankpEDU3X7veoarlOtuIzCHqv
         rMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xq5ml2d/MeiCgCuvTz1iX/vBFJV/Zf5wkHsF94chv1Q=;
        b=S33nnDDF0ucKlGsLl1K/oiKAzQaxxOyNYg/5Py5a/KzXAeXiLl+6Wf9WqBkKIO4py5
         lj9m8ma6IOF5vhRNTi6XdRNYNH8qbMxAbaZsJUWGWkoI027LyeATgIybhVVfPJXu7m0a
         e+RR3Zgm75sSt4RnkFp1ImNUf18GsSh1SVrZ30goqygrFeo9hdozSbUyGXP++i7yUtVU
         MCFX6NrhL7akYNNhhBLI+NodEvVBGMD12nOLOAz2et5GipXzVtU5MFTworQQ1yBZS8t1
         iaWk7TgkqAcE9AGBKtnUw8oig1n8NwEBC0HCrU7xdRSrbQKzx6x3Qd4xI0scFYEVHCh+
         WaPA==
X-Gm-Message-State: AOAM533Yp566U1PcdYrKSvjKmb/YeukACCtGnnZJrsYy08Q44RGZitG0
        UzL08XOxXQ0XwGmE8N53qJkrPAn+ZTTRJr7Bo6kqXQ==
X-Google-Smtp-Source: ABdhPJz9taxhLV4YRudjP7JD9rlg95k5LEcou1gLMLiVH/oLNlkumRLOmW/IlL/tmn/lb4A3bbzyo1/l2F7YyG1FIcQ=
X-Received: by 2002:a19:4303:0:b0:473:f5fb:27b2 with SMTP id
 q3-20020a194303000000b00473f5fb27b2mr12343182lfa.626.1652116799064; Mon, 09
 May 2022 10:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220508190631.2386038-1-masahiroy@kernel.org> <20220508190631.2386038-4-masahiroy@kernel.org>
In-Reply-To: <20220508190631.2386038-4-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 May 2022 10:19:47 -0700
Message-ID: <CAKwvOd=LR=UNOeWJDmM-McJ=FrCWTo8w1ox+KGMQCwCVpiUyFg@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] modpost: split the section mismatch checks into section-check.c
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun, May 8, 2022 at 12:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> modpost.c is too big, and the half of the code is for section checks.
> Split it.
>
> I fixed some style issues in the moved code.

It would be helpful for review if the split and restyle were distinct
patches.  Otherwise I can't tell what has changed.

This does lose the ability to use git blame to get more context on
some of the oddities in modpost (which I have found useful in the
past).  I don't feel strongly though.

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v4:
>   - New patch
>
>  scripts/mod/Makefile        |    2 +-
>  scripts/mod/modpost.c       | 1202 +---------------------------------
>  scripts/mod/modpost.h       |   34 +-
>  scripts/mod/section-check.c | 1222 +++++++++++++++++++++++++++++++++++
>  4 files changed, 1240 insertions(+), 1220 deletions(-)
>  create mode 100644 scripts/mod/section-check.c
>
> diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
> index c9e38ad937fd..ca739c6c68a1 100644
> --- a/scripts/mod/Makefile
> +++ b/scripts/mod/Makefile
> @@ -5,7 +5,7 @@ CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
>  hostprogs-always-y     += modpost mk_elfconfig
>  always-y               += empty.o
>
> -modpost-objs   := modpost.o file2alias.o sumversion.o
> +modpost-objs   := modpost.o section-check.o file2alias.o sumversion.o
>
>  devicetable-offsets-file := devicetable-offsets.h
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index a78b75f0eeb0..e7e2c70a98f5 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -31,7 +31,7 @@ static bool external_module;
>  /* Only warn about unresolved symbols */
>  static bool warn_unresolved;
>
> -static int sec_mismatch_count;
> +int sec_mismatch_count;

^ this should go in modpost.h if it is to be used in two translation
units, rather than forward declaring it in section-check.c.  You did
this for the functions.
-- 
Thanks,
~Nick Desaulniers
