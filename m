Return-Path: <psusi@ubuntu.com>
Return-Path: <psusi@ubuntu.com>
Message-ID: <52F54EBA.4060803@ubuntu.com>
Date: Fri, 07 Feb 2014 16:23:06 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: kmod has no man page
References: <52F539D1.3010204@ubuntu.com> <CAKi4VA+aqzFZ=AJyiXV3sF+K705ssT_sC0DwY1=Fd6-e3=-9uA@mail.gmail.com>
In-Reply-To: <CAKi4VA+aqzFZ=AJyiXV3sF+K705ssT_sC0DwY1=Fd6-e3=-9uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2/7/2014 3:13 PM, Lucas De Marchi wrote:
> It's only *apparently* useless. If you use a more recent version of
> kmod you will see there's at least static-nodes command, that is
> not available otherwise.
> 
> The plan has always been to create sane commands in the kmod tool 
> (like kmod insert, kmod info, kmod remove, etc) and let the
> symlinks for when the compat behavior is expected.
> 
> Right now this is only half done, but removing it like you suggest
> is not an option.

Ahh, in that case then it just needs a man page ;)


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS9U66AAoJEI5FoCIzSKrwX6QH/jtfGo0A9kdoYVMZXR0NEzPJ
6lC6LQOUX69gqbR1nkG4TqOYwcQnfvC9eUxYt1ANoXXrr7KUqtgT2Ds+bHzzs9t2
ZqMh4cZG1B3PUdJSZShXioHs0JHaZQIMca+IgACexeGVEYu01QSU+DuqQLcVwh6v
3fePhQ1Z4p6rdNFZkwwoiO83tvonA0gCBbXv7Db1gQAc2hBP4+cSFda1rzJbhZPc
GLmV9TtDfYVZkkk4w2+dsXNAyWqWokrU478+Ud3juyllgp9pEaC3CkLVXQP1KQsh
BKh69ItTgC4ka6gRQm2K2hdiHUZk/qb6xeJ9NTJOu4zapAV11VgxWLTRs3MAqNU=
=AlFN
-----END PGP SIGNATURE-----
