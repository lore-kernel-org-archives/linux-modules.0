Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5E043C7DD
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784668254; cv=none; b=rdaxIsMul1LXSvCze9e+4zEe3XiE3Vu+qmV/tcc3+2IBvhY0DNnSWuDbjo5hQxUaexR92eNvaYbAHD3lUuvElFJ3FTSvipfHSZPuOzRxI6rb36X9j1oINcALEd+SJIS8NU3NQ8ACDTcSJJpcLYeJvLAMaFTQ+TmZ0OgsnyZbIno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784668254; c=relaxed/simple;
	bh=BRJAaJZnP99VEQlZa2D903Ck5X4mo6RmhMoDZS1fG4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZayTgOFQiqnKi54FUdmcV2XylG0WBVRg6DwbINT2+WV/BLVPX/+HIEUeOi1J25/dXkI/bCxF6zbTtM2R0KzT9Qko19M4nVZJWsVHIgUqPGT86CS5pAj5n9UsETKnuhPcEdRwvKSljdJBC8BBCLg0ujIqFj5EVcmMaPfo4ylY8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONXXii7f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONXXii7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28351F000E9;
	Tue, 21 Jul 2026 21:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784668253;
	bh=knrpHStVOCVVxYCMRyxiaKE5pUbZPv/jIqbcEWBXL4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ONXXii7f1qOoq6UFEABW1cRY9mc8NBzdY7/V23lOz5Zw9hp2uUSbnpDDTCCTNg14K
	 eLd2WpEEkmyGRR8LDo9MIRbzgr69qRXkbobU4C3DLvqf6rnzBom4TkaYk1IYQSYvTb
	 kLtu4ioTRMCLKKATH9KRkRFmkkNvH0Vgrg6wSSxgQcCyaoRxH1BNGbcSGPN2Y1A6v5
	 vZH1Cen8x6fYqAc+/MNJRUH6pB5bWHhSaVvEJDGxKbqg2Lf6tVzM0ZAc+1/1aF1Pni
	 HlEqJjsk0O0xbLDT1Ow3q0auD+TSnXxp1zFdU1lbWqLJvR7bmzliElrvW3wi5oKsZ7
	 dErDnflNfki2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 24/29] dyndbg: pin class param storage to u32
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-dd-maint-2-v7-24-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
 <20260721-dd-maint-2-v7-24-010fbe73b311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 21:10:52 +0000
Message-Id: <20260721211052.D28351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Bitwise shift out-of-bounds on 32-bit architectures when evaluat=
ing `BIT(bi)` in `ddebug_apply_class_bitmap()`.
--

--- Patch [24]: [PATCH v7 24/29] dyndbg: pin class param storage to u32 ---
commit 87a65c25e24b4e05bdc18ddf16105e9237d922db
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: pin class param storage to u32

This commit changes the bits and lvl fields in struct ddebug_class_param
to use u32 instead of unsigned long. This ensures consistent sizing across
different architectures.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 59e3c0eccbede..60b67face46e1 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -643,24 +643,27 @@ static int ddebug_apply_class_bitmap(const struct d=
debug_class_param *dcp,
>  	int bi, ct;
> =20
>  	if (*new_bits !=3D old_bits)
> -		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
> +		v2pr_info("apply bitmap: 0x%x to: 0x%x for %s\n", *new_bits,
>  			  old_bits, query_modname ?: "'*'");
> =20
>  	for (bi =3D 0; bi < map->length; bi++) {
> -		if (test_bit(bi, new_bits) =3D=3D test_bit(bi, &old_bits))
> +		bool new_b =3D !!(*new_bits & BIT(bi));
> +		bool old_b =3D !!(old_bits & BIT(bi));

[Severity: Medium]
Can this result in an out-of-bounds bitwise shift on 32-bit architectures?

The BIT(bi) macro expands to (1UL << bi). On 32-bit systems, 1UL is 32
bits wide. If a module defines a classmap with 32 or more classes
(map->length >=3D 32), shifting by 32 or more triggers undefined behavior.

On most 32-bit architectures, the CPU masks the shift count modulo 32, mean=
ing
BIT(32) evaluates to BIT(0). This causes the loop to incorrectly re-evaluate
and alter class 0 instead of processing the intended class, leading to
incorrect functional behavior when configuring dynamic debug.

> +		if (new_b =3D=3D old_b)
>  			continue;
> =20
>  		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dd-maint-2=
-v7-0-010fbe73b311@gmail.com?part=3D24
