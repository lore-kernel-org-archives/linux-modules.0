Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0B43033CB
	for <linux-modules@vger.kernel.org>; Sat,  5 Sep 2026 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788607163; cv=none; b=h7abnu4IhUVQdzfL+RfS+2zVdEHK+Vr9wSn4K04MD0pRD0wY/LRt+ZNJHZ3VbVTdt0Z4IbQjcvUbZmc6xksKGnaRnvkBN8gmwka0CpMa88+uFd6qprmwt9FuqInDqy7nRLfbJkv/TBbVPXATXDAfGxoXRDarvOSbHn7mDqiRWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788607163; c=relaxed/simple;
	bh=0nFv6v4VDEUW8F6h8B8cMmcf6j+G03P/WmkCVXg7bsk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cC+jISaQUg3tbfNC2aMF8IWsjySmf4sj18bZOBTSdV//Es6uff2ZjkdyMFxvlK1oP4Mtcbvs3VOHbIttKU5dxuJS0xLkV4YY1WJG3h8xQHX6EYIUVTIjbHHxUs/1D8mOXQE+shdMuq6sJ7HTczXDvKojzeRwgfyCHSPC2tsYNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPC3s8RY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPC3s8RY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319941F00A3E;
	Sat,  5 Sep 2026 11:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788607161;
	bh=G7K3l0MI73hmHPnTiWpNsBKbDtex0kvzSZ+I8aRSEro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fPC3s8RYNrewKmhnj7QUGLIaGyApaKx3nqlzQFNhz3OUN7p1jvE6HyZumz0sjm9+V
	 rxf3MEOD21LsHWXeLTercys5W2hmPjrG4RuUQ2vedT4caE9+vJf2+9SODSqJ+GKOmm
	 css1U4Elhe82ZZOCsMUWb/vninvP+zrNTqS907WmuApbubD/Z1T3dGXYt4aQ9AJysY
	 yJa2fq4B/+HYgkjLKBQVpfD3PqneL5aogi5SZcXWUwDEoiebTEWnBmLr4e0ch2BHOf
	 Z3FHL+KNmFGvYcR7XjaPVsMOZIlMcW2khJRQ9PzrgxWrdf56QveMQD3FqNkjMsSIp5
	 9U/zTreKPitHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] module: validate sh_name for SHT_NULL sections
Reply-To: sashiko-reviews@lists.linux.dev
To: liuc63 <liuc63@xiaopeng.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260905110813.150411-1-liuc63@xiaopeng.com>
References: <20260905110813.150411-1-liuc63@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 11:19:20 +0000
Message-Id: <20260905111921.319941F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The patch strictly enforces sh_name boundaries on SHT_NULL secti=
ons, violating the ELF specification and risking module load failures for v=
alid files.

Pre-existing issues:
- [Critical] The patch leaves unvalidated sh_offset and sh_size fields of S=
HT_NULL and SHT_NOBITS sections vulnerable, allowing out-of-bounds reads an=
d memory corruption.
- [High] Consumers like find_any_sec, find_any_unique_sec, and module_enfor=
ce_rwx_sections still process SHT_NULL sections, which can cause false posi=
tives and crashes if undefined fields contain in-bounds garbage.
--

commit 15965760da3d985f09b447439735945868c9d133
Author: Liu Chao <liuc63@xiaopeng.com>
Subject: module: validate sh_name for SHT_NULL sections

This commit removes the bypass for SHT_NULL sections when checking
section name boundaries. It attempts to prevent out-of-bounds reads
during section name lookups by enforcing that all sections have valid
sh_name offsets.

Link: https://lore.kernel.org/linux-modules/20260708013301.C4D4A1F000E9@smt=
p.kernel.org/

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad06..7d5943cd65432 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2060,9 +2060,6 @@ static int elf_validity_cache_secstrings(struct loa=
d_info *info)
> =20
>  	for (i =3D 0; i < info->hdr->e_shnum; i++) {
>  		shdr =3D &info->sechdrs[i];
> -		/* SHT_NULL means sh_name has an undefined value */
> -		if (shdr->sh_type =3D=3D SHT_NULL)
> -			continue;

[Severity: Medium]
Does enforcing this boundary on SHT_NULL sections violate the ELF
specification?

According to the ELF specification, members of SHT_NULL sections, other
than the sh_type field itself, have undefined values. By removing this
check, we now strictly enforce sh_name is less than strhdr->sh_size for all
sections.

Could this cause a valid ELF module to be incorrectly rejected with
ENOEXEC if it happens to have an undefined but non-zero sh_name left over
from a post-processing tool shrinking the string table?

[Severity: High]
This is a pre-existing issue, but does removing this bypass leave
other SHT_NULL regressions unpatched?

For example, consumers like find_any_sec() and find_any_unique_sec()
do not check if sh_type is SHT_NULL before doing string comparisons:

find_any_unique_sec()
    ...
    if (strcmp(info->secstrings + info->sechdrs[i].sh_name, name) =3D=3D 0)=
 {

If an attacker crafts an SHT_NULL section with an in-bounds sh_name
that matches a targeted section name like .modinfo, will the loader
erroneously use this empty section and its undefined sh_offset and
sh_size fields?

[Severity: Critical]
This is also a pre-existing issue, but there appears to be a separate path
where unvalidated fields in SHT_NULL sections can lead to memory
corruption.

In elf_validity_cache_sechdrs(), offset and size bounds checking is
explicitly bypassed for SHT_NULL sections:

elf_validity_cache_sechdrs()
    case SHT_NULL:
    case SHT_NOBITS:
        continue;

However, move_module() does not exclude SHT_NULL sections, it only
excludes SHT_NOBITS:

move_module()
    if (shdr->sh_type !=3D SHT_NOBITS) {
        memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
    }

Can this sequence cause an out-of-bounds read from kernel memory if a
crafted module contains an SHT_NULL section with SHF_ALLOC set and an
arbitrary sh_offset?

Similarly, elf_validity_cache_index_mod() accepts SHT_NULL sections for
the .gnu.linkonce.this_module section.

Does this allow info->mod to point to an arbitrary kernel address when
initialized in elf_validity_cache_copy(), leading to out-of-bounds
writes during module initialization?

>  		if (shdr->sh_name >=3D strhdr->sh_size) {
>  			pr_err("Invalid ELF section name in module (section %u type %u)\n",
>  			       i, shdr->sh_type);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905110813.1504=
11-1-liuc63@xiaopeng.com?part=3D1
