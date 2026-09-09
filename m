Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38725A2A4
	for <linux-modules@vger.kernel.org>; Wed,  9 Sep 2026 01:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788916391; cv=none; b=EMlSEXEAouiuvRK4oDej6BO3bhaoQX7Shok7rGda4AR0Aioe9zSqzqs92/feN9QyCsesqSM53jH2wgmI+CAxDuWUUDK+1JGcWopsvWYxC97pMwWa98JoLI7omDSr/ltklsSYDUGfKZH4bJInuT8CUFtE78gucot4xFxS3uZXuBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788916391; c=relaxed/simple;
	bh=mCe+V3Du7xOXEqyTZkHEG69PVD6ik54MSqiWSCVem/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V3WmKHh4JFdUYWouCLFo2S8URezOO5KvDHhEoCYm76PHt/sMFOML4yl63VMDGgpt6qH7P05/5VONnMSzavP/rNzEy7NzR/d1SG1e3UgYGG+huXHt67ISW8BhtRbgVcnrlqh65rCOv7OkiAw4ql6EB00srZx8lQ7eZ+DP72M8Ths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBKFklrn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBKFklrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543B91F00A3A;
	Wed,  9 Sep 2026 01:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788916389;
	bh=UFRPDA8m8KiCTIUyiHHoDKKe8gdZ4atFzqQJTtd2PQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SBKFklrnztE+DyBEIYgp/1QHkuesOkeanah/5zMnSKdEmLkHAhZahOW8pTEAjilo+
	 /BfII9UorwwpOInTwJuCedTTXnzskygyWvF4V0QBa0slFtaAxgIOedlQOCvhuR5HG7
	 iHPhBLj/EcBEUyAStfmtglL0qh/m2WT76gykdOyaLiyccB6F2bMLNU2SSdlU5nyz6W
	 Zu5qbHdbWQ7LfqyN31cQ7R75HoNMJ4m8HFK/mpwwYStYSxCPIMHreltrpHIqctAHAT
	 t+Znb6ELmKMi1h542wOfS1AqKtgV5+LvZ4ffFf8JXQ2nkvnxm3f3uL1mitlAww9Qur
	 JGwKYhW8dfOeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 24/39] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-24-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-24-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:13:08 +0000
Message-Id: <20260909011309.543B91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Newly loaded classmap user modules fail to sync disabled classes=
 due to a hardcoded `0UL` state assumption.
- [Medium] TOCTOU race in `ddebug_apply_class_users` when a class parameter=
 is modified via sysfs concurrently with module load.
- [Low] struct ddebug_class_user defines mod_name as non-const char*, which=
 discards qualifiers from string literals.
--

commit ed72477b68f823658c20da0da2c5754d60e12c69
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
   =20
DECLARE_DYNDBG_CLASSMAP had a flaw: multiple invocations across both
core and driver modules broke the K&R "define once, refer afterwards"
principle, causing boot-time parameter propagation failures.

Replace it with an explicit client-server model:
[ ... ]

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 144a2a947abcb..6517e0169a803 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
[ ... ]
> +struct ddebug_class_user {
> +	char *mod_name;

[Severity: Low]
Does this code discard qualifiers from string literals?

Using the DYNAMIC_DEBUG_CLASSMAP_USE_ macro assigns the string literal
DDEBUG_MODNAME to this field, which can trigger compiler warnings and
compromises type safety. Should this be declared as const char *mod_name
instead, similar to how it is defined in struct ddebug_class_map?

> +	struct ddebug_class_map *map;
> +	const int offset;	/* offset from map->base */
> +} __aligned(8);

[ ... ]
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 2065bfd1687e0..0e25b4d53942b 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> +/* called for class-users only, parse_one does this for definer modules =
*/
> +static void ddebug_sync_classbits(const struct kernel_param *kp, const c=
har *modname)
> +{
> +	const struct ddebug_class_param *dcp =3D kp->arg;
> +	u32 val, new_bits;
> +
> +	if (!dcp || !dcp->map)
> +		return;
> +
> +	switch (dcp->map->map_type) {
> +	case DD_CLASS_TYPE_DISJOINT_BITS:
> +		val =3D READ_ONCE(*dcp->bits);
> +		ddebug_class_param_clamp_input(&val, kp);
> +		new_bits =3D val;
> +		v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bits);
> +		ddebug_apply_class_bitmap(dcp, &new_bits, 0UL, modname);

[Severity: Medium]
Will this fail to sync disabled classes for newly loaded modules?

By hardcoding 0UL as the old_bits argument, ddebug_apply_class_bitmap()
assumes the module starts with all debug classes disabled. This means it
will skip generating disable commands for any cleared bits.

If a module is compiled with -DDEBUG, its callsites are enabled by default
and won't be correctly disabled to match the system-wide classmap parameter
state.

> +		break;
> +	case DD_CLASS_TYPE_LEVEL_NUM:
> +		val =3D READ_ONCE(*dcp->lvl);
> +		ddebug_class_param_clamp_input(&val, kp);
> +		new_bits =3D CLASSMAP_BITMASK(val);
> +		v2pr_info("  %s: lvl:%d bits:0x%x\n", KP_NAME(kp), val, new_bits);
> +		ddebug_apply_class_bitmap(dcp, &new_bits, 0UL, modname);
> +		break;
> +	default:
> +		pr_err("bad map type %d\n", dcp->map->map_type);
> +		return;
> +	}
> +}
[ ... ]
> @@ -1238,12 +1404,17 @@ static int ddebug_add_module(struct _ddebug_info =
*di)
>  	 */
>  	dt->info =3D *di;
>  	dd_set_module_subrange(i, cm, &dt->info, maps);
> +	dd_set_module_subrange(i, cli, &dt->info, users);
> =20
>  	mutex_lock(&ddebug_lock);
>  	list_add_tail(&dt->link, &ddebug_tables);
>  	mutex_unlock(&ddebug_lock);
> =20
> -	vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mod_name=
);
> +	if (dt->info.users.len)
> +		ddebug_apply_class_users(&dt->info);

[Severity: Medium]
Can this introduce a TOCTOU race with concurrent sysfs updates?

Here, the new module is added to ddebug_tables and the ddebug_lock is
dropped before the module's initial settings are applied by
ddebug_apply_class_users().

If a concurrent sysfs write to the dyndbg class parameter occurs in this
lockless window, the sysfs thread will acquire ddebug_lock, apply its new
parameter value to all modules (including this newly added one), and update
the parameter value.

When this load thread then calls ddebug_apply_class_users(), it will read t=
he
parameter unprotected. If it read the old parameter value before the sysfs
thread overwrote it, it will subsequently acquire the lock deep inside
ddebug_change() and apply the stale old value, overwriting the sysfs thread=
's
newer changes. This would leave the module permanently out of sync.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D24
