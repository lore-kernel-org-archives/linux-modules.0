Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B512F6931
	for <linux-modules@vger.kernel.org>; Wed, 12 Aug 2026 03:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786506152; cv=none; b=bpUt67uc4mOdosJvJY0TaKQsnO5naB7AjiKwOZpigkNa4DDRJnznVuavIYDze77Mqw948xcwdgOHS9lwacTiXFHllbRNp3YfaY6qSLetv8BmKmfgutOjZG0Ww3G1bcm8l2u8GNVXrx978qYTkmXbzSvTUfDi8Y7bYRejxVhc7Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786506152; c=relaxed/simple;
	bh=Eghftz41OzykVBzhoQsH5C2o7klWSoibrkeqR7iHcwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IyfGwB9dDHze4GzraMEjnSC9e+qlODoJfXRt1N61tE641qHNDLnqTvES8lK+fEYwdgAUs5V4MrW8hW8BjaOpL4a0UtPN1gYiGSgvN8MBLFueTGiKT8PmYxAc1cHbM6vwZNb1PuvzWsHtULxA9vdB1Hpmg0dup0ec4xLW7IaYrik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP2r6GvT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP2r6GvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463EE1F000E9;
	Wed, 12 Aug 2026 03:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786506150;
	bh=oNcR1dqi5nt3vZehf2iIGNYogDyMnZqOB5jht2vzqHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IP2r6GvTzJ3pSyBymoMRUmp9+GMOV2lcVynyLqKOAeBbhCPmT7/YWljMxSN6QOIBA
	 lZ5dgOiEM+pZCeCJ7l7swFOLV88MfuhkrFDsCcbbaK+2yyOijvEUmAzgG2LM5sICSu
	 nnZgi6lhRppeyWO5zdI74WTG4WXeh6IvizVX5XMtb5i1t0Egelt53XJ7mFgD3QCPX4
	 BetRb3u/FNho7QphMic0q4UMlyPBR9xFEBBqzhcXLitmxb+ipe77k5dDAIzGnPA/YR
	 6yiWVZdrR72Me1Hiwe0iq1P/I2gY1tcz9MPrGxtcY/11vozO2qmKyqanCBfcdgF4bA
	 5Tn7jkcKwb1og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] module/kallsyms: Refactor current symbol
 filtering into is_kept_symbol()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260812032807.15034-3-yangtiezhu@loongson.cn>
References: <20260812032807.15034-1-yangtiezhu@loongson.cn>
 <20260812032807.15034-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 03:42:29 +0000
Message-Id: <20260812034230.463EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An attacker can use ELF relocations targeting the `.symtab` sectio=
n to bypass early validation checks. This leads to heap buffer overflows, o=
ut-of-bounds reads, and information leaks during module loading.
--

--- Patch [2]: [PATCH v3 2/3] module/kallsyms: Refactor current symbol filt=
ering into is_kept_symbol() ---
commit a466dcd66d6b608624bbdcca606a5281e2967615
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

module/kallsyms: Refactor current symbol filtering into is_kept_symbol()

Currently, the loops in layout_symtab() and add_kallsyms() duplicate the
exact same checks to determine whether a symbol should be preserved in
the module's core symbol table. This commit renames is_core_symbol() to
is_kept_symbol() and consolidates the checking logic.

> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index 8955cd42f20bc..efc73f66defd5 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c

[ ... ]

> @@ -197,23 +199,21 @@ void add_kallsyms(struct module *mod, const struct =
load_info *info)
>  	strtab_size =3D info->core_typeoffs - info->stroffs;
>  	src =3D kallsyms->symtab;
>  	for (ndst =3D i =3D 0; i < kallsyms->num_symtab; i++) {
> +		ssize_t ret;
> +
>  		kallsyms->typetab[i] =3D elf_type(src + i, info);
> -		if (i =3D=3D 0 || is_livepatch_module(mod) ||
> -		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
> -				   info->index.pcpu)) {
> -			ssize_t ret;
> -
> -			mod->core_kallsyms.typetab[ndst] =3D
> -				kallsyms->typetab[i];
> -			dst[ndst] =3D src[i];
> -			dst[ndst++].st_name =3D s - mod->core_kallsyms.strtab;
> -			ret =3D strscpy(s, &kallsyms->strtab[src[i].st_name],
> -				      strtab_size);
> -			if (ret < 0)
> -				break;
> -			s +=3D ret + 1;
> -			strtab_size -=3D ret + 1;
> -		}
> +
> +		if (!is_kept_symbol(mod, info, i, src + i))
> +			continue;
> +
> +		mod->core_kallsyms.typetab[ndst] =3D kallsyms->typetab[i];
> +		dst[ndst] =3D src[i];
> +		dst[ndst++].st_name =3D s - mod->core_kallsyms.strtab;
> +		ret =3D strscpy(s, &kallsyms->strtab[src[i].st_name], strtab_size);

[Severity: High]
This isn't a bug introduced by this patch, but could an attacker use ELF
relocations targeting the .symtab section to bypass early validation checks
and trigger a heap buffer overflow or out-of-bounds read here?

During module loading, layout_symtab() adds the SHF_ALLOC flag to the
.symtab section and computes memory requirements based on the unmodified
symbols:

kernel/module/kallsyms.c:layout_symtab() {
    ...
    symsect->sh_flags |=3D SHF_ALLOC;
    ...
}

Later, apply_relocations() processes relocation sections. Because .symtab
now has the SHF_ALLOC flag, relocations targeting .symtab are applied,
modifying the symbol table in memory after bounds checks have completed:

kernel/module/main.c:apply_relocations() {
    ...
    if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
        (!infosec || infosec !=3D info->index.pcpu))
        continue;
    ...
}

Finally, add_kallsyms() reads this modified symbol table without
re-validating it. If an attacker modifies st_name via relocations, it
bypasses the earlier elf_validity_cache_strtab() bounds check, causing
strscpy() to read out-of-bounds memory. Modifying st_shndx bypasses the
ndst calculation, causing out-of-bounds writes on mod->core_kallsyms.symtab
and typetab arrays.

> +		if (ret < 0)
> +			break;
> +		s +=3D ret + 1;
> +		strtab_size -=3D ret + 1;
>  	}
> =20
>  	/* Set up to point into init section. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812032807.1503=
4-1-yangtiezhu@loongson.cn?part=3D2
