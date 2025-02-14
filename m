Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B3151983;
	Fri, 14 Feb 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524797; cv=none; b=lTLEh0G5Sr0nhqDrhdUz4OTCBLvbIBNcGtfuLTmKSvE7wOEdrhD3MwTZEpu3+tfbC/Ypy2ZZHfcI1qr3t21fX8H81dfS3fDAo52maG0FZwJqsBmXC53zc41P866xPhMasXgO8SIchy9saxDbb4GmBddHbyym9gaBDoFdxmhE3Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524797; c=relaxed/simple;
	bh=s+iEc6DLOSUz5BLsMGI/9e2xgGB1qfrDPRfDFIUI0Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W78ruTgPXC3q5KgONYM6duI+AFYX4pX5ohp6an/tjoeD3odjyjiwi0xm8/M4tVqTGc6GwRkhCd0wpN3wVqchEsWHtLHxk5W+cHFGUrnJAUPz3DlShQsM6/jlrj2sPeSTVnL0vBgmnLAu9RdLM05T87HGqIvgUMJcluGi32Z28J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wLaIcU64; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wLaIcU64"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ef75NRy6e5D2kiAitttN6Y3m+w92DY/+/SD9KngtQFI=; b=wLaIcU64Ocq93q8mFp/gxBJpNg
	lPBJ2dsmNZs67hlBC5O7E0/g+CI3bm/iOo+ze2kfkKsHYhjnYRXFdMe9g8vEWo2H8G9n0yGxmgtJD
	SeZJyrZvxFd8t4O+qxQDQ658g8AJsjZCGIt3SjTIyiW0D1MmlVmEk5OUqOjIv0v2pdjZgNFGWOmPx
	jnDyYtiPDGuLb+GHDiZfpPbqyQMElowB+fGua7cer6CxVHsfjS+oW8OhvK8e3JmUV1bCFwgldT/Wy
	/pQ5UqoviHhtzhlH3VaE5pn+yoPFuasBIeEZQv8RYAqdCzn+8+wKMKjDq5/3/Ni5hQbjkLX3Bs55m
	LgsdoDjA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tirrR-0000000ApKS-1Gnv;
	Fri, 14 Feb 2025 09:19:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E89CA3002F0; Fri, 14 Feb 2025 10:19:47 +0100 (CET)
Date: Fri, 14 Feb 2025 10:19:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] module: don't annotate ROX memory as kmemleak_not_leak()
Message-ID: <20250214091947.GA21726@noisy.programming.kicks-ass.net>
References: <20250214084531.3299390-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214084531.3299390-1-rppt@kernel.org>

On Fri, Feb 14, 2025 at 10:45:31AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> The ROX memory allocations are part of a larger vmalloc allocation and
> annotating them with kmemleak_not_leak() confuses kmemleak.
> 
> Skip kmemleak_not_leak() annotations for the ROX areas.
> 
> Fixes: c287c0723329 ("module: switch to execmem API for remapping as RW and restoring ROX")
> Fixes: 64f6a4e10c05 ("x86: re-enable EXECMEM_ROX support")
> Reported-by: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> 
> Peter, can you take it via tip tree?
> Or you prefer for Luis to pick this up?

Less of a head-ache overall if these things stay together I recon.
So I'll stick it in tip/x86/mm along with the rest of those patches.

Thanks!
