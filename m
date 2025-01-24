Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC8288B1;
	Fri, 24 Jan 2025 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740993; cv=none; b=B0MVxYNwcdvmK+Hw7pMpQlbcPRAvsWKBhCVW0BCXmwgewLwfzn4u9tcb18gOj3AujJ8U/+hd8joYx5jYu2qmo5s9bSfssimPD+lRIZldEk3Zkhl85XQOvFDwzsdlxsXGOyWtCOvcwof7FRW6RVPwQNeFLjVWzudoSrvl2DdFOV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740993; c=relaxed/simple;
	bh=/rpO99Ajce58LdrxCaHl0YxQdD2byB5hvyYBAhibXn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usEnFnbqKpuabSqHmxw3RCGsVy013v+4EZElXvWERiFHe1boRTTYtIBtQIS1VLGLezSbv9yShmvrs9R276rx7I4cBIxAfDPixrLeNHDIKJ8WFTaHxy5uSSxOmPtmhHAaZ2BKJj9IYanHgfZF1vLaTCcVy49XpnVjRkQBIP4R0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ecx7DbZP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HCozOTks; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ecx7DbZP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HCozOTks"
Date: Fri, 24 Jan 2025 18:49:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737740991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/rpO99Ajce58LdrxCaHl0YxQdD2byB5hvyYBAhibXn8=;
	b=ecx7DbZPlBZTeJfQgeA7pfHUYdnhR5J+d10Ko8NyYscjKhXnbvfBUx7n/lvi0cTvkhTSL0
	bRR1PaIEvF2OXEGeVeZK8TE5lFPn1IpNA5DwqvEr53IzvjqkF02bOiUFdcYij4b6Zknpcb
	otC2zWdKBvj0Tn5VkzJsVY/FMrZBtCXqGU8ktrGmMRhl9FakB5xauU8d+SQJ6ECP5pzBlp
	u/pt5DmxIH7I5+Tb8kjnDjprJpmOXphGGc+FDo+upYE/rOu77cvgh13IRGj28fsS9ygxMX
	5ZkoGDiDLoTTDXFtTwL5qBupNJTykldO6rJ6oYwxO921npJPQ1RZHyqqsmsWkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737740991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/rpO99Ajce58LdrxCaHl0YxQdD2byB5hvyYBAhibXn8=;
	b=HCozOTksk1xgKxcRGilsZ9oAeYqibngB01n1jR4d5tm2jSAl2oo8I7DCuHn9AJQMAz8bUK
	UfkGr/mGLLChv5Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 00/28] module: Use RCU instead of RCU-sched.
Message-ID: <20250124174949.mqhpjdpu@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
 <f4e953a4-4458-4034-b91b-7a433f20114b@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4e953a4-4458-4034-b91b-7a433f20114b@suse.com>

On 2025-01-13 12:09:27 [+0100], Petr Pavlu wrote:
> Thanks for this cleanup. I've queued the fix in patch #1 on
> modules-fixes. For the rest, I plan to give folks more time to look at
> the changes as this affects a number of subsystems. If there are no
> other concerns, I'd then add the series on modules-next.

#26 (kprobes) clashes with the changes that have been merged upstream.
Do you want me to resend the whole series or just #26? The other patches
apply cleanly so far.

Sebastian
