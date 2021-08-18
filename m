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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B26C4338F
	for <linux-modules@archiver.kernel.org>; Wed, 18 Aug 2021 19:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D0A60BD3
	for <linux-modules@archiver.kernel.org>; Wed, 18 Aug 2021 19:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhHRTOQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 18 Aug 2021 15:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbhHRTON (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 18 Aug 2021 15:14:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA5FC061764
        for <linux-modules@vger.kernel.org>; Wed, 18 Aug 2021 12:13:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d4so6806267lfk.9
        for <linux-modules@vger.kernel.org>; Wed, 18 Aug 2021 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DeGpNsn5fmUYo3C5RQ26Fb13o7IwQjQdkhKmioYgAw=;
        b=jJeJeCGuFVcPaiWwWwCbpzIyr3Dzf7vHjXc7ZahHlZwORWCN4z6lB2A2R4Hn58JMLP
         DXDVtgatghiPS6GusDXSn5keYUrHC0csJg6pUmTEj9bVKKiBNOg7JF4EvwhiBdY1eCng
         eN7KowCPq2y2Ai72yWYZnppA9ZQQRiL6sajLx2FM/xvQJkduTzZrhLTZgnvm+6v6qBhZ
         kT/tuvMNOxYRGE5J1LhxQewm+HiznJWSaoN/9R+Ss8YH9i70JNdJNY5koI/cBVnf1WSm
         3r3OHJ6MN+AqAHKR9+CK6CUD+h6ghCM26tOc91lb45glHZ7o6tf+nb/uFyKrUoz+hotu
         FNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DeGpNsn5fmUYo3C5RQ26Fb13o7IwQjQdkhKmioYgAw=;
        b=bs3TeJBqeP0dxodNfu4LtKUsPN1ZloEV+XPuJ9tlnLlZ/iHPTN7D2tNYsKXEz2w0g5
         PeIkISRDgvLI53WKOVnroYOpg2ePON4JUgn/eLbFL/WGB1kBefe40y/LgvLwT7fKiWaz
         lr5Dc5pgEKU+Cm+5madjS3U2ijXD8KI3Ma1b63Mt/0+hFI/d0S9pcgaYpTj23LkRBQlm
         EA923SoMxBYrV526p8PtnxDwRIrBCWqblgmJjixTBI772BOH/22UPZI3+dUl3R3mqTxg
         ERGC+qu1AdDmQpnFNNg2hfd5EXoCcg28xE4XgheXk78D4kVI/YYULKJ1hYPwxkD03FTq
         wZ3A==
X-Gm-Message-State: AOAM532ayYD+yIM0DApJICQyPDwcLvLSjdwkjatBY/STygi84pH1i0Dz
        h0jaTr6n0blRmWr96c7bJf1kfAug2T7plYhqx0c=
X-Google-Smtp-Source: ABdhPJwoxgv+irFS5Vp6wdKlZIeuZLeF49fGOaTPPj7iGZJVN77MgOxdTlx6X0T3HukBODdHm8wskL5rBrPJde+8mSk=
X-Received: by 2002:a05:6512:32c8:: with SMTP id f8mr7383049lfg.351.1629314017075;
 Wed, 18 Aug 2021 12:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210818112203.24863-1-tiwai@suse.de>
In-Reply-To: <20210818112203.24863-1-tiwai@suse.de>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Wed, 18 Aug 2021 12:13:24 -0700
Message-ID: <CAKi4VAJVvY3=JdSZm-GD1hJqyCPYaYz-jBJ_REeY5BakVb6_ww@mail.gmail.com>
Subject: Re: [PATCH] modinfo: don't parse built-in for explicitly given module files
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Aug 18, 2021 at 4:23 AM Takashi Iwai <tiwai@suse.de> wrote:
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
> This patch addresses the regression by checking the presence of the
> module path at first before checking the built-in module.
>
> Fixes: e7e2cb61fa9f ("modinfo: Show information about built-in modules")
> BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1189537
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  libkmod/libkmod-module.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 6e0ff1a99604..9e878a5345a1 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -2292,7 +2292,8 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
>         assert(*list == NULL);
>
>         /* remove const: this can only change internal state */
> -       if (kmod_module_is_builtin((struct kmod_module *)mod)) {
> +       if (!kmod_module_get_path(mod) &&
> +           kmod_module_is_builtin((struct kmod_module *)mod)) {

thanks for spotting this... but I'm not sure this is the right fix.
kmod_module_is_builtin() shouldn't return true if the module was
created by path rather than lookup. It seems we should rather set
mod->builtin = KMOD_MODULE_BUILTIN_NO in
kmod_module_new_from_path(). This would also fix the use of
kmod_module_is_builtin() directly by applications.

Since the builtin check uses lazy initialization,  the default is
KMOD_MODULE_BUILTIN_UNKNOWN, hence the bug here.

Lucas De Marchi

>                 count = kmod_builtin_get_modinfo(mod->ctx,
>                                                 kmod_module_get_name(mod),
>                                                 &strings);
> --
> 2.26.2
>
