Return-Path: <ben@decadent.org.uk>
Message-ID: <1463489490.8490.12.camel@decadent.org.uk>
Subject: Re: [PATCH v2] libkmod: Add support for detached module signatures
From: Ben Hutchings <ben@decadent.org.uk>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, 820010@bugs.debian.org,
	Rusty Russell <rusty@rustcorp.com.au>
Date: Tue, 17 May 2016 13:51:30 +0100
In-Reply-To: <1460541612.2705.32.camel@decadent.org.uk>
References: <20160405001611.GJ21187@decadent.org.uk>
	 <20160405003237.GK21187@decadent.org.uk>
	 <CAKi4VAK64gR8U2n6=fO8o9Y1m7bTJsmeDLQcpegjF+57=_e8VA@mail.gmail.com>
	 <1460541612.2705.32.camel@decadent.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-VIfn7drj+X5M/ImdsxKN"
Mime-Version: 1.0
List-ID: <linux-modules.vger.kernel.org>


--=-VIfn7drj+X5M/ImdsxKN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2016-04-13 at 11:00 +0100, Ben Hutchings wrote:
> On Wed, 2016-04-13 at 01:05 -0300, Lucas De Marchi wrote:
> >=20
> > Hi,
> >=20
> > CC'ing Rusty
> >=20
> > On Mon, Apr 4, 2016 at 9:32 PM, Ben Hutchings <ben@decadent.org.uk> wro=
te:
> > >=20
> > >=20
> > > Debian will not sign modules during the kernel package build, as this
> > > conflicts with the goal of reproducible builds.=C2=A0=C2=A0Instead, w=
e will
> > > generate detached signatures offline and include them in a second
> > > package.
> > Is this a decision already? It doesn't look as a good reason - you
> > would already need to provide a signing key (CONFIG_MODULE_SIG_KEY)
> > anyway for this to work. How is leaving the module signature in
> > another package be any better than just signing the module?=C2=A0=C2=A0=
If you
> > have the signature, the build is just as reproducible as before.
> I think we may have different ideas about what reproducibility means.
> When I say reproducible I mean *anyone* with the right tools installed
> can reproduce the binary packages (.deb) from the source package (.dsc
> and tarballs).
>=20
> The signing key obviously isn't available to everyone, so the source
> package has to include detached signatures prepared outside of the
> package build process. =C2=A0But we can't put them in the linux source
> package, because that results in a dependency loop.

So, given these requirements, what do you think now about supporting
detached signatures?

I spoke at greater length about what I'm trying to do at Linuxwochen
Wien; see
http://meetings-archive.debian.net/pub/debian-meetings/2016/mini-debconf-vi=
enna/webm/Secure_Boot_vs_the_Debian_linux_package.webm#t=3D595
from about 9'55" to 17'30".

Ben.

> >=20
> > >=20
> > >=20
> > > We could attach the signatures when building this second package or a=
t
> > > installation time, but that leads to duplication of all modules,
> > > either in the archive or on users' systems.
> > >=20
> > > To avoid this, add support to libkmod for concatenating modules with
> > > detached signatures (files with the '.sig' extension) at load time.
> > this has the drawback that finit_module() can't be used.
> So does module compression, but it's still a supported option.
>=20
> [...]
> >=20
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Try to open a detached =
signature.=C2=A0=C2=A0If it's missing, that's OK. */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (asprintf(&sig_filename=
, "%s.sig", filename) < 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0err =3D -errno;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto error;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0file->sig_fd =3D open(sig_=
filename, O_RDONLY|O_CLOEXEC);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (file->sig_fd < 0 && er=
rno !=3D ENOENT) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0err =3D -errno;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto error;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > This can't really work if the module is being loaded uncompressed (I
> > think nowadays we can even add support for compressed modules...
> > Rusty, any input here?).
> >=20
> > When the module is being directly loaded, the direct flag gets set so
> > kmod_module_insert_module() knows it can try to use finit_module().
> > Since you have an external signature what would happen is that we
> > would load the signature, but try to load the module in the kernel
> > without it.
> It does work. =C2=A0I changed load_reg() to disable direct loading.when
> there's a detached signature.
>=20
> Ben.
>=20
> >=20
> > I'm still not convinced the split module + signature is actually a good=
 thing.
> >=20
> >=20
> > Lucas De Marchi
--=20
Ben Hutchings
Lowery's Law:
             If it jams, force it. If it breaks, it needed replacing anyway=
.
--=-VIfn7drj+X5M/ImdsxKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOxPSAAoJEOe/yOyVhhEJjcoP/3peqqMp1oCrhEEchX725Ig7
GYnGDYgLrKDtRTM0R07qPz3KtnyCjfGF8KMp1xfUAf37YyPDJjC/Zxbl2RH2INgK
XYZyhxMELsro2kLXrt9Huj13OwLPAFGSG5AYf3srJddPqoROCkBelzcwEAH7lR9u
Q1w0kl37NdkYW47a4CCJwVOKV1GewCHCPKoys8RBHrgiHw6lGuoI3Z/XK78waAOe
6jHX80iMnmfy92Y0N4rgOtd2F0AkLLJ/10ELjRzemloZ0yyUBNc9srsyAN7/Tw+f
yhK2PX+wzjZAnqQfIuEOia3mMXP9yf+XnGnW+ltSL7XaglXekaYIvKdgtlnYHqiU
o+di8eaqsg9OEr5mTVhph0d+2WmY/XlCaEKydJ4b0PRpIzGeQXs2PR9Gou+3GHZh
FLriGA0oDYl9zarUvEzEeTYJXY4BnmDb6AtkEkFMcp2NxDi0CKASiTryEjjGO89a
z4FQVUbn3Ed0Fg3HzCkyRYjP7sbIEudYZs2irSlaLN2SlOeV7BTLzvVn5WHWDF8J
LFHJ+GsnNDmfc3H92wNRPQcD2yHwIh9dd21Xj8ZYQQkob7HZrZKzQKKB5ShFy+A1
xg4ARsjJdhW1ezzpndUaUkeNv2e1RzpEg37dKt8+G7iI1RQp3sp5w/5Vo9UUb1Vb
7lTFNItaCUHuHJBatTYD
=A2yy
-----END PGP SIGNATURE-----

--=-VIfn7drj+X5M/ImdsxKN--
