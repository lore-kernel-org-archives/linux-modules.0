Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E24DAF96
	for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577803; cv=none; b=E1H455UKtRyAwcDsvNjVKfj1g/tAdjbGoF2DQ09qm9GSnTF+jWZIFCAOQwDxdnxIbzCAjvECvZZMb6rQ9dlIxf5edD9U/U8kSBfgxVyKvPqDBEko65FuXU1S7hhc74cZfKS/7D9oGmbx1l6HeDNTc8hU/2q36mrXNDirrS82Uk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577803; c=relaxed/simple;
	bh=jL9L8dYH0HF0XotwAegwqqiUJoFF891fmVRzzm2D+0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HWYODynBGlRq/+DrrI1ttSWA6vNMyAEzilBE2icubUv6+z2GK7yFCTPvKnZ+yg8G3/UB6PW/SO/yqB15AQ22p+ALLuOwQVGEAsH+Cjr+SC8HnO77bbeOsKpxMmCUPCRdaemCNG+VU8zhVk/Oaqxv+74JHSw9Xnbef4tv26iHu6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMdoiVCl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMdoiVCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6148A1F000FF;
	Wed, 16 Sep 2026 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577780;
	bh=S3g6xYYlbmO2Ve8K8DLvb+2r9RmCjeNeWyDLqiGiLqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fMdoiVCl8H3+zC3SU/J5a4Ri5KRxy9M4GyXRJX1KQZMwCuZWwkdhRJHd4RjgefGW8
	 I94PZF3Dl6dRN6y4j6M8/BfC5i6lvEpCHIskZqMD60hbHsw1iHKyP+rNust37Gg2U3
	 fbPLEVrLcD2NsMLv+iMrEIGQq580RCMXLtDPvOeOx3X34mgCZrc0n3XjhkIfmK6j+Z
	 h6Ln/o7KXyPmPEC6C7t1hF5LeRQbHNlkLz8kEYM/W5ASN9YcP27hpmRj/JBGyTgiIB
	 hCs36J7S5eJmcyDLRrWneFjHmzOOicev2yhIf/8oA1NN4mOiJFezgJo3ynKHiYeq26
	 Q0iL43mrEMosQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 32/38] dyndbg: resolve "protection" of class'd
 pr_debug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-32-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-32-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:56:19 +0000
Message-Id: <20260916165620.6148A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dyndbg: module's own classmaps bypass protection due to missing co=
ntrolling_param init
- [Medium] dyndbg: data race on map->controlling_param due to lockless init=
ialization
--

commit 5ffc9f5551765ac7c4413f320b8e9d1977dbe99a
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: resolve "protection" of class'd pr_debug

This commit updates the protection mechanism for class'd pr_debug callsites
against unclassed queries. It introduces a requirement that a sysfs paramet=
er
(controlling_param) must be present for a classmap to be protected.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index c023d07623f29..ac54a0499369c 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -257,7 +300,28 @@ static bool ddebug_match_desc(const struct ddebug_qu=
ery *query,
>  	    dp->lineno > query->last_lineno)
>  		return false;
> =20
> -	return true;
> +	/*
> +	 * above are all satisfied, so we can make final decisions:
> +	 * 1- class FOO or implied class __DEFAULT__
> +	 * 2- site.is_classed or not
> +	 */
> +	if (query->class_string) {
> +		/* class FOO given, exact match required */
> +		return (dp->class_id =3D=3D selected_class);
> +	}
> +	/* query class __DEFAULT__ by omission. */
> +	if (dp->class_id =3D=3D _DPRINTK_CLASS_DFLT) {
> +		/* un-classed site */
> +		return true;
> +	}
> +	/* site is class'd */
> +	site_map =3D ddebug_find_map_by_class_id(di, dp->class_id);
> +	if (!site_map) {
> +		WARN_ONCE(1, "unknown class_id %d, check %s's CLASSMAP definitions", d=
p->class_id, di->mod_name);
> +		return false;
> +	}
> +	/* module(-param) decides protection */
> +	return !ddebug_class_wants_protection(site_map);

[Severity: High]
Does this code inadvertently bypass ABI protection for a module's own
class'd pr_debug sites?

Since the ddebug_apply_class_maps() block was removed in v10, it appears
ddebug_add_module() only initializes user maps (by calling
ddebug_apply_class_users() when dt->info.users.len > 0), and misses
initializing the defining module's own native classmaps.

Consequently, if a module defines a classmap and parameter but has no
loaded dependent modules, map->controlling_param remains NULL. This causes
ddebug_class_wants_protection() to default to false, allowing unclassed
legacy queries to incorrectly modify these protected sites.

>  }
> =20

[ ... ]

> +static void ddebug_match_apply_kparam(const struct kernel_param *kp,
> +				      struct ddebug_class_map *map,
> +				      const char *mod_name)
> +{
> +	struct ddebug_class_param *dcp =3D ddebug_get_classmap_kparam(kp, map);
> =20
>  	if (dcp && dcp->map =3D=3D map) {
> +		map->controlling_param =3D dcp;

[Severity: Medium]
Can this assignment introduce a data race?

In ddebug_add_module(), the new debug table is published to the globally
visible ddebug_tables list under ddebug_lock, but the lock is released
before calling ddebug_apply_class_users().

Since ddebug_match_apply_kparam() is subsequently called without locks,
concurrent threads processing ddebug_change() could hold ddebug_lock
and read map->controlling_param while it is being updated here, leading
to a data race.

>  		v2pr_info(" kp:%s.%s =3D0x%x", mod_name, kp->name, *dcp->bits);
>  		vpr_cm_info(map, " %s maps ", mod_name);
>  		ddebug_sync_classbits(kp, mod_name);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D32
