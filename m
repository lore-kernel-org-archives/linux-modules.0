Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042DF2F7AC1
	for <linux-modules@vger.kernel.org>; Sat, 18 Jul 2026 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784352802; cv=none; b=CD+CV8LISBpymrV8ncIyGf77cs8x/1lUL3Xfl3yaCdjxB9JNJvr0E1LRACVIUWQnQ5s5TgoYAq2OmAbg4WvtJPQL110XLBMzo0TU4qglQfiFv7sE4C+rC9AcRVP16xwvUtyquUlgRreqeniGPBORxQ5SuT1gAU+ZugLIDZXTu8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784352802; c=relaxed/simple;
	bh=ghOVk14kE8AfDn5vT+dAkN7iDqaMlqtQHDURFKf/9vo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E59fPg78Q4mNrz76tuF/fhAogoR2Nq8vv6xtLHmIp+FJlwagUz08m+9kE/TCeCLVorsattWFcH4RHhiQG0yDG1NAl5BK1EFsLSnJ0j3ofBX0erZJBfITGXA/Y5JgpTmWYwH7ZZ3Ki+EutV6CfeaCIhm7NGpef5de/wsz7ZTyTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJYUYHRM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJYUYHRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B7B1F000E9;
	Sat, 18 Jul 2026 05:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784352800;
	bh=OuDLXo2iZ6c49rwWu4E9pilMW29eJKCw6BhFtYru34o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJYUYHRMt3B0J18Qr8Lpfgn4hFNla/LqUDdgmNUtlisLO5tWpMHVxDloFriFSVTdj
	 /bb0uFDZj/z3qgKPZGLgJot2nTeuekMD85UZwZEN/pY49kPWRepOuamwkBCESLIxrk
	 HicC2i1lGEmFGAQFwesuL72Zj6rrgbt68kgbJooUSXpnLioRxsofVvLO0F/TYhwCQo
	 tSNdW37J1dt6tnwp40GO2JIUgnL3xZskbHoy3ezLxxRs3kAjFNgZVIsXWr56DCm9la
	 SICIwS46GlFpyLiTP9YaG8v6xalUkbfGjqg+4xaHYYmkd1Z/uGLG2EZfYMDUBaffaP
	 2+KwsTVQ5sT7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] module: Extend module_blacklist parameter to
 built-in modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260718051350.344772-2-atomlin@atomlin.com>
References: <20260718051350.344772-1-atomlin@atomlin.com>
 <20260718051350.344772-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 05:33:20 +0000
Message-Id: <20260718053320.92B7B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] A fatal modpost section mismatch warning occurs when CONFIG_MODULE=
S=3Dy because a non-__init function references an __init function.
- [High] An unsynchronized TOCTOU race condition in `do_one_initcall()` all=
ows concurrent loadable module initialization to execute freed `__init` mem=
ory and access freed `__initdata`.
- [High] The temporal check `system_state < SYSTEM_FREEING_INITMEM` is vuln=
erable to Spectre v1 branch misprediction, leading to speculative execution=
 of freed `__init` code and speculative reading of freed `__initdata`.
--

--- Patch [1]: [PATCH v5 1/2] module: Extend module_blacklist parameter to =
built-in modules ---
commit befcdb365a33b92bbd551da11437b39b818bdea2
Author: Aaron Tomlin <atomlin@atomlin.com>
Subject: module: Extend module_blacklist parameter to built-in modules

This patch extends the module_blacklist command-line parameter to apply to
built-in modules by checking an .initcall.modnames table during early boot.
It moves the blacklisting logic to init/main.c and intercepts initcalls in
do_one_initcall().

> diff --git a/init/main.c b/init/main.c
> --- a/init/main.c
> +++ b/init/main.c
[ ... ]
> @@ -1365,12 +1365,58 @@ static const char *__init get_builtin_modname(ini=
tcall_t fn)
>  {
>  	struct initcall_modname *p;
> =20
>  	for (p =3D __start_initcall_modnames; p < __stop_initcall_modnames; p++=
) {
>  		if (dereference_function_descriptor(p->initcall_fn) =3D=3D
>  		    dereference_function_descriptor(fn))
>  			return p->modname;
>  	}
>  	return NULL;
>  }
> =20
>  int __init_or_module do_one_initcall(initcall_t fn)
>  {
>  	int count =3D preempt_count();
>  	char msgbuf[64];
> +	const char *modname =3D NULL;
>  	int ret;
> =20
> +	if (system_state < SYSTEM_FREEING_INITMEM && module_blacklist) {

[Severity: High]
Can this unsynchronized system_state check race with concurrent module load=
ing?

If a driver or subsystem schedules an asynchronous task that triggers
request_module(), a worker thread could evaluate this system_state check as
true. Concurrently, another CPU could advance the state and execute
free_initmem(), unmapping and freeing all .init.text and .init.data pages.

If this happens, the worker thread would then call get_builtin_modname(),
executing freed .init.text instructions and scanning the freed
.initcall.modnames array.


[Severity: High]
Is this temporal check vulnerable to Spectre v1 branch misprediction?

During early boot, do_one_initcall() is heavily executed for built-in
modules, training the CPU branch predictor to predict this condition as
true. At runtime (system_state =3D=3D SYSTEM_RUNNING), an unprivileged user
triggering a module load might cause the CPU to speculatively mispredict
the branch as true.

If the branch is mispredicted, the CPU would speculatively execute a direct
call to the freed .init.text section in get_builtin_modname(), potentially
creating an arbitrary speculative execution gadget if an attacker has
reallocated that memory.

> +		modname =3D get_builtin_modname(fn);

[Severity: High]
Does this introduce a modpost section mismatch warning when CONFIG_MODULES=
=3Dy?

When module support is enabled, __init_or_module evaluates to an empty macr=
o,
placing do_one_initcall() in the persistent .text section. Because it
directly calls get_builtin_modname(), which is annotated with __init, modpo=
st
will statically flag this cross-section reference since it doesn't perform
control flow analysis to evaluate the runtime system_state guard.

> +		if (modname && module_is_blacklisted(modname)) {
> +			pr_info("Skipping initcall for blacklisted built-in module %s\n",
> +				modname);
> +			return 0;
> +		}
> +	}
> +
>  	if (initcall_blacklisted(fn))
>  		return -EPERM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718051350.3447=
72-1-atomlin@atomlin.com?part=3D1
