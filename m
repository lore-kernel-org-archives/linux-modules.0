Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41936155A5F
	for <linux-modules@vger.kernel.org>; Tue,  9 Jul 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517146; cv=none; b=Qq/t5/ghBcvmcTEMaySoTnPTFa6Ec7bwo7KYU6dMKWzZsgadSfCPQeOQBH2Qdi4sxQbaQG5JWVFdLDp+9EW4zizXNTm/sGj+Iix85yQZEdi3ULNPNYJROhLlxI+WKTM1IwKmO2vn+yP0z6vfGAPjAQdqyvs0OJERPY0HyMLtxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517146; c=relaxed/simple;
	bh=CbggQywMclYItKuSRcDiI3tcqHQqBDwiC81LnGPVLKg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQcuo/7I9kgvBje+Ji5mWorGtl1z1t34HelnVCsPYiRAaCTGcGORM87fctJ+52lOTlIPsDWt9+3LU8F+0DR03YK6st2aSeES8CLsKGz4FguDM5ZGfBe2awCrL2cOd4Sz8yvEX48PWnu4kf7fLkUQhCzdiIV+s9dWLEd7G96zYw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=Sv/NxuLn; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="Sv/NxuLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1720517137; x=1720776337;
	bh=CbggQywMclYItKuSRcDiI3tcqHQqBDwiC81LnGPVLKg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Sv/NxuLnup4HHc1ufAj6dGVSs7s+DPf7SXYovOqdg0AAeb3MMb5L/Ajb3ol8GziV5
	 mgtETAZ9zk+yUcYhckiI5Ou/hj+cfXGUF4nsMc92EZJhoEFDwI7GSKTQbO1NWAaaU4
	 KPBEh+lOuRkMjXoMl4ZezCD8n5K/NJgMQtIolM76Uo8VNiqKP8IreexEdrPR/oQHi/
	 rBleJNlkYGzt3GDl30Yxu9f6xuVfHEpJxq4urE04SJnLF+b9L4xKiwRqy7UnOnLn4J
	 jvUIR9Cz6axcC85MkCflf4eFlKY8TCYi8310kyZcsQXipXs87m5dq7LyHKeG0D1hGi
	 DoCj7Aot4/zMQ==
Date: Tue, 09 Jul 2024 09:25:35 +0000
To: Greg KH <gregkh@linuxfoundation.org>
From: nmi <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>, Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <WayJa_6KjKqqYlkPyVKr-HT2LOGIBgTfNucynbLdrUPm_JusRDoLJGRpOqcUPO2OVWEQDRAqFYBj9vhK8E_NOU66bfE2TK3DgNuxEhQedRc=@metaspace.dk>
In-Reply-To: <2024070924-darkening-knee-bfef@gregkh>
References: <20240705111455.142790-1-nmi@metaspace.dk> <ZoxdRjpy2hRndqmc@bombadil.infradead.org> <LHGWBNSEDaOsx4BbADR1pZYqPV0KKhVaJ1Qvwe9h4UPeERRAA4s1DTIsnFR5rpHBGa6uIG1tU_4hTBXgjAc5BNwNqo0Rg_kOx2W_y0EUy_I=@metaspace.dk> <2024070924-darkening-knee-bfef@gregkh>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: 39e6b85eabb777531f448c0a05d95b4b0ed5c28d
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Greg,


On Tuesday, 9 July 2024 at 10:27, Greg KH <gregkh@linuxfoundation.org> wrot=
e:


> On Tue, Jul 09, 2024 at 06:00:46AM +0000, nmi wrote:
>=20
> > Hi Luis,
> >=20
> > On Monday, July 8th, 2024 at 23:42, Luis Chamberlain mcgrof@kernel.org =
wrote:
> >=20
> > > I'm starting to feel the same way about modules, but modules requires
> > > more work than the firmware loader. And since I also know Andreas has
> > > already a lot on his plate, I'm at a cross roads. My above request fo=
r
> > > the firmware loader made sense to the person working on the firmware
> > > loader changes, but who would help on the modules side of things? And
> > > does this request make sense to help scale?
> > >=20
> > > The rationale here is that a rust binding means commitment then also
> > > from fresh blood to help co-maintain review C / Rust for exising code
> > > when there is will / desire to collaborate from an existing C maintai=
ner.
> > >=20
> > > I realize this may be a lot to ask, but I think this is one of the
> > > responsible ways to ask to scale here.
> >=20
> > I am not sure I am the right person for the task, because as you say,
> > I have a lot on my plate. But perhaps lets schedule a call so I can
> > get a sense of the required effort.
>=20
>=20
> Kernel development is done through emails, not calls :)

This is such a confusing statement to me. Of course people are using video =
calls and even meeting up in real life, to discuss matters of kernel develo=
pment and communicate technical details? Perhaps you could clarify a bit mo=
re what you are trying to communicate?

>=20
> If a submitter isn't willing to maintain the code they submit, then it
> should be rejected as maintance is the most important part.

Unless I misunderstand something, Luis requests is about the C code that is=
 already in the kernel, not the code I submitted now. Of course I will main=
tain the code I submit, if required.

Best regards,
Andreas
