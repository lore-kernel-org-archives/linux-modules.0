Return-Path: <md@linux.it>
Date: Fri, 8 Sep 2017 23:30:48 +0200
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-modules <linux-modules@vger.kernel.org>, jeyu@kernel.org
Subject: Re: [RESEND PATCH] modprobe: install default configuration
Message-ID: <20170908213048.d4lwkemko53sqagb@bongo.bofh.it>
References: <20170901112801.11703-1-lkundrak@v3.sk>
 <CAKi4VAKS7Vo6WoEJGjY6cRMZxmSsv4mj=eRhhHCnYno0DoP5Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i7occb6o45oxe4jg"
In-Reply-To: <CAKi4VAKS7Vo6WoEJGjY6cRMZxmSsv4mj=eRhhHCnYno0DoP5Ag@mail.gmail.com>
From: md@Linux.IT (Marco d'Itri)
List-ID: <linux-modules.vger.kernel.org>


--i7occb6o45oxe4jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 08, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

> On Fri, Sep 1, 2017 at 4:28 AM, Lubomir Rintel <lkundrak@v3.sk> wrote:
> > Some network devices have an awful habit of creating interfaces when lo=
aded,
> > despite not asked for. Worse even, they do so while being autoloaded du=
e to an
> > attempt to create a device via netlink:
I agree that this behaviour by dummy, bonding, etc is unfortunate
and annoying; however, I do not believe that user space tools
maintainers overriding the decisions of kernel maintainers will help
creating an healty environment.

As the Debian kmod maintainer I would also be seriously concerned about
carrying this change since it would break existing configurations on
upgrades.

> It seems you forgot to follow up on the feedback I gave last time and
> asked for opinions.
>=20
> https://lkml.org/lkml/2016/6/14/336
I think that this would create excessive complexity and force everybody=20
to learn the semantics of this new directive.
If you really believe that copying the whole file would be bad then just=20
split the directives in multiple files.

--=20
ciao,
Marco

--i7occb6o45oxe4jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEGBsIcS5ipP0URKfyK/WlwSLE96QFAlmzDAgACgkQK/WlwSLE
96Q7hQv/d0eAlwS6wCgzCJWewgtg6Vpqe9p3EZX/9sZfqFQoK00CXCOIF4062Rw9
mQ8//AiuV5blKzJm/k9lOIaiLNWsvvFVnxgRs2syidOYnvnoe/bpoJTOPBV/307q
QPYaLEdDzNuuAJKz120d+aUvAD8HDQbBmeLKytuwgc7BEEW7154zi7Ct0ZWyAHmM
zTt04ghc7YU4+JI3RMf4/pcrHaizOalQl2m67del1Th0j4FqEmX9I8IPfnfn0h1m
mFZFAt7xZ1vF3QSUjEMkn1bwb6O/+f9km9wVFihw1gzYYJ5NC//xN0IFICXtYSnj
KzIqtSSdOT7Ud8Lv/T6wp0Hmqq49m4Roo1KvKHdSUIpqjuQHdDjoMWl/Vfke7peE
K5fO5THrzPWDr3uEoZ/+2e8wynTXk/sznNiGYCT3CcGQv5foM/8lw/mNZHCIi9o7
XFn0P2mUhzgl63EKdM8C3mS4WDZjymVrrYg03+NxF/MJLWnyvItXQKhlIyVuGtvN
7C4xyqvW
=M6U/
-----END PGP SIGNATURE-----

--i7occb6o45oxe4jg--
