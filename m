Return-Path: <chengwei.yang@intel.com>
Date: Wed, 8 May 2013 08:15:30 +0800
From: Yang Chengwei <chengwei.yang@intel.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Yang Chengwei <chengwei.yang@intel.com>,
	kmod <linux-modules@vger.kernel.org>
Subject: Re: [RFC] Fix the kmod internal list behavior?
Message-ID: <20130508001530.GA4432@chengwei-workstation.bj.intel.com>
References: <20130507135453.GA25275@chengwei-workstation.bj.intel.com>
 <CAKi4VAJkZpo-=XxJ9Tnwdt6E9YdHsoQu1s7nU7m5ZUNQmNcp5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
In-Reply-To: <CAKi4VAJkZpo-=XxJ9Tnwdt6E9YdHsoQu1s7nU7m5ZUNQmNcp5Q@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 12:14:59PM -0300, Lucas De Marchi wrote:
> On Tue, May 7, 2013 at 10:54 AM, Yang Chengwei <chengwei.yang@intel.com> =
wrote:
> > Hi List,
> >
> > I just found that there are some minor issues in kmod iternal list
> > implementation implemented by libkmod-list.c.
> >
> > Say
> >         1. list_node_append() is identical with list_node_insert_before=
(),
> >         so somehow the list_node_append() in fact does "prepend" operat=
ion.
>=20
> To append to a circular list, you insert it *before* the first node.
> So what's wrong here?

Yeap, it's definitely right. I was misunderstanding. :-(

>=20
> >
> >         2. just the same as list_node_append(), kmod_list_append() which
> >         invokes the former just do "prepend" operation rather than "app=
end".
>=20
> like I said, it's expected, since it's circular. kmod_list_append()
> expect you to pass the head of the list, so to append to the list you
> prepend to the first node, but you don't return it as the new head
> unless it's the first one - check the return code.
>=20
> >
> > I'd like to fix these internal APIs to do the operation suggested by its
> > name like
> >         1. drop list_node_append()
> >         2. call list_node_insert_after() to do "append" operation
> >         3. call list_mode_insert_before() to do "prepend" operation
> >
> > Since the list here is circular linked, so I think these changes should
> > not break things except the test cases.
> >
> > Any comments are appreciated.
>=20
> Are you analyzing the source code or are you seeing a real problem?

Relax, no real issue found.

> It'd be nice to write a small test showing the problem - you can use

So I think it's not necessary to add a dedicate test for list, the
others somehow use the list, like modinfo test.

--
Thanks,
Chengwei

> the testsuite for this... take test-alias as an example (i.e. you need
> to link to the private lib).
>=20
> regards
> Lucas De Marchi

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJRiZkiAAoJEG8F0Pe1SMenorkH/jIvvJb4ymNhKKTHSH/p0iTc
6mDWC+dECTlwSjMSrx8KBlPhMYGUPWJWXE9cnnCUKhPeTuTKqmyfgdKKO2u94hQO
7NVXB2JOJejXpr+3tyNN0qMgtkqYHN7YDKxE6b6yd154v+GpdWWFM4gVzQU5RmLL
kp4K28YhWIrZyDuhkcj4czDhh/rALYhBu5LCQ7l/OmAkIax1aog8pQYT0i3Y8sPX
8xbVgVAnlYbWuKBkH7S8lOKPS7n5TtuXkCPdS34be3OL1dOquC52PVseayotYny7
rfNuFowFJn9Y7Tok4GFpnPTXAcv/jueOaGoX/gRankJTzNVK5qrOqRMCkoU73HM=
=Q6Ld
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
