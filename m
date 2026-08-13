Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA93921DD
	for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614594; cv=none; b=q0gyw4F/HCCba4SvSaKvJa6dbJpuUOMeJ4oqUlIbUZpN41a8h9s4r79bXuklvy+f7k86h8LT9YyceQMQQPbQpnYbV3WRUKb7oiHMIjYVDcXCKR5L8hYrdzOSReXeEfyhCuTHaFqgk+0pQYAjnJyvetFJjQWaaSX3LY3FsG1XA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614594; c=relaxed/simple;
	bh=t9CWCCFY9zZvBPDDpqOt2JECTvnyDth5JPDF7tOxMuk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dITu90Dm14q1QypKlbxYk/cl9ICpiPSHq81aGJFKhv8a+2OPF0l2/iqqmuoO82q8AZILMuvUNJo9ehq+4P5z+5ECew3dl/VV2Nu7rq44HPq2W9CFGaS97AYarUhdGC6lMQxu1oCcn7sq1dG+puicAA3/CFPWKvGfncHGbm8Dl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBI0Uz3t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBI0Uz3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FFB1F000E9;
	Thu, 13 Aug 2026 09:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614593;
	bh=uUS3xEEkGqF4Nr60z0VIHmnGP15d4ht97gFMX/xUaxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fBI0Uz3tjP5m0HAM8dHY2xcbGJNLPbwxoTBA925b+MoTpdgYE+ymEj1zrLKeO+Ovl
	 BrhuxNkFch9LBcqubP+SKuGEQj2sUrcUqR9aZX9GbmGl6PneyCZTy791Vx3+EXiTcX
	 xFDssr/V4jjP+Xc35S0zBnY2XBopRX+wX/QPHsP463NjVDREyyBnUaNSnCClC22ISR
	 Lk2DeBaZzW7JxHLMVJFAZfHlGEXeks3tJ+W0TBiblG16vTXeaKzdPzpeVLP0xKsbAu
	 dpze/2xCK87uduJaM0EmII5WyL2biqvpMaQ7R1BK4W/9Vyt4gB+b1+0HZqjfinizp6
	 fQzhAhTTKSYGQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] alloc_tag: skip percpu counter allocation when
 profiling is disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260813093421.135230-2-hao.ge@linux.dev>
References: <20260813093421.135230-1-hao.ge@linux.dev>
 <20260813093421.135230-2-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 09:49:52 +0000
Message-Id: <20260813094952.D2FFB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error code assignment when codetag_load_module() fails in =
load_module().
- [High] Use-After-Free and memory leak due to missing codetag_unload_modul=
e() on the module load error path.
--

--- Patch [1]: [RFC PATCH 1/3] alloc_tag: skip percpu counter allocation wh=
en profiling is disabled ---
commit 355b88475bea314f9aab64a9aa73da39a0d2bcf0
Author: Hao Ge <hao.ge@linux.dev>

alloc_tag: skip percpu counter allocation when profiling is disabled

After shutdown_mem_profiling() clears mem_profiling_support,
needs_section_mem() returns false, so later modules have their codetag
section placed as regular data and never enter the alloc_tag maple tree.
This patch returns CODETAG_MODULE_EXCLUDED when profiling is off to skip
percpu counter allocation.

> diff --git a/lib/codetag.c b/lib/codetag.c
> index a9cda4c962a30..8506ecab9ea70 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
[ ... ]
> @@ -238,9 +238,10 @@ static int codetag_module_init(struct codetag_type *=
cttype, struct module *mod)
>  	}
>  	up_write(&cttype->mod_lock);
> =20
> -	if (err < 0) {
> +	if (err) {
> +		/* Error or excluded: cmod is dropped, free it. */
>  		kfree(cmod);
> -		return err;
> +		return err < 0 ? err : 0;
>  	}
> =20
>  	return 0;

[Severity: High]
This is a pre-existing issue, but if codetag_module_init() fails midway thr=
ough
the codetag types, does it leave the module registered in the previously
initialized types?

lib/codetag.c:codetag_load_module() {
...
	list_for_each_entry(cttype, &codetag_types, link) {
		ret =3D codetag_module_init(cttype, mod);
		if (ret)
			break;
	}
...
}

If the loop breaks on an error, the successfully initialized types are not
unwound. When load_module() in kernel/module/main.c handles this error, it
jumps to sysfs_cleanup and eventually frees the module, but misses a call to
codetag_unload_module(mod).=20

Could this lead to a use-after-free or a memory leak when traversing the IDR
later, since the freed module is still registered?


[Severity: High]
This is another pre-existing issue. Is the error code lost in load_module()
when codetag_load_module() fails?

kernel/module/main.c:load_module() {
...
	if (codetag_load_module(mod))
		goto sysfs_cleanup;
...
}

Since err is not assigned before jumping to sysfs_cleanup, would the syscall
incorrectly return 0 (success) even though the module failed to load and was
destroyed on the error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813093421.1352=
30-1-hao.ge@linux.dev?part=3D1
