Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415CC4A0EF8
	for <linux-modules@vger.kernel.org>; Thu,  1 Oct 2026 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887730; cv=pass; b=n3/2ZLNcSPeo1MLMRMNSGzkies4in203UYjdTY5wGBKZdifzEG/uxKLNxRHe71DdkuFgcNYev0AyV6yyYKYzn6BQPazLUgnxp4HzezMqSuLaLxzmim3C0pO5HAy41uvJnL1+QasIH/C6GawkHMMmWc3ZMcQ2c3lLCgM0JCwdGqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887730; c=relaxed/simple;
	bh=tOUyUtD9YzGjF21bX25M8K+WYH8Q/K7pCMWsEnYbjKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fogUCvvbBAuEV3kVK6Xd5UpvimtSoCqo4H88zMkqBgD8oE4CZR+5hYR9It1g4vh3TeCxKnhQDrDkHYAww0Th/ZR8+Uco93tieGD3ExQKrJXBH1lKoux5Bi4PvnbiaG0u6nbIYv3yp2ZuXKKfpHZNynthY1c3K9JelE3TU1XIItA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP8w5boi; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP8w5boi"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-6768ac36eb6so2121721d50.3
        for <linux-modules@vger.kernel.org>; Thu, 01 Oct 2026 13:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790887728; cv=none;
        d=google.com; s=arc-20260327;
        b=ga+lcw+AMimW8V1DrHh3U0KYgsIGPebQS+yVy+DVUwuEE5SqgbgPvGDz/GHLaLpl0g
         ZS6dTuP5wm+/kT/+dW/tIM2BsW5pa5rfJrWV/fA+4fWfRPcX5/j1O+xa/HGkf9yC+FEf
         cwL3p1HtnvSuUSmLpBmKPMIjb2GOXnqhvFIljbu96M1+e40fD23TNFcMK4IzYIYwldzu
         I91zW/XLIZmSFouegGv5FMdbJj1L0nAkCbmU4oYZf9URcrfIhes0D8EkVHzhqxUTo4Sy
         Hfity71iPu8YWfVRXS1eR4fznqqdJT96BoNQE3kamB2Urlb99Go9ivsVqt2UIsPW+Qnc
         oyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hXzdK5QWID3MCeLjE3WVpfx7nvstpzl0h0tds4vVtak=;
        fh=n7FKPHlYAIp+J9KAl4Bm0+JphIkSnt3jlp9hlG8EtGA=;
        b=CBiCSWOC7ZpZDMFUEhGHUPiTxuNNiaHQ+zcfNAgJjFFZg6gwhumViqJNPEp+VOGZO7
         VKtav0zg1zcpdX1qIAF03pzRPkTBQWNCPbr00tr7luxpqLgA/0nbi+nTehDVQ15IB/fG
         K+B2zzIIRu4XrksKYFlizLjJgnvM88EqW1ZXYdI84wALuGwmG0zV5o7uAUNSqyF+0+4o
         mCwx3yNHQ9bKQEVAl7CIOCR0a+aoI8xEntR1uI9WM6y0iVkCpC6gIT+F89K0rk5h9872
         t1FzOPduEdFcBznnk1l2l8OBp9kC2XYNfe+j9Fu1Vrnu+X7AtNMFMk1EzeRWBLL7nWz4
         bl9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790887728; x=1791492528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hXzdK5QWID3MCeLjE3WVpfx7nvstpzl0h0tds4vVtak=;
        b=KP8w5boikPWa+Qy6o6x58zbUVEcZfwonULl13siQYnubBUmYmsf/aXYYDWN9fTnoyl
         IvZ8BtnejtMZDojzvwFodugbtcqHX/ygvu1nAag33JvO8G2sK1kV08sErYtMTmr1usvt
         2pBVFmIS/5bl1n1tSAMO7oiP+PYQqa3aKE54VicmAFytrh74akLuKleWVBSFyIWgqT4f
         jbrXHGtvdlwUtiN/jGtj1rNRznFTdim5IOLKAXHRYjzFjhRayfDz6uewzSNUO+B25uND
         k9qiLazOvMBoPjriQjbHMXYJ4v2PpOGSm7PrBMx1ds9HpW9X3cNJILq2P13sC1jXzKcH
         v+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887728; x=1791492528;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXzdK5QWID3MCeLjE3WVpfx7nvstpzl0h0tds4vVtak=;
        b=rVAjfwlkCXUHfqn6vrJLjuJT2NRTAEdHqmebVTFtOTAdhsgc+y7IbD7jBa9DQI0gba
         G8egjxzOHVTYKrG1vlbrBuoAFgmP6IHI58H6OJu6kSnh+uGXPZhWCZir9uk0B/iYrmQ4
         98U2vZo2iJY4Gh04uQ0h3/WJITL3sWm5l8242JLFcy10PwYMhtHB2JSkw4zgdSl1lSW2
         bchlDcHXq60T4L6/zzkv/Zt1sn7Slh4AjQnni41IdbOHXT15j1Lq9mA8TDM+sRLePo4s
         SrSaJZ/Lqor7RDfZT9VZPOoFpFGUhvy0AaHAi3/uQOkxuPpcdudkPCJCHkJrL2phH0uH
         WZyA==
X-Forwarded-Encrypted: i=1; AKwUvByrvUQ/Y3U46tUEbtCnPl1fMIqslgsdKz7REiscKWTbHGK/Ds14KEjJpJOutITymnPPU/6DKA1ymeUVDXnf@vger.kernel.org
X-Gm-Message-State: AFq9FYKZY3E7MJ72ozpHd3ddwLeNpq2S3y0taBsz8WquzoBJxW6jPnlf
	LMddOxEj049FUy2nQ7+QtR/e8cuO8/yM/EnAp6G3pf0zzVubKfG0f5zpUFSENPJQLzZxTMjW71r
	eOkzSA1GAPJWPeRXpEaSwaoVWHCj31K+irm1s
X-Gm-Gg: AYBFou3cueMXyEoorceQH12YZ8WmLFhJZ87Wr5+pLuieOMWRrz6JtpU0sEZPbrZSlZx
	mnGPYlAI5CZrUQVdXscLFZYPf9VC/qboQbQP75kBv37isrEV28Y+29UcQnS5dUMyka7z63yqtkF
	oMQ3ZtjLhcKeBqGEc2uWT/BqBFcnWaXANY4EDR0s8nyzfIvg9rfqgKm1DJ0pgmua+twbm0FSmyi
	qMscRzmwbBOswHg5ek64X6kTCGEOYwIryuAqiBrhJJBVnjYtxT8LSCY7m/1aKz0eHzIllm6+aTP
	hSygA3JYmEdogh9q5Hxlsk125p7mTHc/3OeS+n+Scv1Wz27H9sGpzgLtPp1qqgjPOQ3lIyqYAFk
	6/BBlzh2wdeH6CWwt26ZiJdTunbOvb+W8hx6S5QLapOr5
X-Received: by 2002:a05:690e:43c2:b0:675:3b2f:149d with SMTP id
 956f58d0204a3-677abdedee8mr177654d50.6.1790887728087; Thu, 01 Oct 2026
 13:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-17-9b6c217fdf2f@gmail.com> <20260923224758.ABDB11F000FF@smtp.kernel.org>
In-Reply-To: <20260923224758.ABDB11F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 14:48:22 -0600
X-Gm-Features: AclHuK_fnG9ePBcpefBAaL1OxTkmt0Q1XqH_AAR2O6UruMjbb77-3ueG2XaC4OU
Message-ID: <CAJfuBxzR+rHmMw7HPscwb4eAVn1SsnHpFVLGcYxJOq9icQyQWw@mail.gmail.com>
Subject: Re: [PATCH v11 17/38] dyndbg: replace classmap list with an array-slice
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:47=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] dyndbg: interleaved classmaps are orphaned due to contiguous s=
lice assumption
> --
>
> commit 8936e7007afda568cebc34aa496a40887ac6a5a1
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: replace classmap list with an array-slice
>
> Classmaps are currently individually list-linked onto dyndbg's per-module
> ddebug_table for operation. This commit replaces the list building operat=
ion
> with an approach that treats packed classmaps as an array-start-address a=
nd
> array-length, reusing the select-by-modname condition to find the bounds.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
>
> [ ... ]
>
> > -static void ddebug_attach_module_classes(struct ddebug_table *dt,
> > -                                      struct ddebug_class_map *classes=
,
> > -                                      int num_classes)
> > +static void ddebug_attach_module_classes(struct ddebug_table *dt, stru=
ct _ddebug_info *di)
> >  {
> >       struct ddebug_class_map *cm;
> > -     int i, j, ct =3D 0;
> > +     int i, nc =3D 0;
> >
> > -     for (cm =3D classes, i =3D 0; i < num_classes; i++, cm++) {
> > +     /*
> > +      * Find this module's classmaps in a subrange/wholerange of
> > +      * the builtin/modular classmap vector/section.  Save the start
> > +      * and length of the subrange at its edges.
> > +      */
> > +     for (cm =3D di->classes, i =3D 0; i < di->num_classes; i++, cm++)=
 {
>
> [Severity: Medium]
> Since the scan in ddebug_attach_module_classes() always restarts at index=
 0,
> could this cause regressions if multiple descriptor tables exist for the
> same interleaved module? When distinct compiled objects share the same
> KBUILD_MODNAME, it seems they might all incorrectly bind to the first blo=
ck
> instead of finding their respective fragments.
>
> >
> >               if (!strcmp(cm->mod_name, dt->mod_name)) {
>
> [ ... ]
>
> > +                     if (!nc) {
> > +                             v2pr_info("start subrange, class[%d]: mod=
ule:%s base:%d len:%d ty:%d\n",
> > +                                       i, cm->mod_name, cm->base, cm->=
length, cm->map_type);
> > +                             dt->classes =3D cm;
> > +                     }
> > +                     nc++;
> > +             } else if (nc) {
> > +                     /* end of matching classmaps */
> > +                     break;
> >               }
> >       }
>
> [Severity: Medium]
> Does this premature break in ddebug_attach_module_classes() enforce an
> assumption that classmaps are strictly contiguous?
>

Yes, it explicitly enforces that assumption, because contiguous packing
is a fundamental invariant of the Kbuild object model and linker script:

0. In Linux, all translation units (.c files) comprising a loadable
   module or composite built-in object are linked together via
   $(LD) -r into a single intermediate object (e.g. foo.o) before final
   vmlinux or .ko generation. All contributions to custom ELF sections
   (__dyndbg_classes, __dyndbg_class_maps) within that object are
   placed contiguously.

1. Built-in module definitions do not interleave across directories or
   link units. Core dyndbg already relies on this exact contiguous
   invariant for callsite descriptors: dynamic_debug_init() scans
   __start___dyndbg_descs sequentially from index 0 and allocates a
   struct ddebug_table whenever strcmp(modname, iter->modname)
   transitions. If Kbuild interleaved objects for the same module
   across arbitrary boundaries, descriptor tables would already break.

2. An array slice (start, len) inherently represents a single contiguous
   memory extent. By definition, a slice cannot represent fragmented,
   disjoint ranges. Replacing struct list_head link with a slice saves
   memory and pointer indirection overhead per classmap, backed by
   standard section layout guarantees.

> If classmaps for a module are interleaved, breaking early means only the
> first contiguous block is bound. Subsequent classmap fragments might be
> permanently orphaned, leaving class'd pr_debug calls in those fragments
> uncontrolled.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D17
