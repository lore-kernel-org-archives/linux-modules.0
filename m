Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825433822BB
	for <linux-modules@vger.kernel.org>; Wed,  2 Sep 2026 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338314; cv=none; b=QLuw0U4Av1F3sQcn3ca1SfgiWUH/xFGm9d2cQXVIDmN/9hDA36zMWSlqxIhPfqC007DO2v4YGcnQPtQCR64qWhiQorhW/dejT+z7yCrvFhuWY42NDIV2kjabKrUTInuS8cPJlsfydxvPxKjPTHKlyruiO+p+Awt0ikcrTcezDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338314; c=relaxed/simple;
	bh=gDuZcGRuqftgvZ20Cjm8Xa8y5JLI2NNpVmvFUewLrd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BfgCsMUxsLywZuuMvABH7N+p3jMNTCz8CdsXSIH/encwJAX8dMADZcnB/XO9JrvTzgbEN2q8tjvp9yxCCg+8VUSt3gII4PBGjINYic6LSL9n32Q5i6ZaAFPs7HtgzO56GFicev1lqbCVRFfPCvg1qm6lEVXFqtmHD2KEFs2x6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBvGmYRM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBvGmYRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2131F000E9;
	Wed,  2 Sep 2026 08:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788338313;
	bh=AWfBtkGxsEYfQMcPa2cLDrXsWrkKLVclOKf8SGKssk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BBvGmYRMq9fcD8Yos6hmcJ8S4FHOmCmbLoZ2fszm9BvIc+Lub/eBBLlyVEgxfMaLv
	 KQiKBRLo3mpncQrgDVwdglC4/rdUfgvS/nZBBxW4WzkKruowVwTLq1XpIPi59CMgeh
	 aJqZou+o5ZvVoD9Qe+ElTwroxzwIEboFhpW3B8YOXe20dQUP6hPLtyM4DdBmhj9gpB
	 olupY0KqAfoshDn+/KbLKLUWAbFzxnalANtkf8MUQXgrkbawPOtmt1MEH2v/n4wpp+
	 794LwcUXR1H09odU6kAdAweIVi8fPGcqfTB52JvLHiqTtub+qP/7AGrb9s0dK8JAid
	 /c02rS4r/Ex4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] alloc_tag: release the reservation when populate
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260902081802.146145-5-hao.ge@linux.dev>
References: <20260902081802.146145-1-hao.ge@linux.dev>
 <20260902081802.146145-5-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 08:38:32 +0000
Message-Id: <20260902083832.DC2131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing page table teardown on vmap_pages_range() failure in v=
m_module_tags_populate() creates dangling PTEs pointing to freed physical m=
emory.
- [High] Failure to revert `module_tags.size` after `vm_module_tags_populat=
e()` fails creates a race condition that can return unmapped memory to the =
module loader, leading to a kernel crash.
- [High] Lockless race between alloc_tag_sub() and clean_unused_counters() =
causes use-after-free on per-CPU counters.
--

commit d4d7fb3ee0094651ba53e0f489d27eaa1b6cc2af
Author: Hao Ge <hao.ge@linux.dev>
Subject: alloc_tag: release the reservation when populate fails

This patch updates reserve_module_tags() to call release_module_tags()
when vm_module_tags_populate() fails. This ensures the module tags
reservation is correctly released on error paths.

> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 112a014d4b890..c11813cd9e153 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -963,6 +963,7 @@ static void *reserve_module_tags(struct module *mod, =
unsigned long size,
>  			shutdown_mem_profiling(true);
>  			pr_err("Failed to allocate memory for allocation tags in the module %=
s. Memory allocation profiling is disabled!\n",
>  			       mod->name);
> +			release_module_tags(mod, false);
>  			return ERR_PTR(grow_res);
>  		}
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
module_tags.size to remain inflated here on error?

Earlier in reserve_module_tags(), module_tags.size is optimistically
updated:

	if (module_tags.size < offset + size) {
		int grow_res;

		module_tags.size =3D offset + size;
		[...]
		grow_res =3D vm_module_tags_populate();

If vm_module_tags_populate() fails, the error path calls
shutdown_mem_profiling() and releases the module tags, but it does not
revert module_tags.size.

Can a second thread loading a different module concurrently evaluate
codetag_needs_module_section() as true just before shutdown_mem_profiling()
disables profiling?

If this second thread enters reserve_module_tags(), it might find the newly
freed space at the same offset in the maple tree. Because module_tags.size
was left inflated, would the check "if (module_tags.size < offset + size)"
evaluate to false, causing the second thread to skip
vm_module_tags_populate()?

This could result in returning a pointer to unmapped virtual memory to the
module loader, leading to a kernel crash when the loader subsequently calls
memcpy() on this pointer.


[Severity: Critical]
This is a pre-existing issue, but does vm_module_tags_populate() clean up
page tables correctly when it fails?

Looking at vm_module_tags_populate(), physical pages are mapped using
vmap_pages_range():

		if (nr < more_pages ||
		    vmap_pages_range(phys_end, phys_end + (nr << PAGE_SHIFT),
				     PAGE_KERNEL, next_page, PAGE_SHIFT) < 0) {
			release_pages_arg arg =3D { .pages =3D next_page };

			/* Clean up and error out */
			release_pages(arg, nr);
			return -ENOMEM;
		}

If vmap_pages_range() fails midway through, it returns a negative error code
but does not unmap the pages it already successfully mapped.

The error handler unconditionally calls release_pages(arg, nr) to return the
physical pages to the allocator, but it fails to call vunmap_range() to
clear the kernel page table entries.

Does this leave valid, writable kernel PTEs pointing to freed physical
memory? If these physical pages are reallocated to other subsystems, could a
subsequent write to the module_tags virtual memory region silently corrupt
unrelated kernel memory?


[Severity: High]
This is also a pre-existing issue, but is there a lockless race between
alloc_tag_sub() and clean_unused_counters() that could cause a
use-after-free?

When an object allocated by a module is freed, alloc_tag_sub() locklessly
decrements the profiling counters:

	this_cpu_sub(tag->counters->bytes, bytes);
	this_cpu_dec(tag->counters->calls);

Concurrently, another module load or unload may trigger
clean_unused_counters(), which checks if the counters are completely unused
based solely on the bytes counter:

		counter =3D alloc_tag_read(tag);
		if (!counter.bytes) {
			free_percpu(tag->counters);
			tag->counters =3D NULL;

If a thread executing alloc_tag_sub() is preempted or interrupted after
this_cpu_sub() but before this_cpu_dec(), the global sum of bytes could
reach 0 while the calls counter decrement is still pending.

Seeing bytes =3D=3D 0, clean_unused_counters() could immediately call
free_percpu(tag->counters).

When the preempted thread resumes, would it attempt to execute
this_cpu_dec(tag->counters->calls) on the freed memory, causing a
use-after-free that corrupts the per-CPU allocator state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902081802.1461=
45-1-hao.ge@linux.dev?part=3D4
