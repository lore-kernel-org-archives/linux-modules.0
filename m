Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062554A3402
	for <linux-modules@vger.kernel.org>; Tue, 14 Jul 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044869; cv=none; b=LGVwUldFurdvtTMHIWUuG+3jspBOJGf6s0QUJYuVTfmJbWBPdCSSWtvIgVsHNQZz1oZChRhFLBDLr2G2kvUDRxYDAK04JkVIXtuPAqbQoa3fIaupG/88iiRBeVcdjsif7rCLo/21D2O7Li04X1DHsv/MNAPgUR8DOtkigwDuLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044869; c=relaxed/simple;
	bh=u4lTDPeSMiO04wCV+mqY/aRa6UGP/ND8+dKzBNBm5YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYyRyDI18M5m/Zkr+fsegazXX/X4moF8ugziFUzqrVnGOTxN51gGMktMguJaNFjvrv8nwjf/u+w98bAuwOregnvDvBkJhrSvwkxWmrF4s5lNSDOgtol+0fr+Q0v8HXxXIYn5kHYvQ5QuRlyazxzkomHCwlfGb7YRFkHvzyp9Dec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y7xEWWzY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ejRPvJPM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y7xEWWzY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ejRPvJPM"
Date: Tue, 14 Jul 2026 18:01:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784044865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrjQC+j8aq582qmodbAAvVYj6iNLW6QD7qGJZ6E4cyY=;
	b=Y7xEWWzY8kssTcYzUW6DEIlNpndSA8yQara1uuFOck3GWaM4Yw8bgn78jj26LEL7fsdWNq
	91+UtlUJSlZU7iYL/NWpCaLFSPIiWJ47RWjXp4zVnLD3nKxH9CAu/GKQZgqD6UfLPJMiwA
	M6uTrH4mgQdNxMFrOCOwyXFPtBwUfU1gz/FdQAm6H2Gqo7+va/kE7sBLXA8faqA+ra1sVs
	JhPkiqmbxvhKcJPW9T4Km3Xh4xOSTcb1aOhD6C3eNm/pVS+9LLMr5gYFQgpnCMD8Kq07k3
	xB4VujdbxSAiNw6L7/r6+6ps57wXPwqcm1p5ReCaSUu8yA1xv4mGi8VjR0OECg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784044865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrjQC+j8aq582qmodbAAvVYj6iNLW6QD7qGJZ6E4cyY=;
	b=ejRPvJPMwzmpnswcyyNSySoXrwMN5JwGCAe6pbjkPppzVnkskm1OG3xqx/II62N52SeDne
	tQuylfkVZoCtsJDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
Message-ID: <20260714160104.jK83e41c@linutronix.de>
References: <de2616b3-6edf-4255-ba77-0674e225ab27@linux.dev>
 <akfjpBVML_1RFF91@gmail.com>
 <87111f02-5b7a-4185-8364-2faba650578b@linux.dev>
 <20260706092926.PIlrhRKz@linutronix.de>
 <0dfe59c2-bf60-40fe-90e6-d6e1003709d0@suse.com>
 <20260708074904.xnpi0mlh@linutronix.de>
 <bef05178-4856-4b62-9c3b-62bf636c239d@suse.com>
 <20260708135651.zl03TEfr@linutronix.de>
 <20260708190003.gmLFJGYo@linutronix.de>
 <70060a4e-4630-487f-8ecc-4408e23268d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <70060a4e-4630-487f-8ecc-4408e23268d4@paulmck-laptop>

On 2026-07-08 12:22:58 [-0700], Paul E. McKenney wrote:
> The RCU-callback ordering guarantees are quite weak:
=E2=80=A6
So this is not working.

> What you maybe *could* do is to have the two RCU callbacks communicate,
> so that the last one to be invoked did the work of both of them.  For
> example, use a shared variable initialized to 2, then have each callback
> do atomic_dec_and_test(), with the "winner" doing the work.
>=20
> Would that do the trick?

This would work but we would have to fix each one or make it slower for
everyone in the common case. So I think adding a rcu_barrier() to module
unload wouldn't be that bad and Petr did not say "get out" so ;)

I've been looking a bit more:
- fs/netfs/objects.c
  call_rcu(&rreq->rcu, netfs_free_request_rcu). No rcu_barrier or
  flush_worker.=20

- net/sched/sch_taprio.c
  call_rcu(&oper->rcu, taprio_free_sched_cb) from with the destroy
  callback. There is a rcu_barrier() but for classification not qdisc.

- drivers/net/tun.c.
  tun_free_netdev() from the net_device::priv_destructor.

The net things _might_ be okay since there is netdev_run_todo() with a
rcu_barrier() which is run at rtnl_unlock(). So it might work.

- drivers/vfio/pci/vfio_pci_core.c
  call_rcu() but I don't see anything rcu_barrier() like.

- security/keys/trusted-keys/trusted_core.c=20
  security/keys/encrypted-keys/encrypted.c
  call_rcu() from an update callback. No rcu_barrier in security/.
  This looks "easy".

- drivers/gpu/drm/lima/lima_sched.c
  lima_fence_release() does call_rcu() from an release callback. Don't
  see anything that would enforce a rcu barrier here. The remove path
  has also a lima_sched_slab_fini() which removes the slab cache used in
  the rcu callback.

And we had the infinibad thing which got fixed in the meantime.
So I *think* this qualifies for an rcu_barrier() in the module unload
path. No objections I guess?

> 							Thanx, Paul

Sebastian
