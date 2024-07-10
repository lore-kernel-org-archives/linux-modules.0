Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766C1DDC5;
	Wed, 10 Jul 2024 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617746; cv=none; b=bwEUJ/kMputaRYAvWq2qC6MfcluKZB2kORFA7MJYrFZBFy9Kc5wrqA6JnGYHTavo4nk8vwOD9RKV4Qk1USEhS5oFlG5UOe266gLiMzHND96cTrUsqSotGzuBLflS0+GCgJoTYnGgqJEEa28hsg5EiB4uFncWUXW1dPfHA14v+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617746; c=relaxed/simple;
	bh=H/Mh5dijKIbLYIxonJjEKCDKJU/iEvbrdpiVCnmG2dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxLRvVi4kh/92VXHc0Lybc5PqGskRozBZU2qhWI9tQw3wYZAaF41yW9qTKHH92CsNu5PGDteR8UZ/ULOgrqJJs9Yo3sKCFhQRl8987+ISebWZIOqS1D7hWs87EsFJtQvOY05pSYDO/3i1wukey4JuIK1k70mED6BjFWDRnMzCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PaD2r72i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PaD2r72i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA1FC32781;
	Wed, 10 Jul 2024 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720617745;
	bh=H/Mh5dijKIbLYIxonJjEKCDKJU/iEvbrdpiVCnmG2dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PaD2r72iJ7Oz+lB6QWTBKvGGi1zGUpmdiwtKSwfAnT8zbaLBRanI7OPDR2Nw9+UEo
	 NarRLTQhlJ1jOJBnDZJzBQUFGrEQTrUVBPwj5Ar9JksnyoG2pKGABp5iYaEe3dDxZH
	 mLCigsguIlw2/S3JVRHdl8wVimCYV43VfDqUxrIU=
Date: Wed, 10 Jul 2024 15:22:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?=C1gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, patch-reply@agatha.dev
Subject: Re: [PATCH v3] init: staging: Fix missing warning/taint on builtin
 code
Message-ID: <2024071032-hardened-discard-4cf6@gregkh>
References: <zsk54zosv6tht4j4nma4ix7lq2knxi3ylqadd2foznc72nkaa3@xbc7gpozx6ai>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zsk54zosv6tht4j4nma4ix7lq2knxi3ylqadd2foznc72nkaa3@xbc7gpozx6ai>

On Sat, Jul 06, 2024 at 12:15:01AM -0300, Ágatha Isabelle Chris Moreira Guedes wrote:
> Fix the absence of warning message and kernel tainting when initializing
> drivers from the `drivers/staging` subtree from initcalls (when
> configured as built-in).
> 
> When such a driver is built as module and the module is loaded, the
> `load_module()` function taints the kernel to signal code of unknown
> quality is loaded, and produces a warning like this:
> 
> [    8.076352] rts5208: module is from the staging directory, the
> quality is unknown, you have been warned.
> 
> The same behaviour is absent, however, when a staging driver is compiled
> as built-in on the kernel image, since loading it happens through
> initcalls and not through load_module().
> 
> This might prevent relevant information of being available on a bug
> report (i.e. on a panic log) among other possible problems.
> 
> NOTES:
> - The patch is written in such a way that all non-staging drivers are
>   kept the way they were, except for staging drivers built with
>   `-DSTAGING_CODE`.

That's good!

> - Since it changes some macros related to clang LTO as well, I tested it
>   and it works properly in kernels compiled with both clang and gcc.

This is odd, why is it messing with LTO stuff?  It should be much more
"self contained" than this I feel like.

I see what you are doing by trying to use some of the LTO macros again,
but in doing so, it makes it really hard to understand the diff and feel
comfortable with this.

If you want to stick with what you have done here, can you split it up a
bit more?  Once patch for the LTO header file changes and then another
that only adds the staging stuff.  That way it's easier to review and
justify that nothing is going to be broken with this patch.

> - Some `checkpatch.pl` errors, warnings and checks (with `--strict`) are
>   present. Some were already there, some I introduced but I think
>   they're unavoidable. Some IMHO don´t make sense at all, I think they
>   would apply for most regular macros but initcall macros are just way
>   different.

Yeah, checkpatch and macros can get tricky, use your best judgement here
and it looks ok.

> Fixes: 061b1bd394ca ("Staging: add TAINT_CRAP for all drivers/staging code")

I think it really fixes the commit _after_ this one that turns on the
taint for the build :)

anyway, nice work, I think it's almost there!

greg k-h
