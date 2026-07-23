Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840EB488DBB
	for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832302; cv=pass; b=T1VvTwKtZ7ThF2R1xYXLLhCvpGhdwNi/pUtnmJc+Sk5syUX5qHxOrtZBPr/mQkDqunkQMtESh0bG6WcGua2VuIokTKwLDisUcLEvAnf46oX02nt0CCRfGn1ywVu9n1ikOOhtYS0MLCw3wKbQW5K4gFMKKVc+seMvxwndST6Uh88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832302; c=relaxed/simple;
	bh=yg9/TuPXxiIR3f/K2GQ63dB4YPeSX1mhjvPFI9kMu+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFV3jOXlndzzJIc+JCE4KUVLKvSwsnWqaPFJarBoIgWHVlFOuS11VZd3kQsumBI2J5L3D6KFw3axVfzcB9LjAMSrw6VI80dNti2sv5BB4+1Y7XX9C6vh+k63SjoBtB3RCVL10A40qgoCgVrEEQAauXKSlqICCdSx25pczox2250=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHVGOMxj; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHVGOMxj"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8114a4542b2so9858627b3.1
        for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 11:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784832293; cv=none;
        d=google.com; s=arc-20260327;
        b=HjhApq5BjUey1VQtYY2Kg1BkTuf0sEWRwJp2+f54vvPEc8rSjGAF2N4PoexI75HCri
         JdhF/OoCkFwVY9VxdVH2b+3UE16fWxDEpTW9vRvQYDIR4PZ2U8Ni9QuPZPN4xnDAiM2r
         H7RCz358GS+ys1v96hxgGAWWiuH5JFkoJt4Q15Zbt72X827ft3xrZxg11+byukJ30d58
         aBIvviy697a1IF+hs+jDz4lU7cZsmI3TrKbA8o2CJoEwawQb+/zN+6XxZHhvYQJf0AOp
         X2nfttpdhIRvaGbhPZlWzhRiseR4C0UIbGaQFwHxwz3csZ4o2TuAKLLFh+UvyOv5ORAs
         ZHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nWE1XQk5hMIg4yF/U3X0RJddhBOGdBRI/GnQd18cQ84=;
        fh=REQp+dKrLXXaq7FH8uX2sfygwWcSkviirvlohRP55IA=;
        b=F5oCPi9N3QJqwvyYIZd4hfDc9yk/ja1eYTIsb3Rd5Qha/siAb0X+GDPvNiQg2loFQD
         +G8CnbMpollsW4bymNvCJoezRiUA8eex7ieQHCZYktw1m73qzpM2Gg2xQ1bTye8bVupI
         ghQnH4FelZKA8C5eG+20akOWPlxYuTF1vw8MsrwchHPpbkc8Nu8yQov9s+WSpWCnhGVK
         9fm9RsSKAyCFIn0QDrvmk4LQxTMYUnMbm0G238wLb0TvV0GEKmF8kseIJ8JAyxxOcTzV
         R0IPB2IymSzwarYpZxmQ2W15gKdQ8Xurxvxjeym8YRmev4O0eEG7KgrrgAbywY0lNg5L
         ktUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832293; x=1785437093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nWE1XQk5hMIg4yF/U3X0RJddhBOGdBRI/GnQd18cQ84=;
        b=WHVGOMxj1CWLzGT3NGmOvhKggzzfbnWq4lvD2JgvQQZUDQ/oDWohCe31+QBM7LjWac
         oVrpGyt5Bb/ufN7HAeYGjlYzoUpYrXJU0BX+kzLHj6JkVUlEIavwNHr3vTjosX2FXb6Z
         1GOjPTXeVYqFUfO+K98XGxrj8C407CPGzzZP8i2RoVt99IAcXeMq8PkLr7YKWJgbDvl+
         VOs5T5g47Ia3voa9zAkkgLh8KaYQoHNJwtbYPdMzR9ipPY5gXV4DaNGk+lRgmACr8PCH
         ZgWE6/on/Luw/p4HojcEa2a81+J05BKNTznnJvyHsOSFhUxrIa/CY7O3HkXjDVz0Fd/r
         qKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832293; x=1785437093;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nWE1XQk5hMIg4yF/U3X0RJddhBOGdBRI/GnQd18cQ84=;
        b=Aa/UHsryVWpfd2sL+QMwZlMivDVaKJBekoizssQdTKG12WcOezPEZrkm2noiOBV+Ir
         OJcOsqLPFZkenAhYfj6uH1QNusoh83dR2oUMxQKIE0xep4XZafR0d/OX0tyFLkxQ6Qv5
         Vxj1vpaP7P1fybAcRe920+V3tES5+JEg/fp+/DVWTB1TmwHmcbhIuJSOCSiWmpILCN6e
         D1i97yfqe/bAkv8wfg+N47k2N54IUX5H+KPa34v+hUiexNsBtj9LIlSPXjZflVBHZVW6
         1AHU6gCY7in6zlKQ+eFcaHWVSY5rJrewcMNa+psAk7U5gxzbwn4nfFxfDlfoAOcg3eOe
         SQrQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTaxcEL6SfEULGchP4HoPbChJ0VJO5ZvEXzdDqe/Y7aErGCAPB2xanpLt5l7/gDr84yq8O/VyDpa50Lp1n@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/mz/wZ3PuT88HgoAQwZaHeSKTbmqxVQDFAXGgQ+Ihi8hGG+wI
	z7/dhy+S3oz4ZEnISG0LqqjAmhnTC+D37+kyrUk6rb+GNw7tM7YX3GRyx4IrvjLdL+XXHMjP09c
	kjk3nhQ80Xa+qgt6B7+wptuSwvZKqyoaNQw==
X-Gm-Gg: AR+sD11dyweLVNoTuV4E3Fcp88PHtBgeKzUVUcyBbSWDbHxZrscbXgpOXOo5Zu++ITS
	i75FoSJkGQT1hkaMIZLrCz6Hj1H1KMxg5cAuO+SooueAL6v/N6OybHW/16py9UFntMmt+dEAeXC
	rSSPe+Uih5apYScenRYfGV9bOQgkqEpHNzFd2JUVE5IQiBU/qheV/5Lxg+HreKVRoOedkiUeTuz
	BI6tJaIkT97BB2hlEVfgFesqxK9rfp36wbmuMJ8YoYVFfyw053PQE+1zBznpo315nvcwys7oU8+
	CA53qGEyMrEcjUbti6R6HIEHrLo5VPZv9CwSdaCx
X-Received: by 2002:a05:690c:6181:b0:81e:76a6:4fa4 with SMTP id
 00721157ae682-81f4c3641b3mr13865687b3.51.1784832293409; Thu, 23 Jul 2026
 11:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
 <20260721-dd-maint-2-v7-20-010fbe73b311@gmail.com> <20260721211144.5FF051F00A3A@smtp.kernel.org>
In-Reply-To: <20260721211144.5FF051F00A3A@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 23 Jul 2026 12:44:27 -0600
X-Gm-Features: AUfX_myewH6u9zWxn6egOOnD6NQMr2PYuX2LLJqaFPr4esqlMtuMqkOK2XVFRr4
Message-ID: <CAJfuBxzqPPui3TRsyncnbS_CLyyh6pU2=1mkO=JsPEVwa_v9Rg@mail.gmail.com>
Subject: Re: [PATCH v7 20/29] dyndbg: refactor param_set_dyndbg_classes and below
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:11=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The refactored `param_set_dyndbg_module_classes` is structural=
ly incapable of correctly applying existing global classmap settings to new=
ly loaded modules, and it corrupts the global state.
> --
>
> --- Patch [20]: [PATCH v7 20/29] dyndbg: refactor param_set_dyndbg_classe=
s and below ---
> commit fd7e6888285afde6b911cef67e7e2452e7180dba
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: refactor param_set_dyndbg_classes and below
>
> This commit refactors the param_set_dyndbg_classes callchain to support
> module-specific classmap updates, primarily intended for modprobe handlin=
g.
> It splits the function into upper and lower parts, threading a modname
> parameter through to ddebug_exec_queries. It also adds a check in
> ddebug_apply_class_bitmap to skip printing if bits haven't changed.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index f66e5373e61e2..a619cefd801f7 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> [ ... ]
> > @@ -625,7 +626,9 @@ static int ddebug_apply_class_bitmap(const struct d=
debug_class_param *dcp,
> >       int matches =3D 0;
> >       int bi, ct;
> >
> > -     v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
> > +     if (*new_bits !=3D *old_bits)
> > +             v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_=
bits,
> > +                       *old_bits, query_modname ?: "'*'");
> >
> >       for (bi =3D 0; bi < map->length; bi++) {
> >               if (test_bit(bi, new_bits) =3D=3D test_bit(bi, old_bits))
> >                       continue;
>
> [Severity: Medium]
> When applying the current global state to a newly probed module, will thi=
s
> continue statement incorrectly skip all configuration queries?

this is a param callback. the modprobe has finished, and the modprobe
args setting classmaps
are already done.  the param-callback only handles param updates


> Since old_bits represents the global state, test_bit() will evaluate to t=
rue
> when applying the same global configuration to a new module, silently
> skipping required query updates.



>
> >               snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_n=
ames[bi],
> >                        test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
> >
> [ ... ]
> > @@ -683,8 +693,8 @@ int param_set_dyndbg_classes(const char *instr, con=
st struct kernel_param *kp)
> >                               KP_NAME(kp), inrep, CLASSMAP_BITMASK(map-=
>length));
> >                       inrep &=3D CLASSMAP_BITMASK(map->length);
> >               }
> > -             v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
> > -             totct +=3D ddebug_apply_class_bitmap(dcp, &inrep, dcp->bi=
ts);
> > +             v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*",=
 KP_NAME(kp));
> > +             totct +=3D ddebug_apply_class_bitmap(dcp, &inrep, dcp->bi=
ts, mod_name);
> >               *dcp->bits =3D inrep;
>
> [Severity: Medium]
> Does this code inadvertently corrupt the global state if a module-specifi=
c
> override is applied?

the param belongs to a module, its not "global".
and I dont know what override means here.
the callback MUST update the internal state, or error out.




> It appears that *dcp->bits (the global parameter state) is unconditionall=
y
> overwritten with inrep, even when a mod_name is provided.

the param belongs to a module. so does the param state.

> Should the state update be conditional on mod_name being NULL, to prevent
> modprobe handling from modifying the global state?
>
> >               break;
> >       case DD_CLASS_TYPE_LEVEL_NUM:
> > @@ -697,7 +707,7 @@ int param_set_dyndbg_classes(const char *instr, con=
st struct kernel_param *kp)
> >               old_bits =3D CLASSMAP_BITMASK(*dcp->lvl);
> >               new_bits =3D CLASSMAP_BITMASK(inrep);
> >               v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, K=
P_NAME(kp));
> > -             totct +=3D ddebug_apply_class_bitmap(dcp, &new_bits, &old=
_bits);
> > +             totct +=3D ddebug_apply_class_bitmap(dcp, &new_bits, &old=
_bits, mod_name);
> >               *dcp->lvl =3D inrep;
>
> [Severity: Medium]
> Similarly, is the global *dcp->lvl state unconditionally overwritten here
> when a module-specific override is applied for LEVEL_NUM map types?

the state belongs to the module.

>
> >               break;
> >       default:
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dd-maint=
-2-v7-0-010fbe73b311@gmail.com?part=3D20
