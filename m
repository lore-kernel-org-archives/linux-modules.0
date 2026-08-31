Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759A83BF677
	for <linux-modules@vger.kernel.org>; Mon, 31 Aug 2026 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162435; cv=none; b=Ngo81uGrPANjyDTW2/vwyqQJKgNvZ7SAjUvKT3d63FM3i5b+u4TIAzH79eD/6u9VHvLOYvICFYmSbaw+pRrpMLqPZzgMSVBElTFBHj83vkcTvMXpujkiEA8Se4dI0sdoMJ+M30RR5eLkMUuFnTj5PNrd+wsx4Vq7pVvnpaJC66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162435; c=relaxed/simple;
	bh=QFdyxRhpsg9kggc1hVee+VLj915JIyaWMBGUQHLvmoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J5Kz3keBt/LU5KtIJqDueifE66cjZqqM45Y67o83wJtpw5gMUxxD/TuKgkpvz+taHH1KsGHu0nzLAOK5p/47wi49T709jhph8NSc3IphxD0vv7prI6JzZYalqzTWmsJtLA1qbPvsftOb6/w1Ny5ec3et8Uk3xnbAM9nUBZEFkDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDS8mjCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDS8mjCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA391F000E9;
	Mon, 31 Aug 2026 07:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788162431;
	bh=/zivJ0slopkTEwbN9RhBJmA0bt5rqq6fiUj5G5Ilja0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDS8mjCkLgbxYnK2jn0n88qPPFrvNDbNqYPa0YU+T/YVc5fYBwCn8ZOjvbLh7xcdh
	 st5DilUdCxagxhpZekeOVfu9bY1fsEHA8AD3MmKkJPbE/HQemRQa+Ykr1PMvAOAq5F
	 eSn3peWWVutW6bselNLxSCT98SDA5M7yM8UASdKmMm3Rz8fLGLhaEzm6+ygVE0tqvc
	 Cyg4i3KHb2CYupXF7R55QUqsKIt/X+Ien4zTNjTvW3ddU104S1hvdZjAEK6kPzXf4s
	 WOI5LvsORMH2JVx+VW9zYG/D44wrHBB3GW5kFTUyjqXRJaTY9J/u3CL/3kg7BaogDJ
	 hRG9TZXERs46A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v6 2/2] module: allocate codetag sections before the
 regular module layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260831072104.120197-3-hao.ge@linux.dev>
References: <20260831072104.120197-1-hao.ge@linux.dev>
 <20260831072104.120197-3-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:47:11 +0000
Message-Id: <20260831074711.AAA391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Percpu counters are permanently leaked when a codetag section fall=
s back to regular module memory.
--

commit 67e030141d036ccecf172380286b7317fac48a51
Author: Hao Ge <hao.ge@linux.dev>

module: allocate codetag sections before the regular module layout

This patch moves codetag section allocation to occur before the regular
module layout and fails the load on allocation errors. However, on tag
area overflow, it gracefully falls back to allocating the codetag section
in regular module memory instead.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad06..da80f7c187921 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c

[ ... ]

> @@ -2951,9 +2906,48 @@ static bool blacklisted(const char *module_name)
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
> +		if (WARN_ON(!dest))
> +			return -EINVAL;
> +		if (dest =3D=3D ERR_PTR(-EAGAIN))
> +			/* Allocate the section as a regular section. */
> +			continue;

[Severity: High]
If reserve_module_tags() returns -EAGAIN due to reaching the tag addressable
limit, the module load proceeds by falling back to regular module memory.
However, does this cause a permanent percpu memory leak when the module is
eventually unloaded?

When the codetag section falls back to regular memory, the module is never
added to the mod_area_mt maple tree. Later, load_module() in mm/alloc_tag.c
unconditionally allocates percpu memory for all tags in the module:

mm/alloc_tag.c:load_module() {
    ...
    for (tag =3D start_tag; tag < stop_tag; tag++) {
        ...
        tag->counters =3D alloc_percpu(struct alloc_tag_counters);
    }
}

During unload, release_module_tags() attempts to free these counters. But
since the module was never added to the maple tree, it exits early before
cleaning up the counters:

mm/alloc_tag.c:release_module_tags() {
    ...
    mas_for_each_rev(&mas, val, 0)
        if (val =3D=3D mod)
            break;

    if (!val) /* module not found */
        goto out;
    ...
}

Will this cause all percpu counters allocated for this module to be leaked,
potentially leading to percpu memory exhaustion over time?

> +		if (IS_ERR(dest))
> +			return PTR_ERR(dest);
> +
> +		if (shdr->sh_type !=3D SHT_NOBITS)
> +			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
> +		shdr->sh_addr =3D (unsigned long)dest;
> +		shdr->sh_flags &=3D ~(unsigned long)SHF_ALLOC;
> +		shdr->sh_entsize =3D SH_ENTSIZE_STANDALONE;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831072104.1201=
97-1-hao.ge@linux.dev?part=3D2
