Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3955E2931C0
	for <linux-modules@vger.kernel.org>; Wed,  9 Sep 2026 01:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788916203; cv=none; b=rofwa/qyUSyaYHYqJNO5jUdl5XAWVBy2VpAgiK2VfHXQV1lTbbpKjqO2mhHjWRBB0K8xo3G0spAw6ntBA/tDIYGMfUeWie23C7f9hjBpecaB52GmLdGp2SJFYjzhH5NSKc7lTtUlIRHO5YdI5sXIoZIS2CQC+BjWwdkW6EeIb7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788916203; c=relaxed/simple;
	bh=DZ5ih6yyTe4HeZDXL5D8F4WIEbeLIg4TVBSpLlcHIWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PrRAmH2IyUqoudQ29iathGqOppSCcyu4EXZDPZB+ZoMzLiovjelZ/gCUJZyScigqC4K4umHF3GlY+a+0/rDXLOu7K9Is322KKB5dTIqTF0V+FueAfmfSq/exyI8b8KgYCO2Szyfdd0Ted+KPt7YP9Eg2ei3M6Yl7zdbPFxj16S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBt/91HD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBt/91HD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFAA1F00A3A;
	Wed,  9 Sep 2026 01:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788916201;
	bh=NKsw/DD5o2qV5RvFgW6LmX+4CKTjelFvDtWQuz14AQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nBt/91HDF7+KwLMj2NN8ZWnY8j9x8ghxfdiVcjRbQHRQp6ld0UPIXxsbE/tIcqLaN
	 TNFU09PsJ0n/DYDgR6YvpbHLYRjIvwODPmE41w1xNGr7G8IjqQ/404Zk4A437+fR00
	 cw0Xy4wTskHKT6UiSuoiF2sBforNMX957/NRDSMdvMauQ5jMyHN7ZBEalZ7C9ElFvG
	 DocC5ehHoLHJxmKrYBfoircC+XhNbrlUrB8JvwT7R/Z/6WFawPpMvy4ARetLMzRkDO
	 bNb4oXCrVIVVMSVIpvbCRyu5HJiButcUkkjBA8XJnXNcvu7HG4rhmw5RO+9K+FOare
	 YJG99EWd3ziRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/39] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-8-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-8-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:10:01 +0000
Message-Id: <20260909011001.AAFAA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Moving DECLARE_DYNDBG_CLASSMAP into the CONFIG_DYNAMIC_DEBUG block =
causes a build failure in DRM when CONFIG_DYNAMIC_DEBUG is disabled but CON=
FIG_DYNAMIC_DEBUG_CORE is enabled.
--

commit 0230d1a17999838bd74e9c3bf428293b96fde5ce
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP

This patch adds a stub macro for DECLARE_DYNDBG_CLASSMAP for !DYNAMIC_DEBUG
builds. It moves the original macro definition under the ifdef block to
provide a cleaner starting point for future changes.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 05743900a1169..a10adac8e8f00 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h

[ ... ]

> @@ -314,6 +314,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
> =20
>  #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
>  #define DYNAMIC_DEBUG_BRANCH(descriptor) false
> +#define DECLARE_DYNDBG_CLASSMAP(...)

[Severity: Low]
Does this empty stub cause a build failure in DRM when compiling with
CONFIG_DYNAMIC_DEBUG=3Dn, CONFIG_DYNAMIC_DEBUG_CORE=3Dy, and
CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy?

Because DYNAMIC_DEBUG_MODULE is missing for drm_print.c in this configurati=
on,
the stub macro is used. This causes drm_debug_classes to be undeclared when
drm_debug_bitmap() attempts to reference it:

drivers/gpu/drm/drm_print.c:drm_debug_bitmap() {
    ...
    .map =3D &drm_debug_classes,
    ...
}

Could this empty stub be updated to properly declare the struct pointer even
when the debug features are disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D8
