Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A063B388D
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 01:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474392; cv=none; b=bWhuONvsogn6Z0garm/M7tnSAz7YjUDz0SHnR/2gXPx3YkxrrEtKVqVm1lZtC5wHT3P2VOnW6Uu8aLB+spwtTBGTgD0pUUur9TDqv1cJHg/P9sBBW8yHPGhTjocdaq2ZUuHDnozv5zfaNs3geXrwEZMn3bBLahEEponRDggShMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474392; c=relaxed/simple;
	bh=8FWSK4uzI/NHn4iQH/BVX3NVrmJPL2ZYn8lrMMJ9BeQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YpCitgUPSJ27Nxm2hl44DHgcG3QsXMIabSvRezNEpYToQ+7JFZsIbSBI1Y877cx/yHDV1RpP31Qhjou/YgKraZzVHOXpK1a+FIjp7wFZ/ZTKDZpoa0IKENJn/DsTEP7FTndrRasxyfOlY3J2/RxeoM0wEeeynuUyqU5PcKeCcY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liHU33q4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liHU33q4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D4A1F000E9;
	Wed,  8 Jul 2026 01:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783474381;
	bh=Op3Uz8ZBxYO3GbEZ+og9YRZKbg/2ljL83BmD0AV1AaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=liHU33q4ewc1+VfesfQvHzZAqRimzAOsc5YxE2Hd1u1nXbDT65YLVC3d3Q4jB7bBU
	 20VFR8I9uBHRE6EkHh4nqC1agXrVRDKQTHSzad+mYw4enPbvi+VBygtEzwyWANLy9j
	 xuaWYbmcLHy6Ofe9Yhq6zw5IGdnxeA/PcGC5AFv9W9DnxpQqaoYZk7Y51SRbor0fVr
	 nzTrYaqqO7NoCKZvoesZ1BlaYvFLQsspPrcstc8y9YYXuqIaigO4ayPVcF97AZdCAO
	 lcQ1J38PcY/r7Hv0G2KyQKeHzEkxYA/QHpyxvoqOoTbiBYjuVDVOyj76scIc3V9Yzw
	 szCpObxSfOr0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] module: validate string table section types
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhpw6liYXVkIFdla3N0ZWVu?= <tweek@google.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260708012107.1621513-1-tweek@google.com>
References: <20260708012107.1621513-1-tweek@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 01:33:01 +0000
Message-Id: <20260708013301.C4D4A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes an out-of-bounds read vulnerability for string tab=
les by ensuring they are of type SHT_STRTAB, but fails to address the exact=
 same vulnerability class for several other ELF sections (e.g., .modinfo, .=
gnu.linkonce.this_module, __version_ext_names, __ksymtab).
- [High] Iterating over sections in lookup functions triggers an out-of-bou=
nds string read for SHT_NULL sections due to missing sh_name bounds checkin=
g.
- [High] Validation logic for section headers accesses sechdrs[0] out of bo=
unds if e_shnum is 0 and e_shoff is near the end of the file.
--

--- Patch [1]: [PATCH] module: validate string table section types ---
commit e8e815fedf365febe70f5870d807616d37946281
Author: Thi=C3=A9baud Weksteen <tweek@google.com>

module: validate string table section types

In elf_validity_cache_sechdrs, section sizes and offsets are validated,
unless the section type is SHT_NULL or SHT_NOBITS.

Later, elf_validity_cache_secstrings and elf_validity_cache_index_str
access the section name table (.shstrtab) and symbol string table
(.strtab) headers without first ensuring that their types are
SHT_STRTAB. If a section type is SHT_NULL or SHT_NOBITS, sh_offset has
not been validated and may reference out-of-bounds memory when
dereferenced in elf_validity_cache_secstrings or
elf_validity_cache_strtab.

Validate that both string section headers are of type SHT_STRTAB before
caching them.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a6058..7cbc8f0e28c61 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2011,6 +2011,7 @@ static int elf_validity_cache_sechdrs(struct load_i=
nfo *info)

[Severity: High]
This is a pre-existing issue, but does the validation logic in
elf_validity_cache_sechdrs() access sechdrs out of bounds if e_shnum is 0
and e_shoff is near the end of the file?

The overflow check evaluates to 0 > positive if e_shnum is 0 and e_shoff is
less than info->len, allowing the check to incorrectly pass:

elf_validity_cache_sechdrs() {
    ...
    if (info->hdr->e_shoff >=3D info->len
        || (info->hdr->e_shnum * sizeof(Elf_Shdr) >
            info->len - info->hdr->e_shoff)) {
    ...
}

The code then sets sechdrs and blindly accesses sechdrs[0], reading past the
end of the user-provided module buffer:

elf_validity_cache_sechdrs() {
    ...
    if (sechdrs[0].sh_type !=3D SHT_NULL
        || sechdrs[0].sh_size !=3D 0
        || sechdrs[0].sh_addr !=3D 0) {
    ...
}

>   * Specifically checks:
>   *
>   * * Section name table index is inbounds of section headers
> + * * Section name table type is SHT_STRTAB
>   * * Section name table is not empty
>   * * Section name table is NUL terminated

[ ... ]

> @@ -2038,6 +2039,11 @@ static int elf_validity_cache_secstrings(struct lo=
ad_info *info)
> =20
>  	strhdr =3D &info->sechdrs[info->hdr->e_shstrndx];
> =20
> +	if (strhdr->sh_type !=3D SHT_STRTAB) {
> +		pr_err("Invalid ELF section name table type: %u\n", strhdr->sh_type);
> +		return -ENOEXEC;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but does iterating over sections in lookup
functions trigger an out-of-bounds string read for SHT_NULL sections due to
missing sh_name bounds checking?

In elf_validity_cache_secstrings(), bounds validation of sh_name against the
string table size is explicitly skipped for SHT_NULL sections:

elf_validity_cache_secstrings() {
    ...
    if (shdr->sh_type =3D=3D SHT_NULL)
        continue;
    ...
}

Later, section lookup functions like find_any_unique_sec() iterate over all
sections and blindly pass the unvalidated info->secstrings pointer to strcm=
p():

find_any_unique_sec() {
    ...
    if (strcmp(info->secstrings + info->sechdrs[i].sh_name,
               name) =3D=3D 0) {
    ...
}

Could this cause an immediate out-of-bounds memory read when strcmp()
executes if an attacker sets a huge sh_name on a SHT_NULL section?

[ ... ]

> @@ -2218,6 +2224,12 @@ static int elf_validity_cache_index_str(struct loa=
d_info *info)
>  		return -ENOEXEC;
>  	}
> =20
> +	if (info->sechdrs[str_idx].sh_type !=3D SHT_STRTAB) {
> +		pr_err("Invalid ELF symbol string table type: %u\n",
> +		       info->sechdrs[str_idx].sh_type);
> +		return -ENOEXEC;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but while this patch fixes an out-of-bounds
read vulnerability for string tables by ensuring they are of type SHT_STRTA=
B,
does the same vulnerability class exist for other ELF sections?

Since elf_validity_cache_sechdrs() skips bounds checking of sh_offset and
sh_size for SHT_NULL and SHT_NOBITS sections, lookup functions can match
sections by name while ignoring sh_type.

For example, elf_validity_cache_index_info() looks up .modinfo by name and
caches it without validating its sh_type:

elf_validity_cache_index_info() {
    ...
    info_idx =3D find_any_unique_sec(info, ".modinfo");
    ...
}

Similarly, in elf_validity_cache_index_mod(), the .gnu.linkonce.this_module
section rejects SHT_NOBITS but fails to reject SHT_NULL:

elf_validity_cache_index_mod() {
    ...
    if (shdr->sh_type =3D=3D SHT_NOBITS) {
    ...
}

And in move_module(), the loop skips SHT_NOBITS but calls memcpy for
SHT_NULL:

move_module() {
    ...
    memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
    ...
}

Could a malicious module supply these sections with type SHT_NULL and an
arbitrary, unvalidated sh_offset, leading to out-of-bounds reads or copies?

>  	info->index.str =3D str_idx;
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708012107.1621=
513-1-tweek@google.com?part=3D1
