Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17414 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140Ab3EHHrr (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 8 May 2013 03:47:47 -0400
Date: Wed, 8 May 2013 15:47:44 +0800
From: Yang Chengwei <chengwei.yang@intel.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Chengwei Yang <chengwei.yang@intel.com>,
	linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] Fix 'make check': undeclared __NR_finit_module
Message-ID: <20130508074744.GB6991@chengwei-workstation.bj.intel.com>
References: <1367938456-13058-1-git-send-email-chengwei.yang@intel.com>
 <CAKi4VAKBuD4JM-OoHRuHxE7KZgWxHNt=tuCJr6pHrV-aHY9WUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
In-Reply-To: <CAKi4VAKBuD4JM-OoHRuHxE7KZgWxHNt=tuCJr6pHrV-aHY9WUQ@mail.gmail.com>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 11:57:28PM -0300, Lucas De Marchi wrote:
> On Tue, May 7, 2013 at 11:54 AM, Chengwei Yang <chengwei.yang@intel.com> =
wrote:
> > This issue introduced by a fix for syscall(-1, ...) is invalid on some
> > arch. The error thrown by 'make check' likes below.
> >
> > testsuite/init_module.c: In function 'syscall':
> > testsuite/init_module.c:317:17: error: '__NR_finit_module' undeclared
> > (first use in this function)
> > testsuite/init_module.c:317:17: note: each undeclared identifier is
> > reported only once for each function it appears in
> > make[2]: *** [testsuite/init_module.lo] Error 1
> > make[1]: *** [check-am] Error 2
> > make: *** [check-recursive] Error 1
> > ---
> >  libkmod/missing.h |   16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/libkmod/missing.h b/libkmod/missing.h
> > index b31af84..52dbcc7 100644
> > --- a/libkmod/missing.h
> > +++ b/libkmod/missing.h
> > @@ -12,6 +12,10 @@
> >  # define MODULE_INIT_IGNORE_MODVERSIONS 1
> >  #endif
> >
> > +#ifndef __NR_finit_module
> > +# define __NR_finit_module -1
> > +#endif
> > +
> >  #ifndef MODULE_INIT_IGNORE_VERMAGIC
> >  # define MODULE_INIT_IGNORE_VERMAGIC 2
> >  #endif
> > @@ -19,11 +23,11 @@
> >  #ifndef HAVE_FINIT_MODULE
> >  static inline int finit_module(int fd, const char *uargs, int flags)
> >  {
> > -#ifndef __NR_finit_module
> > -       errno =3D ENOSYS;
> > -       return -1;
> > -#else
> > -       return syscall(__NR_finit_module, fd, uargs, flags);
> > -#endif
> > +       if (__NR_finit_module =3D=3D -1) {
> > +               errno =3D ENOSYS;
> > +               return -1;
> > +       } else {
> > +               return syscall(__NR_finit_module, fd, uargs, flags);
> > +       }
>=20
> humn... my bad not applying it to testsuite.
>=20
> But I would expect the same fix being applied to testsuite instead of
> changing the check to runtime.

Agreed, I'll upload v2 later.

--
Thanks,
Chengwei

>=20
> Lucas De Marchi

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJRigMgAAoJEG8F0Pe1SMenJeEH/R1XkY4aXwCydF99gq0ag7NW
y/IC0IJx+63xEcd/CcSIJYmemtiG8zKMiI91Olm5kxiIKs1qOvziB0Ev0L3qdIRY
0Tb6V+27zSXBjPUHxy7eAwpb2QNIz3xo7xgNI69zBeFT1RuDFXEpoR5EVE5hcOfj
1IOQE3tEyczQshIuYnwOd1KK64BJAhFRI75IZaGPkoI4oibIxy2io/HWq+5TecGg
2/Fs6w3/LxeY/XlOOxyvZ4nCmDA6Fibi+qi9Gyf66VqOeibGAlzsYp2CEqG2JOJ7
JJT2/KVjsSHa33Smw7gmDOAKWGAP4Bajq+mLD+dNRy67nir+SArMNFbl7Er6dr4=
=gaJ1
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
