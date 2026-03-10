Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548C28CF4A
	for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773124293; cv=none; b=lXzDe3rnwTvxinR/JQ31vx49SLJ2bV6tyoI3jkOP6XzZRffNmlgs4v0apUhoenUrXOKUSnDMsvvCPaL6py7R68B1UFkZSmZCpubWhG7SQWg+m8QcerQpr+nnBpQ5+CWuQyGp0+n9/nx44sdx4yzUiqTGRMwmhUrSOAhS4SI8lGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773124293; c=relaxed/simple;
	bh=x8vqr1fAtyB8RfT7QGJDUM1DM9UZcCL3Ji32ctvvq6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IA0PNEEgxbcZV2Pb1FFKgx8pNpd/LWKM1Wi1Hi8r/vXZoLtl5xM8/mMq6IU5nYKAQ2acvzY1pwTK+nEIMIWeEoUzFkE8SHRarr2ZkVt9OrDSylf/Rd4ndLHwSmC1AJRZBsJ8L7kryVebacnRGho8tjJ1+KvqomJUMVApFTNdMQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wxefry2p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wxefry2p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x8vqr1fAtyB8RfT7QGJDUM1DM9UZcCL3Ji32ctvvq6Q=; b=Wxefry2p7S+k3/wIvEueSUOTc6
	RL5zDSPkaJuAGSymWYKO+8lXUL7z6g0CWdtIYXKPoWGwamSL4EMHD8bF3ZbkgiESLK28BpstohZy8
	sqWg9dXekjbjfXi2p+TuEi4ImphaM3EkhuRQ4b5M+72ov+Y5R5yVaHz9Qa8Nw+hSwIknkzWSY/Cfh
	estkhEiUElNCIcAvMvz8O6A8b2JZOJ2yAItKTwCK0500leRKBx+oF2xeauwMAFd+NrGtNJHAX36EM
	xlC1ZlkTGKRx4FYebFjQ4cgRq0LU8bcJpZes4BNu5xVFxABsFxZliVuLxXeVCwYwClPpl1fE3d/N7
	GhtIrsSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzqcq-00000008n5c-1SuR;
	Tue, 10 Mar 2026 06:31:28 +0000
Date: Mon, 9 Mar 2026 23:31:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, atomlin@atomlin.com,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH v3] module: print version for external modules in
 print_modules()
Message-ID: <aa-6wILF90Y4ndnd@infradead.org>
References: <20260310023807.80140-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310023807.80140-1-laoar.shao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 10, 2026 at 10:38:07AM +0800, Yafang Shao wrote:
> For vmcores triggered by a driver bug, the system calls print_modules() to
> list the loaded modules. However, print_modules() does not output module
> version information.

And it should not.

>
> Across a large fleet of servers, there are often many
> different module versions running simultaneously, and we need to know which
> driver version caused a given vmcore.

Then don't run extetrnal modules, which are not a first part citizen.
Get your changeas upstream instead of just leeching the upstream
developers work.

