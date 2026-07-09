Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045CD373BF2
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615833; cv=none; b=shGkbuMGspcwv0+B73pwibZ56dp9Ty9zSAJmtbk0EpPgM0gBqQrX/t8BO6MHnrQhXz4C+JYkKFs9zvyxAVfjexOceZb42qgkr0bxLA0W0sNEd0uH6TMmMcQpEXd1jc63oeNIy9d10ay1i8Ek9qvh5vBzzT6ABAEwKC4sVtONQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615833; c=relaxed/simple;
	bh=uIvfLEd/IE43gvIbM6CYe8fYESslUHG2nX7kNN6qivk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sidYEDWGcOqy2xDZMbVKrKV0hiWwnZW+0L6arItFZnVUen5cxp1V8nwK1Aar3LEi1M6iuEjKgRfZ0BkhYVotK0zme81UBSfKv8iN18wC5rNftRmnhHLEhZXECPy7GnhFWCF8YcpkZUCs/GHKaqg1GOFJcJt+afqsjAxSUG4B6n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGOYzJ2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGOYzJ2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A95E1F000E9;
	Thu,  9 Jul 2026 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783615831;
	bh=XsSQMhaDW8yDLfNILTL8shTiG6NxLdg17oVowN+VSlc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iGOYzJ2OaLYdreozm4KiuR/LULA4IzJinqJtkcEuEO4VWC7mYGUUdglKzdDeb58IS
	 B5tjXqnxh0LPYwe4+DWKg8g/xEMDxdPJD7hLm5xPJSYXdG+eEH0fqA20m34ppVHCmd
	 Ih5TH2QFX4M3cZjLT5zj6Yt6iJcwDsWZm0YrPgHgp7SKLm4T1LloC52uAZQL5iJV+U
	 9b/sbdY8DHeyCQMNagsrrSp15SOTZ9mv+KaQFExuIoFDc2O01AZUwYrIgZfzAm6cEz
	 4HXr7QIxT40Oq4PRB8nJ+g8g7/YiRSybObLrMKLbDn7aRidPjOGVEg6BbOKok9F+08
	 wIz2wxL6TFk4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] kallsyms: extend lineinfo to loadable modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260709163833.3851179-3-sashal@kernel.org>
References: <20260709163833.3851179-1-sashal@kernel.org>
 <20260709163833.3851179-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 16:50:30 +0000
Message-Id: <20260709165031.6A95E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unvalidated module blob offsets cause unaligned memory accesses, p=
otentially triggering alignment faults in critical contexts.
- [Medium] Integer overflow in the `apply_one_dl_reloc` bounds check allows=
 out-of-bounds heap access in the `gen_lineinfo` tool.
- [Low] Dynamically allocated memory for `extra_sections` is never freed in=
 the `gen_lineinfo` tool.
--

--- Patch [2]: [PATCH v7 2/4] kallsyms: extend lineinfo to loadable modules=
 ---
commit be00704ef1eba0bdfe61160ba94617348dfdc7dc
Author: Sasha Levin <sashal@kernel.org>

kallsyms: extend lineinfo to loadable modules

This patch extends the CONFIG_KALLSYMS_LINEINFO feature to loadable kernel
modules. It uses scripts/gen-mod-lineinfo.sh to generate .mod_lineinfo
sections containing binary tables of source file and line number mappings.
At runtime, module_lookup_lineinfo() searches these read-only tables to
provide NMI-safe file and line annotations for module stack traces.

> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index 0fc11e45df9b9..4888ce8a7f951 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
[ ... ]
> @@ -494,3 +494,201 @@ int module_kallsyms_on_each_symbol(const char *modn=
ame,
> +static bool module_lookup_lineinfo_section(const void *blob, u32 blob_si=
ze,
> +					   u32 hdr_offset,
> +					   unsigned int section_offset,
> +					   unsigned int min_offset,
> +					   const char **file,
> +					   unsigned int *line)
> +{
> +	const struct mod_lineinfo_header *hdr;
> +	const u8 *base;
> +	const u32 *addrs, *lines, *file_offsets;
> +	const u16 *file_ids;
> +	const char *filenames;
> +	u32 num_entries, num_files, filenames_size;
> +	unsigned int low, high, mid;
> +	u16 file_id;
> +
> +	if (hdr_offset > blob_size ||
> +	    blob_size - hdr_offset < sizeof(*hdr))
> +		return false;
> +
> +	base =3D (const u8 *)blob + hdr_offset;
> +	hdr =3D (const struct mod_lineinfo_header *)base;

[Severity: High]
Does this code safely handle unaligned memory accesses?

The hdr_offset value is read directly from the binary blob and is never
validated for 4-byte alignment before being cast to struct
mod_lineinfo_header * and subsequently u32 * for the internal arrays.

If a malformed or corrupted .ko file provides an unaligned hdr_offset,
dereferencing these pointers could trigger a hardware alignment trap on
strict-alignment architectures. Since this code is designed to be called
during NMI or panic stack traces, taking an alignment fault here would cause
a recursive fault and hang the system without producing the crash dump.

Could we add an alignment check for hdr_offset before casting it?

[ ... ]
> diff --git a/scripts/gen_lineinfo.c b/scripts/gen_lineinfo.c
> index 699e760178f09..7624098d0cb42 100644
> --- a/scripts/gen_lineinfo.c
> +++ b/scripts/gen_lineinfo.c
[ ... ]
> +static void apply_one_dl_reloc(Elf_Data *dl_data, Elf_Data *sym_data,
> +			       bool target_le,
> +			       unsigned int abs32_type, unsigned int abs64_type,
> +			       GElf_Xword r_info, GElf_Addr r_offset,
> +			       GElf_Sxword addend, bool has_addend)
> +{
> +	GElf_Sym sym;
> +	unsigned int r_type =3D GELF_R_TYPE(r_info);
> +	size_t r_sym =3D GELF_R_SYM(r_info);
> +	bool is_abs64;
> +	size_t width;
> +	uint64_t value;
[ ... ]
> +	width =3D is_abs64 ? 8 : 4;
> +
> +	if (r_offset + width > dl_data->d_size)
> +		return;

[Severity: Medium]
Can this bounds check overflow?

Because r_offset is a 64-bit integer, a maliciously crafted .ko file fed
to the gen_lineinfo tool could provide an extremely large value (such as
0xFFFFFFFFFFFFFFFE). Adding width to it would wrap around to a small
number, successfully bypassing the bounds check.

This could lead to out-of-bounds pointer arithmetic and a subsequent
out-of-bounds write in elf_write_uint() below, potentially causing a crash
or code execution within the kernel build environment.

[ ... ]
> +static void resolve_covered_sections(Elf *elf,
> +				     struct covered_section *sections,
> +				     unsigned int num_sections)
> +{
[ ... ]
> +		if (!covered &&
> +		    (shdr.sh_flags & SHF_EXECINSTR) && (shdr.sh_flags & SHF_ALLOC) &&
> +		    shdr.sh_size && shdr.sh_size <=3D UINT_MAX) {
> +			struct covered_section *es;
> +
> +			extra_sections =3D realloc(extra_sections,
> +						 (num_extra_sections + 1) *
> +						 sizeof(*extra_sections));
[ ... ]
> @@ -552,6 +1387,5 @@ int main(int argc, char *argv[])
>  	for (unsigned int i =3D 0; i < num_files; i++)
>  		free(files[i].name);
>  	free(files);
> -
>  	return 0;
>  }

[Severity: Low]
Does this code leak the dynamically allocated extra_sections array?

In resolve_covered_sections(), extra_sections is allocated and expanded
via realloc(). However, the cleanup block in main() only frees entries
and files, missing the extra_sections array.

While this is a short-lived userspace tool and the OS will automatically
reclaim the memory upon exit, would it be better to explicitly free
extra_sections to keep the cleanup complete?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709163833.3851=
179-1-sashal@kernel.org?part=3D2
