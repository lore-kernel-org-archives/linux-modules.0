Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB16133A71B
	for <linux-modules@vger.kernel.org>; Tue,  8 Sep 2026 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860857; cv=none; b=SlXUhE0K8sFMk3eOjvMahaBMG32Azm6FkhrrLZTXBJET6pl46xkufG95uKo8Js+DAVCdOTd7qoOhlcPHrj6RId9fM29NoelkDVbgHA/+KbWsjUjwsd8HYTA59gP/7EUi/SuBpsM55JWuOdCZVaaF20Gr4JvuABHPQPAsQNsz8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860857; c=relaxed/simple;
	bh=MMnQdsZ4IsnI/xRLvaw6PAvE5QdC3CzGLbQTSvyAT4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tnd9FHmMRwx3i80V9I3GngYii4Bc6WG7CiJPAU8MgXC0vXndgrbvVqMWfPsmo+AKM8GjqRt/BxJI5cK9sNuPCmddXHf7XqsUb1tWmJQWAYA7biPydoJb4z8HO7QgS2tDevDIkV3MSYhU14EeQ+RKkOWYNkgyA0pN4QUDq2X2etE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chna8MpT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chna8MpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1A61F00A3A;
	Tue,  8 Sep 2026 09:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788860856;
	bh=ktFykE1Cd5a0rUu6tW2CD1SUVG8bkkXtVtL6FAV7RIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=chna8MpTzK5qgwQ9rjU8GrIxInMLKthZLiCocDQQOWiulXm6d0hMO32usy+isLemw
	 xW3QJE7RyXjlwv6jjWH6VpAaKsWImoQCzd/2AVOu2oondDP7shxHASXaQ61p6tUJMS
	 +ilbNp90XkaL4FvUNBTdPMvjlPX4DG2OwE45w0Ckr9IKJgUMraQy4nfkh+EJ6cB4IE
	 XUrHw0jRqTpd8vIexvlit2Dx9K2wKsRWjxDFv1vd820FRSvVkRs98r9gFzp2EtN6PP
	 dlxd1+tknxK2qYoyA4bS52dZPZdRR62nb1+r2Vxt0wbnBqby5mEp22XwV8ALkxb78j
	 3JrCLrZM870pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/4] module: allocate codetag sections before the
 regular module layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260908092412.115953-5-hao.ge@linux.dev>
References: <20260908092412.115953-1-hao.ge@linux.dev>
 <20260908092412.115953-5-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 09:47:35 +0000
Message-Id: <20260908094736.2B1A61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Percpu counters are permanently leaked when module alloc_tags fall=
 back to regular module memory.
--

commit e3319858bb95e951205b0e09569d4ef2ec702635
Author: Hao Ge <hao.ge@linux.dev>

module: allocate codetag sections before the regular module layout

Whether a codetag section goes to the codetag region is decided by
layout_sections() and asked again in move_module(). A concurrent
load can shut profiling down in between, and move_module() then
copies the section to offset 0 of its regular destination,
overwriting whatever is there.

Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse=
.com/ [1]

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 15ad6c54bb1c3..f020293b3a496 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c

[ ... ]

> @@ -2947,6 +2908,49 @@ static bool blacklisted(const char *module_name)
>  }
>  core_param(module_blacklist, module_blacklist, charp, 0400);
> =20
> +/*
> + * Allocate codetag sections separately. They are loaded into preallocat=
ed
> + * contiguous memory because they may still be used after the module is
> + * unloaded.
> + *
> + * If the separate allocation overflows, allocate the section normally
> + * so that the module can still be loaded.
> + */
> +static int allocate_codetag_sections(struct load_info *info)
> +{
> +	for (unsigned int i =3D 1; i < info->hdr->e_shnum; i++) {
> +		Elf_Shdr *shdr =3D &info->sechdrs[i];
> +		const char *sname =3D info->secstrings + shdr->sh_name;
> +		void *dest;
> +
> +		if (!codetag_needs_module_section(info->mod, sname, shdr->sh_size))
> +			continue;
> +
> +		dest =3D codetag_alloc_module_section(info->mod, sname, shdr->sh_size,
> +				arch_mod_section_prepend(info->mod, i), shdr->sh_addralign);
> +		if (WARN_ON(!dest)) {
> +			codetag_free_module_sections(info->mod);
> +			return -EINVAL;
> +		}
> +		if (dest =3D=3D ERR_PTR(-EAGAIN))
> +			/* Allocate the section as a regular section. */
> +			continue;

[Severity: High]
Does this error fallback path lead to a permanent percpu memory leak?

When the dedicated tag memory area is full and tags_addressable() returns
false, reserve_module_tags() returns -EAGAIN. This code bypasses the error =
via
continue, falling back to allocating the .alloc_tags section as a regular
module data section instead of failing the module load.

However, mm/alloc_tag.c:load_module() still unconditionally allocates percpu
counters for these tags:

    tag->counters =3D alloc_percpu(struct alloc_tag_counters);

When the module later unloads, mm/alloc_tag.c:release_module_tags() attempts
to clean up:

    if (!val) /* module not found */
        goto out;

Since the module's tags fell back to regular memory, the module is not found
in the mod_area_mt maple tree, and release_module_tags() immediately return=
s.
This skips clean_unused_counters() and appears to permanently leak the perc=
pu
counters for every tag in the module.

Could this eventual exhaustion of percpu memory be avoided by either skippi=
ng
the percpu allocation or ensuring the cleanup logic can find modules that f=
ell
back to regular memory?

> +		if (IS_ERR(dest)) {
> +			codetag_free_module_sections(info->mod);
> +			return PTR_ERR(dest);
> +		}
> +
> +		if (shdr->sh_type !=3D SHT_NOBITS)
> +			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
> +		else
> +			memset(dest, 0, shdr->sh_size);
> +		shdr->sh_addr =3D (unsigned long)dest;
> +		shdr->sh_entsize =3D SH_ENTSIZE_STANDALONE;
> +	}
> +
> +	return 0;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908092412.1159=
53-1-hao.ge@linux.dev?part=3D4
