Return-Path: <sfr@canb.auug.org.au>
Date: Thu, 4 Jun 2015 13:19:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>, Andreas Mohr
 <andi@lisas.de>, Andrew Morton <akpm@linux-foundation.org>, Bertrand
 Jacquin <beber@meleeweb.net>, Marco d'Itri <md@linux.it>, linux-modules
 <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jon
 Masters <jcm@redhat.com>
Subject: Re: [PATCH] modules: CONFIG_MODULE_COMPRESS: add hint that
 userspace support may easily be missing.
Message-ID: <20150604131946.6441b568@canb.auug.org.au>
In-Reply-To: <87h9qouuny.fsf@rustcorp.com.au>
References: <20150531152932.GA16337@rhlx01.hs-esslingen.de>
	<87r3pwgd0b.fsf@rustcorp.com.au>
	<CAKi4VAJfhM0UMOmFkQ40RW5gJGKch8AH8QEvuiYtj93O+YTNwA@mail.gmail.com>
	<87h9qouuny.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XhZ/N1vgoHg3pkWsL8yla_g"; protocol="application/pgp-signature"
List-ID: <linux-modules.vger.kernel.org>

--Sig_/XhZ/N1vgoHg3pkWsL8yla_g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rusty,

On Thu, 04 Jun 2015 11:00:41 +0930 Rusty Russell <rusty@rustcorp.com.au> wr=
ote:
>
> Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
> > On Mon, Jun 1, 2015 at 3:26 AM, Rusty Russell <rusty@rustcorp.com.au> w=
rote:
> >> Andreas Mohr <andi@lisas.de> writes:
> >>>
> >>> I just had a not so nice experience
> >>> when finally upgrading to a new 4.1-rc5
> >>> with CONFIG_MODULE_COMPRESS newly enabled -
> >>> userspace binary parts (kmod 18 or 20 in my case)
> >>> did not have compression enabled
> >>> (at least on Debian 8pre, vs. encountering it enabled on FC21)
> >>> since it does not seem to be
> >>> the default build configuration of kmod (yet?).
> >>
> >> Sure.  Let's get the maintainers to insert the actual version required
> >> in the help text though.
> >
> > kmod supports gz since the first version and xz since version 3.  So bo=
th
> > of them can be safely fall into "it's supported since the beginning of
> > kmod IMO".
>=20
> Thanks, that's what I needed.
>=20
> But disappointing that Debian doesn't configure with it, and there's no
> easy way to check it.  Looks like Ubuntu vivid is the same.

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D772628

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/XhZ/N1vgoHg3pkWsL8yla_g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVb8PXAAoJEMDTa8Ir7ZwVvyoP/3dqTENEmA80BWjlD4w5CKLT
Xwk3WrIwnbGHEHNYxUkqkwuwpUsaatL11/rO+n4T5cF9/ltEWlXxCwC72cTovrz+
XeoTQ1TK3LqBk9Np+oJvLwQAN4XPuHBQjAbyCpa2mj/tSvGW8Ywb+UIKc/zFp3pS
DwIlRacv2L91wOGTfUO7yiDgFmtZ8OCrr1MsbPb1xtfPvhM5DUHHASjU+eOw7nkL
U56EXYet+xU0ZZdcbysfrWDW3asLofcEmCtKxEY7rhOqre7h84STBJMRtiQPVWq1
UqBGNjZ9jF02Npp+gmOODJvC3qWfTEAdJFKBN9JQ09CTzktxHbqVg/Ot2OVNhffs
pAmt/tTO5wLa+EZ8aLVwvzJB54B28YIlCVtEe321tjZSIihwwCA+Q1X+tEhpwOP5
cZfpftTsTNqIs8jgYW8VT5MpgC38RvOqLgQnDHT9XqZa+xAEs5lfiGxJi2brWiUr
GoAJGT3ognUcV8YyNkscND5hLY5XurvJizmSxM05ez1ZzE7c5bhLD1tVlLKL1b0/
adQR6okKZuSKnHIYcUXu+fRekd7tx7DQqBY4i9nrBrX19toKBActvRWobxoEZft0
zyOhxwxpfLOu5L92GPKraEq6MS/mvMnl2hPtJ7gPiWmJvP+VWTJo82bsiQg/BKic
UKJxPJlrIXgDWYP9MqVU
=TZuZ
-----END PGP SIGNATURE-----

--Sig_/XhZ/N1vgoHg3pkWsL8yla_g--
