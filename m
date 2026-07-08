Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60613A86C
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783538581; cv=none; b=e1UyjZoF8zmwkwBeAdZwZwFw+18kDs+fmBLg0kixanDMMeK8KXCzMq98iVzngCPaeZnq5m6cj1bf422TP9+TjwRlZICgq1V3+vO/agtj5yi4h4HdUzG13nPUd1A6r0DMG95cLkV2jCGcvJd32NNIGUapX4sxR8EPgQUkGJ2+e+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783538581; c=relaxed/simple;
	bh=l46bk59LoaQ368wvxM0PymzLodnRAjgzuE5p5cEVxeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSBlZEJLmqXHQ8h7JYWz6ci8AHIMcRZjqXs3/1jp1VESi4pDZ2aiSRjvv46WYYrzNh4ds1ZZAKOb9ojj+mBzOeikARq++V2Amm9hJ5IIFmyAbbtACtFuWl2exekp20ba0eLyFrOk2QkdUAiHQ8+YAZgSovYSHfhc1PU1tYSLZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kINeXGfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kINeXGfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949181F00A3A;
	Wed,  8 Jul 2026 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783538578;
	bh=FYJtPnw6io7HML0+Q2Jwb8XG3Bo50PtR+mx0w4NXwGM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=kINeXGfxIAqdpJQiCRS6B8lxZEaY8radhjXKbmgCtIAHA6eYORxOqsje/ChCnuiDr
	 26/VObUUsoG1blM4MhHMXphEn98KLReqRI8MBN6IhOUipCh/yuu2PQZidCeNu7AM5o
	 KSQ7M+3KrdRt5yK8bKoCuEZwkpCrsRxx+U5Csn+XzfUbLsazuQhOCOBxrrh3f08alv
	 t2HjEkBFW+tIEvNbKlpTlYEn4A8GAojBrBGQtoFSZw8k13wmQhTBRTlWxyCCGHPNlE
	 UWUYz1ioQPKZFLVw7te2/FFrt+hSsEX9+j8fyFYex9DPhFatL9wW+2ivUOT4TJYdbk
	 I8C1GXa0Wffjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 61543CE074A; Wed,  8 Jul 2026 12:22:58 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:22:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
Message-ID: <70060a4e-4630-487f-8ecc-4408e23268d4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
 <de2616b3-6edf-4255-ba77-0674e225ab27@linux.dev>
 <akfjpBVML_1RFF91@gmail.com>
 <87111f02-5b7a-4185-8364-2faba650578b@linux.dev>
 <20260706092926.PIlrhRKz@linutronix.de>
 <0dfe59c2-bf60-40fe-90e6-d6e1003709d0@suse.com>
 <20260708074904.xnpi0mlh@linutronix.de>
 <bef05178-4856-4b62-9c3b-62bf636c239d@suse.com>
 <20260708135651.zl03TEfr@linutronix.de>
 <20260708190003.gmLFJGYo@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708190003.gmLFJGYo@linutronix.de>

On Wed, Jul 08, 2026 at 09:00:03PM +0200, Sebastian Andrzej Siewior wrote:
> -*, +module +Paul.
> 
> On 2026-07-08 15:56:53 [+0200], To Petr Pavlu wrote:
> > > One problem is that I'm not sure where the new rcu_barrier() call should
> > > be placed. The prototype adds it before calling the module's exit
> > > function. Would this actually fit all modules? From a quick look, I can
> > > see that various modules call it at different points during their exit.
> > 
> > I don't know why you would use call_rcu() in your module_exit()
> > (pointing to the same module). But you could have call_rcu() invoking
> > kmem_cache_free() and destroying that cache (kmem_cache_destroy()) in
> > your exit path. From that perspective it would make sense to flush all
> > calls before invoking module_exit().
> 
> Paul, are the RCU callbacks always invoked in FIFO order?
> If we put the module unmap into a call_rcu() (instead of the current
> synchronize_rcu()) would we invoke the callback's of the module's
> callback before the unmap of the module? Or is this not guaranteed due
> callbacks on CPU0 vs CPU1 are executed in different order?

The RCU-callback ordering guarantees are quite weak:

o	If callback A executes call_rcu() that queues callback B, then
	A will be invoked before B.  (Just in case anyone had any doubt.)

o	The callback queued prior to a call to rcu_barrier() will be
	invoked before any that are queued after return from that same
	call to rcu_barrier().

The current *implementation* orders callbacks queued on a given CPU
(but please see below), but there are absolutely no ordering guarantees
among CPUs.  To see why, consider the following sequence of events:

o	CPU 0 does an "rm -rf" of a large file tree containing huge
	numbers of small files.  This results in an RCU callback being
	queued for each file.

o	CPU 0 queues RCU callback A.

o	The corresponding grace period completes, so CPU 0 starts
	invoking callbacks.

o	CPU 1 queues RCU callback B.

o	The corresponding grace period completes, so CPU 1 invokes
	callback B.

o	Meanwhile, CPU 0 is still working off its RCU callback backlog.

o	CPU 0 eventually invokes RCU callback A

Worse yet, if we here in RCU-land ever allow a given CPU's callbacks
to be offloaded or deoffloaded while that CPU is online, then there
really will be cases where callbacks queued even by a single given CPU
get invoked out of order.  And there are people who would dearly love
us to make this happen.  (The last time we tried, we were inundated in
odd race conditions, but maybe we will come up with a better way.)

So these RCU callback ordering guarantees are probably too weak for your
use case.

> Because if the FIFO order is guaranteed then it would be cheapest
> solution. But it would require a rcu_barrier() in kmem_cache_destroy()).

What you maybe *could* do is to have the two RCU callbacks communicate,
so that the last one to be invoked did the work of both of them.  For
example, use a shared variable initialized to 2, then have each callback
do atomic_dec_and_test(), with the "winner" doing the work.

Would that do the trick?

							Thanx, Paul
