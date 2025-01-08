Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E1B1E570E;
	Wed,  8 Jan 2025 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333544; cv=none; b=knqJI5wACJkwOuLNTcdVN/BwS5hedSbx1Y0wx04Ff85qMIV9f2x86xtXZzQXdb+xoDmvRglUVHFIbqcu7tbjgh/UhkRKc/oro3y8/u6tctMVhitzJ9t21Y4Ze4AfEJwjwqf0z+LhfSIuLCWQzkH/1yMqRQwHewYhZVlCngHIN9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333544; c=relaxed/simple;
	bh=GyPvW/pRim7Im4VD9R/EMp8w7OK8cC/hL53fAtEFq4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DftOmKh8P8WjsSp0C9G1oK3hIi847kD7Gu1A+ygLe0H5nOp+dPhZBASgK2rEMZ4Wdo8ybnk84QwLSuFV+RUSDedDcCueeU7noJY2LsffKeisK1qlRnxtCmBS3ka+N6e1Bztublys7IJbUu1fVn3lO68e221XSvjyGh1rSk/ILTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dVBnuM4j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rETOKJL2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dVBnuM4j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rETOKJL2"
Date: Wed, 8 Jan 2025 11:52:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736333541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p+UNOk/Gc7YL182qdcRhQOE6egTTYXg4wgQpkSsftN8=;
	b=dVBnuM4jjN5JT9vWqgK5VhYdpkywqP+envwHxNmws7s4YEtB5Yor7H/SpopHTxJZNiWWa+
	tb/fimI+Fbz4EDt6OU9pJhyMIMXLU9jBBd9VWqtQwPAFsIwFxddyy7oZhhCrqpwb2zps3Y
	+yjrdJSi+guYZkzHqAtwHdBSP4WUgNKnrueotbGyo4r/OiIenKMm61kjEv/DIixG05Vhoa
	UN68bbc92C2zOnS/yx1F7X/iGiDqn+Qw8ks4qtSs0Od74hm3NZvWtcZ045mW4Ajj8hqfLE
	rZ43r5nya+EkczgnaM8bIl5uRjLSRbN0gblqMrb6sNKFqgAI7QchRofJ3xwKLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736333541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p+UNOk/Gc7YL182qdcRhQOE6egTTYXg4wgQpkSsftN8=;
	b=rETOKJL2GevpN/Q3/95xe8uhF6nTOw8CVstX4041p8a3OB4SZgNDKyEkpYgx4E6EdgyIqJ
	+eOK8sxNeXECukAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Helge Deller <deller@gmx.de>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 01/28] module: Extend the preempt disabled section in
 dereference_symbol_descriptor().
Message-ID: <20250108105219.0qt_iWHk@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
 <20250108090457.512198-2-bigeasy@linutronix.de>
 <6e8ef32e-6698-496e-a9e4-09f0ade5f264@gmx.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e8ef32e-6698-496e-a9e4-09f0ade5f264@gmx.de>

On 2025-01-08 10:55:04 [+0100], Helge Deller wrote:
> Nice catch.
> 
> Acked-by: Helge Deller <deller@gmx.de>
> 
> This patch really should be backported.
> Can you add a Cc: stable tag?

It should be picked due to the fixes tag. I add it if I am going to
repost it.

> Helge

Sebastian
