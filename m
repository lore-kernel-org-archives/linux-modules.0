Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from attila.bofh.it ([85.94.204.146]:52802 "EHLO attila.bofh.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753319AbcCBQLC (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 2 Mar 2016 11:11:02 -0500
Date: Wed, 2 Mar 2016 16:55:51 +0100
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH] modprobe: install default configuration
Message-ID: <20160302155551.GA31679@bongo.bofh.it>
References: <1456931893-13545-1-git-send-email-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <1456931893-13545-1-git-send-email-lkundrak@v3.sk>
From: md@Linux.IT (Marco d'Itri)
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 02, Lubomir Rintel <lkundrak@v3.sk> wrote:

> The kernel maintainers seem opposed to fixing this in kernel (despite a s=
imilar
> thing has been done with loop block devices) [1]. Let's fix this my overr=
iding the
> defaults from userspace.
Because, guess what? This breaks userspace.
Feel free to configure your system this way if it is what you want.

--=20
ciao,
Marco

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAABCAAGBQJW1w0HAAoJECv1pcEixPek/aQMALzS1tjiJ2aYCKxhnDoDkHqM
rLZEEGK/kwVhlYvD5QLkUcK4n6FSGssUQwaHhiz10EYmUTTyaNXLL3gw6AOjVl0T
qYyRO2Uw1j8uJxtwBZrqfE93UInKzBtyLLY4J4qrNHR30v1OHbj8c06Zh6IcRAXw
8TL3LI+AGnkuv+x9ZtD91YXlSenxs9EjeAXsriG8vjXNVxYWbp5/ZgQ+w93LEnAC
QfGVFgrMg2zdOMr1VjQ9EuFbihSz9pNeOlmKbWSAIlWQj7L0FqOhKhbN4HVVKnQs
u/LbT8u/b+18fclmJMfAhZPafq67sMAPYVAE2qpAx6Jr3XxBtCqV6H+UFAQ8176c
XQFGF5NxEbGKXbc7JKkEXBIhe2Xj9f1hFiRs567R5O7E0m/fwLZf+c7z/NvmrARd
M2Wk8BuvY7tW8aFJa5FOgBgGfNtZiCPruU+VoOPLAAgeAKNWCUbXHZVdBjOLvbuN
Ajk3cmW4WLUYgIhnkNl0wsNI0qB0q9MT3+BULGnibA==
=YlCq
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
