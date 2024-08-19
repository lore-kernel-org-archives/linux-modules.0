Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E453F9CC;
	Mon, 19 Aug 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104765; cv=none; b=K0R+6+DcHxf+Z3mPjDzKLO199RZ2TwiFy4ApMQjZzoKIFvF0gO8C6f68mdOaxCTBuUc8a0MEVGN8j8jpk4s2feDobglLdW1o9aD7QcUhDQeQSR3blAuB4OFrHZag/P8k1sG5B3oGGXjDUuSZGbdBWGIdb2SzE39+/GlOD+z/+W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104765; c=relaxed/simple;
	bh=35T7/Aohfjch7/lh6Q3THDvtEv05kNIwetD7JhqyDRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAJo4/626EpqCJu3gQ+jB9fi0YBMBEFPZBhfPKTm43GulTsWWZbe8txkfEXJX9fjNE8857lA9ZGODVh9V7SYfQYE3qY1cFqwpEqr/PBKLmf1HOxKIcMRHopRbuRON2cJJRu2Y2LuyddEx9cCOMPuMspy6/D8MlMUQ0bYi/SMBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zZaJfN4R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zZaJfN4R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=6Ns1rz6nFORh3L1YJNQmC2wwxnJMNk+I926LQj3IOeY=; b=zZaJfN4RRLYG49wTIPs9xsG2x4
	fGBYfeNMqacNwHAyywmyw1F2i1PjFKb2ca5fgfJrWulwwi+bxbTbuD8rgSac5SfNMooLnOPOVtgKd
	BXmyh8HTPlVeMteCZKnBysGNh4dtp7mtS4nYoUkCq5TnAG4wbMu4eGOAnyYxlNSukKmAS4vYBh6U/
	t1oADChJr0qt6XVaa8m8Unz9tvRwFElw9nuYFIznDsQax4niEMcletrlxv2z6yLqJF/yC9wA1FgdB
	09CuEXAADc2hmQUhDrEEZdXqFbEsowwafbj9rFSefysjM948w97syoAE3Fxxvf6gmRa8s9nyrhwGN
	ci4sl7RA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgAPH-000000033Lx-1DVL;
	Mon, 19 Aug 2024 21:59:19 +0000
Date: Mon, 19 Aug 2024 14:59:19 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Kris Van Hees <kris.van.hees@oracle.com>,
	Andreas Hindborg <nmi@metaspace.dk>,
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <ZsPANzx4-5DrOl5m@bombadil.infradead.org>
References: <20240705111455.142790-1-nmi@metaspace.dk>
 <ZoxdRjpy2hRndqmc@bombadil.infradead.org>
 <CANiq72=VU+PHfkiq8HokfeCEKvQoeBiUaB76XbW6s3f2zYmEtA@mail.gmail.com>
 <ZplNxxXS3RLULeI6@bombadil.infradead.org>
 <CABCJKud=dfBKaCSqW2NbDCiN=EX0hGxkZ7H+dCd5mK_9NbwBVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKud=dfBKaCSqW2NbDCiN=EX0hGxkZ7H+dCd5mK_9NbwBVw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Jul 24, 2024 at 05:04:25PM +0000, Sami Tolvanen wrote:
> Hi Luis,
> 
> On Thu, Jul 18, 2024 at 5:15 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Tue, Jul 09, 2024 at 12:08:16PM +0200, Miguel Ojeda wrote:
> > > On Mon, Jul 8, 2024 at 11:42 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > >
> > > > The rationale here is that a rust binding means commitment then also
> > > > from fresh blood to help co-maintain review C / Rust for exising code
> > > > when there is will / desire to collaborate from an existing C maintainer.
> > > >
> > > > I realize this may be a lot to ask, but I think this is one of the
> > > > responsible ways to ask to scale here.
> > >
> > > But, yes, I think Rust is a great opportunity to get new
> > > co-maintainers, as well as getting new developers involved with kernel
> > > maintenance in general, which could help with other issues too.
> >
> > Great well then my preference is to not have Rust bindings for modules
> > unless the Rust community can commit to not only a co-maintianer for
> > both C And Rust but also commit to not ditching the role; if a C/Rust
> > co-maintainer gets hits by a bus the Rust community would strive to
> > look for someone else to step in. This would proactively help with
> > upstream responsibilities understood by companies who hire developers
> > in this context. It is why I brought up Andreas's work, I already know
> > he has a lot of work to do and responsibilities. If not Andreas, who else
> > can step up to help with this, Sami?
> 
> I agree, having a co-maintainer from the Rust community sounds like a
> good idea. It would be great if someone actually working on the
> bindings could step up, but if there are no other volunteers, I can
> certainly help with this.

Excelent thank you for this, yes we can certainly use your help with
this. After this went out we also had Daniel Gomez express interest, and
Petr Pavlu expressed interest as well. I think with all of us we can
likely grow a strong base to cover both C / Rust side of modules.

I'll send a follow up maintainers patch up for this and we can move on
forward with review / future integration of Rust module code.

  Luis
