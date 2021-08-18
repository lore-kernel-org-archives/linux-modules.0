Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3872DC4338F
	for <linux-modules@archiver.kernel.org>; Wed, 18 Aug 2021 21:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E15610CD
	for <linux-modules@archiver.kernel.org>; Wed, 18 Aug 2021 21:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhHRVYq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 18 Aug 2021 17:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbhHRVYp (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 18 Aug 2021 17:24:45 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A9DC061764
        for <linux-modules@vger.kernel.org>; Wed, 18 Aug 2021 14:24:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id n6so7584402ljp.9
        for <linux-modules@vger.kernel.org>; Wed, 18 Aug 2021 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgndujLcd+n2nRBcjduBeXJI3jeF8Lf8aYHpwJ0GAYA=;
        b=UGjP5KoJ6X9etP+ls1fM9/SPR3h8T0xozanuB/GGB3tebnRhlPFuuiyBmw17CwMBq9
         akip67PxksvyAfh21ICfCsxSEnQiobyE5fyDDFVZAGOHm19miTZHQrC8YGARsAEB/MGV
         W4KOp5rOGOgsRcHJY00yaKZDG7O3/6IzgWaQGgw5C0oLzPpEkd32llp+gt4Jdwy38zx5
         lqAaSG0ZELoYkxYu7q80V4ScxTUgFSqZk1sws75xvh8fJtFEZ8cPoapaXc0uu0V90fa1
         QGrOdIDUc5oOFesYuPcUrN5oUYl0JtV8o0igHT91Q4kkmP4Y1DHX9DeHAGSV03hDpSRC
         PyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgndujLcd+n2nRBcjduBeXJI3jeF8Lf8aYHpwJ0GAYA=;
        b=euZY5RfaquijungoZcGpn9nJSH5gjsro+xSlVs+YzNTNNvFzoxeN0NSu9rKnPhgQqz
         DIjphXRcTqHDk2BIKeo7hGSkOTbU40KLHzpOpIJReaDPnJjxyJtlTlnut2Kmdn62k/qC
         xFVDJywLNmzuloKjd8LG1SKBgrCYhQkcJ1NhoBV19Pg/qba/RijbiO8itGceBG47il/w
         dlgy0hsV0YOaiFPqT9QKRQGNuNhaE7xVlOWVVPpNbuFDewNRp+wEDL4eIHNbGxT4hG5n
         rdUjAKV42f5zv2V84jgO3fzZnDHn8nkUEP13xn6+EZ8JOHSo5LlU23wcB9/0xN5CktcV
         BlLA==
X-Gm-Message-State: AOAM533trDF9gA1gIA8B/d/x2d3SSzPva67ABp2rZ5QGeWtBa/11O2bL
        RA3yEDUdSMap5VPC+S4FZvS6RqIwMN74vfSgOSU=
X-Google-Smtp-Source: ABdhPJxBw1Cyy8Hm6ubEgXYLKBdOJVjNmpJ25nH7w4CwmJVl5qeSGo4uvcC3i4Ydgh9T4jQkTm/zdjVGUt9qorSWoQQ=
X-Received: by 2002:a2e:a809:: with SMTP id l9mr9303330ljq.302.1629321848890;
 Wed, 18 Aug 2021 14:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAKi4VAJVvY3=JdSZm-GD1hJqyCPYaYz-jBJ_REeY5BakVb6_ww@mail.gmail.com>
 <20210818205159.6066-1-msuchanek@suse.de>
In-Reply-To: <20210818205159.6066-1-msuchanek@suse.de>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Wed, 18 Aug 2021 14:23:56 -0700
Message-ID: <CAKi4VAJ6suukX93gjruTG3H66NeA6PxQ40hR2_+hL5m11LQ_ZQ@mail.gmail.com>
Subject: Re: [PATCH] libkmod: Set builtin to no when module is created from path.
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Aug 18, 2021 at 1:53 PM Michal Suchanek <msuchanek@suse.de> wrote:
>
> Something like this?

yep. Just a matter of style but I think I like the *mod = m as the
last thing. Let me send it with that additional change.

thanks
Lucas De Marchi

>
> Thanks
>
> Michal
>
> --------------------------------------------------------------------
>
> A recent bug report showed that modinfo doesn't give the signature
> information for certain modules, and it turned out to happen only on
> the modules that are built-in on the running kernel; then modinfo
> skips the signature check, as if the target module file never exists.
> The behavior is, however, inconsistent when modinfo is performed for
> external modules (no matter which kernel version is) and the module
> file path is explicitly given by a command-line argument, which
> guarantees the presence of the module file itself.
>
> Fixes: e7e2cb61fa9f ("modinfo: Show information about built-in modules")
> Link: https://lore.kernel.org/linux-modules/CAKi4VAJVvY3=JdSZm-GD1hJqyCPYaYz-jBJ_REeY5BakVb6_ww@mail.gmail.com/
> BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1189537
> Suggested-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  libkmod/libkmod-module.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 9e878a5345a1..53b220d492e8 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -432,18 +432,18 @@ KMOD_EXPORT int kmod_module_new_from_path(struct kmod_ctx *ctx,
>                 }
>
>                 *mod = kmod_module_ref(m);
> -               return 0;
> -       }
> +       } else {
> +               err = kmod_module_new(ctx, name, name, namelen, NULL, 0, &m);
> +               if (err < 0) {
> +                       free(abspath);
> +                       return err;
> +               }
>
> -       err = kmod_module_new(ctx, name, name, namelen, NULL, 0, &m);
> -       if (err < 0) {
> -               free(abspath);
> -               return err;
> +               m->path = abspath;
> +               *mod = m;
>         }
>
> -       m->path = abspath;
> -       *mod = m;
> -
> +       (*mod)->builtin = KMOD_MODULE_BUILTIN_NO;
>         return 0;
>  }
>
> --
> 2.31.1
>
