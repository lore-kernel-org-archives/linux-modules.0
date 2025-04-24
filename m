Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1641A3BA1;
	Thu, 24 Apr 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507843; cv=none; b=SERh8jQ0pjB0Qlc76aOE/wRLRT+drQ+8gKjXVf8pC/a//RI3VyJ1qM2malNOk+qEb50D+mHFOvsDHC8xnjGkIxw8gdbZ+7+Ew1WjkjFNYELR7BkXe7KH4sHsORpd+F/6vgOl+BY4U50YNEzR1jUiW9Mo+kYnEqG0qVFcmggWDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507843; c=relaxed/simple;
	bh=i5zQo+ZbmXhXlpKA0PxW7GVqKWnTwvj3UM7NmLcRBq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqFocAq9o6EUMayxMfHhvxdw4pAA0tRZjGYNJI5Pd9SrswiVzc8LQ8GIlfdu8Cym0oq/TOYehJigi3TrCSWjghvsTw2XF1pW1LaalrnorRVt+jdYCsyygxGwPQ12NHwYeDfLznjGyAStChjNhMPjoACN36rLby1n0xA1uF9donY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F/cBTzER; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F/cBTzER"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i5zQo+ZbmXhXlpKA0PxW7GVqKWnTwvj3UM7NmLcRBq0=; b=F/cBTzERGsPjUZ7LTI3oLSK5vp
	G2bszn/q/yJZ4a6vUl5M1DRld859/iBLasTsPq1DF0MAj8LPt2uMUhU/RK3ExROxDnt6RjSYeoCLc
	pij00dSo/Ok8y/QwQllmpkApl33JIY24pQkvQOroLeB/zk1AvABphUxYcl5dnSpCSES3RWd7cSYjT
	vAm/208jspVYndt7VdmTUl5GdvtYRo4HInRjZuNXKsvB3aLLaBcXMMINnLIweX3YRnd7kg8z8jB6s
	kkn1O5VVLIMGxE7rypgA+QUGkuhp4YLR7L4qjXzUdosMfewNygyicpqtsWnM1qfb98zOAQ7tm7Kzl
	0aNn1ofA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7yKB-0000000BqUv-09Vd;
	Thu, 24 Apr 2025 15:17:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5D927300642; Thu, 24 Apr 2025 17:17:14 +0200 (CEST)
Date: Thu, 24 Apr 2025 17:17:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net, Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 15/28] module: Use RCU in all users of
 __module_text_address().
Message-ID: <20250424151714.GA18306@noisy.programming.kicks-ass.net>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
 <20250108090457.512198-16-bigeasy@linutronix.de>
 <db0f8ec385762e6edb3edf5054a76ea189135e6e.camel@sipsolutions.net>
 <4446525f-4e89-41bb-91a0-89c72dd0e8f8@paulmck-laptop>
 <20250424090539.0O37K8vN@linutronix.de>
 <bc9896f2470c70519c3b9257a1a2dd32e5e9c6e9.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc9896f2470c70519c3b9257a1a2dd32e5e9c6e9.camel@sipsolutions.net>

On Thu, Apr 24, 2025 at 11:30:39AM +0200, Benjamin Berg wrote:

> Not sure if something like that would be desirable upstream. This is
> happening for us when running the hostap "hwsim" tests inside UML (with
> time-travel). At least internally, we could carry a custom patch to add
> the lockdep_off()/lockdep_on() to dump_trace in order to work around
> it[1].

Urgh, so lockdep_off() usage is a really bad sign.

Having just done a git-grep, I see there's crap to clean out :-(

Some day I'll manage to remove that thing.
