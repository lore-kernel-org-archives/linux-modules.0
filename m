Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19F4E1408
	for <linux-modules@vger.kernel.org>; Sat,  5 Sep 2026 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632930; cv=none; b=BvppcqxI2KdaB6OL9bSEmbSmn8jjW2reYqRk5IARNiWM/aIduS1lQZ4pXUmQ9GUnIKu2bYqKY7DvnViLg5p3F0gWgFdvPOOLXlmLxb/Yru5mQjuJsl/CyWkNqFnoUOV9GJ35vXidnwg1onO0gGx5EGybHXktJvIFcHAGHwO9zFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632930; c=relaxed/simple;
	bh=8wSod0MqvmzFx/cDS6Eo3ZAXnYiF9POA+rR/oEPB+/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mIQ2a9F6Z9SA5IMdnh3id9v14FI4gWKu4rJppm52EjmyHW9Xdgqo9AkxkS4qmjaSUntwSByzJNMcGIlw9kPLK+4QaEr2YbiTDkR2t27GQJt3/neWt1DKEqT2t/owbMK2aGOPiEL5IrYzsseg0GXMw+NXPQgB6qFtYPx4HvLy1wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SivQIKd9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SivQIKd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3CE1F00A3A;
	Sat,  5 Sep 2026 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788632928;
	bh=Fo3RsZGjWAxUb2917MqCwro/N2noThtpChQF++us2wo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SivQIKd9fqUHSrdqlznGA1GciMelDNftBumEfeEcz5gzk/0yHMwIjz2mH2Q1/8wby
	 MWwtaZy2Nf8fj+sTBjN8f25wxzN4wvIZQSzSouIl2mBuqroEIjvWBvlWorGwxgPCtm
	 rk2hTZJ4aoyKyVHRWKskni/g3Qx+x9QrFm+cFwsWnxoDecTatk7oPGBLbCLdBAJ32O
	 1tCFl/T+eokLGptaALwPsteq2pKy4YLaVp8EooL4pGhP2yFlK2Gf2zRaqAqr+5w7FH
	 U/K5vCVLhna1580DX6jFBMD87UyJE5YiRlw616xpS6Yr7x+eu3FyejseR+BtRt12dP
	 +CIGOfkT+Zq5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 32/43] dyndbg-API: promote
 DYNAMIC_DEBUG_CLASSMAP_PARAM to API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-32-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-32-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:28:47 +0000
Message-Id: <20260905182848.7A3CE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Compilation failure for !CONFIG_DYNAMIC_DEBUG builds due to incorr=
ect macro argument count in DYNAMIC_DEBUG_CLASSMAP_PARAM_REF stub.
- [Low] Incorrect format specifier %d used for u32 in ddebug_class_param_cl=
amp_input.
- [Low] Duplicate log statement in param_set_dyndbg_module_classes.
- [Low] Unused CLASSMAP_BITMASK macro introduced in lib/test_dynamic_debug.=
c.
- [Low] The commit message claims to modify `ddebug_sync_classbits()`, but =
the patch does not modify it.
- [Low] The API documentation for `DYNAMIC_DEBUG_CLASSMAP_PARAM_REF` incorr=
ectly claims `@_bits` expects an `unsigned long`.
--

commit fa1c83c075dcd96521ed0eca436783391777f24c
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-API: promote DYNAMIC_DEBUG_CLASSMAP_PARAM to API

This commit promotes the DYNAMIC_DEBUG_CLASSMAP_PARAM macro into the
dynamic debug header for broader use (e.g., DRM). It splits the macro
into a standard version and a _REF version, modifies argument handling,
and updates the selftest modules.

> Modify ddebug_sync_classbits() argtype deref inside the fn, to give
> access to all kp members.

[Severity: Low]
Is this part of the commit message accurate? The commit message mentions
modifying ddebug_sync_classbits(), but looking at the patch, its body
remains unchanged.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 471b9891bd83b..a740b3fabc09e 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
[ ... ]
> @@ -291,6 +291,44 @@ struct ddebug_class_param {
[ ... ]
> +/**
> + * DYNAMIC_DEBUG_CLASSMAP_PARAM_REF - wrap a classmap with a controlling=
 sys-param
> + * @_name:  sysfs node name
> + * @_bits:  name of the module's unsigned long bit-vector, ex: __drm_deb=
ug

[Severity: Low]
Does this comment correctly describe the expected type? The documentation
mentions @_bits expects an unsigned long, but the underlying
struct ddebug_class_param uses a u32 *. Could passing an unsigned long
variable here cause endianness issues on 64-bit big-endian systems?

> + * @_var:   name of the (exported) classmap var defining the classes/bits
> + * @_flags: flags to be toggled, typically just 'p'
[ ... ]
> @@ -473,6 +511,8 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
> =20
>  #define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)
>  #define DYNAMIC_DEBUG_CLASSMAP_USE(_var)
> +#define DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _var, _flags)
> +#define DYNAMIC_DEBUG_CLASSMAP_PARAM_REF(_name, _var, _flags)

[Severity: High]
Should DYNAMIC_DEBUG_CLASSMAP_PARAM_REF accept four arguments here?
The stub macro for the !CONFIG_DYNAMIC_DEBUG configuration only takes
three arguments (_name, _var, _flags), but callers of the active macro
pass four. This will cause compilation to fail for any modules using
it when CONFIG_DYNAMIC_DEBUG is disabled.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 0f89b6784ab26..3f9821f747d80 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -697,9 +697,42 @@ static int ddebug_apply_class_bitmap(const struct dd=
ebug_class_param *dcp,
[ ... ]
> +static void __maybe_unused ddebug_class_param_clamp_input(u32 *inrep, co=
nst struct kernel_param *kp)
> +{
> +	const struct ddebug_class_param *dcp =3D kp->arg;
> +	const struct ddebug_class_map *map =3D dcp->map;
> +
> +	switch (map->map_type) {
[ ... ]
> +	case DD_CLASS_TYPE_LEVEL_NUM:
> +		/* input is bitpos, of highest verbosity to be enabled */
> +		if (*inrep > map->length) {
> +			pr_warn("%s: level:%d exceeds max:%d, clamping\n",
> +				KP_NAME(kp), *inrep, map->length);

[Severity: Low]
Does this format string match the type of *inrep? Since inrep is a u32 *,
using %d might result in misleading warning logs where large unsigned
values are printed as negative integers.

> +			*inrep =3D map->length;
> +		}
> +		break;
> +	}
> +}
[ ... ]
> @@ -718,31 +751,21 @@ static int param_set_dyndbg_module_classes(const ch=
ar *instr,
[ ... ]
>  	case DD_CLASS_TYPE_LEVEL_NUM:
>  		old_val =3D READ_ONCE(*dcp->lvl);
>  		old_bits =3D CLASSMAP_BITMASK(old_val);
>  		new_bits =3D CLASSMAP_BITMASK(inrep);
>  		v2pr_info("lvl:%u bits:0x%x > %s\n", inrep, new_bits, KP_NAME(kp));
> +		v2pr_info("lvl:%u bits:0x%x > %s\n", inrep, new_bits, KP_NAME(kp));

[Severity: Low]
It looks like this v2pr_info() statement was accidentally duplicated.

>  		totct +=3D ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_nam=
e);
>  		WRITE_ONCE(*dcp->lvl, inrep);
>  		break;
> diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> index 39499e52d7c04..def44524b762d 100644
> --- a/lib/test_dynamic_debug.c
> +++ b/lib/test_dynamic_debug.c
> @@ -67,32 +68,7 @@ static const struct kernel_param_ops param_ops_do_repe=
ats =3D {
[ ... ]
> -#endif
> +#define CLASSMAP_BITMASK(width, base) (((1ULL << (width)) - 1) << (base))

[Severity: Low]
Is this CLASSMAP_BITMASK macro used anywhere in the test module? It seems
to be defined but left unused, which might cause confusion since it
shares a name with a macro in lib/dynamic_debug.c but takes different
arguments.

>  /*
>   * Demonstrate/test DISJOINT & LEVEL typed classmaps with a sys-param.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D32
