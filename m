Return-Path: <md@linux.it>
Date: Sat, 21 May 2016 20:40:04 +0200
To: Lucas De Marchi <lucas.de.marchi@gmail.com>, 820010@bugs.debian.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	linux-modules <linux-modules@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Bug#820010: [PATCH v2] libkmod: Add support for detached module
 signatures
Message-ID: <20160521184004.GA32133@bongo.bofh.it>
References: <20160405001611.GJ21187@decadent.org.uk>
 <20160405003237.GK21187@decadent.org.uk>
 <CAKi4VAK64gR8U2n6=fO8o9Y1m7bTJsmeDLQcpegjF+57=_e8VA@mail.gmail.com>
 <1460541612.2705.32.camel@decadent.org.uk>
 <CAKi4VAKQecNsdVUXV0dR8_0GTKBirZq8NR7b32xMY+ar3Dn4Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
In-Reply-To: <CAKi4VAKQecNsdVUXV0dR8_0GTKBirZq8NR7b32xMY+ar3Dn4Uw@mail.gmail.com>
From: md@Linux.IT (Marco d'Itri)
List-ID: <linux-modules.vger.kernel.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 21, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

> And how is this signature prepared?  Since it needs the compiled
> module it would be a matter of changing the compiler, even minor
> version, to invalidate the argument of reproducible build. It seems
> very fragile to me.
But this is the whole point of reproducible builds: knowing that if you=20
start from the same sources and build enviroment, and distributions do,=20
then you will get the same results.
Building gcc is reproducibile as well...
Reproducibility with a different compiler has never been a goal.

--=20
ciao,
Marco

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAABCAAGBQJXQKuDAAoJECv1pcEixPekcPEL/A3V/R4p01gKl0ajMocvHRfd
eDxyRgqWjFXE56a1duj0VgsUIfG0PRAAN84b5enljUyTY+eunpGLdALxa7L1DDnN
zpnB5ZGPgrRV1GnMc7XJTlHTdHmF4wR9m0lmCMOZOIf7O6hsvmLr5bvwk3XHXYJw
7s1afC46zsTbvPzEKqJT4GYz233cin4K0mISqsYbgXJTMIQjlV53iqGhAxHGxO61
8eJMWZlmJHAUfRT+5hm8CvwN4tY0q7Mn5S5I2TdpJ0wcnI8J+9XzTQTN2VcYGbo0
viQlCcPYPFnk/47xsltY7MS2NNx+HumiMV4Czx/7+WyKnsf7A18dGNEm7m1I5wJ+
GtKhHnvuNFGFH+dUlY86r37eH6Q2jPaALrjciNTBtUYti/lrkVxDHY3nh8qe9GoO
6ZoJ7fdjvYHW7PMnvDA/Pn0t6YQxN6VIqiUWhp90fuC7EXpN+PXcniZr/HVgKMDs
M9YHyVbGOQpyiiWX+N34BSig7des3erPla+JO02SYg==
=/q0y
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
