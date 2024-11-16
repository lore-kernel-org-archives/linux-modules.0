Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD854B666;
	Sat, 16 Nov 2024 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731779400; cv=none; b=dq/tuu88xrU1U4DaGAobjui6behNX9b+oseg5XtNzHcMF02XffkydTArA9ClAhnHKvN2knnHyG2xhddCj+mpBrIRE43LjmK8+ogMCiGfxcfCwsz0Ahrh8x9aWAZjx3kOzmwZsR1G3QpEoMFr+eTDemlWk/G5yCFEyNbHwNo6Oww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731779400; c=relaxed/simple;
	bh=6omQLfyrdzywIDGTsKilpGsb6tCdhV5CflukTwmNgVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rc/L7iHJwEutyzovoxPCC0Kl9XMnbgIIGtNHATCSxdTfN/dUvob13SUkMtmVDh9NyMg4udT7DMOB85+kNbTduMUMcl4ecUKM/aowJBrJpjwYj7jfzj5LAmwzvqGp+YfPG8smG6jfTW95c0+VdwRJYqU5hfJnghDYUJG9cH8W/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5gXCT8E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5gXCT8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E3FC4CEC3;
	Sat, 16 Nov 2024 17:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731779399;
	bh=6omQLfyrdzywIDGTsKilpGsb6tCdhV5CflukTwmNgVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5gXCT8E1q1Cnk3WHXKpw6kKLZJApGSAdSYiagjvPD1a4G+/meuSEUIGFJm05KfAK
	 Hxlfhv70dgOrByUFWaS+uqz5w7O4McVAecoXCi0RWBXn9ac4HWk/CgO7XxvE/XmuX3
	 HMGL8pYLZnh77Y3rte6rzfIZIe08qYLg0WnpoTOOkdPR2mZriYEj+Ovn8/5Kv9MFeU
	 2YRWowGMygtQcYs25V96l1uOevypjv5mHh+Zz/xD/H8BcmlJ0CSGZ4F1GjLXbE4B/W
	 keVHdEQvv+TbD9dp2vVEZ1TNoYtSGpMvakr5VM6LtiNyiKOmj8N0DjZDUsHJ55O5z9
	 r5xfXZ3sd4V0Q==
Date: Sat, 16 Nov 2024 18:49:56 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, tux@tuxedocomputers.com, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
Message-ID: <ozjiojcjmdjppmtardffvrqkuksnexyhfttzbyandihzhg6n3t@ssscyybngobw>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
 <e7d97b3d-1880-4c89-bbf2-a742d6ac9e6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z4gm4udsgcwtxml7"
Content-Disposition: inline
In-Reply-To: <e7d97b3d-1880-4c89-bbf2-a742d6ac9e6b@kernel.org>


--z4gm4udsgcwtxml7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
MIME-Version: 1.0

Hello,

On Thu, Nov 14, 2024 at 12:14:16PM +0100, Uwe Kleine-K=F6nig wrote:
> On 11/14/24 11:49, Werner Sembach wrote:
> > Am 14.11.24 um 11:31 schrieb Uwe Kleine-K=F6nig:
> > > the kernel modules provided by Tuxedo on
> > > https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers
> > > are licensed under GPLv3 or later. This is incompatible with the
> > > kernel's license and so makes it impossible for distributions and oth=
er
> > > third parties to support these at least in pre-compiled form and so
> > > limits user experience and the possibilities to work on mainlining th=
ese
> > > drivers.
> > >=20
> > > This incompatibility is created on purpose to control the upstream
> > > process. See https://fosstodon.org/@kernellogger/113423314337991594 f=
or
> > > a nice summary of the situation and some further links about the issu=
e.
> > >=20
> > > Note that the pull request that fixed the MODULE_LICENSE invocations =
to
> > > stop claiming GPL(v2) compatibility was accepted and then immediately
> > > reverted "for the time being until the legal stuff is sorted out"
> > > (https://gitlab.com/tuxedocomputers/development/packages/tuxedo-
> > > drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427).
> >=20
> > As already being implied by that commit message, this is sadly not an
> > issue that can be sorted out over night.
> >=20
> > We ended up in this situation as MODULE_LICENSE("GPL") on its own does
> > not hint at GPL v2, if one is not aware of the license definition table
> > in the documentation.
>=20
> That statement isn't consistent with you saying to pick GPLv3 as an
> explicitly incompatible license to control the mainlining process. So you
> knew that it's legally at least questionable to combine these licenses.

When I wrote this mail I missed the possibility that while Werner knew
GPLv3 isn't ok for in-kernel code might still have considered GPLv3 ok
for external modules anyhow.=20

So I take back what I said and excuse me for my words. They were not
intended as harsh as Werner obviously took them, but still I regret
having written my reply with this suggestion.

I'm sorry,
Uwe

--z4gm4udsgcwtxml7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc420IACgkQj4D7WH0S
/k6L8Af/Yrhl+2KEFVEyXCZhK5T2bGM3MLav7R0yMc3ZVsZyuR6spJY5g7bpBPqS
Q94n0qrm7Bk/J/RnC6fULy+TvFGwQDrqE5NSzImB2LSu+y6K2g1VprpFgOnQ3Tgl
qfLnCoHELuoUrgB2yJlHlowvnZspd9Qcz4qUzPBA5X7MtA5Uqn9dBK47LB0eGg2h
bnlseBKig59XKGWyi0WALZAsxXPqcSjpxPWpfrdebk1M5UqRim8TTEaKhekCLjUB
o/2v+yhDJwLEZZxNVMZHqOqK5JyFPnoWVLiw5kEwdcmkbw73C5kQehSkvO52hiHO
4vHBnmcMis4TV7sDfZsfrPXBA07mCw==
=zoHt
-----END PGP SIGNATURE-----

--z4gm4udsgcwtxml7--
