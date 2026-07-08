Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8591420896
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478247; cv=none; b=FgkgVeYsKzeik6XNYyXm/gsNKMFf1c0eDzK8rfR9YPtU0ld8q7IbBjcesZxmwkbDopVm+zbvTR4ybdxV4QT8RvTNmE4DX6OUOujZ6f+F8Jt/U4PvcK1MwsX1rQ1TbgNqvamPwzZTZNTLV924T9xfYPppdHzUUY462rhqIoegd9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478247; c=relaxed/simple;
	bh=bvBodtAVlml7+6896m3844Z+DhaZc+ZkguKsfazHtUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N8/zpQls8p6wxVM48IBBZF3Ukc8oqgdOF2qRzS2w7LfRKw7yDROzdj/QNtIlCJeN7z4o8M7HNwmIqggAlmVHI3j1uIRSlxWUQK4xxmvQpEuYd7fbw4HMr8Gl4FUJXY3GuuLi3KoanwvypRf0GJamv7CAm9wHtr/zdFfoPhFlp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcC4PHx4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcC4PHx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B9E1F000E9;
	Wed,  8 Jul 2026 02:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783478245;
	bh=c1JuxJTYI9Cou+7ltriAtaCjSpE1PC98rSxYT5CMPr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VcC4PHx4ClHt6zI+9/JsC7K2oBHyjSJnaLWgwr8ky/DABPGlUYzdAdhNJ21IvrGrk
	 M7T03WTnKeozeB97VlMpX5dS+PWxR+kMnxGKQ+vBSVWvA664mFFxt/CPzlQXeAYrGi
	 zxOE8kiwARQRdsHR4HGZo+gkt7FTo0UePBoS5vuoCbsgqn2RJlmNKhYsgNtBlIIQfc
	 q0INN1mpPy3VH5VtTHDoI7nhSFBz9joRwE9CHYFNq5Ehsa4jAkiUHLM4o9sSZGQP1/
	 q2kIIp/Za4VtJ080FdtksPyBDh/LcfMH+/FLWkIYaXEiFEalwSzbvrOplv6sIJ8IOS
	 JXoloZpIESqYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 19/24] dyndbg: pin class param storage to u32
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-dd-maint-2-v6-19-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-19-381f3edb0045@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 02:37:24 +0000
Message-Id: <20260708023725.52B9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Support for classmaps with more than 32 classes is broken, causi=
ng undefined behavior on 32-bit architectures and silent truncation on 64-b=
it architectures.
--

--- Patch [19]: [PATCH v6 19/24] dyndbg: pin class param storage to u32 ---
commit df6ebc9b56fab43581ec7860d30aab6f33272ee2
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: pin class param storage to u32

This commit changes the storage of dyndbg class parameters from unsigned lo=
ng
to u32 for consistency across architectures. It also shrinks __drm_debug ba=
ck
to u32.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index d99c69b9ad12f..af05f4ae3b55e 100644
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
Since classmaps can theoretically contain up to 63 classes (as mentioned in
the commit message), is there a risk of an out-of-bounds shift on 32-bit
architectures?

BIT(bi) expands to 1UL << bi, so if map->length is greater than 32, this
shift would exceed the capacity of an unsigned long on 32-bit systems.

On 64-bit systems, *new_bits is now a u32. When it is combined with BIT(bi)
using a bitwise AND, the u32 is zero-extended. Will this cause new_b and
old_b to always evaluate to 0 for classes >=3D 32, silently ignoring the
requested state?

[ ... ]
> @@ -704,24 +707,24 @@ static int param_set_dyndbg_module_classes(const ch=
ar *instr,
[ ... ]
>  	case DD_CLASS_TYPE_LEVEL_NUM:
>  		/* input is bitpos, of highest verbosity to be enabled */
>  		if (inrep > map->length) {
> -			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
> +			pr_warn("%s: level:%u exceeds max:%d, clamping\n",
>  				KP_NAME(kp), inrep, map->length);
>  			inrep =3D map->length;
>  		}
>  		old_bits =3D CLASSMAP_BITMASK(*dcp->lvl);
>  		new_bits =3D CLASSMAP_BITMASK(inrep);

[Severity: Medium]
Will this silently prevent enablement of classes >=3D 32?

CLASSMAP_BITMASK was changed to limit the generated mask to 32 bits, but
map->length is not restricted to 32.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dd-maint-2=
-v6-0-381f3edb0045@gmail.com?part=3D19
