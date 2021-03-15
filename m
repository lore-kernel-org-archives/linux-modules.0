Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A339AC433DB
	for <linux-modules@archiver.kernel.org>; Mon, 15 Mar 2021 20:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA7864E90
	for <linux-modules@archiver.kernel.org>; Mon, 15 Mar 2021 20:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhCOU0h (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 15 Mar 2021 16:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhCOU0M (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 15 Mar 2021 16:26:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFE3C06174A
        for <linux-modules@vger.kernel.org>; Mon, 15 Mar 2021 13:26:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x4so52222406lfu.7
        for <linux-modules@vger.kernel.org>; Mon, 15 Mar 2021 13:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lds8ZD/SW40IdgKmNQ3JBh4VXjFkpdP44VXrvXjqTyo=;
        b=seeRY0WSt3/3Xc+TMl49IHLFJ3EuRIH/EJoCi/smdsUBcyUjitkK+9dCTJ2sUunoOZ
         jyn240RgWkb0WJrz/AOB7aLbaYPTVKz6LEIyD57qJKB6S40J69EeOdXf83lTrKH8N1i/
         ssyNu1RyYlz1ZoUgYrUThMuDjRdEmvpvwxDVu0yJqMskAk00DGD69f0oElMoqvDpZ/R+
         Cvj47umb/ej3tdeg153Mp7aAI2jbdvviMQh+vBPa5A0WXyyhXpVy2SEWJuyya7wry24d
         xcH1AdWOv7qw1+gdOeEJmEucyfCkL1xM1ay5zpyR03/AMd5sjZQXnM+FnXfke2VdHMx3
         G1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lds8ZD/SW40IdgKmNQ3JBh4VXjFkpdP44VXrvXjqTyo=;
        b=nCGbo6nHVVAXpwraInoRzn5vub2tvyfzWuUfu0yKM9fiJdKSA4zgiCX5xI46I4YS4Z
         KFxBFYqs2Cz9RBHexf7kiiBs2gX4dmjLNlA8gMngY/wjPmVCGJFRZQ8udG8E9RNK2QbY
         Gzqv191ctorU0zzMadl1F48fvHLW8E1BX9p31enYurwD24fOkFqfEjJgLXBodxZRkhsY
         ePjHURgVO2XgTwXc0yvuIlI42/hsUtMkfuvJSveh21JFzrh5QwXLsz3fwcbgGylYIpdE
         XAB9Fb9Afj2jZSsVK6l0U8nS1rTyR4WjQvqnshOsZ7jZA400wMk9pZ/s+KeO7+pdE5bX
         rbwA==
X-Gm-Message-State: AOAM533qIc0MQS5PZM6859kEImFMs1MEFnQWPSTq/Ll+r4dvyu5W21EP
        b/3KcKS6RfboEOZHaGuMlDefsLsapvqGMg6gVWzKu2in
X-Google-Smtp-Source: ABdhPJzu6iAhvWkUSRPcZ7759f4ecJZEc5YXoI5jLZLRVADUlHXKQQRU07QLdafpBaiDNxA2PuEJF+A1y6ysSGHPxsI=
X-Received: by 2002:ac2:5e26:: with SMTP id o6mr9153821lfg.355.1615839966879;
 Mon, 15 Mar 2021 13:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210310172652.13638-1-lucas.demarchi@intel.com>
In-Reply-To: <20210310172652.13638-1-lucas.demarchi@intel.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 15 Mar 2021 13:25:55 -0700
Message-ID: <CAKi4VAJGg2AgxrJ5y9+GauJ1uRRiYt1xTWfaiaunA2+ey7XTXg@mail.gmail.com>
Subject: Re: [PATCH] libkmod-config: more chars allowed as space
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 10, 2021 at 9:31 AM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> Recently in a discussion I noticed that kernel allows more chars to be
> considered as space in the kernel command line. Switch to the equivalent
> of isspace() instead of considering only ' '.

Applied,

Lucas De Marchi

> ---
>  libkmod/libkmod-config.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
> index 2873f06..4fdd40f 100644
> --- a/libkmod/libkmod-config.c
> +++ b/libkmod/libkmod-config.c
> @@ -543,11 +543,14 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
>
>                         break;
>                 case '\0':
> -               case '\n':
> -                       /* Stop iterating on new chars */
>                         iter = false;
>                         /* fall-through */
>                 case ' ':
> +               case '\n':
> +               case '\t':
> +               case '\v':
> +               case '\f':
> +               case '\r':
>                         if (is_quoted && state == STATE_VALUE) {
>                                 /* no state change*/;
>                         } else if (is_quoted) {
> --
> 2.30.1
>
