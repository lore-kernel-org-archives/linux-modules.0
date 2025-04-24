Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA31DED49;
	Thu, 24 Apr 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485545; cv=none; b=qu7Ob4p7a05TqO1u+Zag7fstuzkDpJKKyisX8EBKb0t/KClTEQKDUZ872rsCeIuu1o2xN0K6LjILGD8fHZrh/V08otfuNhLTNK501UrPsEYvVDRydk9H6nmaYoNZ/j3SNIwnIBsZCay1sTRq0H6wrJ4i5qPVmAv9OXQslissX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485545; c=relaxed/simple;
	bh=BvJcgZPL7Y6NtEbnl10qscW0JW8vgaTOZZiY4RK3Y2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCzIhko3eNXHiqi81Fv5zjKUE0wLIkRcfnjEFVyLeICNViBsFUgMZBLe0a09ic50r7m+rx+0r0HQ2LzapADLNedfs5U8DxIG8LgTbpQsBz/fvI4uyD0zsJ+g8ejNRxcAydRQskN6om3yUAvV7Gd+lTck50jC6ac8Qj4cDYmz0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MRCPDEiP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zUqgaLWG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MRCPDEiP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zUqgaLWG"
Date: Thu, 24 Apr 2025 11:05:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745485541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5BC3iHnKNhjS4kP0x8raSp+c/AcRUFkJZZ5qX+a0VE=;
	b=MRCPDEiPn5KsNzGkee9SfI/b4QIGM/LU+SLnCprxMe2GNSdUsgVZdbFGovbrjDaIAPtuSA
	Bxci2k0xoGP7faCASbNJyy7dMAYykT9WZUub+k8cXQ+TAOWpaCpQDND6niwShdMEVRIoaF
	0vWFtOPqscmSKumm2K8dLugHltDGi4qbehDVLAEQFZ+6aP0Q1HlYpjCDyMTmIxYUoEIXmG
	x33i+Cco+RaZosvY4vX+hvJ8y0HqmZur2gcR5c9i5zG7SgcRiMs2QtUZp4BxDj6zNNEI/2
	V5w2db1/M6dVAfPQ31vVWpWH2zbcDZYr7zf+TxGXzB3MA2aIoxcCEhmO09XTdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745485541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5BC3iHnKNhjS4kP0x8raSp+c/AcRUFkJZZ5qX+a0VE=;
	b=zUqgaLWGxpg74RdcI0+Bnd019mRPg4PVHttM47/20CiVVso8Oj/Bw5lEi7bQoWdItrTh+W
	/tvib0jZhDHb+HCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net, Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 15/28] module: Use RCU in all users of
 __module_text_address().
Message-ID: <20250424090539.0O37K8vN@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
 <20250108090457.512198-16-bigeasy@linutronix.de>
 <db0f8ec385762e6edb3edf5054a76ea189135e6e.camel@sipsolutions.net>
 <4446525f-4e89-41bb-91a0-89c72dd0e8f8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4446525f-4e89-41bb-91a0-89c72dd0e8f8@paulmck-laptop>

On 2025-04-23 11:16:49 [-0700], Paul E. McKenney wrote:
> On Wed, Apr 23, 2025 at 05:17:31PM +0200, Benjamin Berg wrote:
> > Hi,
> > 
> > On Wed, 2025-01-08 at 10:04 +0100, Sebastian Andrzej Siewior wrote:
> > > __module_text_address() can be invoked within a RCU section, there is no
> > > requirement to have preemption disabled.
> > > 
> > > Replace the preempt_disable() section around __module_text_address()
> > > with RCU.
> > 
> > Unfortunately, this patch causes a performance regression for us. The
> > trouble is that we enable kmemleak and run trace-cmd so a lot of stack
> > traces need to be collected. Obviously, we also have lockdep enabled.
> > 
> > Now, combine this with the UML stack dumping code calling into
> > __kernel_text_address a lot[1] and it really has a relevant performance
> > impact. I saw the kernel spending 40% of its own CPU time just on the
> > lock in is_module_text_address.
> > 
> > Maybe kernel_text_address should leave the RCU handling to the caller
> > and assume that the RCU read lock is already taken?
> > 
> > Benjamin
> > 
> > [1] The UM arch dump_stack function reads every "unsigned long" on the
> > stack and tests it using __kernel_text_address.
> 
> Use of a single guard(rcu)() is regressing performance?  Interesting and
> quite unexpected.  That said, tiven the amount of debug you have enabled,
> I am not so sure that people are going to be all that excited about a
> further performance regression.
> 
> But is this regression due to the cleanup hook that guard(rcu)()
> registers?  If so, please feel free to try using rcu_read_lock()
> and rcu_read_unlock() instead.  I would be surprised if this makes a
> difference, but then again, your initial regression report also comes
> as a surprise, so...
> 
> Another way to reduce guard(rcu)() overhead is to build your kernel
> with CONFIG_PREEMPT_NONE=y.  Not so good for real-time response, but
> then again, neither are your debug options.

The guard notation is not regression I guess it is just the plenty of
rcu_read_lock()/ unlock(). We had one regression which was "fixed" by
commit ee57ab5a32129 ("locking/lockdep: Disable KASAN instrumentation of lockdep.c").

My guess would be that this is a preemptible kernel and the preempt
disable/ enable is cheaper that the RCU version. So going back to a
non-preemtible kernel should "fix" it.

Looking at kernel_text_address(), is_bpf_text_address() has also a
RCU read section so probably subject to the same trouble. And
is_ftrace_trampoline() could be also converted to RCU which would
increase the trouble. 

Improving the stack trace on UM or caching some of the most common one
might help. Not sure if disabling kmemleak for lockdep is possible/
makes a difference.

> 							Thanx, Paul

Sebastian
