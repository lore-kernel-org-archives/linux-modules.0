Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CCE38B12F
	for <linux-modules@vger.kernel.org>; Sat,  5 Sep 2026 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632719; cv=none; b=diznTcymow26eRjshYojZNRgCN0vl4opMTG/jlwaRBeUNi9c9OlKKwfd7P35Iq6aN6o9ngxLq2xmIBCAZMjttutrOJXVw5T/Ldpe6ijV4xh6LhO6x/8wvrsY66bB3BFwmstflvtuaj0HATuCKzEM7HB44ax914PNHkCKpj5/vl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632719; c=relaxed/simple;
	bh=cfnEvP7dPhq8MQoXn60J5eBRFLUJbUehHLgJpJJIxJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BjRdpUfrpsrOQHmEcQAuUoP+AuURDlg3EKcPv3K0GSlJCzseksae4yg4R7uL6XtAQ1xzLKzddhcqE5MeTIwqthM6qtOtQXfDtp1xPvyqmuFT/mRqOjEzFUMWudS/1j168ER84b7C/WyEkd3VXiRIyMJS7t2MwHVllcqSKr+Dqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkGUlqHy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkGUlqHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F51E1F00A3A;
	Sat,  5 Sep 2026 18:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788632718;
	bh=+TR+XKvZ2RbPZzBMQi/0LwyDXu6MQIV/uFxbwZpLVJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FkGUlqHyMUiMjaiN8Vr2YAfD4MY6j1fixvDvFgSevOsZCFB8f5Bf1WL2J8YuEImVh
	 /VPdOw55+6T6DwulffJsVN5sJwsSQKmXbwG3CCtgVrkgJp+uJl/t5R+TFNKNGQ3P2U
	 gGQEYdh9G/9or20SuHI2R6MysatQLPd44XfIrjWzhM6TC2UdEWVVbJa49RlBqBy2/6
	 NkAD0xp2P3Q+98/Gns/1f7J17q9U3rRGRpRxuqZc9Z218oujzZqC9n0FEi3ONGbAeI
	 Cdzi78PiM3ucP89emiDRCBLXEdzmyW1QACqHt7OmJqOBsllc0w+IdoxYPQ/hSGvvTw
	 fO/OrAJ1wCr/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 21/43] dyndbg: replace classmap list with an
 array-slice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-21-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-21-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:25:17 +0000
Message-Id: <20260905182518.1F51E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The array-slice logic incorrectly assigns the first contiguous b=
lock of classmaps to all disjoint instances of a split built-in module, sil=
ently ignoring subsequent classmap blocks.
--

commit 83893b53c8dd08c74af1a0d4c13885f9854d8f97
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: replace classmap list with an array-slice

This commit replaces the linked list used to track a module's classmaps
with a contiguous array-slice approach. It updates
ddebug_attach_module_classes() to find the start and end of a module's
classmaps within the compiled section based on contiguous packing and
module name.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index e0e3cadd82bd9..470314e4810eb 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -1153,30 +1155,34 @@ static const struct proc_ops proc_fops =3D {
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
>  	}

[Severity: Medium]
When there are disjoint built-in modules sharing the same name (due to Kbui=
ld
naming collisions), dynamic_debug_init() creates a separate ddebug_table for
each disjoint block of descriptors.

Does this logic incorrectly assign the first contiguous block of classmaps
to all disjoint instances of a split built-in module?

Since this loop always starts scanning from the beginning of di->classes and
breaks on the first mismatch after a match, it seems subsequent calls for t=
he
same module name will redundantly receive the exact same first block of
classmaps.

Could this permanently orphan the actual classmaps belonging to the subsequ=
ent
blocks, potentially leading to unknown class_id warnings or broken pr_debug
class filtering?

> -	if (ct)
> -		vpr_info("module:%s attached %d classes\n", dt->mod_name, ct);
> +	if (nc) {
> +		dt->num_classes =3D nc;
> +		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D21
