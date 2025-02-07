Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A94E233148;
	Fri,  7 Feb 2025 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738907008; cv=none; b=fMyuV6EDbeamXNJll/XnwKgiydZ7kLovNP0cv7SB4wLPpa2cJ27rAqsqAVkKzpVkgB/DYbHok+lhZtqJrcIZGKu9omPpDVCgtnnYvdNnIE0Bx/4+i06V6kUYtrEzDmZGZPoh8xQXp63yAThIP+S2Ig1wrKqENocdJLjafxCcg6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738907008; c=relaxed/simple;
	bh=FbqvspU70ux8xhH5GV7nNntPDn/y+jPWMJBM4gK4o4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQvn/N06svjMCy8Avly0D2cdjsVJ7kQ/lpD0kuX6Mo4KMSjSmIZjTb1raZUT7vq3rwnJ0td/9DrmDWVySDu8fH0Lmtr6K324PyUdrfpSFliuaxd6xdAzwKGhgEl8eheJLn8Z09ztj5VTjmzuSxigUpefOgTqPADF9MEP9G8lI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZCfHWylj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZCfHWylj"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id BDCE0205491C; Thu,  6 Feb 2025 21:43:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BDCE0205491C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738907005;
	bh=yYbYHbF6Cw2M3eiKWKa9HfzDACNKpJkgQcaNttK4MrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCfHWyljCupEp3sfyTltcraBRrq9wyuuYMRTGtXV/bMyMbfbhRJeQkdPlXIqjEIXn
	 B9/oQoF7IGgQOuGEby5GglfpaTbssUztNH5HRBKlSJFWuN7DMUlJaGta8Tw+cIicYv
	 08bp+f/m+zRDMtocHIUGCuk98CDlWWR6eYL9g50Y=
Date: Thu, 6 Feb 2025 21:43:25 -0800
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, hch@infradead.org,
	christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	code@tyhicks.com, mcgrof@kernel.org, frkaya@linux.microsoft.com,
	vijayb@linux.microsoft.com, petr.pavlu@suse.com,
	linux@weissschuh.net, samitolvanen@google.com, da.gomez@samsung.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org
Subject: Re: [v1 2/3] include: move
 lookup_or_create_module_kobject()/to_module* to module.h
Message-ID: <20250207054325.GA25299@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250204052222.1611510-1-shyamsaini@linux.microsoft.com>
 <20250204052222.1611510-3-shyamsaini@linux.microsoft.com>
 <87h658u6hr.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h658u6hr.fsf@prevas.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Everyone,

On Wed, Feb 05, 2025 at 09:43:12AM +0100, Rasmus Villemoes wrote:
> On Mon, Feb 03 2025, Shyam Saini <shyamsaini@linux.microsoft.com> wrote:
> 
> > Move the following to module.h to allow common usages:
> >  - lookup_or_create_module_kobject()
> >  - to_module_attr
> >  - to_module_kobject
> >
> > This makes lookup_or_create_module_kobject() as inline.
> >
> > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > ---
> >  include/linux/module.h | 39 +++++++++++++++++++++++++++++++++++++++
> >  kernel/params.c        | 39 ---------------------------------------
> >  2 files changed, 39 insertions(+), 39 deletions(-)
> >
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 12f8a7d4fc1c..ba5f5e6c3927 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -894,8 +894,47 @@ static inline void *module_writable_address(struct module *mod, void *loc)
> >  #endif /* CONFIG_MODULES */
> >  
> >  #ifdef CONFIG_SYSFS
> > +/* sysfs output in /sys/modules/XYZ/parameters/ */
> > +#define to_module_attr(n) container_of_const(n, struct module_attribute, attr)
> > +#define to_module_kobject(n) container_of(n, struct module_kobject, kobj)
> >  extern struct kset *module_kset;
> >  extern const struct kobj_type module_ktype;
> > +
> > +static inline struct module_kobject * __init lookup_or_create_module_kobject(const char *name)
> 
> As others have said, this is way too big for an inline. Also, __init is
> at best harmless (if it is indeed inlined into all callers), but if for
> whatever reason the compiler decides to emit an OOL version, we
> definitely do not want that in .init.text as we are now calling it from
> non-init code.
> 
> > +{
> > +	struct module_kobject *mk;
> > +	struct kobject *kobj;
> > +	int err;
> > +
> > +	kobj = kset_find_obj(module_kset, name);
> > +	if (kobj) {
> > +		mk = to_module_kobject(kobj);
> > +	} else {
> > +		mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
> > +		BUG_ON(!mk);
> > +
> 
> And while the BUG_ON() is borderline acceptable in the current,
> only-used-during-init, state, that definitely must go away once the
> function can be called from non-init code.
> 
> This is what I alluded to when I said that the function might need some
> refactoring before module_add_driver can start using it.
> 
> I'd say that the BUG_ON can simply be removed and replaced by a return
> NULL; an "impossible" error case that can already be hit by some of the
> code below, so callers have to be prepared for it anyway. If the
> allocation fails (during early boot or later), the allocator already
> makes a lot of noise, so there's no reason to even do a WARN_ON, and
> since it "only" affects certain /sys objects, it's probably better to
> let the machine try to complete boot instead of killing it.
> 
> Also, I agree with the suggestion to drop/outdent the whole else{} branch by
> changing the if() to do "return to_module_kobject(kobj);".
> 
> To summarize:
> 
> - refactor to do an early return
> 
> - drop BUG_ON, replace by return NULL.
> 
> - drop static and __init, perhaps change __init to __modinit (which is a
>   pre-existing #define in params.c, so the function remains __init if
>   !CONFIG_MODULES), add an appropriate declaration somewhere, and if you
>   like, also do the rename
> 
> - make use of it from module_add_driver()

I have addressed these feedback in v2, thank you for the reviews.

Thanks,
Shyam
