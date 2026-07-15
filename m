Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634733B27C6
	for <linux-modules@vger.kernel.org>; Wed, 15 Jul 2026 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132771; cv=none; b=G+SuTpDh734zjtgWUISYr2W3N0Pwwn0zBt9rHcYF9p2qHmsNmcjzDq6JiE1WrowRd1BoT806MRcgJZJzmzKogHwcRdJoHa/xYGs3Yc10LI/tOCivk0quwLPngvBcQxI+9Xa2OrmKgpbiGD0jRELw7y1QkHh1nVzm85j9YJLpvIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132771; c=relaxed/simple;
	bh=PNS/ueX4d6mleSXcn6W4bjvW1KtY3Y1R2ir+U4Ptgic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YG5jXjl3YSKqlY8RWu5SBLo7Ob3dXl5CqRYJCEFR+qclojY1viW/9vHpJ6t3rdyPqZN0UR/wpB1ciudc3h+CD6aSTVxrx2aYoB2T6YnjcWBNiD4KXSy+A6fEdNl5cIKpiyL72qPTC2naRCNmyVfRVaaBbAj9Sws01DlnfP0UAYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H67mKeGW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H67mKeGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7E91F00A3F;
	Wed, 15 Jul 2026 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784132770;
	bh=Zxt757ZyGmJFxK3kQdoQ0L6dZbLw05n5OC5xfr/awlE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=H67mKeGWYT7qpBD+nA7stQv2/+oxl25lbPXjCyX05CUC6A60MVK+EMl9M54UyIZCM
	 2YIaR37uldalD0V2o5viT5L2IQf3RSOo8lh58Xawk/ac+vGql35Jy2wEgFVDZahiSI
	 deNQl3Idt7pA5XvpGylCCV3pDKAEmD+7ojD1F7q26nof9cOal65Os4xQ8mwcr9zy09
	 as6/5PRWvyplfrV5mD9Rl3yonMtpXwLgLsTkKS94mBGfXpR+BuliYWaK2iaeMDw36V
	 eHqqQ/UiNeLtd3u/MxR7WeUvXSj02cjeZVTqtAMRxTppB5IgKchQqmpQs+jFO7cQ0R
	 fzUh7pE+EugLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D373FCE074A; Wed, 15 Jul 2026 09:26:09 -0700 (PDT)
Date: Wed, 15 Jul 2026 09:26:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
Message-ID: <18709a40-7c72-45d4-a76b-3b82b6b7f1ff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260706092926.PIlrhRKz@linutronix.de>
 <0dfe59c2-bf60-40fe-90e6-d6e1003709d0@suse.com>
 <20260708074904.xnpi0mlh@linutronix.de>
 <bef05178-4856-4b62-9c3b-62bf636c239d@suse.com>
 <20260708135651.zl03TEfr@linutronix.de>
 <20260708190003.gmLFJGYo@linutronix.de>
 <70060a4e-4630-487f-8ecc-4408e23268d4@paulmck-laptop>
 <20260714160104.jK83e41c@linutronix.de>
 <b7b5a7f1-7d09-4181-9257-ea9272325ef2@paulmck-laptop>
 <20260715082518.3z_iDNrR@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715082518.3z_iDNrR@linutronix.de>

On Wed, Jul 15, 2026 at 10:25:18AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-07-14 10:47:58 [-0700], Paul E. McKenney wrote:
> > On Tue, Jul 14, 2026 at 06:01:04PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2026-07-08 12:22:58 [-0700], Paul E. McKenney wrote:
> > > > The RCU-callback ordering guarantees are quite weak:
> > > …
> > > So this is not working.
> > > 
> > > > What you maybe *could* do is to have the two RCU callbacks communicate,
> > > > so that the last one to be invoked did the work of both of them.  For
> > > > example, use a shared variable initialized to 2, then have each callback
> > > > do atomic_dec_and_test(), with the "winner" doing the work.
> > > > 
> > > > Would that do the trick?
> > > 
> > > This would work but we would have to fix each one or make it slower for
> > > everyone in the common case. So I think adding a rcu_barrier() to module
> > > unload wouldn't be that bad and Petr did not say "get out" so ;)
> > 
> > I am not opposed to rcu_barrier() in module unload.
> > 
> > But just to fill out the other similar situations...
> > 
> > In addition to call_rcu(), there is call_srcu(), call_rcu_tasks(),
> > and call_rcu_tasks_rude().  I think that we can rule out call_srcu()
> > as ridiculous because there could have been an arbitrarily large number
> > of srcu_struct structures passed to call_srcu() along with callback
> > functions defined within this module.  For their parts, call_rcu_tasks()
> > and call_rcu_tasks_rude() are special-purpose functions that are rarely
> > used and could therefore be ignored.

[ Just to be clear, I doubt that these problems all need any better
  solution than the status quo.  After all, any added mechanism can easily
  produce more bugs than it consumes.  I just want people to be aware. ]

> Regarding srcu, module unload should have cleanup_srcu_struct() which
> would flush pending item, no?

Unless the srcu_struct was global, but the callback was located in
this module.

> > But what about things like timers and hrtimers?  Or are people already
> > doing the right thing for such things?
> 
> Right. What people often did wrong with timers is that they enqueued a
> timer then forgot about it and released the memory with the timer
> active. Then someone who got all the timer bugs assigned came up with
> debugobjects.
> 
> This checks only that the memory is not released while the object is
> active. It does not verify the callback.

Ah, so *that* is where debugobjects came from!  ;-)

> I think it depends on what we want to achieve. We could iterate over all
> RCU callbacks checking if it belongs to the memory that we intend to
> free. The same could be done for timers, too. They should be caught by
> debugbjects unless they leak the memory…

Iterating over RCU callbacks is a no-go, except maybe under extreme
debugging levels.  There can easily be millions of those things!

> The rcu_barrier() before module_exit() would ensure the callbacks are
> done before a possible kmem_cache_free() where the cache is removed in
> the exit function. Now I see that for !SLUB_TINY there is a barrier if
> the cache has sheaves (kmem_cache_destroy() ->
> kvfree_rcu_barrier_on_cache()). Buh…

;-) ;-) ;-)

							Thanx, Paul

> Sebastian
