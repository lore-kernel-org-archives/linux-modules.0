Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1717FC433EF
	for <linux-modules@archiver.kernel.org>; Mon,  9 May 2022 23:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiEIXRp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 9 May 2022 19:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiEIXRn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 9 May 2022 19:17:43 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FB22A3BE7
        for <linux-modules@vger.kernel.org>; Mon,  9 May 2022 16:13:48 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2f7c57ee6feso161812777b3.2
        for <linux-modules@vger.kernel.org>; Mon, 09 May 2022 16:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oazinpgomaqUG0jSYMm8ubizFPTzpD9YluLXTH1Uf+8=;
        b=f6fWCk6p41OZaY/aYptJIOS/H7gQoR2LQU/vFrk5Gn4NSNwuGdiZDiDStk7AbG3yZD
         IKBXb4w884/50UAgGFMYKZ1TW7UWPSrJsR6aU/0xVkQloWI1gv9dqJSDbnU+7ZRlaq+H
         5q6FzLE9Jch5W51SjYRwMzmvNSaAVh59pmK1la7G6Ce7QS8+phGNXM1poUTxBJEghkkL
         rkNzGIHiR6cg7h2j0E68I08LETn6PDCH3Bk2j2CtnK3mFxMH+qkZYlQ5Mbk0pgP96vbx
         k86u84TYrd/iZlrt9edUpHqGeZQt6sH9DbxxljCpeCMl8DqbX8Q9LTMC9vVENf9lnOH2
         8xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oazinpgomaqUG0jSYMm8ubizFPTzpD9YluLXTH1Uf+8=;
        b=6rwuvVwp9v+TSPjqOGvXfvAe3DAbfaUzJ4MyTTKUALN57V5awBDTQuc+I/L8bIImpo
         hop/FhzAn2pNjS30dF0w2L8LPxKSpysettGHX+C1Cuv0vd1sU8xefZfiuw6tHZ+6XH5j
         IoqFIHc/HLO0bhOCgCz65hakHYr/V2QuyR6KM5iRks7EImFHx3Ecuyk/vOGWuPzqS6BX
         mLZX6O9xRv48Wy2T2sSTcTfUl9vw+pNI8uLTNHpPZXCJi65eiyUbn41DgTfk01iTE75f
         4frfKtkEWMp/n8tWdTsCruav2oKyVHMNnEkTJJDbBRrsvHAoATUEx+ujT9SYeiYCv2op
         Q0rg==
X-Gm-Message-State: AOAM532Rd4H/gmcuXfSQWj2QRXSoOFbBIV8dJ1ydT5QyOc1yB1n6XB9Y
        wKse5iAeT766mIZjmjoR+oxZk5XQ4ugi9Zsc7wwCeg==
X-Google-Smtp-Source: ABdhPJxssHqsbnbsTj81I2dSgjtFlZace94GadSqyvpd5jqz1pk64Y4lHyhr+1TXl7QDxSK2F5OuNrrpLo+K4Kc2AN8=
X-Received: by 2002:a81:1108:0:b0:2f7:bf11:3fb9 with SMTP id
 8-20020a811108000000b002f7bf113fb9mr17011668ywr.305.1652138027673; Mon, 09
 May 2022 16:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220508190631.2386038-1-masahiroy@kernel.org> <20220508190631.2386038-10-masahiroy@kernel.org>
In-Reply-To: <20220508190631.2386038-10-masahiroy@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 9 May 2022 16:13:11 -0700
Message-ID: <CABCJKudnbTS=_2WgX63xb_3oCwt_6jwotqfoV5wSjkmfjuUJZQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/14] kbuild: do not create *.prelink.o for Clang LTO
 or IBT
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun, May 8, 2022 at 12:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> When CONFIG_LTO_CLANG=y, additional intermediate *.prelink.o is created
> for each module. Also, objtool is postponed until LLVM bitcode is
> converted to ELF.
>
> CONFIG_X86_KERNEL_IBT works in a similar way to postpone objtool until
> objects are merged together.
>
> This commit stops generating *.prelink.o, so the build flow will look
> the same with/without LTO.
>
> The following figures show how the LTO build currently works, and
> how this commit is changing it.
>
> Current build flow
> ==================
>
>  [1] single-object module
>
>                                       $(LD)
>            $(CC)                     +objtool              $(LD)
>     foo.c --------------------> foo.o -----> foo.prelink.o -----> foo.ko
>                            (LLVM bitcode)        (ELF)       |
>                                                              |
>                                                  foo.mod.o --/
>
>  [2] multi-object module
>                                       $(LD)
>            $(CC)         $(AR)       +objtool               $(LD)
>     foo1.c -----> foo1.o -----> foo.o -----> foo.prelink.o -----> foo.ko
>                            |  (archive)          (ELF)       |
>     foo2.c -----> foo2.o --/                                 |
>                 (LLVM bitcode)                   foo.mod.o --/
>
>   One confusion is foo.o in multi-object module is an archive despite of
>   its suffix.
>
> New build flow
> ==============
>
>  [1] single-object module
>
>   Since there is only one object, we do not need to have the LLVM
>   bitcode stage. Use $(CC)+$(LD) to generate an ELF object in one
>   build rule. When LTO is disabled, $(LD) is unneeded because $(CC)
>   produces an ELF object.
>
>            $(CC)+$(LD)+objtool             $(LD)
>     foo.c ------------------------> foo.o -------> foo.ko
>                                     (ELF)    |
>                                              |
>                                  foo.mod.o --/
>
>  [2] multi-object module
>
>   Previously, $(AR) was used to combine LLVM bitcode into an archive,
>   but there was no technical reason to do so.
>   This commit just uses $(LD) to combine and convert them into a single
>   ELF object.
>
>                             $(LD)
>             $(CC)          +objtool        $(LD)
>     foo1.c -------> foo1.o -------> foo.o -------> foo.ko
>                               |     (ELF)    |
>     foo2.c -------> foo2.o ---/              |
>                 (LLVM bitcode)   foo.mod.o --/
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Looks good, thanks for cleaning this up!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
