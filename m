Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974039BFE2;
	Fri, 27 Mar 2026 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614455; cv=none; b=CJWXfaQuqtd/b5MGtrea4qAE4iOnoEq6dgDygN0NXmPzPjr/URkPzk4LBgWjk/Povbmo3tBWM5dSJ30ClrwLpuFHzkK6uMCQefTr0DNZPGhzS5LsaUv3U52lw/FZOhQjiTEWNQ0fbtChPnfPgbH3h6TJzcZSHWYIw5gqpEpwJfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614455; c=relaxed/simple;
	bh=xFOV8aaDXh7WZIERIMzvbgvKcud+c9QBrNKJN4ZQ4fU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bon+g7ft1LbdQd5sY61R2oi787Xtu4dBxRzrwPZ1kbzKNeEx/5jdavv+zfAYIHsY4wGiu6iPyiyxo83p8TSRu2T9Xl5YKmN1G+LMMExgAbodD06FRsaJO/CwbhPjPrPHJF/D15ZKUqCgWQmPN/Caa7kcXV2vf6DbuQDW2TlklhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l+LLIfZy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fWjMkhws; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l+LLIfZy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWjMkhws"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774614447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lzEFKnBhxHaS9x50NKoJGALUwHrUCjFi2x+ZMkq4iEY=;
	b=l+LLIfZy/bnYTaT5MnKDRebxlWltqbiwK9bhO+imF/7qjYRaTsAM0IgNcSCxdHocnTpBDT
	/flJlvKxA5gCHsflY7bzRIWQWWyXx7ZN+SrlbyMoZzc3Biv1dgvvA3AB4Q6mTSZtIC8N7Z
	ZyiDkPcOG0eIHky6SviDLgPyi0awb1qzB1UJCl7g92t/PlbKCKR7aiWcq0DyiONQnc23WT
	0y9rL96UgjPX0oBdbsmkIByWa6lXsGL8Z1Z50OODZuX4BvwOp49+iWRMK0YhRYwqUP0miK
	8/o8Ieny+w43L8pQxkaAoCde1N5l1YQWhwbz4Al9YTWXd1rnEgaGubMtovQQVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774614447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lzEFKnBhxHaS9x50NKoJGALUwHrUCjFi2x+ZMkq4iEY=;
	b=fWjMkhwsvTGbz6n+Dvf74BVGMNJJR+mRZuq79DIvP1I8QgbmFe1Q4ys6ZB+aYu54dh71d3
	aoVb1YTkctsi2sDw==
To: Petr Pavlu <petr.pavlu@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Luis
 Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Shyam Saini <shyamsaini@linux.microsoft.com>, Kees Cook <kees@kernel.org>,
 Thorsten Blum <thorsten.blum@linux.dev>, Christoph Hellwig
 <hch@infradead.org>
Subject: Re: [PATCH] module: remove MODULE_VERSION()
In-Reply-To: <d622c70a-f79a-4215-84fb-c5de0a8f6ce5@suse.com>
References: <2026031341-evolve-repeater-987b@gregkh>
 <d622c70a-f79a-4215-84fb-c5de0a8f6ce5@suse.com>
Date: Fri, 27 Mar 2026 13:27:26 +0100
Message-ID: <87cy0p5ufl.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Petr Pavlu <petr.pavlu@suse.com> writes:
> On 3/13/26 3:20 PM, Greg Kroah-Hartman wrote:
>> Module "versions" do not make sense as the kernel is built all at once,
>> the "version" is the overall kernel version number, so modules can not
>> really be described as having a unique version given that they rely on
>> the infrastructure of the whole kernel.
>> 
>> For now, just make this an "empty" define, to keep existing code
>> building properly as the tree is slowly purged of the use of this over
>> time.
>> 
>> This macro will be removed entirely in the future when there are no
>> in-tree users.
...
> The original patch "Add a MODULE_VERSION macro" [1] from 2004 doesn't
> say much about the motivation for adding module versions, but it does
> mention that they should be accessible via sysfs. That was implemented
> a year later in commit c988d2b28454 ("[PATCH] modules: add version and
> srcversion to sysfs") [2], which primarily discusses use cases related
> to DKMS, and to administrators + tech support needing to know what is
> actually loaded on the system. For the latter, I believe srcversion (or
> something similar) should be sufficient.

I develop an external module. And our userspace program does rely on
this to get the module's version on the user's system. This patch would
break our program.

I can change to use a different mechanism. But surely I am not the only
one who write something that rely on this.

Best regards,
Nam
