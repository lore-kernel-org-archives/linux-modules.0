Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A83C872C
	for <linux-modules@vger.kernel.org>; Wed, 15 Jul 2026 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103923; cv=none; b=LL5jgh1rDMMhDRuod/vFtrz7EsfBO3G3o8U2aNYsPvkErzBtK4kjnNCLTY/DxJ+cy4btPKXHudME5pFECKmuQOQ2ELsgjV6F6vSzg4NN57Xd/bwb+b8MBSfWVcE0NL0q4RKxHDlI8Sh9wNPM1SgAQxZnsHKKaKkwSMA2NLgX2zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103923; c=relaxed/simple;
	bh=wun9MLbhdN5K7oMmeoUdvCdwu5sJ4gkMOK8Y7R9EMlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvuWMtSO46pf0LNDlAE+6AGfZBWprJcuZohGb3bfAWgUzxbRd6+gffHYZUBGthjss6GzZBRuuT70e/MQ7dXJePeFOAh0rEq32RQr1bO0lVAXTPMPhOQMaoqcvoCunZJk/wjCliPiNVmYn06k+KKkVr1RdfXwQWlzB7NnaX1CvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xEZ2hVcH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5ZJETz/G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xEZ2hVcH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5ZJETz/G"
Date: Wed, 15 Jul 2026 10:25:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784103920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fgk/0xmibRED3QGCq/OcCyCI0e7hkBGIzhmH0vUyY58=;
	b=xEZ2hVcHK+Q3o+pzFnTYHA6GtAxHlv8AZviLm20czcw+JViqAlB500ftTeVeBhn1jK3tNt
	N7jtjt7TeKHDrcfwwUkojFIK+BJ6dXFIH3InEMdHkBwh5iEfqskjK4ozZAw7ix79ONNOG6
	Y2Lvto/mCxMdqO7E1BoFp5qgFrVFB4vOM0DieaQRTVR/GS8tWOcgOiwB/Ndl38dmFKh8DX
	F+pgoQjYTU1I4nQR0j34pg7bktljcX0AQGlKE2RFEBBHf59o0qRV9bFsAou4XwrMJ1YMnv
	4sWv46j7EtMakpdetbt0XbG7yxHD3GXOFGUSduzystLhaMfsSWPxdERbaztw+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784103920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fgk/0xmibRED3QGCq/OcCyCI0e7hkBGIzhmH0vUyY58=;
	b=5ZJETz/GfBX8pd7kQdH42ifHa/RYE2dbrUq9Es4wM6m4hre/kZVyfau4gp0n7PIWPK2Iz1
	wRrntRAY12PMBSBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
Message-ID: <20260715082518.3z_iDNrR@linutronix.de>
References: <87111f02-5b7a-4185-8364-2faba650578b@linux.dev>
 <20260706092926.PIlrhRKz@linutronix.de>
 <0dfe59c2-bf60-40fe-90e6-d6e1003709d0@suse.com>
 <20260708074904.xnpi0mlh@linutronix.de>
 <bef05178-4856-4b62-9c3b-62bf636c239d@suse.com>
 <20260708135651.zl03TEfr@linutronix.de>
 <20260708190003.gmLFJGYo@linutronix.de>
 <70060a4e-4630-487f-8ecc-4408e23268d4@paulmck-laptop>
 <20260714160104.jK83e41c@linutronix.de>
 <b7b5a7f1-7d09-4181-9257-ea9272325ef2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b7b5a7f1-7d09-4181-9257-ea9272325ef2@paulmck-laptop>

On 2026-07-14 10:47:58 [-0700], Paul E. McKenney wrote:
> On Tue, Jul 14, 2026 at 06:01:04PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-07-08 12:22:58 [-0700], Paul E. McKenney wrote:
> > > The RCU-callback ordering guarantees are quite weak:
> > =E2=80=A6
> > So this is not working.
> >=20
> > > What you maybe *could* do is to have the two RCU callbacks communicat=
e,
> > > so that the last one to be invoked did the work of both of them.  For
> > > example, use a shared variable initialized to 2, then have each callb=
ack
> > > do atomic_dec_and_test(), with the "winner" doing the work.
> > >=20
> > > Would that do the trick?
> >=20
> > This would work but we would have to fix each one or make it slower for
> > everyone in the common case. So I think adding a rcu_barrier() to module
> > unload wouldn't be that bad and Petr did not say "get out" so ;)
>=20
> I am not opposed to rcu_barrier() in module unload.
>=20
> But just to fill out the other similar situations...
>=20
> In addition to call_rcu(), there is call_srcu(), call_rcu_tasks(),
> and call_rcu_tasks_rude().  I think that we can rule out call_srcu()
> as ridiculous because there could have been an arbitrarily large number
> of srcu_struct structures passed to call_srcu() along with callback
> functions defined within this module.  For their parts, call_rcu_tasks()
> and call_rcu_tasks_rude() are special-purpose functions that are rarely
> used and could therefore be ignored.

Regarding srcu, module unload should have cleanup_srcu_struct() which
would flush pending item, no?

> But what about things like timers and hrtimers?  Or are people already
> doing the right thing for such things?

Right. What people often did wrong with timers is that they enqueued a
timer then forgot about it and released the memory with the timer
active. Then someone who got all the timer bugs assigned came up with
debugobjects.

This checks only that the memory is not released while the object is
active. It does not verify the callback.

I think it depends on what we want to achieve. We could iterate over all
RCU callbacks checking if it belongs to the memory that we intend to
free. The same could be done for timers, too. They should be caught by
debugbjects unless they leak the memory=E2=80=A6

The rcu_barrier() before module_exit() would ensure the callbacks are
done before a possible kmem_cache_free() where the cache is removed in
the exit function. Now I see that for !SLUB_TINY there is a barrier if
the cache has sheaves (kmem_cache_destroy() ->
kvfree_rcu_barrier_on_cache()). Buh=E2=80=A6

> 							Thanx, Paul

Sebastian
