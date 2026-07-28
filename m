Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22E447810
	for <linux-modules@vger.kernel.org>; Tue, 28 Jul 2026 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260849; cv=none; b=guMVRlL2eW/7tuv+hRgA8zd3PrnwWva4MmIqiDwFrjYM068E1jAS/dnGyKU9X7nEL+8IdSZrby5HYDtRALd5p6VMRzV6d2zSXuLe6XyQ6UzQJxp/0kf7xqQL4Tkxzih8dDwGmLU0SCTZ4XPFqGZ70UMrIdh9JBpBdetg9vYdqSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260849; c=relaxed/simple;
	bh=cvgOO9VY6sXUSf8H1fV20vduS2+7NkQ85QrE+boeM0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nhVpdMY1phqAEfIyi3W4y7S+/V+/3belsUQBIyw+Hy3y1vzjkfePIN0xX5aSr3BPQGPbJ4lT5UiAGCEZNCGnbmnfsFmvF5TJBddPQfSqRCKIf2QfAQOGZYB5duT65QcLjqewYw7EVzLE+gmBYZp9z98JURkUqO4R0meLvwGcQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/ztJ5Pw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/ztJ5Pw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F221F000E9;
	Tue, 28 Jul 2026 17:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260847;
	bh=bnMlMuCSMG0fro89gHmoieLWNPFMpnMwEh99LausLtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/ztJ5PwimU1cxOYEsLJr0jCwFXPurbRbUdjG+R95ULfZLqZWgAPxjCIW9R5boNlD
	 HTcyKRwnR7UQHcp+g9qXIFJb9pXYafxyeHnReMp4zelpAnEelpM9ojNb5OriHU2mv3
	 H39yiVmmSVtkb2YMOTEFjLv8K6QZ+V/Tk/euI4qvblqB/2OTNpZQk6i6x5bHemRHbM
	 HuGEsCGHKVE0wctgaoyhGAlLPEDy43anGaTR8vaLBDpJEC30afO2FHSiI5h37u/TvW
	 Chj43YnWMoH8aEeuW99tN6NIbcaCUbC8D1ifKgOmkjKSHrLcKygSRPvUroxnjzo3ak
	 Ct06nDJpZLy/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] module: reject malformed .modinfo sections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Laxman Acharya Padhya" <acharyalaxman8848@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260728173318.63736-1-acharyalaxman8848@gmail.com>
References: <20260728173318.63736-1-acharyalaxman8848@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:47:27 +0000
Message-Id: <20260728174727.A2F221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `.modinfo` section bypasses bounds validation if its type is s=
et to `SHT_NOBITS`, allowing arbitrary `sh_offset` and `sh_size` values tha=
t lead to out-of-bounds kernel memory reads.
- [High] The patch fails to protect against out-of-bounds reads if the `.mo=
dinfo` section is completely omitted, falling back to an unvalidated `SHT_N=
ULL` section offset.
--

--- Patch [1]: [PATCH] module: reject malformed .modinfo sections ---
commit 7548fa1ced4767f35fb298eeab3978cae911d641
Author: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

module: reject malformed .modinfo sections

This commit attempts to prevent loaders from reading past the end of the
.modinfo section by rejecting empty sections and those that are not
NUL-terminated before parsing them.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 528690ba160bd..91e20cd1e6ac9 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2082,6 +2082,8 @@ static int elf_validity_cache_secstrings(struct loa=
d_info *info)
>  static int elf_validity_cache_index_info(struct load_info *info)
>  {
>  	int info_idx;
> +	Elf_Shdr *info_shdr;
> +	char *modinfo;
> =20
>  	info_idx =3D find_any_unique_sec(info, ".modinfo");
> =20

[Severity: High]
This is a pre-existing issue, but does the early return when info_idx is 0
leave us vulnerable if a module omits the .modinfo section completely?

When the subsequent early return for info_idx =3D=3D 0 is taken, info->inde=
x.info
remains 0. Subsequent calls to get_modinfo() will use info->sechdrs[0].
While elf_validity_cache_sechdrs() validates the size and addr of section 0,
it doesn't validate sh_offset:

kernel/module/main.c:elf_validity_cache_sechdrs()
        if (sechdrs[0].sh_type !=3D SHT_NULL
            || sechdrs[0].sh_size !=3D 0
            || sechdrs[0].sh_addr !=3D 0) {

When get_next_modinfo() processes this, it uses this unvalidated sh_offset
to calculate modinfo, which is immediately passed to strncmp():

kernel/module/main.c:get_next_modinfo()
        char *modinfo =3D (char *)info->hdr + infosec->sh_offset;
        ...
        for (p =3D modinfo; p; p =3D module_next_tag_pair(p, &size)) {
                if (strncmp(p, tag, taglen) =3D=3D 0 && p[taglen] =3D=3D '=
=3D')

Could this lead to an out-of-bounds read if sh_offset points outside valid
memory?

> @@ -2095,6 +2097,18 @@ static int elf_validity_cache_index_info(struct lo=
ad_info *info)
>  	}
> =20
>  	info->index.info =3D info_idx;
> +	info_shdr =3D &info->sechdrs[info_idx];
> +	modinfo =3D (char *)info->hdr + info_shdr->sh_offset;
> +
> +	if (info_shdr->sh_size =3D=3D 0) {
> +		pr_err("empty .modinfo section\n");
> +		return -ENOEXEC;
> +	}
> +	if (modinfo[info_shdr->sh_size - 1] !=3D '\0') {

[Severity: High]
This isn't a bug introduced by this patch, but does accessing modinfo here
pose a risk if the .modinfo section type is set to SHT_NOBITS?

In elf_validity_cache_sechdrs(), offset validation is explicitly skipped
for SHT_NOBITS sections:

kernel/module/main.c:elf_validity_cache_sechdrs()
        case SHT_NOBITS:
                /* No contents, offset/size don't mean anything */
                continue;

Since info_shdr->sh_size and sh_offset are unvalidated for these sections,
could modinfo[info_shdr->sh_size - 1] read from unmapped or arbitrary memor=
y?

> +		pr_err(".modinfo section isn't NUL terminated\n");
> +		return -ENOEXEC;
> +	}
> +
>  	/* Try to find a name early so we can log errors with a module name */
>  	info->name =3D get_modinfo(info, "name");
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728173318.6373=
6-1-acharyalaxman8848@gmail.com?part=3D1
