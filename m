Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A226AA7;
	Sun, 20 Oct 2024 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729421996; cv=none; b=Q6R4ukWvhzK+BZqoK4gNIutkrjv4FUx5cKmn+Si2uBoCqB0LougbGKHPva57NawRU96s9R5h29GSBo+a6QCm+kHifHDTAvrANxvpWk9zRUKBR0H7dliXGxcGU6eIUKADyV3p/XR8BO+HdnvjGbhZCek+Kzlc/LIsA7TjAKOabSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729421996; c=relaxed/simple;
	bh=Ez26bh9tHqqLY9ulMFyogGa+HW8UWLMV0dvVM/teQn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpslRfuDhJaS+lRVTHxOV8+e4byaF0buNhRpRH1Pk0WkHxAxFRD4OYDwhHFJ0MkAgAy94iFHKVirqP4E6e0dE5A3NmOGDFFBB5HaFr8eW/2oLlOnONX+btuZUzIL5aoIlPNUchdyPZaaDSPaxRLVHErR7Vg02h970vwVT+9t4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=aQIB2dc1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aQIB2dc1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1729421991;
	bh=JHJRLpA94qHX4kOBpUBcRZMD8go6QvdIkInPmeCI0cA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aQIB2dc1iIgjdYuWHboBJZUj/SS4OR6dnMs90yiLZZjRhX+dHhOj4k0kME6p0KM2G
	 8jbVaMLKQkn3Ic/OJQ7pLhtodI3hi5Q/qPepY4bF5KZZk/uzjV+wN0zgOi0/QO63iJ
	 j8JkDONSRTI2nP4LWXakPoZlW3Vt8Ido9N5AKAvsi8aznOBtY1sqwwCLrV6UKIjqZB
	 SURH41b3Vuvy6mORo79PC4sU3zOt78p9m5ui1985koZOXxbS0Ah2FygUr/3uB/wRIu
	 DLdqN911DMsI6Ek4j5RxqOLOX3IVG7eYY3jbO7au5W+CmRufZfCrpKmA3F6z0vaQWX
	 VLoKgpWq0+HeQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XWb7B2gg4z4wbp;
	Sun, 20 Oct 2024 21:59:50 +1100 (AEDT)
Date: Sun, 20 Oct 2024 21:59:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] next: use new shared modules tree
Message-ID: <20241020215949.41324ccf@canb.auug.org.au>
In-Reply-To: <20241019212100.940549-1-mcgrof@kernel.org>
References: <20241019212100.940549-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PhAISm9YWCJwAcCr+AyPPiN";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/PhAISm9YWCJwAcCr+AyPPiN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 19 Oct 2024 14:21:00 -0700 Luis Chamberlain <mcgrof@kernel.org> wro=
te:
>
> Use the new shared modules tree as we have more than one
> modules maintainer now.
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  Next/Trees | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Next/Trees b/Next/Trees
> index 38812059087c..585cddaf8746 100644
> --- a/Next/Trees
> +++ b/Next/Trees
> @@ -252,7 +252,7 @@ regmap		git	git://git.kernel.org/pub/scm/linux/kernel=
/git/broonie/regmap.git#for
>  sound		git	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git=
#for-next
>  ieee1394	git	https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/li=
nux1394.git#for-next
>  sound-asoc	git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sou=
nd.git#for-next
> -modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.=
git#modules-next
> +modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux=
.git#modules-next
>  input		git	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git#=
next
>  block		git	git://git.kernel.dk/linux-block.git#for-next
>  device-mapper	git	git://git.kernel.org/pub/scm/linux/kernel/git/device-m=
apper/linux-dm.git#for-next

Done

Currently only you, Luis, are listed as a contact.  Should I add anyone els=
e?
--=20
Cheers,
Stephen Rothwell

--Sig_/PhAISm9YWCJwAcCr+AyPPiN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcU4qUACgkQAVBC80lX
0GwZlwf/bfIjAodugw9q1IlkhZ7IeCx7e373lSUlg/hR+ZXQdjuWC6q9Q/yIBp0F
vK6UTCt+JHfoM+j2zReZ6OmbFWPU6G7ju0rTGna9WzUFKs05sZr9Fh7S6GAbudEW
gmZFLFYK+7hWdQKr6JOTEPkHoe/QF6btE6NGorc3S5zphUPu+SKsm6bDd3mV11KW
whtPk9mB5wOLFozyYQ3QWpgLmW2/qq10/Jr4+nJB8J+zZzb+ZEjEMtcB6EgydDlQ
UisJJJSM31t4RLgI3GWHNt7sJxvlaV/NwwDZFVGEuEBmFq+J+B0DcD95/vULAoOL
smbGoO+bYg13f6YT9J23p+n6cI9X0g==
=aHjy
-----END PGP SIGNATURE-----

--Sig_/PhAISm9YWCJwAcCr+AyPPiN--
