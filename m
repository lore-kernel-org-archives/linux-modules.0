Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF533AAF6F
	for <linux-modules@vger.kernel.org>; Wed, 29 Jul 2026 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347924; cv=none; b=ChzDiHoHwhjWyCFC5yHqZrmfN1NzXpUyWL9bVNWliDaQdmH8E57SuMfl13F9wt0Ea3RqsSSG5uKYfp1xD4gLNioO6994Ug2gja5/KeuwUydlGUc96XHeEmoSCEeO+SzmKiF0SWSLIVETdONL/oRIN00JeYjX9etiXK8LHKxvTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347924; c=relaxed/simple;
	bh=NEO6v8cndrVcHRDhdKUInRxpVow4micaHOZcmrmZfvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UiCEYF3GiYxKlBtxV+EVZkPJCCNGY/x9oxo3zP9JanyopTH7w/ofIDSU92U1a4gKT4KhmJMvE9ZtusfnriuXJX2t/dZJPGleBh8KYr/wc52zXHPluZgJeYbuulpFq8ZucILx93Z0AefkhSFdME0toCBggxrv914rKn/H2+U4ZYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfKx39Al; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfKx39Al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D551F000E9;
	Wed, 29 Jul 2026 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785347915;
	bh=tCuitixg4MSFTrpz6Eajo+LEkDZHosEHSR3nH36IRF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LfKx39AlhFP0mlS1K63gAItPXxksagV6fBvTjWRjyBuc0OmgKHQyyGT/qOuBAE1AX
	 fZtanrgZ0nX6Z5iNt0V1yebf7g4UyEP/+tY/G2zJ5BCQPmQknNxg0jo3nRzEpG7r0f
	 B31G0zFtDvCc9H/L2NIdj2c/jwPCmeoDQkyphvqbiURH+CwPxNfvsMyk27P2bbu5Kq
	 QM2ZKHp+qe5N1B23jTIGtVumdQUF4eL4x7lqxU2A+XKEEeBNfHb5E14aX4gjD+Zzlh
	 ab6FPH4ccHUqu1J6cZRWPiNJkwnMWg7DG0NyxQJvfuApzRHA5ONNQLo9SmcKtweVg4
	 cMPyXMr3NMIig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] lib/bug: ignore non-allocated module bug tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Laxman Acharya Padhya" <acharyalaxman8848@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260729174234.86242-1-acharyalaxman8848@gmail.com>
References: <20260729174234.86242-1-acharyalaxman8848@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:58:34 +0000
Message-Id: <20260729175834.E1D551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Systemic Use-After-Free (UAF) due to missing SHF_ALLOC validation =
across multiple subsystems.
- [High] Integer overflow in module layout calculation leading to out-of-bo=
unds reads.
--

--- Patch [1]: [PATCH] lib/bug: ignore non-allocated module bug tables ---
commit 2f65def59be64b4d6ec8eb77329b4e7bc9acac8c
Author: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

lib/bug: ignore non-allocated module bug tables

This commit updates module_bug_finalize() to require the __bug_table section
to have the SHF_ALLOC flag set before retaining its address. This prevents a
malformed module from leaving the bug table pointing into the temporary
module image, which is freed after loading.

> diff --git a/lib/bug.c b/lib/bug.c
> index 7c1c2c27f58e7..44966ead1e5fa 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -94,7 +94,8 @@ void module_bug_finalize(const Elf_Ehdr *hdr, const Elf=
_Shdr *sechdrs,
>  	/* Find the __bug_table section, if present */
>  	secstrings =3D (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
>  	for (i =3D 1; i < hdr->e_shnum; i++) {
> -		if (strcmp(secstrings+sechdrs[i].sh_name, "__bug_table"))
> +		if (strcmp(secstrings + sechdrs[i].sh_name, "__bug_table") ||
> +		    !(sechdrs[i].sh_flags & SHF_ALLOC))
>  			continue;

[Severity: High]
This is a pre-existing issue, but does this same vulnerability exist in oth=
er
subsystems that look up sections by name without checking SHF_ALLOC?

For example, in module_cfi_finalize() it assigns the section address to
mod->kcfi_traps without verifying the SHF_ALLOC flag:

kernel/cfi.c:module_cfi_finalize() {
    ...
    if (strcmp(secstrings + sechdrs[i].sh_name, "__kcfi_traps"))
        continue;
    mod->kcfi_traps =3D (s32 *)sechdrs[i].sh_addr;
    ...
}

Similarly, in unwind_module_init(), unvalidated ORC section addresses are
saved into the module structure:

arch/x86/kernel/unwind_orc.c:unwind_module_init() {
    ...
    mod->arch.orc_unwind_ip =3D orc_ip;
    mod->arch.orc_unwind =3D orc;
    ...
}

There is also module_init_ftrace_plt() which saves the unvalidated ftrace
trampolines address retrieved via find_section(), which ignores flags:

arch/arm64/include/asm/module.h:find_section() {
    ...
    if (strcmp(name, secstrs + s->sh_name) =3D=3D 0)
        return s;
    ...
}

If a malformed module provides these sections without the SHF_ALLOC flag,
would their sh_addr similarly point to the temporary module image buffer
and cause a use-after-free when the buffer is freed?

>  		mod->bug_table =3D (void *) sechdrs[i].sh_addr;
>  		mod->num_bugs =3D sechdrs[i].sh_size / sizeof(struct bug_entry);

[Severity: High]
This isn't a bug introduced by this patch, but can an extremely large
section size cause an integer overflow leading to an out-of-bounds read
here?

If a malformed module provides a section marked with SHT_NOBITS and
SHF_ALLOC, elf_validity_cache_sechdrs() explicitly skips size validation:

kernel/module/main.c:elf_validity_cache_sechdrs() {
    ...
    case SHT_NOBITS:
        /* No contents, offset/size don't mean anything */
        continue;
    ...
}

Then, in module_get_offset_and_type(), adding a massive 64-bit sh_size to a
32-bit offset truncates the result:

kernel/module/main.c:module_get_offset_and_type() {
    ...
    mod->mem[type].size =3D offset + sechdr->sh_size;
    ...
}

This wrap-around results in a small allocated memory layout size. However,
since module_bug_finalize() uses the original un-truncated 64-bit sh_size
to calculate mod->num_bugs, would a subsequent kernel warning or bug
trigger iteration far beyond the actually allocated memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729174234.8624=
2-1-acharyalaxman8848@gmail.com?part=3D1
