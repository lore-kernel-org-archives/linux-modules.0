Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5E379C27
	for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204000; cv=none; b=YtDT8ECbnd2+aggijW0PKFMM36aNkOAO3chHQk18Q7XNGIlOQlV/W9UOuKY7wZc0aFnl++liafO9Nryzu8MHGZ03epbtPFYyFPhqRHDeMruypRgerwEWFOplL8VddKgPl64T3VWu49rV6jawa+IwMrl9PqSKFrA6xEWpAb9C1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204000; c=relaxed/simple;
	bh=bKCGnlYl9o2/hxiNBgTHMKDB8FUHDXs6kAuB/FWPkH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rlWAE0RvvFPHmTzNVS38ya2XurQ8pjsnu5qJ1aTzio8W5Q6w5pMuU6vN/gi+i7pokPtq7B9ZGJ4+8nGP7moLXfm70O0nK47N4eT0VcXxWkxfknoBhcHNYqPZv2BaQSW45mrxb1G84gQSBReedoBJUnpKPhlGlkDO97yLL92Un2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEGNm4xC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEGNm4xC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FA81F000FF;
	Wed, 23 Sep 2026 22:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203998;
	bh=Rc8/RMkUyLUQbirB8h84mJPdqZ4rXMWzsxoKZyAFhTk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hEGNm4xCBLc+bwtcqJk6NVT3SFJ1vrzTsBcXfjBmdv0hhC5YYqKbobIJOXL9J66tP
	 3lhEZIn3DdqS81Bpvn0Q5onqcVTCb/51fSsQrlKPnjgUCcwyc7qJ+1BO76+VSWMqio
	 jjp5O76W86gVkCV7QkJHMPfiNiHcpUg3BUeGDA1G2FhAD8C/kgtgLxMdFg2rnLjXv8
	 7oe9N6E6Flsj5CEOlCvgR6f7xtgFnCsmcYY9fgaz9xu2kDQOkze4hMNaBI3cfpa9JX
	 dZnWLO3mUuRW/+Wr2a+1L7SMTuUAR9vX1tSk6WKbgcP8yUiPOZ5egVH+B/te/pah7p
	 7z93bmB5NjIrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 32/38] dyndbg: resolve "protection" of class'd
 pr_debug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-32-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-32-9b6c217fdf2f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:53:17 +0000
Message-Id: <20260923225318.68FA81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dyndbg: race during module load bypasses ABI protection permanen=
tly
--

commit c8a052c030fff7b63aa2d9e4c2dc3aa455948704
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: resolve "protection" of class'd pr_debug

This patch implements an ABI protection mechanism for dynamically debugged
classes by binding a controlling sysfs parameter to classmaps. If a module
parameter is configured, it protects class'd callsites from being
accidentally modified by un-classed wildcard queries.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 636a88994a774..d300d44c1a82e 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -252,7 +294,28 @@ static bool ddebug_match_desc(const struct ddebug_qu=
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
>  }

[Severity: Medium]
Does this code expose a race condition when a module is loading?

Looking at ddebug_add_module(), the module is added to ddebug_tables and the
ddebug_lock is dropped before map->controlling_param is initialized:

lib/dynamic_debug.c:ddebug_add_module() {
	...
	mutex_lock(&ddebug_lock);
	list_add_tail(&dt->link, &ddebug_tables);
	mutex_unlock(&ddebug_lock);

	if (dt->info.maps.len)
		ddebug_apply_class_maps(&dt->info);
	...
}

If a concurrent wildcard query (like echo -p > /proc/dynamic_debug/control)
is processed while the lock is dropped but before ddebug_apply_class_maps()
finishes binding the parameter, site_map->controlling_param will be NULL.

This causes ddebug_class_wants_protection() to return false, bypassing the
protection and erroneously enabling the callsites.

[ ... ]

> @@ -772,11 +833,14 @@ static int param_set_dyndbg_module_classes(const ch=
ar *instr,
>  					   const struct kernel_param *kp,
>  					   const char *mod_name)
>  {
> -	const struct ddebug_class_param *dcp =3D kp->arg;
> -	const struct ddebug_class_map *map =3D dcp->map;
> +	struct ddebug_class_param *dcp =3D kp->arg;
> +	struct ddebug_class_map *map =3D dcp->map;
>  	u32 inrep, new_bits, old_bits, old_val;
>  	int rc, totct =3D 0;
> =20
> +	if (map && !map->controlling_param)
> +		map->controlling_param =3D dcp;

[Severity: Medium]
Is it safe to assign map->controlling_param here without holding
ddebug_lock or using WRITE_ONCE()?

Since this shared state is accessed by concurrent queries, could this
cause a data race?

[ ... ]

> @@ -1332,25 +1395,40 @@ static void ddebug_sync_classbits(const struct ke=
rnel_param *kp, const char *mod
>  	}
>  }
> =20
> -static void ddebug_match_apply_kparam(const struct kernel_param *kp,
> -				      const struct ddebug_class_map *map,
> -				      const char *mod_name)
> +static struct ddebug_class_param *
> +ddebug_get_classmap_kparam(const struct kernel_param *kp,
> +			   const struct ddebug_class_map *map)
> +{
> +	struct ddebug_class_param *dcp;
> +
> +	if (kp->ops !=3D &param_ops_dyndbg_classes)
> +		return NULL;
> +
> +	dcp =3D (struct ddebug_class_param *)kp->arg;
> +	return (map =3D=3D dcp->map)
> +		? dcp : (struct ddebug_class_param *)NULL;
> +}
> +
> +static void ddebug_match_apply_kparam(const struct kernel_param *kp,
> +				      struct ddebug_class_map *map,
> +				      const char *mod_name)
>  {
> +	struct ddebug_class_param *dcp =3D ddebug_get_classmap_kparam(kp, map);
> =20
>  	if (dcp && dcp->map =3D=3D map) {
> +		/*
> +		 * Bind controlling_param to activate ABI protection in
> +		 * ddebug_match_desc(), shielding callsites from non-class
> +		 * wildcard (>control) queries.
> +		 */
> +		map->controlling_param =3D dcp;
>  		v2pr_info(" kp:%s.%s =3D0x%x", mod_name, kp->name, *dcp->bits);
>  		vpr_cm_info(map, " %s maps ", mod_name);
>  		ddebug_sync_classbits(kp, mod_name);
>  	}
>  }

[Severity: Medium]
Can the delayed assignment of map->controlling_param combined with
ddebug_sync_classbits() result in permanent desynchronization?

During the race window in ddebug_add_module() mentioned above, callsites
can be erroneously enabled by a concurrent query. Once the module loading
thread resumes, it binds map->controlling_param here and calls
ddebug_sync_classbits().

However, ddebug_sync_classbits() passes 0 for old_bits:

lib/dynamic_debug.c:ddebug_sync_classbits() {
	...
	case DD_CLASS_TYPE_DISJOINT_BITS:
		val =3D READ_ONCE(*dcp->bits);
		new_bits =3D val;
		v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bits);
		ddebug_apply_class_bitmap(dcp, &new_bits, 0, modname);
	...
}

Because old_bits is 0, the function skips resetting any class bits that are
supposed to be off (since it sees new_bits (0) =3D=3D old_bits (0)). Doesn'=
t this
prevent the synchronizer from noticing and clearing the erroneously enabled
callsites?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-pa=
rt2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D32
