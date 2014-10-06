Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:54121 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbaJFGjK (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 6 Oct 2014 02:39:10 -0400
Message-ID: <54323906.1050808@web.de>
Date: Mon, 06 Oct 2014 08:39:02 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
To: linux-modules@vger.kernel.org
CC: Hans de Goede <hdegoede@redhat.com>
Subject: [solved] Re: uas module not loaded automatically
References: <54303DF6.4050203@web.de> <54310A74.3090404@redhat.com> <54310C04.5060008@web.de> <54310DF9.8070904@redhat.com> <54310FFF.10504@web.de> <543112A6.8070503@redhat.com> <543113FF.7050900@web.de> <54311549.4070808@redhat.com> <5431258D.3020904@web.de>
In-Reply-To: <5431258D.3020904@web.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4b99R5gq0uNT6QTSrqhGdOJ3TAw74FGIa"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4b99R5gq0uNT6QTSrqhGdOJ3TAw74FGIa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2014-10-05 13:03, Jan Kiszka wrote:
> Hi all,
>=20
> I'm migrating this conversation over from LKML as it is probably a kmod=

> issue. I've just retried the scenario with kmod 18 (from OpenSUSE
> Factory) and can still confirm it. Please see below for details.

Mystery solved:

/etc/modprobe.d/50-blacklist.conf:
# uas has been confirmed to be hopelessly broken
# Bug bnc#770301
blacklist uas

I'll check with my distro if this is gone in their next release when
they switch to a UAS-enabled kernel. The official kernel for their
current release still has it disabled, the problem only occurred when
moving to a newer kernel.

Jan


--4b99R5gq0uNT6QTSrqhGdOJ3TAw74FGIa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlQyOQoACgkQitSsb3rl5xSuGQCg4Hy3KdocfU9bxJGUT5n+R5go
gAcAnjsJYKflpsI5sA9hf8lcshaWFP2C
=sU5C
-----END PGP SIGNATURE-----

--4b99R5gq0uNT6QTSrqhGdOJ3TAw74FGIa--
