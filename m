Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192C382368;
	Mon, 16 Mar 2026 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651465; cv=none; b=VspiS7kx6iRvgMFpvlC8k4XzedQAaUmXBCFdB1sgwBpmR8R7LDtX36dL7VUdOXda3eA16tqORKJhFvjWJE2gC8LX8aHbWeikq4gX+lr4uOplI1GAdMOqJP+AlrRHfTMVlOvc3dOMdoZEAj2622HMhZZhmS/LfuQRFnq+1LKX9u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651465; c=relaxed/simple;
	bh=SCf1RFUQzCz8Y4ad7IZGpSyhj6FrCuBaRU/GdYeQ/Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAhR+l8H3/Xj9V5gn7jrEu0rD/na332wk8vAtLIG4oCUfpRcwP6MVsPEyf5nmqmCU/MWv4qm3RzCWaiSj1KlUfq3Cngspp03MBiZaldt4frtNvqonrsx7P4x+kvdHQkzbVJJpwP3cs6QPLzlItFmTVnONulOg5wS0EiroekajjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kPyb1OSr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kPyb1OSr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5vhN9U2pPDWEsUGYLhkenSRF13hw4G4rHsoAC7E75ms=; b=kPyb1OSrE+MaupU/fc6qzYBU9k
	7ARw9fmOPWVcifm7GvanauLW00ilixDD5nsSvmixLYn1RJSoOIAMq2A3lTqDXlHWdrHdNaQHm1rrN
	uBOtFt+ICRXf3HUnsP/ECvx+ReA0B6aAxFN2Kq9BPJGvNbrBqg9Fm9woyUIbH+eKwIyqL5M7RWBk6
	vtoEAL+kzNSYt/1bnifHw1jBnKtBGVVOO029ZQgz6hkgEUUYcr4wKz3Yd1LVAZ5fWElBeEf7uoK6R
	plYoYE56OiU5WgpXX1jmlyfQky5tTRxnHEV0FROVu2/SNHzlOvb/QKh3Qm6umuR6UFutaBQlQd8Dk
	WA0d5i1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w23lc-00000003aOI-0JEh;
	Mon, 16 Mar 2026 08:57:40 +0000
Date: Mon, 16 Mar 2026 01:57:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] module: remove MODULE_VERSION()
Message-ID: <abfGBKsrGaHyLHtA@infradead.org>
References: <2026031341-evolve-repeater-987b@gregkh>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026031341-evolve-repeater-987b@gregkh>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 13, 2026 at 03:20:42PM +0100, Greg Kroah-Hartman wrote:
> Module "versions" do not make sense as the kernel is built all at once,
> the "version" is the overall kernel version number, so modules can not
> really be described as having a unique version given that they rely on
> the infrastructure of the whole kernel.
> 
> For now, just make this an "empty" define, to keep existing code
> building properly as the tree is slowly purged of the use of this over
> time.
> 
> This macro will be removed entirely in the future when there are no
> in-tree users.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

The removal should be an easy scriptable one after the next -rc1.
