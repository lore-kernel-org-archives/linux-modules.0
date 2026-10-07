Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1795B206;
	Wed,  7 Oct 2026 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791361518; cv=none; b=Qz6wEHB8qHMVaFRhxLSv2vhgl5mCqtPD+07TYFlROYxtfN6CqkZSJxNBFdFHbXHGdPcTLt4ME8nFm1XaMMRvyCsFr9f3PJqseY8sXW7jNlQ4KwEDDiDWUSlojTQUs2JurIno5db9R6hLfkQB/riaktk0S3nria0A8Xp4R6yLduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791361518; c=relaxed/simple;
	bh=R8sKPXcXCIG0QtL7Z2Bnv+mo8sKczf8TconfNYIaZV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJswQx29VFUUDQpLJggNKd/lFIJEbPSqlGXQ5YS6tw4CwuV2sYmbk85opm9MmpUncxV5ISt1HHrijlQgsrOXUPS5edHzXcsRdCRDHrM7tM0qhd+fLadryTvDt+jAL/HnczCd4TQVVs9/d2tFx5U9WsirwcUwajYEq2D1uwiTRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM9wvGug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM9wvGug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F891F0089B;
	Wed,  7 Oct 2026 08:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791361517;
	bh=AV4b7TDs1QryDsNnBsMpSOE1EhNt5PGbHrDuxEwaO6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cM9wvGugpSdaZ5yqOKIpgSEImCOyhgX/aqN0dRZZwYkqtXanohguE7EG4YMPqofBX
	 wDUmc9VG72VFs7i7xER+GCnio/TN2f62vDeUQAwpYm87chX+UMTzine/AFMyMx5rtF
	 vwkFLptmcPwTFyTbJnfRyRMIwz/LMFNDQhoOuqgU/+K+k3RMRquU9cE6SwDsjFr/FR
	 SuuNR9JmnaW/nVR2qR1UH8b+WccXxEGZvbSIhs7s932CtgeOBA2bHTRZOjZC9UrSuG
	 gkRicdv6u4k629MTLyYiA+mf568KIPGeLat/nT17KlcB2av7qoLNMFHxjQStOM2CDu
	 4DcoFUp86da1g==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 41C82186248E; Wed, 07 Oct 2026 09:25:14 +0100 (BST)
Date: Wed, 7 Oct 2026 10:25:14 +0200
From: Mark Brown <broonie@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org, jpoimboe@kernel.org,
	nathan@kernel.org, nsc@kernel.org, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	atomlin@atomlin.com, ndesaulniers@google.com, mark.rutland@arm.com,
	will@kernel.org, catalin.marinas@arm.com, ardb@kernel.org,
	Emanuele.Rocca@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/3]  kbuild: modules: Fixup arm64 BTI relocations
Message-ID: <asYB6uwzbNTGv2Td@sirena.org.uk>
References: <20261006221815.2823252-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VDG7eEdWMOyvQRMd"
Content-Disposition: inline
In-Reply-To: <20261006221815.2823252-1-jeremy.linton@arm.com>
X-Cookie: Use the Force, Luke.


--VDG7eEdWMOyvQRMd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2026 at 05:18:12PM -0500, Jeremy Linton wrote:
> The kernel module loader, the arm64 ABI, GCC/Clang, and the static
> linkers operate with slightly different assumptions about which
> functions require BTI landing pads.

Ard has a series which resolves this in the kernel's module loader:

   https://lore.kernel.org/r/20261005110511.157016-4-ardb+git@google.com


--VDG7eEdWMOyvQRMd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrGAeMACgkQJNaLcl1U
h9Dtogf/YeJAfcWSiZMI18mNhDCluml9tNwRZyaPkGqGdZCujAmo2HpwPGHBAPAW
SNs0juN9tLR2gBo1ZAspzv9k4/Lq2jIjpEisTo/A9Nht6ZPu3ZWExOhxbwgEYt1O
QARJYk0lnSzJSZpys5PKXgfj77xTdaWsgRoExp/YL9+Mg5ORQuf0DJSUR9gUxRnX
FZCCZT8CF3AqbsL7xb6eJnmnc6auqEIEFtP1U5m2+LP5fuEu3lcbmNNIcM5BXwoo
aJuRBaomHnj9o8OfIKFuaNkU5ILBhYkB1Q627Jm/pVojaSEozyoPadZRfvxQAl6Q
/TW1oq1yrf0NpN8S9Fqa+kOGIexbZQ==
=Kq5m
-----END PGP SIGNATURE-----

--VDG7eEdWMOyvQRMd--
