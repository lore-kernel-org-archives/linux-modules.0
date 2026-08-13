Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375D3A7F57
	for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614898; cv=none; b=bGJNf8Z88ainYSVN4J+ZW+EIxGQ3Ie6vo6FLjsioBSIOuTbd6jTYmW/FHhmzuM0JerFwag6tUHMdjlFIrOQPsEkpexsQNHfnTaGZD64UNAd3Rjnhv6k3YuOfypi6sJL5s67DEzq75duHg/k7mz7157tb1tXQIppTr/jvcAPRA88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614898; c=relaxed/simple;
	bh=6aFYd2kSlYZjfvezvQxBX96rPjTrd67QNg9Mj+OJSrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pArOQPNYGZ0RZInRjHJu1leeLrURzybP57g9HJLmxVDATCJp+ClW7Z9gedbMylduMu64iIAuX9h9Wo6mu55hqwx/Oc28LmtaNW42wpKZe4tqRz4fVEdexGO6t1ubbft6QPwTCdqk2H5FG4U3Rf5I9nUcJAMnHvGz+BFxx0tOFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PESBlgwE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PESBlgwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563E01F000E9;
	Thu, 13 Aug 2026 09:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614896;
	bh=KDSe1dU9CAYRK3rIhCHJugg8ruMj6jquBhcdnpJG/MM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PESBlgwEoo2/KvI8MZvomlF63LRgSYQnjf6w7xKzuPJ5CQ2zGv3mTxrB2V1+VwJrd
	 INzzEOFXf3J6WlqzANKzc2PjR9/3C3pWslTyrkkIECs2fTxJMaPifhCNeqahguUoh8
	 7l+qysGrdxyZ751a0dNimkkltQVHnMOGSEHy5J539sguilEKtSWW0OdBSS1g6vJCl8
	 6z9AK9k5YS2fXiwnWJcSpmA7QHsWrKL8wR+WCf8+3o9tfqU7t+n5HbU1GMY69map9o
	 vWYS5ta40LKd6hfxDvw5dW13jYxcKapeRdToMCXgB8LJpmYqrP42oS0ySH3NvfsAHz
	 o3g0C3R0uqxvw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] module: move codetag section placement decision
 to layout_sections()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260813093421.135230-3-hao.ge@linux.dev>
References: <20260813093421.135230-1-hao.ge@linux.dev>
 <20260813093421.135230-3-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 09:54:55 +0000
Message-Id: <20260813095456.563E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] An integer overflow in ALIGN() using unvalidated sh_addralign allo=
ws an attacker to spoof the memory type stored in sh_entsize, leading to an=
 out-of-bounds read and kernel panic.
--

--- Patch [2]: [RFC PATCH 2/3] module: move codetag section placement decis=
ion to layout_sections() ---
commit f621cb3d3b6809c9dd569a1f5e20bfb1e929c4d4
Author: Hao Ge <hao.ge@linux.dev>

module: move codetag section placement decision to layout_sections()

This commit moves the decision for codetag section placement to
layout_sections(), storing the result in sh_entsize using the new
MOD_MEM_CODETAG type. The move_module() function now relies on this stored
type instead of calling codetag_needs_module_section() again. This prevents
a race condition when profiling support is toggled during module load.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a6058..25056e87d0038 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
[ ... ]
> @@ -2815,11 +2812,10 @@ static int move_module(struct module *mod, struct=
 load_info *info)
>  			continue;
> =20
>  		sname =3D info->secstrings + shdr->sh_name;
> -		/*
> -		 * Load codetag sections separately as they might still be used
> -		 * after module unload.
> -		 */
> -		if (codetag_needs_module_section(mod, sname, shdr->sh_size)) {
> +
> +		enum mod_mem_type type =3D shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
> +
> +		if (type =3D=3D MOD_MEM_CODETAG) {

[Severity: High]
Can a maliciously crafted ELF module spoof the type by causing an integer
overflow in module_get_offset_and_type()?

If a module with two SHT_NOBITS sections is loaded, it might bypass ELF file
size validations. The first section could inflate mod->mem[MOD_DATA].size to
0x60000001. If the second section has sh_addralign =3D 0x10000000, it would
cause an integer overflow in module_get_offset_and_type():

kernel/module/main.c:module_get_offset_and_type() {
    ...
    offset =3D ALIGN(mod->mem[type].size, sechdr->sh_addralign ?: 1);
    ...
    return offset | mask;
}

The overflowed offset (0x70000000) places 7 (MOD_MEM_CODETAG) into the top 4
bits of sh_entsize. By setting the second section's sh_size to 0x90000000,
the attacker can wrap mod->mem[MOD_DATA].size back to 0, avoiding -ENOMEM
during module_memory_alloc().

If this spoofed type is trusted by move_module(), execution routes to
codetag_alloc_module_section():

lib/codetag.c:codetag_alloc_module_section() {
    ...
    const char *type_name =3D name + strlen(CODETAG_SECTION_PREFIX);
    ...
}

If a short-named section is routed here by the spoofed type, could blindly
advancing the name pointer cause an out-of-bounds read past the secstrings
vmalloc allocation and trigger a kernel panic?

>  			dest =3D codetag_alloc_module_section(mod, sname, shdr->sh_size,
>  					arch_mod_section_prepend(mod, i), shdr->sh_addralign);
>  			if (WARN_ON(!dest)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813093421.1352=
30-1-hao.ge@linux.dev?part=3D2
