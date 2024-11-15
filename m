Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329B42ABD;
	Fri, 15 Nov 2024 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731645801; cv=none; b=dgEVWN5lymCh0ZronN0wa+UR1C4GBozzymGQg7OTImPZ7kImfNpHGlZRIbbr7kDnOBB3gSDsrFlOSg2ieER7J/rJZGpY16ID7jVREQO9m7FzcnbnCep0LWgrzDeZHyqvTdit6jPlIr/ugXnRwRcuTiIiNoe5Wtah3iWR9Gh+nQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731645801; c=relaxed/simple;
	bh=DlEsP+R7bMUbur9zCqIgTBikFKZDRZbyJP2pLEJLiHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCv+WpbMcGdYlntkkIGBpHgX/lbEdDY3YbIpIeYE4RkBQQdUqehQQvBbQPWPFgE7DV3mxHsOMyRKeIXy9CnqSFlPO1BYAv8cg5MCD1T1tyZFGdjmNRHgdPw5kSiIgCNVZXUVGXxZlpHNebhoR873sDCL6Te/e6DhHyyWoDCOgiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dGiwoA9G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dGiwoA9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AD2C4CECF;
	Fri, 15 Nov 2024 04:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731645800;
	bh=DlEsP+R7bMUbur9zCqIgTBikFKZDRZbyJP2pLEJLiHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGiwoA9G0C49ECkaww/j82gV3tokxBo19EFieLL5RBQsC4Watl9yAjAYx8f3Y/IUT
	 cDzT1Nz5RPs6nHCVzE7QJMQLXECQgwHvZWfMxB6+rqUn7xUP+iTrzBQTwN1vWstNT/
	 dXIRbeKLXrMAIscwovqfoAGOhBrx5RMzuNtXgJeg=
Date: Fri, 15 Nov 2024 05:43:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, tux@tuxedocomputers.com,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
Message-ID: <2024111557-unlighted-giggle-0d86@gregkh>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>

On Thu, Nov 14, 2024 at 11:49:04AM +0100, Werner Sembach wrote:
> Hello,
> 
> Am 14.11.24 um 11:31 schrieb Uwe Kleine-König:
> > Hello,
> > 
> > the kernel modules provided by Tuxedo on
> > https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers
> > are licensed under GPLv3 or later. This is incompatible with the
> > kernel's license and so makes it impossible for distributions and other
> > third parties to support these at least in pre-compiled form and so
> > limits user experience and the possibilities to work on mainlining these
> > drivers.
> > 
> > This incompatibility is created on purpose to control the upstream
> > process. See https://fosstodon.org/@kernellogger/113423314337991594 for
> > a nice summary of the situation and some further links about the issue.
> > 
> > Note that the pull request that fixed the MODULE_LICENSE invocations to
> > stop claiming GPL(v2) compatibility was accepted and then immediately
> > reverted "for the time being until the legal stuff is sorted out"
> > (https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427).
> 
> As already being implied by that commit message, this is sadly not an issue
> that can be sorted out over night.
> 
> We ended up in this situation as MODULE_LICENSE("GPL") on its own does not
> hint at GPL v2, if one is not aware of the license definition table in the
> documentation.

That's why it is documented, to explain this very thing.  Please don't
suggest that documenting this is somehow not providing a hint.  That's
just not going to fly with any lawyer who reads any of this, sorry.

greg k-h
