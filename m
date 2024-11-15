Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355C170A0C;
	Fri, 15 Nov 2024 04:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731645643; cv=none; b=GuB4xi+/AtTgi7G1cauQjzp75cxY5p/p3O1lDhxN33vuHfPFzOZONhyWp+/5ngtEVqMfRzhCAihCLzKjx3Z4J8r2rz42L8Mp91sQlHKVifRK44LSERlE6EC1z2NzgkoSjx8SM/1PEKS26khkASxKfAdZDVUN2pUB/9km2BKSPYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731645643; c=relaxed/simple;
	bh=s5Sf/073PZg0plaPLRk7Xqrl7dbJWb5pAAlCEskPFqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=debbnG+HaNEiM5wUSb+iH7Ath12ln6Q5tTbHtgMxs9Bk5yCPYk5feQUfw5gwWjJlvxg9wroV9xQYwcSYfwyuQNHAcCQV5d8/mcYz3WBWJCM03x+vRcVAEMnmRqRZcqp+2YjDZX9Ps5kqHSWEXD+DJaGuQSozmiLSXDG19202yek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i5eJYGVl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i5eJYGVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99872C4CECF;
	Fri, 15 Nov 2024 04:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731645642;
	bh=s5Sf/073PZg0plaPLRk7Xqrl7dbJWb5pAAlCEskPFqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5eJYGVlR8pUe14oi8sfcDVauEGlO8wzsLLXl4LOrNO8ZLp9Dy4h574PDTtOMWtzS
	 8rWP4ygFu1gM9O5eUXL0aRI6jdwmVvZvI52BtvV+zU31y53x6y6aFYe8BCDW7FdofE
	 nMGGmbI8t5VAFkE1horjVonzFwinMk5tisFFTO8I=
Date: Fri, 15 Nov 2024 05:40:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Werner Sembach <wse@tuxedocomputers.com>, tux@tuxedocomputers.com,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 2/2] module: Block modules by Tuxedo from accessing GPL
 symbols
Message-ID: <2024111513-gave-gracious-5f7b@gregkh>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <20241114103133.547032-6-ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114103133.547032-6-ukleinek@kernel.org>

On Thu, Nov 14, 2024 at 11:31:34AM +0100, Uwe Kleine-König wrote:
> Tuxedo licenses the modules used on their hardware under GPLv3+, to
> "keep control of the upstream pacing" – and want to re-license the code
> while upstreaming.
> 
> They were asked to then at least not use MODULE_LICENSE("GPL") which
> declares compatibility to the kernel's GPLv2. They accepted the pull
> request and shortly after reverted the change and so continue to lie
> about the license.
> 
> So teach the module loader that these modules are proprietary despite
> their declaration to be GPLv2 compatible "until the legal stuff is
> sorted out".
> 
> Link: https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427
> Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


