Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7233DED5
	for <linux-modules@vger.kernel.org>; Tue, 14 Jul 2026 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051291; cv=none; b=LZvf/LBrDncRW9Imz672VW6qPx2HFqOSgbD3wMMzWI4n8o69VxoE9Y0uQvvzmVR1oUON7ksX/uHuJ/baG+IY+06VhmuoWAXb++VcpPfDTHqzOJ3jzwlXNsndNB1b5Xefa0wQvA0QDMQsKsDAO5dQcuXHRt9o0Lfxqpn99YWdJpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051291; c=relaxed/simple;
	bh=A2ViJy86+k/tSmtxjeK3BCF9u6smHXKnpVrcP+kwu8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzhXBfXPxYgaHl/YyuSR5NOP5s+vwFPUoBO3lOXlgsAk8sFEHghabZcxWrFrJ7JPcFMbl8RTIIxOR2s3CMLLkOMNUBmxI+oSK2Ffqgfa1hI6c9g2Bsxh+SYnbLGrwvELfIXjo2w8MS8g+htZ8JPnhtTqtKJhptOOh6lXK4TSTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKINiHDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKINiHDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871211F000E9;
	Tue, 14 Jul 2026 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784051278;
	bh=tnpfLCQIOwF41V2REqYRkLyxTLtRNd2VZdLX4N6XSGU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=kKINiHDKh3WBXFiqpCydFBgg4fz+KF+USEpKYx/l/UI9BePsMwkCFVnE47mG3AheU
	 jDulvI5+jywX8qzJJHz9D0MVAgPRCmj98kaTJz+ywoJCjukedXhRNdC+yX94YUrgS3
	 ZFfskUBEzRcejFaT9NRrNBE/KKvDx8MLdRdQ1j1HrvAuapxSEWpJ3mcIM5cIk6kBEK
	 U/Tb3NVI2E0prgW23TwIvao1nSJgQockjLosHOdMpR8dMUNlk1AXe7i3jx23+5IaZ3
	 Su5F2o+5rFn9dNd55yg9jbJ88loAoWmy9sQ8Q9qKgloT6SIOJJl/cId3VLlObUs6qA
	 cYXbhKS1V5Y+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 49580CE054B; Tue, 14 Jul 2026 10:47:58 -0700 (PDT)
Date: Tue, 14 Jul 2026 10:47:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
Message-ID: <b7b5a7f1-7d09-4181-9257-ea9272325ef2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <akfjpBVML_1RFF91@gmail.com>
 <87111f02-5b7a-4185-8364-2faba650578b@linux.dev>
 <20260706092926.PIlrhRKz@linutronix.de>
 <0dfe59c2-bf60-40fe-90e6-d6e1003709d0@suse.com>
 <20260708074904.xnpi0mlh@linutronix.de>
 <bef05178-4856-4b62-9c3b-62bf636c239d@suse.com>
 <20260708135651.zl03TEfr@linutronix.de>
 <20260708190003.gmLFJGYo@linutronix.de>
 <70060a4e-4630-487f-8ecc-4408e23268d4@paulmck-laptop>
 <20260714160104.jK83e41c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714160104.jK83e41c@linutronix.de>

On Tue, Jul 14, 2026 at 06:01:04PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-07-08 12:22:58 [-0700], Paul E. McKenney wrote:
> > The RCU-callback ordering guarantees are quite weak:
> …
> So this is not working.
> 
> > What you maybe *could* do is to have the two RCU callbacks communicate,
> > so that the last one to be invoked did the work of both of them.  For
> > example, use a shared variable initialized to 2, then have each callback
> > do atomic_dec_and_test(), with the "winner" doing the work.
> > 
> > Would that do the trick?
> 
> This would work but we would have to fix each one or make it slower for
> everyone in the common case. So I think adding a rcu_barrier() to module
> unload wouldn't be that bad and Petr did not say "get out" so ;)

I am not opposed to rcu_barrier() in module unload.

But just to fill out the other similar situations...

In addition to call_rcu(), there is call_srcu(), call_rcu_tasks(),
and call_rcu_tasks_rude().  I think that we can rule out call_srcu()
as ridiculous because there could have been an arbitrarily large number
of srcu_struct structures passed to call_srcu() along with callback
functions defined within this module.  For their parts, call_rcu_tasks()
and call_rcu_tasks_rude() are special-purpose functions that are rarely
used and could therefore be ignored.

But what about things like timers and hrtimers?  Or are people already
doing the right thing for such things?

> I've been looking a bit more:
> - fs/netfs/objects.c
>   call_rcu(&rreq->rcu, netfs_free_request_rcu). No rcu_barrier or
>   flush_worker. 
> 
> - net/sched/sch_taprio.c
>   call_rcu(&oper->rcu, taprio_free_sched_cb) from with the destroy
>   callback. There is a rcu_barrier() but for classification not qdisc.
> 
> - drivers/net/tun.c.
>   tun_free_netdev() from the net_device::priv_destructor.
> 
> The net things _might_ be okay since there is netdev_run_todo() with a
> rcu_barrier() which is run at rtnl_unlock(). So it might work.
> 
> - drivers/vfio/pci/vfio_pci_core.c
>   call_rcu() but I don't see anything rcu_barrier() like.
> 
> - security/keys/trusted-keys/trusted_core.c 
>   security/keys/encrypted-keys/encrypted.c
>   call_rcu() from an update callback. No rcu_barrier in security/.
>   This looks "easy".
> 
> - drivers/gpu/drm/lima/lima_sched.c
>   lima_fence_release() does call_rcu() from an release callback. Don't
>   see anything that would enforce a rcu barrier here. The remove path
>   has also a lima_sched_slab_fini() which removes the slab cache used in
>   the rcu callback.
> 
> And we had the infinibad thing which got fixed in the meantime.
> So I *think* this qualifies for an rcu_barrier() in the module unload
> path. No objections I guess?

No objection, just calling attention to the possible follow-on to this
particular camel's nose.

							Thanx, Paul
