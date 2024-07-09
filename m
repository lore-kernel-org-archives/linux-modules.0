Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B6143752;
	Tue,  9 Jul 2024 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513633; cv=none; b=fO632M2+WLcaP0tvzzqCbgi0NVuFbJ0KneRAbfL0jKhnIMQUBJqDR5zcrX38rW1nIyzASBwI1EQy02x2DcREE2U495T05AttI4OujEM6re9oBEuKj93ols1LdtQ5mKLGoOvEedFAuApTEZ7UogyAN4ulHzEcHmNqA4RGzdymYzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513633; c=relaxed/simple;
	bh=8swVpidJ5ergHaUtyYa0T5Ao4WQQVKO8d3kfW7RqCAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3s2vjr3rZ7Wu5ZRo73htv0rlbO53yc6gu13WVYr69La6uTBpxtF07/cRi6qlrM0FjJ+ruozZzZ52+XxOZcb+eyZXGPh9b6kNqC/AB641oF1Nj1src84bHX8FBZE8N3EGLFLj2BLVmO+iflgiG9nO+ZR+uSI9DPUvliE1uEKPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MKs58uMT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MKs58uMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7963CC3277B;
	Tue,  9 Jul 2024 08:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720513632;
	bh=8swVpidJ5ergHaUtyYa0T5Ao4WQQVKO8d3kfW7RqCAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKs58uMTimJSNukbLWZVm36D1otxy9BBGzP/Gob20xKl25WDcspRBnkP4N2py/S2S
	 X7NY9l4aN4axsk2IoB5jvqmW4SXmP3lcd5b+oyvO3NjG659aBjUBnv/eiZE98rxHHY
	 YOsSyPUoaa/ItFlU+AIle/K1xTdXgvs23G2qEWDw=
Date: Tue, 9 Jul 2024 10:27:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: nmi <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Adam Bratschi-Kaye <ark.email@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <2024070924-darkening-knee-bfef@gregkh>
References: <20240705111455.142790-1-nmi@metaspace.dk>
 <ZoxdRjpy2hRndqmc@bombadil.infradead.org>
 <LHGWBNSEDaOsx4BbADR1pZYqPV0KKhVaJ1Qvwe9h4UPeERRAA4s1DTIsnFR5rpHBGa6uIG1tU_4hTBXgjAc5BNwNqo0Rg_kOx2W_y0EUy_I=@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LHGWBNSEDaOsx4BbADR1pZYqPV0KKhVaJ1Qvwe9h4UPeERRAA4s1DTIsnFR5rpHBGa6uIG1tU_4hTBXgjAc5BNwNqo0Rg_kOx2W_y0EUy_I=@metaspace.dk>

On Tue, Jul 09, 2024 at 06:00:46AM +0000, nmi wrote:
> Hi Luis,
> 
> On Monday, July 8th, 2024 at 23:42, Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > I'm starting to feel the same way about modules, but modules requires
> > more work than the firmware loader. And since I also know Andreas has
> > already a lot on his plate, I'm at a cross roads. My above request for
> > the firmware loader made sense to the person working on the firmware
> > loader changes, but who would help on the modules side of things? And
> > does this request make sense to help scale?
> >
> > The rationale here is that a rust binding means commitment then also
> > from fresh blood to help co-maintain review C / Rust for exising code
> > when there is will / desire to collaborate from an existing C maintainer.
> >
> > I realize this may be a lot to ask, but I think this is one of the
> > responsible ways to ask to scale here.
> 
> I am not sure I am the right person for the task, because as you say,
> I have a lot on my plate. But perhaps lets schedule a call so I can
> get a sense of the required effort. 

Kernel development is done through emails, not calls :)

If a submitter isn't willing to maintain the code they submit, then it
should be rejected as maintance is the most important part.

Sorry,

greg k-h
