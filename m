Return-Path: <SRS0=j9+u=CD=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56480C433E1
	for <linux-modules@archiver.kernel.org>; Tue, 25 Aug 2020 17:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3643120706
	for <linux-modules@archiver.kernel.org>; Tue, 25 Aug 2020 17:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k88cbixX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHYR2E (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHYR2B (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 25 Aug 2020 13:28:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D599FC061574
        for <linux-modules@vger.kernel.org>; Tue, 25 Aug 2020 10:28:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a65so3293722wme.5
        for <linux-modules@vger.kernel.org>; Tue, 25 Aug 2020 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WPrygzvQbeXYlDb9zp3K/zodsjmwgcRKnTEnTl7emgI=;
        b=k88cbixXTh/xbjvFsiaNrPFJBe1i+6cN5oaz+MxGjhyarf5MjLRRHTe9KoYILKPWgq
         lXUk+4FvUThBZkARcpR1BJHnWXgcOUTLLJkK/3ZaOKcPaSQ+VlguPMV08mhDf3GJaITU
         RHWoSwuxcX0PbFqFkyyZ32wILycvgRZNLAunEG7uBDxSVsI0DXu1tmE/gy627ASCj0rY
         DAIg4XFB/pf0mwO67je3gd5hbK+8LnVaQavpjOQw4TKyYuQ6IGvgOszv6YT0FFrIeWAu
         TF+rvtFH6b2FoxN4Wr+4mC9e8FlU/gi6SA9JSKxw1rtX7u+VGLpJsX/ZZ4RWR0ML5zsI
         8x2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WPrygzvQbeXYlDb9zp3K/zodsjmwgcRKnTEnTl7emgI=;
        b=VkybDEitqKwUXwsBSgmedQzckxIcvvgnOFUciyWrm+BHfAHfpODkb6UqoW9cFfT+hl
         M9d/xmjBu0I9/uEjW/fhpoJnSPaDIDBN9RGJGpQb1Nw+c2Wzgu9yyJRW+LQPLXv+W4PY
         ku9J00ptgk0QWh4Jieij2kPTvJz3T69QCcGxkfEpwlBbrIZheMSMOpjP6T2OEc218TUy
         dHgvSefSjAAEQD+Yrfb5nIyQvLDEQ5PgFXgAKcex3vTBQIMb3mvA6SWfy5gCczCPc+8j
         kdxnYWezYgToCUUFOulKSb6Kh+e0DG2HkZQSdCEgllxSOIBVaheBUdFCoLd/UEUnrNVU
         q0/w==
X-Gm-Message-State: AOAM5323NUkWRk2wv6kdaEku0H9UkmflhLdkIWy9PeJpEIoUwW8wNVmD
        b9wgVB6HRGT+4gc1s3U6pOsM8nA3PRV/b+rrCvg=
X-Google-Smtp-Source: ABdhPJzYNZ55Wl3a9pBSOyonbsaSTXuthNaHC4kf81Cnl1FGNXZJYXEwAs9tf2G/Ju9GnViFsyoG1ArFkAGTqR4KfLw=
X-Received: by 2002:a7b:cc90:: with SMTP id p16mr1956899wma.100.1598376479441;
 Tue, 25 Aug 2020 10:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200823215433.j5gc5rnsmahpf43v@blumerang>
In-Reply-To: <20200823215433.j5gc5rnsmahpf43v@blumerang>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 25 Aug 2020 10:27:46 -0700
Message-ID: <CAKi4VALERCR92nf+D00knka4NOrUM+P2TY7Rs+zoLOvi_8iQtQ@mail.gmail.com>
Subject: Re: [PATCH] modinfo: dont print module name when --field is given
To:     =?UTF-8?Q?Xaver_H=C3=B6rl?= <hoe.dom@gmx.de>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun, Aug 23, 2020 at 3:01 PM Xaver H=C3=B6rl <hoe.dom@gmx.de> wrote:
>
> I hope I found the right mailing list for this issue, which
> came up here: https://github.com/NixOS/nixpkgs/pull/96008
>
> The man page for modinfo claims that with the -F / --field option only
> the specified field gets printed. Currently this is not true as for built=
in modules, the name is always printed.
>
> Try something like "modinfo -F firmware unix" for example.
> It will print: "name:           unix"
>
> So either the man page needs to be updated or the behaviour changed.

yeah, it seems something to change in the code. This behavior
started when we added support in modinfo to show information
about builtin modules.

> The following patch should fix this:
>
> ---
>  tools/modinfo.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/modinfo.c b/tools/modinfo.c
> index 0231bb0..7b2259e 100644
> --- a/tools/modinfo.c
> +++ b/tools/modinfo.c
> @@ -178,7 +178,10 @@ static int modinfo_do(struct kmod_module *mod)
>         is_builtin =3D (filename =3D=3D NULL);
>
>         if (is_builtin) {
> -               printf("%-16s%s%c", "name:", kmod_module_get_name(mod), s=
eparator);
> +               if (field =3D=3D NULL || field !=3D NULL && streq(field, =
"name")){

the name would be handled by the next if/else branch. Unconditionally print=
ing
the name at the beginning for built-in modules doesn't seem something impor=
tant
to retain. I'd rather handle it in the `if (is_builtin && err =3D=3D
-ENOENT) {` below just
not to exit without printing anything. In that case, printing both
name and filename
would be preferred, so the user knows why there isn't additional informatio=
n

thanks
Lucas De Marchi

> +                       printf("%-16s%s%c", "name:",
> +                              kmod_module_get_name(mod), separator);
> +               }
>                 filename =3D "(builtin)";
>         }
>
> --
> 2.28.0
>
