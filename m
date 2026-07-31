Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186072EA754;
	Fri, 31 Jul 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505879; cv=none; b=lD6QJlorw/g5rLELYm13qixffAyyG5vP6Foji/klM6VQ2Byn/fQgP7FUhnxFIvzR51t16MDLn3J2vJXCw1ljmC1+tYf7qxHB3KoMQt+Cj92ygGLXH9Ay8GudpcCdvtnYy3tiMIIZdAFeDpjqKMgrw069NPVeE0QPgZNB+C81nN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505879; c=relaxed/simple;
	bh=GWAZim2V30VMLWOPAUMazG2fKrywJO5mir5oB8QLoCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3BVw2QkSkN3x+14NNSIQ82flvHDzBmcG4+TmfZAga1410L0wZeJA4WSLeRc6+BlLckG7e+aqQquIk07KJqgGF87PxJMxagpdzM3hm8zr2YONgsuNehYMrlg3RDUtbD3yli3S/OmDImZBS6cHHnV9imwvyJVSC1uINvY05qKhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R5gfaDdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R5gfaDdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB871F000E9;
	Fri, 31 Jul 2026 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785505875;
	bh=5/+3MA+2pSCTipp3UdibdYu7N8D6n8PyxxPZgopB5XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R5gfaDduPJQlZ9sjHI8DNXarl1aulr+ylHjn7L7/CHSGJAggqFY4gSYXKcfLNfxxN
	 Q+NG8QpVUzZysR/nvTeY0azisGPaE4mWUjhn2INnPu82s9efep7RIXNPQ/yTsZawSJ
	 XiGvd5V1Uz3vJoIBv7DchzlnUw7St1R1txgmfR0s=
Date: Fri, 31 Jul 2026 15:51:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 1/2] module: remove MODULE_VERSION()
Message-ID: <2026073151-imitation-ageless-5f3d@gregkh>
References: <20260731-module_ver_remove-v2-0-c9163858f382@linuxfoundation.org>
 <20260731-module_ver_remove-v2-1-c9163858f382@linuxfoundation.org>
 <20260731131854.B085B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731131854.B085B1F00A3A@smtp.kernel.org>

On Fri, Jul 31, 2026 at 01:18:54PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Immediate, unphased removal of the `/sys/module/*/version` sysfs ABI and `modinfo` version outputs.

Heh, that is intentional!  :)

