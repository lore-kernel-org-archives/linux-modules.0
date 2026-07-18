Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6291DF25C
	for <linux-modules@vger.kernel.org>; Sat, 18 Jul 2026 05:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784352303; cv=none; b=Wd00Xcs9JYlL9lO0GMYSjuEY4gNXMPT4Yngkd4jmeYIQhzhkDD4S/rw8JGTSkJBwcENKpSi3BRH1XGRcZKRAGUlLX8ElZtPjCykhQFaxwfYjhi+YuhUHWtoQjvcV5D8E5in9DuMXggz41TOOykOTKHZkOZVpswpviBF7y1Rj3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784352303; c=relaxed/simple;
	bh=J7yS62RgDeEjzYo+1VYzi8/gsP0kij1GaNcw/Sen21c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GaS588PmEWiy1ahrzWKT0G7f7QmEm05Uz2aUt7QyrGXZRuDkHHx1hVM+sHhyAtAhtY7ea/1gHUTRrsfmF/Tb9mw8uNIKc+6LYESHu6a9tst45/zmyv4IQOcVGwNN2m9T8XDyuFKlqFxokyLGZ/B5t3oT8z+DddzpROwBSkASIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQptP9M+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQptP9M+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF931F000E9;
	Sat, 18 Jul 2026 05:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784352301;
	bh=TMpU7DXpibmIbfa28Erxqs7sp/WRHV8MIDRjusOkz+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mQptP9M+NIVUPqfp4N4M0zGMH/fbOc6FkwG2/QKQFcBULknoFr0tIX7BDDJt3f08V
	 NOlHitx6sD7T4dLJzao2RbHJPNQcnHubdQRRtntyFmAhWDWYnZnIF9DM7MIWX2KR2i
	 /KO1wm5iycgQiUU5/ebDmlZIU0eLD78O9rb5s9bUR5JbNTABrUssU3ciBhe4Q+igM5
	 IROIU4FtVRuVHYDNHnn1CiD67qH6lSSx1UcA0cre3K3LmqQCs+L9USblb6n5SrTuGN
	 QNiCg8NiRuOg7HkhissjjEljAJoRM6bPEgME7rD+jmsv2z7EjftA2Ahyfi2mQgOekv
	 5YeVC284oAH0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] module: Rename module_blacklist to
 module_denylist
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260718051350.344772-3-atomlin@atomlin.com>
References: <20260718051350.344772-1-atomlin@atomlin.com>
 <20260718051350.344772-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 05:25:01 +0000
Message-Id: <20260718052501.BFF931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The newly introduced `module_denylist` kernel parameter is not docu=
mented in `kernel-parameters.txt`, and the legacy parameter is not marked a=
s deprecated.
- [Low] Kernel log messages were not updated to reflect the new inclusive t=
erminology.
--

--- Patch [2]: [PATCH v5 2/2] module: Rename module_blacklist to module_den=
ylist ---
commit 4cda93857ba5a82c96224a9d0d2d74dde6f4849f
Author: Aaron Tomlin <atomlin@atomlin.com>

module: Rename module_blacklist to module_denylist

This commit renames the internal module_blacklist variables and helper
functions to module_denylist to align with the kernel's coding style guide.
It retains module_blacklist as a legacy alias for backward compatibility.

> To align with the kernel's established coding style guide regarding
> naming conventions (i.e., Documentation/process/coding-style.rst),
> migrate the internal module_blacklist variables and helper functions to
> module_denylist and module_is_denylisted().

[Severity: Low]
Since the kernel parameter is being updated to module_denylist=3D, should=20
Documentation/admin-guide/kernel-parameters.txt also be updated to document=
=20
the new parameter and mark the old module_blacklist parameter as deprecated?

> diff --git a/init/main.c b/init/main.c
> index 7899a31d525df..df21df7b7e868 100644
> --- a/init/main.c
> +++ b/init/main.c

[ ... ]

> @@ -1408,9 +1409,9 @@ int __init_or_module do_one_initcall(initcall_t fn)
>  	const char *modname =3D NULL;
>  	int ret;
> =20
> -	if (system_state < SYSTEM_FREEING_INITMEM && module_blacklist) {
> +	if (system_state < SYSTEM_FREEING_INITMEM && module_denylist) {
>  		modname =3D get_builtin_modname(fn);
> -		if (modname && module_is_blacklisted(modname)) {
> +		if (modname && module_is_denylisted(modname)) {
>  			pr_info("Skipping initcall for blacklisted built-in module %s\n",
>  				modname);

[Severity: Low]
This isn't a bug, but should the pr_info() log message also be updated to s=
ay=20
"denylisted" instead of "blacklisted" to match the new terminology?

>  			return 0;

[ ... ]

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d397b57f57b65..0f05497c0fc3e 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c

[ ... ]

> @@ -3298,9 +3298,9 @@ static int early_mod_check(struct load_info *info, =
int flags)
> =20
>  	/*
>  	 * Now that we know we have the correct module name, check
> -	 * if it's blacklisted.
> +	 * if it's denylisted.
>  	 */
> -	if (module_is_blacklisted(info->name)) {
> +	if (module_is_denylisted(info->name)) {
>  		pr_err("Module %s is blacklisted\n", info->name);

[Severity: Low]
This isn't a bug, but should this pr_err() message also be updated to use=20
"denylisted" to fully align with the naming convention update?

>  		return -EPERM;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718051350.3447=
72-1-atomlin@atomlin.com?part=3D2
