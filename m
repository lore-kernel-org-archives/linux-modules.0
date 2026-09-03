Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB533E0754
	for <linux-modules@vger.kernel.org>; Thu,  3 Sep 2026 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462469; cv=none; b=KVoGYh2YSW4fKdos9FNh5B1NdnZMq4lMmcuaBwS73mKi+padSjbVCsDMEul5nv74i0n6x49ydDBgoJM0q61sQRnffwL6w6lryIMRoqqVpW0UyeEpzoJa43js48VseSspLSSjro4502DOp37PlYmZhaVSQJfQTsdVaZ4xR3lYo4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462469; c=relaxed/simple;
	bh=9kAgrOlAJRu/M+wtXOoFK3u0Co3pP9E+9/A5vjVK6tE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z+tBJTdrbIoTI2riJWW5ZixB9oBg4lketyZLH10rvNpQapV6zywzxCvlcdKgJpVjPtMpqh9+cMNxFXzqaHhAuE+yaUy6L85wFP3dJouLi6w8ogG4c8N4NYn9jOfScVJP03lo1J2AhAanHyU1CKEUIF+lcRGVKE/dxJl4iFp1DR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFW6BFzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFW6BFzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B051F000E9;
	Thu,  3 Sep 2026 19:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788462455;
	bh=cnxJtWl1/X4rgzO/Z5Mq+2hUmHtQf8oKnqH+zu6UP2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aFW6BFzZ6mX9NJHAPBdr3QUIGfMS1Q9VT2r/s+fpVnM/CcRgzMQ1q+QX0KLFFrElQ
	 wIXmmCo8ulqMGTnUV40isHEz8xT1NYbVDMt6AqQZ6s9kBCEMSqvJD7dr3OJnS0Kruo
	 1qFIdGP6v7gobfo21OtSxjPkmmTBOxoZurQbPjfjXF07C2maK3uyUAwWgQGDFUuFDY
	 kj2Sa8I+0PVNm/IEA20P0HjHGXBVRjgmIEEjy55pvQ2yEQYhYTKIb23yoJ4aU5Q1lB
	 DmEypd4+5uLVA7bo8q00Dlrey6pyaaOAGM9a5onWaRQDddXuTx1lvnmal9KSbderQO
	 Tpu2aR1o5dEFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/2] module: Rename module_blacklist to
 module_denylist
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: ojeda@kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260903185557.183224-3-atomlin@atomlin.com>
References: <20260903185557.183224-1-atomlin@atomlin.com>
 <20260903185557.183224-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 19:07:35 +0000
Message-Id: <20260903190735.82B051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] module_is_denylisted() uses exact memory comparison (memcmp) inste=
ad of treating dashes and underscores interchangeably, breaking denylisting=
 for module names with dashes.
--

commit 2df01653b8cde06423a15fc161d3df5e8eddbdba
Author: Aaron Tomlin <atomlin@atomlin.com>

module: Rename module_blacklist to module_denylist

This patch renames the module_blacklist boot parameter and internal
variables to module_denylist, keeping the old parameter as a deprecated
legacy alias. Internal symbols and log messages are also updated to
reflect the new nomenclature.

> diff --git a/init/main.c b/init/main.c
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1347,17 +1347,17 @@ static inline void do_trace_initcall_level(const =
char *level)
[ ... ]
> -bool __init_or_module module_is_blacklisted(const char *module_name)
> +bool __init_or_module module_is_denylisted(const char *module_name)
>  {
>  	const char *p;
>  	size_t len;
> =20
> -	if (!module_blacklist)
> +	if (!module_denylist)
>  		return false;
> =20
> -	for (p =3D module_blacklist; *p; p +=3D len) {
> +	for (p =3D module_denylist; *p; p +=3D len) {
>  		len =3D strcspn(p, ",");
>  		if (strlen(module_name) =3D=3D len && !memcmp(module_name, p, len))
>  			return true;

[Severity: High]
This isn't a bug introduced by this patch, but it appears the renamed
module_is_denylisted() function retains a pre-existing logic issue.

Does the exact memory comparison here break denylisting for module names
containing hyphens?

Since the kernel build system converts module names to use underscores
internally (e.g. "my_module"), if an administrator passes a module name
with a hyphen on the command line (like "module_denylist=3Dmy-module"),
the strict memcmp() will fail to match the hyphen to the underscore.

This would allow an explicitly denylisted module to load, which could
defeat the administrative mitigation for buggy or malicious modules.
Is there a string comparison utility we should use here instead to treat
hyphens and underscores interchangeably?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903185557.1832=
24-1-atomlin@atomlin.com?part=3D2
