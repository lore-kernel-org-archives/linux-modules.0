Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B7A6F30F;
	Fri, 15 Nov 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731672122; cv=none; b=ghyqwf/8IHrghOVMEDIxxuMC4SVkyHOF8iRMy2CraDWoD3liiWQBuMQTlet1Be6yRqlHh66wjzHpbohBsxVtqkqdFm0joK94h1LWiMw/RTp8EXKd/ubH6utl924n2cMYtNmT2+vrAqph74xdrT6H2U/zGld+nW81tAsBJj2ebyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731672122; c=relaxed/simple;
	bh=9+qERUFS0AA2LpaZdeMa2icf2BqLd698AI0JTy8nXZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewrZJDImSN8Ztz1WBW4rU0pbyOjKdNtdz6yNSBEu+WM4wCNaOh/2BgCZLwZjtRGX1vnx0asI7OV9V61WeQELRbO7vVj56Ew17rne1WcQVM9qQo/d4+rK/8k+Ggpgas+TAS3/TsZGWImk4YkJ8aHSA4DuBTe5V1Hf/tFmpWJqDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svlS5zaI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svlS5zaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932AFC4CECF;
	Fri, 15 Nov 2024 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731672122;
	bh=9+qERUFS0AA2LpaZdeMa2icf2BqLd698AI0JTy8nXZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svlS5zaIeu/Yhm0GOEbycxIIFfQ/72UYqfx0WpeIPvF3jsSj2FG1Aw7Yi57oRDh3R
	 mtgEDqPYzfNh8RRYoCcOd4WAESfT+ocuYkyqPQ4+oArL/GvWu3sSlToTl9xnFFqwIm
	 IK7GTPatQzF1FzSowO5RIFkMJqr2OeTGovVbsMsw=
Date: Fri, 15 Nov 2024 13:01:58 +0100
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
Message-ID: <2024111530-angles-celestial-2d5e@gregkh>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
 <2024111557-unlighted-giggle-0d86@gregkh>
 <6c1952bc-f58d-4c55-887e-6aa247daec5c@tuxedocomputers.com>
 <h5q36ajuzgwf5yrjmqv46x62evifcgoi5imxhcvsv7oxauvxak@sj54oisawqnf>
 <58b85a78-55aa-422c-a21d-254eb16cc8c6@tuxedocomputers.com>
 <2024111522-brush-excusably-cae5@gregkh>
 <3ea99d52-cafb-4c79-a78b-fdd1f9a9fcd5@tuxedocomputers.com>
 <2024111558-albatross-vice-2a73@gregkh>
 <459e15ff-4f1f-4d7c-b49d-ccae540eaa4f@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459e15ff-4f1f-4d7c-b49d-ccae540eaa4f@tuxedocomputers.com>

On Fri, Nov 15, 2024 at 11:59:47AM +0100, Werner Sembach wrote:
> 
> Am 15.11.24 um 11:22 schrieb Greg KH:
> > On Fri, Nov 15, 2024 at 10:40:56AM +0100, Werner Sembach wrote:
> > > Am 15.11.24 um 10:18 schrieb Greg KH:
> > > > On Fri, Nov 15, 2024 at 10:00:23AM +0100, Werner Sembach wrote:
> > > > > I guess what I try to convince you and others is that we _are_ taking Open
> > > > > Source licenses seriously, but still there are mistakes to be made,
> > > > > especially with complex projects like the Linux kernel, e.g. I'm not aware
> > > > > of any other project that uses a similar construct to
> > > > > EXPORT_SYMBOL_GPL()/MODULE_LICENSE().
> > > > The Linux kernel is very simple from a license point of view, your code
> > > > has to be GPLv2 compatible.  That's it, nothing complex or odd about
> > > > that at all.
> > > Then why does the proprietary NVIDIA driver exist?
> > You will have to discuss that with that company's lawyers.  That was
> > their business decision to make, and in my opinion, the contracts they
> > wrote around that thing were a mastery of license law in "how to pass
> > the liability onto someone else."
> But you see where there is complexity, and where my misconception stems from?

No, not at all.  nvidia adds complexity in their contracts with vendors
in order to attempt to circumvent the very simple license rules that we
have.  Again, talk to your lawyers about this, they are the ones that
know this type of thing.

greg k-h
