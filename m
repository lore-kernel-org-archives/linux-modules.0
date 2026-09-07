Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750CA17BED0
	for <linux-modules@vger.kernel.org>; Mon,  7 Sep 2026 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763418; cv=none; b=noeX5emSvB6xW2IbQndgyQ47z24LaBjKWqpLncXZzwGTi8y2xaLsCiqCPXADO2VD1JEkAzMorvqh66Gs2ph7PGjBLg6mAjXe2guSavrCXLhZtC0KYLqC8x8M4exWxN4TRVBr4SXxfkZAzo2dgC4s4j6BS4WGIaM0QgZv6LkYwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763418; c=relaxed/simple;
	bh=GY5KbA4OXdkw4gQqJfn10i59zYDYq+2M8PqOMTHXlDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mY41lcssgJMfcOxQe6rRqxDz9FGz5+JIM9knI2zNkJnia22Jw3Ui1IwVv0/57cYyI47zZJ2lnlSCUkiejf0mOT3ObCfGbQyDmers5Xlqvt8JNDniirYGt+A3NcnGsJ7OUfgqGGXeSFozPClVJLY+UZNvy3l9Ysn8HuYEKW4S6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUrp4i2G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUrp4i2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33BE1F00A3A;
	Mon,  7 Sep 2026 06:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763417;
	bh=crI51gCX9aNuQgXzRNwPfby91Hnb1p1BcqoIRzeMTNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XUrp4i2GkaJSIMTT4IdFL8vcTU5h4dEkGlVPYUKKtZZ9MN8qP2m/6VR4yQMe43Bhv
	 7O8VSJAHuBbjddcl2aGx+jm/BwqalPucSA/9P2P3tIbRxzOnodThSbB66rwNGe+s5R
	 XjDKoypRfEn8Q+xqGHhnbiknKSyUcO4RVP7wpc6/LL7R9QjSiOkaPAzsvCn2Jee63j
	 BZQfN2FnidxuvUkoE2mkmHWpMShBVNu5qCr9iMkcODjAHgJIz+HittN+fS+1Vn/l+t
	 XOKAMQsjFftSA6G3mzpdLNKx8cWDH7bvS7LmawaJQN5pZi6c+QeFghUoegztG9QZ/u
	 yLCDkn1zLdDfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] alloc_tag: release the reservation when populate
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260907062414.106873-5-hao.ge@linux.dev>
References: <20260907062414.106873-1-hao.ge@linux.dev>
 <20260907062414.106873-5-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 06:43:36 +0000
Message-Id: <20260907064336.E33BE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] The patch introduces a kernel crash by freeing the maple tree =
entry without rolling back module_tags.size on failure.

Pre-existing issues:
- [High] vmap_pages_range() failure in vm_module_tags_populate() leaves phy=
sical pages mapped while freeing them, leading to Use-After-Free.
- [High] AB-BA Deadlock between procfs read and module loading via shutdown=
_mem_profiling().
- [Medium] Memory leak of percpu counters when module falls back to standar=
d section allocation.
--

commit 09d0b9820f6ab861e4c9680b44a685c8658fb571
Author: Hao Ge <hao.ge@linux.dev>

alloc_tag: release the reservation when populate fails

vm_module_tags_populate() can fail after a reservation is stored in the
maple tree. The error return previously leaked the entry because a failed
load never unloads the module. This patch calls release_module_tags()
on failure to free the reservation.

> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 112a014d4b890..c11813cd9e153 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -963,6 +963,7 @@ static void *reserve_module_tags(struct module *mod, =
unsigned long size,
>  			shutdown_mem_profiling(true);

[Severity: High]
This isn't a bug introduced by this patch, but could calling
shutdown_mem_profiling(true) here risk an AB-BA deadlock?

A read to /proc/allocinfo enters proc_reg_read_iter(), taking an 'in_use'
reference on the proc entry, then calls allocinfo_start() which waits for
down_read(&alloc_tag_cttype->mod_lock).

Concurrently, module loading calls codetag_alloc_module_section(), holding
down_write(&alloc_tag_cttype->mod_lock).

If reserve_module_tags() encounters an error, it calls
shutdown_mem_profiling(true), which invokes remove_proc_entry().

Since remove_proc_entry() blocks waiting for the 'in_use' reference count
to drop to zero, and the procfs reader blocks on the mod_lock held by the
writer, doesn't this create a system hang during a module load failure?

>  			pr_err("Failed to allocate memory for allocation tags in the module %=
s. Memory allocation profiling is disabled!\n",
>  			       mod->name);
> +			release_module_tags(mod, false);

[Severity: Critical]
Will this new call to release_module_tags() cause a kernel crash on a
subsequent module load?

In reserve_module_tags(), module_tags.size is optimistically updated
(module_tags.size =3D offset + size;) before attempting to allocate physical
memory via vm_module_tags_populate().

If population fails, this patch frees the maple tree entry, but
module_tags.size is left artificially inflated.

A subsequent module load will search the maple tree and reuse this freed ga=
p.
Because module_tags.size is already inflated, the allocation check bypasses
vm_module_tags_populate(), returning an unmapped virtual address. Can copyi=
ng
section data into this address then trigger a fatal page fault?

[Severity: Medium]
This is a pre-existing issue, but might the use of release_module_tags()
when falling back to a standard section allocation leak percpu counters?

If tags are not addressable, reserve_module_tags() calls
release_module_tags(mod, false) to remove the module from the maple tree
and returns -EAGAIN.

The module loader catches -EAGAIN and falls back to a normal section
allocation. Later, load_module() successfully allocates percpu counters for
the tags.

On unload, release_module_tags(mod, true) is called to free the counters.
However, because the module is no longer in the maple tree, the search fails
and exits early:

mm/alloc_tag.c:release_module_tags() {
    ...
    if (!val) /* module not found */
        goto out;
    ...
}

Are the percpu counters allocated during load_module() permanently leaked
in this scenario?

>  			return ERR_PTR(grow_res);

[Severity: High]
This is a pre-existing issue, but is there a risk that the failure path of
vm_module_tags_populate() leaves dangling PTEs causing a Use-After-Free?

In vm_module_tags_populate(), vmap_pages_range() maps allocated pages into
the kernel virtual address space.

If it fails, it returns an error but may leave successfully mapped PTEs
active in the page tables. The error path calls release_pages() to free the
physical pages back to the allocator, but fails to call vunmap_range():

mm/alloc_tag.c:vm_module_tags_populate() {
    ...
    if (nr < more_pages || vmap_pages_range(...) < 0) {
        release_pages(arg, nr);
        return -ENOMEM;
    }
    ...
}

Could this leave dangling PTEs with PAGE_KERNEL permissions pointing to
freed pages, risking data corruption when the pages are reallocated?

>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907062414.1068=
73-1-hao.ge@linux.dev?part=3D4
