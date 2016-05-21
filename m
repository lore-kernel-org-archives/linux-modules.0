Return-Path: <ben@decadent.org.uk>
Message-ID: <1463857278.2613.7.camel@decadent.org.uk>
Subject: Re: [PATCH v2] libkmod: Add support for detached module signatures
From: Ben Hutchings <ben@decadent.org.uk>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, 820010@bugs.debian.org,
	Rusty Russell <rusty@rustcorp.com.au>
Date: Sat, 21 May 2016 20:01:18 +0100
In-Reply-To: <CAKi4VAKQecNsdVUXV0dR8_0GTKBirZq8NR7b32xMY+ar3Dn4Uw@mail.gmail.com>
References: <20160405001611.GJ21187@decadent.org.uk>
	 <20160405003237.GK21187@decadent.org.uk>
	 <CAKi4VAK64gR8U2n6=fO8o9Y1m7bTJsmeDLQcpegjF+57=_e8VA@mail.gmail.com>
	 <1460541612.2705.32.camel@decadent.org.uk>
	 <CAKi4VAKQecNsdVUXV0dR8_0GTKBirZq8NR7b32xMY+ar3Dn4Uw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Q0fqFbJigc7MqPq5BRVB"
Mime-Version: 1.0
List-ID: <linux-modules.vger.kernel.org>


--=-Q0fqFbJigc7MqPq5BRVB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2016-05-21 at 15:31 -0300, Lucas De Marchi wrote:
> On Wed, Apr 13, 2016 at 7:00 AM, Ben Hutchings <ben@decadent.org.uk> wrot=
e:
> >=20
> > On Wed, 2016-04-13 at 01:05 -0300, Lucas De Marchi wrote:
> > >=20
> > > Hi,
> > >=20
> > > CC'ing Rusty
> > >=20
> > > On Mon, Apr 4, 2016 at 9:32 PM, Ben Hutchings  wrote:
> > > >=20
> > > >=20
> > > > Debian will not sign modules during the kernel package build, as th=
is
> > > > conflicts with the goal of reproducible builds.=C2=A0=C2=A0Instead,=
 we will
> > > > generate detached signatures offline and include them in a second
> > > > package.
> > > Is this a decision already? It doesn't look as a good reason - you
> > > would already need to provide a signing key (CONFIG_MODULE_SIG_KEY)
> > > anyway for this to work. How is leaving the module signature in
> > > another package be any better than just signing the module?=C2=A0=C2=
=A0If you
> > > have the signature, the build is just as reproducible as before.
> > I think we may have different ideas about what reproducibility means.
> > When I say reproducible I mean *anyone* with the right tools installed
> > can reproduce the binary packages (.deb) from the source package (.dsc
> > and tarballs).
> >=20
> > The signing key obviously isn't available to everyone, so the source
> > package has to include detached signatures prepared outside of the
> And how is this signature prepared?=C2=A0=C2=A0Since it needs the compile=
d
> module it would be a matter of changing the compiler, even minor
> version, to invalidate the argument of reproducible build. It seems
> very fragile to me.

The versions of build tools have to be recorded:
https://reproducible-builds.org/docs/formal-definition/
https://wiki.debian.org/ReproducibleBuilds/BuildinfoSpecification

> > package build process.=C2=A0=C2=A0But we can't put them in the linux so=
urce
> > package, because that results in a dependency loop.
> >=20
> > >=20
> > > >=20
> > > >=20
> > > > We could attach the signatures when building this second package or=
 at
> > > > installation time, but that leads to duplication of all modules,
> > > > either in the archive or on users' systems.
> > > >=20
> > > > To avoid this, add support to libkmod for concatenating modules wit=
h
> > > > detached signatures (files with the '.sig' extension) at load time.
> > > this has the drawback that finit_module() can't be used.
> > So does module compression, but it's still a supported option.
> This is easily fixed by teaching the kernel to handle the fd as a
> compressed file.

This sounds speculative.

> The kernel already has the routines to uncompress
> them anyway. Supporting detached signatures means it can't be fixed
> anymore since we will have to use init_module() rather than
> finit_module().

Why does that matter? =C2=A0init_module() isn't deprecated.

Ben.

--=20
Ben Hutchings
Experience is what causes a person to make new mistakes instead of old ones=
.
--=-Q0fqFbJigc7MqPq5BRVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXQLB+AAoJEOe/yOyVhhEJHO4P/ifRJPrnbSBQgtLJvjUGd822
v6vfNqlemJl0S5i0gVtKxCcNCO0+sw66Bflo4Gldhm1Pgba+CNvmD/+8DxVEs5ZZ
8+TyYsFDCDgngGGeZaOBcC5fV09H5LFcpcMZchjrKGFuK4DRxG2e5yYf4RZS0qmU
89ixXDsQ3JpFeDtYiAYUL1Fi6lPGsa2OIpvcGVmrXtTkBVbhGw1mEEk+OhW6rWR3
SGwtV9ojReUkdZ5b2gzrAVA/jDy7Xc2jsdpWWRWyV05/B9to2pjAyDw2PtomraVw
LBx1SAt1kwQVrVoSHZ2rYrMrQkhe/7bpJtZV2QvNVIfG8xTU3HY5+LYZTJPoO3PR
FIv7HJ3xMZf1pDHWA7NGWSaHssS8WpcVBETZPIRlwLfSlhuixcH/FMLY6QHv4bCI
wTPukzQSqJDYRhETqPlh/yNn3/tBF8ernI/nE2mBS0rKKvH9MNLiZJk0Fhg+dJu3
Q7m/mDOiXzKX02ToaY8kwgdhpWxv86KURYhtpIzyvnQK6n8F0KFB2RNwbmA0BrYh
RZhhXLaZxw9fhEgYKtjK7kgy2FGKOIYPmLDtmyaxMKVU0ZFsHexAj5ayGU7bk0Vx
xDJruE4948XNVSUqpv89VMkWB8YQB1SajBMVnGqdt1W/uJi0bi8pxA1rqH3uFBjY
wKymh0qGEQDXgHB8s8KO
=itr3
-----END PGP SIGNATURE-----

--=-Q0fqFbJigc7MqPq5BRVB--
