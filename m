Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02236997D;
	Mon, 12 Jan 2026 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236225; cv=none; b=pO5Zv7c6NdwSynTcFmfQHtIoQRI7eb6zrmhWlzAnjfcOrqP64IcB5cmyHfOYwyhXAbLYE3v/VCWkcr5l0Iij4shwiPa15fhrsj4dRCz3BJep991KCsFarNLWcJqRmVlmF8nyapSeeaPDc7JRqXWScy8Q9EwJXwERxWO18HYCXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236225; c=relaxed/simple;
	bh=4m5vZMhkyIAFZEFDERjphvH88aWpo+HBmZvfEgUz+Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ll7tENTH/sZISgUoPYlFQaTNxDgTAgy8soge9AoABO95tAFgSxofC9nfUvMi1xgAZeRUX8kDJCyrI66H3JoBb7tw3d9D9ocl8kg3bLEWwnz3sR8wfR+7aD4uXw/EUF0GthOWQYCDNd5q0cnCTtwbSapWIdFTsDTewkJVVLubgEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZVsLw+ds; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZVsLw+ds"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QQtqe6cr7CLTj5lsiVf7e2mma3ytQYAggQ5dp6tr2Sw=; b=ZVsLw+dsAPbv7Y0fC2nElmp0PH
	9RFwX9pWg8ddg0L6Dv34MDRcyygK67LnTdBVEfldPM9kOa7EwNF/VZNtDGlFzsbblnCT2Gfp0nSVy
	sSR2DDsp2F6FxPiAXTLKpvlypU9N+YDmBCtm7OHj057fQUseeAz57jjD0h00QZk+xr2ZoVPaRaQMP
	+MqQZLQzfyIURv+QSLHgs1c0+DfhSESyQXsfhYdC75MnjpSCh0pI27p0qt3ysWVO8lSpxTJ6qNa52
	Cx41BB7dp12y3cElrsKu/Wfse70o+4M+g+/y4AhH0cYeLUT+crYIy1du7OIW9IygtA6TBZ8nQII/t
	KlJ7PKdQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfL0w-00000003Urd-3p7J;
	Mon, 12 Jan 2026 16:43:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8C6CF302D3E; Mon, 12 Jan 2026 17:43:33 +0100 (CET)
Date: Mon, 12 Jan 2026 17:43:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>, Song Liu <song@kernel.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Remove duplicate freeing of lockdep classes
Message-ID: <20260112164333.GR830755@noisy.programming.kicks-ass.net>
References: <20260107122329.1324707-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107122329.1324707-1-petr.pavlu@suse.com>

On Wed, Jan 07, 2026 at 01:22:57PM +0100, Petr Pavlu wrote:
> In the error path of load_module(), under the free_module label, the
> code calls lockdep_free_key_range() to release lock classes associated
> with the MOD_DATA, MOD_RODATA and MOD_RO_AFTER_INIT module regions, and
> subsequently invokes module_deallocate().
> 
> Since commit ac3b43283923 ("module: replace module_layout with
> module_memory"), the module_deallocate() function calls free_mod_mem(),
> which releases the lock classes as well and considers all module
> regions.
> 
> Attempting to free these classes twice is unnecessary. Remove the
> redundant code in load_module().
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Indeed,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/module/main.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 710ee30b3bea..bcd259505c8b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3544,12 +3544,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	mutex_unlock(&module_mutex);
>   free_module:
>  	mod_stat_bump_invalid(info, flags);
> -	/* Free lock-classes; relies on the preceding sync_rcu() */
> -	for_class_mod_mem_type(type, core_data) {
> -		lockdep_free_key_range(mod->mem[type].base,
> -				       mod->mem[type].size);
> -	}
> -
>  	module_memory_restore_rox(mod);
>  	module_deallocate(mod, info);
>   free_copy:
> 
> base-commit: 3609fa95fb0f2c1b099e69e56634edb8fc03f87c
> -- 
> 2.52.0
> 
