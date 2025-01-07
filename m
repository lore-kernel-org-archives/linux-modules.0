Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1361EB9F4;
	Tue,  7 Jan 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264743; cv=none; b=X3zvqLiFwnsyzJLHfSQBfhTlWO5uJpaU3SBGcs1uo0p7ky8QJ+NzHYMYL+OvmSmRXM+zd3SqRn3/GvFyuh+tWex8lJmgt7FPGCuRd3X71hEiLcXow7z5m0gEXlaGlgtXXezPw0ucZnCShStXWIDCkzA4vSRWXlRm8mpqB2uuL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264743; c=relaxed/simple;
	bh=as1Cob34LKjg8VDh5L6PzRFoMJkB8AwdQHABXLhRx08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+r9hmMVXDtpwBdtR/GT7DaGmx4yMl9N274jaPc48mEOyzgF03OO+OF0m3ySe1aG/4OPNnh3dkxx5cOX1gLebECQ+8YhlOiubQtPSCiIu8CvwGdSXyQ6nUs2vDRV74T2ZbuhFL1QDmLr/5ADPPKTvYk9ukyJh4/WLufxQg8ufYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l3iXgm9V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J11FizcU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l3iXgm9V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J11FizcU"
Date: Tue, 7 Jan 2025 16:45:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736264739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/xCcNUNS0pFnj6wlnKxyKH/CSwIK2vP8VdV+uHUpW0=;
	b=l3iXgm9VSD8VX2V2rGENam0jNVEPFtKr9/LlgjaMxCo+YTwz/BR+63B9zUyKT5YSejxADb
	NAPG9qLH+qmplaYwuthblDJ8V+Yil7Yv8gj+3Hu/ch87KSMDCxG8pvTh/yalk9Xm9df3uT
	wUnQ0CiR6go56LX+m0p7fdoJS/MIqgp0ii3gwcd3Eon+bwaOnHkLUA7eUZYn5ysKosWmn+
	lDMV86R83lYQpdJRHp0bDeZDR0I1aUMzxgh5HGv5S4hhU7XNGMCbt0IAgiGtTLC+UQ/V1r
	i4GJ56WYEoUxUhDeL2cHFm/xAp7OwZEmhYHdOje+PLmKvpug8wtnlmRztVBnKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736264739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/xCcNUNS0pFnj6wlnKxyKH/CSwIK2vP8VdV+uHUpW0=;
	b=J11FizcU1nDXJcjA/fCTSpGpsI886y1Aixst1YWz6vwWSSiqrXTJAs44tVIgRIau51/gVO
	bgb2+ZbR/wmoY0DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/28] module: Use RCU instead of RCU-sched.
Message-ID: <20250107154538.uvWsfMl5@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
 <2f95fe76-f309-45f2-8023-7793403ed85b@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f95fe76-f309-45f2-8023-7793403ed85b@csgroup.eu>

On 2025-01-02 13:47:06 [+0100], Christophe Leroy wrote:
> Hi Sebastian,
Hi Christophe,

> How did you generate that cover letter ?
> 
> It should contain the full list of files modified by the series, so that I
> can see if any of them is of interest to me without going into each patch.
> 
> This is done automatically when you use 'git format-patch --cover-letter'.

I could do so for v3. This was format-patch without --cover-letter.

> Christophe

Sebastian
