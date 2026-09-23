Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441214349AA
	for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203782; cv=none; b=ET9KCMp6qxzHb1LBcBuczvBK/mSOFC6mRMT3slcmrDDTk59bRreU6w2DZXyI5gwfeXQ4ISkbGRTj9/82rC7yGaaiNo4WGJQ1eTBAio17k8w5dHMyH6ycQEoEi6gfltp6z9wmEqxKRdtVDRPGponzKdggt1Jt5dX9g5jCeWewV4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203782; c=relaxed/simple;
	bh=yJ0faqstv+RkOihGGRsnzoIG1acYNlqKwWdrzEuMIKY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y9E8RYIH/fUo+RXKQ1ohdRH7jhM7KX6PNnmepALmKAtIXQ2XPWVVxyXvQEPc6KEoBQSAJ29ov8YpqctgykSC9uzC1k1MFetXuSikwbzPCQgvQlKjXwUMXfq7bFjLSs26arrMNVWQLsG2GcGOoyHbnsYR94dlkc6Yc0+6y+eOlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhH3PxDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhH3PxDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEB51F00893;
	Wed, 23 Sep 2026 22:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203780;
	bh=oEVINwN1fsaBxbTWTmB9UveFtaUrQhkMplONQt/zYhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LhH3PxDWqbDzwdS17+H0D3CuXIHYNf3UfLXhkJVjYePKD4Drr5wubCEc+XndP+XOd
	 mhTNqXbyZYGKGzdHrNvXtaCgV8odtKJ2gcq6iVRiEZ+g3ku4CCf7MGR3QvG+Q1OW/p
	 poAdCzQ3itBx3B6dSD0C2WsyNBiDTfFfb78x4Y4JsVQxyYzhFy+0YBLlwYiBdBnBrQ
	 b3c6p9fSceYe21WD6AuBowRyv+CMVB5EoEz8GEPw8LbmJEGvIHlKdUGPKD2Un5mIlY
	 To/exwyT2tpF0NMYlRJRvMgTHjxNeAG/hPfveUX8oKP+/dFkCHWPWU+YEYGjqCAnoL
	 UP2sO4RDh4zGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 23/38] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-23-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-23-9b6c217fdf2f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:49:40 +0000
Message-Id: <20260923224940.ABEB51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dyndbg: TOCTOU race in ddebug_sync_classbits allows stale module=
 settings
- [Low] dyndbg: incompatible pointer type in module section load
--

commit 0e12bed35baa8c038def6b06ffc95416176ee997
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP

This commit replaces DECLARE_DYNDBG_CLASSMAP with an explicit client-server
model using DEFINE and USE macros. It resolves boot-time parameter
propagation failures by establishing a robust reference linkage. At module
load time, dyndbg now scans and resolves parent classmap references.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
[ ... ]
> @@ -2791,6 +2791,9 @@ static int find_module_sections(struct module *mod,=
 struct load_info *info)
>  	mod->dyndbg_info.maps.start =3D section_objs(info, "__dyndbg_class_maps=
",
>  						   sizeof(*mod->dyndbg_info.maps.start),
>  						   &mod->dyndbg_info.maps.len);
> +	mod->dyndbg_info.users.start =3D section_objs(info, "__dyndbg_class_use=
rs",
> +						   sizeof(*mod->dyndbg_info.users.start),
> +						   &mod->dyndbg_info.users.len);

[Severity: Low]
The len field in struct _ddebug_class_users is declared as a signed int, but
section_objs() expects an unsigned int pointer for its num parameter. Could
passing &mod->dyndbg_info.users.len here trigger an incompatible pointer
type compiler warning and result in a build error under standard
configurations?

[ ... ]
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
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
> +		new_bits =3D val;
> +		v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bits);
> +		ddebug_apply_class_bitmap(dcp, &new_bits, 0, modname);

[Severity: Medium]
Because dcp->bits is read locklessly via READ_ONCE() before
ddebug_apply_class_bitmap() takes ddebug_lock, is there a race condition
here?

If a user concurrently writes to the corresponding sysfs parameter, the sys=
fs
thread will update existing modules under the lock, release it, and then
update the parameter value.

If a concurrent module load thread executing ddebug_sync_classbits() reads
the old parameter value right before the sysfs thread writes the new value,
and then acquires the lock to apply the settings:

sysfs thread:
param_set_dyndbg_module_classes()
    mutex_lock(&ddebug_lock);
    // updates existing modules
    mutex_unlock(&ddebug_lock);

Module load thread in ddebug_sync_classbits():
    val =3D READ_ONCE(*dcp->bits); // reads old stale value

sysfs thread:
    *dcp->bits =3D new_value;

Module load thread in ddebug_sync_classbits():
    ddebug_apply_class_bitmap(...)
        mutex_lock(&ddebug_lock);
        // applies stale value

Would the newly loading module miss the concurrent sysfs update and
initialize with stale debug class settings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-pa=
rt2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D23
