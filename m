Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0C61E4AD;
	Thu, 18 Jul 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322958; cv=none; b=VydC0ntlbEkSNerqXnIyhKe7dQo65S6nfFy87+jPfxQtvnqf1ClgbMHFoQsFaSKARD5TSOshJro1RJHvsSWvl6/qhvGvzBboiP+G6SnY+C+N/4lOF6y7A/6cDildDh3YF2/Bib9Mbz1JRXq3xBQCGXyi5CwhEgjg8Xp7/LNAUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322958; c=relaxed/simple;
	bh=Q8zNgc+7hrY5JnU4IWEXyGDGa6A8Rxwhz3jMgMcDeqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD8Y6uh7k+VJSIljg/AneX/JA+MjfGfAk/MILljw0Ht37x82uMip+LV8cKwmnvrco02wLC+6Hrry4Q6i6YSezclxQ7/YMl7VQ6t9i8CvqFowXI+Cv9MYOD+619FKxRvVFXdtRhH/cARgwNgbw57lenGhlx+Iy+HseCmLbhizcGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qKm1Wzpd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qKm1Wzpd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=nzofLT5tIYdWN9XeUlSlttsrRWtNc7/F41l2/uaJDwU=; b=qKm1Wzpd4/tkRJSx9UoLrzQ4ES
	Bmx7of+BO45TPaDcR/ePUKt5MGLuTgm9Jp5gmP/mFI3oZpdBfFDZpBSAEA9DLtIlJixV1tQONcEKE
	pSdXUEpmlGC5sNBXQ6bBIS7NQMRtMGW6qTV5ORRNvPm/hlWl6sZW4rScvdu1K33NEBiGqeIDAV6lF
	Ul1uli4d2/nOPCMmE4D+EOQrBniROkKIRndxvfQ030wvDcZ2tkJu5d0Nm1zhwZDPw/9ixcZu9pY5V
	R84jinTY3etz4ejKQ8X5p1ExTgmIlr1RCt21EofaVHSiEUJ+L7GubA9mUG3wOd74gRYdVX5+mBAn5
	7V1vW1vg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUUjP-000000004Wm-1hBk;
	Thu, 18 Jul 2024 17:15:51 +0000
Date: Thu, 18 Jul 2024 10:15:51 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Kris Van Hees <kris.van.hees@oracle.com>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Miguel Ojeda <ojeda@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <ZplNxxXS3RLULeI6@bombadil.infradead.org>
References: <20240705111455.142790-1-nmi@metaspace.dk>
 <ZoxdRjpy2hRndqmc@bombadil.infradead.org>
 <CANiq72=VU+PHfkiq8HokfeCEKvQoeBiUaB76XbW6s3f2zYmEtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=VU+PHfkiq8HokfeCEKvQoeBiUaB76XbW6s3f2zYmEtA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Jul 09, 2024 at 12:08:16PM +0200, Miguel Ojeda wrote:
> On Mon, Jul 8, 2024 at 11:42 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > The rationale here is that a rust binding means commitment then also
> > from fresh blood to help co-maintain review C / Rust for exising code
> > when there is will / desire to collaborate from an existing C maintainer.
> >
> > I realize this may be a lot to ask, but I think this is one of the
> > responsible ways to ask to scale here.
> 
> But, yes, I think Rust is a great opportunity to get new
> co-maintainers, as well as getting new developers involved with kernel
> maintenance in general, which could help with other issues too.

Great well then my preference is to not have Rust bindings for modules
unless the Rust community can commit to not only a co-maintianer for
both C And Rust but also commit to not ditching the role; if a C/Rust
co-maintainer gets hits by a bus the Rust community would strive to
look for someone else to step in. This would proactively help with
upstream responsibilities understood by companies who hire developers
in this context. It is why I brought up Andreas's work, I already know
he has a lot of work to do and responsibilities. If not Andreas, who else
can step up to help with this, Sami? While each company varies in
accepting a developer's roles in the community, I think we would stand
to gain to consider the long term aspects of this before it becomes an
issue, so we get employers to understand / accept this as part of our
work. I don't think this is an unreasonable for companies or developers
interested in Rust advancements.

This includes testing, helping improve tests and using existing tests
or automation tools for them so we don't regress.

Clearly, this isn't just about a module_params macro, for example
I'm starting to see other module related code I need to review and
having to be very careful to ensure all of what is ongoing with modules
like Kris's work on kbuild CONFIG_BUILTIN_MODULE_RANGES will still work
in a Rust modules world with Sami's work on module modversions.

[0] https://lkml.kernel.org/r/20240716031045.1781332-1-kris.van.hees@oracle.com

  Luis
