Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8868E3AE6FC
	for <linux-modules@vger.kernel.org>; Tue, 29 Sep 2026 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670789; cv=none; b=ur1Upque9RIhroCRqd36Q60Ps70CgqSw6oe7FYocJuYHYIyRXkcIbsf7j40IoWUM1A8PS7Ugkxao60glmRaxqT4/wCfIS2dGUxze/9v2CGMX3v2iVTfxyp30VR0Sd2sEILAY2kcnwFB1ua8Jdo+GvrDTR/VjnYQsGkBx6McvDoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670789; c=relaxed/simple;
	bh=SLm9/kCkD8VdE5Rbg2O1vthoQAOJ+ZR4gpn0I8c/Lyw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S7GtL7XL5Y9FO6L1LEoA/QGEKmCy7yiKCpmPG3nPiDa1d7FwuSk+mD9iYfp4IMQ302kQpmPYHy2XsX7oJXiBkuzsxOzjyYIo8pWoVhGlD+bxICLM5wrXs1UEhnll231TyGufjSGAMZkgPoUPDbsJ/n0KA/LtREpAsAt8GHK8w7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1ObhKYD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1ObhKYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046B41F000FF;
	Tue, 29 Sep 2026 08:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790670788;
	bh=xRJfJh3Naye7GuOC1E3JzA3vVijBvsb2qOaB8uZ4SWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b1ObhKYDN3Eu4smiEBO2QFiHE/M2K2BAJDrap40+6CPP/d3g7RZyuk/lItjvIJqek
	 fGbHtOjjZo7BqRPZ7WckZ/tpK/mpXPGtByV9tI++xurJ6BB/2j+u3yx5sckNDMply3
	 iF42KC7+CbVWYppzNbriuEd8Cw8MgXxGqSagorSiYcF8xV2FWdRDrRMbZtqzXFB8aA
	 VhvM99e7kx0bZiPQlelnzHuUyjRLswLVlIyE2+BAGgbkg6Tp4M5KkjlUlQNsVajPoc
	 CM6IJu4hY2eKqcQYOLu0PmuSRGXJ4IasqHs42txcPsLXkF/D6ws4+oIHMJHh4//qDt
	 yr7tP0pgMqj1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/7] mm/vmalloc: undo partial mappings inside the
 mapping functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <20260929082014.160587-3-hao.ge@linux.dev>
References: <20260929082014.160587-1-hao.ge@linux.dev>
 <20260929082014.160587-3-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:33:07 +0000
Message-Id: <20260929083308.046B41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm: BUG_ON() triggered in __vunmap_range_noflush() on first chunk =
failure
- [High] mm: stale TLB entries left on mapping rollback cause UAF
--

commit 8d2eaa273026d4be467acd8256954d343a66fc4c
Author: Hao Ge <hao.ge@linux.dev>

mm/vmalloc: undo partial mappings inside the mapping functions

This patch modifies __vmap_pages_range_noflush() and friends to undo the
PTEs they installed themselves on failure. Callers no longer need to clean =
up
partial mappings.

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a9fce7efe4f49..436393aba7eb7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -349,6 +349,10 @@ static int vmap_range_noflush(unsigned long addr, un=
signed long end,
>  	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
>  		arch_sync_kernel_mappings(start, end);
> =20
> +	/* Undo the PTEs installed before the failure. */
> +	if (err)
> +		__vunmap_range_noflush(start, end);
> +
>  	return err;
>  }

[Severity: High]
Is it safe to omit a TLB flush on rollback here?

By clearing the PTEs using __vunmap_range_noflush() without flushing the TL=
B,
the CPU might retain stale entries.

If a caller like vm_module_tags_populate() in mm/alloc_tag.c frees the
physical pages immediately after the mapping attempt fails:

    if (vmap_pages_range(...) < 0) {
        ...
        release_pages(arg, nr);
    }

could speculative or adjacent accesses hit the freed memory, leading to a
use-after-free and state corruption?

[ ... ]

> @@ -683,6 +694,7 @@ int __vmap_pages_range_noflush(unsigned long addr, un=
signed long end,
>  		pgprot_t prot, struct page **pages, unsigned int page_shift)
>  {
>  	unsigned int i, nr =3D (end - addr) >> PAGE_SHIFT;
> +	unsigned long start =3D addr;
> =20
>  	WARN_ON(page_shift < PAGE_SHIFT);
> =20
> @@ -696,8 +708,14 @@ int __vmap_pages_range_noflush(unsigned long addr, u=
nsigned long end,
>  		err =3D vmap_range_noflush(addr, addr + (1UL << page_shift),
>  					page_to_phys(pages[i]), prot,
>  					page_shift);
> -		if (err)
> +		if (err) {
> +			/*
> +			 * vmap_range_noflush() undoes its own partial work,
> +			 * discard the chunks that already mapped.
> +			 */
> +			__vunmap_range_noflush(start, addr);
>  			return err;
> +		}

[Severity: High]
What happens if vmap_range_noflush() fails on the very first iteration of
this loop?

In that case, the variable addr is still equal to start, so this calls
__vunmap_range_noflush() with a zero-length range.

Because __vunmap_range_noflush() contains:
    BUG_ON(addr >=3D end);

will this immediately panic the kernel on an early allocation failure?

> =20
>  		addr +=3D 1UL << page_shift;
>  	}
> @@ -714,7 +732,16 @@ int vmap_pages_range_noflush(unsigned long addr, uns=
igned long end,
> =20
>  	if (ret)
>  		return ret;
> -	return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
> +
> +	ret =3D __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
> +	/*
> +	 * The page tables undo themselves on failure. Tear down the
> +	 * metadata that was fully set up before the mapping failed.
> +	 */
> +	if (ret)
> +		kmsan_vunmap_range_noflush(addr, end);

[Severity: High]
Are we also leaving behind stale TLB entries for the KMSAN metadata here?

kmsan_vmap_pages_range_noflush() successfully maps the metadata and
explicitly flushes the TLB for shadow/origin mappings.

If the subsequent main mapping fails, this rollback clears the KMSAN PTEs b=
ut
skips the TLB flush, which might leave stale TLB entries pointing to freed
KMSAN metadata.

> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929082014.1605=
87-1-hao.ge@linux.dev?part=3D2
