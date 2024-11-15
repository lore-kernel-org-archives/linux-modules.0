Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C952CA5B
	for <linux-modules@vger.kernel.org>; Fri, 15 Nov 2024 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655801; cv=none; b=NVr3Vp3eKL4g1MOBYHduUl1v2ICaBuH7ZJzphmH80IB9V0sjcP269Bkw5k3fIT2MD6ccPc5AODq/faIQ7t4ONE07tQcCSYwPExPgTgEjhUi/zaufa0FtR24Nl04ZDvfIpB8Cm8DKoxVCn5zbOInZDnv1hEIkji/rqMp73dkqFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655801; c=relaxed/simple;
	bh=GgSbgWg4MW1L3JYXj9d335LNafj6YVAmSdOuM+0t5nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKA9f6ICtNNjkgD9w33HVXOPbL3wfBO4iE97bAftRp9ll5DyJRS7kxV/lpCOnAKZKDRgYRgGtubCIM+HmD+SoAygBuP8ftfitl1KkW7DtJJ/TGk4H+jOgfM0sxE0ERIB+/TBjGVRygcr3U0EdPJ1TvxarSsr5W5wV54dRw3S4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SmUs6i5t; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SmUs6i5t"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53a007743e7so368144e87.1
        for <linux-modules@vger.kernel.org>; Thu, 14 Nov 2024 23:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731655796; x=1732260596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4C89xO91Qp04ruzBXQ8iOKApTYhEHlHgzGUbAr/+YWA=;
        b=SmUs6i5t+x96s87oNGeBouycYToU/7BMyxpbklXeevuvsSJ6H9EWZxjDtHiVp+szR5
         p06fnSbp1M04zvpHm3IS47GuQKgdvI3MxvN+WTA7PZdTH7HLasqW7C2TIuA/GzXYHcFm
         09NJqfPmMXmFlg6n4kqxJt10S6eeiL3nHyQDxIFJBl74f6JCCjWtlyQu6d5Xs/6kU3s1
         vSmb/FqwhuYglB4Y+921woUTgjGgnSSLg4I1RmxG5uFJMtd74VHUY3TBULU0WcE6T16S
         sqNblkoqQnafhyYIjGynWnwVv4z5725HnDN6h4QhoHsQLZT9uJEjLAKYo2xiJ6TahMPx
         ySOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731655796; x=1732260596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4C89xO91Qp04ruzBXQ8iOKApTYhEHlHgzGUbAr/+YWA=;
        b=KoeZtMZJXOYdiZSG+VQZnnQqi4bWDSDjWtEWrA3Nfrd9fHlMQBhBQvE1WPzdEjWwxF
         XnGm3bqMgnCJdF2zgHDLU+4bmfLxAeXksARV7awend5AofrKzh/YAToAVsI1CShBNU2+
         JKWp4geNFFUDq2eqkfaolPn+ZSeisZerJwANybEsYQNvJnNf136yrWxjeSf7YyQIouin
         OaujeFFEiZE/EogJy+3iL7w8DKsRQFvwx4qxXbKb3RM2k9Ct181iqCXPCmCSR7WbXzGA
         TE+DpTd1OE+SxDJusgt9ecCbwwFnDe5rhyVciM3bO2cd2Px2ku9Wgq3o2P+oqO3R7vU/
         Tg6g==
X-Forwarded-Encrypted: i=1; AJvYcCUOm9ymHSxDOMOwQaBfujmmuKhpcd+EUviSUUX3W3ASb/ZTTgQ7TucZP7j0zUxVxdqU+lxHCr9oibC3XEOE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6mx+zbQY8tsHScf7b1FqwUz1mnMOLU627M6NJ9aVqrYIdCrsk
	qPa//2i/xdG5grXbsGnHL/q4Z69qyRhNyaBU9Cfe47X5hf0oljTgnGFyHw2drz0=
X-Google-Smtp-Source: AGHT+IFkDNCjCVVG2zhGx6CoVl0K8SoMdNhuwuIX3WqcYHS2MOeo+v7OzJoTs9iDrJljGk2d92FhMA==
X-Received: by 2002:a05:651c:503:b0:2fb:357a:be41 with SMTP id 38308e7fff4ca-2ff6064e2b9mr7452151fa.5.1731655795774;
        Thu, 14 Nov 2024 23:29:55 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0ae3asm44317295e9.27.2024.11.14.23.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:29:54 -0800 (PST)
Date: Fri, 15 Nov 2024 08:29:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, tux@tuxedocomputers.com, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
Message-ID: <h5q36ajuzgwf5yrjmqv46x62evifcgoi5imxhcvsv7oxauvxak@sj54oisawqnf>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
 <2024111557-unlighted-giggle-0d86@gregkh>
 <6c1952bc-f58d-4c55-887e-6aa247daec5c@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w7sfc5s6xclpwoad"
Content-Disposition: inline
In-Reply-To: <6c1952bc-f58d-4c55-887e-6aa247daec5c@tuxedocomputers.com>


--w7sfc5s6xclpwoad
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
MIME-Version: 1.0

Hello Werner,

On Fri, Nov 15, 2024 at 07:09:49AM +0100, Werner Sembach wrote:
> Am 15.11.24 um 05:43 schrieb Greg KH:
> > On Thu, Nov 14, 2024 at 11:49:04AM +0100, Werner Sembach wrote:
> > > Am 14.11.24 um 11:31 schrieb Uwe Kleine-K=F6nig:
> > > > the kernel modules provided by Tuxedo on
> > > > https://gitlab.com/tuxedocomputers/development/packages/tuxedo-driv=
ers
> > > > are licensed under GPLv3 or later. This is incompatible with the
> > > > kernel's license and so makes it impossible for distributions and o=
ther
> > > > third parties to support these at least in pre-compiled form and so
> > > > limits user experience and the possibilities to work on mainlining =
these
> > > > drivers.
> > > >=20
> > > > This incompatibility is created on purpose to control the upstream
> > > > process. Seehttps://fosstodon.org/@kernellogger/113423314337991594 =
for
> > > > a nice summary of the situation and some further links about the is=
sue.
> > > >=20
> > > > Note that the pull request that fixed the MODULE_LICENSE invocation=
s to
> > > > stop claiming GPL(v2) compatibility was accepted and then immediate=
ly
> > > > reverted "for the time being until the legal stuff is sorted out"
> > > > (https://gitlab.com/tuxedocomputers/development/packages/tuxedo-dri=
vers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427).
> > > As already being implied by that commit message, this is sadly not an=
 issue
> > > that can be sorted out over night.
> > >=20
> > > We ended up in this situation as MODULE_LICENSE("GPL") on its own doe=
s not
> > > hint at GPL v2, if one is not aware of the license definition table i=
n the
> > > documentation.
> > That's why it is documented, to explain this very thing.  Please don't
> > suggest that documenting this is somehow not providing a hint.  That's
> > just not going to fly with any lawyer who reads any of this, sorry.
>=20
> You are right, that's why when I became aware of the situation this Monda=
y https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/=
commit/9db67459510f18084694c597ff1ea57ef1842f4e

We should differentiate two situations here: The one is from Monday
when you realised that a non-GPL2 compatible kernel module is unable to
use many functions. The other (and IMHO more relevant) is when GPLv3 was
chosen knowing it's incompatible with the kernel's license. I would
argue that you were aware of that since at least March this year
(https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/i=
ssues/137#note_1807179414).

And in my opinion
https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/co=
mmit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427
was a wrong reaction. I received this as a statement that your company's
goals are important enough to not adhere to the kernel's license and the
open source spirit. This was what triggered me to create the patch under
discussion.

> I got the gears to resolve this into moving (me playing devils advocate h=
ere
> is directly related to this https://lore.kernel.org/all/17276996-dcca-4ab=
5-a64f-0e76514c5dc7@tuxedocomputers.com/)
> and then returned on working on the code rewrite for upstream ( https://l=
ore.kernel.org/all/8847423c-22ec-4775-9119-de3e0ddb5204@tuxedocomputers.com/
> is directly related to that), because I'm a developer not a lawyer.

I agree that it's unlucky that MODULE_LICENSE("GPL") doesn't apply for
GPLv3. Not sure if it's sensible to deprecate "GPL" and mandate "GPL v2"
though.

> Then I get called a liar

I guess you mean me here saying "That statement isn't consistent with
you saying to pick GPLv3 as an explicitly incompatible license to
control the mainlining process. So you knew that it's legally at least
questionable to combine these licenses."? If so: I understand that this
is discomfortable suggestion. However with my current understanding it's
true. If this is a problem with my understanding, please point out where
I'm wrong.

> and hit with the nuclear option not even full 3 days later,

For now we're in the discussion period for this "option". I would expect
that this patch doesn't go in before 6.12. So 6.13-rc1 should be the
earliest broken ("enforcing") kernel which probably starts to affect
your users starting with 6.13 final. The actual decision if and when to
apply this patch isn't mine though. But you should have at least a few
weeks to work on resolving the licensing.

> while I'm working on resolving the issue

This is good. You have my support to revert the patch under discussion
as soon as this is resolved.

> and in parallel working on improving the code for it to be actually
> accepted by upstream.
>=20
> If you want prove of my blissful ignorance from just last week please tak=
e a
> look at my comment here: https://gitlab.com/tuxedocomputers/development/p=
ackages/tuxedo-drivers/-/merge_requests/21#note_2201702758

I indeed wondered about your reaction.

> Now trying to be constructive: Can you give me a timeframe to resolve the
> license issue before this is merged?

I would wish that in people's mind open source licensing would be taken
as serious as for example fiscal laws. If my company was caught as tax
evader the officials would rather shut down the company's operation than
to allow another month with unclean bookkeeping.

So if you ask for my opinion, the right thing to do would be to stop
distributing tuxedo-drivers until this is resolved. Then I'd guess it's
your company's officials who would tell you about a time frame. But I'm
aware that I'm on the strong side of the spectrum of possibilities here.

Best regards
Uwe

--w7sfc5s6xclpwoad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc2+GsACgkQj4D7WH0S
/k6yOAf/Zm9KYSYcJUTsDFoOFYQlhw2IKeDDqFXcXhvtZg9vAr8yHapB12XRe7HA
fx4biFFckYk4xmtpCuaHYwWOkM/j2h2S0+8nBSsFex9YO6XiynP4KZxfVwFZ0mDW
lzbTMpA22Y/bYJgp+IEksky2+g6Bx/YTr1vzrNfAbpjVM9jCz+siujHCbJHEwxs2
XOh4I0lWxHpo+nPzP7DRkmljmiKxPMTGscZoVYnly1jfJVPHRTe4XBrDUKlkYPmn
dW7EzPjrKa4qUAICSiiv03NelUB7a5TbOxp7rdVdA62/hnlf8r9iZmOlzgDnHzbi
9+OnVcrA+9s/ncwJk5l1+yoWZgKtsQ==
=/nDg
-----END PGP SIGNATURE-----

--w7sfc5s6xclpwoad--
