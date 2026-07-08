Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E02222C5;
	Wed,  8 Jul 2026 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519305; cv=none; b=tpUcAawF2rWJ6mGA4sjLXx3J0lfGNi3pumY8AjMYqMucl3WLqm851inoYcZXVH2vL/+BwP/44w8gCHUsMf7MiqyTPQhEGra/P6MH9haOSNZag0RmOfNR7MhiePRV1p+jbzvIMwwMLPWRS+9SBTFjz0kc1o3fsiFM5VirmVzd8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519305; c=relaxed/simple;
	bh=YC/qCa48WRz1F+/u1eBG35P/dZUcvcWdqRTkbNtiX2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IH7VMKqYhQPdFx772Q8zrLf3SRyI87+ZJQkYjPdNy7ATtj2KafbFSAIewUjI8F5MT5DiKnYkFtkQdmINZsEHTHyCqjI9h9Gr0He1y56CZDK+AO3Io1z6JLTAvcnzNEDN6YXVjdZ38QnPRiL6WwywAv2OIokre11B0xOFl9sQ16A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Apu/OFOx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apu/OFOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA26F1F000E9;
	Wed,  8 Jul 2026 14:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519303;
	bh=9iuqA1JnRaIWvxE2q0j98cwoSE0yjUDKHKevIN01wxQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Apu/OFOx4X6HeghfBzTIPllEGxDwqvapdQz8PF7LNNg9dqdzhoK8mu9wyjGR+7hKs
	 V2MLFHaxAhv9b5v1fi+L8g/ZYWNT8+5SJiSPR2EIVgSc8ewS1nUU2M+FNihm8mQomc
	 lQj6IoGpYmhyzplQY+9ghnXi8NmBfU6WueIKfv9wjz2Jw2Z046dFOD5lEuEs7iFF1k
	 dTUAqQ5Yl7xd6L28zrKOCEShE5YjRSzhVPcudjlo+IzHPqvLo38V4OcZRW4oT9CGC8
	 zb4ABjulHNgaDxMR3qIrvejR4OHvojRlHzp8vK6QgoR6YH/4rMFvPm5t1qdndGpDl1
	 PGv9OPJBWnRtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A57B0CE04B1; Wed,  8 Jul 2026 07:01:43 -0700 (PDT)
Date: Wed, 8 Jul 2026 07:01:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <b78eb36d-3d3e-4a08-ba8e-a1cdb084c41b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
 <de2616b3-6edf-4255-ba77-0674e225ab27@linux.dev>
 <akfjpBVML_1RFF91@gmail.com>
 <87111f02-5b7a-4185-8364-2faba650578b@linux.dev>
 <20260706092926.PIlrhRKz@linutronix.de>
 <0dfe59c2-bf60-40fe-90e6-d6e1003709d0@suse.com>
 <7ff3af97-1c10-4f46-84ae-ffbf757f7e9e@paulmck-laptop>
 <20260708091147.O1d41Vi0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708091147.O1d41Vi0@linutronix.de>

On Wed, Jul 08, 2026 at 11:11:47AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-07-07 09:39:01 [-0700], Paul E. McKenney wrote:
> > Alternatives include:
> > 
> > o	Provide a patch like that above, but only execute the
> > 	rcu_barrier() in some debug mode.  If your code works when
> > 	that debug is enabled but does not otherwise, you add the
> > 	rcu_barrier().
> > 
> > o	If debug is enabled, make rcu_do_batch() check the function
> > 	before invoking it.  If the function is not mapped, issue a
> > 	diagnostic, and don't try to invoke the function.  (But is
> > 	there a sufficiently cheap way to check for the function not
> > 	being mapped?)
> 
> In both cases you would see a backtrace and the name of the last
> unloaded module. And since we don't see a lot of these reports, people
> either don't run into this because it does not exist or RCU is quick
> enough.

Good point, the splat from calling the no-longer-mapped function should
call out the offending module.  So maybe our debug code is good enough
already.

							Thanx, Paul
