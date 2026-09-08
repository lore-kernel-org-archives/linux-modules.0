Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA174B5CD4
	for <linux-modules@vger.kernel.org>; Tue,  8 Sep 2026 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860327; cv=none; b=l72nxoBASUnV3Ghzeoj/RUba06ojv9OwZjYMRaitMddAGQk/oxcdMz8SNBQZxDgVKIduMqYD1fopK8Iffq3wUhVmR936WN5b1yDGz3S3AatyoAgZeB0YcruphFXx8bNG7bW29VpJydD6w+Q4fd5SoMaxPavZAc8DFqt3WsCloqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860327; c=relaxed/simple;
	bh=pZesJLyvq6pgga/5Z2hQAb9dFF6knLvGdyrEEwLy7zw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nCEVSiz42iS1szQz3mFqrgXZK9qnu2tWSax43y4dKn9ObTIo/7VWFX1fwhZhOS+PEUlOwe2EliXAtmAM1JMj4pmAMX67hBzHzMTkM57hv0Eh1WFdH900ppPvE/v0j5oKGDMIRvx+2ZQ5yhlhKsscl5gJad+SSA/nXe1j2ESRmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKKDdn9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKKDdn9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0BC1F00A3A;
	Tue,  8 Sep 2026 09:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788860325;
	bh=x7jUhoGl/W0WBFag51njSfWs/Ypo80xlQSeRIgkHtEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iKKDdn9Er9lr52pmmQJo/9doBo4B+DvXn403meoW39hhoVNl06sWCRduGpDJIr3T9
	 ogOZ89Nx2S6AYsi4AljVYK5mUoAWVXONraOnTrNNtRMm0UnvebjR4+fT9/6Q9uM96/
	 6w4Y5zxD76cG39TOJ/pdHi9TTDM5M0MUdjUTaLuI5JPwF1CMN2ikTnvqAkoFuSgZqZ
	 ODImaByJto+Gba32ExcujaVmVuqUIQKXSkfETM1oHm0Q7rpacjpHcWriAdahRM1/si
	 u3/xtE07UeROsWquNWTKVkAvNr6uBR4Z4SAimNybWXjkCiGHC1U4XD4r55jIDjPwFw
	 bHBWz7cZnoPwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/4] alloc_tag: clean up the populate failure path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260908092412.115953-3-hao.ge@linux.dev>
References: <20260908092412.115953-1-hao.ge@linux.dev>
 <20260908092412.115953-3-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 09:38:45 +0000
Message-Id: <20260908093845.9F0BC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of kasan_alloc_module_shadow() is ignored in vm_m=
odule_tags_populate(), which can lead to a kernel panic if shadow memory al=
location fails.
--

commit 2ae06d89a64873006e3ba06f14d9b47ec2d37bcf
Author: Hao Ge <hao.ge@linux.dev>

alloc_tag: clean up the populate failure path

The reservation is already stored in the maple tree when
vm_module_tags_populate() fails. A failed load never unloads the
module, so nothing releases the entry. Release it and roll
module_tags.size back.

> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 2070e682fe106..95ddf5b743d0b 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
>  				     next_page, PAGE_SHIFT) < 0) {
>  			release_pages_arg arg =3D { .pages =3D next_page };
> =20
> +			/*
> +			 * vmap_pages_range() only runs once all pages were
> +			 * allocated, and it may have installed some mappings
> +			 * before failing. Undo them.
> +			 */
> +			if (nr =3D=3D more_pages)
> +				vunmap_range(phys_end, phys_end + (nr << PAGE_SHIFT));
>  			/* Clean up and error out */
>  			release_pages(arg, nr);
>  			return -ENOMEM;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but just below this code in
vm_module_tags_populate(), the return value of kasan_alloc_module_shadow() =
is
ignored:

		if (old_shadow_end < new_shadow_end)
			kasan_alloc_module_shadow((void *)old_shadow_end,
						  new_shadow_end - old_shadow_end,
						  GFP_KERNEL);

If the shadow memory allocation fails due to memory pressure, could this le=
ad
to a kernel panic?

When the module later accesses its allocation tags, the KASAN instrumentati=
on
would attempt to read unmapped shadow memory, causing a fatal page fault.

Since other kernel components like mm/execmem.c explicitly check the return
value of this function, should vm_module_tags_populate() also check for
allocation failure and error out appropriately?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908092412.1159=
53-1-hao.ge@linux.dev?part=3D2
