Return-Path: <SRS0=7uvt=3Q=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29566C2D0DB
	for <linux-modules@archiver.kernel.org>; Mon, 27 Jan 2020 13:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB8720716
	for <linux-modules@archiver.kernel.org>; Mon, 27 Jan 2020 13:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpSIDVcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgA0NqS (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:46:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39405 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0NqS (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 27 Jan 2020 08:46:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so11360076wrt.6
        for <linux-modules@vger.kernel.org>; Mon, 27 Jan 2020 05:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2TOgtPtQgES0YOuM1y6e7kBO7bIL9iyF0to8ptT5CQ=;
        b=KpSIDVcsM0xk/D4byrq8clAUAKbRK8qVkQFu+q3WRuDXwsDTPDUXSyQNKTaB3UqlGv
         z+HvuaPn7Qe+5CErC5hr5syEGUSXbL/4Ta+Zv0l30AjMeYDkWODvXQYuwa8wvyFaIYqe
         dS+XNsMdSwhPrbNaxykYNH2M3fP4A6Wr2MxlI9TMulhjpYsvzeu2GSG4jl4pHuUVIAMe
         7XwY4a3GvGQv8hgecFFQQQYtdfCcPKVl8XjRWdsk4WMKG/E1LlOBT/SPC/ZcMubD60eG
         o5Zd9AEsw0A++s2dIah61a9N6obh0qWxvmwrAH6JUg8rh9a0mvJysqeG88IKoWlEI8IE
         9PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2TOgtPtQgES0YOuM1y6e7kBO7bIL9iyF0to8ptT5CQ=;
        b=hUlMEVer576OI0k2RtdLOleR/3PEusi6dT1pqZUGg2kDsGcnNB+7SXESJ7XPZA2zE8
         ScJnC4dueddD0TQzLHoaYjkSv7OmqpFPTZPJwRW2rrWfx7XvBDhQjge2Tu6JBCJHjjOz
         FMFH/PavD0ugxyjMwmNv6jY5r8NId5nnF2JRWXR6mvhrvcYd8oua7AQ6mvmALXD6dGPp
         FO8QoeDDK07h/koXJrcQj7ZahEPQTQSiblPt0St/lR418q1iYVyNrtWnam192+Mvx9G1
         sHXJ8siI3YSKelzmw7gPF06BC7yaqRfOtJojl0n25sO6/POXrG9o1kZfia68YMq8cbI5
         UNgg==
X-Gm-Message-State: APjAAAUiqIlZMa/2H0SIUybf3UxukuhDfhZmTNl11cz2LaLtqnVdk7tc
        QgYwUYBD1ewpghlxFYIUcEnzjGxqP3zqX7y+6rWXK3qWWqRdBg==
X-Google-Smtp-Source: APXvYqx5UlNHOT5IFCZrYCC/Iv/+yWzAnJFSGbSEKzFALioAEPMFAVEM90laN/0UcTiFVpzUQme1HgQn2iitJLrvo9E=
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr21022758wrs.424.1580132775565;
 Mon, 27 Jan 2020 05:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20200120192210.6370-1-lucas.de.marchi@gmail.com>
In-Reply-To: <20200120192210.6370-1-lucas.de.marchi@gmail.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 27 Jan 2020 10:46:02 -0300
Message-ID: <CAKi4VAJjA_G5KZ2Z6uAMKcp-38mF3PfAsfM1MvLQcKuDO7vWsA@mail.gmail.com>
Subject: Re: [PATCH] libkmod: reset was_space on second pass
To:     linux-modules <linux-modules@vger.kernel.org>
Cc:     Jorge Lucangeli Obes <jorgelo@google.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 20, 2020 at 4:22 PM Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
>
> From: Lucas De Marchi <lucas.demarchi@intel.com>
>
> The softdep config parser uses a 2-pass approach to use a single
> allocation for all the softdep struct. However "was_space" variable
> isn't reset between them. This can lead to a buffer overflow.
>
> Reported-by: Jorge Lucangeli Obes <jorgelo@google.com>
> Link: https://lore.kernel.org/linux-modules/CAKYuF5QhGCPCazHQjN-=kFc5kHs7Ok8WqmmGLo31CiOEN8TYdA@mail.gmail.com
> ---

Applied,

Lucas De Marchi

>  libkmod/libkmod-config.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
> index aaac0a1..7b62367 100644
> --- a/libkmod/libkmod-config.c
> +++ b/libkmod/libkmod-config.c
> @@ -335,6 +335,7 @@ static int kmod_config_add_softdep(struct kmod_config *config,
>         n_pre = 0;
>         n_post = 0;
>         mode = S_NONE;
> +       was_space = false;
>         for (p = s = line; ; s++) {
>                 size_t plen;
>
> --
> 2.24.1
>


-- 
Lucas De Marchi
