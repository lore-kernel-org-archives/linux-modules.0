Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55AD1AAC4;
	Mon, 13 Jan 2025 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774643; cv=none; b=uwritUSsgWlaV+5gak+WNImZ2cM8/92UfM7Q9ZuY1CvUaZ1IEAseXpV/C6ImCKdyeiv00I12nRw0qqo0wJ5MnPWyfZdHVmU/l1g+fvMT9yr0v/Ipr9DrQxW5FinmjZ6DETluLpf4e3xTZd8VnTh2qH/rpSiAqRL4yswrdw/S44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774643; c=relaxed/simple;
	bh=O75hgMd62P1EPuXfhIAOpl/gshAtFrxDvn0E2P9yawI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy07cbyfOamu8efFtd5ofrIPtv7fkqrzlkUP06tVxeG4QX0R5AxQjz7tzwamq9SCPzvGvr353Ga1NWqJd2Uf1WEop1Bqh30alXslKmlwgotsex4YFm/+jzlNMGT4SPZM3wmFzbmZFHDfI7oNsCu8hP31n9q28NjVMJV69uC7W+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Br96jGJr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+1i9U8mk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Br96jGJr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+1i9U8mk"
Date: Mon, 13 Jan 2025 14:23:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736774640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O75hgMd62P1EPuXfhIAOpl/gshAtFrxDvn0E2P9yawI=;
	b=Br96jGJrvDSHaSugKVLAgUTELR/QUxkALuPzk6QAuIc/LWE8E2gjMXkAlvnsjFvVJBlLCW
	VEa99UyIR/718Lwy9sdQ9o2Gz4yPYquCWEd9sPjBuvv7IpY4fG/jFjHuikK/591LJZYSav
	XRbfbJ1U4qiKMTRQ3OUAY7/grOnCxknVk/vWUiByTU8g0fAS2sCS7x5Uf0HHJDuYCIxZF4
	I8k/RdNwIlca0emx5K/v3zqBGLvILisk4yfmFChRXV4InAwIT1PYQlLNZ6AHfaCI5xsR8G
	1IOSZnVH9SWAPzEM66pIkX1i4lTYRR89VPp1hUwXqB9YrYMsCiFN+D3LNOBLAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736774640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O75hgMd62P1EPuXfhIAOpl/gshAtFrxDvn0E2P9yawI=;
	b=+1i9U8mk50lDF4FM9liZAzx1RUV0HkELpGNvfF/FBz5K8heceDsoKcovh3mEq4PK2urs4f
	FgztqfDzxfQE5qDA==
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
Message-ID: <20250113132358.qk1UL6-h@linutronix.de>
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
Good, thanks for the update.

Sebastian
