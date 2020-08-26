Return-Path: <SRS0=Sldx=CE=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8A6C433E1
	for <linux-modules@archiver.kernel.org>; Wed, 26 Aug 2020 10:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373FA206EB
	for <linux-modules@archiver.kernel.org>; Wed, 26 Aug 2020 10:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJqcyqc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgHZKM1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgHZKM1 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 26 Aug 2020 06:12:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C01C061574
        for <linux-modules@vger.kernel.org>; Wed, 26 Aug 2020 03:12:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d10so292497wrw.2
        for <linux-modules@vger.kernel.org>; Wed, 26 Aug 2020 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+pZ7xiUKLgQ1svLeV8q6vPSSRm35giyv1QTtLks5t74=;
        b=CJqcyqc6Sw4CltpKy4utN1VlQbIQBY2/wiAEro4r1K/N3KIGExmtCmkl96JV+dq/sE
         kX6tQGjXsaMGfH1wzOEPM8fFli0Y7W7ZDlAWwmu8OjZE3SOib6KKKzjrOOhOCtPdz4yr
         1zbHyty/AFP6IHC5J1viWBjqWfO3C1Sc/4xurN9GtsAv6fTX27B02Ly6M6bXMyfr4QjC
         Pfse8ufjqb/nMdP1DLbgzWpBQJq5b+W76/39c0s9FX+3s4iczz7FjQzcUdFoGNERxqVK
         o/nWx7sn1f+J/PVkKpxt+1FfjTC/+qlQESgE9oj7BCcdfdvkywztf6tcBNge+Ve2yQYs
         mLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+pZ7xiUKLgQ1svLeV8q6vPSSRm35giyv1QTtLks5t74=;
        b=CxCTeVcWZfY8Hu1dsaKdgEugXvucjR24wo8H2iKuQyLl+jjUfmhneMzBRhzcmuJBN3
         bV2ScIrY85qMrfjQ5zIt5onOLowPVWplK0IyUsG1VEO95OE38163yZly1NBtjODwycon
         iUupOVE/0wIDcbleT0Q5z1c6ronQ96ZlkgVPAfnrUtSW39DMnm4hXPq7rzE2ytHyf6kx
         Ild+nBwPNHvzk1Gvzn6+EQw9Owl7QfGfHeTIRo2XjCgfujMIrWAeMI0cnLU4jTRN+dPf
         te2WcjE0pms0nzvYxZyVLFNBIFkBl+zQoFCoVD6Pl2I5pR/DH++xC3ivzfXhO1V2I3IO
         Rp4Q==
X-Gm-Message-State: AOAM5328/5In6AfJ/N0CWZ2hwKy4SR28MEekhoukAHWM3rDbphmlUkfN
        HEU8H+lIz43R6bd7sO1Q0JlV3vX0s0oqBaAgCC4kIz3Ez+U=
X-Google-Smtp-Source: ABdhPJywVkNvPZk55IrGblioIjpY+e/z5AxHVF4AvYP3nuaYMLgsGWCT08CZkxnoSVGFFg5j5qZDySoRzsmprnXtOjA=
X-Received: by 2002:a5d:4e02:: with SMTP id p2mr10773598wrt.276.1598436745430;
 Wed, 26 Aug 2020 03:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200823215433.j5gc5rnsmahpf43v@blumerang> <CAKi4VALERCR92nf+D00knka4NOrUM+P2TY7Rs+zoLOvi_8iQtQ@mail.gmail.com>
 <20200826093627.ukw4hwff2wxb6ykh@blumerang>
In-Reply-To: <20200826093627.ukw4hwff2wxb6ykh@blumerang>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Wed, 26 Aug 2020 03:12:13 -0700
Message-ID: <CAKi4VALaCE2U_e5aovDmRgQq1k_GTSANFtVaX_Phz7b5U2bwqQ@mail.gmail.com>
Subject: Re: [PATCH] modinfo: dont print module name when --field is given
To:     =?UTF-8?Q?Xaver_H=C3=B6rl?= <hoe.dom@gmx.de>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Aug 26, 2020 at 2:36 AM Xaver H=C3=B6rl <hoe.dom@gmx.de> wrote:
>
> On Tue, Aug 25, 2020 at 10:27:46AM -0700, Lucas De Marchi wrote:
> > the name would be handled by the next if/else branch. Unconditionally p=
rinting
> > the name at the beginning for built-in modules doesn't seem something i=
mportant
> > to retain. I'd rather handle it in the `if (is_builtin && err =3D=3D
> > -ENOENT) {` below just
> > not to exit without printing anything. In that case, printing both
> > name and filename
> > would be preferred, so the user knows why there isn't additional inform=
ation
>
> Dropping the "name:" part with --field seems the right thing (updated
> patch below implements this). But I don't know what exactly to do about
> the error case, not sure if I get your intention right there.
>
> If --field is not given, the name and filename (i.e. "(builtin)" in
> this case) will be there anyway, on the other hand if --field

I was thinking about this specific error condition:
                if (is_builtin && err =3D=3D -ENOENT) {
                        /*
                         * This is an old kernel that does not have a file
                         * with information about built-in modules.
                         */
                        return 0;
                }

I.e. if --field is not given and the kernel is old enough not to contain
/lib/modules/$(uname -r)/modules.builtin.modinfo, then we print
name + filename (builtin).

$ modinfo unix
name:           unix
filename:       (builtin)
alias:          net-pf-1
license:        GPL
file:           net/unix/unix
$ sudo mv ll
$ modinfo unix
name:           unix
filename:       (builtin)


Lucas De Marchi

> _is_ given it seems a bit inconsistent to give additional output.
> Unless you consider this case an error condition of sorts, but the
> return value being 0 suggests otherwise.
>
>
> Thanks for having a look at this!
> Xaver H=C3=B6rl
>
> ---
>  tools/modinfo.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/modinfo.c b/tools/modinfo.c
> index 0231bb0..b49f622 100644
> --- a/tools/modinfo.c
> +++ b/tools/modinfo.c
> @@ -178,14 +178,21 @@ static int modinfo_do(struct kmod_module *mod)
>         is_builtin =3D (filename =3D=3D NULL);
>
>         if (is_builtin) {
> -               printf("%-16s%s%c", "name:", kmod_module_get_name(mod), s=
eparator);
>                 filename =3D "(builtin)";
>         }
>
> -       if (field !=3D NULL && streq(field, "filename")) {
> +       if (field !=3D NULL && streq(field, "name")) {
> +               printf("%s%c", kmod_module_get_name(mod),
> +                              separator);
> +               return 0;
> +       } else if (field !=3D NULL && streq(field, "filename")) {
>                 printf("%s%c", filename, separator);
>                 return 0;
>         } else if (field =3D=3D NULL) {
> +               if (is_builtin) {
> +                       printf("%-16s%s%c", "name:",
> +                              kmod_module_get_name(mod), separator);
> +               }
>                 printf("%-16s%s%c", "filename:",
>                        filename, separator);
>         }
> --
> 2.28.0
>
