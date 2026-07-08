Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A653DA7C5
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543734; cv=pass; b=T/rV4e6VDlSoQi7lMg7M9NwsbTC+BLEXgkPipUIwvEZTOEgLQvNI4EWfHAQMcAsBMO4cNOBX8n/ytjNc+1zYasQp9RJhwiUIdy/0/S/E3l/isWWOqxajs6gS66/nzC6chfeY6s5K6MYL18MpaTv7lKsdkZgEg0o7qZdKfG/JD3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543734; c=relaxed/simple;
	bh=9BJdBJoh6bO5JgM9sko/x+9Pye2uwMOLk+dxbigAcs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0WCj4EESTW2DeavHSl30Dx24CDeSjC02ZhqbuOqTMz4jxOiNrggWfLtZugDn5yj3xqLXyjLQgug73PTQR+oCAQzT+un5RVnDjMDdAKNS6JOJmsspUV18dyqjl/zbsSX2beyGpbel2ChKrab60XaTzgxLwWmPq2CZOwQFAFmagM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0B/aZXH; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0B/aZXH"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6675db463b9so991466d50.3
        for <linux-modules@vger.kernel.org>; Wed, 08 Jul 2026 13:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783543732; cv=none;
        d=google.com; s=arc-20260327;
        b=IabDP1gf/9m2QtzbiwtwidCQdm5TDEUBA7sN7h2HJvd/fwOtHfGbkvj59nmINpjAAp
         prwGQGB3mtBnzwXe34A5rU1QNi8bpOCzxuOFFj6ah70uSoxSFkq8sqoaAebZOZQFmRw8
         c+2oH3lnmOMhaT0nASGFKRVmh/ilWW0wmeNAVAe9j5pKXCnKsS+EdzruJXVUnkO9Gc6k
         z/DTd48k6mTxyoPmC9QqOQu1XOwy+0lLqRvPPs8ACR02LUIXnIDTFn52xvXS699VY/sA
         NHxrSd05fPhzG5+sBeH3ntn4aObvMJjwd921uV8m2+cx7niJpnpb8dTZLXgy397rj0we
         r+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Su5iC7GyWFqasMSbo6foK0Ud8wXMN0xjdKWMhHqwlc=;
        fh=5cs6b6d7Xpq2ANmcE1sW6J73OLOoOdfaXy4E0BsYxz0=;
        b=HfSQFTmTzM7fy1qj2s+sTTRkbp8ezhX31GxhB0e4C+n4lbtSpH8d2NUzm3Vp815IQQ
         q63l1o9NERExhQtwbBa1bIhoKU8/x0x2gg5H6jvo1WutQg6E/dzdx74+e7ZLDBT5Zg1X
         /S3FJFbTmTuCwwaufGQvvK0XvtKL2TMG12G0oG8NEQPSLvYTAnYOsC8lVyzmEi9GoYO8
         U5MK8o6YrBgh0PdxbzXDjbeyar1gJRtY6M6LEw5heifkn0Xum0gq1Q1FRkW8+esWrfAZ
         i0COux28tn+fDgk7gXs6WcRQbk6VU2mWg+tHCCj150c2qBd0cTrpxf7M408z4Yfx+ZWp
         CXfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783543732; x=1784148532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Su5iC7GyWFqasMSbo6foK0Ud8wXMN0xjdKWMhHqwlc=;
        b=l0B/aZXHJIjAW1CHrPwYrI6BsFNib5buUL1urvZKilqEC9TsteOtvgnkdrwXOfqlFk
         ClTxONulLw8QWEN2FkO+cpPca5jLjz3AsCFVpq9/XI8Eywe4D+cvMMfV17VZ/nhnEPnn
         HnUiFTA9KBEjOHDEZ45BUzTFaqRdKa+eY9tJHrlYkwgTvxxGE5FY9EF8wx8N22944U9n
         RTyi4igILC9UfBbwYKvBXrvytwn99+NALe6WzgMmQI45iRvhHx6G5ikH6dwey5TIdejD
         WPYm8pHxcGFjYGc4Gv3tWFDRVdfYSE8vqZ/qGdSPDbFCpLPmmloz6g4wuWEUjXJcSz9h
         F+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783543732; x=1784148532;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Su5iC7GyWFqasMSbo6foK0Ud8wXMN0xjdKWMhHqwlc=;
        b=RFg85+VmTRKvXtiebizVUvcN2GPxxPWsPHt+8rt96VLkD4hM75WgYoehRNscKCj/Wr
         E4e3LinJfaqHRGBKOaK7pF3kKUMDWGp2Pnm5GIFm/DpLkjETvlA5UAz63F0tl+bYKshk
         d2qvquN1smt2Je3evNq1qA15ruOj8jrArGxszKMQvEqc7Devy+3zhSBHTfY7ULkCtO5z
         x2PGmZPQIapGZduk8TP3CIfpTriCr0kiIlOGKEYVkvCq4aUvM3hpC9vGKKOTVnsLtucE
         W0kDd/xz/pECOoJPUdd5heA14AfbJr8IvfzWHmtFRnFDKil2Imrv7YlRmBhrEuSNR+sF
         fWOw==
X-Gm-Message-State: AOJu0YzUK3ByRFkHFF8NrYkPQG7MUNQPmd9lyy349h62Kr6crvEfBCWm
	ygK0Y/oJXD34dMu0KjYDrjgs65hsU9fEmAiP8zLdVf/0puenZHprDkD+scTyhKXC1XjsQlOgiue
	H8BXci0LmaOTU2S+lE+f2ArbjBwEbjMTvG8Cp
X-Gm-Gg: AfdE7cnVSF9dCjgQNHq7Obcw7q+TfXHaavJUccCV+nw/LSQ+hmgOj1lohqYWPxtyFji
	v9WHvnYUTPZBioVUYQdE1HswAwXBKIL1lvgzdw/dzHBsBOZ6Zn7GEqKnS48wmw6mOefjmAPwWtk
	VtGAaCV2xOYYVQsaptJaRlBRDn0XVTMU1Ic3w43SRhIButvhYbUGRtymKEvXsarlpNlBIGVveps
	7YMZTQODn7Wo6x7F4Q+joVdVeQA2QKyfBzzIpEnMrR5U8+T0gpqwz2/9Tf1JHpGD2Ap2ALch44i
	wTHt
X-Received: by 2002:a05:690e:1348:b0:667:b08e:2a2 with SMTP id
 956f58d0204a3-667b08e0ae6mr1729856d50.27.1783543732085; Wed, 08 Jul 2026
 13:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-19-381f3edb0045@gmail.com> <20260708023725.52B9E1F000E9@smtp.kernel.org>
In-Reply-To: <20260708023725.52B9E1F000E9@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Wed, 8 Jul 2026 14:48:24 -0600
X-Gm-Features: AVVi8Cef1o43P0BcIrbKibkv5LgOWcV8WhWKRwgZJ3xzNcwlJwrD7Ugwb6QN5b0
Message-ID: <CAJfuBxx+5i4z77hC5BEDkyegE0FWjGRfBfWM6M_nkk94btfO0w@mail.gmail.com>
Subject: Re: [PATCH v6 19/24] dyndbg: pin class param storage to u32
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 8:37=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Support for classmaps with more than 32 classes is broken, cau=
sing undefined behavior on 32-bit architectures and silent truncation on 64=
-bit architectures.
> --
>
> --- Patch [19]: [PATCH v6 19/24] dyndbg: pin class param storage to u32 -=
--
> commit df6ebc9b56fab43581ec7860d30aab6f33272ee2
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: pin class param storage to u32
>
> This commit changes the storage of dyndbg class parameters from unsigned =
long
> to u32 for consistency across architectures. It also shrinks __drm_debug =
back
> to u32.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index d99c69b9ad12f..af05f4ae3b55e 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> [ ... ]
> > @@ -643,24 +643,27 @@ static int ddebug_apply_class_bitmap(const struct=
 ddebug_class_param *dcp,
> >       int bi, ct;
> >
> >       if (*new_bits !=3D old_bits)
> > -             v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_=
bits,
> > +             v2pr_info("apply bitmap: 0x%x to: 0x%x for %s\n", *new_bi=
ts,
> >                         old_bits, query_modname ?: "'*'");
> >
> >       for (bi =3D 0; bi < map->length; bi++) {
> > -             if (test_bit(bi, new_bits) =3D=3D test_bit(bi, &old_bits)=
)
> > +             bool new_b =3D !!(*new_bits & BIT(bi));
> > +             bool old_b =3D !!(old_bits & BIT(bi));
>
> [Severity: Medium]
> Since classmaps can theoretically contain up to 63 classes (as mentioned =
in
> the commit message), is there a risk of an out-of-bounds shift on 32-bit
> architectures?
>

A macro in a later patch (not in this series) limits a classmap to 32 class=
es,
which is a practical limit for usability of classmap params.
As a case in point, drm.debug has only ~10 DRM_UT_* values.

64 is a per-module class-id space, allowing modules to have several classma=
ps.
a classmap's base/offset lets it map its 0..31 range into upper class-ids,
which is how a module can have multiple, non-overlapping mappings.


#define __DYNAMIC_DEBUG_CLASSMAP_CHECK(_clnames, _base, _mapty)         \
        static_assert(((_base) >=3D 0 && (_base) < _DPRINTK_CLASS_DFLT),  \
                      "_base must be in 0..62");                        \
        static_assert(__DDEBUG_ARRAY_SIZE(_clnames) > 0,
                 \
                      "classnames array size must be > 0");             \
        static_assert(__DDEBUG_ARRAY_SIZE(_clnames) <=3D 32,
         \
                      "classnames array size must be <=3D 32");           \
        static_assert((__DDEBUG_ARRAY_SIZE(_clnames) + (_base)) <
_DPRINTK_CLASS_DFLT, \
                      "_base + classnames.length must be <=3D 62");       \
        static_assert(((_mapty) >=3D DD_CLASS_TYPE_DISJOINT_BITS) &&      \
                      ((_mapty) <=3D DD_CLASS_TYPE_LEVEL_NUM),            \
                      "unknown class_map_type")

So while its currently possible to define a problematic classmap,
that will not be possible soon.


> BIT(bi) expands to 1UL << bi, so if map->length is greater than 32, this
> shift would exceed the capacity of an unsigned long on 32-bit systems.
>
> On 64-bit systems, *new_bits is now a u32. When it is combined with BIT(b=
i)
> using a bitwise AND, the u32 is zero-extended. Will this cause new_b and
> old_b to always evaluate to 0 for classes >=3D 32, silently ignoring the
> requested state?
>
> [ ... ]
> > @@ -704,24 +707,24 @@ static int param_set_dyndbg_module_classes(const =
char *instr,
> [ ... ]
> >       case DD_CLASS_TYPE_LEVEL_NUM:
> >               /* input is bitpos, of highest verbosity to be enabled */
> >               if (inrep > map->length) {
> > -                     pr_warn("%s: level:%ld exceeds max:%d, clamping\n=
",
> > +                     pr_warn("%s: level:%u exceeds max:%d, clamping\n"=
,
> >                               KP_NAME(kp), inrep, map->length);
> >                       inrep =3D map->length;
> >               }
> >               old_bits =3D CLASSMAP_BITMASK(*dcp->lvl);
> >               new_bits =3D CLASSMAP_BITMASK(inrep);
>
> [Severity: Medium]
> Will this silently prevent enablement of classes >=3D 32?
>
> CLASSMAP_BITMASK was changed to limit the generated mask to 32 bits, but
> map->length is not restricted to 32.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dd-maint=
-2-v6-0-381f3edb0045@gmail.com?part=3D19
