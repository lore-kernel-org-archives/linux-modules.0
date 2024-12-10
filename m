Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAA1AAA15;
	Tue, 10 Dec 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839845; cv=none; b=Xcz/1CHC3oxZ1RnYjviW9l07PANT6c1lYGSXnESlk0ZGOu0gQOXHdm5uKwAWCGiOeBpNo0Ry3iQSDk05IUF5CmbxKG7bmtv6fVKr6pWy0+MGzLlLNjyNxsmbeEbGlkLLMCW66Nhe9F3h8C5NkN/L568Qdy0dc201FnUnp5kmCpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839845; c=relaxed/simple;
	bh=0fDRgjHWBT2z2J9Fg91uJWZC57PBHwHCdpEVcEBo7sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIPbItLgj1CaXmjVjsBmPqmBnH8l0ybuX1DY0kalww1DiqI2nGNFe+n98J7YWIfbOjkLBhqODGA70NJlF9PB1MklHeWT8Z+ag4EVxsweH2cMd91UlZ8O+I5kFXke+lWz6BtqoIt/eBabTL+7CpWXK2dxMTzA3lR3nnqkk3VJHHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4QG9QT73; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VnfobE9D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4QG9QT73";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VnfobE9D"
Date: Tue, 10 Dec 2024 15:10:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733839835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgr84OYGOCZUB+B/nW78DumQz+SZr0r+3+t9kzfh9nE=;
	b=4QG9QT73h1incZk/ZP7NSx4S1Ew1JoHDw4h8gYKiiGE3FtiXlpLIQ4jHceeu6qwzi4Xe7g
	4mY8dowuTwmwhAnKbIgQOI5PV7DZSmvWYHkWWJIT4htWDMoi0iOMhDwrVCg+9cfIt02Dlk
	tLRDCYnJE8KI77qAVHOpzCy3VzX1Hg0pzBD1HqhkbeL1KPRERMcRBTJi7s5blv7lEZ5zeH
	FFtpPoP09E/flqe4km7lJtRqnnv2ZrFh7MR4p1ruVDjNNRxkw+zmJzS/Mh0lZzJ43TUZj6
	F5vNZ0hSyjfpadFXOqVDj1GSx+LpuH/o9CHgSnNcjFoFeo+InHE2y64ZCmoOtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733839835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgr84OYGOCZUB+B/nW78DumQz+SZr0r+3+t9kzfh9nE=;
	b=VnfobE9DTQgHAupwLdAOaAGWIC/XCvhuEd1LkrHoxSHdMwUxqle66LyppAqNO1WRuzKsHg
	W0wxtc0fm5rImkCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Ben Segall <bsegall@google.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] preempt: Move PREEMPT_RT before PREEMPT in vermagic.
Message-ID: <20241210141033.9-1fcRkc@linutronix.de>
References: <20241205160602.3lIAsJRT@linutronix.de>
 <21f75fd1-58f3-4c80-8527-55282518c802@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21f75fd1-58f3-4c80-8527-55282518c802@suse.com>

On 2024-12-10 14:52:23 [+0100], Petr Pavlu wrote:
> 
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> I'm going to wait for a few days if others want to comment and then plan
> to take this through the modules tree for 6.13-rcX fixes.

thank you.

> [Luis asked me to look after the modules tree for a while, with the plan
> to rotate it.]

understood.

Sebastian
