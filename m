Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A24197A81;
	Sun, 20 Oct 2024 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729456764; cv=none; b=AG4NDLCAVuQ/qWxmSDxJO/YT3gIkq+bst7+he+lQgSfrqfjBtUzjsSLQmNzeEAj7mxatJHg28nmB/apOc6F9xOT0HHWP9SVj8lAlKCDC/QdYUTVKg47bMhEyR32y/Yzl992Frn+ZxPXUl11LR/xhadWLBFA4MEWlTCY+5vl0wtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729456764; c=relaxed/simple;
	bh=5TQHYQ6Afx6n89aKi3GjfRs8mppeAlFI9hCXm9fei+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6BDdHUkoTSUi1BjhrzBtZ5RFpDab3bDRTPa6VV4Vi9etN1japJfna6GZjNg79JihbHwPnYIwO6A7JDW4X1Beo6P1wGNLk+YrNlUe0YR0ZhrU3Wmiy7qOd4fV0Zxx8GzM936vp/x+iT0Dnf6k5Y0eVAwQ2wJoYrfgtC/nBhDF+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iDhNDm24; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iDhNDm24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1729456758;
	bh=5TQHYQ6Afx6n89aKi3GjfRs8mppeAlFI9hCXm9fei+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iDhNDm24+GBkvq9XmNkTfGako6t2N2UTUovuCy6S9gN7GrkQ/gI7d2L5Lh0d9PvKC
	 pZMRfSIt9VI84c8ANGHw6uRH/e5BBSatV7ld+NYP41mKrGQKI7Tr7dUTA5iGVGroyh
	 mHJL0KEDGDkWSLHKT40gWA12uHeZipJ0r+WNM96hy2r2kcOzQOOdHqtVzmskaKaaEB
	 7sADqUFGuCtlAd9EzKcaZiVOAcUoqRrQ7xzrOjCVJNkizjqJX/paoYY76vQvPtOwsv
	 V5IyXWfVSvvnxgZ/P20ER+bNsMRo0JjL6AcJRzC+VcYtPvE+Fqur8oykLaocg0WczY
	 RG3eDN+9Nnm/w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XWqzp39n3z4wbv;
	Mon, 21 Oct 2024 07:39:18 +1100 (AEDT)
Date: Mon, 21 Oct 2024 07:39:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] next: use new shared modules tree
Message-ID: <20241021073918.7b7071d6@canb.auug.org.au>
In-Reply-To: <ZxU9tMF7SPNfPYok@bombadil.infradead.org>
References: <20241019212100.940549-1-mcgrof@kernel.org>
	<20241020215949.41324ccf@canb.auug.org.au>
	<ZxU9tMF7SPNfPYok@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KdnhONMyGwiVMw+qh=giEf9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/KdnhONMyGwiVMw+qh=giEf9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Sun, 20 Oct 2024 10:28:20 -0700 Luis Chamberlain <mcgrof@kernel.org> wro=
te:
>
> Yes please add: petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@sa=
msung.com

Done.

--=20
Cheers,
Stephen Rothwell

--Sig_/KdnhONMyGwiVMw+qh=giEf9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcVanYACgkQAVBC80lX
0GzOnwf+KaJraH8PQ8iqVlt0OI1G7PpxhMBqjowpwq13wKSSrCYlqVJMXQ/qp7jC
ze0MQXW3nW2XtJAAFq0j7Fr7CnPUJhRoyBj7c0ZOmShBHBilCZwJEpS00rRhUD5J
7rYMKih2/8dtXdJBps4yM4nVQsFKwHvRKdiqocnjlzseQ0BrphnoUBqgi0/cRFtN
Nln+NSOc2+/cjuaQcENxkRq5JLsp79Wqq6FXDRbPVxHwj/DvaVQ7KRPvp7QkVb3h
r3H7kaml3Ei0w+Uwx6jgzcCL8Sa1ThGh1o/REGiIVpIY1LFcI3hZr26BNR860ORu
768XsYQF15r/gM1xvJdidyzdouig5g==
=KS72
-----END PGP SIGNATURE-----

--Sig_/KdnhONMyGwiVMw+qh=giEf9--
