Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383883CAA30
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441260; cv=none; b=BMty0FQigp04X7MMo4UppHNcE5797s9rp4EgHMIxAobhr7BaKqTKBOHIh54PMsTJx2RNrsH7NDhSOGXgNH5RkG4ogPe31pVdydWMBSe0yKMIv6smJ72bGHO6Hq2ppfFp+cE62BksR1it32VfyfxeL1u+GTCyhqoNwTRjTH8HIUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441260; c=relaxed/simple;
	bh=oPwOBjPsk20fae8U3Xw7YEh2GC4WqL1e+w5HUN/pjD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hJS955sGQn5IuP0porPHvY1xmkdbKJLpOyrJI7Qqj+9UZOX8r5TJv16xuThGlnrXgiBuvvOA7pMgg7bdWozS1ltOa0e+fZ0SFytHMbmbAZOA/gsVT74nGGTsyAtoYfnvS3+6SSsXKlE4JuJQpfDNKpncLSqYqI3Qjr8QqqLYWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnpk895g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnpk895g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFE71F00893;
	Tue,  2 Jun 2026 23:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780441258;
	bh=7YGvQNea+t04x21an5pSdpy6weF8qmqTDSffkqVLIxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dnpk895gua/ZKP9wBkR7veuN9GnvHD9NkzQkAArHDzgSt06Nr/SmUJdTixKNB6+04
	 KswfnS1mTt1mqlIXSnR+MV3xDWW4nlF8Usfv5TzffTmS21CBFKuL4TL8iOalPh1iNe
	 lCEp/YrAcorYB6LQbZwZuVC8Me359vdOBOMDTNLwyqomwJ1VvsLZV7iHbiuJanvRCJ
	 m0EYhZo0x7OxN3ZJxuwm+XSyDQa7Tkz8QOGSoDaOf9zLxg5k9/czfom+GUG72TjOSx
	 QGg0AJkNRW3e1aJQUCE3TOhe8dGI24g4HPN1gmX5ZvZoHGfeZr1Ddha9fAgwl9wKyS
	 ZgPrUPAbmEd7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/25] dyndbg-API: remove
 DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260602-dd-maint-2-v4-11-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-11-19a1445585a8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 23:00:58 +0000
Message-Id: <20260602230058.ABFE71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Kernel-doc for DECLARE_DYNDBG_CLASSMAP incorrectly references `stru=
ct _ddebug_class_map`.
--

commit 047a6407ea6feae6857cc7d6870594191a931c7d
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code

This commit removes the unused DD_CLASS_TYPE_DISJOINT_NAMES and
DD_CLASS_TYPE_LEVEL_NAMES classmap types to simplify the dynamic debug API.
It also renames enum class_map_type to enum ddebug_class_map_type.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h

[ ... ]

> @@ -119,8 +108,8 @@ struct ddebug_class_param {
> =20
>  /**
>   * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
> - * @_var:   a struct ddebug_class_map, passed to module_param_cb
> - * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
> + * @_var:   a struct _ddebug_class_map, passed to module_param_cb

[Severity: Low]
This isn't a bug, but is this change to struct _ddebug_class_map intentiona=
l?
The DECLARE_DYNDBG_CLASSMAP macro instantiates a struct ddebug_class_map
without the leading underscore, so this appears to be a typo introduced in
the kernel-doc comment.

> + * @_maptype: enum ddebug_class_map_type, chooses bits/verbose
>   * @_base:  offset of 1st class-name. splits .class_id space
>   * @classes: class-names used to control class'd prdbgs
>   */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-dd-maint-2=
-v4-0-19a1445585a8@gmail.com?part=3D11
