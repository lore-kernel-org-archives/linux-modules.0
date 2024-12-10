Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42281A9B30
	for <linux-modules@vger.kernel.org>; Tue, 10 Dec 2024 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835522; cv=none; b=Oom0MJUijL9UL/gQs0QZlxdVfBUOpvcTBMa6lm+kdjUzK1Z0ES9uSu60zG2OgkduIuKHGbDYRG6Zc+eGHI1R4Y3SiOGK08fZVH0NMlIM5zso2AQA28wBLNnu0mslSHJRznd/P0XtukAxL+ByXgd3snxpiURpmFO41OKd/50hVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835522; c=relaxed/simple;
	bh=detIezy017On8DkL0Gy8QoElvixD/xvCENgnIjGBzN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7YalJf4ztcXLl3J7dfNbC+8iDdRD9GbjW7A3m2iqn7LlPCtNRp+iDNxV4j3CB/eVBuKYz+1IHrQsPAPrazCVQQAinyL0jyT0XsZkVuOxJhlU4zTfhL21DEgLTueGLmtVHYg7qMx/wCGwLoMOhJNftwZ1Iz49Q3JMFuh/YfDKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QaSmf+z2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XO0LKp1r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QaSmf+z2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XO0LKp1r"
Date: Tue, 10 Dec 2024 13:58:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733835518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=detIezy017On8DkL0Gy8QoElvixD/xvCENgnIjGBzN4=;
	b=QaSmf+z2AXiKXu+Dn2wbcVFjzlf0+O/ZU/KTFxzsR1vLOWKL13sxxmwi2+QA49T9hL/xM7
	0I1Sw2x6EJ+isLbhr3/MTziWKmMzcPkLCHqt3GQdMcfdeoey1qbxubZER0gYps3PD1f4Z+
	3ow+BRyTAhZgKpXoM4Zq5DW/3fOqYwvYHA8aAWj60JyQsSjGUMvlXZbRK+N8SI/QSHFHYn
	SeGXldo2JEIgwis4R+DTdevFfx0cngZ+CtIkD07CfJiWfo2gFzmKMEFlblO0Ofk2j6N7zg
	9kIVW48+aSm1FSiRgONM3XaFxPAMLzUgmik7Ak76EE4cknvZaKYWNq67q6IVBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733835518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=detIezy017On8DkL0Gy8QoElvixD/xvCENgnIjGBzN4=;
	b=XO0LKp1rc5T7mxoOuqAVsaR2FwDLp0RkMktNrSQedcJiEfyKgVhBZ/RaryGfHipbD02DtJ
	BCGUC6mk8lSKp6Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-modules@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] module: Use complete RCU protection instead a mix of RCU
 and RCU-sched.
Message-ID: <20241210125837.DH5NPK2a@linutronix.de>
References: <20241205215102.hRywUW2A@linutronix.de>
 <20241210120801.GP21636@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210120801.GP21636@noisy.programming.kicks-ass.net>

On 2024-12-10 13:08:01 [+0100], Peter Zijlstra wrote:
> There's more in kernel/jump_label.c and possibly other sites, grep for
> __module_address.

Thank you.

Sebastian
