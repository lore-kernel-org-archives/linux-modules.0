Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD172AEE1
	for <linux-modules@vger.kernel.org>; Mon, 12 May 2025 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747084973; cv=none; b=H/TENSXTN18aj0H8BVItK9B+dSfprH4u6Vx4KHVKCn/vbyuwmWBklm/Vq5mBeiKeRWiFOT1ngtqwIA7Jy9HlfV3NjRfpMwdMNhFTiO5Vcn0RolOsOyfcG5HUoh3BwbgGLSwJmjahie/XqPnAeUcOgtAG7QEiY7GPMcarZnP2Lrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747084973; c=relaxed/simple;
	bh=SMBDwkB6ZO5EjlFwvEAuX+WqRipKGqgUOkdjOXdx+10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gj8XB072Oa5RtyMuRksJUNnzqI3foWyvR99U8rvN5H1dysPj2ZTA6lP6YqEQOy3aQAV2baHjeWAvCj4FH29W+1PFR+gC3RrCtPFLOteDhFnl0BoQntM95Jj2m77orw7YVpbKcUJ0Bq+tAEsHnedDbwTUWov3MDq2Do+9nopX4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=Fi0EJro8; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=DsLgap4S; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="Fi0EJro8";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="DsLgap4S"
Date: Mon, 12 May 2025 23:22:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1747084964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kc0U8uxLzvsmQSs0slkCejhK8ZuVOJ6poNnn3hgdMUU=;
	b=Fi0EJro8n8C2K5LBxV7hQt5hzApCIGTV+U2xaYECnU6SaMKahDecEKFLZQjuaJUl2PW/wE
	NFUEmGhDaLUdN4KVN89WLnrTXQWEK1/x+ed2TgQKgBOeB651PKPx9/LZaGYYeevlkUO74h
	NWHB+Z96qk/87sjxerSCcBcv8J34fCJ81CYgBjP11OrUHnpz7f/8/xmqAcpQW3WnXk4FBW
	AQfhElVx57A6m5Fg39FT/FptLJFrcYDqOJMnU55delPelmTvTxs6yrppqtbO02xCmMjoBh
	Nm7haMbKANPn9HzwtkmqrX5irxcx8ryrFXggQYTxIuH+UgwsCqbKZnIVrz+9Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1747084964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kc0U8uxLzvsmQSs0slkCejhK8ZuVOJ6poNnn3hgdMUU=;
	b=DsLgap4SotO5gYLBziaFz9yA794vm8wo+IunNIY1r2rmDqQB3VorQk7VPMFSSwOCL0mCTH
	UWrORXZQsG8L9FDQ==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] module: Use rcuref_t for module::refcnt.
Message-ID: <20250512212241.Jtv69FX7@breakpoint.cc>
References: <20250309121914.pN6eBMvI@breakpoint.cc>
 <2362aa50-67fc-4535-b0eb-26f50066710b@suse.com>
 <20250310212416.K2OGvLw7@breakpoint.cc>
 <0d4d5530-7e0f-4ccb-ba53-135e1eb65b89@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d4d5530-7e0f-4ccb-ba53-135e1eb65b89@suse.com>

On 2025-03-17 17:33:58 [+0100], Petr Pavlu wrote:
> >> I'd understand changing module::refcnt from atomic_t to refcount_t, but
> >> it isn't clear to me from the above description what using rcuref_t
> >> actually gains. Could you please explain why you think it is more
> >> appropriate over refcount_t here?
> > 
> > I seems easier to handle without the atomic_inc_not_zero() and
> > atomic_dec_if_positive().
> 
> I think the use of atomic_inc_not_zero()/refcount_inc_not_zero() is
> a common pattern. The call to atomic_dec_if_positive() would be with
> refcount_t in this case replaced by refcount_dec(). That looks fairly
> comparable to me to the rcuref_t version.

It is a common pattern. The difference is that atomic_inc_not_zero() is
implemented as cmpxchg loop while rcuref_get() is implemented as an
unconditional get. Now: The cmpxchg loop might need a retry if there are
two simultaneous gets while rcuref_get() does always the increment. So
if you have simultaneous gets you can see a performance improvement with
rcuref_t, see for instance
	https://lore.kernel.org/all/202504221604.38512645-lkp@intel.com/

> > rcuref_get() is implemented as an implicit inc and succeeds always as
> > long as the counter is not negative. Negative means the counter has been
> > probably released and the slowpath decides if it is released or not.
> > Eitherway you get rid of all the WARN_ON()s and the dec/ inc dance in
> > try_release_module_ref() where you simply attempt the final "put" and if
> > this one fails (because a refence is still held) you attempt to get the
> > inital reference and can decice if it was successfull or not.
> > If the puts outweight the gets then you see a warning from the rcuref()
> > code itself.
> 
> Sure, but having these warnings would be the case also with refcount_t,
> no?

The first put will fail, so it will attempt a get. If the get succeeds
then the initial reference has been obtained and the object will remain.
If the get fails, then the object has been properly released (there was
a put in between). So the state is eitehr/ or.

> I see that rcuref_t is so far used by dst_entry::__rcuref, for which it
> was originally added, and k_itimer::rcuref. I'm not sure if there's any
> guidance or prior consensus on when to use refcount_t vs rcuref_t.
> I understand some of the performance advantage of rcuref_t, but I wonder
> if code that doesn't substantially benefit from that, such
> module::refcnt, should now use it, or if it should stick to the more
> common refcount_t.

It is kind of new, yes. The big performance benefit comes when you have
multiple puts/gets in parallel. But if you don't you don't lose
anything. There is also file_ref_t which is the same as rcuref_t from
the principle of operating but different in terms of counter size and
memory barriers.

Sebastian
