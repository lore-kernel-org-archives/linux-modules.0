Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59B78F3A
	for <linux-modules@vger.kernel.org>; Sat,  1 Aug 2026 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785595372; cv=none; b=VJFwsdmzaeU9t82OLbuJzQrCNuRbsgONFJgd6raUYGomr5lvdz9oBABtxMgFZKPoephYs2otmoGls0prShYLzbtPChsv5oiyVD1hi8cr6kXZHcb6BAsVDZ/9+njkpLC0OA5wL18qiy3sF95SbqcKz0xSxbVSQ4qoTLPYWT2lVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785595372; c=relaxed/simple;
	bh=aCs1jm4FCwR38FuiXOUbWThAe8Tjfsf/+Atxq+qULwQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lc72Kib4qFpgGqtsHhBpMXsb/tndQs3vhSthBZ3rf8Y5BtRyi5XRfEJ2qKl2al/0el7siVlbELJULGwlI/06TNcJQX++/SHyVG1S+T0ajcIWJc3NzfR3f17yCkbWeGAwSQvfJ8jBXsazzpztLju3E17W/QvyzNIWbV0B7e+hRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6aFq8Zt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6aFq8Zt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E347C1F00AC4;
	Sat,  1 Aug 2026 14:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785595371;
	bh=3g4i+AlEk3MiNJT9yOpYaSam1QqhOeMv53dMbTqZmsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T6aFq8Zt/Bk+0MJBTD5LWZDJ83sKaUKi8+J09kH5Z5CpEUrl+MagsYwxBLwkfy5O0
	 KvRoJK5FkEm84tsnFv7egGxHgqWK0+4d3YPrR5DXywt+PxlOXX6PEG1qX/5hsz3XG7
	 ttZ6JxcF1bev+yM2gGHc1dMB3FU0RAzK81jnBYgq1oOWCfIr3cgtV/C+8nuSJbrd8v
	 YgkPvvEo+MA72h8p9dm7I6eVx/uFRG80TDol0OQ8P5wMYn1Y7AkxTL/xIB1RnzPgws
	 DrNijWSOaXkVO5thrjPqeghqBRwJhDBeRZBlWQkwmlgkartUteiyReMrRfVkHZVhY3
	 vlMzx6aEaZ8iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/4] kallsyms: extend lineinfo to loadable modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260801143219.3975824-3-sashal@kernel.org>
References: <20260801143219.3975824-1-sashal@kernel.org>
 <20260801143219.3975824-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 14:42:50 +0000
Message-Id: <20260801144250.E347C1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Integer overflow in `mod_lineinfo_filenames_off()` and `module_loo=
kup_lineinfo_section()` size calculations bypasses bounds checks, leading t=
o out-of-bounds memory accesses in NMI/panic context.
- [Medium] `gen_lineinfo` fails to apply `.debug_info` relocations, causing=
 `dwarf_getsrclines` to read the wrong line program for all CUs except the =
first in an ET_REL module.
--

--- Patch [2]: [PATCH v8 2/4] kallsyms: extend lineinfo to loadable modules=
 ---
commit 4466d01d38fe10716b6638bf8ed427b3c7f20a03
Author: Sasha Levin <sashal@kernel.org>
Subject: kallsyms: extend lineinfo to loadable modules

This commit extends CONFIG_KALLSYMS_LINEINFO to loadable kernel modules.
It post-processes each .ko at build time to embed a lineinfo section,
which is used at runtime to annotate stack traces from module code.

> diff --git a/include/linux/mod_lineinfo.h b/include/linux/mod_lineinfo.h
> new file mode 100644
> index 0000000000000..75d0bfba6ce57
> --- /dev/null
> +++ b/include/linux/mod_lineinfo.h
> @@ -0,0 +1,122 @@
[ ... ]
> +static inline u32 mod_lineinfo_addrs_off(void)
> +{
> +	return sizeof(struct mod_lineinfo_header);
> +}
> +
> +static inline u32 mod_lineinfo_file_ids_off(u32 num_entries)
> +{
> +	return mod_lineinfo_addrs_off() + num_entries * sizeof(u32);
> +}
> +
> +static inline u32 mod_lineinfo_lines_off(u32 num_entries)
> +{
> +	/* u16 file_ids[] may need 2-byte padding to align lines[] to 4 bytes */
> +	u32 off =3D mod_lineinfo_file_ids_off(num_entries) +
> +		  num_entries * sizeof(u16);
> +	return (off + 3) & ~3u;
> +}
> +
> +static inline u32 mod_lineinfo_file_offsets_off(u32 num_entries)
> +{
> +	return mod_lineinfo_lines_off(num_entries) + num_entries * sizeof(u32);
> +}
> +
> +static inline u32 mod_lineinfo_filenames_off(u32 num_entries, u32 num_fi=
les)
> +{
> +	return mod_lineinfo_file_offsets_off(num_entries) +
> +	       num_files * sizeof(u32);
> +}
[ ... ]
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index f23126d804b25..b0e703e29708b 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
[ ... ]
> +static bool module_lookup_lineinfo_section(const void *blob, u32 blob_si=
ze,
> +					   u32 hdr_offset,
> +					   unsigned int section_offset,
> +					   unsigned int min_offset,
> +					   const char **file,
> +					   unsigned int *line)
> +{
[ ... ]
> +	/*
> +	 * Validate counts before multiplying =E2=80=94 sizing arithmetic could
> +	 * otherwise overflow on 32-bit with a malformed blob.  Each entry
> +	 * contributes one u32 (addrs), one u16 (file_ids), and one u32
> +	 * (lines); each file contributes one u32 (file_offsets).
> +	 */
> +	{
> +		u32 avail =3D blob_size - hdr_offset;
> +		u32 needed =3D mod_lineinfo_filenames_off(num_entries, num_files);
> +
> +		if (num_entries > U32_MAX / sizeof(u32))
> +			return false;
> +		if (num_files > U32_MAX / sizeof(u32))
> +			return false;
> +		if (needed > avail || filenames_size > avail - needed)
> +			return false;
> +	}

[Severity: High]
Can the needed calculation overflow before the bounds check is evaluated?

If num_entries is maliciously large (e.g., 0x33333334), the calculation in
mod_lineinfo_filenames_off() sums the array offsets using 32-bit unsigned
arithmetic (around 10 bytes per entry). This would wrap around modulo 2^32,
resulting in a small needed value that bypasses the needed > avail check.
A later binary search on addrs could then access out-of-bounds memory.

The division check on num_entries above only guards against a single u32
array's size, not the combined 10 bytes per entry.

> diff --git a/scripts/gen_lineinfo.c b/scripts/gen_lineinfo.c
> index a3ee54eaad05d..725a8dfbf011a 100644
> --- a/scripts/gen_lineinfo.c
> +++ b/scripts/gen_lineinfo.c
[ ... ]
> +static void apply_debug_line_relocations(Elf *elf)
> +{
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
> +		else if (!strcmp(name, ".rel.debug_line"))
> +			rel_debug_line_scn =3D scn;
> +		else if (shdr.sh_type =3D=3D SHT_SYMTAB)
> +			symtab_scn =3D scn;
> +	}

[Severity: Medium]
Does this miss relocations for ET_REL modules that contain multiple object
files?

This loop collects and applies relocations for .debug_line, but appears to
omit .rela.debug_info and .rel.debug_info entirely.

Without the relocations applied to .debug_info, the DW_AT_stmt_list attribu=
te
for all compile units might remain at offset 0.

> +static void process_dwarf(Dwarf *dwarf, unsigned long long text_addr,
> +			  struct covered_section *sections,
> +			  unsigned int num_sections)
>  {
[ ... ]
> +		if (dwarf_getsrclines(&cudie, &lines, &nlines) !=3D 0)
> +			goto next;

When dwarf_getsrclines() is later called in process_dwarf(), will it
repeatedly read the line program of only the first compile unit, leaving
most module functions without line info?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801143219.3975=
824-1-sashal@kernel.org?part=3D2
