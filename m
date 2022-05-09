Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6428C433EF
	for <linux-modules@archiver.kernel.org>; Mon,  9 May 2022 17:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbiEIRNH (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 9 May 2022 13:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbiEIRNF (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 9 May 2022 13:13:05 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6981E3266
        for <linux-modules@vger.kernel.org>; Mon,  9 May 2022 10:09:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y32so24949688lfa.6
        for <linux-modules@vger.kernel.org>; Mon, 09 May 2022 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmNh/UlR00KzKm2embL/8KXGrDJlEF5LNSh8Qse0tHI=;
        b=XlxYVyti/+Q7NqrSdb22SAIl6Y2j55Yg5g2k37ctvzV1ktFvUd3+GBrrXaqN+9NFeY
         6EJHldsP4pwcrjQ2xzBRUlRSmr1Qray+IZ0Azb6pH9oGWAA6cH1MqKDYqSoobESAB3Tt
         eRGYGGgOM/icKjcAIArV0t0cRsOS98O3uc3oCmKTiATpvxAJt2dw7pFRGKnsUp5Fy6+q
         XIPCiWfYfE/TS6cBhvExSO/fG7/pxV+Gc6ing+pOzWL/ysqhEjHBgLIYNRnpXIBuNHwt
         4ZGKV+R/g8mxG2EAM+mfZqER4WmDuwtD4WjdICN3razEbRrdkjkeh/S/AOCAatbdqrDm
         dp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmNh/UlR00KzKm2embL/8KXGrDJlEF5LNSh8Qse0tHI=;
        b=vDna16s05pI1UE08lGzQgtj7qrS5w2SGoHAU9XXkQUPiGysCU0wFUDDqcRk0gEhYT3
         RGTCNxhyatcaILbRStYHFaz8Fr6p++s1GpzI1YwA7IGAqqaUM/ihWklAcfC8TXhG/cUF
         J2I1Xax+z/n9Rc3ORJG+a2KQJrlRxxynL36PR7IJLyLrYh+BNL6kL2lJ83T8GCzWLv0Q
         P45w+AJ0u9Va5Y7ElrCo8Dic2x1w+E89zIa9wl3spjd/6PfdurnBSlksYnaP1v0OqMoV
         RFJTj7XBItERZEUltIcsV9JnMv3g5Dny0eVnK6zvITikZ79o+KwxZgqoEb/f/cCC5Lr5
         xO3w==
X-Gm-Message-State: AOAM532bbzHAPrJrHR526NyEC3g0c4wLPdJLeUS6fPSemQHYxpEVeqRB
        j7I8WDkSTQ9EzJ1xSkgXRgzVDwy1yX2e3Qw4q7fQhA==
X-Google-Smtp-Source: ABdhPJwxw3I1e8oaAvfUjbq5Ev4Yd8NjV0buUyZoAzr7cbILcvl2TRmROPbsKEb/6HUIdbYLzAigXpP3dNIEtdsX6aE=
X-Received: by 2002:a05:6512:1d1:b0:471:f63a:b182 with SMTP id
 f17-20020a05651201d100b00471f63ab182mr13052968lfp.392.1652116149145; Mon, 09
 May 2022 10:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220508190631.2386038-1-masahiroy@kernel.org> <20220508190631.2386038-2-masahiroy@kernel.org>
In-Reply-To: <20220508190631.2386038-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 May 2022 10:08:57 -0700
Message-ID: <CAKwvOdnawYY05Boy6FNUtBoi11z8yyMnfDzGUw0CDMT3vKuP5w@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] modpost: remove left-over cross_compile declaration
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

On Sun, May 8, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This is a remnant of commit 6543becf26ff ("mod/file2alias: make
> modalias generation safe for cross compiling").
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch! (I wonder if we should put our old mailing list
in .mailmap?)
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v4:
>   - New patch
>
>  scripts/mod/modpost.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index cfa127d2bb8f..d9daeff07b83 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -174,7 +174,6 @@ static inline unsigned int get_secindex(const struct elf_info *info,
>  }
>
>  /* file2alias.c */
> -extern unsigned int cross_build;
>  void handle_moddevtable(struct module *mod, struct elf_info *info,
>                         Elf_Sym *sym, const char *symname);
>  void add_moddevtable(struct buffer *buf, struct module *mod);
> --

-- 
Thanks,
~Nick Desaulniers
