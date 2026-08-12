Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E72D7398
	for <linux-modules@vger.kernel.org>; Wed, 12 Aug 2026 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514653; cv=none; b=mGKyn2G/kaLX2sPmeaoZASTctrrB7DCDIlWoydzCJHqehFTw5HafitTtoxqK8tB+GrqFz0ZgaSI3seQO4GOoH4SAfPavrf8cvkXCqevVHeBUIZth3PfjkhMfYgfigdquL6ir/D6zcM21xs0w2b8/a4S6OXLOP/rSvzCXC4RnZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514653; c=relaxed/simple;
	bh=zNHfLTdM0JClurQOC9s06F+97a5m/9Q5M6QCDzpTuqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rmx6/VvUNBbOYvWO6qPwF8HLf42jdDymCtzzDsQhH4zfU0BX6SdavWFqL9ERQS2frAwu3T5ohWQ0Qvudms2fsmXJiMD1sbqyZket7LwfVb0PDvfPcGBiq18xX/s6mCTnvp1sQeK+LdPskezlsBULEFFIVDQb6SqY1tesZru++T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVMj0Qfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVMj0Qfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968631F000E9;
	Wed, 12 Aug 2026 06:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786514651;
	bh=iVuFaVw0wifSNVVYsDKsrG/qGBiy9nbNKZtwwZoXJZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MVMj0Qfx0LEXWLhlodLyXKURM27wBpzgMSz3JrXYL3jYC7983AmBqhslUgFdH5N6E
	 p6a2nA7FlXhsOoqsuOYO6sXYzLehOQUwMkZWnfAiouVgePFP/gt0afDc9+KG1+cjsF
	 lRjo4Hq05QNdkDPY9VH24Sk8sgKLdW1KZc64aX61tliTPaU9U5u4ACuW9/WaC+relc
	 T+prebkEBGS8F9dHfhR+EXEX/T8W5BQ6J76PzBSrrvUfq+2EE/vjuu5ABtUqcjOhhB
	 NBEkuum379mB7f0tmzZxd2th8P7FbZtt+fOTFbGmQ25fjHsM3emp4Cf/Xae98bv87I
	 WUX8UdJiDdWqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] alloc_tag: fix undetected compressed tag
 overflow when profiling is disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260812054105.102637-3-hao.ge@linux.dev>
References: <20260812054105.102637-1-hao.ge@linux.dev>
 <20260812054105.102637-3-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 06:04:11 +0000
Message-Id: <20260812060411.968631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unconditional allocation of per-CPU counters for modules causes a =
memory leak when memory profiling is disabled and the module load is retrie=
d.

Pre-existing issues:
- [Critical] Concurrent module loading can cause an out-of-bounds memory wr=
ite and module corruption because the global profiling flag is toggled with=
out cross-phase synchronization.
- [High] A race condition on the global module tags size variable can lead =
to unmapped virtual memory access and a kernel panic.
- [High] If page population fails, a dangling module pointer is left in the=
 maple tree, leading to a Use-After-Free.
--

--- Patch [2]: [PATCH v5 2/2] alloc_tag: fix undetected compressed tag over=
flow when profiling is disabled ---
commit ffb2b208763f32cdfb3d6cb740d4d4efa5c99ae0
Author: Hao Ge <hao.ge@linux.dev>

alloc_tag: fix undetected compressed tag overflow when profiling is disabled

This patch modifies module layout and allocation to retry loading without
memory profiling if the compressed tag limit is exceeded. It removes the
profiling enabled guard when checking for tag overflow and handles the
fallback by resetting section flags and repeating the layout process.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c

[ ... ]

> @@ -2966,18 +2967,38 @@ static struct module *layout_and_allocate(struct =
load_info *info, int flags)
>  	 */
>  	module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstrings);
> =20
> +	/*
> +	 * Save the sizes reserved by module_frob_arch_sections() so they can
> +	 * be restored if we retry below.
> +	 */
> +	for_each_mod_mem_type(type)
> +		frob_size[type] =3D info->mod->mem[type].size;
> +
>  	/*
>  	 * Determine total sizes, and put offsets in sh_entsize.  For now
>  	 * this is done generically; there doesn't appear to be any
>  	 * special cases for the architectures.
>  	 */
> +retry:
>  	layout_sections(info->mod, info);
>  	layout_symtab(info->mod, info);
> =20
>  	/* Allocate and move to the final place */
>  	err =3D move_module(info->mod, info);

[Severity: Critical]
This isn't a bug introduced by this patch, but can concurrent module loading
cause memory corruption if profiling is disabled mid-flight?

In move_module(), if one thread disables profiling globally via
shutdown_mem_profiling() while another thread is halfway through module
loading (between layout calculation and memory movement), the second thread=
's
section offset queries could evaluate to false.

This would cause the module loader to use an un-incremented 0 offset and
incorrectly write the codetag section into the base memory, overwriting the
start of the module's core memory block.

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
> +			info->mod->mem[type].size =3D frob_size[type];
> +		info->sechdrs[info->index.sym].sh_flags &=3D ~(unsigned long)SHF_ALLOC;
> +		info->sechdrs[info->index.str].sh_flags &=3D ~(unsigned long)SHF_ALLOC;
> +		goto retry;

[Severity: High]
Does this retry mechanism cause a memory leak for per-CPU counters?

When the module load is retried via this new loop, the codetag section is
treated as standard memory and bypasses maple tree registration. However, t=
he
subsequent codetag module initialization unconditionally allocates per-CPU
memory for these tags regardless of the profiling state.

During module unload in release_module_tags(), the cleanup path exits early
because the module cannot be found in the maple tree, permanently leaking
the per-CPU memory on every unload.

> +	}
> =20
>  	/* Module has been copied to its final place now: return it. */
>  	mod =3D (void *)info->sechdrs[info->index.mod].sh_addr;

> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c

[ ... ]

> @@ -950,10 +950,12 @@ static void *reserve_module_tags(struct module *mod=
, unsigned long size,
>  		int grow_res;
> =20
>  		module_tags.size =3D offset + size;

[Severity: High]
This is a pre-existing issue, but does the update to module_tags.size race
with concurrent module loads?

The high-water mark for the module tags size is updated here without a lock
after the maple tree lock is released. If two concurrent module loads race =
on
this update, a higher offset might be overwritten by a smaller one.

Subsequently, vm_module_tags_populate() relies on this corrupted size and
would fail to map the physical pages for the higher virtual addresses, lead=
ing
to a page fault when the module accesses its allocated tags.

> -		if (mem_alloc_profiling_enabled() && !tags_addressable()) {
> +		if (!tags_addressable()) {
>  			shutdown_mem_profiling(true);
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

[Severity: High]
This is a pre-existing issue, but could this lead to a dangling pointer in
the maple tree if page population fails?

If vm_module_tags_populate() fails and returns an error, the allocation
routine returns an error here but doesn't remove the newly inserted module
pointer from the maple tree.

Since this error bypasses the standard codetag cleanup routines in the modu=
le
loader (where codetag_section_found might remain false in move_module()),
the maple tree retains a pointer to the aborted module. Once the module
structure is freed, future maple tree iterations could dereference this fre=
ed
pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812054105.1026=
37-1-hao.ge@linux.dev?part=3D2
