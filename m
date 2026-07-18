Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626035E92F
	for <linux-modules@vger.kernel.org>; Sat, 18 Jul 2026 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784401901; cv=none; b=kO71i3mpPVEQWDm9SYMfH2qpKv1PaFHXYtssQNH4QJ4UJxLnPyR7Y6WkbSI9miO1AVUl++z75yA9vVPVwvjY9gpPFbrpafoQhSiabqkJZRIFUD/5jnxD5vb6m+iFWYSmiN4Di049JB17/D+GTSXh/biLgBbTZoKDh2oM9yrpNx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784401901; c=relaxed/simple;
	bh=64JzB7eM/zdusjg+8SnZA2FpQCN2HAUKk/wO3CqQZBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MWE07ob6+wwmpQb237jjeEN8vuUxdEk0NzYE9tA23ptIvNtKFHp/zXQgvDMiJBb4k4gB1qbyOjgvf+6nbMF2tPLFLdhanKtBB74S2fYXOshhJyfpPHCItLQfDOZ0axH4IGnsdRrDW6iyaTGWnb9KxTnhqRTTJ3FeRCWU2my/4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ+Gk2ZI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ+Gk2ZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100B01F000E9;
	Sat, 18 Jul 2026 19:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784401898;
	bh=qUm0Vo3TV6xbS/CsIp9cPQJx7hWJmkJM9vQjquscFGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QJ+Gk2ZIRjWgyAhBDgxWI40pp7TGvFOcEWFE+OhIKN2hNdjs8Y0J0TDmM4fchL2LU
	 0PfOT/MVPeG8Yh9OLxpHktMaiX7AYuQJOjv4ns4TZCYENNqR/E8oQRRReYavqz+5HI
	 dzHJ+h0SJCJutmEVmF0YZVIWt+bzU5AUUOYNmK5oCtjsJnxpln/m9D8M0xJdvMsC+8
	 W0RXvkGvFNjLSdtC/K1NhhsCH0UdhfudPtfHhmfLWnOchMrCUpYrln8G5cmJIc1ItX
	 ae7blU9YvNGQC4iX1sqzKmgHa/n/yfJZrqNu4mK/kuJ3bTNkP0j9pYtXFPX/tqO/XT
	 xNH51XgQ5v6CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] module: Rename module_blacklist to
 module_denylist
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260718190121.378314-3-atomlin@atomlin.com>
References: <20260718190121.378314-1-atomlin@atomlin.com>
 <20260718190121.378314-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 19:11:36 +0000
Message-Id: <20260718191138.100B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The module denylist/blacklist fails to block modules if the comman=
d-line parameter uses a hyphen while the internal module name uses an under=
score.
--

--- Patch [2]: [PATCH v6 2/2] module: Rename module_blacklist to module_den=
ylist ---
commit e8f656a2a563ecf3826a9353c13ab68af8069728
Author: Aaron Tomlin <atomlin@atomlin.com>

module: Rename module_blacklist to module_denylist

This patch renames the module_blacklist parameter to module_denylist while
keeping the old parameter as a legacy alias. It also marks the old parameter
as deprecated in the documentation and updates internal symbol names.

> diff --git a/init/main.c b/init/main.c
> --- a/init/main.c
> +++ b/init/main.c
[ ... ]
> @@ -1368,17 +1368,17 @@ static inline void do_trace_initcall_level(const =
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

[Severity: High]
This isn't a bug introduced by this patch, but does this strict byte-by-byte
comparison fail to account for the kernel's inherent hyphen-to-underscore
normalization in module names?

When an administrator specifies a module name containing a hyphen in the
module_denylist=3D parameter (e.g., usb-storage), the internal module name
will typically contain an underscore (e.g., usb_storage) because the kernel
build system automatically normalizes them.

Since memcmp() is used here in module_is_denylisted(), won't the comparison
fail, allowing the explicitly blocked module to load and bypassing the
intended security mechanism?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718190121.3783=
14-1-atomlin@atomlin.com?part=3D2
