Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7715339D;
	Tue,  9 Jul 2024 06:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720504862; cv=none; b=meUDSy+QNCSBU/txq5+q/++liXntw+p6er9rBKT0axHQ6qpkvtsdARbuOm5OhxhJm3NIxuQe0vVWlX84cwJ1beK/HFdyAiuPb1SDi4q6o56qWvoGppQQysbuk+9uo08oCZu1NapZxuf2fm/xrseDkZJAifQ/XUz7YrIsHi5kMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720504862; c=relaxed/simple;
	bh=cjVkguTcrkVE0w6ZweMJZaUA2qKicyJLz9aNAlqZy/s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2m/2SkMae2r2kGpvoOeyqqOFr+df+vTm6+2jVBnaQvPp1c7JyzUENVtcEgj6vh3vnhMYKVrNX2MruQPFofCXfOHnftRQBWoyPp6/6cVEb2Ozcm5WujvNo56Cpm1FBPCtQJubuRbx/Apf7zQgNax6ABxQUAHs2vj9uW8QddPKJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=hYf6tc9x; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="hYf6tc9x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1720504850; x=1720764050;
	bh=cjVkguTcrkVE0w6ZweMJZaUA2qKicyJLz9aNAlqZy/s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hYf6tc9xTv2o7Jcsj1oMmEWl8mDIoi/vtJFOlI4ahYFWAak1iIpw/krhldw7uqyy4
	 l8bAxEDOyHIZQ5UJtQvI2BZFZjy2Om26+8gxljRYUb91y9D3nZ4XPPeaEM9y0wYje2
	 dtR3nta8PXiIA0ATqkxDnMZKRn8LhoUBLhyUhzmzwgp+ZiyY7o71TWdW2i9tLKScm5
	 cjeQnCnC8XYQh2lncb4X0QjpbBSrdpk3pGjqTl0Qev3xOgvMmT49UQpCBSMqH1CDmS
	 cMoHel0ALnKZckHjzjYT3Eh+CL8tNNtm49QM4L/nLzUkq4FmKZG6H1Mt4O9f9C5TFI
	 uE8teoa66jrXQ==
Date: Tue, 09 Jul 2024 06:00:46 +0000
To: Luis Chamberlain <mcgrof@kernel.org>
From: nmi <nmi@metaspace.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>, Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <LHGWBNSEDaOsx4BbADR1pZYqPV0KKhVaJ1Qvwe9h4UPeERRAA4s1DTIsnFR5rpHBGa6uIG1tU_4hTBXgjAc5BNwNqo0Rg_kOx2W_y0EUy_I=@metaspace.dk>
In-Reply-To: <ZoxdRjpy2hRndqmc@bombadil.infradead.org>
References: <20240705111455.142790-1-nmi@metaspace.dk> <ZoxdRjpy2hRndqmc@bombadil.infradead.org>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: 27bf84e35fba8303395607499fdd21e54b7c4836
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Monday, July 8th, 2024 at 23:42, Luis Chamberlain <mcgrof@kernel.org> wr=
ote:

> I'm starting to feel the same way about modules, but modules requires
> more work than the firmware loader. And since I also know Andreas has
> already a lot on his plate, I'm at a cross roads. My above request for
> the firmware loader made sense to the person working on the firmware
> loader changes, but who would help on the modules side of things? And
> does this request make sense to help scale?
>
> The rationale here is that a rust binding means commitment then also
> from fresh blood to help co-maintain review C / Rust for exising code
> when there is will / desire to collaborate from an existing C maintainer.
>
> I realize this may be a lot to ask, but I think this is one of the
> responsible ways to ask to scale here.

I am not sure I am the right person for the task, because as you say, I hav=
e a lot on my plate. But perhaps lets schedule a call so I can get a sense =
of the required effort.=20

Best regards,
Andreas

