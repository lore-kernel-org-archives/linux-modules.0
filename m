Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5867EC43381
	for <linux-modules@archiver.kernel.org>; Mon, 11 Jan 2021 13:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345452222F
	for <linux-modules@archiver.kernel.org>; Mon, 11 Jan 2021 13:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbhAKNrN (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 11 Jan 2021 08:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731232AbhAKNKj (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 11 Jan 2021 08:10:39 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74F5C061795
        for <linux-modules@vger.kernel.org>; Mon, 11 Jan 2021 05:09:58 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o17so37658912lfg.4
        for <linux-modules@vger.kernel.org>; Mon, 11 Jan 2021 05:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78F8dwoJmBN75Jd2Tj0I97qiYwPmL2YsEUkwjMkUZ0E=;
        b=SpK44BO1kNiZfgxi13bvzNJdRRe4zuE+kNoDszh6ZZhbIwV5WMGd3pl8J3z6zzpIiD
         sJSXxbd2/6V0f5mm5YGetmn52mjYcv4uZOVDYB4MnOooZVQ4deFrLSaxEKq1TmdyK4wx
         sSk67ex4BEAjdn+s+pjQ9B2XXoGH5aP9K3lcRHmtPuMTTGNZDLcW5bTz5VMjo/OMemol
         wOMGj14K65itXvi4uVu91+MOGuLEbgtIoEEgumg/X2yemJHnTY0/OYmpuT6kXkpqVBFn
         Tj4sn732DF+dATsNClJh8isKSVzZsHitWyYO7N3aFjRliIWpsF4M5Sp0GtDKlnbQMbB0
         ILHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78F8dwoJmBN75Jd2Tj0I97qiYwPmL2YsEUkwjMkUZ0E=;
        b=j2uEzeRIekdkf7/gqE2dmM/HwbtNOLCBXvdDYu244AU6mhm4mU87s2R0GBjARBHgcf
         Fxn+hU9FQfMRBHy0vjehIa0AMn8ere2Lne/7E3g+i02XT5vPViahc8rV+jkTNNTewI0j
         FwKv25wmsbYPaVvUyKowJysbxh1oECSNlSg0Bk4l0WJa6Nt6tpB0pUZSiMVYb5ip9qDJ
         lQatpPltBVN73+mzw+TCE7WgoXIdGxvVFACUqhbOaGUzA+Dy88IXayKyWGJD1z9/kYh0
         pqq1elmUCdDPcegTzC/9mBGWr/nMtaMBc9qTu78hIdtEXmcugwqjCpF1DoRQXwKNnb2s
         sc4A==
X-Gm-Message-State: AOAM533ZlA1ScJUY5yfgbn/77mHC/nG78ORsANRlmRqQKEKILFJvP9D3
        c1N3rdHTdOpzVwP++dJArLEpNYQ37W0zfk74ay0=
X-Google-Smtp-Source: ABdhPJxW1yOFnGaee9hQfC1jem1of5K9r6Oh/ZnTjrX0w1fv94bq9MzE4eqplcUGtUXXC+4C4wkaEyuGWYWQJldhKLA=
X-Received: by 2002:a19:ca55:: with SMTP id h21mr6775203lfj.23.1610370597450;
 Mon, 11 Jan 2021 05:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20210108072243.22828-1-wangshuo47@huawei.com>
In-Reply-To: <20210108072243.22828-1-wangshuo47@huawei.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 11 Jan 2021 05:09:45 -0800
Message-ID: <CAKi4VAKrhR4s2ibo7pg6Sr7x=GQG2ao9KgwudxJsqvJqwr7F6w@mail.gmail.com>
Subject: Re: [PATCH] libkmod: assign values to variables to fix warnings
To:     Shuo Wang <wangshuo47@huawei.com>
Cc:     patchwork-bot@kernel.org,
        linux-modules <linux-modules@vger.kernel.org>,
        hushiyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

what compiler?

On Thu, Jan 7, 2021 at 11:22 PM Shuo Wang <wangshuo47@huawei.com> wrote:
>
> libkmod/libkmod.c: In function 'kmod_lookup_alias_is_builtin':
> ./shared/util.h:73:9: warning: 'line' may be used uninitialized in this function [-Wmaybe-uninitialized]
>          free(*(void**) p);
>          ^~~~~~~~~~~~~~~~~
> libkmod/libkmod.c:581:23: note: 'line' was declared here
>   _cleanup_free_ char *line;
>                        ^~~~
> In file included from libkmod/libkmod-module.c:42:0:
> libkmod/libkmod-module.c: In function 'kmod_module_probe_insert_module':
> ./shared/util.h:73:9: warning: 'cmd' may be used uninitialized in this function [-Wmaybe-uninitialized]
>          free(*(void**) p);
>          ^~~~~~~~~~~~~~~~~
> libkmod/libkmod-module.c:1009:23: note: 'cmd' was declared here
>   _cleanup_free_ char *cmd;
>
> ---
>  libkmod/libkmod-module.c | 2 +-
>  libkmod/libkmod.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 76a6dc3..2e973b5 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -1006,7 +1006,7 @@ static int module_do_install_commands(struct kmod_module *mod,
>  {
>         const char *command = kmod_module_get_install_commands(mod);
>         char *p;
> -       _cleanup_free_ char *cmd;
> +       _cleanup_free_ char *cmd = NULL;
>         int err;
>         size_t cmdlen, options_len, varlen;
>
> diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
> index 43423d6..66e658c 100644
> --- a/libkmod/libkmod.c
> +++ b/libkmod/libkmod.c
> @@ -578,7 +578,7 @@ finish:
>
>  bool kmod_lookup_alias_is_builtin(struct kmod_ctx *ctx, const char *name)
>  {
> -       _cleanup_free_ char *line;
> +       _cleanup_free_ char *line = NULL;
>
>         line = lookup_builtin_file(ctx, name);

line is assigned here. Why is this giving you a warning? I remember
seeing these warnings that ended up being fixed
in gcc some years ago.

Lucas De Marchi

>
> --
> 2.23.0
>
