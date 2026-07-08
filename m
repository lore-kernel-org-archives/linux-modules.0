Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F2362143;
	Wed,  8 Jul 2026 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519016; cv=none; b=fCbO+pYdXlgtym5vpApBv9I/QfUpe788mgk99WBJwZ313Z51wrOS5UkOSWY5Ai8VQAfJ4cuzSaWcLO1Q0cRkUDUpsb12qqUQrjUzLXw27WN2+td6EZycPJl3PpihkhDhKHYz9+ZhebZgrTP9D9YCnMd++Bw+Cx24l78M+cZQraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519016; c=relaxed/simple;
	bh=ypqZAI1oU5JGm8/KBes9kuxTMKNdF+eggwaTNnsX/60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHISI0RShFWAxcdAn9gq18QvVNSIUOMqbDdic4RMk18tcNjkkJLh4UPiU2yCRaWDOZ7l8ECesjctEY3FlmSaKnUjXMD/xRA64CL0w1qZzlDLOQdHUoihBOQWtb1d54zMP3HCN0A+H1ZrI72aOivKdSwN7JwaVjBfnn0Q5i1ox/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kts+Lrlw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o23ljR+q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kts+Lrlw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o23ljR+q"
Date: Wed, 8 Jul 2026 15:56:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783519013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/V/epasgT8Yu7gP0faBZj8vgD9Xn8KwZKX1Je5vr8BI=;
	b=kts+LrlwbgtCLiPMljMBa4w+f9wrnW0MQWCXjB2ngOMBoLe5/NNKbDXJzDGwxIKL3m4ETj
	Q+5xZkLq1PabsFGyLadLSreAwYAvtDsfaTtYcmG1fKlHszCi0v993Um+SuxLN2S2x/SG5N
	uuWO4DEn/QehpKSv2uGL/naFZZzNWXTIN3uHjN3sLIn79/gq2rSUBNnzvVA6AXmrzHkjXY
	IsIxiNJE9vXEayEPOk3/3pAwJwnFUHg99zlWvyiBc0YwTQ36LybduUc4dCZJfpXr6MSq6c
	X4OnDTjKUI6QXfOW6uWJucw8w4bqz99kBSasUSBu9vLJSXFVKN1Rv8bpOsjI1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783519013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/V/epasgT8Yu7gP0faBZj8vgD9Xn8KwZKX1Je5vr8BI=;
	b=o23ljR+qd4kbANJJhPpv5c1eR9QZj4D3ewIVk6k6zz8twCFj9c2oXOOhLT4ekS1eS8AQaf
	tEKZOZlN3UZ79rCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Qingfang Deng <qingfang.deng@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Taegu Ha <hataegu0826@gmail.com>, Kees Cook <kees@kernel.org>,
	linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
Message-ID: <20260708135651.zl03TEfr@linutronix.de>
References: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
 <de2616b3-6edf-4255-ba77-0674e225ab27@linux.dev>
 <akfjpBVML_1RFF91@gmail.com>
 <87111f02-5b7a-4185-8364-2faba650578b@linux.dev>
 <20260706092926.PIlrhRKz@linutronix.de>
 <0dfe59c2-bf60-40fe-90e6-d6e1003709d0@suse.com>
 <20260708074904.xnpi0mlh@linutronix.de>
 <bef05178-4856-4b62-9c3b-62bf636c239d@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bef05178-4856-4b62-9c3b-62bf636c239d@suse.com>

On 2026-07-08 15:04:32 [+0200], Petr Pavlu wrote:
> As RCU usage in modules is now more common, I see an argument for the
> module loader to invoke rcu_barrier() during module unload to make RCU
> usage easier. In general, module unloading is a rare operation, so even
> if it becomes somewhat slower, I don't expect it to be a significant
> issue.

Okay.

> One problem is that I'm not sure where the new rcu_barrier() call should
> be placed. The prototype adds it before calling the module's exit
> function. Would this actually fit all modules? From a quick look, I can
> see that various modules call it at different points during their exit.

I don't know why you would use call_rcu() in your module_exit()
(pointing to the same module). But you could have call_rcu() invoking
kmem_cache_free() and destroying that cache (kmem_cache_destroy()) in
your exit path. From that perspective it would make sense to flush all
calls before invoking module_exit().

> -- 
> Thanks,
> Petr

Sebastian
