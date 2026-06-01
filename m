Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FE371880
	for <linux-modules@vger.kernel.org>; Mon,  1 Jun 2026 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316447; cv=none; b=qSKDxEiEkIliADefpBHuLc+H1gytmJ4EJXebS8RbOVxk0spS2htAyvuEyfx6s4TwYfcPfmm5BswpF2k94DBIvE1v8ctwDqNlevRjryK1x9OnPXJHVSIsvZHGxGK1CbvXdrCOkY4ewH4rS7Xw2IruDwznjXwXCkoTCC4DBSLo9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316447; c=relaxed/simple;
	bh=h+2jgYQvTStWdCngbud+3VmpduVkM4DHw0CVRt7gL9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=odqle0yzqaZdBe9/i+UVs7/4gTUnS894772/TDZ8ZI0t5JdbBgAB1ymcmx1659LOBlsR23LVtj7T/kDlqj9WiKZq6N25RKTWxX3D5HLtN8x9K84FFNkbDFr1o9gcgaGWsMHlNgMGWTgrc3+sbKBCW0849moAXNG0Q5pjy35vCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAOu3ts/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAOu3ts/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889961F00893;
	Mon,  1 Jun 2026 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780316445;
	bh=yr602zP+a84lq9vwBywD0yEALkBYNTGbkNwAfpRp2ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DAOu3ts/9+LyLN20/KyLWdgeL4keVeN4Dhu6D4FerxE/UVuhdMFSPi6O7D2lUEfzV
	 1+s5FsU4vcuTrmB8lVBd7+b+7XUX2RRp6oGTOkEYlyOqboZEagpUQi6uxxBr16NO7o
	 ucMHcDrr4uX9hs4+7K69W9GKF2KARxv6Ib6TfHbtTyYEW9mRoYlvd3h+vKyFWP3C7Q
	 jiiIrVwbopgJbIaKouwCul4ThN6SgDfZrlgKHyLFSzQXCEZWQ4GcahQUruZ3+gM9QO
	 9uaPgW7zMSTiGQcwZK2OiEFTnkryLajHUC+QZNS70FWXa/pvWg3u0FrizNDQdoONdG
	 /CFnXZCZ9Betg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/24] dyndbg: Upgrade class param storage to u64 for
 64-bit classmaps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260601-dd-maint-2-v3-18-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-18-4a15b241bd3c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 12:20:45 +0000
Message-Id: <20260601122045.889961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch causes a compilation failure by instantiating an undeclar=
ed type `struct _ddebug_class_param` for `drm_debug_bitmap`.
--

commit 907ab9c053461a5ca389ec9e173d54aa04b245d4
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: Upgrade class param storage to u64 for 64-bit classmaps

This patch upgrades the internal storage types in the dynamic debug class
parameter structures to u64 to fully support 64-bit debug categories. It
updates the internal storage elements and the relevant dynamic debug sysfs
input parsers to use the 64-bit types.

> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index ded9461df5f25..9b4d8e3baacc0 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
[ ... ]
> @@ -69,7 +69,7 @@ DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYP=
E_DISJOINT_BITS, 0,
>  			"DRM_UT_DP",
>  			"DRM_UT_DRMRES");
> =20
> -static struct ddebug_class_param drm_debug_bitmap =3D {
> +static struct _ddebug_class_param drm_debug_bitmap =3D {

[Severity: Low]
Does this cause a build failure when CONFIG_DRM_USE_DYNAMIC_DEBUG is enable=
d?

The struct is still defined as ddebug_class_param in
include/linux/dynamic_debug.h at this point in the commit history.
Instantiating the undeclared _ddebug_class_param type for drm_debug_bitmap
breaks bisectability for this patch.

I see this issue is fixed later in the patch series in commit
97c08d5dc7f7ec501676f73addba8ad9f6c67352, but it might be worth correcting
here to keep the tree building at every step.

>  	.bits =3D &__drm_debug,
>  	.flags =3D "p",
>  	.map =3D &drm_debug_classes,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-dd-maint-2=
-v3-0-4a15b241bd3c@gmail.com?part=3D18
