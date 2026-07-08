Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469683C5823
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537208; cv=none; b=Y9GeDw6/bRN7zaBHqOWFt1Qjg+YA5RnCBomXpaQWCVHiS6mX47SxwZXLbESgcPai8cEmenTesa9Ne0gaDfUR+HFyuga77Crh2UeHk3YRIayXbuMEbqyU3AjZJewOWX+x3/VydPJ1+csLbBhRdycteN5Y9cWIkCdLMfrQDuFd+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537208; c=relaxed/simple;
	bh=u9F89pN4SuQ/3PPckQ02ildggGatpsk9Xbh1o2X5/9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1ag7pS50fiFwXszLLN5mJLJ1doHvUwAgdVRvxsbbBrJztUjS27stcwtSGjUriVzJXKH1Z9/hnn2yVtkJecHPwuXNpL4hJE7ZSq2v5tA3h1v0saPAt1Z9b1ixCVHn6E6GyWatBvC4VKAc3Sg6sCK448cf9ti4QPHAGogkCu4G7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MbmsRiln; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LlQs4mL/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MbmsRiln";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LlQs4mL/"
Date: Wed, 8 Jul 2026 21:00:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783537205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQ1QEPf+fCfjAT2+s2yP2LtF2yqy3ibkRKg2JCFFtBI=;
	b=MbmsRilnHNfAxG1SxZaiknyQUsiydbo7SovFOhQQhlZSkLhs8Qo/e+P+yGE/bqqpFACTCt
	cvdw9HEO/8RJO7YkQz1M+TYMIpqZim7ZGQP2VQidG+/8731jlUQnqXmtpvddzGAJgiqaLn
	Rae7TYNvyHorhHLbLVQRNP9bNyt6BQ08F+BA0Udb0GXD3PnHVE9kqYX7xsyOa5GmrOhOqw
	YSBp5z3WaxRb+G2DM6Yftwo2j3H7LOVHhQrMgGMydQyY7doKF7iiFf19VWTZkzixGxnpNg
	eIeZKxQ0+tAXp/zcvakUut9soXK3yySifki6VVq8i032ndyNj8RILZKU5QWkog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783537205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQ1QEPf+fCfjAT2+s2yP2LtF2yqy3ibkRKg2JCFFtBI=;
	b=LlQs4mL/kZx/sJJG9aTTwsOq8nvfPqx7gd/uet4yZ/FNu0g3wYLSnfNPn188pevUZBHTTc
	YTL9BquC3aZv31DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
Message-ID: <20260708190003.gmLFJGYo@linutronix.de>
References: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
 <de2616b3-6edf-4255-ba77-0674e225ab27@linux.dev>
 <akfjpBVML_1RFF91@gmail.com>
 <87111f02-5b7a-4185-8364-2faba650578b@linux.dev>
 <20260706092926.PIlrhRKz@linutronix.de>
 <0dfe59c2-bf60-40fe-90e6-d6e1003709d0@suse.com>
 <20260708074904.xnpi0mlh@linutronix.de>
 <bef05178-4856-4b62-9c3b-62bf636c239d@suse.com>
 <20260708135651.zl03TEfr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708135651.zl03TEfr@linutronix.de>

-*, +module +Paul.

On 2026-07-08 15:56:53 [+0200], To Petr Pavlu wrote:
> > One problem is that I'm not sure where the new rcu_barrier() call should
> > be placed. The prototype adds it before calling the module's exit
> > function. Would this actually fit all modules? From a quick look, I can
> > see that various modules call it at different points during their exit.
> 
> I don't know why you would use call_rcu() in your module_exit()
> (pointing to the same module). But you could have call_rcu() invoking
> kmem_cache_free() and destroying that cache (kmem_cache_destroy()) in
> your exit path. From that perspective it would make sense to flush all
> calls before invoking module_exit().

Paul, are the RCU callbacks always invoked in FIFO order?
If we put the module unmap into a call_rcu() (instead of the current
synchronize_rcu()) would we invoke the callback's of the module's
callback before the unmap of the module? Or is this not guaranteed due
callbacks on CPU0 vs CPU1 are executed in different order?

Because if the FIFO order is guaranteed then it would be cheapest
solution. But it would require a rcu_barrier() in kmem_cache_destroy()).

> > -- 
> > Thanks,
> > Petr

Sebastian
