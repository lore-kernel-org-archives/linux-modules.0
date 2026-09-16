Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F33383980
	for <linux-modules@vger.kernel.org>; Wed, 16 Sep 2026 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574423; cv=none; b=Y+WSYR4ZFldkw2Ji1BnpVtMyKLUrlFHct0hylB/zjP0jZUn6lOd7Zf65vmk4kXdCsuG744RGZznVcm/nNBgccfsCmbB4UqBIjGjoDlHLVDgXp2YzBLIOat3I5UCpyti5/rNGvKn8sCBmutsz8p5fcXlQy1/b6vju0BXy9BzYFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574423; c=relaxed/simple;
	bh=GL4yYEEx2VvfxjruLnOvMDZnvF/RE3pTEIbyfW9ZC8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pqd9NEu4VSkM7OEOIlKCNi52UTYmD50unlHUCdcRzJMajxYVVecDEUL6fYVFg5uvK4icCYRhu9bbf4ORDIOlSD6tBvI4n/iKWaNpADHPSkFmnRCWUajCog/yKZy8NHDCJD/srwtBcSuSD/mC8ZWo4bM0zO5dhBZ4BliuUAz/Uxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhLTUF0G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhLTUF0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5F61F000FF;
	Wed, 16 Sep 2026 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574419;
	bh=Ydnkobt8d1OCf8cXm89W4LuryFwjkgPXjx+lVfR3s2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nhLTUF0GKLG3sdLsGv0C1xREJldQB8F2H4M6x9pqtTUCx2kz1NuRUqYs7iEOYLce1
	 2LDeccW2OBfRq3S4u22ekSpQkwsP8j+thsEk861BLVSy9V26C8LlxiRDApzaWtAmJc
	 dCvrj1rPLipP586fyis/aN3SQVrhsmje5B9gE3hS/LKZLkdBcmazy33eYb36d3+wOv
	 ic5FdX89scN99n3DzI61yTPsAuuaOljKa9922rcEx1cYlLlEjnZZ4CUCn7hAIIWkFG
	 viW975E9LrP9HF1nikgAAAJA2XWgd+IH2m3nF9Jtd1R/PXGR1HQdOjHshr+CIOg66z
	 07ZLfCvz9wTxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/38] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-8-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-8-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:00:18 +0000
Message-Id: <20260916160018.DC5F61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm: compilation failure due to DECLARE_DYNDBG_CLASSMAP stub
--

commit 96b109d4ffa1bfc809c49d548861d8dd8aa48aaf
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP

This commit moves the DECLARE_DYNDBG_CLASSMAP macro definition inside the
DYNAMIC_DEBUG ifdef block. It also adds an empty stub macro for builds
without dynamic debug enabled to provide a cleaner starting point for
future changes.

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
Does this empty stub lead to a compilation failure in the DRM subsystem?

In drivers/gpu/drm/Makefile, CFLAGS is used but ignored by Kbuild for
subdirectories, meaning DYNAMIC_DEBUG_MODULE is never actually defined
for the DRM subsystem. Before this patch, DECLARE_DYNDBG_CLASSMAP was
defined unconditionally, which masked the Kbuild typo.

When CONFIG_DYNAMIC_DEBUG=3Dn, CONFIG_DYNAMIC_DEBUG_CORE=3Dy, and
CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy, this empty stub is used because
DYNAMIC_DEBUG_MODULE is undefined. This causes DECLARE_DYNDBG_CLASSMAP
to expand to nothing.

As a result, drm_print.c attempts to reference the undeclared
drm_debug_classes variable, causing a build regression:

drivers/gpu/drm/drm_print.c:drm_debug_bitmap() {
    ...
    .map =3D &drm_debug_classes,
    ...
}

Would it be possible to handle the stub expansion differently or update
the DRM Makefile to use ccflags-y instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D8
