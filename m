Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343A7C433F5
	for <linux-modules@archiver.kernel.org>; Sun,  3 Apr 2022 17:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbiDCRHQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 3 Apr 2022 13:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbiDCRHQ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 3 Apr 2022 13:07:16 -0400
X-Greylist: delayed 199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Apr 2022 10:05:21 PDT
Received: from condef-02.nifty.com (condef-02.nifty.com [202.248.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B2D33890
        for <linux-modules@vger.kernel.org>; Sun,  3 Apr 2022 10:05:21 -0700 (PDT)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-02.nifty.com with ESMTP id 233GwjEM023619
        for <linux-modules@vger.kernel.org>; Mon, 4 Apr 2022 01:58:46 +0900
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 233GwUXY007222
        for <linux-modules@vger.kernel.org>; Mon, 4 Apr 2022 01:58:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 233GwUXY007222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649005110;
        bh=wdLsMn3mkFndeGhF9m4eudBm04hLi1EuvuWjt+slEX4=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=Za2xx9nLUO7x1ngbTyaerj/TwKaDMOXyibx/L6FHRN0YTohhRHXLDw3b+SEgOZLn2
         +vMQR/F8VLv7W2PUXXxUTTN28il8s3kI9AylTwaT0S/HZVTQl9vnkyUyBacp089MnB
         YtpT8DNtUWZFhUKDPJiFpat5Ucn1J1Nta/hQ81bMePsNruBgq0ACSawiXax6Ls2aXA
         GI4mYFxWOAJtQQusuHpKK73c3V0ZJlJdFF7WcIhGy+2I9PH54wdJ4fGGlEyZMfPSLe
         Fvd6nH4mqdWeKdZhODnn5mkSCf4a03PJeE/f7E6m9u+4sbWJDVuboGeAruOFSYM6jt
         S/eGNv7k1BOWQ==
X-Nifty-SrcIP: [209.85.210.175]
Received: by mail-pf1-f175.google.com with SMTP id b13so6934590pfv.0
        for <linux-modules@vger.kernel.org>; Sun, 03 Apr 2022 09:58:30 -0700 (PDT)
X-Gm-Message-State: AOAM533MSqaUrWUr4trMXyjDe15xB+o9y+mUq/bd0n9c8vvbPFtRPDdi
        +ePFhQznIITDFfUXXJjtp4Oktjk9/kX4clLN534=
X-Google-Smtp-Source: ABdhPJwqQBz0KzsPUqWzGsRHmUNAJA6Vx3lLH1SsdbTH0d7GXH4kVeRytuJKys4nVmfpJHNQ1i9xitYBEfcZedGrznA=
X-Received: by 2002:a05:6a00:24d2:b0:4fb:1b6d:ee7d with SMTP id
 d18-20020a056a0024d200b004fb1b6dee7dmr20150333pfv.36.1649005109626; Sun, 03
 Apr 2022 09:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220210021423.3388827-1-masahiroy@kernel.org>
In-Reply-To: <20220210021423.3388827-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 4 Apr 2022 01:57:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS+NK7dmBcqpO3x_MOhqjWyt3SLkwJE1O-zvGUH255ZsA@mail.gmail.com>
Message-ID: <CAK7LNAS+NK7dmBcqpO3x_MOhqjWyt3SLkwJE1O-zvGUH255ZsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] modprobe: fix the NULL-termination of new_argv
To:     linux-modules <linux-modules@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Lucas,

Ping?


On Thu, Feb 10, 2022 at 11:14 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The number of new arguments is (i + argc - 1) as it is set to *p_argc
> one line below.
>
> The correct location of NULL termination is new_argv[i + argc - 1].
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  tools/modprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/modprobe.c b/tools/modprobe.c
> index 9387537..b6b2947 100644
> --- a/tools/modprobe.c
> +++ b/tools/modprobe.c
> @@ -743,7 +743,7 @@ static char **prepend_options_from_env(int *p_argc, char **orig_argv)
>         }
>
>         memcpy(new_argv + i, orig_argv + 1, sizeof(char *) * (argc - 1));
> -       new_argv[i + argc] = NULL;
> +       new_argv[i + argc - 1] = NULL;
>         *p_argc = i + argc - 1;
>
>         return new_argv;
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
