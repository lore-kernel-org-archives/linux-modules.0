Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2950542802
	for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576096; cv=none; b=qjovuNraRKxRgQB2ZDEypcFKjs0EVL8LayraVa1d451k3drpJhX8N0cSJnUuG/QlQlBDG0zXqTc7InD7iclYpoVyzoYf1NCGZWKs8vee9WrUVmYnxC73nvAg3oqCQsny2KEAoyNgAHDzvaCcZj5WA3/5Rjrew1JsHaziAjMBGT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576096; c=relaxed/simple;
	bh=99iSSOz6qgD8i5vmQH+PiQq30SevlBkPhoGAYtKAa3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MpCiIcIEbP9dTJG+o827802LCz3yqMhXnAgaaqkyPMIMzMVQpsnfOL+xD0+OFAeZGU+sqBFFaed1KUMTSBEFPsceY33XCJNt9hNbdryrAl9cfCeU/lD5d6h2X+IH9F5ZwL/4R3XL1EtGXUgBjQx8D+siCixgD+/bZ4mLU+xHTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeatDIeM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeatDIeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434551F000FF;
	Wed, 16 Sep 2026 16:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576094;
	bh=LlcZw6XkDE/6bt45luqgzwD5XfsvVZ9DhDWP+PDIclg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UeatDIeM2moz1aNbz3PgQOoB8WIPTv/KeAltcrDxFgbJR/5BuPs79heQnrBb6tbHH
	 2kwrzV9hsYF9jGlbkvhd9cjU0jWfV2xs3Sdf/UsLyeM24rLufZ8E1sJC8LhIXN2fvl
	 JoQdB1JgC+JCwo4NtDOgZztxivpCqTKEvfttBm7tUTMHW28CdDWVV+2UVogp+ICplX
	 3JUPiM+qs1TvFWvEtzdvL7Q57dakZMXtnDMrOQ6MwC5rW+HHA9ziZVG03sJYZGqjLD
	 oocFltmmmVS998EniE7LAh5xLeS3I9IRlwLq7HYhV0eb+VfvSEC2UK++TD2MCDYypu
	 V3bV61kHX51jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 23/38] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-23-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-23-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:28:13 +0000
Message-Id: <20260916162814.434551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dyndbg: init_bits relies on _DPRINTK_FLAGS_DEFAULT evaluated in wr=
ong translation unit
- [Medium] dyndbg: TOCTOU race in ddebug_sync_classbits() causes out-of-syn=
c debug state
--

commit 3b29729057e8a4b4e0401fd7f3a74205f701c129
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP

This commit replaces DECLARE_DYNDBG_CLASSMAP with an explicit client-server
model using DYNAMIC_DEBUG_CLASSMAP_DEFINE and DYNAMIC_DEBUG_CLASSMAP_USE.
At module load time, it resolves reference records and automatically applies
the initial bitmap to the module.

Cc: linux-doc@vger.kernel.org

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 03dc35af4faa1..566c3860d7bfb 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> +static void ddebug_sync_classbits(const struct kernel_param *kp, const c=
har *modname)
> +{
> +	const struct ddebug_class_param *dcp =3D kp->arg;
> +	u32 val, new_bits, init_bits;
> +
> +	if (!dcp || !dcp->map)
> +		return;
> +
> +	init_bits =3D (_DPRINTK_FLAGS_DEFAULT & _DPRINTK_FLAGS_PRINT) ?
> +		CLASSMAP_BITMASK(dcp->map->length) : 0;

[Severity: High]
Does this evaluate _DPRINTK_FLAGS_DEFAULT in the context of the dynamic
debug library rather than the target module's translation unit? Since
dynamic_debug.c is not compiled with -DDEBUG, init_bits will always be
evaluated as 0 here. Could this prevent the system from properly disabling
callsites for modules that are loaded and compiled with -DDEBUG?

> +
> +	switch (dcp->map->map_type) {
> +	case DD_CLASS_TYPE_DISJOINT_BITS:
> +		val =3D READ_ONCE(*dcp->bits);
> +		new_bits =3D val;
> +		v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bits);
> +		ddebug_apply_class_bitmap(dcp, &new_bits, init_bits, modname);
> +		break;
[ ... ]
> @@ -1238,12 +1410,17 @@ static int ddebug_add_module(struct _ddebug_info =
*di)
[ ... ]
>  	mutex_lock(&ddebug_lock);
>  	list_add_tail(&dt->link, &ddebug_tables);
>  	mutex_unlock(&ddebug_lock);
> =20
> -	vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mod_name=
);
> +	if (dt->info.users.len)
> +		ddebug_apply_class_users(&dt->info);

[Severity: Medium]
Could this introduce a time-of-check to time-of-use (TOCTOU) race condition
between module loading and concurrent sysfs updates?

Once ddebug_add_module() adds the module to ddebug_tables and drops the
ddebug_lock, it proceeds to call ddebug_apply_class_users() (which then
calls ddebug_sync_classbits()).

In ddebug_sync_classbits(), the parameter value is read via
READ_ONCE(*dcp->bits) without holding the lock. If a concurrent sysfs write
updates the parameter and applies it to all modules in ddebug_tables
(including this newly added one), could the module load thread subsequently
resume and apply the stale value it just read, leaving this module's debug
state out-of-sync with the global parameter?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D23
