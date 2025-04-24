Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F080205E34;
	Thu, 24 Apr 2025 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487048; cv=none; b=LoUnYmNJ5A7sQDjHExvrIv/zNtMbzhXlrrMs7HeO/O7JhOfIsJU9Ne5Ugc8wIHYs0IGx32Pr83dE9g6fNabh4jSfBzQjImtr02qIXTjYj5lYRqAgitn1Kp4xN5AkT/88AEgExGuKigtlj4APpSmqwwWxoDRR9NLtEIzQrkHEfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487048; c=relaxed/simple;
	bh=taJ25v7BecY6Hb0vwCJAfsxO+KMfgxuJA7gLq6CzpbU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q09dcaL1U2pYORC9/XyqMflHGNxTdOuMJ9FO2PaLFMdLO1aBsOrda/sL6SuBTu/YhRSjBbYZbulQBkn+RTYv+0wbLwrEmVmy/9WFOBfE4gwbmg0i4FJIc2b6D5nwUwGnDAKIdBqwQ5AEnqit/fr2SDhJB923XUWNHFrnq+9qvVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rGsMUB+6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rGsMUB+6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=U7peuKN6TtXCN3LsiGw8eaRb2QQ7ZZqgkZWgO6FWmEg=;
	t=1745487046; x=1746696646; b=rGsMUB+6MfB25IwxbAM62uZun/I03GcHkd3eQUu13IKOKTf
	r6/EbxXv6V6VXknzmcB8aEYMaOtas3CrwXqu9H8RJ5JDcKSDUeIgbHD3QRBzTXt7AyhzoGqQoXaFF
	oqMZJXo7Ss1UUjnjBvPD2X9Cp854r/Fv928c9dN1rcIE7YZCGqzirP/Uxehrmg4N/VxxN4Q16iCxc
	C2Cl2t1ZvfKvTju3Ls5WGDFRKfI1NVZCwlh1a69pe20C1KkwkR2Kg2rOzT7xkEnk6K0OQ7Ps5yl2U
	xnefAi9DmwKiuhCoA++da+/z7iDpmETP/YtPmDYqyyVSYCzvEkfJ4Ld/qhN4vqUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1u7sum-0000000GwTd-11Rb;
	Thu, 24 Apr 2025 11:30:40 +0200
Message-ID: <bc9896f2470c70519c3b9257a1a2dd32e5e9c6e9.camel@sipsolutions.net>
Subject: Re: [PATCH v3 15/28] module: Use RCU in all users of
 __module_text_address().
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Paul E. McKenney"
	 <paulmck@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	johannes@sipsolutions.net, Daniel Gomez <da.gomez@samsung.com>, Luis
 Chamberlain	 <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Petr Pavlu	 <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Thomas Gleixner	 <tglx@linutronix.de>
Date: Thu, 24 Apr 2025 11:30:39 +0200
In-Reply-To: <20250424090539.0O37K8vN@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
	 <20250108090457.512198-16-bigeasy@linutronix.de>
	 <db0f8ec385762e6edb3edf5054a76ea189135e6e.camel@sipsolutions.net>
	 <4446525f-4e89-41bb-91a0-89c72dd0e8f8@paulmck-laptop>
	 <20250424090539.0O37K8vN@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-04-24 at 11:05 +0200, Sebastian Andrzej Siewior wrote:
> On 2025-04-23 11:16:49 [-0700], Paul E. McKenney wrote:
> > On Wed, Apr 23, 2025 at 05:17:31PM +0200, Benjamin Berg wrote:
> > > Hi,
> > >=20
> > > On Wed, 2025-01-08 at 10:04 +0100, Sebastian Andrzej Siewior wrote:
> > > > __module_text_address() can be invoked within a RCU section, there =
is no
> > > > requirement to have preemption disabled.
> > > >=20
> > > > Replace the preempt_disable() section around __module_text_address(=
)
> > > > with RCU.
> > >=20
> > > Unfortunately, this patch causes a performance regression for us. The
> > > trouble is that we enable kmemleak and run trace-cmd so a lot of stac=
k
> > > traces need to be collected. Obviously, we also have lockdep enabled.
> > >=20
> > > Now, combine this with the UML stack dumping code calling into
> > > __kernel_text_address a lot[1] and it really has a relevant performan=
ce
> > > impact. I saw the kernel spending 40% of its own CPU time just on the
> > > lock in is_module_text_address.
> > >=20
> > > Maybe kernel_text_address should leave the RCU handling to the caller
> > > and assume that the RCU read lock is already taken?
> > >=20
> > > Benjamin
> > >=20
> > > [1] The UM arch dump_stack function reads every "unsigned long" on th=
e
> > > stack and tests it using __kernel_text_address.
> >=20
> > Use of a single guard(rcu)() is regressing performance?=C2=A0 Interesti=
ng and
> > quite unexpected.=C2=A0 That said, tiven the amount of debug you have e=
nabled,
> > I am not so sure that people are going to be all that excited about a
> > further performance regression.
> >=20
> > But is this regression due to the cleanup hook that guard(rcu)()
> > registers?=C2=A0 If so, please feel free to try using rcu_read_lock()
> > and rcu_read_unlock() instead.=C2=A0 I would be surprised if this makes=
 a
> > difference, but then again, your initial regression report also comes
> > as a surprise, so...
> >=20
> > Another way to reduce guard(rcu)() overhead is to build your kernel
> > with CONFIG_PREEMPT_NONE=3Dy.=C2=A0 Not so good for real-time response,=
 but
> > then again, neither are your debug options.
>=20
> The guard notation is not regression I guess it is just the plenty of
> rcu_read_lock()/ unlock(). We had one regression which was "fixed" by
> commit ee57ab5a32129 ("locking/lockdep: Disable KASAN instrumentation of =
lockdep.c").

Yup, we really pretty much created a micro-benchmark for grabbing stack
traces.

> My guess would be that this is a preemptible kernel and the preempt
> disable/ enable is cheaper that the RCU version. So going back to a
> non-preemtible kernel should "fix" it.

Yes, preempt_disable() is extremely cheap.

> Looking at kernel_text_address(), is_bpf_text_address() has also a
> RCU read section so probably subject to the same trouble. And
> is_ftrace_trampoline() could be also converted to RCU which would
> increase the trouble.=20
>=20
> Improving the stack trace on UM or caching some of the most common one
> might help. Not sure if disabling kmemleak for lockdep is possible/
> makes a difference.

What does seem to help is to simply disable lockdep inside dump_trace.
That should be good enough for us at least, bringing the overhead down
to a manageable amount when running these tests.
Some unscientific numbers:

config                               dump_trace     locking
----
no locking (preempt_disable)            6 %         -
guard(rcu)() + lockdep_off             15 %         58 % of that
rcu_read_lock + lockdep_off            17 %         60 % of that
guard(rcu)()                           48 %         91 % of that

That confirms that guard(rcu)() really is not a problem. There might be
slight overhead, but it is probably within the margin of error. Turning
lockdep off/on inside the UML dump_trace() function brings down the
overhead a lot and I guess that should be an acceptable level for us.

Not sure if something like that would be desirable upstream. This is
happening for us when running the hostap "hwsim" tests inside UML (with
time-travel). At least internally, we could carry a custom patch to add
the lockdep_off()/lockdep_on() to dump_trace in order to work around
it[1].

Benjamin

[1] Actually, now I am reminded that we already have that for kmemleak
as lockdep was considerably slowing down the scanning.

>=20
> > 							Thanx, Paul
>=20
> Sebastian
>=20

