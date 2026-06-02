Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E03C873B
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441304; cv=none; b=hR2KT/lprrdIhN+2pn+4uNrqB8GRjR6wIU1qaqjAfPQ1GXi91Osekv201PqZj3cuTEuwE9vtQv8eOPirkWTyNLwlJlRBfnqm+AzsPEjDqK/EBXTUuWO2Jt9M/ZV+YM6azTtFP7uwfkL+KN4Y5aQUIuPT3awlsO2603vMM7m3EZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441304; c=relaxed/simple;
	bh=tPamSdrh/VvjyM4Gt79GW+DG98ap4fRd2SgFRWC013Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uEcX+ShBkyBSVWgFLx2uyLAXNO3XZ5Nwn0G4v4z+ApLJIen2i2bCP0H33cPiI6jClrtLcjtcnDUEmk4UrVGWEU3kmjuo/dHaAN2gLlP9eGwiEgpYqr3ptrpZjDYHmLKghfgJsfJBwGSqry9cLSKKHjHjoRs/UMtzBwgbdIHiXBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd9Dde4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd9Dde4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877811F00893;
	Tue,  2 Jun 2026 23:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780441302;
	bh=rMZEKyDmOKtih4pg1q2SNt3j6DEr9Eaj0B+vNJPgOEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vd9Dde4L8I1jk47k7pogugXiF6d+pAMk9NrBw5QY0cX8H9/B8qVfEMvOFYUksPeH3
	 04IWo3L/b8qsfovJy+iMcM2Y7j09xWO3VQnuZ5p6fF4BohAgrAC0sYJYcnWIMX9Drm
	 V7eu+L/F1oIpgkLrF94Je9p2xZ9U4h+TMxdQkmznVIdS+73gQdhuOxOYrOb8ss0ASP
	 jmpGrQLJ17zKtUBipN2zIeu5CFk7thAyNNOCKgfnT9vtVzQqq2RebitTmm/CEbVCDJ
	 sgTnanaZlca59rjikKFbPYTzdSimcJXJ3HS4vBvAmOEpxd8iXxKt89ZLtdYB4YoY2L
	 1xLdrjnUflcVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/25] dyndbg: replace classmap list with an
 array-slice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260602-dd-maint-2-v4-16-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-16-19a1445585a8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 23:01:42 +0000
Message-Id: <20260602230142.877811F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ddebug_attach_module_classes() incorrectly assigns the first match=
ing classmap subrange to all non-contiguous descriptor blocks of identicall=
y-named built-in modules, permanently dropping subsequent classmap subrange=
s.
--

commit 6fb00fe7f4da26525b10dfd1edfb384c35a9b281
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: replace classmap list with an array-slice

This commit replaces the list-based storage of dyndbg classmaps with contig=
uous
array-slices. It simplifies classmap attachment by dropping list constructi=
on
and reusing the module name filter to find subranges.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 9bd521651c484..b8a494835ef58 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -1150,30 +1152,34 @@ static const struct proc_ops proc_fops =3D {
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
>  		}

[Severity: High]
Does this break prematurely for identically-named built-in modules?

Because KBUILD_MODNAME currently allows multiple built-in modules to have t=
he
same name (e.g., "main"), these modules can have non-contiguous descriptor =
and
classmap blocks in the ELF section.

When ddebug_attach_module_classes() is called for a second "main" module,
it scans from the beginning of di->classes, finds the first "main" module's
classmaps, and immediately breaks upon the first non-match.

Will this cause the second module's actual classmaps to be permanently disc=
arded,
assigning it the wrong classmap subrange instead?

Note: I saw this issue is resolved later in the series by commit
3e924d4e19d326f9d0f87715e82bd2970e66e217 ("dynamic_debug: use KBUILD_MODFILE
for unique builtin module names"), which prevents identically-named built-in
modules by using unique file paths.

>  	}
> -	if (ct)
> -		vpr_info("module:%s attached %d classes\n", dt->mod_name, ct);
> +	if (nc) {
> +		dt->num_classes =3D nc;
> +		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-dd-maint-2=
-v4-0-19a1445585a8@gmail.com?part=3D16
