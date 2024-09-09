Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD61B14E8;
	Mon,  9 Sep 2024 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871981; cv=none; b=Dey4jnu5tvnNViwEMRBGXXb5OPPz1BclikTL2pLiO03/N6QuAtya8wDJFcWGikmykMqz8yFMMueF97WXlsYkndqbeBTMEo3E4Ze/c9uKEp/ObgI9/Tg1T97jR76pSE7UMZCitgtYO9jKzwlEoJVRbx7w8sfk7t+MFpLo3tn9FQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871981; c=relaxed/simple;
	bh=5pYzR9/0mNgcE9oWenX5Qf/q1RYzYHaUwcpqyuXMLk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lptHCs7Oqwvoznsd08pGB562pzfvVLR6axWEzAMLysyDhZLtP+lbBvtWmoqpIfe9JKzMiN85WlksF64N0bqjQaEz2LXcm5XYLSMW+Q8227MKNv1qNypgNrGQMjdR/aetqv/1AMracEmvs9pe55PHqpYfKdlpD7S7KrlLLlJGWcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C62C4CEC5;
	Mon,  9 Sep 2024 08:52:59 +0000 (UTC)
Date: Mon, 9 Sep 2024 09:52:57 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mcgrof@kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH] module: Refine kmemleak scanned areas
Message-ID: <Zt63aV2zmkOkwRc3@arm.com>
References: <20240906153856.22204-1-vdonnefort@google.com>
 <ZtxenHsGPyDoYnzY@arm.com>
 <Zt6mcvkzPI8WNgHl@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt6mcvkzPI8WNgHl@google.com>

On Mon, Sep 09, 2024 at 08:40:34AM +0100, Vincent Donnefort wrote:
> On Sat, Sep 07, 2024 at 03:12:13PM +0100, Catalin Marinas wrote:
> > On Fri, Sep 06, 2024 at 04:38:56PM +0100, Vincent Donnefort wrote:
> > > commit ac3b43283923 ("module: replace module_layout with module_memory")
> > > introduced a set of memory regions for the module layout sharing the
> > > same attributes but didn't update the kmemleak scanned areas which
> > > intended to limit kmemleak scan to sections containing writable data.
> > > This means sections such as .text and .rodata are scanned by kmemleak.
> > > 
> > > Refine the scanned areas for modules by limiting it to MOD_TEXT and
> > > MOD_INIT_TEXT mod_mem regions.
> > > 
> > > CC: Song Liu <song@kernel.org>
> > > CC: Catalin Marinas <catalin.marinas@arm.com>
> > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > > 
> > > diff --git a/kernel/module/debug_kmemleak.c b/kernel/module/debug_kmemleak.c
> > > index 12a569d361e8..b4cc03842d70 100644
> > > --- a/kernel/module/debug_kmemleak.c
> > > +++ b/kernel/module/debug_kmemleak.c
> > > @@ -12,19 +12,9 @@
> > >  void kmemleak_load_module(const struct module *mod,
> > >  			  const struct load_info *info)
> > >  {
> > > -	unsigned int i;
> > > -
> > > -	/* only scan the sections containing data */
> > > -	kmemleak_scan_area(mod, sizeof(struct module), GFP_KERNEL);
> > > -
> > > -	for (i = 1; i < info->hdr->e_shnum; i++) {
> > > -		/* Scan all writable sections that's not executable */
> > > -		if (!(info->sechdrs[i].sh_flags & SHF_ALLOC) ||
> > > -		    !(info->sechdrs[i].sh_flags & SHF_WRITE) ||
> > > -		    (info->sechdrs[i].sh_flags & SHF_EXECINSTR))
> > > -			continue;
> > > -
> > > -		kmemleak_scan_area((void *)info->sechdrs[i].sh_addr,
> > > -				   info->sechdrs[i].sh_size, GFP_KERNEL);
> > > +	/* only scan writable, non-executable sections */
> > > +	for_each_mod_mem_type(type) {
> > > +		if (type != MOD_DATA && type != MOD_INIT_DATA)
> > > +			kmemleak_no_scan(mod->mem[type].base);
> > >  	}
> > >  }
> > 
> > I lost track of how module memory allocation works. Is struct module
> > still scanned after this change?
> 
> That section being RW, it will be part of the MOD_DATA vmalloc and scanned.

Ah, makes sense. I'm fine with this patch, it simplifies the code now
that we have mod->mem[type]. I wouldn't say it's a fix, though no
backporting needed.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
