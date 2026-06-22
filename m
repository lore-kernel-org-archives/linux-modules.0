Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619F3AEB4A
	for <linux-modules@vger.kernel.org>; Mon, 22 Jun 2026 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782137869; cv=none; b=CUZgzf4yrx/lcWZZv+k/eLlBtsqCaKxUZvCyZxH6ACR9DUi6EU39vvR9e5A3V4PH/i3/WFuHwkDh3x+dYILpqK1ptNbMTdH3oegwdGutlUKsct2JgfD1B95uHRSR1YmHJAVzhM8cxagFi2evtdiZv4c5+z02FaKRbtqDs/sdKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782137869; c=relaxed/simple;
	bh=RbAP7CCT+ZQgGyCMoN/9Z7myE+mmWAbElbfWbdZNqZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M0GXmGyP4ralsHqy0D9H+4PVOHKStU8Ehgn3BuEQ92pkSL7skIL4v0QBt45AeO/wAx3Ai2psUYRHRIvn4YjJOyFCTShbRwLz0exgFOCS7G0m6zv7AEYBdI2qO2vVB6yhMxllCC3iM5/+hDB2sYCe5UV+DaYPK9wiWqHD6Ijay8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKdAsbEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKdAsbEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB5D1F000E9;
	Mon, 22 Jun 2026 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782137868;
	bh=03jKoFkEQ9vkVQu4uWynUF4RFu+R9x7172yp8Cu6Mhc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AKdAsbEUzeHQoNEE1tOCesIT5V+3dQrJIfWv9F6zG7GTBy1YGwTg84X3FQ5DI8kKU
	 bIKCJkfHOIrjdL1eLBmT/ieoOQsisxd0Hvtr2heJvh5O8ifjzmT5YiyJXCmb40uuAz
	 JYJeZno2iu2YEdrbWQ9YKo0/xtgGS0qi7TQWPAVVF6K7BQYnf6UjpjXFhBm16a/Bdr
	 Ew1EQyV7jdbobh+mtDJ/XMV3M6QdAU9nNrmmtrNgQU4j2d2twj6ReY4fnw/ez0/KZI
	 H2jzOoG18pShNSc3AwVLfw3QkryLEHqHrXx6AXgY3lHBjMf76Z45sbST+sTDxJVxW+
	 gCmP7KAySQIaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] module: Extend module_blacklist parameter to
 built-in modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260622140259.2974-1-atomlin@atomlin.com>
References: <20260622140259.2974-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 14:17:47 +0000
Message-Id: <20260622141748.0AB5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Accessing the .initcall.modnames array during loadable module =
initialization reads freed .init memory, causing a Use-After-Free.
- [High] Built-in module blacklisting silently bypasses or fails to compile=
 under CONFIG_LTO_CLANG / CONFIG_CFI_CLANG due to function pointer mismatch.
- [Low] Kernel build fails when CONFIG_MODULES is disabled due to missing m=
odule_is_blacklisted() definition.
--

commit 5c29fcaa43d56c5e3cb5426f55d85a536519732f
Author: Aaron Tomlin <atomlin@atomlin.com>

module: Extend module_blacklist parameter to built-in modules

This patch extends the module_blacklist parameter to intercept and prevent
the initialization of built-in modules during system boot. It creates a
.initcall.modnames section mapping initcalls to module names, using 32-bit
relative offsets to preserve KASLR.

Link: https://lore.kernel.org/lkml/20260510061301.41341-1-atomlin@atomlin.c=
om/

> diff --git a/include/linux/init.h b/include/linux/init.h
> index 40331923b9f4a..212f64a07c739 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h

[ ... ]

> @@ -270,9 +280,26 @@ extern struct module __this_module;
>  		__initcall_stub(fn, __iid, id),			\
>  		__initcall_name(initcall, __iid, id),		\
>  		__initcall_section(__sec, __iid))
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +#define ___define_initcall(fn, id, __sec)				\
> +	__unique_initcall(fn, id, __sec, __initcall_id(fn));		\
> +	asm(".pushsection \".initcall.modnames\", \"a\"\n"		\
> +	    ".balign 4\n"						\
> +	    ".long " #fn " - .\n"					\

[Severity: High]
When compiled with CONFIG_LTO_CLANG or CONFIG_CFI_CLANG, the kernel wraps
initcalls in an __initcall_stub function, and stores the stub's address in
the initcall array.

Since ___define_initcall explicitly stores the original function's address
here, will initcall_get_modname() fail to match the runtime CFI/LTO stub
address passed by do_one_initcall()?

Also, could using #fn in inline assembly for a static function renamed by
LTO cause an undefined reference link error?

> +	    ".long __initcall_modstr_" #fn #id " - .\n"			\
> +	    ".popsection\n"						\
> +	    ".pushsection .init.rodata, \"a\"\n"			\
> +	    "__initcall_modstr_" #fn #id ": .string \"" KBUILD_MODNAME "\"\n" \
> +	    ".popsection\n");

[ ... ]

> diff --git a/include/linux/module.h b/include/linux/module.h
> index d80c3ea574726..21668ef1430a5 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -754,6 +754,8 @@ void *dereference_module_function_descriptor(struct m=
odule *mod, void *ptr);
>  int register_module_notifier(struct notifier_block *nb);
>  int unregister_module_notifier(struct notifier_block *nb);
> =20
> +extern bool module_is_blacklisted(const char *module_name);

[Severity: Low]
Does this cause a build failure when CONFIG_MODULES is disabled?

The function module_is_blacklisted() is defined in kernel/module/main.c,
but it is declared here unconditionally and called from do_one_initcall()
in init/main.c. If CONFIG_MODULES is disabled, could the linker fail with
an undefined reference?

> +
>  extern void print_modules(void);

[ ... ]

> diff --git a/init/main.c b/init/main.c
> index b84818ad9685f..ce6d769b99e17 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1365,12 +1365,39 @@ static inline void do_trace_initcall_level(const =
char *level)
>  }
>  #endif /* !TRACEPOINTS_ENABLED */
> =20
> +extern struct initcall_modname __start_initcall_modnames[];
> +extern struct initcall_modname __stop_initcall_modnames[];
> +
> +static const char *initcall_get_modname(initcall_t fn)
> +{
> +	struct initcall_modname *p;
> +
> +	for (p =3D __start_initcall_modnames; p < __stop_initcall_modnames; p++=
) {
> +		if (initcall_from_entry(&p->initcall_fn) =3D=3D fn) {
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +			return (const char *)offset_to_ptr(&p->modname_offset);
> +#else
> +			return p->modname;
> +#endif
> +		}
> +	}
> +	return NULL;
> +}
> +
>  int __init_or_module do_one_initcall(initcall_t fn)
>  {
>  	int count =3D preempt_count();
>  	char msgbuf[64];
> +	const char *modname;
>  	int ret;
> =20
> +	modname =3D initcall_get_modname(fn);

[Severity: Critical]
Is there a use-after-free risk here when loading dynamic modules?

The .initcall.modnames section is placed in INIT_DATA_SECTION, mapping it to
.init.data. Memory in the .init.* sections is freed by free_initmem() after
the system boots.

Since do_one_initcall() is marked __init_or_module, it is also called by
do_init_module() whenever a loadable module is initialized after boot:

do_init_module()
  do_one_initcall()
    initcall_get_modname()

Does this unconditionally iterate over the __start_initcall_modnames array
residing in the freed .init.data section?

> +	if (modname && module_is_blacklisted(modname)) {
> +		pr_info("Skipping initcall for blacklisted built-in module %s\n",
> +			modname);
> +		return 0;
> +	}
> +
>  	if (initcall_blacklisted(fn))
>  		return -EPERM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622140259.2974=
-1-atomlin@atomlin.com?part=3D1
