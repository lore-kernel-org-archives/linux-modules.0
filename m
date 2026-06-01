Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E18340411
	for <linux-modules@vger.kernel.org>; Mon,  1 Jun 2026 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316894; cv=none; b=h8P1PFMJp0XfICXxZFDjlGU1Zg+RcI7UVpiNDDSmifNUJZ/Not0Ugrvl4YvLnfJCgXDEzmNQ8bOFCzoFFlb2ErBVST8XtTW3n7EWiM8nKZ9f7jKyg+KR4bzIzU+WSGD4E96MPFesmSVtRJy4Vk7TIHFMk+kFqHADjpfe3G+Fbk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316894; c=relaxed/simple;
	bh=8T01rYmuA6AzXVO6T8h9isSdhkwxG+kxH/XgtNAfb8A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NJUdSwHSegiw+QBgqQcxeXbBNEOxDYgGqkKI3hzE95ySU/+NKEBT+3R96kCUUdgZISnwYulUF5seg1VUjqCejvxtvHqzVcAx7EOn8edAk88O1/2bMX6qDQvPQSXNKhWuxbNT1OKRAGOx0IC2oVn4+LSTPBSsxc4KRJ6cze71OTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSckYQyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSckYQyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F641F00893;
	Mon,  1 Jun 2026 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780316893;
	bh=izZB7CRgH44OMdrdgj4kDlj13evBSUadJkwcCCtXbT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mSckYQyIFZA8J06zwH1GU9/iJ0JWRh1EC75EoEnUUjcs/2zaLfbEEU8RoiZspiSdF
	 VcILT1rm5zZsLyk0Jn12GMbfChRwn0vnDyIWIuFFvfd+z5DjYghausAnGr+rkMRqkF
	 uB4fuCGztipIThjVtJhnP8i71mw5U9IhCR6GGLxObPishkB3KQhZMsFemtzxQGwELk
	 Ei+pBA8gLfbRWCTGkKvnVOtpb1FyNAM6mnRW2IDQve1J4f3NFWGfGQUOghqxRkYaXi
	 vf9/5/smm1Eue4Jd4yDh2dEMi1xuavopuOkWIjZPuKLbP4DDt/GYd+dHWcTrAb9hAJ
	 6thFrRWbIa7Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 24/24] dynamic_debug: use KBUILD_MODFILE for unique
 builtin module names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260601-dd-maint-2-v3-24-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-24-4a15b241bd3c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 12:28:12 +0000
Message-Id: <20260601122812.D4F641F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] User queries and boot parameters for built-in modules with hyphens=
 in their names will silently fail because KBUILD_MODFILE retains hyphens, =
unlike KBUILD_MODNAME.
--

commit 5657a3b8ff6d75b1ecf79e0009e73fb62384f27d
Author: Jim Cromie <jim.cromie@gmail.com>

dynamic_debug: use KBUILD_MODFILE for unique builtin module names

This commit changes the module name used by dynamic debug for built-in
modules from KBUILD_MODNAME to KBUILD_MODFILE. This provides unique names
for built-in modules that might otherwise just be called "main".

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 2d6983186f37d..aee6f3d0916f4 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -8,6 +8,17 @@
> =20
>  #include <linux/build_bug.h>
> =20
> +/*
> + * Pick the best name for the module:
> + * KBUILD_MODFILE includes the path (e.g., drivers/usb/core/usbcore) for=
 built-ins.
> + * Fall back to KBUILD_MODNAME for modules (loader requires unique names=
).
> + */
> +#ifdef KBUILD_MODFILE
> +# define DDEBUG_MODNAME KBUILD_MODFILE
> +#else
> +# define DDEBUG_MODNAME KBUILD_MODNAME
> +#endif

[ ... ]

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index fdb730db385e8..7f78c6b3eeaf7 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -248,7 +248,8 @@ static int ddebug_change(const struct ddebug_query *q=
uery,
> =20
>  		/* match against the module name */
>  		if (query->module &&
> -		    !match_wildcard(query->module, di->mod_name))
> +		    !match_wildcard(query->module, di->mod_name) &&
> +		    !match_wildcard(query->module, kbasename(di->mod_name)))
>  			continue;

[Severity: High]
Since KBUILD_MODFILE retains hyphens (unlike KBUILD_MODNAME, which is
sanitized by the build system to convert hyphens to underscores), will user
queries and boot parameters using underscores fail to match?

For example, if a user passes a boot parameter like snd_hda_intel.dyndbg=3D=
+p,
query->module will use underscores.

Because match_wildcard() performs exact character matching without translat=
ing
hyphens, will this silently break dynamic debug configuration for built-in
modules with hyphens in their file names?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-dd-maint-2=
-v3-0-4a15b241bd3c@gmail.com?part=3D24
