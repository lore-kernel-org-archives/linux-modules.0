Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE25189916;
	Mon,  9 Sep 2024 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725917146; cv=none; b=PWnN1I1rQagJknTdhWO3m4ugblNXiAGmm8QjK9UJJshacPgUG20k97sGVJxCnLsvAFi3vwGf9/nJuTPr3uslgthhff/KCJTzSqSTd00mK+AQDIId1XKORf/KIRdujN9mC6PMLhDEQmshHP9d5n05wz4Uqy559+RMvpSzi8UYM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725917146; c=relaxed/simple;
	bh=/zLbARdaPmZDHdAt/HtrxVUAXzYHVhfPmzor+VTQ0AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOl+b5rQ2OtX1X4hQsdH5+bcrPPpVumikJhmwIy7EmCS3y6VQ7zZmZ5oILtvZKqJxkm8lUqsQyJlNoIgg22NcpKd9fOIpZPQGegExfmhDEp0lElEii2mVdCj5bsV+rrJNRRXhu6VsVq1VIoMu11gVO+kQvsQl0E/eri1BlNFzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEoDwD1k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEoDwD1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22111C4CEC5;
	Mon,  9 Sep 2024 21:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725917146;
	bh=/zLbARdaPmZDHdAt/HtrxVUAXzYHVhfPmzor+VTQ0AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEoDwD1kwaDmk9azedC7KApARFBvQBMsc/MCE2QR3aOA5JUAL33GEWIcCHqEdd00k
	 DiYW+g3jYhhe2ugEMieUgHbuvh+OGF2VnqUqV3m5ZYbJRZ2C8UCnl2kRXc3pHevFoH
	 ceB8hz3C4wa6ByKgDpk1Xj3CAuq9Ho2ZFGfgDgH+hUScAAVzyhA7z/z+78CPGedBni
	 p9ixtbvYXKatfaGBmtfikiXemwYmXWQJpf7EOSKMWsQT8OzN1Q+3Yvh1V3CGGmzACB
	 PQxxPkAHlHncWIO4Kz5M1IxXav00r6AyQO/yOoBpewSZHM/oAo1R9uS2WqL8I+7Fgc
	 3N0nq1X4wc2BA==
Date: Mon, 9 Sep 2024 14:25:44 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH] module: Refine kmemleak scanned areas
Message-ID: <Zt9n2E0otOx5RT5I@bombadil.infradead.org>
References: <20240906153856.22204-1-vdonnefort@google.com>
 <ZtxenHsGPyDoYnzY@arm.com>
 <Zt6mcvkzPI8WNgHl@google.com>
 <Zt63aV2zmkOkwRc3@arm.com>
 <Zt7MvByqVqgQ8CSz@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt7MvByqVqgQ8CSz@google.com>

On Mon, Sep 09, 2024 at 11:23:56AM +0100, Vincent Donnefort wrote:
> On Mon, Sep 09, 2024 at 09:52:57AM +0100, Catalin Marinas wrote:
> > On Mon, Sep 09, 2024 at 08:40:34AM +0100, Vincent Donnefort wrote:
> > > On Sat, Sep 07, 2024 at 03:12:13PM +0100, Catalin Marinas wrote:
> > > > On Fri, Sep 06, 2024 at 04:38:56PM +0100, Vincent Donnefort wrote:
> > > > > commit ac3b43283923 ("module: replace module_layout with module_memory")
> > > > > introduced a set of memory regions for the module layout sharing the
> > > > > same attributes but didn't update the kmemleak scanned areas which
> > > > > intended to limit kmemleak scan to sections containing writable data.
> > > > > This means sections such as .text and .rodata are scanned by kmemleak.
> > > > > 
> > > > > Refine the scanned areas for modules by limiting it to MOD_TEXT and
> > > > > MOD_INIT_TEXT mod_mem regions.
> > > > > 
> > > > > CC: Song Liu <song@kernel.org>
> > > > > CC: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > > > > 
> > > > > diff --git a/kernel/module/debug_kmemleak.c b/kernel/module/debug_kmemleak.c
> > > > > index 12a569d361e8..b4cc03842d70 100644
> > > > > --- a/kernel/module/debug_kmemleak.c
> > > > > +++ b/kernel/module/debug_kmemleak.c
> > > > > @@ -12,19 +12,9 @@
> > > > >  void kmemleak_load_module(const struct module *mod,
> > > > >  			  const struct load_info *info)
> > > > >  {
> > > > > -	unsigned int i;
> > > > > -
> > > > > -	/* only scan the sections containing data */
> > > > > -	kmemleak_scan_area(mod, sizeof(struct module), GFP_KERNEL);
> > > > > -
> > > > > -	for (i = 1; i < info->hdr->e_shnum; i++) {
> > > > > -		/* Scan all writable sections that's not executable */
> > > > > -		if (!(info->sechdrs[i].sh_flags & SHF_ALLOC) ||
> > > > > -		    !(info->sechdrs[i].sh_flags & SHF_WRITE) ||
> > > > > -		    (info->sechdrs[i].sh_flags & SHF_EXECINSTR))
> > > > > -			continue;
> > > > > -
> > > > > -		kmemleak_scan_area((void *)info->sechdrs[i].sh_addr,
> > > > > -				   info->sechdrs[i].sh_size, GFP_KERNEL);
> > > > > +	/* only scan writable, non-executable sections */
> > > > > +	for_each_mod_mem_type(type) {
> > > > > +		if (type != MOD_DATA && type != MOD_INIT_DATA)
> > > > > +			kmemleak_no_scan(mod->mem[type].base);
> > > > >  	}
> > > > >  }
> > > > 
> > > > I lost track of how module memory allocation works. Is struct module
> > > > still scanned after this change?
> > > 
> > > That section being RW, it will be part of the MOD_DATA vmalloc and scanned.
> > 
> > Ah, makes sense. I'm fine with this patch, it simplifies the code now
> > that we have mod->mem[type]. I wouldn't say it's a fix, though no
> > backporting needed.
> 
> Agreed, it's "fixing" because it was scanning unecessary regions, but it's not
> worth any backport.

Please send a v2.

  Luis
