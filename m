Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8101DF987;
	Tue,  7 Jan 2025 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239738; cv=none; b=T1PaxIuR+DnSfslG4FKafE2vnHDp2aB5EaUtM/Qwh+5Edqi4ohhCNBQsYdupyM/vZMLLAuF+cCSGFdl0DcTbsM89onvQExn0w7yJxhD0pkWGu04ft9NphrGqWZitFx2oyDqEyvzf+gqTiNZK+uvYj7e6Ug+0JnPlP0esC3he0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239738; c=relaxed/simple;
	bh=75qSoARujHFKrxawR0blzosOlHUziYhK6L/R2vdTEek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bw5nbbW6MYZ3F6ljS7HlQQjv1RA8QES+14w7STYy0nBMJDxe8zJPUZ42DK6Nn0CqzjNyaVZgtlpLbciLTZwAhSDOJKqEnZrtwBa9ih5Kc64hxpHn8oyKj8ZGI0CxQ+SnVzz4uGA3JcPfH57/lYfmYMrZ8mG0T8+vn032AEZPUQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L7zH7+wl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L7zH7+wl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=WwRVnzV3CDoYfoXPZ2biLNd0Ko3ydMKPZgxSyZnn16Y=; b=L7zH7+wlOdtHvMj5rcLSTdTA9C
	NHxoT45+BXSDgAbhvBwLRXVa3itr1LEFY4SocJjCsIzyKHM4j5V/R1xEEtrsZzpP/NDyOcVrevGnE
	sbuBUk1CgQ3Do77iq4gxWbG7QuOqHd+qSGb0zSYlNfE9Jym8YSXpYD2KXZlX5SwMGn4HLcH5v+MQ1
	ilouiBEihhWi0HhhR0u/HDSSGEhWDY+88J4yZAJKgEyfNAToQWVk34uL8hJSZb0gKMmGA3D/+h4j8
	XRE/MPTh8HvbZh0j7IElzzLcPiJfbZTrusKjD95TwrDhR0BS6S5pdxOoFY4VtkO06MfAsriJyQv4P
	xL/2WVGQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tV5GV-000000059Jt-2WSo;
	Tue, 07 Jan 2025 08:48:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 11CE630057A; Tue,  7 Jan 2025 09:48:43 +0100 (CET)
Date: Tue, 7 Jan 2025 09:48:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/28] module: Use RCU instead of RCU-sched.
Message-ID: <20250107084842.GH20870@noisy.programming.kicks-ass.net>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>

On Fri, Dec 20, 2024 at 06:41:14PM +0100, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> This is an updated version of the inital post after PeterZ made me aware
> that there are users outside of the module directory.
> The goal is replace the mix auf rcu_read_lock(), rcu_read_lock_sched()
> and preempt_disable() with just rcu_read_lock().
> 
> I've splitted it into smaller chunks which can be applied/ reviewed
> independently. I'm just not sure about the cfi patch (28/28) so I added
> just a comment instead.
> 
> v1…v2: https://lore.kernel.org/all/20241205215102.hRywUW2A@linutronix.de/
>   - Splitted into smaller patches.
>   - Converted all users.

Thanks for doing the cleanup!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
