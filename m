Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C670149C41;
	Thu, 24 Apr 2025 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506059; cv=none; b=K2B8+DDqFJjGYcUwYIoDzWCNfkzy8htAK8xbON4x0ydnU6HqRAFhOLqioNGyz96V/D+yMJTgN5cElgqjfE0Dk8Q6FWKWhgbu+9bd6kyADsViJUzvSVTudc5gN+ZeV1gRaqMyKLz5TNo+rZqOB19Dkc2dV9HxRqGTZRbei/LvQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506059; c=relaxed/simple;
	bh=aI+0J8pNI48g/nj9AVjzAh0Eq0xcHXjVInXIA5TOWqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGioGVzL7vCeiw1F1xRCdHWERCodvK3OSkiCnra7G5nHJ5xZhQWUug322ZGJKdBX8Z9MdX82VMHSIqewdpT+QlfffqCGhro3kRlwCazEl/FMmaZj6oWsu7qjWMXSkHFvh0dvieznxJyNRkFU1uegjpbkNvcI6fDoQZtuds8ENfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN9AYyRT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN9AYyRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1877C4CEE3;
	Thu, 24 Apr 2025 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745506059;
	bh=aI+0J8pNI48g/nj9AVjzAh0Eq0xcHXjVInXIA5TOWqw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eN9AYyRTJunIPoIKnx1LWKGqL9hiQRVPIsv4MSxykjdGtV6LBxOyy5b4R70iop/0G
	 JKtPScOyukzAKGsw8w8+h+j9JW4Y4cCf9toc5ETZksoW1Hf4HD1lnqRK/5O0qYz69J
	 ZBRDdm2CfF0xQ2Ont3qAIpwVac7yyEwgKG67G/9eFPjw7UyIp7jGCFlXsTfubIMIWD
	 DAuQ3/yTqle0JPLu/aRHrnI76L8+RhPI8XWtdwHJc2iGnMRc/aPmv6tnBZRUSYQbVz
	 JNeXpYhSqAXIB5lKj60oLLx+E+12RplIBgLtS8r5n+pTLXtHWRHbC0xVQBHILdGhNm
	 05Ys2OsCleNRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94F42CE191C; Thu, 24 Apr 2025 07:47:38 -0700 (PDT)
Date: Thu, 24 Apr 2025 07:47:38 -0700
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
Message-ID: <2219e88b-61a5-4176-bec8-73e6db9a36cc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250108090457.512198-1-bigeasy@linutronix.de>
 <20250108090457.512198-16-bigeasy@linutronix.de>
 <db0f8ec385762e6edb3edf5054a76ea189135e6e.camel@sipsolutions.net>
 <4446525f-4e89-41bb-91a0-89c72dd0e8f8@paulmck-laptop>
 <20250424090539.0O37K8vN@linutronix.de>
 <bc9896f2470c70519c3b9257a1a2dd32e5e9c6e9.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc9896f2470c70519c3b9257a1a2dd32e5e9c6e9.camel@sipsolutions.net>

On Thu, Apr 24, 2025 at 11:30:39AM +0200, Benjamin Berg wrote:
> On Thu, 2025-04-24 at 11:05 +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-04-23 11:16:49 [-0700], Paul E. McKenney wrote:
> > > On Wed, Apr 23, 2025 at 05:17:31PM +0200, Benjamin Berg wrote:
> > > > Hi,
> > > > 
> > > > On Wed, 2025-01-08 at 10:04 +0100, Sebastian Andrzej Siewior wrote:
> > > > > __module_text_address() can be invoked within a RCU section, there is no
> > > > > requirement to have preemption disabled.
> > > > > 
> > > > > Replace the preempt_disable() section around __module_text_address()
> > > > > with RCU.
> > > > 
> > > > Unfortunately, this patch causes a performance regression for us. The
> > > > trouble is that we enable kmemleak and run trace-cmd so a lot of stack
> > > > traces need to be collected. Obviously, we also have lockdep enabled.
> > > > 
> > > > Now, combine this with the UML stack dumping code calling into
> > > > __kernel_text_address a lot[1] and it really has a relevant performance
> > > > impact. I saw the kernel spending 40% of its own CPU time just on the
> > > > lock in is_module_text_address.
> > > > 
> > > > Maybe kernel_text_address should leave the RCU handling to the caller
> > > > and assume that the RCU read lock is already taken?
> > > > 
> > > > Benjamin
> > > > 
> > > > [1] The UM arch dump_stack function reads every "unsigned long" on the
> > > > stack and tests it using __kernel_text_address.
> > > 
> > > Use of a single guard(rcu)() is regressing performance?  Interesting and
> > > quite unexpected.  That said, tiven the amount of debug you have enabled,
> > > I am not so sure that people are going to be all that excited about a
> > > further performance regression.
> > > 
> > > But is this regression due to the cleanup hook that guard(rcu)()
> > > registers?  If so, please feel free to try using rcu_read_lock()
> > > and rcu_read_unlock() instead.  I would be surprised if this makes a
> > > difference, but then again, your initial regression report also comes
> > > as a surprise, so...
> > > 
> > > Another way to reduce guard(rcu)() overhead is to build your kernel
> > > with CONFIG_PREEMPT_NONE=y.  Not so good for real-time response, but
> > > then again, neither are your debug options.
> > 
> > The guard notation is not regression I guess it is just the plenty of
> > rcu_read_lock()/ unlock(). We had one regression which was "fixed" by
> > commit ee57ab5a32129 ("locking/lockdep: Disable KASAN instrumentation of lockdep.c").
> 
> Yup, we really pretty much created a micro-benchmark for grabbing stack
> traces.
> 
> > My guess would be that this is a preemptible kernel and the preempt
> > disable/ enable is cheaper that the RCU version. So going back to a
> > non-preemtible kernel should "fix" it.
> 
> Yes, preempt_disable() is extremely cheap.
> 
> > Looking at kernel_text_address(), is_bpf_text_address() has also a
> > RCU read section so probably subject to the same trouble. And
> > is_ftrace_trampoline() could be also converted to RCU which would
> > increase the trouble. 
> > 
> > Improving the stack trace on UM or caching some of the most common one
> > might help. Not sure if disabling kmemleak for lockdep is possible/
> > makes a difference.
> 
> What does seem to help is to simply disable lockdep inside dump_trace.
> That should be good enough for us at least, bringing the overhead down
> to a manageable amount when running these tests.
> Some unscientific numbers:
> 
> config                               dump_trace     locking
> ----
> no locking (preempt_disable)            6 %         -
> guard(rcu)() + lockdep_off             15 %         58 % of that
> rcu_read_lock + lockdep_off            17 %         60 % of that
> guard(rcu)()                           48 %         91 % of that
> 
> That confirms that guard(rcu)() really is not a problem. There might be
> slight overhead, but it is probably within the margin of error. Turning
> lockdep off/on inside the UML dump_trace() function brings down the
> overhead a lot and I guess that should be an acceptable level for us.

Whew!!!  ;-)

> Not sure if something like that would be desirable upstream. This is
> happening for us when running the hostap "hwsim" tests inside UML (with
> time-travel). At least internally, we could carry a custom patch to add
> the lockdep_off()/lockdep_on() to dump_trace in order to work around
> it[1].

That makes sense to me, but I am not the maintainer of that code.  ;-)

							Thanx, Paul

> Benjamin
> 
> [1] Actually, now I am reminded that we already have that for kmemleak
> as lockdep was considerably slowing down the scanning.
> 
> > 
> > > 							Thanx, Paul
> > 
> > Sebastian
> > 
> 
