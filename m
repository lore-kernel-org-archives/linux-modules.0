Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B91DF97D
	for <linux-modules@vger.kernel.org>; Mon, 10 Mar 2025 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641861; cv=none; b=W4jkycHqiNEX+Co4hth/7Il+vrL89P7+XB0S82Ip5EPZ5hbmvjVYD5AIlWUspJLohmUcnDRtMER5MRZfUDihyebxaUDv2SnrL8OOwxHNYlpqEAkLkG5TJqucNzBw/Z+PKUpdhg7xrvgJNYW/669aZRsEZAalsVwAl/R20D1Phu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641861; c=relaxed/simple;
	bh=z0EsPfx5/OmkGre8hPaihflOCTr7SoqUbe0N0ZMFNzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVNNyxpIXCHUfPl2RjvpZMYgLtcRNazHD3O2NNuYM0hVQycUia2ounDLRKBZ4Vyjzc17hSlexayAHSlscFqdcNvg8SdwxIPiQVnRCIZp1DFX36ilKd62VUoHwQ/y7GJPRhSZWl0J7CE4XOWjWIdcmDwKCXTIZ0hRgdboYlFx3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <sebastian@breakpoint.cc>)
	id 1trkbg-0002c0-4W; Mon, 10 Mar 2025 22:24:16 +0100
Date: Mon, 10 Mar 2025 22:24:16 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] module: Use rcuref_t for module::refcnt.
Message-ID: <20250310212416.K2OGvLw7@breakpoint.cc>
References: <20250309121914.pN6eBMvI@breakpoint.cc>
 <2362aa50-67fc-4535-b0eb-26f50066710b@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2362aa50-67fc-4535-b0eb-26f50066710b@suse.com>

On 2025-03-10 15:28:23 [+0100], Petr Pavlu wrote:
> On 3/9/25 13:19, Sebastian Andrzej Siewior wrote:
> > By using rcuref_t the atomic_inc_not_zero() and atomic_dec_if_positive()
> > can disappear. By design rcuref_t does not allow decrementing past the
> > "0" reference and increment once it has been released. It will spill
> > warnings if there are more puts than initial gets.
> > This also makes the put/ get attempt in try_release_module_ref() a
> > little simpler. Should the get in try_release_module_ref() fail then
> > there should be another warning originating from module_put() which is
> > the only race I can imagine.
> > 
> > Use rcuref_t for module::refcnt.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> 
> I'd understand changing module::refcnt from atomic_t to refcount_t, but
> it isn't clear to me from the above description what using rcuref_t
> actually gains. Could you please explain why you think it is more
> appropriate over refcount_t here?

I seems easier to handle without the atomic_inc_not_zero() and
atomic_dec_if_positive().
rcuref_get() is implemented as an implicit inc and succeeds always as
long as the counter is not negative. Negative means the counter has been
probably released and the slowpath decides if it is released or not.
Eitherway you get rid of all the WARN_ON()s and the dec/ inc dance in
try_release_module_ref() where you simply attempt the final "put" and if
this one fails (because a refence is still held) you attempt to get the
inital reference and can decice if it was successfull or not.
If the puts outweight the gets then you see a warning from the rcuref()
code itself.

> > -/* Try to release refcount of module, 0 means success. */
> > -static int try_release_module_ref(struct module *mod)
> > +/* Try to release the initial reference of module, true means success. */
> > +static bool try_release_module_ref(struct module *mod)
> >  {
> > -	int ret;
> > +	bool ret;
> >  
> >  	/* Try to decrement refcnt which we set at loading */
> > -	ret = atomic_sub_return(MODULE_REF_BASE, &mod->refcnt);
> > -	BUG_ON(ret < 0);
> > +	ret = rcuref_put(&mod->refcnt);
> >  	if (ret)
> > -		/* Someone can put this right now, recover with checking */
> > -		ret = atomic_add_unless(&mod->refcnt, MODULE_REF_BASE, 0);
> > +		/* Last reference put, module can go */
> > +		return true;
> >  
> > -	return ret;
> > +	ret = rcuref_get(&mod->refcnt);
> > +	if (!ret)
> > +		/*
> > +		 * Last put failed but can't acquire a reference. This means
> > +		 * the previous owner has put the reference.
> > +		 */
> > +		return true;
> > +
> > +	/* There is still a reference on the module */
> > +	return false;
> 
> The updated version of try_release_module_ref() no longer uses the
> MODULE_REF_BASE constant and silently expects that it is equal to 1. We
> could trivially get rid of MODULE_REF_BASE and similarly hardcode it
> as 1 throughout kernel/module/main.c, but I assume the purpose of it
> being a #define constant is for explicitness to make the code clearer.
> 
> I realize the new code cannot use MODULE_REF_BASE because rcuref_t
> currently doesn't have functions to add/subtract an arbitrary value from
> the reference counter. I guess this goes back to my first question about
> why rcuref_t is preferred over refcount_t.

The idea is to start with a refcount of two. I don't if having the
define as MODULE_REF_BASE or simply use 1 + 1 to make it obvious that 1
additional reference is held which is dropped in
try_release_module_ref() it an attempt to release the module.
rcuref does not provide add/ inc but allows to keep one extra refence.

> >  }
> >  
> >  static int try_stop_module(struct module *mod, int flags, int *forced)
> >  {
> >  	/* If it's not unused, quit unless we're forcing. */
> > -	if (try_release_module_ref(mod) != 0) {
> > +	if (try_release_module_ref(mod) != true) {
> 
> Nit: -> 'if (!try_release_module_ref(mod)) {'.

Noted.

Sebastian
