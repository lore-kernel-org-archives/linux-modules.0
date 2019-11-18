Return-Path: <SRS0=PaVa=ZK=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B53C432C0
	for <linux-modules@archiver.kernel.org>; Mon, 18 Nov 2019 22:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4940D222EF
	for <linux-modules@archiver.kernel.org>; Mon, 18 Nov 2019 22:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBW/5PuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKRWSW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:18:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40838 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfKRWSW (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 18 Nov 2019 17:18:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id f3so1105811wmc.5
        for <linux-modules@vger.kernel.org>; Mon, 18 Nov 2019 14:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GMyhQg0rAxGXDELJrh6PmYkO5j0/ZpqpnSXImUdtok=;
        b=VBW/5PuNbFJOpyinIiDH3ugx9pHSdl0db4KVWsHAHv/aZMX1d4dDcVDmI1aua0NDYm
         2KyxCB+pl5qvXdBiglrOJ3v1h4oYaBn4MY5b2JvitvAchslOEaNGLcgmdfDQybFSkFbj
         NtZjCWXSo3Sx2E7Lbf/0QbaYOHffD8QmmSFdTvlxK8p8uEavXhunFeyqzLurBj1IYVvq
         LSvFn9N7W+Sv4Bg4pOCDbTggnmPKyyyRLd55LVLQIj0xUyK5EapcO6PGxZcHj/p5NO00
         n/LH6uoojrvVRfxzKB8i/PlxwjJpNJEWLo9EY2DSkTc4ugwkUsCZWWasV4m1XiyWmHYa
         bURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GMyhQg0rAxGXDELJrh6PmYkO5j0/ZpqpnSXImUdtok=;
        b=mFUCKhAcamHNfXtu42/BEShOJJJQf1Tn68eQds8eeReK+JqZdGCmBSEUklMUx+xKJB
         lzur5FxiTk5Jxs2WW1gmdTKLGbhzMwkRB0x3SozYoXmo6Nz1pfoOvbU0l+ku8XnX14Lg
         ya1tcL8q2q0LDcTPw7/wyT52BQMfQeXOh0JFQZqXt4CrrPtkKuAdOruMxo84LIvNr0Q6
         ko2Qm1Ml3AVLuONT1qEPyLGwI5XVZjT0oD2B9RPNIow33OE3CgALUrOgga6A8DLKL2jJ
         ZzfI0vMzo7x2+7qHRBthfb7rinnlKrA5li5PfXxZ2Nn2ammodoWhGVPFJaCOXnQVn+ic
         aCPg==
X-Gm-Message-State: APjAAAWrsg1VpViymuBbZrMCg2fRdxTsWLKnSG7bJBkYOefNqjp6Sx+R
        g9gazIOrZrAtsYHXNAVplEUEL50qrViDkaacTOg=
X-Google-Smtp-Source: APXvYqwaW90Qpc+YPtkDtZxrzXoh8ErZY6Fh9i42a+bARwz/6ZpZpDLBEo2kzj4/juebzzfp6vgkXQHwihnmMVbhlzE=
X-Received: by 2002:a1c:a743:: with SMTP id q64mr1791885wme.44.1574115500309;
 Mon, 18 Nov 2019 14:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20191118215617.395319-1-fontaine.fabrice@gmail.com>
In-Reply-To: <20191118215617.395319-1-fontaine.fabrice@gmail.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 18 Nov 2019 14:18:07 -0800
Message-ID: <CAKi4VAKB1myn8AuMaV3SjBrthNiTxc8TkE18w95BPdRuzQBn2g@mail.gmail.com>
Subject: Re: [PATCH] Makefile.am: filter -Wl,--no-undefined
To:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Nov 18, 2019 at 1:59 PM Fabrice Fontaine
<fontaine.fabrice@gmail.com> wrote:
>
> Commit 1d14ef82f4a3be741bcdf6b1c6d51ce9dce43567 does not completely fix

CC'ing Thomas.

Lucas De Marchi

> the build with python 3.8 as we still get link failure due to
> '-z undefs' being ignored by some versions of ld.
>
> Indeed, -z undefs was added by commit
> 97a232d7335f3bd0231fd9cd39455bde1d563922 in upstream binutils, and this
> commit was first present in binutils 2.30.
> So any toolchain using binutils version older than that won't have
> -z undefs and will build fail on:
>
> /home/buildroot/autobuild/instance-0/output-1/host/opt/ext-toolchain/bin/../lib/gcc/mips-linux-gnu/5.3.0/../../../../mips-linux-gnu/bin/ld: warning: -z undefs ignored.
>
> /home/naourr/work/instance-1/output-1/host/opt/ext-toolchain/bin/../lib/gcc/aarch64_be-linux-gnu/7.3.1/../../../../aarch64_be-linux-gnu/bin/ld: warning: -z undefs ignored.
>
> So filter -Wl,--no-undefined to fix the issue
>
> Fixes:
>  - http://autobuild.buildroot.org/results/e9645d9969481b09f507f6e0d0b35faaa283eb60
>  - http://autobuild.buildroot.org/results/06a6d865b6b7d8ebd793bde214f4a4c40e0962e1
>
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> ---
>  Makefile.am | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 8e9c90d..47505c1 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -173,7 +173,10 @@ CPYTHON_MODULE_CFLAGS = \
>         $(AM_CFLAGS) -DCPYTHON_COMPILING_IN_PYPY=0 \
>         $(PYTHON_NOWARN) $(PYTHON_CFLAGS) \
>         -fvisibility=default
> -CPYTHON_MODULE_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version -shared -Wl,-z,undefs
> +# Filter -Wl,--no-undefined to fix build with python 3.8
> +comma = ,
> +CPYTHON_MODULE_LDFLAGS = $(subst -Wl$(comma)--no-undefined,,$(AM_LDFLAGS))
> +CPYTHON_MODULE_LDFLAGS += -module -avoid-version -shared
>
>  if BUILD_PYTHON
>  pkgpyexec_LTLIBRARIES = \
> --
> 2.24.0
>


-- 
Lucas De Marchi
