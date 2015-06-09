Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from attila.bofh.it ([85.94.204.146]:51808 "EHLO attila.bofh.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791AbbFIHvx (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Tue, 9 Jun 2015 03:51:53 -0400
Date: Tue, 9 Jun 2015 09:34:29 +0200
To: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [ANNOUNCE] kmod 21
Message-ID: <20150609073429.GA9053@bongo.bofh.it>
References: <CAKi4VAKaZPtGvT9gwTOmoTG8mpnn05ybSSeNde8VPOcczLuChg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
In-Reply-To: <CAKi4VAKaZPtGvT9gwTOmoTG8mpnn05ybSSeNde8VPOcczLuChg@mail.gmail.com>
From: md@Linux.IT (Marco d'Itri)
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 09, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

>         - kmod tool started to learn the "insert" and "remove" commands t=
hat
>           are the simplified versions of the older modprobe tool.  These
>           commands are still work in progress so they are hidden behind a
>           --enable-experimental flag during build.  It should not be enab=
led
>           unless you know what you're doing.
Should I enable it in Debian testing/unstable or do you see this as=20
strictly developers-only?

--=20
ciao,
Marco

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAABCAAGBQJVdpcFAAoJECv1pcEixPek++UL/RIGIvHzW+XYliVJCGIUObrc
v3v90uSd/1aT3Dj8h6pxXqJYOWqhszhNeqQ/X+z4fSfqAaDyqPDUZK4/1MbLbJJp
rZtTqiUqEaZ1NM6ARWLdBSBq26f3oUX0Rk44KBz+2iC/Vx0i2K2nSCt2JTcKsSo2
wcvtDD8QvV8CVAvOFFkeRxuksKR/STrhr1xxsLStCga6126KdCJ/lnySNDx4gVWw
4B8ajEeyUkREu65GqotdJd9qVbLCOKWf0T9AvjYpEZPdWz2z+4HDMvCkOAKrmkmg
JzdJThWQLvjC/GKapN3VsZoU8VEtKhF5BM0k6uT89HOnS/ARFffalECf36AtiZS7
KN/5o0dLY10/zh4lGiD9zA0e35Kw+FFLETCs4j/L41p1qE/1NxtBqMDTosSoIc5+
rz1DBzvSt0YDdJuuyoMV5D5oNmiEn5FOHAGKm7VcAvUtmHf+4f1RqOHrba2+nOwe
CrIj/l0qEUpYlqhszPHYUeUg+X+UAwhQGpBeNwM0eQ==
=04l3
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
