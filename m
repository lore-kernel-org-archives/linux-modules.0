Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3723EB815
	for <linux-modules@vger.kernel.org>; Wed,  2 Sep 2026 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338213; cv=none; b=RhPvZN2s1KF1HHRzqm+xxUEavbmwSDGb7425sgh9j97LV775qi7LkZtQ3aJwyf0xK6YbqSp9/Oq2UCRQqKi0X+TWApxLrE8sX7nlAuabqpIb2RDSc4rAWVQvIS3G2wkljxBlt9ZuXC/CMrxm0cukZiC2tMt2QeXXF2270n2ehZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338213; c=relaxed/simple;
	bh=0mDHTp2X+F2xTEACYoBMrw7VdhvDUT3aIb9cXVfTA7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g1HaTfHL+jPvqo44CnNoKe4R073BrdAZyPNfgynerUyCLBSXQHk/lFphzK76QB5km9e+RW2fP3oRpekBkPXMvoAzRiiTptLksNeYGJ6387tCvkAnru2kCoIBVRUa8nfvwBv8hmjDxaxbYIf1odaNPcbpflUQP86MmMMYZkalhUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ius+HJAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ius+HJAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3BD1F00A3D;
	Wed,  2 Sep 2026 08:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788338212;
	bh=o1AQi75AZCjMhi19hGIJgZ+8BureuZIg30Gucv+6bNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ius+HJAzfSYzlFLSZE072gmJy4Ws2JVUYwHI/DiHMjjJeaZ3t2vhe4MinLEAgo2JV
	 YOFe7lazT4JU56eeGNOE3NR1TW83O7lF+I98K7hELGw6WU0PYKDkWALsz0AgJyIohK
	 yx+R62YRSYS/q1Ycv3qDuwAZRk62RB3rWdBbm7KttvUUkXC6MCklt9UQs2ltoWPgnG
	 nmf7ImRqi9EIfaWqT4B+PCd0U5bZz0N86MQ12/dhTrv5qwAFXz0yUs6QA2aTM7b3CQ
	 VBE35FSP12zK0zhLW2ChSO9uNmhDfZ9yjjMq7tnxp3ApmGfjBEhV56WzHzO447S+/s
	 nLfgGWWscWDBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] module: allocate codetag sections before the
 regular module layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260902081802.146145-4-hao.ge@linux.dev>
References: <20260902081802.146145-1-hao.ge@linux.dev>
 <20260902081802.146145-4-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 08:36:51 +0000
Message-Id: <20260902083652.2C3BD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Per-CPU memory leak of module allocation tag counters on module un=
load when falling back to regular section allocation.
- [Medium] Skipping memcpy for SHT_NOBITS codetag sections leaves them fill=
ed with uninitialized kernel memory.

Pre-existing issues:
- [High] AB-BA deadlock between `/proc/allocinfo` file readers (`pde->in_us=
e`) and module loading (`cttype->mod_lock`).
--

commit 073ca6b0680c884f9d863cdcbd7d5db665a17c3b
Author: Hao Ge <hao.ge@linux.dev>

module: allocate codetag sections before the regular module layout

Whether a codetag section goes to the codetag region is decided by
layout_sections() and asked again in move_module(). A concurrent
load can shut profiling down in between, and move_module() then
copies the section to offset 0 of its regular destination,
overwriting whatever is there.

Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse=
.com/

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index b114b815187a9..b94830c5b9a10 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c

[ ... ]

> @@ -2940,6 +2901,47 @@ static bool blacklisted(const char *module_name)
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
Does this code leak the per-cpu memory on module unload when falling back to
regular section allocation?

If tags_addressable() returns false, reserve_module_tags() returns -EAGAIN
and removes the module from mod_area_mt. The fallback mechanism here alloca=
tes
the tags in regular module memory, but the module loading process still
unconditionally allocates per-cpu counters for each tag, oblivious to the
fallback or the disabled profiling state:

    for (tag =3D start_tag; tag < stop_tag; tag++) {
        WARN_ON(tag->counters);
        tag->counters =3D alloc_percpu(struct alloc_tag_counters);

On unload, release_module_tags() fails to find the module in mod_area_mt
because it was removed, skipping clean_unused_counters() and leaking the
previously allocated per-cpu memory.

> +		if (IS_ERR(dest)) {
> +			codetag_free_module_sections(info->mod);
> +			return PTR_ERR(dest);
> +		}
> +
> +		if (shdr->sh_type !=3D SHT_NOBITS)
> +			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);

[Severity: Medium]
Could this expose uninitialized kernel memory if the codetag section is
parsed from an ELF module with the SHT_NOBITS type?

The code skips memcpy() but fails to use memset() to zero-initialize the
destination buffer. Regular module sections are safe because
module_memory_alloc() explicitly zeroes them, but reserve_module_tags() bac=
ks
its memory with alloc_pages_bulk_node() without the __GFP_ZERO flag:

mm/alloc_tag.c:vm_module_tags_populate() {
...
    allocated =3D alloc_pages_bulk_node(GFP_KERNEL | __GFP_NOWARN,
            NUMA_NO_NODE, more_pages - nr, next_page + nr);
...
}

> +		shdr->sh_addr =3D (unsigned long)dest;
> +		shdr->sh_entsize =3D SH_ENTSIZE_STANDALONE;
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 2070e682fe106..112a014d4b890 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -950,10 +950,12 @@ static void *reserve_module_tags(struct module *mod=
, unsigned long size,
>  		int grow_res;
> =20
>  		module_tags.size =3D offset + size;
> -		if (mem_alloc_profiling_enabled() && !tags_addressable()) {
> +		if (!tags_addressable()) {
>  			shutdown_mem_profiling(true);

[Severity: High]
This is a pre-existing issue, but does this shutdown_mem_profiling(true) ca=
ll
introduce an AB-BA deadlock between /proc/allocinfo file readers (pde->in_u=
se)
and module loading (cttype->mod_lock)?

A user reading /proc/allocinfo acquires the procfs in_use reference in
use_pde(), then blocks on down_read(&alloc_tag_cttype->mod_lock) in
allocinfo_start().

Concurrently, if a module loads and tags_addressable() fails,
codetag_alloc_module_section() holds down_write(&cttype->mod_lock) and calls
shutdown_mem_profiling(true), which removes the proc entry. This removal wa=
its
indefinitely for the in_use reference to drop to zero, hanging both procfs
reads and module loading.

> -			pr_warn("With module %s there are too many tags to fit in %d page fla=
g bits. Memory allocation profiling is disabled!\n",
> -				mod->name, NR_UNUSED_PAGEFLAG_BITS);
> +			pr_warn_once("With module %s there are too many tags to fit in %d pag=
e flag bits. Memory allocation profiling is disabled!\n",
> +				     mod->name, NR_UNUSED_PAGEFLAG_BITS);
> +			release_module_tags(mod, false);
> +			return ERR_PTR(-EAGAIN);
>  		}
> =20
>  		grow_res =3D vm_module_tags_populate();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902081802.1461=
45-1-hao.ge@linux.dev?part=3D3
