Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A72E401
	for <linux-modules@vger.kernel.org>; Sat,  8 Aug 2026 03:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786161183; cv=none; b=HrgezGmJtxLgR88yMyJKO+rzakco5sc5o3zvm5ERoKnKam6FkqroncX5w1tvh3f8XMzonSdbNjy9om7NRvK6S6s3fqxj1JVyw2QZqNrIeIU5eC3WsTBarhCh43UyARaGOa04Scph6kzWHa+V4OmIhvms3UCmRwhp9NKrPx8H/+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786161183; c=relaxed/simple;
	bh=VAGv35Sm81Q8QluSwbypaMr2C6DMwa7L//krha8djjo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XUz3WkAEcuqE71BtOKtrb6OYCLIPqqQNi5HEH1xDwn4h8QW5uuioJ94lD8Vm9fBcEoAUMz08Y9iIb/Iq+hwFRIbiO6a2lSrvFX9ghMfAlepn9ibYXZxTTzMehEAuqKHvWdGkOqGg6KYewmL48osF40zRLqMYh+yuWC7GtRbWBVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dg6wcTtn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg6wcTtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E6F1F000E9;
	Sat,  8 Aug 2026 03:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786161182;
	bh=ER79e4dgiSCWmxzxHNFIHAY2QE15a+azd3aXVDNKxbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dg6wcTtnci9eNpn9n/fonhP5r5+MTrBcOIKiXf8IDDKdZQTsTYJguUUSJThQiXma9
	 YTHj6fjMJEfNtOnlHbm0UgMYGxxyDUAilyZZK8LwLdl+pqmRLtRdJ3UHYW57FjL5pl
	 3yLDmAc7CGqHBzEufZZmNszrlIvIzVpNYWUoWPQGWvkGVZM0Ju9/Ua2lJhhnb98lIc
	 3eU40Tt6pI1JLQVdQm1pC84TICx9ojOYl50ExLJcV9u+ja5IdTcVOV+htS5cZ/Hj9e
	 Yqh10x6Ih+gy1R+ZXVtQbwm9OS7TKk+Qds3VaHLo/SdnnbfaCNlMXQLGRPEP+pIFNx
	 qHBqaS2FyC8yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] module/kallsyms: Filter out local mapping symbols
 during module load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260808033715.13117-1-yangtiezhu@loongson.cn>
References: <20260808033715.13117-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 03:53:01 +0000
Message-Id: <20260808035301.C3E6F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Filtering mapping symbols from `core_kallsyms.symtab` before check=
ing for livepatch modules fundamentally breaks the 1:1 symbol index mapping=
 required for livepatch delayed relocations.
--

--- Patch [1]: [PATCH v1] module/kallsyms: Filter out local mapping symbols=
 during module load ---
commit 341d5ac5814c0e09a7b6cda2b0753c3161fb7f96
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

module/kallsyms: Filter out local mapping symbols during module load

This patch filters out compiler-generated local mapping symbols from loaded
modules' permanent symbol tables. It modifies layout_symtab() and
add_kallsyms() to skip these mapping symbols during layout generation so
that tracing tools resolve to clear C function names instead.

> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -130,6 +130,9 @@ void layout_symtab(struct module *mod, struct load_in=
fo *info)
> =20
>  	/* Compute total space required for the core symbols' strtab. */
>  	for (ndst =3D i =3D 0; i < nsrc; i++) {
> +		if (is_mapping_symbol(&info->strtab[src[i].st_name]))
> +			continue;
> +
>  		if (i =3D=3D 0 || is_livepatch_module(mod) ||
>  		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
>  				   info->index.pcpu)) {

[Severity: High]
Does skipping mapping symbols before the is_livepatch_module() check
incorrectly alter the total symbol count and layout for livepatch modules?

The livepatch subsystem requires mod->core_kallsyms.symtab to be an exact,
1:1 copy of the original ELF symbol table.

[ ... ]

> @@ -198,6 +201,10 @@ void add_kallsyms(struct module *mod, const struct l=
oad_info *info)
>  	src =3D kallsyms->symtab;
>  	for (ndst =3D i =3D 0; i < kallsyms->num_symtab; i++) {
>  		kallsyms->typetab[i] =3D elf_type(src + i, info);
> +
> +		if (is_mapping_symbol(&kallsyms->strtab[src[i].st_name]))
> +			continue;
> +
>  		if (i =3D=3D 0 || is_livepatch_module(mod) ||
>  		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
>  				   info->index.pcpu)) {

[Severity: High]
Will filtering mapping symbols while copying to core_kallsyms.symtab cause
all subsequent symbol indices to physically shift down, breaking livepatch
delayed relocations?

kernel/module/livepatch.c:copy_module_elf() explicitly documents this
requirement:

    /*
     * For livepatch modules, core_kallsyms.symtab is a complete
     * copy of the original symbol table. Adjust sh_addr to point
     * to core_kallsyms.symtab since the copy of the symtab in module
     * init memory is freed at the end of do_init_module().
     */
    mod->klp_info->sechdrs[symndx].sh_addr =3D
        (unsigned long)mod->core_kallsyms.symtab;

When klp_resolve_symbols() indexes into the table using the original
(unshifted) ELF indices, will it read the wrong symbol or go out of bounds?

kernel/livepatch/core.c:klp_resolve_symbols() {
    ...
        sym =3D (Elf_Sym *)sechdrs[symndx].sh_addr + ELF_R_SYM(relas[i].r_i=
nfo);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808033715.1311=
7-1-yangtiezhu@loongson.cn?part=3D1
