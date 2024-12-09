Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6C51EB2E
	for <linux-modules@vger.kernel.org>; Mon,  9 Dec 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746056; cv=none; b=Z0S1GTLexES9YBK543RclfLUDWH9+CDMJrSkaV63N3MEQPDvx0OqFupJKsRGTWurpX/lpSoWH0HkfLr/4VPfmfz5Ywtk2WzRCrevyUZwrXm/iqfs7Qhq3pnszusssyOpLB+jot8spTcjEfHmvzNz/DNE7qss7ctZuZ6jvyBvQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746056; c=relaxed/simple;
	bh=g8FSBqXDKtYsVZhEc1MC+9l4yc+r3pcwuo6cYoN+hKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkJDgxUTbtFUdzLZLExxNJIbaqXg5+xSet422nKAINYhJRLC844eyhWdwojcD3fXwWjqntxA9JU0PHO7PC3JuuBpuACTLpjTV1PTtnnitSAecvibkpMGnBhzauG1ke1EFzTmR+Ix6/2PccDl6ZQ3CQDLHD3XS7j2fRFh6lDsdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MpgJE9sf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MpgJE9sf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=678PhImsyGy7L91TFEoaEQSWpYoRmS+RytZyEIMUJN0=; b=MpgJE9sfiLbNBAz2+oMdDsG3WW
	5Wq41KZFR43ZRmzhNGNehCb+fKTET/hEBuA4w4Cgdixmp2QepZgWna2eEvcJplXr2dNlF1NmYFuCF
	Hkp1INjAf0h4IR/gZdnq4IeAE6uwGKf6DR7/QHrnYNHyl12XrUhlHz98hIst/wKgdsixeDajF4pC8
	CGKjv7mLMJXjm5TqAtRWnwnKGTbBQmEfA9CP/SinmS5qF7hu7u9covIPYztsMuXo+oJyVkleTjT8t
	anEWwynpNO0jwBePMyk79oSL25CMSv6zRHT42S3/pNgElNsDvNjAAyhJ0FNAf9gbGwSe/iZtRTjgv
	4jBzIEWw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKcXz-00000003X7I-1H5W;
	Mon, 09 Dec 2024 12:07:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CAEB93003FF; Mon,  9 Dec 2024 13:07:30 +0100 (CET)
Date: Mon, 9 Dec 2024 13:07:30 +0100
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
Message-ID: <20241209120730.GM35539@noisy.programming.kicks-ass.net>
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

Looks about right,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
