Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8A517B50F
	for <linux-modules@vger.kernel.org>; Fri, 24 Jul 2026 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784858436; cv=none; b=ii8hPvH2KWQcWg4PHQ9AqD/gqY++PQ0TgIjG+vXRbm1Hmrhqt5+uP8lgj9IMUUgtKZ04ynnCJRbg72zFhWG9jgZkrp9u++BHwJre4mYxHJtpjCz68NugLVppq80IOxImi13vC4oQeUK5Bnvq8YHRS31Q0/PQ3xv8Fi4myQ/xT90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784858436; c=relaxed/simple;
	bh=aZBJG+Foju4T2g8NK8DOEP7dyw1DuTdYvgHBxvH6V6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kl35SaauGSC5M1vAdwWncefxzGWuD40n8AvA+a8gtnV/N3zKshKSa3igx8dtHdrNdC9FwV3w4npPa+/+YJCiHcDxz2Y0f3VjSWmIq7WVHK+tMoZwIokccVT+jYPyWkcIYX3AmZW9ErnCrhG6FfcdGjkC6CSs16VOddEbWz3YuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLDZLc8O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLDZLc8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC9D1F000E9;
	Fri, 24 Jul 2026 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784858435;
	bh=LwyXiU32UJDvyvvaPMeh3/0tGzAPcyebHLkl5QVzZlA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WLDZLc8OzpKEx1jgESlMKAa51QfSyx0y4DZzPeOlH00TVnVY8ouhA0KQvOYVGR8wD
	 4AgVKcLj105KSimeunfcZGF6N0MF6HUannAX9xmc/ChJ8VHKv0tasQbseYNAnl+p60
	 iPTGrbSio1vw2a6YVeYA+SSSIaEGKQ5+AVPDmOlEfEtgE1sSUFXr81pYitye/MN3qw
	 uamcRltqJDSOWb9OdkKBydVXIH7OMmrUZd44aE6w53857miJL2xapmlFucSFJXg81b
	 BgsWY7nbIoJdnecbQD4i5wXCJWpVgLI5y82nbmrdK9LA/g9R8jGUdkzNvKWgRT6/Yy
	 YA8VHRAwmblLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] module: Extend module_blacklist parameter to
 built-in modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260724014345.589326-2-atomlin@atomlin.com>
References: <20260724014345.589326-1-atomlin@atomlin.com>
 <20260724014345.589326-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 02:00:34 +0000
Message-Id: <20260724020035.1EC9D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Double evaluation of `__initcall_id(fn)` within `__define_initcall_=
modname` causes a fatal compilation/linker error when `CONFIG_HAVE_ARCH_PRE=
L32_RELOCATIONS` is enabled.
--

--- Patch [1]: [PATCH v7 1/2] module: Extend module_blacklist parameter to =
built-in modules ---
commit e69e6c4b3390b09453c5912322a9c34ef99cf6b5
Author: Aaron Tomlin <atomlin@atomlin.com>

module: Extend module_blacklist parameter to built-in modules

This commit extends the "module_blacklist=3D" command-line parameter to
intercept built-in modules during early boot. It introduces the
".initcall.modnames" section to map initcalls to module names, checking
this metadata before executing built-in initcalls.

> diff --git a/include/linux/init.h b/include/linux/init.h
> index 40331923b9f4a..46141c263ef25 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -252,6 +252,7 @@ extern struct module __this_module;
>  #endif
> =20
>  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +#define __initcall_fn_ptr(fn, id)	__initcall_stub(fn, __initcall_id(fn),=
 id)
>  #define ____define_initcall(fn, __stub, __name, __sec)		\
>  	__define_initcall_stub(__stub, fn)			\
>  	asm(".section	\"" __sec "\", \"a\"		\n"	\
[ ... ]
> @@ -271,7 +273,24 @@ extern struct module __this_module;
>  		__initcall_name(initcall, __iid, id),		\
>  		__initcall_section(__sec, __iid))
> =20
> -#define ___define_initcall(fn, id, __sec)			\
> +struct initcall_modname {
> +	initcall_t initcall_fn;
> +	const char *modname;
> +};
> +
> +#define __define_initcall_modname(fn, id)				\
> +	__define_initcall(fn, id)					\
> +	static const char __initstr_##fn[] __used __aligned(1)		\
> +		__section(".init.rodata") =3D KBUILD_MODNAME;		\
> +	static const struct initcall_modname __modname_##fn __used	\
> +		__section(".initcall.modnames") =3D {			\
> +			.initcall_fn =3D __initcall_fn_ptr(fn, id),	\
> +			.modname =3D __initstr_##fn			\
> +		};

[Severity: Low]
Does this double evaluation of __initcall_id(fn) break the build when
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS is enabled?

__define_initcall(fn, id) evaluates __initcall_id(fn) as part of its expans=
ion.
__initcall_fn_ptr(fn, id) also evaluates __initcall_id(fn).

Since __initcall_id() relies on the __COUNTER__ preprocessor directive,
these two evaluations will consume different counter values. Could this
generate mismatched stub references, causing undefined reference errors
during the build for built-in modules?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724014345.5893=
26-1-atomlin@atomlin.com?part=3D1
