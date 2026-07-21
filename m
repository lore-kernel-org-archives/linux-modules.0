Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2344AB6D
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784668168; cv=none; b=Gq7M+UZTBsaAJb93BLr0u8zMWhyhwZAgPpQVDjuKpvzDByTc5TMmSlwdlu7HE2zQQwRCT/wicxSn9F2lOPW9x0ZBL2nsVncCOmyQgwSeFtdfCNLvpwpSIgZekcrT3Jm6ODEyIHsSjBctC2KIiuL1tZ8QR9b8xHM22jGgeipMuiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784668168; c=relaxed/simple;
	bh=YaEIfhl2fRgDbsEPAJMv9eG9t3FCEoSqfYsrBioNhqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o5pjm4eCtktgoHCdk2XkWze2LCRSHjnCguEq0BGhFsam3UpWNCIZ8EYWLePjLbUQnvqzvzNIdqqtiRPADubNgO3pRefWDNChUrmkfvAgP3n5l2PflYHzcBv0jSlr7phlDa0peT4QHajovyfnARMrrgyfEHMbJG2Tv9zXJTHpbDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFnpq9+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFnpq9+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A8C1F00A3F;
	Tue, 21 Jul 2026 21:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784668166;
	bh=7wgDjnw7QnTpFWAn6E2MwK8kTJLqveKowBOvXf7xDcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FFnpq9+JxNEx8gQCQz+wJaNqqLGLSb/mjrU7W1O0TKNkq+LVvtYzf+BAxnlRQCHCt
	 Wyg8sHMZj49nkO2cHnQfv5vS2D1DFJQNrgZ8pD73pC+6kIOKvW0dOBD/cfyMyPpHmG
	 1lJFLBsZAX6s7l5fhOdIZi6Il7DGBCgjKNzxVIVxFBCCNhcOlvBorxNs4WwNZQ0c4i
	 Tt40Ob4sIfLXsys8UHe1djbeHXbjok6Zyz7qa/CiTraVSGYIy0QSUqRYaN4aGjm3l/
	 zuaN/nQsU4qsrqevcdmd8dsxe0yiAGbGU1Kf+6vGovuHEnEVqv0hzx1KQwIiDF/cW7
	 XRWCi6wv9eEYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 25/29] dyndbg,module: make proper substructs in
 _ddebug_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260721-dd-maint-2-v7-25-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
 <20260721-dd-maint-2-v7-25-010fbe73b311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 21:09:26 +0000
Message-Id: <20260721210926.A4A8C1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Built-in modules without their own dynamic debug class maps inco=
rrectly inherit the entire array of built-in class maps, causing cross-cont=
amination of debug class settings.
--

--- Patch [25]: [PATCH v7 25/29] dyndbg,module: make proper substructs in _=
ddebug_info ---
commit 9690152a047a31662e977dac229f6c3d6cb68cd2
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg,module: make proper substructs in _ddebug_info

This commit recomposes struct _ddebug_info by inserting proper sub-structs
for descriptors and class maps, and updates the dynamic debug core to use
these new structures.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 60b67face46e1..e7742fcca50ba 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -1185,12 +1186,12 @@ static void ddebug_attach_module_classes(struct d=
debug_table *dt, struct _ddebug
>  	 * the builtin/modular classmap vector/section.  Save the start
>  	 * and length of the subrange at its edges.
>  	 */
> -	for_subvec(i, cm, di, classes) {
> +	for_subvec(i, cm, di, maps) {
>  		if (!strcmp(cm->mod_name, dt->mod_name)) {
>  			if (!nc) {
>  				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d=
\n",
>  					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
> -				dt->classes =3D cm;
> +				dt->info.maps.start =3D cm;
>  			}
>  			nc++;
>  		} else if (nc) {
> @@ -1199,7 +1200,7 @@ static void ddebug_attach_module_classes(struct dde=
bug_table *dt, struct _ddebug
>  		}
>  	}
>  	if (nc) {
> -		dt->num_classes =3D nc;
> +		dt->info.maps.len =3D nc;
>  		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
>  	}
>  }

[Severity: Medium]
When a module has no classes and nc remains 0, does dt->info.maps retain
the values originally copied from di?

Since dt->info =3D *di is performed before this function is called, this me=
ans
the module will incorrectly inherit the entire global array of built-in
class maps. Could this cause cross-contamination of debug class settings
between unrelated modules?

[ ... ]
> @@ -1212,10 +1213,10 @@ static int ddebug_add_module(struct _ddebug_info =
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
> @@ -1229,19 +1230,18 @@ static int ddebug_add_module(struct _ddebug_info =
*di, const char *modname)
>  	 * this struct ddebug_table.
>  	 */
>  	dt->mod_name =3D modname;
> -	dt->ddebugs =3D di->descs;
> -	dt->num_ddebugs =3D di->num_descs;
> +	dt->info =3D *di;
> =20
>  	INIT_LIST_HEAD(&dt->link);
> =20
> -	if (di->classes && di->num_classes)
> +	if (di->maps.len)
>  		ddebug_attach_module_classes(dt, di);

[Severity: Medium]
If di->maps.len > 0 (which is true for built-ins since di spans all global
maps), but the module itself has no classes, ddebug_attach_module_classes()
won't reset dt->info.maps.len to 0.

Would it be better to clear dt->info.maps.len and dt->info.maps.start here
before calling ddebug_attach_module_classes() to prevent the module from
accidentally keeping the global state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dd-maint-2=
-v7-0-010fbe73b311@gmail.com?part=3D25
