Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811255;
	b=jsbAnvzcW3dM2tbzVzYQG4d1GDwGLCAhD9qVT/3zmckyN2SMe0sDXjZ1LzJgipsbn2S+
	 8MR8RPTStlKsQNU0893NzT4jqoenzJ/SGqClWdYsdQmhrK+XIbr2dSJEFTJODZYGyzTgN
	 AaUj0rQmqTweBIV4MGF2L921guhD9OYMqoDrWmuj5jZmhyLS6y5knJGa4rfoBr+EqdBKY
	 9uOtHKMwr5XqOOznb1ttahq2vzbCdod2i0V2sBNprUl9e+rfYHkkgINVUdyO/Yk+4bTDv
	 R1/y9XlxLVzRVy6zapn8CE3hiDT47NEX0dHCkWwIRibkHQKd6A3JXIirzqOvYtImLCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811255;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CScKELz5SKzseYYXZSgcmYAKi8+4UxQJUKYYxamqLTo=;
	b=2yuwP7QcqXeDrZzv8eVCapUzMSb670gCMctEl7eVM8SpD+szpYLcDnOIPzmtUqEqF8k+
	 EBOsDhgdLYKX813JSf8t3ZSjFqLZqK2Jv7S+D9sR7CMWm491hQa2pR8OtCGAlK/LaF8tP
	 +/NPeN6fhTlp+hcSaNfbrr/pj8bK+cp2XNxvkY+usHbUBw00ar+mljx+TaGxLVrIf/E3m
	 GmJcM3UjY7ddH1niMYV/9tkFzE51D5bPfNW53+GpVdFU9+7BiWGjljmoy6zNP9HI/nDnx
	 YVwzx63kcgbxg5g2pHYt+jIsf/PKgVb2Z2Gf8aaggT4o6fys3phw+66MjawVbJNKb9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbe4PHAt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B422606A328
	for <linux-modules@vger.kernel.org>; Wed,  4 Nov 2026 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbe4PHAt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ACB1F0093A;
	Wed,  4 Nov 2026 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793811255;
	bh=CScKELz5SKzseYYXZSgcmYAKi8+4UxQJUKYYxamqLTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gbe4PHAtNtqURzu6jUi82uH+VWN2KwXZ+CxMV8rfX6Z3JmvABWj4F4mCdAYF98U6h
	 9CFRQ5xlm2j0MvQNlrF00Wxh5vaGoQBWEsEnhhhCmj7XIkxs2w88T0YL0nmG6hLlva
	 acIhDheFQ5VazZ9uZyoelQnUD7FZYxqrLtsW9x5yQizbcWm6Ao1lHZgiulbupYWAgl
	 7Vi8CTleylDck90wiWckAlQIlr2Yid3TjlM7TSrD5htE5M/k+fqNU29bOvo0gNqO70
	 atzeRK/SmXgLG+1ukQUD4XabkDBzXqMqoPlV9E4j565JU4DpjJLEGecRhor94i9I3N
	 OXVytrKcaqsSg==
Message-ID: <sashiko-outbox-197697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/3] module: Extend module_blacklist parameter to
 built-in modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261104154003.43313-3-atomlin@atomlin.com>
References: <20261104154003.43313-1-atomlin@atomlin.com>
 <20261104154003.43313-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:54:14 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] init: klp-diff failure on __modname_<fn> with LTO and PREL32 rel=
ocations
--

commit 4ae71df0c31c4118e7804e6488565c6666998f3a
Author: Aaron Tomlin <atomlin@atomlin.com>

module: Extend module_blacklist parameter to built-in modules

This patch extends the module_blacklist=3D command-line parameter to built-=
in
modules by recording each module_init() function pointer and its
KBUILD_MODNAME in a new .initcall.modnames section. During boot,
do_one_initcall_builtin() checks this table and skips initcalls for
blacklisted built-in modules.

> diff --git a/include/linux/init.h b/include/linux/init.h
> index 6326c61e2332d..08cb8a2943758 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
[ ... ]
> @@ -252,6 +257,7 @@ extern struct module __this_module;
>  #endif
> =20
>  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +#define __initcall_fn_ptr(fn, __iid, id)	__initcall_stub(fn, __iid, id)
>  #define ____define_initcall(fn, __stub, __name, __sec)		\
>  	__define_initcall_stub(__stub, fn)			\
>  	asm(".section	\"" __sec "\", \"a\"		\n"	\
> @@ -260,6 +266,7 @@ extern struct module __this_module;
>  	    ".previous					\n");	\
>  	static_assert(__same_type(initcall_t, &fn));
>  #else
> +#define __initcall_fn_ptr(fn, __iid, id)	fn
>  #define ____define_initcall(fn, __unused, __name, __sec)	\
>  	static initcall_t __name __used 			\
>  		__attribute__((__section__(__sec))) =3D fn;
> @@ -271,7 +278,23 @@ extern struct module __this_module;
>  		__initcall_name(initcall, __iid, id),		\
>  		__initcall_section(__sec, __iid))
> =20
> -#define ___define_initcall(fn, id, __sec)			\
> +#define ____define_initcall_modname(fn, id, __sec, __iid)		\
> +	__unique_initcall(fn, id, __sec, __iid)				\
> +	static const char __initstr_##fn[] __used __aligned(1)		\
> +		__section(".init.rodata") =3D KBUILD_MODNAME;		\
> +	static const struct initcall_modname __modname_##fn __used	\
> +		__section(".initcall.modnames")				\
> +		__aligned(__alignof__(struct initcall_modname)) =3D {	\
> +			.initcall_fn =3D __initcall_fn_ptr(fn, __iid, id),\
> +			.modname =3D __initstr_##fn			\
> +		};

[Severity: Medium]
Can this break livepatch builds with objtool klp diff when
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=3Dy, CONFIG_LTO_CLANG=3Dy, and
CONFIG_KLP_BUILD=3Dy are enabled?

Under those options, ____define_initcall_modname() initializes
__modname_<fn>.initcall_fn to __initcall_fn_ptr(fn, __iid, id), which expan=
ds
to __initcall_stub(fn, __iid, id). Because __iid is generated by
__initcall_id(fn), the stub symbol name embeds both __COUNTER__ and __LINE_=
_:

include/linux/init.h:
    #define __initcall_id(fn)                                   \
            __PASTE(kmod_,                                      \
            __PASTE(__KBUILD_MODNAME,                           \
            __PASTE(__,                                         \
            __PASTE(__COUNTER__,                                \
            __PASTE(_,                                          \
            __PASTE(__LINE__,                                   \
            __PASTE(_, fn)))))))

During objtool klp checksum, calculate_checksums() -> checksum_update_objec=
t()
hashes target->demangled_name for each relocation on the __modname_<fn>
object:

tools/objtool/klp-checksum.c:checksum_update_object() {
    ...
                __checksum_update_object(sym, sym_offset, "reloc name",
                                         target->demangled_name,
                                         strlen(target->demangled_name));
    ...
}

Because demangle_name() in tools/objtool/elf.c does not strip the embedded
__COUNTER__ and __LINE__ tokens from __initstub__kmod_*, any patch to a
translation unit containing a built-in module_init() that shifts __COUNTER__
(for example by adding or removing min(), max(), guard(), WARN_ON(), or
__UNIQUE_ID()) or __LINE__ before module_init() changes the stub name and
alters the checksum of __modname_<fn>.

In tools/objtool/klp-diff.c, dont_correlate() -> is_initcall_sym() skips
__initcall__ and __initstub__ symbols, but does not skip __modname_:

tools/objtool/klp-diff.c:is_initcall_sym() {
        return strstarts(sym->name, "__initcall__") ||
               strstarts(sym->name, "__initstub__");
}

When correlate_symbols() pairs __modname_<fn> between the original and
patched objects, mark_changed_functions() sees the differing checksum on the
non-function symbol and aborts the build:

tools/objtool/klp-diff.c:mark_changed_functions() {
    ...
                if (orig_sym->csum.checksum !=3D patched_sym->csum.checksum=
) {
                        if (!is_func_sym(orig_sym)) {
                                ERROR("changed data: %s", orig_sym->name);
                                return -1;
                        }
    ...
}

Should is_initcall_sym() in tools/objtool/klp-diff.c also exclude
__modname_ symbols (or should __modname_<fn> avoid referencing the
__COUNTER__- and __LINE__-dependent stub name)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104154003.4331=
3-1-atomlin@atomlin.com?part=3D2
