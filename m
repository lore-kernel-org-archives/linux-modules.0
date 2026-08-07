Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0A282F3A
	for <linux-modules@vger.kernel.org>; Fri,  7 Aug 2026 01:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066659; cv=none; b=mlzcSXtls4ggeOn7Bz28u7Wl8F1DY4JKGtf1S4sfCvVUDZV3qXE5KJJUquFa1gPTzTi+hbW1ADmeUUMO9fNYfOsgH/pR1fkoWU2ZaeK08E3b06nOZGGPme33VbAX//I5xYBlsHTlM/r/TLac1sptwsZS3Oikk+sFIqz1NALDKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066659; c=relaxed/simple;
	bh=Ky40BFjS37i1yJ3xxBZ/TnvRelFsTlojVn8ZVGQgjC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lVO+ybRf+4xiX+2/mnEjDYAYdLDKNsCLurPiy2zmfG/ls2XjR6MloF0TQaiWoDu7BgHNfxehgtHikSR0rDGFpTczQzK4e7q1HjxVTbJKprKErxkhnt5nZ+3kWLjzasA4hpmbzHa8XILyDz3Vd8QenEpVOq2e3oc0J3VjR18K/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yup8zWpp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yup8zWpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2BF1F000E9;
	Fri,  7 Aug 2026 01:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786066650;
	bh=IYMuRIdxIhcINuVQNFlMKQDQX3vFryl6YNM6ASDl+C0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yup8zWppM3sESqBFpba7OFLlwXi7saLRxdWc+XCkQEuuPTkfGSC90Nznvdl57xpDA
	 6Ufh86jm4tgAzsGPSyP0Dupb7CBoQjJ7vtnn9FR1Y5Vm69pSKh9WyGFdDYhqjG+2gM
	 MPe/tNs3Wn7DoZILc2QQ8qv/DZmsaFXGpyn7S59R98yKCRn9J6A09vl44C2E+QmgCV
	 s5Od+zepr+ZJv0TfJb2TFe/fe1mSR9P/oNXy619AlCnDnzkAHAL0iFsYFf0oCFpegC
	 p5ZzaL+H7m90gV87/0/UaW329d9eMumuT4DhwBJTrmA2w4ViDodmo9A6Wsi9Woea1h
	 5yJRlKm5jN8OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/2] module: Rename module_blacklist to
 module_denylist
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260807012601.360452-3-atomlin@atomlin.com>
References: <20260807012601.360452-1-atomlin@atomlin.com>
 <20260807012601.360452-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 01:37:29 +0000
Message-Id: <20260807013730.3A2BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The comment preceding the module_is_denylisted() call was not updat=
ed to reflect the new terminology.
--

--- Patch [2]: [PATCH v9 2/2] module: Rename module_blacklist to module_den=
ylist ---
commit ac79bb8334a6a0d6e2353ff853444d535ab50178
Author: Aaron Tomlin <atomlin@atomlin.com>

module: Rename module_blacklist to module_denylist

This commit renames the kernel parameter and internal symbols from "blackli=
st"
to "denylist" while keeping the old parameter as a deprecated alias. Log
messages and documentation are also updated to reflect the new terminology.

[ ... ]

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index a9fd6aaedc69c..1a58313649d94 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3381,8 +3381,8 @@ static int early_mod_check(struct load_info *info, =
int flags)
>  	 * Now that we know we have the correct module name, check
>  	 * if it's blacklisted.

[Severity: Low]
This isn't a bug, but should this comment also be updated to say "denyliste=
d"
to match the rest of the terminology changes in this patch?

>  	 */
> -	if (module_is_blacklisted(info->name)) {
> -		pr_err("Module %s is blacklisted\n", info->name);
> +	if (module_is_denylisted(info->name)) {
> +		pr_err("Module %s is denylisted\n", info->name);
>  		return -EPERM;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807012601.3604=
52-1-atomlin@atomlin.com?part=3D2
