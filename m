Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1781A0B13
	for <linux-modules@vger.kernel.org>; Tue, 10 Dec 2024 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832490; cv=none; b=kIbbvu0bch6NI7xSn+xzjikfDoqKZpGp2ImcojNPaW++/I0kgZ+lR3CMfeiFnzlJp7G/VjlGdOboa4Xpw8W6tjcSvv5P9sfGQYFuPfyDH3LNh53q13Zmo+4QfVBYu41ti74vaUBCl9RoOlOaJXVZQKcknsgec6Q2YBSFzw3vCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832490; c=relaxed/simple;
	bh=kp7arn24HTmwrF0WOW+V4THGERzTgPIJI2xqeeA/RgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkr9YvpqXCbPZIJu+nRektJPycAgG6jnc/USe4N7+GAvlNbiB7ruCo8mds809Vw8Ay3HLp7X1mX1a6DB6Zp7pL5erSkmps4qt/rhZ5W+uif4ng5TlBK6GdUVB75hLCUBiJ+9QDrXtaC21iy0GJ59IiOHkkIAV7AlJ+mTdgMlCZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bpXWDbPm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bpXWDbPm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DrUbPe9ig9e7kSPtCwMuijumMr4FzuYBXtNTbtsW+bQ=; b=bpXWDbPmH9SJS9CwM3PgzJHEQg
	z6+31VHsYp2/dqG9daeHsoImAyIfG+C7LKArmBXQYlLV4FPJhP1mkdMjLgybwHQeR3bOrItGtWG8L
	3XKorgYXpcvpPQvvFUl9vZ2lFowq2vG6gEJ46K6IPt7U7wxp8TisdjCLX1MNks6Qm2dUOAWUT7Hol
	dQ+Eme5mYZz3g89oDRVk9ZjC029xvz7lBLMJlqsnVxa7rlpOuD/DKF9z+SQtGURXteYn2JqRflASm
	LeZfKPseXJeRTq02jBGcvxNfKIpEUBmxePInpEJtAFFReTqGcYZHtq0r+swJ0//KAR46+fbne6sR/
	yVjHhtpw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKz22-00000003fPf-2pfT;
	Tue, 10 Dec 2024 12:08:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 02B3C30035F; Tue, 10 Dec 2024 13:08:02 +0100 (CET)
Date: Tue, 10 Dec 2024 13:08:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] module: Use complete RCU protection instead a mix of RCU
 and RCU-sched.
Message-ID: <20241210120801.GP21636@noisy.programming.kicks-ass.net>
References: <20241205215102.hRywUW2A@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205215102.hRywUW2A@linutronix.de>

On Thu, Dec 05, 2024 at 10:51:02PM +0100, Sebastian Andrzej Siewior wrote:
> The RCU usage in module was introduced in commit d72b37513cdfb ("Remove
> stop_machine during module load v2") and it claimed not to be RCU but
> similar. Then there was another improvement in commit e91defa26c527
> ("module: don't use stop_machine on module load"). It become a mix of
> RCU and RCU-sched and was eventually fixed 0be964be0d450 ("module:
> Sanitize RCU usage and locking"). Later RCU & RCU-sched was merged in
> commit cb2f55369d3a9 ("modules: Replace synchronize_sched() and
> call_rcu_sched()") so that was aligned.
> 
> Looking at it today, there is still leftovers. The preempt_disable() was
> used instead rcu_read_lock_sched(). The RCU & RCU-sched merge was not
> complete as there is still rcu_dereference_sched() for module::kallsyms.
> 
> The RCU-list modules and unloaded_tainted_modules are always accessed
> under RCU protection or the module_mutex. The modules list iteration can
> always happen safely because the module will not disappear.
> Once the module is removed (free_module()) then after removing the
> module from the list, there is a synchronize_rcu() which waits until
> every RCU reader left the section. That means iterating over the list
> within a RCU-read section is enough, there is no need to disable
> preemption. module::kallsyms is first assigned in add_kallsyms() before
> the module is added to the list. At this point, it points to init data.
> This pointer is later updated and before the init code is removed there
> is also synchronize_rcu() in do_free_init(). That means A RCU read lock
> is enough for protection and rcu_dereference() can be safely used.
> 
> Replace preempt-disable sections with RCU-read sections. Replace
> rcu_dereference_sched() with rcu_dereference(). Remove
> module_assert_mutex_or_preempt(), its goal is covered by the following
> RCU usage.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/module/internal.h | 11 -------
>  kernel/module/kallsyms.c | 45 +++++++++-------------------
>  kernel/module/main.c     | 64 ++++++++++++----------------------------
>  kernel/module/tracking.c |  2 --
>  kernel/module/version.c  | 11 ++++---
>  5 files changed, 38 insertions(+), 95 deletions(-)

There's more in kernel/jump_label.c and possibly other sites, grep for
__module_address.
