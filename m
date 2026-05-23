Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ADC175A72
	for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779522171; cv=none; b=s97tCtsqtoEBw44jvVD5X6M4MkChyVngdUJGTta7iMlFxe8BJJ48u63BeHZOj8em2csitK8aXJPu+uFh2+MeaSduG09GjfhXhg4p7IHI/+wBbPop18Tu9BDXtbstwRrIXjZ8OUkqFaqVw0GELq7P4ZN+JQPgeg+Ac6uWUqewpbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779522171; c=relaxed/simple;
	bh=/Y+Uw2aU26irr+uhpwQ4vA4zZZL49qzyDiyPCWU6xd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nz2ONJzJ4jCx7n4hqXUYjl9wcVSovmA/UtTj7U+09uAAAcaL79HUH7eHieV6KEKNaxSZbDnYhEW7epAHMCjXKYCgXwmmLLl+bE9X/ZL+2rebBWMuIc1N8B1gsNVe50hMq0NdUUnJv35mu8G2JZe9kLiShtP3GDKktHypeGWkIic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr7J44dl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr7J44dl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EB61F000E9;
	Sat, 23 May 2026 07:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779522169;
	bh=uy1I8Pi7y+9MTmq0B3ReHMvewG4s1xACTAu7Y09zDeA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xr7J44dl35vIZ8DNOfVTLGurO0NAfSS5PLN/S5HSGEo0TYyTRP/SfneK+RwbZzRQa
	 kI5rFMu/F11LVijVQnlMICYIZ0cX75o8Gq2+hUBG2HN6HodVVJOt4GSrZmrfLcKxZ5
	 uKr8VmF6Xh6cofwdhiHxXs0VCsXfYWa+DZnprXbn2v+O/eaZ8Hhds9fyLcbuHCbByp
	 CVZrz3r3Iu7CCMgLLsIa1aActWEJ1QggqhBlAbpZ9feAR0j4lqt82LpPtqgYVITL/k
	 vNzOw9c0p3o9xGWOKlcwxd3yeQr0BNIGGeYXgJlM95vEi/PhmkLqkciwmxnb+aNiVm
	 uvrehaK/WjTZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/24] dyndbg: Upgrade class param storage to u64 for
 64-bit classmaps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260523-dd-maint-2-v2-18-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-18-b937312aa083@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 07:42:49 +0000
Message-Id: <20260523074249.B1EB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Buffer Overflow / Memory Corruption due to mismatched types in `dd=
ebug_class_param`.

Pre-existing issues:
- [High] Undefined Behavior in `CLASSMAP_BITMASK` triggers shift overflow f=
or 64-bit classmaps.
--

commit 58d2c659362026860249b9d71580382d0d84aa4e
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: Upgrade class param storage to u64 for 64-bit classmaps

This commit upgrades the internal storage types in struct
ddebug_class_param from unsigned long to u64 pointers. This change
aims to safely support 64-bit classmaps across all architectures
without truncation.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index e9481ef21825d..580aa258f902f 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -661,7 +663,7 @@ static int ddebug_apply_class_bitmap(const struct dde=
bug_class_param *dcp,
>  /* stub to later conditionally add "$module." prefix where not already d=
one */
>  #define KP_NAME(kp)	kp->name
> =20
> -#define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
> +#define CLASSMAP_BITMASK(width) ((1ULL << (width)) - 1)

[Severity: High]
This isn't a bug introduced by this patch, but does this macro invoke
undefined behavior if the classmap width reaches 64 bits?

If width is 64, shifting 1ULL by 64 is undefined behavior in C. On some
architectures like x86, the shift count is masked by 63, causing 1ULL << 64
to evaluate to 1ULL << 0 (which is 1). This would result in a bitmask of 0,
wiping out valid input bits and breaking the 64-bit feature.

[ ... ]

> @@ -696,24 +698,24 @@ static int param_set_dyndbg_module_classes(const ch=
ar *instr,
>  	case DD_CLASS_TYPE_DISJOINT_BITS:
>  		/* expect bits. mask and warn if too many */
>  		if (inrep & ~CLASSMAP_BITMASK(map->length)) {
> -			pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, masking\n",
> +			pr_warn("%s: input: 0x%llx exceeds mask: 0x%llx, masking\n",
>  				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
>  			inrep &=3D CLASSMAP_BITMASK(map->length);
>  		}
> -		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
> +		v2pr_info("bits:0x%llx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp)=
);
>  		totct +=3D ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name=
);
>  		*dcp->bits =3D inrep;

[Severity: High]
Can this cause memory corruption on 32-bit architectures?

The commit message notes that __drm_debug is not yet updated to u64,
meaning it remains an unsigned long. On 32-bit systems, unsigned long is 4
bytes. Since dcp->bits is now a u64 pointer, won't assigning inrep perform
an 8-byte write into a 4-byte allocation, corrupting adjacent memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523-dd-maint-2=
-v2-0-b937312aa083@gmail.com?part=3D18
