Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2E43A7FF
	for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203680; cv=none; b=j6cseh+ODmzDwSq5DPGUil7zqC8P1Mj5fTmkhnC/WxpL/4TeFY5LpxyWkNdJ/rCMu0rv8ntmbcW00v2hen9bmhxhnmeZ3kj+OQY7VgAJEljeTZzYEBmatrho24KTJ87f/tWq373vafDBck+urS7mN2bJJauyUCDJfVtVLrBmcsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203680; c=relaxed/simple;
	bh=PfYdJH3vnfpjlWMYlGm97I9op2OsQKPzXZX6N8oJH8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=itIGxUYEkKdkLReNKC62BU2kFI1N/PFXJfWD8H3XdqE+WNT2fpFZkxr/sdEICx1ghlG1Zgxq4b/Xo9rDzulhHzmi6jVS26b0PsCSeLRdPxDjuBOlKUoFDxZqrpwUWuyFEV1uB0cY9kkxm+NtN20Ycy3bvzCQ7GP3piWSWGT3Fus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzM+XDE5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzM+XDE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDB11F000FF;
	Wed, 23 Sep 2026 22:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203678;
	bh=aiefSjdeEoopnq//Y4ByOxpgvdN6hsTmkRuDe5tsSXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AzM+XDE53mOxdg5n8+7T4rh6Hc/zzAFGyI+e7oorEALPmnjelZNQmc4B85VgOkjc3
	 QpWitdfhB+tnrFZfw+IF9WYplX8IRB7CUqU8xMRRjvo46/mOrO3J9SYhJ5svR3pzG4
	 PVRu7GOmZyeAzUTkkV/VAX+PNzVZgYUsoEVQIbDx1jt7Uuf/oCdX8AT19RM2jSXHCE
	 +Ahy8ZYZrDW/K3XCCSiKaDmVegXIcDm4U2D130dpnOlo1KzrIoMOjWj0EJy1LwC+em
	 a+rEIp8JHUHjWVtSb8vC8kXbywp5bbhba9Y3vrQ0VBaAoiXa4jywAWv6hiNiBv6Qu9
	 lFtiLlQWij3aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 17/38] dyndbg: replace classmap list with an
 array-slice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-17-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-17-9b6c217fdf2f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:47:58 +0000
Message-Id: <20260923224758.ABDB11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dyndbg: interleaved classmaps are orphaned due to contiguous sli=
ce assumption
--

commit 8936e7007afda568cebc34aa496a40887ac6a5a1
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: replace classmap list with an array-slice

Classmaps are currently individually list-linked onto dyndbg's per-module
ddebug_table for operation. This commit replaces the list building operation
with an approach that treats packed classmaps as an array-start-address and
array-length, reusing the select-by-modname condition to find the bounds.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

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

[Severity: Medium]
Since the scan in ddebug_attach_module_classes() always restarts at index 0,
could this cause regressions if multiple descriptor tables exist for the
same interleaved module? When distinct compiled objects share the same
KBUILD_MODNAME, it seems they might all incorrectly bind to the first block
instead of finding their respective fragments.

> =20
>  		if (!strcmp(cm->mod_name, dt->mod_name)) {

[ ... ]

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
>  	}

[Severity: Medium]
Does this premature break in ddebug_attach_module_classes() enforce an
assumption that classmaps are strictly contiguous?

If classmaps for a module are interleaved, breaking early means only the
first contiguous block is bound. Subsequent classmap fragments might be
permanently orphaned, leaving class'd pr_debug calls in those fragments
uncontrolled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-pa=
rt2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D17
