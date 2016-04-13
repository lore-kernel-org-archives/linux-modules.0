Return-Path: <ben@decadent.org.uk>
Message-ID: <1460541612.2705.32.camel@decadent.org.uk>
Subject: Re: [PATCH v2] libkmod: Add support for detached module signatures
From: Ben Hutchings <ben@decadent.org.uk>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, 820010@bugs.debian.org,
	Rusty Russell <rusty@rustcorp.com.au>
Date: Wed, 13 Apr 2016 11:00:12 +0100
In-Reply-To: <CAKi4VAK64gR8U2n6=fO8o9Y1m7bTJsmeDLQcpegjF+57=_e8VA@mail.gmail.com>
References: <20160405001611.GJ21187@decadent.org.uk>
	 <20160405003237.GK21187@decadent.org.uk>
	 <CAKi4VAK64gR8U2n6=fO8o9Y1m7bTJsmeDLQcpegjF+57=_e8VA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-V+gzpQYMN9VdXaJsCtJS"
Mime-Version: 1.0
List-ID: <linux-modules.vger.kernel.org>


--=-V+gzpQYMN9VdXaJsCtJS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2016-04-13 at 01:05 -0300, Lucas De Marchi wrote:
> Hi,
>=20
> CC'ing Rusty
>=20
> On Mon, Apr 4, 2016 at 9:32 PM, Ben Hutchings <ben@decadent.org.uk> wrote=
:
> >=20
> > Debian will not sign modules during the kernel package build, as this
> > conflicts with the goal of reproducible builds.=C2=A0=C2=A0Instead, we =
will
> > generate detached signatures offline and include them in a second
> > package.
> Is this a decision already? It doesn't look as a good reason - you
> would already need to provide a signing key (CONFIG_MODULE_SIG_KEY)
> anyway for this to work. How is leaving the module signature in
> another package be any better than just signing the module?=C2=A0=C2=A0If=
 you
> have the signature, the build is just as reproducible as before.

I think we may have different ideas about what reproducibility means.
When I say reproducible I mean *anyone* with the right tools installed
can reproduce the binary packages (.deb) from the source package (.dsc
and tarballs).

The signing key obviously isn't available to everyone, so the source
package has to include detached signatures prepared outside of the
package build process. =C2=A0But we can't put them in the linux source
package, because that results in a dependency loop.

> >=20
> > We could attach the signatures when building this second package or at
> > installation time, but that leads to duplication of all modules,
> > either in the archive or on users' systems.
> >=20
> > To avoid this, add support to libkmod for concatenating modules with
> > detached signatures (files with the '.sig' extension) at load time.
> this has the drawback that finit_module() can't be used.

So does module compression, but it's still a supported option.

[...]
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Try to open a detached si=
gnature.=C2=A0=C2=A0If it's missing, that's OK. */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (asprintf(&sig_filename, =
"%s.sig", filename) < 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0err =3D -errno;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto error;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0file->sig_fd =3D open(sig_fi=
lename, O_RDONLY|O_CLOEXEC);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (file->sig_fd < 0 && errn=
o !=3D ENOENT) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0err =3D -errno;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto error;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> This can't really work if the module is being loaded uncompressed (I
> think nowadays we can even add support for compressed modules...
> Rusty, any input here?).
>
> When the module is being directly loaded, the direct flag gets set so
> kmod_module_insert_module() knows it can try to use finit_module().
> Since you have an external signature what would happen is that we
> would load the signature, but try to load the module in the kernel
> without it.

It does work. =C2=A0I changed load_reg() to disable direct loading.when
there's a detached signature.

Ben.

> I'm still not convinced the split module + signature is actually a good t=
hing.
>=20
>=20
> Lucas De Marchi
--=20
Ben Hutchings
It is easier to change the specification to fit the program than vice versa=
.
--=-V+gzpQYMN9VdXaJsCtJS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXDhisAAoJEOe/yOyVhhEJbjwQALsp1KxDdOYHq0kvNSfiDrVH
VuzMtyvGd3N/4nSf57oBrjs7ympLJx04jXc8fguAJCoXm2eUQutnkWPbXwdsJhSp
hJt/mFpfE2TD7mlJ60n1w5vpREAoBm299OW6CdSQoiIfcUeqp0cfqnk4MxDrtZPC
JQXSV8Ler/pSVMtarhBKWzuLBDnquD2lodDOSHOa3nxNWLkjx0KujxhhaFgmAwDT
Nayi+W3/YxgTIU4lAmXbDgcL53yeXfE0YUH/PEBzfQunNqv/ydimdzSAriTLMm5H
mL3zYMvJEBK0ZiBo6DOgicfsFFw6g+P6ME8S4UFZKWUzNwZn0P7VIPr16cOnNplK
xnBMdXTzdosgwstjC1bwWzM9BV/uYfnK+QrToBfM08Op0cWe7mAWwZAHfr+EkSHW
dCGI3+9t6a2LHvt/mHox9WjXU5Ckcl7SHlSxXKu4ZSKaXY3drxqOtDiLBkFlBwpI
lfd/30Pqp/LHFNlKXBhVhVDdGjci8L6ONp0CAi+C8AoCwF3W0bXwPzGTF0Xns65z
WtfKhG0eflBAdBEijaFcZd3AvSdz0K1miQ8VXK2m/OJajJX/nD+Xu/txL108OBIv
MxbnK/M6Cgy4j0Yvpao/Ki+vUPZtJB3u9mOLAa7eMeXIN5y6KgPTk9vQnwSPIXvv
tyPsFvvNIeNuhidCg1Oo
=U55H
-----END PGP SIGNATURE-----

--=-V+gzpQYMN9VdXaJsCtJS--
