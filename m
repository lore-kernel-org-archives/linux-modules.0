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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28543C07542
	for <linux-modules@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C3723122
	for <linux-modules@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406951AbhALVh1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437077AbhALU46 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 12 Jan 2021 15:56:58 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13337C061786
        for <linux-modules@vger.kernel.org>; Tue, 12 Jan 2021 12:56:18 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id k4so42742ybp.6
        for <linux-modules@vger.kernel.org>; Tue, 12 Jan 2021 12:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eOuj3nUOkwNzeJ//NA9IcFSibtVsNBDhvztCplpBCts=;
        b=g2Y9j/IELl0J44RG/oZfjlq9sdKlXGnYYtCBhgAGgJNbnoqVSLOUJ6MmPKFOUMLcbB
         PkpRFgWdD89qjvyC0zlNIns3OUltdinDLG1NWnbJA+/l978+w1VKLKtSQthLVvt4scCq
         D2ta09lX5SyX7T43HjC6p/mzbp4Y/lb+64yDlrqon+fAbIPNDl1V9XNGRktkOwAYdpt7
         kyNxRYMSQfc5FOI7hNtpNPVE4g+TkTo6xahPH/zIe7CO63IfpB9twxHS6e8FiKSN6EsR
         Ao3XSAgBtnjJ6oQKudo69uuK/zXh426aWRXMExH8k/16aZIXjG+xVHkLU8Zt2B+ncves
         620g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eOuj3nUOkwNzeJ//NA9IcFSibtVsNBDhvztCplpBCts=;
        b=scm0WmS/MDz3QSk3ga7wFxr5pFVQomCl9cRxUhwHeWjtJbJyZLwHyodWetpCu2S8gh
         IwhhR8loyC7dE17U4vNl+4eMxio3QYykmBy+dYggFSXA5/3Uvh6R8pINZaEKOR1+1KGm
         +oAdaEq+pj+lGvZ9/FMe2/rdpomRvi3o1HhDTbjo5kzXHPjKuIsroY2agv0hG3+oX0XO
         CgNiwC05WkQYHb4iaHg1WJM2l+OqnbpM5xKVaOqo8rk+b+54Rk/FPab/rpOWQWw/2i6d
         XWVam4NhnkXdh2PyP/emvWuj7BJrxo+pOS2pJFErjPvgbLOFDYIvx7tYiVeR4D7h997/
         ETOQ==
X-Gm-Message-State: AOAM531YnQH/mlkbLhp0pXhhag3NL62MWY6F/MS9F00g+oQxMZs/Lw1E
        qWdQgX0wSObT2KWSOgIrVAokXZJQp7S9TqoNoo1ybT3qIlQgZnF2
X-Google-Smtp-Source: ABdhPJwsF98C6BPin0zR4mXf3yHzzNm87Oi3/coBjMjdbstHC7xTNEzr7mxwa7Am0Rd9afgspCSClMtRYthTf7lQhx8=
X-Received: by 2002:a25:b06:: with SMTP id 6mr1974206ybl.134.1610484977322;
 Tue, 12 Jan 2021 12:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20210112160211.5614-1-msuchanek@suse.de>
In-Reply-To: <20210112160211.5614-1-msuchanek@suse.de>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 12 Jan 2021 12:56:05 -0800
Message-ID: <CAKi4VAJKxUVtqFGkCkeL5hc+Uuyh94Nzt+c1zLpSEdbvzjjwaQ@mail.gmail.com>
Subject: Re: [PATCH] modprobe.d: load from /usr/lib.
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        =?UTF-8?Q?Marcus_R=C3=BCckert?= <mrueckert@suse.com>,
        Takashi Iwai <tiwai@suse.com>,
        Dominique Leuenberger <dimstar@opensuse.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jan 12, 2021 at 8:06 AM Michal Suchanek <msuchanek@suse.de> wrote:
>
> There is an ongoing effort to limit use of files outside of /usr (or
> $prefix on general). Currently all modprobe.d paths are hardcoded to
> outside of $prefix. Teach kmod to load modprobe.d from $prefix/lib.

/lib came from module-init-tools and we kept it for compatibility. It
became a non-issue when distros
decided to just merge them and do a symlink /lib -> /usr/lib following
https://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/

what distros didn't do that?

I also fear the solution you want here is not so simple since now the
configs will be added twice
if there is the symlink.  And if we just drop /lib and start using
/usr/lib we break compatibility.

Lucas De Marchi

>
> Cc: Marcus R=C3=BCckert <mrueckert@suse.com>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Dominique Leuenberger <dimstar@opensuse.org>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  Makefile.am        | 1 +
>  libkmod/libkmod.c  | 1 +
>  man/modprobe.d.xml | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/Makefile.am b/Makefile.am
> index b29e943a4d29..702a665f0334 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -19,6 +19,7 @@ AM_CPPFLAGS =3D \
>         -include $(top_builddir)/config.h \
>         -I$(top_srcdir) \
>         -DSYSCONFDIR=3D\""$(sysconfdir)"\" \
> +       -DPREFIX=3D\""$(prefix)"\" \
>         ${zlib_CFLAGS}
>
>  AM_CFLAGS =3D $(OUR_CFLAGS)
> diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
> index 43423d63a889..9399c6c902f8 100644
> --- a/libkmod/libkmod.c
> +++ b/libkmod/libkmod.c
> @@ -65,6 +65,7 @@ static const char *default_config_paths[] =3D {
>         SYSCONFDIR "/modprobe.d",
>         "/run/modprobe.d",
>         "/lib/modprobe.d",
> +       PREFIX "/lib/modprobe.d",
>         NULL
>  };
>
> diff --git a/man/modprobe.d.xml b/man/modprobe.d.xml
> index 211af8488abb..ae5a83986a52 100644
> --- a/man/modprobe.d.xml
> +++ b/man/modprobe.d.xml
> @@ -40,6 +40,7 @@
>    </refnamediv>
>
>    <refsynopsisdiv>
> +    <para><filename>/usr/lib/modprobe.d/*.conf</filename></para>
>      <para><filename>/lib/modprobe.d/*.conf</filename></para>
>      <para><filename>/etc/modprobe.d/*.conf</filename></para>
>      <para><filename>/run/modprobe.d/*.conf</filename></para>
> --
> 2.26.2
>
