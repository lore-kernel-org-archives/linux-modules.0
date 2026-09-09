Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281513E5A0B
	for <linux-modules@vger.kernel.org>; Wed,  9 Sep 2026 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987397; cv=pass; b=PO4Iy2yJc9pmzjuuXm/3UUFAy2IeGdjZl2RtvHWVtCckzkD7B0Vf+adY3+eoET/Y7BlM1OLBYS5Jo5RO9t/D78bUo9kmOUx4GlCxczHJGDtA5r6CukceHnrN29uaOjoaKfUv+5G5M0rrfUoZiM4/BMNP5lWUKBjAVM8HcWDKz9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987397; c=relaxed/simple;
	bh=mSXDf5L3akGYZpZ85/ToGKuGbVhQAqImwbuSO42wJoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxUXJPEnfdBU5OONYdeGSe48M+BCPuRyABVryJQ+9jwtzrUXkXgg71uxEMxAO1dnVcCoyBEouJMQnTmXYLfLHnomDgge0sqUbo4f/7TL/22JuPoDnnV2EYlvtbhKq1vAPIvA4qyahgc4jqW9jEQX77IV0xZBJZDKBH3af9IDZq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIE9b+mG; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIE9b+mG"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab201f9so971966d50.0
        for <linux-modules@vger.kernel.org>; Wed, 09 Sep 2026 13:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788987389; cv=none;
        d=google.com; s=arc-20260327;
        b=anXRHC7aSXXd2DBC7YGpN6+HqnTdFBOiDdGwrQsfZtDBXMBMdo+6YHcgYn4vpYWDx8
         4TmQ7QH7RrMqZdFtZt2ZNm6laDOy4KmXnfzZPX14oWu3UCx3BdHBo3yq4m1kYpY9+LHr
         kY6wSx096pv3wAInLMc+imh4yD29Lvg13/WnlLoTsMM0uGwu3/qNDhKd+KUIwh/ixXpb
         wbP2AWdQhewLVUxUTjm2wfYntWlIlFja6GCvbLgbBBtO3colx95wgKXqai0muppJtRn2
         plvo3WjT+27U4aYpf4iHsH/9A0Qu8SvX+/T2jgspGuONYsCaEJDd788o6GIwUTp/UHx1
         5QHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aHx4F49Zpu+pEmstw6hBfMqlyRg9LrY6GEInd1anRvI=;
        fh=PVT6Fyb6gApjT5Yyx3tPZfHl/F+FvPIBEKHFFMgWz/k=;
        b=fwbzr+5zDpQtVWvOe02+WilA1DMHr6tFwiRvGTmEeJmnPmRBvqlqcyeTOhDKySDm0R
         CUJTMCLeaLDoQkSYSazqFpy2IlfIUEPGYxI1F7NIN3YtUBbnKLCS+Vsua7VQxw92LQNq
         oPu6pRcERVkvESRuS3gRv50zU3K75O2SGmAL4ds+3NT0VTb//GufzBA8IvwMjSgp3VK9
         TnXe7okMq4hQlLx1Njx+qE+qlI2TwA0R8WqMYmk8QP9oLfQQXG0/rg2NoeZqVqg9cBIH
         MiJCoSXWctui6PKVOTRj3H/rMxfqZkWHfDKv3yfaFKY2O56JVV6ISvsHBlrscnEVfrq3
         4zcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788987389; x=1789592189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHx4F49Zpu+pEmstw6hBfMqlyRg9LrY6GEInd1anRvI=;
        b=LIE9b+mGAmZxRRgGGeAP0YPr3QDAntRyY+NNdJD+5oXguYt5w8TjBRUccun9XHOCWQ
         IWdCH51+AOcXUgVbd5w6u7RyTomf55j3dmlJ4CjiC7RNeBpyHsTvZXB+qr0JwA5OTEUz
         Eio8EjVdm7Hq3y1UMvd3rxvV24xpzDyP+Fg34MvefD3RGDmHUqQVRcqirRBfTXVvQahi
         3D/+kvexPBlo0MBx3MD1KPbE8+v1K++bePBoNiJVZn70zWs7Po+rJenoupzCvEztXCUp
         HvfJd5UjqqBjk6+VQdY+GE9Hy5A02TktPbTOCnAl+OLrfYXiQJIuSM7m8VPK67Gg9J0V
         hliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788987389; x=1789592189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHx4F49Zpu+pEmstw6hBfMqlyRg9LrY6GEInd1anRvI=;
        b=EAwvdFjzI6LCzek+/KPZBsRks35crjZhVe1sSJgx6Q8sWyHx5HaKoVfM0bufQldO3A
         GT6yjFha/L6FiXA6NdYpoS2AgDnzDjUTFoSmwY+wBDLwr/fWt61sTKUG3cdfZtnDMy0U
         bZHLZllnPhWcTeJd5n1FveuDdKkcER8h+BtT0ETmaJfh6cMYbuEF6sUQgj7JZaG54gEX
         0FG+UfU/SAMHqXcGs+a1P5VJdEev5AycWa7n3JD8QeGe5QIDg6LKlqZGVDt5bheiP+lV
         JGy+ByUicM/NjMuJZcTph4Gs34X7XUBVB2Ssl+RRcUqRZZyB76CtICxtQ3TgRW7nUxO1
         n2kg==
X-Forwarded-Encrypted: i=1; AKwUvBzBOjgW2bk25YffYwA1Lidp+k1cXLgrfBvr4RsTEkDox8V325JDDRRKFIm6vnX6x88TMFddFX6x9zH6ywFv@vger.kernel.org
X-Gm-Message-State: AFuF++k38/DV24xkUH30Q5IyBx7M1zxiol0xNSSZ7UZAGSxIfph+X6Ma
	v8rpvGykpbaZLu11w7s8eV2fKvOl0QGQCnU8S/FFvacUo/1YGREfwCWjzexN+4cQHZPEz6ZUqrb
	fwyD1MSTBJ54MVdPncc8+H6/VGk6hb+GZw50xy7A=
X-Gm-Gg: AYBFou2UHD1HSzrv6Dgzaq0Y7CKqDKG5c62l/gYNQ/qjOj8Os2U0qnP/Z9zvEvHylsx
	xgsamA6bG4Kog7O7P8XlbzEW5oojQNLXMpAAoPVvfHAnwhjs0wwmeSBAKNyYiju5Lx+ofdJB9ws
	TwwX/UCMqmiruofE2MDFsCfaVks8JwPHi1XDnVXnB6iPKpyJ+vrdKIZun4F0Y7dN8JeAFtx0NNS
	d1zhhY93qGBohqVxVgL+8Rg7pt1clk5mplri7qa8Qqdn75iSrudlrXtt5QKgMKq9zp7BG28b19e
	YUb6ytdYeo55A5G6Va8rxXfOcEY0RXNf6RBUUef+ab9GlIUXWJRwTpnURbPQXplrpU0YmmAKggs
	Ammfd+WRFcbSdJfjeZxTRVYtQRcPYU4zKTw==
X-Received: by 2002:a05:690e:43cf:b0:66f:c67f:1a6a with SMTP id
 956f58d0204a3-6710ff14f4fmr1492851d50.44.1788987388660; Wed, 09 Sep 2026
 13:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-24-3a3f621f4a10@gmail.com> <20260909011309.543B91F00A3A@smtp.kernel.org>
In-Reply-To: <20260909011309.543B91F00A3A@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Wed, 9 Sep 2026 14:56:00 -0600
X-Gm-Features: AcwNN1V549rxj8x0UclZdPYhK2I8FxFFFwB6mo2fxWYjnCTaNEuPXTVR7O_ixeA
Message-ID: <CAJfuBxy9gvQ3kBRy=9_ik6oUaBdczoC76XwHR71zc4Lxkp-wSw@mail.gmail.com>
Subject: Re: [PATCH v9 24/39] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 7:13=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Medium] Newly loaded classmap user modules fail to sync disabled class=
es due to a hardcoded `0UL` state assumption.
> - [Medium] TOCTOU race in `ddebug_apply_class_users` when a class paramet=
er is modified via sysfs concurrently with module load.
> - [Low] struct ddebug_class_user defines mod_name as non-const char*, whi=
ch discards qualifiers from string literals.
> --
>
> commit ed72477b68f823658c20da0da2c5754d60e12c69
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
>
> DECLARE_DYNDBG_CLASSMAP had a flaw: multiple invocations across both
> core and driver modules broke the K&R "define once, refer afterwards"
> principle, causing boot-time parameter propagation failures.
>
> Replace it with an explicit client-server model:
> [ ... ]
>
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 144a2a947abcb..6517e0169a803 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> [ ... ]
> > +struct ddebug_class_user {
> > +     char *mod_name;
>
> [Severity: Low]
> Does this code discard qualifiers from string literals?
>
> Using the DYNAMIC_DEBUG_CLASSMAP_USE_ macro assigns the string literal
> DDEBUG_MODNAME to this field, which can trigger compiler warnings and
> compromises type safety. Should this be declared as const char *mod_name
> instead, similar to how it is defined in struct ddebug_class_map?
>
> > +     struct ddebug_class_map *map;
> > +     const int offset;       /* offset from map->base */
> > +} __aligned(8);
>
> [ ... ]
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 2065bfd1687e0..0e25b4d53942b 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> [ ... ]
> > +/* called for class-users only, parse_one does this for definer module=
s */
> > +static void ddebug_sync_classbits(const struct kernel_param *kp, const=
 char *modname)
> > +{
> > +     const struct ddebug_class_param *dcp =3D kp->arg;
> > +     u32 val, new_bits;
> > +
> > +     if (!dcp || !dcp->map)
> > +             return;
> > +
> > +     switch (dcp->map->map_type) {
> > +     case DD_CLASS_TYPE_DISJOINT_BITS:
> > +             val =3D READ_ONCE(*dcp->bits);
> > +             ddebug_class_param_clamp_input(&val, kp);
> > +             new_bits =3D val;
> > +             v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bit=
s);
> > +             ddebug_apply_class_bitmap(dcp, &new_bits, 0UL, modname);
>
> [Severity: Medium]
> Will this fail to sync disabled classes for newly loaded modules?
>
> By hardcoding 0UL as the old_bits argument, ddebug_apply_class_bitmap()
> assumes the module starts with all debug classes disabled. This means it
> will skip generating disable commands for any cleared bits.
>
> If a module is compiled with -DDEBUG, its callsites are enabled by defaul=
t
> and won't be correctly disabled to match the system-wide classmap paramet=
er


ack.  handled with a macro that yields a classbits full of 1s on DEBUG.

> state.
>
> > +             break;
> > +     case DD_CLASS_TYPE_LEVEL_NUM:
> > +             val =3D READ_ONCE(*dcp->lvl);
> > +             ddebug_class_param_clamp_input(&val, kp);
> > +             new_bits =3D CLASSMAP_BITMASK(val);
> > +             v2pr_info("  %s: lvl:%d bits:0x%x\n", KP_NAME(kp), val, n=
ew_bits);
> > +             ddebug_apply_class_bitmap(dcp, &new_bits, 0UL, modname);
> > +             break;
> > +     default:
> > +             pr_err("bad map type %d\n", dcp->map->map_type);
> > +             return;
> > +     }
> > +}
> [ ... ]
> > @@ -1238,12 +1404,17 @@ static int ddebug_add_module(struct _ddebug_inf=
o *di)
> >        */
> >       dt->info =3D *di;
> >       dd_set_module_subrange(i, cm, &dt->info, maps);
> > +     dd_set_module_subrange(i, cli, &dt->info, users);
> >
> >       mutex_lock(&ddebug_lock);
> >       list_add_tail(&dt->link, &ddebug_tables);
> >       mutex_unlock(&ddebug_lock);
> >
> > -     vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mo=
d_name);
> > +     if (dt->info.users.len)
> > +             ddebug_apply_class_users(&dt->info);
>
> [Severity: Medium]
> Can this introduce a TOCTOU race with concurrent sysfs updates?
>
> Here, the new module is added to ddebug_tables and the ddebug_lock is
> dropped before the module's initial settings are applied by
> ddebug_apply_class_users().
>
> If a concurrent sysfs write to the dyndbg class parameter occurs in this
> lockless window, the sysfs thread will acquire ddebug_lock, apply its new
> parameter value to all modules (including this newly added one), and upda=
te
> the parameter value.
>
> When this load thread then calls ddebug_apply_class_users(), it will read=
 the
> parameter unprotected. If it read the old parameter value before the sysf=
s
> thread overwrote it, it will subsequently acquire the lock deep inside
> ddebug_change() and apply the stale old value, overwriting the sysfs thre=
ad's
> newer changes. This would leave the module permanently out of sync.
>


    There is no race here:

    0. Separate definer vs user modules:
       The locking in ddebug_add_module() adds the module to ddebug_tables =
so
       it is reachable by params and >control queries.
       Classmap definer modules (e.g. drm) EXPORT their classmap records;
       class_user modules (e.g. amdgpu, drm_kms_helper) depend upon them.
       The kernel module loader guarantees strict serialization: the define=
r
       is fully live before any user module can begin loading.

    1. Builtin ordering:
       For builtins, the linker orders drm ahead of dependent drivers and
       helpers in vmlinux, strictly ordering ddebug_add_module() calls duri=
ng
       early_initcall.

    2. Deadlock avoidance:
       ddebug_lock must be dropped before calling ddebug_apply_class_users(=
)
       because the sync path calls ddebug_change(), which acquires ddebug_l=
ock.
       Holding the lock across ddebug_apply_class_users() would self-deadlo=
ck.

    3. Init bits handling:
       Calculate init_bits based on (_DPRINTK_FLAGS_DEFAULT &
       _DPRINTK_FLAGS_ACTIVE) (CLASSMAP_BITMASK(map->length) if DEBUG is
       defined, else 0UL). Pass init_bits as old_bits to
       ddebug_apply_class_bitmap() in ddebug_sync_classbits(), ensuring
       disabled classbits correctly generate "-p" queries for modules built
       with -DDEBUG.
