Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AF612E75;
	Mon,  8 Jul 2024 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474954; cv=none; b=pBZxoeJF4tK1EGWZKjxIX0aVhE1SvKuO3mFOBdwuUlSr79M3uXrxmQ6xS4prYJxpNGdDmEgswLxVTJCEb7dE/h84hkojjN+y5psibp5WWLHfaDld8C4scdKejE2JVdkN8qEUdFCk2riPPi84mUOKMKszMdVdGl86orpxTNkARfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474954; c=relaxed/simple;
	bh=nNHjOUmsuhksRuBi0fRdrf0oyZ550QXs02FNHRVIwb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i91hLsEHFm2yWPLAkSylrNmIfQeHPy8+U1QmblMVDXCCC+GXISzsBsuq7d+m2bTtyriB42S21oxLshhLgF0sPVKFcvWPo5s9XtOIr+/1enoR9blVtLyDJjj/yFAUA4aMWmeqhoJKdQ5dEIPbUph9EnkzdMaV1GZyiZ2IFcVkmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JmsIav5a; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JmsIav5a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+4oLNogoKqNdECWwvx4V4mZJfeGXVDyegSQAzpBI+nY=; b=JmsIav5acmpHbrPFIcr5DCSWbC
	KqomigDtbRr7st/F5qsV//WJpwj9UkZiA7Sb2yIrlOVtbMzhQJGxN7O16wbMc/sQGTI5rpWKs+9OG
	CbD6MxkKQLOEJGhJG/RZcjL6kbvEnOkvhZOxnMDhwgj69JFMfgVwlGwR0y1iYlipZpqZ47C9ilal2
	WWOV1CtcEd6P4daQ95+Plf7Ej7Vo+aHM6m2kFFS8uf9RnsTrN8KuJNoJ2lb5Q2bloDDM1/9zQjQ4a
	SELBsPDpnDLi2pY0eT/St9WPG25l9bXv6pvP//k/RoTzaNux1/iDkffJ7lWb79A9w1c/g/Fy1EOlI
	BGDC5j+Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQw7y-0000000573F-2DGQ;
	Mon, 08 Jul 2024 21:42:30 +0000
Date: Mon, 8 Jul 2024 14:42:30 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Adam Bratschi-Kaye <ark.email@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <ZoxdRjpy2hRndqmc@bombadil.infradead.org>
References: <20240705111455.142790-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705111455.142790-1-nmi@metaspace.dk>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Jul 05, 2024 at 11:15:11AM +0000, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> This patch includes changes required for Rust kernel modules to utilize
> module parameters. This code implements read only support for integer
> types without `sysfs` support.
> 
> This code is a reduced and updated version of code by Adam available in the
> original `rust` branch [1].
> 
> [1] https://github.com/Rust-for-Linux/linux/tree/bc22545f38d74473cfef3e9fd65432733435b79f
> 
> Cc: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> 

This poses an interesting challenge I'd like to take up with the Rust
community. I'm fine with Rust bindings, however many C maintainers
neither don't speak / write Rust, and in many cases many don't even want
to touch Rust at all. In my case I want to get there.. but just haven't
had time yet. So we have to live with that world. But to help with a
Rust world, clearly we need to allow for some Rust bindings.

As a compromise, I recently suggested for example for the firmware_loader
Rust bindings to be acceptable if and only if we could get the developer
doing those changes to be willing to commit to also being *both* a C and
rust maintainer for the firmware loader.

I'm starting to feel the same way about modules, but modules requires
more work than the firmware loader. And since I also know Andreas has
already a lot on his plate, I'm at a cross roads.  My above request for
the firmware loader made sense to the person working on the firmware
loader changes, but who would help on the modules side of things? And
does this request make sense to help scale?

The rationale here is that a rust binding means commitment then also
from fresh blood to help co-maintain review C / Rust for exising code
when there is will / desire to collaborate from an existing C maintainer.

I realize this may be a lot to ask, but I think this is one of the
responsible ways to ask to scale here.

  Luis
