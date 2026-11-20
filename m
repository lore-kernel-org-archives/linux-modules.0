Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175870;
	b=JyRp+Dla1hiOu2ngyR4vFSantUYCnwxa5tBv9Ritw8I+Le9vcSujp5eNREB5QAQKvSTg
	 5fj7f5gQQOE/ZOCnkJKAQHVM26w77XtC8ijuPmUMcXTmoXKpkaAKo0aoFUffk7pQT9+ej
	 t55NAlMQdp30AzJL3s0vb/q2vnWd3DDvcSrz79/reXCR352z/z9ctbY/m1znekHT8156y
	 TLn/e9ZqdvlCbMb19SUy0cwRnPmCHOYscFlmprzTFwf09X648NmAVQ0DICwggXrm7Agi1
	 w75foFLng5cyR7styz2db5VV+kbHfM9/eqzhcQep9YJ1Vb8IJgHGKLIiBPu7tIQ94zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175870;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wLp+MxiKos5wcI7ePiP3oh9z2cyJ/ZVCuxwX0/ByaD4=;
	b=oIuhAl2mHwSTLiqPKj4NK/YVAHDeZeWHLIolA4R4jVutwmBFX+5ACd9k4oHcKQSZPMW4
	 Q6dToKdfC30iNmLe8zET0kwje5aKkb61I53CBGz01KoI9kO9lpktsYpud1Iv9qy7ma8BR
	 YoGboiUn3kAK7xWJaf1HBVvupVHTG4sZPx/GIoIibSLTRoOGnUcGbxCmaz8FAbFp3jDN3
	 AkldGmr+fDoznxP2CfiKz3P5Lf1FAeObQ43/P99zY9qTJ+08XgvEtaP0Gi5b5vgofaNTS
	 33xNZ2u1Nb3ekDxx8p9QY8hJXryNLj0VVrGnwljFwV+c1JMYK5eNl9rlhD+5q3e6qdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bPIR+4US;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F106606A32A;
	Fri, 20 Nov 2026 11:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F106606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bPIR+4US
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wLp+MxiKos5wcI7ePiP3oh9z2cyJ/ZVCuxwX0/ByaD4=; b=bPIR+4USXq3inxA5yPeSvwm2mz
	WKdPklYm/+yxAf7w74YVCTPPbZLz5xNIsbvdBiiF8/XHFuCins+oGC2VHzzbb6yXIxbRWG2BAYETi
	5CE1bNF2m0IdU94Lx1mzdb5qHlFQngAJ3ndvWac+QQsZu2dCGi6XL3FNWYBnkCq4y77a1lKtiywbT
	VxKqOi0cRfGTh1pdMz8RZnhmr5oXhfU3ah6drxs44dbiHyDhrqd9zJQf8gK+0x9AF15mi7dnSRvbx
	uEYpPD9+SwcXResrqa0CQUcLG1mKJYZ4o9AgplvppRk6sJXWe3Cib20AVZtaOoO1e65G3J++hyXJl
	X54MPC+A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUNFS-00000003txx-1rkI;
	Fri, 20 Nov 2026 11:57:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 47FE63008D6; Fri, 20 Nov 2026 12:57:45 +0100 (CET)
Date: Fri, 20 Nov 2026 12:57:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yael Chemla <ychemla@nvidia.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>, x86@kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [REGRESSION] x86: Use RCU in all users of,__module_address()
 slows kTLS+wrk workload on KASAN+PROVE_LOCKING+kmemleak
Message-ID: <20261120115745.GR2668564@noisy.programming.kicks-ass.net>
References: <bd2a701b-866c-4d4c-bd0b-37b4410628be@nvidia.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd2a701b-866c-4d4c-bd0b-37b4410628be@nvidia.com>

On Thu, Nov 19, 2026 at 09:54:37PM +0200, Yael Chemla wrote:
> Hi,
> 
> A kTLS stress test started failing in v6.15-rc1 on kernels built with
> KASAN and PROVE_LOCKING. It was bisected to commit 14daa3bca217 ("x86:
> Use RCU in all users of __module_address().")
> 
> The test runs wrk (1000 connections, 15s, --timeout 5s) against nginx
> serving a 1 MB file over kTLS, with 1% packet loss. It fails because too
> few requests complete: wrk reports only timeouts, no connect/read/write
> errors. With --timeout 10s it passes.
> 
> Reverting 14daa3bca217 on top of 01d5b167dc23 (modules-6.15-rc1 merge)
> or v7.4-rc2 (7475ea8b5861), with the same config, makes the test pass;
> without the revert it fails on both.
> 
> The failing config has KASAN, PROVE_LOCKING, kmemleak and UBSAN enabled.
> Building without KASAN, or without PROVE_LOCKING, also passes.
> 
> I have not looked into where the time goes.
> 
> #regzbot introduced: 14daa3bca217

Anything *SAN is not a performance target, not a regression.
