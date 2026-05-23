Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7494E2773F7
	for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779522092; cv=none; b=aQWM89mSpbMwJtdhupGQFW7YWOd1p4ddeDnKNOtO1gW6qO8zmsR9qsmulXm+TUxzrKdHqIrgN0F/0jKL+iWQTzmNMdqBpXlwObn08OaNVLoOTodxBX/RZywSX7/mSkpWFSE66/J+9W8FTRl9GQB1kgPa3dHO7rEokiWc8UQ6+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779522092; c=relaxed/simple;
	bh=EjMG4JD0Zty11IntyHSezdxUK5ROCAji6wOPyze9tOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d5UAFkKdySVnQGy5CCFh/S6Kbo57GrP9VHLEerZoEtK6mqvMTHORo6h0k4icaR+SP3U70ZSAwFIn7blPIiuonD7eMx3cC7ZuiRm6UYBmbIDc0JdJDin97DN1NoMG3rFuxiwd+8xemT+2WUqt8ILmpdSOo0AsgrPeMyOqJdkFovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8nTjcyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8nTjcyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF35F1F000E9;
	Sat, 23 May 2026 07:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779522091;
	bh=3napE1/4FgQLGTa6ESFKDUCJbR+1Yq0/nQJifWEE+WY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A8nTjcyU7AY31yMeYhpt1pXlK2QpyjcdaPnj+oUW6J+w6UGEMPoRphmxk4lpMpO+Y
	 Cx+bxGwS+fxDTc8aNe5iaXYrTRucU2gGEo1CTKsKNuTUOb2IcFv4c5zv17Vg7pdZvY
	 ulESiNuUMypUXVz0BHFtuMO/Tgfw9GTj/2T44dKD98adpdQXPArgMgI3FeHuS0udFJ
	 2vnumv8H3gr3l2IB4oS3Fb4nAQmNjFIuEuzzt6LRUHh7RY4XiptQbVDEcNogzj0BI9
	 6K5yjU3cDcGANp++N6ashXI33fjdrGNMGzz/cqlwNVaemT2oJyZqyywLUCQ/mYQijj
	 p+wN0IeSgPNHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/24] dyndbg: replace classmap list with an
 array-slice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260523-dd-maint-2-v2-16-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-16-b937312aa083@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 07:41:30 +0000
Message-Id: <20260523074130.DF35F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ddebug_attach_module_classes() assumes all classmaps for a given m=
odule are perfectly contiguous, prematurely breaking the loop and causing d=
isjoint classmaps for built-in modules with duplicate names (e.g., "main") =
to be ignored and incorrectly shared.
--

commit 0adb4bd721cea60d2371ac3aa8cc0fb11eab6469
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: replace classmap list with an array-slice

This commit replaces the linked list used to manage classmaps with an
array slice representation. It modifies ddebug_attach_module_classes()
to find a contiguous subrange of classmaps for a module and stores its
start and length, removing the list_head from struct ddebug_class_map.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index d4cce0f4f197d..7f03b331d185b 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -1147,30 +1149,34 @@ static const struct proc_ops proc_fops =3D {
>  	.proc_write =3D ddebug_proc_write
>  };
> =20
> -static void ddebug_attach_module_classes(struct ddebug_table *dt,
> -					 struct ddebug_class_map *classes,
> -					 int num_classes)
> +static void ddebug_attach_module_classes(struct ddebug_table *dt, struct=
 _ddebug_info *di)
>  {
>  	struct ddebug_class_map *cm;
> -	int i, j, ct =3D 0;
> +	int i, nc =3D 0;
> =20
> -	for (cm =3D classes, i =3D 0; i < num_classes; i++, cm++) {
> +	/*
> +	 * Find this module's classmaps in a subrange/wholerange of
> +	 * the builtin/modular classmap vector/section.  Save the start
> +	 * and length of the subrange at its edges.
> +	 */
> +	for (cm =3D di->classes, i =3D 0; i < di->num_classes; i++, cm++) {
> =20
>  		if (!strcmp(cm->mod_name, dt->mod_name)) {
> -
> -			v2pr_info("class[%d]: module:%s base:%d len:%d ty:%d\n", i,
> -				  cm->mod_name, cm->base, cm->length, cm->map_type);
> -
> -			for (j =3D 0; j < cm->length; j++)
> -				v3pr_info(" %d: %d %s\n", j + cm->base, j,
> -					  cm->class_names[j]);
> -
> -			list_add(&cm->link, &dt->maps);
> -			ct++;
> +			if (!nc) {
> +				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d=
\n",
> +					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
> +				dt->classes =3D cm;
> +			}
> +			nc++;
> +		} else if (nc) {
> +			/* end of matching classmaps */
> +			break;

[Severity: High]
Does this logic correctly handle disjoint classmaps for built-in modules
with duplicate names (such as "main")?

Since di->classes is initialized to __start___dyndbg_classes in
dynamic_debug_init() and is never advanced, ddebug_add_module() processes
the classmaps array from the beginning each time.

Because built-in modules with duplicate names are not contiguous in memory,
dynamic_debug_init() creates multiple ddebug_table structures for them.

When the second "main" chunk is processed, wouldn't this search from the
beginning, find the first module's classmaps, and then prematurely exit
the loop here when it reaches the end of that first contiguous block?

Could this cause the second module's actual classmaps to be permanently
ignored, resulting in subsequent duplicate module names incorrectly
using the wrong classmaps for resolution and control?

>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523-dd-maint-2=
-v2-0-b937312aa083@gmail.com?part=3D16
