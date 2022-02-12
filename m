Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D775C433F5
	for <linux-modules@archiver.kernel.org>; Sat, 12 Feb 2022 06:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiBLGEU (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 12 Feb 2022 01:04:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiBLGEU (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 12 Feb 2022 01:04:20 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC51028E3E
        for <linux-modules@vger.kernel.org>; Fri, 11 Feb 2022 22:04:16 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id c10so2482672ljr.9
        for <linux-modules@vger.kernel.org>; Fri, 11 Feb 2022 22:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWBjVu1c+++V/AW1vC1K1gMO9uJtYuL0zDOp4NBjDi8=;
        b=TV+yRIxzpIhf3YCDKg7y4yk3N/L4/qOHrUGGaeACaBiGPhalc97rXCswaHdl0S7nnH
         4tCnvVs5Z6OtFawnsVfmqGi+XdiEMyOoZKsjFlW6saM7c5qJyjXSF6uGHhxMgHxtYqI3
         /xjDs3R7qcZOx5mV87bHcTLlEswL7NNWT3s/8D3BN+H5Jhb3Cyv4dT0ts3mU6cVU0DHH
         MAVwQtChUEowjimCBmuctf21FekoG5Vbg1sabfJooYyvORTs7YX2V8ztxevp/B0NHhru
         tFu8IwxA5plRvKCYC16LSCY7ujrJKfR5zEnGpmP4FIQXkJXIh6TPhuLFCDNy4UMTKK0H
         i4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWBjVu1c+++V/AW1vC1K1gMO9uJtYuL0zDOp4NBjDi8=;
        b=UM6gtmEOXnOftQ+21lBVbdrg5IdfGGQRDGlLB5pUeubUQf+mQ+dRCYAAdZ7rtdnXZA
         XRxE+MsMUD+hlbviNGnzx2+FJHNvOvz9padyUs4+NIPr6oZB8j543Uk7e3akEhPVkOuB
         p6qKskXP6ogG9C/FxMHjRe2ArFrfT1kFxyIbElk+H4k2psI4GtLH71unpGSko3ca+Usy
         jYHCKe2I7ZuexjxRpreyCxFUmczjyf/kTxGN3YSe1mYtiI1Wi/+uXlnSq/+1Hc2F5Jck
         1bJiXPWttYwZU6p1aNN05ZAdqsS4Zsvhw5Gl6j36fUixw0dGBwhQMVMVDU3yh7V+Wrsi
         lcQQ==
X-Gm-Message-State: AOAM531v6B62m8WNmYiXTnLzY5c6jQ7IsqlgUgGDQtbXATOqSb4GbgL2
        VKg21O1Cn0rhqYQkdQCBewnVbddiIbeuC0zvaTM=
X-Google-Smtp-Source: ABdhPJzpmnmx4C3+KMi+g0k7anO/sT209sujD+cWoswTBQNivkhXrny/QX/P99h8lccDC7EWhOagxR0sHW5W+K82wcY=
X-Received: by 2002:a05:651c:4ca:: with SMTP id e10mr2862990lji.405.1644645855035;
 Fri, 11 Feb 2022 22:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20220211084230.4489-1-lucas.demarchi@intel.com> <20220211104516.5i3selmqfd7rsxxw@example.org>
In-Reply-To: <20220211104516.5i3selmqfd7rsxxw@example.org>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 11 Feb 2022 22:04:02 -0800
Message-ID: <CAKi4VAJs8mC23vpvkryrdJiX2fJgkPPzb763Og4Y0vZv_JH8Gw@mail.gmail.com>
Subject: Re: [PATCH 1/3] libkmod: Prefer builtin index over builtin.alias
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Feb 11, 2022 at 4:28 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> On Fri, Feb 11, 2022 at 12:42:28AM -0800, Lucas De Marchi wrote:
> > The modules.builtin.alias.bin is way larger than the
> > modules.builtin.bin.  On a normal "distro kernel":
> >
> >       21k modules.builtin.alias.bin
> >       11k modules.builtin.bin
> >
> > >From the kernel we get both modules.builtin and modules.builtin.modinfo.
> > depmod generates modules.builtin.bin and modules.builtin.alias.bin
> > from them respectively. modules.bultin is not going away: it's not
> > deprecated by the new index added. So, let's just stop duplicating the
> > information inside modules.builtin.alias.bin and just use the other
> > index.
> > ---
> >  libkmod/libkmod-module.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> > index 6f7747c..40d394a 100644
> > --- a/libkmod/libkmod-module.c
> > +++ b/libkmod/libkmod-module.c
> > @@ -576,13 +576,14 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
> >       err = kmod_lookup_alias_from_aliases_file(ctx, alias, list);
> >       CHECK_ERR_AND_FINISH(err, fail, list, finish);
> >
> > +     DBG(ctx, "lookup modules.builtin %s\n", alias);
> > +     err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
> > +
>
> assigning to the err variable looks useless. It will be overwritten
> anyway.
>


we were supposed to have a CHECK_ERR_AND_FINISH(err, fail, list, finish);
here.

thanks
Lucas De Marchi
