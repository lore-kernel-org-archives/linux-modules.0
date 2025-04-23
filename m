Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2122018DF86;
	Wed, 23 Apr 2025 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432211; cv=none; b=DBaYY3DTaYamvZia1L+W4GYyCfLxOsKzXfkWKW+dh1p7NVKq7svH05a3326LHNK2VnJVFqCwSAPn33OfaDcaDQuCWDTaCIzHAfrB7unjhzrZlRlsgPLEyZASPWURnB9QRyJzUiLftKuv1AJ0acIYcmUKeT/vVsyJpTT33OeguGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432211; c=relaxed/simple;
	bh=UCMgqoUk/35E+0AbklcegPwWnbbccv3El9DIubtxTbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjSSV1CVeFii86prIFZZCq0FZx173dplr9KlqOxk7Dq6pCV1JNr0c0HUg+dlMzlziBo1cSiZh7xbBAMZWpJTT377vlAHimPcknA8zEuTVa5vIdcc7QhtnTpHE4KT4JW8YO7G8/2t2LVHmTWpU3COzEqI+ZgHmmxU+4/B6UKaSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbVgA2W7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbVgA2W7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC3CC4CEE2;
	Wed, 23 Apr 2025 18:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745432210;
	bh=UCMgqoUk/35E+0AbklcegPwWnbbccv3El9DIubtxTbA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kbVgA2W7BzGd24i9NZuPM5D1kKlokI9fRXpflISX/6YJ1QJEoqxHGs2S2/7a/htw8
	 GwkgO2DlW6rqb3KavlQWXeOfABadxRNzO8cQj4sjug1tLbpV3DokH6q1XF/4sVrrGN
	 uiTytMLFteY9fhzTR4XWbJQE6uA8AVNgVH/TtVMSAr80LTNEOZOJiyR6vEdYZaAziV
	 leJVlJWfHrLQsV9kivxEVHa4uP9Z9iGJXRw9KkPIJQ0yjIUi9lsyq/+kiT6fB2v+gX
	 ispA8YeqtUs3xbQ1GwCWFMPt5Z+hxZ0t0FPf5nMzyQJhfe4GgeKlF1rKHP6VVRNB99
	 QP0sDdHG9CA/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3E58DCE0B75; Wed, 23 Apr 2025 11:16:49 -0700 (PDT)
Date: Wed, 23 Apr 2025 11:16:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net, Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 15/28] module: Use RCU in all users of
 __module_text_address().
Message-ID: <4446525f-4e89-41bb-91a0-89c72dd0e8f8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250108090457.512198-1-bigeasy@linutronix.de>
 <20250108090457.512198-16-bigeasy@linutronix.de>
 <db0f8ec385762e6edb3edf5054a76ea189135e6e.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db0f8ec385762e6edb3edf5054a76ea189135e6e.camel@sipsolutions.net>

On Wed, Apr 23, 2025 at 05:17:31PM +0200, Benjamin Berg wrote:
> Hi,
> 
> On Wed, 2025-01-08 at 10:04 +0100, Sebastian Andrzej Siewior wrote:
> > __module_text_address() can be invoked within a RCU section, there is no
> > requirement to have preemption disabled.
> > 
> > Replace the preempt_disable() section around __module_text_address()
> > with RCU.
> 
> Unfortunately, this patch causes a performance regression for us. The
> trouble is that we enable kmemleak and run trace-cmd so a lot of stack
> traces need to be collected. Obviously, we also have lockdep enabled.
> 
> Now, combine this with the UML stack dumping code calling into
> __kernel_text_address a lot[1] and it really has a relevant performance
> impact. I saw the kernel spending 40% of its own CPU time just on the
> lock in is_module_text_address.
> 
> Maybe kernel_text_address should leave the RCU handling to the caller
> and assume that the RCU read lock is already taken?
> 
> Benjamin
> 
> [1] The UM arch dump_stack function reads every "unsigned long" on the
> stack and tests it using __kernel_text_address.

Use of a single guard(rcu)() is regressing performance?  Interesting and
quite unexpected.  That said, tiven the amount of debug you have enabled,
I am not so sure that people are going to be all that excited about a
further performance regression.

But is this regression due to the cleanup hook that guard(rcu)()
registers?  If so, please feel free to try using rcu_read_lock()
and rcu_read_unlock() instead.  I would be surprised if this makes a
difference, but then again, your initial regression report also comes
as a surprise, so...

Another way to reduce guard(rcu)() overhead is to build your kernel
with CONFIG_PREEMPT_NONE=y.  Not so good for real-time response, but
then again, neither are your debug options.

							Thanx, Paul

> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  kernel/module/main.c | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 80877741ac7e5..6a99076146cbc 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -823,13 +823,12 @@ void symbol_put_addr(void *addr)
> >  
> >  	/*
> >  	 * Even though we hold a reference on the module; we still
> > need to
> > -	 * disable preemption in order to safely traverse the data
> > structure.
> > +	 * RCU read section in order to safely traverse the data
> > structure.
> >  	 */
> > -	preempt_disable();
> > +	guard(rcu)();
> >  	modaddr = __module_text_address(a);
> >  	BUG_ON(!modaddr);
> >  	module_put(modaddr);
> > -	preempt_enable();
> >  }
> >  EXPORT_SYMBOL_GPL(symbol_put_addr);
> >  
> > @@ -3694,20 +3693,15 @@ struct module *__module_address(unsigned long
> > addr)
> >   */
> >  bool is_module_text_address(unsigned long addr)
> >  {
> > -	bool ret;
> > -
> > -	preempt_disable();
> > -	ret = __module_text_address(addr) != NULL;
> > -	preempt_enable();
> > -
> > -	return ret;
> > +	guard(rcu)();
> > +	return __module_text_address(addr) != NULL;
> >  }
> >  
> >  /**
> >   * __module_text_address() - get the module whose code contains an
> > address.
> >   * @addr: the address.
> >   *
> > - * Must be called with preempt disabled or module mutex held so that
> > + * Must be called within RCU read section or module mutex held so
> > that
> >   * module doesn't get freed during this.
> >   */
> >  struct module *__module_text_address(unsigned long addr)
> 
