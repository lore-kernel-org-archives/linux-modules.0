Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A75385D77
	for <linux-modules@vger.kernel.org>; Mon,  6 Jul 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348890; cv=none; b=tWQW2uChWn8vpdoCFGx+87+YBItRqLwqulnz2G8uZPGYgcniW7EeM3RX2G4PJAG3c2haBgps33savi9liu+mwKNef93eUVXuIAnQJZR8rVcoID6eMsn7dUouwYQm8MUAL0N05WGhGIZR7C7yUsLB7Eez6DIk/3gnzpcqGgqSYMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348890; c=relaxed/simple;
	bh=fLoq92era25hdy8Wyk5XOcxqabwgutkDyOihMSdm3n8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f9M2JGRAVZhVtaInf0MACBFD5l7i8solWZ4Jz7xuWIOF/Xm03+XCNEIhzhXjnLvBItFVXg3micciDnjguMoFYeeilTd8mnFZwoTDLNfbQp3DEaI2H7ez/zwjkWNI0eY1Lpt6gb9rCkpy+xuzFFRg1DMp3K7EzhMsHHTYRR5Y4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgw1qbVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgw1qbVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34291F000E9;
	Mon,  6 Jul 2026 14:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783348889;
	bh=iPh6LeVPXGRjOrn8l/5/pPzG5GL91f9CYWBNyZRFaSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mgw1qbVYgFnELGretaV77wY4t2RKDgLLecmc7MkY7yo5P6KgHsdCS77XRoZJSfUAE
	 WGzSFTKEfmteQTtLGq/LXsHpcQGFWp8A6l8+IH8us9/UVZOppTt+1UF0I9+2m0fUIc
	 KoPmcGc7AZtL/w7zBIouMi7KYaI7Q3jxyh0fpP1d6vtCKdc0WBFPannJ6xpP9WvkSX
	 bivHgvYwMcgwjjbcuj7PAur0G0EZVHx3Ef1XBeqy8vVHiY/53k8Tdds+F/lG6QqkeK
	 ksRB8CiHIRhG6LWpAuSLPZzLmJLR8FWgri+GFd9z4X2FYx1cQmYlNAIiYnn4RIgmXp
	 09sZvehEVlgnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] kallsyms: extend lineinfo to loadable modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260706142914.2398993-3-sashal@kernel.org>
References: <20260706142914.2398993-1-sashal@kernel.org>
 <20260706142914.2398993-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:41:27 +0000
Message-Id: <20260706144128.E34291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] `apply_debug_line_relocations()` ignores `.rel.debug_line` (SHT_RE=
L), breaking module lineinfo on 32-bit architectures like i386 and ARM.
- [High] Misattribution of DWARF line entries for unhandled text sections p=
ollutes `.text` lineinfo.
- [High] Hardcoded assembly padding creates an ABI mismatch with the C stru=
ct layout on architectures where `alignof(u64) =3D=3D 4` (e.g., 32-bit x86).
- [Medium] An integer overflow in relocation offset validation allows an ou=
t-of-bounds write in the `gen_lineinfo` build tool.
--

commit a6a5ac22ccec63c8ea45f4ded1db6418cd100063
Author: Sasha Levin <sashal@kernel.org>
Subject: kallsyms: extend lineinfo to loadable modules

This commit extends the CONFIG_KALLSYMS_LINEINFO feature to loadable kernel
modules. It post-processes modules at build time to generate per-section
.mod_lineinfo binary tables mapping addresses to source lines. The tables
are embedded in the module and searched during stack traces.

> diff --git a/scripts/gen_lineinfo.c b/scripts/gen_lineinfo.c
> index 699e760178f09..e1e08469b4f2f 100644
> --- a/scripts/gen_lineinfo.c
> +++ b/scripts/gen_lineinfo.c
[ ... ]
> +	/* Find the relevant sections */
> +	while ((scn =3D elf_nextscn(elf, scn)) !=3D NULL) {
> +		const char *name;
> +
> +		if (!gelf_getshdr(scn, &shdr))
> +			continue;
> +		name =3D elf_strptr(elf, shstrndx, shdr.sh_name);
> +		if (!name)
> +			continue;
> +
> +		if (!strcmp(name, ".debug_line"))
> +			debug_line_scn =3D scn;
> +		else if (!strcmp(name, ".rela.debug_line"))
> +			rela_debug_line_scn =3D scn;
> +		else if (shdr.sh_type =3D=3D SHT_SYMTAB)
> +			symtab_scn =3D scn;
> +	}
> +
> +	if (!debug_line_scn || !rela_debug_line_scn || !symtab_scn)
> +		return;

[Severity: High]
Does apply_debug_line_relocations() skip .rel.debug_line sections?

On 32-bit architectures like i386 and ARM, relocations use SHT_REL and
generate a .rel.debug_line section rather than .rela.debug_line.=20

If the function bails out here, synthetic biases are never added and
DW_FORM_line_strp offsets remain un-relocated, which feeds zeros to libdw.
Could this break the module lineinfo feature entirely on these architecture=
s?

[ ... ]
> +		if (module_mode) {
> +			struct covered_section *cs;
> +
> +			cs =3D section_by_index(all_sections, ALL_SECTIONS,
> +					      sym.st_shndx);
> +			if (cs)
> +				value +=3D cs->bias;
> +		}

[Severity: High]
Could unbiased text sections pollute the .text lineinfo?

Sections not listed in all_sections[], such as .noinstr.text, do not
receive a synthetic bias here, leaving their relocated DWARF PCs starting a=
t 0.

When classify_address() processes these entries:

classify_address() {
    ...
    if (addr < sections[i].bias)
        continue;
    if (addr >=3D sections[i].bias + sections[i].size)
        continue;
    ...
}

An address smaller than the size of .text will fall into the .text bucket,
since .text has a bias of 0. Would this incorrectly merge line entries and
corrupt the binary search invariant?

[ ... ]
> +		if (!is_abs64)
> +			value &=3D 0xffffffffULL;
> +
> +		if (rela.r_offset + width <=3D dl_data->d_size)
> +			elf_write_uint((unsigned char *)dl_data->d_buf +
> +					       rela.r_offset,
> +				       value, width, target_le);
> +	}

[Severity: Medium]
Is there a risk of an integer overflow in this bounds check?

If a maliciously crafted ELF file provides a huge r_offset value from the
relocation section (such as UINT64_MAX), the addition of width could wrap
around to a small positive integer and bypass the check. This might lead to
an out-of-bounds write in elf_write_uint().

[ ... ]
> +static void emit_blob(const char *output_section,
> +		      const char *blob_tag,
> +		      enum mod_lineinfo_blob blob)
> +{
[ ... ]
> +	printf("\t.section %s, \"a\"\n\n", output_section);
> +
> +	printf("\t.balign 8\n");
> +	printf(".Lroot_%s:\n", blob_tag);
> +	printf("\t.long %u\t\t/* num_sections */\n", active);
> +	/* Pad to align the u64 anchor in sections[0] to 8 bytes. */
> +	printf("\t.balign 8\n");

[Severity: High]
Does this hardcoded padding create an ABI mismatch with the mod_lineinfo_ro=
ot
C struct on some architectures?

The assembly forces an 8-byte alignment immediately following the 4-byte
num_sections field. However, on 32-bit x86 architectures, the System V ABI
sets alignof(u64) to 4.

Looking at include/linux/mod_lineinfo.h:

struct mod_lineinfo_root {
    u32 num_sections;
    struct mod_lineinfo_section sections[];
};

The C compiler will align the struct to 4 bytes, meaning the sections[]
flexible array starts at offset 4, not offset 8. If the kernel reads this
blob, could it parse the assembly padding as the start of the anchor field
and corrupt the section descriptors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706142914.2398=
993-1-sashal@kernel.org?part=3D2
