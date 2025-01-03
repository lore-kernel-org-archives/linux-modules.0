Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A61FA262;
	Fri,  3 Jan 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918341; cv=none; b=HVqaxwtHs+V8oNoUvp7OnV9o8AgcAipkA0dcNYyXRTPqSlfvRQGqQfwj/mWCNfgRDv79eOucFH8P1gqOM6TpLm1+S8MrC9dfId6/YCVSMl+0FBYGw5eF+9rKU2nJ70sHJLQxloGjRy7txZgH0okg4Rm+NqrIg2SAYqXWVyl1F/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918341; c=relaxed/simple;
	bh=sBtb6vIWkItQOSGLe3vSyL28lkGk8ii7zz3Wh+Oe/7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ste4LpsJuck19/3XqRzJNhI3UBPZHV+LSJNgHAekXNg/ynsbujTu3UWSof8TJTwzGg3UxwqNzdc6PQr4bhfcq6W0OM02Dw4LzToLz8T+2iQNG7/+bGkOP2B+Oi/Ot38SmmlN6zu3jEhKuk43Emujpj0KScRfKnKNERgMmkKIT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr9Qksdt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr9Qksdt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4A3C4CED6;
	Fri,  3 Jan 2025 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735918339;
	bh=sBtb6vIWkItQOSGLe3vSyL28lkGk8ii7zz3Wh+Oe/7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dr9QksdtoXV86hce0C+viL9FIIOgpaBNQP3AGHBkkqe4Zki+NShaiuJmZBLvTmtAO
	 jZwgmDgojavy9tKD16d9TYWEB7hwt0QzLLpL0FoJX8Saw6cxBtNpWAcWhgsL9OGu8y
	 BXitKqpk1XDMbL9tE8WUCWO256Kq534JtA6Pr5TBSS4XEA7QF/zxp55CKDjnjGyPsk
	 1kgho1HKJD8iRFThAKJufwPnWjAxXN6NDGPvs2bQWFTudvNGQJBdEotypNwAbQ1OXm
	 0d8IW7lEaVD294j3NT0/AWsTXbDCkTWqg6X9TzP8neP1GyPDnyC/FtNemIvUCAahah
	 tsUpAzu4HFGhw==
Date: Fri, 3 Jan 2025 07:32:18 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [GIT PULL] Modules fixes for v6.14-rc5
Message-ID: <Z3gDAnPlA3SZEbgl@bombadil.infradead.org>
References: <fedd0c6b-a870-4b8f-8f52-6e11df936678@suse.com>
 <CAHk-=wiihsw2QnwsgYr7xOTpqfjo5ojOaNTBy8hj06Gz+-BDQg@mail.gmail.com>
 <db0cf655-906f-40e3-a9d9-d1854a6dc44b@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db0cf655-906f-40e3-a9d9-d1854a6dc44b@suse.com>

On Wed, Jan 01, 2025 at 01:43:22PM +0100, Petr Pavlu wrote:
> On 12/23/24 21:14, Linus Torvalds wrote:
> > On Mon, 23 Dec 2024 at 02:55, Petr Pavlu <petr.pavlu@suse.com> wrote:
> >>
> >> Luis asked me to look after the modules maintenance for a while, with the
> >> plan to rotate it with other recently added modules maintainers/reviewers.
> >> This is my first pull request to you.
> > 
> > I *really* want maintainers to give me a heads up before people change
> > and I pull from new people.
> > 
> > Please? Otherwise it just takes me by surprise and looks unplanned.
> 
> Sure, I think I got ahead of Luis before he was going to make you aware
> of the change.

Indeed, sorry for the lack of headsup, I forgot we can get fixes in, and
that preempted the pull request rather than waiting until the next
release.

My compromise with the Rust community was that I welcome Rust bindings
for modules and any work needed however I wanted Rust volunteers who
would step up to be both C and Rust maintainers for modules for Linux.
That call ended up with 3 new co-maintainers. To help get them exposed
to maintenance, community, process, I decided it would be good to rotate
every 6 months starting with Pavlu.

Petr is in first for rotation, next will be either Daniel Gomez or Sami
Tolvanenin. I may step out of rotation for a bit so to help give them
more exposure.

  Luis
