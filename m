Return-Path: <chengwei.yang@intel.com>
Date: Wed, 8 May 2013 09:05:41 +0800
From: Yang Chengwei <chengwei.yang@intel.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: kmod <linux-modules@vger.kernel.org>,
	Yang Chengwei <chengwei.yang@intel.com>
Subject: Re: [RFC] Fix the kmod internal list behavior?
Message-ID: <20130508010541.GB4432@chengwei-workstation.bj.intel.com>
References: <20130507135453.GA25275@chengwei-workstation.bj.intel.com>
 <CAKi4VAJkZpo-=XxJ9Tnwdt6E9YdHsoQu1s7nU7m5ZUNQmNcp5Q@mail.gmail.com>
 <20130508001530.GA4432@chengwei-workstation.bj.intel.com>
 <CAKi4VAKsHwG1SqTN4oVO_3ysngEO4M0xC--jbZWyY6aedPxb5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
In-Reply-To: <CAKi4VAKsHwG1SqTN4oVO_3ysngEO4M0xC--jbZWyY6aedPxb5Q@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 09:50:56PM -0300, Lucas De Marchi wrote:
> On Tue, May 7, 2013 at 9:15 PM, Yang Chengwei <chengwei.yang@intel.com> w=
rote:
> > On Tue, May 07, 2013 at 12:14:59PM -0300, Lucas De Marchi wrote:
> >> On Tue, May 7, 2013 at 10:54 AM, Yang Chengwei <chengwei.yang@intel.co=
m> wrote:
> >> > Hi List,
> >> >
> >> > I just found that there are some minor issues in kmod iternal list
> >> > implementation implemented by libkmod-list.c.
> >> >
> >> > Say
> >> >         1. list_node_append() is identical with list_node_insert_bef=
ore(),
> >> >         so somehow the list_node_append() in fact does "prepend" ope=
ration.
> >>
> >> To append to a circular list, you insert it *before* the first node.
> >> So what's wrong here?
> >
> > Yeap, it's definitely right. I was misunderstanding. :-(
> >
> >>
> >> >
> >> >         2. just the same as list_node_append(), kmod_list_append() w=
hich
> >> >         invokes the former just do "prepend" operation rather than "=
append".
> >>
> >> like I said, it's expected, since it's circular. kmod_list_append()
> >> expect you to pass the head of the list, so to append to the list you
> >> prepend to the first node, but you don't return it as the new head
> >> unless it's the first one - check the return code.
> >>
> >> >
> >> > I'd like to fix these internal APIs to do the operation suggested by=
 its
> >> > name like
> >> >         1. drop list_node_append()
> >> >         2. call list_node_insert_after() to do "append" operation
> >> >         3. call list_mode_insert_before() to do "prepend" operation
> >> >
> >> > Since the list here is circular linked, so I think these changes sho=
uld
> >> > not break things except the test cases.
> >> >
> >> > Any comments are appreciated.
> >>
> >> Are you analyzing the source code or are you seeing a real problem?
> >
> > Relax, no real issue found.
>=20
> Good to know :-)
>=20
> >
> >> It'd be nice to write a small test showing the problem - you can use
> >
> > So I think it's not necessary to add a dedicate test for list, the
> > others somehow use the list, like modinfo test.
>=20
> On a side note about the current list implementation: one interesting
> thing to investigate is how much memory we waste on list nodes and how
> we could improve that. One possible answer is by using inlined nodes
> like kernel's.
>=20
> In some places we use kmod_list very heavily like in depmod. Last time
> I checked I remember a great portion of the memory used just to store
> the list nodes. If you would like to improve this part, or at least
> profile it, it would be very nice :)

Add to my TODO list, but I'm not sure what the ETA is. :-)

--
Thanks,
Chengwei

>=20
>=20
> Lucas De Marchi

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJRiaTlAAoJEG8F0Pe1SMenmGsH/AuJlAgaterAYyI57445n/Zu
kfyNuD8YyQyceozy9B9g8yIVshC0rQIYXnIG/tYzxEUYy/2HIx04kxNpE16LfCRL
/JWDkDa5In+lhTDorHD1jev0/XmXPhY+NgggnaUq1DsuNeumEhGEqO7Zwi9iq4SR
gef0m6b7qHbV6XoxHNMTKdm53okokAAdCDkHQ/oM/qcqU9a7TyJThoVAliRuZ5Vc
LfR5Cl1JPRpmvoUiM82m+HKvmF/ObY6oMrpGh8r9/aR1q9lOszfla9AylOa1BiOe
TqztxGCYWvtslIgzCJBbArg0vYK7JKWQl+bhMxN8eHjnxY3dGdpZEmf7uhbro1g=
=oI+1
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
