Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140043EDE46;
	Wed,  8 Jul 2026 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501912; cv=none; b=daZN94+1pQThtMOmeK2bnDMJrcnj8n3N3RleIAJ9T+TScXjzZbnOY1dFlYucBCYlB6EIg2iKh6xXhmkSfxOkEVgab+IlI8WgsPuersJ02TmihkdlgwETRGe3oVKB08vBEB12Pt+9cGj2/mMnpIa2ErHTSg3L/M/87j9f07nj5+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501912; c=relaxed/simple;
	bh=l6JFG91mW4G/R7fCfssf6gK5hHZ7Nor2KNHzJAv9e7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOZnMQ66C11Y0ZV6GR/zDaKWP9iB+ZwLKr9g8wZVGmcPg9xL8x5e88Yf1sFHSHWRKgpm/Kw5whcwCICdPX4BHGmBa1axs7gy4R+cWtUUdror/aBHcrOgB7uZcudp3mmXjsIYqyDpoP6hZGcfUhHVC3gZpkmam+MK9dWwKxKRuaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BmEmoPDU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8LVnaRQu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BmEmoPDU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8LVnaRQu"
Date: Wed, 8 Jul 2026 11:11:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783501909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h20LA5YHcmtZeGTDYEJk05BGftpy3fA0SNQGNgHnfeQ=;
	b=BmEmoPDUE7RTx+O7SGa8Sfj20DHd8nsSSyeAnXbAkrIXfNnYd52ncDrPcrhUZsZLL3n4KJ
	NV7mHh5snAJuqdcw1CV/pMqodej5EzEsCN5rjJ+smi9c4NG+LFQN8KsGRMEqj//80ybY2h
	l7AT/M6Rp4TNGdMXh6aSUmCGQReGIms9I+Q8lbvK911eMGhpBjBHNSjTLvIekjc+alr+8A
	1uE1nfoo3m06k9+3z8FnWkTGLeoBJT32QZBN+TsCZgMdQucW9Jz213gLfGUTdSjLyUzamE
	XEE7AagAEnUQyJc8y6ZT75pQLlW4xqxbV/8rtdSJIPDnLszkLhyyTlvP4LMJzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783501909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h20LA5YHcmtZeGTDYEJk05BGftpy3fA0SNQGNgHnfeQ=;
	b=8LVnaRQujGpEmXl1EKf5Dzy+QxRHLNbyF7X+jFHRdO/pk9s+Ca4LFbi8rLef0/CvI57MFy
	NQfpOW0HMJW4qZDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
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
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
Message-ID: <20260708091147.O1d41Vi0@linutronix.de>
References: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
 <de2616b3-6edf-4255-ba77-0674e225ab27@linux.dev>
 <akfjpBVML_1RFF91@gmail.com>
 <87111f02-5b7a-4185-8364-2faba650578b@linux.dev>
 <20260706092926.PIlrhRKz@linutronix.de>
 <0dfe59c2-bf60-40fe-90e6-d6e1003709d0@suse.com>
 <7ff3af97-1c10-4f46-84ae-ffbf757f7e9e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ff3af97-1c10-4f46-84ae-ffbf757f7e9e@paulmck-laptop>

On 2026-07-07 09:39:01 [-0700], Paul E. McKenney wrote:
> Alternatives include:
> 
> o	Provide a patch like that above, but only execute the
> 	rcu_barrier() in some debug mode.  If your code works when
> 	that debug is enabled but does not otherwise, you add the
> 	rcu_barrier().
> 
> o	If debug is enabled, make rcu_do_batch() check the function
> 	before invoking it.  If the function is not mapped, issue a
> 	diagnostic, and don't try to invoke the function.  (But is
> 	there a sufficiently cheap way to check for the function not
> 	being mapped?)

In both cases you would see a backtrace and the name of the last
unloaded module. And since we don't see a lot of these reports, people
either don't run into this because it does not exist or RCU is quick
enough.

> 
> 							Thanx, Paul

Sebastian
