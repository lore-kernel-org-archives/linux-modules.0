Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F2C343208
	for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779522311; cv=none; b=cqnzcqANNxHe1WHs8xYQyHhtUmzLJ/Sjs6TPcXc5cPsY9cBNYalJ/t7V7VKhEWUP/HH2nHXAil8aJxmMBk7ostHhD8DVjAGDnPSucOj9TABoF3sV44JZ/RjaU2+Np4x8qAs/fSzvsqGW8skewC184+n6CFCm6zWlA1kMVr7Nhx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779522311; c=relaxed/simple;
	bh=Rk0AITy7uwo2pTmz9NNTR9Fx4mBoumecyeflxsL9Y+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JQS58lOeowjSVF8q/EXthz1sFfLrU10FO8G6LLr6bYd1S3EdIud5M+IPGawNruLusaEgrDAm71X+4Xasf2jKg3aNrHElX35zUV/16aZ7nj4XpiQ3Hpds0xoveDAyaMtKQBm2/X246h3jeEXcAFUxAJaZl472kf5mWAn8cGz/fJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW72eYsb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW72eYsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543791F000E9;
	Sat, 23 May 2026 07:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779522309;
	bh=Exk8ktQop1qhA3avn5rmah72HYRqZu4i+ajSTq3DQAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BW72eYsbjqnGphJx5IwoWqinlHl+xCFNfqBkZDXXFD6Q7iiVDoGFRKDZKaC6q5tp6
	 Wa2k+NZvIF6DtW50BlX9wEADFPC9OuSepQxed6Ldeab6Atg7g9Z3S4bAGejC9KGaS5
	 wgmVs38A5Zj2EqRtqZBoV6mskyP+bNf59A+YOwqn/ldg8MUZNeAA9+DmPW1fdTZk9o
	 S0bpWXq+wa3ieT/J2lauZyZGTjUY3FM4IJN1SpO07ylvFooY1eHx9eravATt6kCw9h
	 IYN7YlJTU2nm91cC7UiNkFWKQDUvzerRSsYz1UHq/5arVSCLAOus/qhdYt8I16pwjf
	 yKZJm4Wy3KRhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/24] dyndbg,module: make proper substructs in
 _ddebug_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260523-dd-maint-2-v2-19-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-19-b937312aa083@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 07:45:08 +0000
Message-Id: <20260523074509.543791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Module loader searches for incorrectly named dynamic debug section=
s, completely disabling dynamic debug for all loadable modules.
- [High] Built-in modules without class maps erroneously inherit all global=
 system-wide class maps due to missing state reset.
- [Low] Renaming `struct ddebug_class_param` breaks compilation of external=
 users like the DRM subsystem.
--

commit 647ef6a50774bbbe7f638336c42ae9d912b4ca12
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg,module: make proper substructs in _ddebug_info

This commit recomposes struct _ddebug_info by moving the descriptors and cl=
ass
maps fields into new sub-structures struct _ddebug_descs and struct
_ddebug_class_maps. It also normalizes all related struct names to use a
_ddebug_ prefix.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index a84dcc127e5a7..001bc84eadcab 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
[ ... ]
> @@ -81,21 +81,33 @@ struct ddebug_class_map {
>  	enum ddebug_class_map_type map_type;
>  };
> =20
> -/* encapsulate linker provided built-in (or module) dyndbg data */
> +/*
> + * @_ddebug_info: gathers module/builtin dyndbg_* __sections together.
> + * For builtins, it is used as a cursor, with the inner structs
> + * marking sub-vectors of the builtin __sections in DATA.
> + */
> +struct _ddebug_descs {
> +	struct _ddebug *start;
> +	unsigned int len;
> +};
> +
> +struct _ddebug_class_maps {
> +	struct _ddebug_class_map *start;
> +	unsigned int len;
> +};
> +
>  struct _ddebug_info {
> -	struct _ddebug *descs;
> -	struct ddebug_class_map *classes;
> -	unsigned int num_descs;
> -	unsigned int num_classes;
> +	struct _ddebug_descs descs;
> +	struct _ddebug_class_maps maps;
>  };
> =20
> -struct ddebug_class_param {
> +struct _ddebug_class_param {

[Severity: Low]
Does renaming this structure break compilation for external users?

For example, the DRM subsystem directly references the old structure name in
drivers/gpu/drm/drm_print.c:
"static struct ddebug_class_param drm_debug_bitmap"

Failing to update these external users will result in a build failure for
configurations enabling DRM.

>  	union {
>  		u64 *bits;
>  		u64 *lvl;
>  	};
>  	char flags[8];
> -	const struct ddebug_class_map *map;
> +	const struct _ddebug_class_map *map;
>  };
> =20
>  /*
[ ... ]
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a6058..c2b6e70f2e773 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2774,12 +2774,12 @@ static int find_module_sections(struct module *mo=
d, struct load_info *info)
>  		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
> =20
>  #ifdef CONFIG_DYNAMIC_DEBUG_CORE
> -	mod->dyndbg_info.descs =3D section_objs(info, "__dyndbg",
> -					      sizeof(*mod->dyndbg_info.descs),
> -					      &mod->dyndbg_info.num_descs);
> -	mod->dyndbg_info.classes =3D section_objs(info, "__dyndbg_classes",
> -						sizeof(*mod->dyndbg_info.classes),
> -						&mod->dyndbg_info.num_classes);
> +	mod->dyndbg_info.descs.start =3D section_objs(info, "__dyndbg_descripto=
rs",
> +						    sizeof(*mod->dyndbg_info.descs.start),
> +						    &mod->dyndbg_info.descs.len);
> +	mod->dyndbg_info.maps.start =3D section_objs(info, "__dyndbg_class_maps=
",
> +						   sizeof(*mod->dyndbg_info.maps.start),
> +						   &mod->dyndbg_info.maps.len);

[Severity: High]
Does this correctly match the section names emitted by the linker?

It looks like the section names here were updated to "__dyndbg_descriptors"
and "__dyndbg_class_maps", but the macros like DECLARE_DYNDBG_CLASSMAP and
DEFINE_DYNAMIC_DEBUG_METADATA still emit to "__dyndbg" and "__dyndbg_classe=
s".

Because the strings do not match, section_objs() will fail to find the
sections, setting their lengths to 0 and effectively discarding all
dynamic debug prints for loadable modules.

I see this regression is fixed later in the series by commit f9409a020a4bc
("dyndbg: improve section names").

>  #endif
> =20
>  	return 0;
[ ... ]
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 580aa258f902f..169b94ff6f8ed 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -1202,10 +1203,10 @@ static int ddebug_add_module(struct _ddebug_info =
*di, const char *modname)
>  {
>  	struct ddebug_table *dt;
> =20
> -	if (!di->num_descs)
> +	if (!di->descs.len)
>  		return 0;
> =20
> -	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
> +	v3pr_info("add-module: %s %d sites\n", modname, di->descs.len);
> =20
>  	dt =3D kzalloc_obj(*dt);
>  	if (dt =3D=3D NULL) {
> @@ -1219,19 +1220,18 @@ static int ddebug_add_module(struct _ddebug_info =
*di, const char *modname)
>  	 * this struct ddebug_table.
>  	 */
>  	dt->mod_name =3D modname;
> -	dt->ddebugs =3D di->descs;
> -	dt->num_ddebugs =3D di->num_descs;
> +	dt->info =3D *di;

[Severity: High]
Does this code leave dt->info.maps initialized to the entire system-wide
class maps array if the built-in module has no class maps?

In dynamic_debug_init(), the global _ddebug_info di is initialized with
.maps spanning the entire __dyndbg_classes section.

When this is copied via dt->info =3D *di here, dt->info.maps also spans
the entire section.

If the module has no class maps, ddebug_attach_module_classes() will run, b=
ut
the local variable nc remains 0. The block if (nc) at the end is skipped,
and dt->info.maps is never updated to reflect 0 length.

As a result, built-in modules without class maps falsely match unrelated
class maps from other built-in modules.

I see this regression is fixed later in the series by commit 6fc0ea29f4f01
("dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module").

> =20
>  	INIT_LIST_HEAD(&dt->link);
> =20
> -	if (di->classes && di->num_classes)
> +	if (di->maps.len)
>  		ddebug_attach_module_classes(dt, di);
> =20
>  	mutex_lock(&ddebug_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523-dd-maint-2=
-v2-0-b937312aa083@gmail.com?part=3D19
