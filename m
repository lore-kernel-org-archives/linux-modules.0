Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8918F2DB;
	Fri, 15 Nov 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666135; cv=none; b=WLNeo3j6Cxbrk8ZT9asr0rUXsGBCLpKRFR+nZdUzuXwNtuf+ucWiUuhQdTQrifFHEBvXNBKgW5XEY1DCAFYMiizHWa1WUjMJtTzJr+AVbCTsDSXV3EhNb5WuK/VvM77Ziay634kL1H5kPKLbTqifjWQ07yyYFWoDv+1pv1uyrJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666135; c=relaxed/simple;
	bh=QJAr2AZr2CkGMCpQrbpd08IUMAZ0ehEw4Samp12OP0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ6PuzQ6N0biO1kOU3bOQTTqw8C038kR7Wvt3982L57nPEaCv1U6juIEU/w2XvnciUB+4W/BO32mXaO1jUO4a44/ZRrafhnZtWQjJi3XFxSEJLiqY4WaiPYsRbDTHYCkgYeW4ideodKQ0XULQf/Q6izT33DL26svzVWukkszQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mOkgerFK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mOkgerFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B946C4CECF;
	Fri, 15 Nov 2024 10:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731666135;
	bh=QJAr2AZr2CkGMCpQrbpd08IUMAZ0ehEw4Samp12OP0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mOkgerFKaRivr8mbiUVLMi72sDUOUkls8h1t+W2ooBNV9EXv7ZCZ3YNxs9gdMdmB8
	 j738o4gxD/v3JF8xa3Gn19F3erIbtWqswOPcB1BjG6cj/QxkghcSgrATxKyRTnUYYg
	 tcStkRIbEqg3wDev1ma2JJarHKTcmyhFoYtL6JrE=
Date: Fri, 15 Nov 2024 11:22:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Luis Chamberlain <mcgrof@kernel.org>, tux@tuxedocomputers.com,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Vinzenz Vietzke <vv@tuxedocomputers.com>,
	Christoffer Sandberg <cs@tuxedo.de>
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
Message-ID: <2024111558-albatross-vice-2a73@gregkh>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
 <2024111557-unlighted-giggle-0d86@gregkh>
 <6c1952bc-f58d-4c55-887e-6aa247daec5c@tuxedocomputers.com>
 <h5q36ajuzgwf5yrjmqv46x62evifcgoi5imxhcvsv7oxauvxak@sj54oisawqnf>
 <58b85a78-55aa-422c-a21d-254eb16cc8c6@tuxedocomputers.com>
 <2024111522-brush-excusably-cae5@gregkh>
 <3ea99d52-cafb-4c79-a78b-fdd1f9a9fcd5@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ea99d52-cafb-4c79-a78b-fdd1f9a9fcd5@tuxedocomputers.com>

On Fri, Nov 15, 2024 at 10:40:56AM +0100, Werner Sembach wrote:
> 
> Am 15.11.24 um 10:18 schrieb Greg KH:
> > On Fri, Nov 15, 2024 at 10:00:23AM +0100, Werner Sembach wrote:
> > > I guess what I try to convince you and others is that we _are_ taking Open
> > > Source licenses seriously, but still there are mistakes to be made,
> > > especially with complex projects like the Linux kernel, e.g. I'm not aware
> > > of any other project that uses a similar construct to
> > > EXPORT_SYMBOL_GPL()/MODULE_LICENSE().
> > The Linux kernel is very simple from a license point of view, your code
> > has to be GPLv2 compatible.  That's it, nothing complex or odd about
> > that at all.
> Then why does the proprietary NVIDIA driver exist?

You will have to discuss that with that company's lawyers.  That was
their business decision to make, and in my opinion, the contracts they
wrote around that thing were a mastery of license law in "how to pass
the liability onto someone else."

Luckily we now have open drivers for almost all of that hardware, so
it's not so much of an issue anymore.

Again, talk about this with your company lawyers, they can explain it
all much better than I can.

thanks,

greg k-h
