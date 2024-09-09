Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D521B29D9
	for <linux-modules@vger.kernel.org>; Mon,  9 Sep 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877445; cv=none; b=J+DOdAXPL8LSJ0yMqrYpPRwiXuPDtMSkZBGFG9pG5ctzG5kK+uxu0c1twitph6PK43SkV6dHkKpxb25UDB89SVxefelbEogPnXO6N9lXyjjItk+LSovHVDyNLDwe5uOKwJXr2gipTawAgxM72uAl732I5i5qVu6ALWux2jirsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877445; c=relaxed/simple;
	bh=vPREka0m2x4nHThAppIIysvM7KHGqmf5j2K3rxcXMW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4IN/pzHiwMvSeOeA5xaLvH4o+ez8+6XmGpPUeMo9eHQ7oPYDd4SrR+/V79+WCIvEBHHM4wmQ5d3JvBTHVFs3XhsQvbPEHVpH61OFDq1jHBhM8OvUUWOSr4b4+DzXWaV/wUrn6SbUjshi+Cx1IO4J+stBUmVzE9MV3s/klsK4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vb+wSYzn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vb+wSYzn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so30504485e9.0
        for <linux-modules@vger.kernel.org>; Mon, 09 Sep 2024 03:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725877442; x=1726482242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ5WQoxsyWzldYFB3jlr0SD6So4oXuBDifYXDyaGqRw=;
        b=vb+wSYzn0cQ90uQPyxhV29fCWuks4EfFvgx/Nz7QN9Zw6Fz2fY8g+Dy7vDG00iDRGP
         uk5obytghTlgttFlj1oLUemnSkazwWJ9aw766u+vF4vahi0U5vs4W0rA/G1Nf/Ol+Pdh
         5O+CeNdDxsQ+z4uRgLsMhJ88AGHpege4k2cvMwJKKOhe30L/g6QaPZQyRmiItl60wyfF
         gQYe2zFKhzQgSnqlIPlvASX3UDaYSmfmV7VRZaeiPMcCRviX+tQZA2nyKTCmm9Ura9+/
         R4P1WpLXW+DKeKVAt2WZjkHX0hW2v7YCjFRbayTufRXnqep/uKQSVvh+uxQlYKlNebll
         sI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725877442; x=1726482242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQ5WQoxsyWzldYFB3jlr0SD6So4oXuBDifYXDyaGqRw=;
        b=o1546uwvDkFKM1D81Zg8UEUFikWPaz6RfWNs7KsH7gw4JZFtZsxYGauXtBt7in54ed
         1J5NThpBEW6r576Jwtp/Avb+KXIO6w7kxwnA95dMHxOTjYWVNzpYymIFnFXQURmsnQtB
         6H+E6gMK288EhLpN9dm2NfvmbU0WAMb7HeyLKQQHTXU8gcohzpmzyq2JGXmhgDM9+6ky
         zyu1haOAJ4Yq29IkKdsxTjEqQcsQJp2zCy001KxSVAX1Sa83/8er4xY/2w0J0DpqZkPT
         cFpcfXFjgpo1jZdYqPNW+l2AMYOKe9XR/B47k04m1wWUVKADrurShS3LzNPiCseZSfxR
         Rh+A==
X-Forwarded-Encrypted: i=1; AJvYcCWJbk+KnbI/osuxOwO7AsmeysETLNZXEnKmK4VbroIa6RMbwcC6yFNKdIRhnkpmm1F25tvE0nY77yKEHXad@vger.kernel.org
X-Gm-Message-State: AOJu0YwMaNWgs9JEAlw986dsuSGtTnv22fUly2/gUFPUpG0GOoEE2lUg
	GmCyjWXb52wjzQWLWbRtamSPa87xAv02pD/fiuCRMw06Vm8YPlW6TejWp4k9sw==
X-Google-Smtp-Source: AGHT+IHfxKW3kRyJln3ueSC5yVk7PxFQiVDNAL1/cpHkbHaLPgQ69SPDToYoOPL3BJYr8OQzW92e9A==
X-Received: by 2002:a05:600c:3d88:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42cad760ed1mr61712105e9.10.1725877441253;
        Mon, 09 Sep 2024 03:24:01 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cadda5a07sm76931645e9.0.2024.09.09.03.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 03:24:00 -0700 (PDT)
Date: Mon, 9 Sep 2024 11:23:56 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: mcgrof@kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH] module: Refine kmemleak scanned areas
Message-ID: <Zt7MvByqVqgQ8CSz@google.com>
References: <20240906153856.22204-1-vdonnefort@google.com>
 <ZtxenHsGPyDoYnzY@arm.com>
 <Zt6mcvkzPI8WNgHl@google.com>
 <Zt63aV2zmkOkwRc3@arm.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt63aV2zmkOkwRc3@arm.com>

On Mon, Sep 09, 2024 at 09:52:57AM +0100, Catalin Marinas wrote:
> On Mon, Sep 09, 2024 at 08:40:34AM +0100, Vincent Donnefort wrote:
> > On Sat, Sep 07, 2024 at 03:12:13PM +0100, Catalin Marinas wrote:
> > > On Fri, Sep 06, 2024 at 04:38:56PM +0100, Vincent Donnefort wrote:
> > > > commit ac3b43283923 ("module: replace module_layout with module_memory")
> > > > introduced a set of memory regions for the module layout sharing the
> > > > same attributes but didn't update the kmemleak scanned areas which
> > > > intended to limit kmemleak scan to sections containing writable data.
> > > > This means sections such as .text and .rodata are scanned by kmemleak.
> > > > 
> > > > Refine the scanned areas for modules by limiting it to MOD_TEXT and
> > > > MOD_INIT_TEXT mod_mem regions.
> > > > 
> > > > CC: Song Liu <song@kernel.org>
> > > > CC: Catalin Marinas <catalin.marinas@arm.com>
> > > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > > > 
> > > > diff --git a/kernel/module/debug_kmemleak.c b/kernel/module/debug_kmemleak.c
> > > > index 12a569d361e8..b4cc03842d70 100644
> > > > --- a/kernel/module/debug_kmemleak.c
> > > > +++ b/kernel/module/debug_kmemleak.c
> > > > @@ -12,19 +12,9 @@
> > > >  void kmemleak_load_module(const struct module *mod,
> > > >  			  const struct load_info *info)
> > > >  {
> > > > -	unsigned int i;
> > > > -
> > > > -	/* only scan the sections containing data */
> > > > -	kmemleak_scan_area(mod, sizeof(struct module), GFP_KERNEL);
> > > > -
> > > > -	for (i = 1; i < info->hdr->e_shnum; i++) {
> > > > -		/* Scan all writable sections that's not executable */
> > > > -		if (!(info->sechdrs[i].sh_flags & SHF_ALLOC) ||
> > > > -		    !(info->sechdrs[i].sh_flags & SHF_WRITE) ||
> > > > -		    (info->sechdrs[i].sh_flags & SHF_EXECINSTR))
> > > > -			continue;
> > > > -
> > > > -		kmemleak_scan_area((void *)info->sechdrs[i].sh_addr,
> > > > -				   info->sechdrs[i].sh_size, GFP_KERNEL);
> > > > +	/* only scan writable, non-executable sections */
> > > > +	for_each_mod_mem_type(type) {
> > > > +		if (type != MOD_DATA && type != MOD_INIT_DATA)
> > > > +			kmemleak_no_scan(mod->mem[type].base);
> > > >  	}
> > > >  }
> > > 
> > > I lost track of how module memory allocation works. Is struct module
> > > still scanned after this change?
> > 
> > That section being RW, it will be part of the MOD_DATA vmalloc and scanned.
> 
> Ah, makes sense. I'm fine with this patch, it simplifies the code now
> that we have mod->mem[type]. I wouldn't say it's a fix, though no
> backporting needed.

Agreed, it's "fixing" because it was scanning unecessary regions, but it's not
worth any backport.

Aside, judging by the size of this function, I am not sure it's worth to keep
a separated file, but the patch that introduced it didn't really explain why so
I kept it that way.

> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Cheers!

-- 
Vincent
