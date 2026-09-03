Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29A3DE423
	for <linux-modules@vger.kernel.org>; Thu,  3 Sep 2026 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462796; cv=none; b=kzIRKELZfXbYgKiuUpWCrao2vIewBN2VnwISq/8+unIuztjlzI9jb1++ShnaDRu8T9Q1qmp/OwO2jDdn28UrXF0td5izgx2TCoL9pUXeWVCPbZVhnT8QoEWaUNzw7cBFJah85p003/6biT0U4+jKvRWvxxw+JZdBP/7u//a6qGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462796; c=relaxed/simple;
	bh=IUslvUGII3JreQkITN+WDTfhbyD1M4vtyurO6Sw6rlY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rVVTpNIdesMlou90hGoJSnO54aq1aNK7w0ZZhu/tf2g+2ciCHIbFjdiECa8IB6yoVUyYZt9ibjcQfXDfA/UsFM7HRr1Jzw0zsHAw1b9QjH/HxsCzY19J01s1repCmazWO6yfb7VsxOPO7VHIDssxZA6Vu0KoCkMHx8DA4rpqTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap7dxTzD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap7dxTzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A14B1F000E9;
	Thu,  3 Sep 2026 19:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788462783;
	bh=VZ1WfLLzNvMDF/qj9cA2ClhJB8IX8JWZ0zlTxvea0fU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ap7dxTzDgLJMVOHy5uz6G4on8vFRMwQM1wfMLG5ASd7NDQ43xRDXAUSk+GB7rn5JR
	 gw7t6EVzwFXLX/AEVc61PdO8cUkmB2UcI983Jm8mWo0Wa7N2V+wRyhVsKPjJj0yve4
	 hv4Krkk/9ndC0IHQGHpG72kg0v4o+6crZNkMFHtjav2jOpnSboIipq0Nuc/Ls6o4Y0
	 oNR4s3KpxYYHGM66tAMMlwxBZns3j/pTKc7aNlC4izc7nIGbiuHxJHHeLkrFOGSZ7h
	 USt3uWiR+g/ZtKjlZhyJWSfrp6kH2BKl75BKLgb1tGkzdMMTDxv0qUuXfASaWU9K0D
	 RqScPbpIIbMyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/2] module: Extend module_blacklist parameter to
 built-in modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: ojeda@kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260903185557.183224-2-atomlin@atomlin.com>
References: <20260903185557.183224-1-atomlin@atomlin.com>
 <20260903185557.183224-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 19:13:02 +0000
Message-Id: <20260903191303.5A14B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing alignment for `.initcall.modnames` section causes unaligne=
d pointer reads and potential kernel crashes during early boot.
- [Low] The Rust `module!` macro generates invalid code by dereferencing a =
dynamically sized slice `[u8]` into a fixed-size array `[u8; N]`.
--

commit 828a4fa4f29a0a3c5aba9065f4ba35eb845dddef
Author: Aaron Tomlin <atomlin@atomlin.com>

module: Extend module_blacklist parameter to built-in modules

This commit extends the module_blacklist command-line parameter to apply to
built-in modules. It achieves this by creating a new .initcall.modnames
section to map initcalls to module names, intercepting blacklisted builtin
initcalls during early boot.

> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index b2988aa12f664..7490278b7a2df 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -734,7 +734,8 @@
>  	EARLYCON_TABLE()						\
>  	LSM_TABLE()							\
>  	EARLY_LSM_TABLE()						\
> -	KUNIT_INIT_TABLE()
> +	KUNIT_INIT_TABLE()						\
> +	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)

[Severity: High]
Does this section declaration need an alignment constraint? Without a prece=
ding
. =3D ALIGN(8); or similar, the __start_initcall_modnames label might captu=
re
the unaligned location counter before padding is inserted by the linker.

When iterating over this section during early boot in do_initcall_level(),
could the kernel read padding bytes as garbage pointers, breaking the
builtin module blacklist feature or causing an unaligned memory access pani=
c?

[ ... ]

> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index bc7027f8dbb2c..a96157598197f 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
[ ... ]
> @@ -591,6 +594,20 @@ pub extern "C" fn cleanup_module() {
>                  #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
>                  ::core::arch::global_asm!(#global_asm);
> =20
> +                #[cfg(not(MODULE))]
> +                #[used(compiler)]
> +                #[link_section =3D ".init.rodata"]
> +                static #ident_modname_str: [u8; #name_len] =3D *#name_cs=
tr.to_bytes_with_nul();

[Severity: Low]
Will this cause a compilation failure for built-in Rust modules?

It attempts to initialize a fixed-size array by dereferencing a dynamically
sized slice returned by to_bytes_with_nul(). This could break the build when
CONFIG_MODULES=3Dn or when a Rust module is configured as built-in.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903185557.1832=
24-1-atomlin@atomlin.com?part=3D1
