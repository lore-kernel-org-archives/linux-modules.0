Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6520D2D627;
	Wed, 29 Jan 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738140744; cv=none; b=vDX2/1zNhjywhnQX8FMYrm0icJFy5Te1esU0OKBAHbnWQ7aZWWXgpxOTeZ/+tMDHvQOdOYFC3YZjmc94P6ltwePOVi9LXfvwShD6JqXCQztdoyIyqWFP2hG2JkC30Z5Fi2bgBFvz5eSPnxmxIQ5gYPfx3jwOcbmB4MNp1rEBZRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738140744; c=relaxed/simple;
	bh=cqLOAhZicjKy1tQDweeqaZcWelb+GvGFKxZu02qZQOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYe7JQMNSo/oI+mYJtEIUkg9gM7HsmbdLubctYx54vHx/+YWKUIn9YTJTDNdL8b7QzTiwqZQGxviKID8v0laRPeBA9J7jxqIGjzkV0huOX/BtI/fYnYpItWGMm7mgfHwWN4dQU50WzeCrawJbOvcma5aiMtNIFydQzN5EM+I7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PkzBqeCk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vLV4i7Bg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PkzBqeCk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vLV4i7Bg"
Date: Wed, 29 Jan 2025 09:52:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738140741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S9IR1KpoBrev8QFuxAfwCOX9yG37xFKI+jit5c5pIa4=;
	b=PkzBqeCk7faCk2uPgliF3FANSk4ico72+Rrg7f3hKsXSJp8xlgzOwzADDslWWf2+oyA5F3
	Pjzny67UI8SC6jt3Cpv5euF8EKdLmxghdy7sMAJvjvxSSqyikPypZn599fIWPr/Hg7nFsS
	qbRXM8KYKZXmL7zUDss7Me3+bPq1TZblZYH5js+BqN/UlbghUpzl8+MjirBU0cGHWLNdB3
	zfEoRPfRMutuF03pRa9YBf1UY93gBzt9qF2WzVAhS82TZuEzqcfpZpP8kdlcm8DnsHHhkh
	ivxRWcpdVb07Zt7FZrPB4QjULbTZWA2zC+7MOphOO6FV9yNTnrAuYZdt1dcylA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738140741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S9IR1KpoBrev8QFuxAfwCOX9yG37xFKI+jit5c5pIa4=;
	b=vLV4i7BgCNJ8PgeE8QMRHHsVZMIq84AOzCK+Q5YwT0AXfjZYRMcwvH46tzGJotvebeALuz
	snveqG409t6CWuDw==
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
Message-ID: <20250129085220.U6pWGr5m@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
 <f4e953a4-4458-4034-b91b-7a433f20114b@suse.com>
 <20250124174949.mqhpjdpu@linutronix.de>
 <1907b409-f2e6-4b9a-ad5a-9879100bcf76@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1907b409-f2e6-4b9a-ad5a-9879100bcf76@suse.com>

On 2025-01-27 13:22:17 [+0100], Petr Pavlu wrote:
> On 1/24/25 18:49, Sebastian Andrzej Siewior wrote:
> > On 2025-01-13 12:09:27 [+0100], Petr Pavlu wrote:
> >> Thanks for this cleanup. I've queued the fix in patch #1 on
> >> modules-fixes. For the rest, I plan to give folks more time to look at
> >> the changes as this affects a number of subsystems. If there are no
> >> other concerns, I'd then add the series on modules-next.
> > 
> > #26 (kprobes) clashes with the changes that have been merged upstream.
> > Do you want me to resend the whole series or just #26? The other patches
> > apply cleanly so far.
> 
> I think sending only the updated patch #26 should be sufficient in this
> case, it's only a small adjustment. Please preferably post it as a reply
> to the email with that specific patch.

I just sent two updates:

 [PATCH v3.5 25/28] bpf: Use RCU in all users of __module_text_address().
 [PATCH v3.5 26/28] kprobes: Use RCU in all users of __module_text_address().

Sebastian
