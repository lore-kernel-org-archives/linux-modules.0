Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089B47FB1C
	for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203511; cv=none; b=MRoUGcQMJSbJUSWL443gIYXINpuMhXoU2vHZ5P0Wj+tBq9F0q8vpd/LZ/lb3ik1YQg3KWWwl0o1VMT6nGRRUehq3LRt73gKjXtSfM1yHCKxog9coLjzNBAvQX3Oox4moj3cdrlnCQanBD1rRxMvQEZOfPmTgrePwzgso9KOCxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203511; c=relaxed/simple;
	bh=GmOQhXDPTT4EQnHjgHXrQ53rfCvlN6LoIzh5cV5P2VE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZF7yLev1UtIV1eMhmHE8vFWdaetryHULTZedccPJu3182Ss5tETJg5gqoUofwxG4wK61ZhU70EyIrwbQPaKwo9fYuXb9tkdBU/gJwZ20+iTfhmc1WjjQ6JKGCNhZiCOpyH2YwfF5q63cByuPDfN4pvJfhOzZmNSrxlX8sSjxojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=den/QCVO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="den/QCVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE3F1F000FF;
	Wed, 23 Sep 2026 22:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203509;
	bh=LZlE+GmL6EuuIFtlxRYwAZArS98TNCqm7qx1WgPX/Hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=den/QCVOD/qcZl/+oeQJN8alWunB4JvGTUnoEJEZqb5OPO1s1wNxlUeVTzavSM9Ao
	 nYhu4g5KFMIqxj4fXQPn9FvWKKCAQ5yQlbcecsAKh11xoOXQBgdLQqWafm5MZR0R4C
	 9r9BkHHPymwrf+JbMPit1S99be+KOrXcdFkoozsvm1zlS06shg2XdxPzsbBZcBQOD2
	 1Pz/+U6+igvguL0iB7gJu8VCJ/u5H2DzHkkO0N2U8ueqYqxTSxdzAR6/IEIQYY8+RC
	 O/cIS8Ihzth6B0gE3wydiqdbxL+3ZdwWC/8d+TRfeUzxZuz90VQStquuuz4GxHqILb
	 zaTztCZDlZMVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 14/38] dyndbg: Bind callsites and classmaps to
 DDEBUG_MODNAME
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-14-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-14-9b6c217fdf2f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:45:08 +0000
Message-Id: <20260923224509.4DE3F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dyndbg: classmaps for loadable modules are dropped if DDEBUG_MOD=
NAME is overridden
--

commit 5e35c3cb693ea4379aa99e08e89d78671956f5c5
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: Bind callsites and classmaps to DDEBUG_MODNAME
   =20
Currently, dyndbg binds KBUILD_MODNAME directly into callsite and
classmap declarator macros.

For built-ins, KBUILD_MODNAME defaults to the basename of the source
file. For many subsystems, this fragments what should be a single
module into separate file basenames: kernel/power/ produces "main",
"suspend", "hibernate", "snapshot", and "swap" when all should be
"power". Conversely, multiple unrelated built-in files across the tree
(init/main.c, kernel/power/main.c) all collide under "main".

[ ... ]

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index baf5c0853f459..85863e24ad134 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
[ ... ]
> @@ -121,7 +129,7 @@ struct ddebug_class_param {
>  	static struct ddebug_class_map __aligned(8) __used		\
>  		__section("__dyndbg_classes") _var =3D {			\
>  		.mod =3D THIS_MODULE,					\
> -		.mod_name =3D KBUILD_MODNAME,				\
> +		.mod_name =3D DDEBUG_MODNAME,				\
>  		.base =3D _base,						\
>  		.map_type =3D _maptype,					\
>  		.class_names =3D _var##_classnames,			\

[Severity: Medium]
Will this drop classmaps for loadable modules if a maintainer overrides
DDEBUG_MODNAME?

When a loadable module is loaded, ddebug_module_notify() calls
ddebug_add_module() using the module's actual load name (mod->name) to
initialize the ddebug_table's module name.

During initialization, ddebug_attach_module_classes() attempts to match the
classmap to the module by comparing strings:

lib/dynamic_debug.c:ddebug_attach_module_classes() {
    ...
    if (!strcmp(cm->mod_name, dt->mod_name)) {
    ...
}

If a maintainer uses the opt-in hook (e.g., ccflags-y +=3D -DDDEBUG_MODNAME=
=3D'"power"')
on a loadable module whose load name is "suspend", cm->mod_name will be "po=
wer"
while dt->mod_name is "suspend".

Since the string comparison fails, will all classmaps for the loadable modu=
le
be silently dropped, causing class'd pr_debug calls to lose their functiona=
lity
and trigger pr_warn spam on load due to unknown class IDs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-pa=
rt2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D14
