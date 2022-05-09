Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379CEC433FE
	for <linux-modules@archiver.kernel.org>; Mon,  9 May 2022 18:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbiEISJv (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 9 May 2022 14:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbiEISJt (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 9 May 2022 14:09:49 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85A353A49
        for <linux-modules@vger.kernel.org>; Mon,  9 May 2022 11:05:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m23so18039890ljc.0
        for <linux-modules@vger.kernel.org>; Mon, 09 May 2022 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AN921NaxNkeCgd+/kg15uAVOqAqbEenfNO325PUsS6k=;
        b=cdkkVkNwsvU59Cj0woYu6dSdwau5E9ePg+8kIJ1M1Frwv+LedGaW6DLtMwkXpMZL2B
         r7hFwQ3ahDz+IJdG4IjbhLPOcTwEoyXCnRmAW2WdhUgxhcdRUNGXAuadJ4tWcsACiMSL
         D+ZDP9Q++d5BAfIHETxhJRtnfnDfJwFx7k8npnx59zIQ50VN28X5Urs8CGSBmjf10Azm
         KbxvSubWCFWIqArNH+Eap4Ab+N6ITHlwC+yZnZQK/CX+oo0khGclKQwTivaiOeVCWJ1F
         QPgepFDot07kcqaOrupthXZjZwE3bspAHq+AIGDvC0XPGQqrRHf5JYMmMeJ86QLYBcxh
         6SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AN921NaxNkeCgd+/kg15uAVOqAqbEenfNO325PUsS6k=;
        b=e6BjhWbBH46R5B3SEuFfJ80hAI02lLOOayZebBPhqigLYBH3LPoLT3w1lruiaEV/Z4
         N1YygyuQQ2DcgGf54oNlSZxljg2KNiPr2EclmqGqMvNAVdoaJpyCa9NpNnOoPJzevLq4
         o3s1eJf/H0g7HyDva9XhIFu1GeN5sBCrRmKuCgQyLSf1L1t60DlDdic4bVBlAzd5fB3Y
         KOaCtxo5y0rCWy0lwdFk/URtpfHXE2UV+Gs/NVO/Lkm6qDd/dUQCV/EuPrLmfEYDfKum
         gMPMHSH8i8hjdkm13npWDLoL46/FPMcIIKWQ7z3QFSaNJCrR84pLpHUdUndgetl5dhNj
         +3Qw==
X-Gm-Message-State: AOAM533/L+vCXukL4HRb6DPVaDCgyPqoesl3u+YOAGUKYtHQsgXx6kon
        NejWEKLSH9bY1GlBv4k0OGQBiyWlDen1tTtPz3WN7A==
X-Google-Smtp-Source: ABdhPJwPwqycR8l/3eeVmCel1hLEu82x6SiaXLmDlHX2zoI+YX9jdJy+XCg/b2Ed5906efBN4BZfCg1kx4JD8JBVFLI=
X-Received: by 2002:a05:651c:552:b0:250:5c23:d0f2 with SMTP id
 q18-20020a05651c055200b002505c23d0f2mr11376317ljp.239.1652119550281; Mon, 09
 May 2022 11:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220508190631.2386038-1-masahiroy@kernel.org> <20220508190631.2386038-11-masahiroy@kernel.org>
In-Reply-To: <20220508190631.2386038-11-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 May 2022 11:05:38 -0700
Message-ID: <CAKwvOdkhcJB8Bnrt51siRefWe+ZSvHagCs2G011PzkkrD3cxQw@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] kbuild: check static EXPORT_SYMBOL* by script
 instead of modpost
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun, May 8, 2022 at 12:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> diff --git a/scripts/check-local-export b/scripts/check-local-export
> new file mode 100755
> index 000000000000..d1721fa63057
> --- /dev/null
> +++ b/scripts/check-local-export
> @@ -0,0 +1,48 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (C) 2022 Masahiro Yamada
> +
> +set -e
> +set -o pipefail
> +
> +declare -A symbol_types
> +declare -a export_symbols
> +
> +exit_code=0
> +
> +while read value type name
> +do
> +       # to avoid error for clang LTO; $name may be empty
> +       if [[ $value = -* && -z $name ]]; then
> +               continue
> +       fi
> +
> +       # The first field (value) may be empty. If so, fix it up.
> +       if [[ -z $name ]]; then
> +          name=${type}
> +          type=${value}
> +       fi

Consider adding examples of output from NM as comments where you're
handling special cases.

Aren't BOTH from LTO?  The first case is:

---------------- T strncpy

while the second is

                 U strncpy

IIUC?

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
