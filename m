Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2083B8D48
	for <linux-modules@vger.kernel.org>; Mon, 10 Aug 2026 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356238; cv=none; b=byrMUKEJZM+paTImuuo2dzPXIy6lqAjqw2CFlS6rx9lIE6+SZM8pmaMbNX02gcojo81eYYrvuZ9QsY5d53pOChtmxvoKI0iFQY6pG5AYVlo5GvpbJoYRWIV0Ns6H9xHwELG2RfxogAHJoRXua8pFGBFFxI8y2hfZ0JuORuSFD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356238; c=relaxed/simple;
	bh=62Y0NZyfpMChwBjoIpxHB9oDDVZOXcSprGVr8Gr28O8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dfizD2bV1izRLefC/4U8esVW+zxKgEsD2Ot2i4ecq8yTkPVhH6Qpkp8P9IhzJjZvg22UFq2StUy+1Q5LSdgrInF8nge1RA888UuEbJ/gcEpRAzZMVPjD4weyculH1Q1Yj0PMiLSe64nUot2z0INaO5Ur2UYJalYZJzbIdimHU44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbzQLZUO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbzQLZUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E791F000E9;
	Mon, 10 Aug 2026 10:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786356237;
	bh=OSAy6ar/xFhKUO+SZvGEyWs1CJbEkLYDXyGlpLHjDuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LbzQLZUOPSkHEP1ikJvHyLlMgiXGalsE1S31aha+KZRDtmiNbIKdoJhs3TKjzfwbv
	 8WF9bdFle+JHmqWnsgn53JMUaiACNkFEIItY4vkjpGIJqU/jPQLcp2EAShyDOCIOTd
	 861bPAtQ8Q31WmP/Gi9teB4wJEAr+utH6YT7p5ESINPFbcfoYOY4UKY7mgh6jLEK6d
	 d+skh702IbOBquASlwleUJbanom/zQqLZHZBZQPryEEc5jMB8WHm8FCBG4LGqbZX0f
	 NvquAyZBqtJ7gqJq6OPj061ibCSR8gfXnHneG2VxJAW8p2dvjCAeC+NGJjboQPBGjR
	 HcQ1DUsX4IvZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] alloc_tag: fix undetected compressed tag
 overflow when profiling is disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260810093955.153015-3-hao.ge@linux.dev>
References: <20260810093955.153015-1-hao.ge@linux.dev>
 <20260810093955.153015-3-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:03:56 +0000
Message-Id: <20260810100356.B4E791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Skipping `tag->counters` allocation leads to invalid memory access=
 (garbage reads or crashes) when reading tags.
- [High] The retry loop skips `module_frob_arch_sections()`, causing module=
 memory corruption on architectures that allocate space inside it.

Pre-existing issues:
- [High] Concurrent module loading can lead to silent module memory corrupt=
ion if allocation profiling is dynamically disabled.
--

--- Patch [2]: [PATCH v4 2/2] alloc_tag: fix undetected compressed tag over=
flow when profiling is disabled ---
commit 9e076bfe2df23289b04f8850ce26739d08894c81
Author: Hao Ge <hao.ge@linux.dev>

alloc_tag: fix undetected compressed tag overflow when profiling is disabled

This commit removes the mem_alloc_profiling_enabled() guard when checking f=
or
tag overflows in reserve_module_tags(). If an overflow occurs, it shuts down
profiling and uses an -EAGAIN retry loop in layout_and_allocate() to load t=
he
module without profiling. It also skips allocating per-cpu counters if prof=
iling
is disabled.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a6058..c32bb47a573a1 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
[ ... ]
> @@ -2971,13 +2971,26 @@ static struct module *layout_and_allocate(struct =
load_info *info, int flags)
>  	 * this is done generically; there doesn't appear to be any
>  	 * special cases for the architectures.
>  	 */
> +retry:
>  	layout_sections(info->mod, info);
>  	layout_symtab(info->mod, info);
> =20
>  	/* Allocate and move to the final place */
>  	err =3D move_module(info->mod, info);

[Severity: High]
This isn't a bug introduced by this patch, but could concurrent module load=
ing
lead to silent memory corruption if allocation profiling is dynamically
disabled?

When two modules load concurrently, Module A might calculate section offsets
in layout_sections() while mem_profiling_support is true. Its .alloc_tags
section gets a 0 offset since codetag_needs_module_section() evaluates to
true.

Concurrently, Module B might trigger a tag overflow in reserve_module_tags(=
),
which calls shutdown_mem_profiling() and sets mem_profiling_support to false
locklessly.

When Module A reaches move_module(), codetag_needs_module_section() now
evaluates to false. Does this cause the fallback path to place the section
at offset 0 within the module's core memory block, overwriting the first
valid section?

> -	if (err)
> -		return ERR_PTR(err);
> +	if (err) {
> +		if (err !=3D -EAGAIN)
> +			return ERR_PTR(err);
> +		/*
> +		 * -EAGAIN means profiling was disabled but the module
> +		 * can still load without it. Reset state and retry.
> +		 */
> +		rewrite_section_headers(info, flags);
> +		for_each_mod_mem_type(type)
> +			info->mod->mem[type].size =3D 0;
> +		info->sechdrs[info->index.sym].sh_flags &=3D ~(unsigned long)SHF_ALLOC;
> +		info->sechdrs[info->index.str].sh_flags &=3D ~(unsigned long)SHF_ALLOC;
> +		goto retry;

[Severity: High]
Since the retry loop zeroes mod->mem[type].size and jumps to the retry labe=
l,
does it skip module_frob_arch_sections() which was called earlier in
layout_and_allocate()?

Architectures like s390 use module_frob_arch_sections() to reserve space at
the beginning of MOD_TEXT by modifying mod->mem[MOD_TEXT].size and caching
offsets:

arch/s390/kernel/module.c:module_frob_arch_sections() {
    ...
    mod_mem =3D &me->mem[MOD_TEXT];
    mod_mem->size =3D ALIGN(mod_mem->size, 4);
    me->arch.got_offset =3D mod_mem->size;
    mod_mem->size +=3D me->arch.got_size;
    ...
}

Will skipping this initialization on retry cause the architecture loader to
place normal ELF sections at offset 0, and then overwrite the executable
.text section later during relocation using the cached offsets?

> +	}
> =20
>  	/* Module has been copied to its final place now: return it. */
>  	mod =3D (void *)info->sechdrs[info->index.mod].sh_addr;
[ ... ]
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 96a9196635fea..3c81ec7988860 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
[ ... ]
> @@ -633,6 +635,9 @@ static int load_module(struct module *mod, struct cod=
etag *start, struct codetag
>  	struct alloc_tag *stop_tag;
>  	struct alloc_tag *tag;
> =20
> +	if (!mem_profiling_support)
> +		return 0;

[Severity: High]
If we return 0 here, does it skip allocating tag->counters while still
allowing the module to load with its .alloc_tags section processed as
regular data?

Later, when show_mem() is triggered or /proc/allocinfo is read,
alloc_tag_top_users() unconditionally iterates over the global tags:

mm/alloc_tag.c:alloc_tag_top_users() {
    ...
    while ((ct =3D codetag_next_ct(&iter))) {
        struct alloc_tag_counters counter =3D alloc_tag_read(ct_to_alloc_ta=
g(ct));
    ...
}

Will calling alloc_tag_read() dereference the NULL counter?

include/linux/alloc_tag.h:alloc_tag_read() {
    ...
    counter =3D per_cpu_ptr(tag->counters, cpu);
    v.bytes +=3D counter->bytes;
    ...
}

Because per_cpu_ptr doesn't check for NULL, won't this add the per-cpu
offset to 0 and attempt to read unmapped memory or garbage data, causing a
kernel crash?

> +
>  	/* percpu counters for core allocations are already statically allocate=
d */
>  	if (!mod)
>  		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810093955.1530=
15-1-hao.ge@linux.dev?part=3D2
