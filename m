Return-Path: <md@linux.it>
Date: Thu, 4 Jun 2015 04:51:39 +0200
From: Marco d'Itri <md@linux.it>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Andreas Mohr <andi@lisas.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bertrand Jacquin <beber@meleeweb.net>,
	linux-modules <linux-modules@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH] modules: CONFIG_MODULE_COMPRESS: add hint that userspace
 support may easily be missing.
Message-ID: <20150604025138.GA1004@bongo.bofh.it>
References: <20150531152932.GA16337@rhlx01.hs-esslingen.de>
 <87r3pwgd0b.fsf@rustcorp.com.au>
 <CAKi4VAJfhM0UMOmFkQ40RW5gJGKch8AH8QEvuiYtj93O+YTNwA@mail.gmail.com>
 <87h9qouuny.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
In-Reply-To: <87h9qouuny.fsf@rustcorp.com.au>
List-ID: <linux-modules.vger.kernel.org>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 04, Rusty Russell <rusty@rustcorp.com.au> wrote:

> But disappointing that Debian doesn't configure with it, and there's no
> easy way to check it.  Looks like Ubuntu vivid is the same.
>=20
> Might be time to change the default in kmod?
Changing the default will not make me enable compression support,=20
but providing interesting use cases maybe will.

Also, I see no point in enabling support for both gz and xz in kmod.

--=20
ciao,
Marco

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAABCAAGBQJVb706AAoJECv1pcEixPekJvAL/0nlhhlria5Nj4maa55/wbsc
QWwcoV83cNfwf2N910TpreknbmwqazMMTQm65leFaW5eAlmxrorIGDxgqkTWfaKy
Pi0yUsAyha/2sbfSLfl4J+En14KbKwkWDqRpMxhWaXz0STsLhYu7PonCOvhZZGr5
sKWXBEsPPoUOs3KDxbs3EQJCizPxUpj9+SHFkR1H0Ie0uiwZ4I5ViOPHBEKb8oeh
gvoTwThz/+idOSL258tSyiiZcwjchTDpyQDwGik9hnP6D1fp6UPPQCxasd6tyWUV
36Srgj5PzcpTZTnzF1gP1omnzNc3e26sbSdVlqsW9U+kVzyU7ouHIP0dP8a6rSGc
Qx5rjfannhT2zl7vOZL6MPKMIgrfM4fYYXlEY+W44qVguLjRwg1jyzvnlrmNfAZY
mp/Ox+6+/URJrr9mcAywRJ+64+t86hEqtoL3fXWwlq7bpFj0nU1jAuvERx1ZeUge
MOrPGFq3+PTsRiuZnywNL4Iw6QeeWOepwrRTCWxAQQ==
=/03z
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
