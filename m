Return-Path: <shea@shealevy.com>
From: Shea Levy <shea@shealevy.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>, Nikolay Amiantov <ab@fmap.me>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: Improvements in search of kernel modules directory
In-Reply-To: <CAKi4VA+3z3dqN89yazY2UJ40KmTAHzgW0UfiGfY3odbngqmj7A@mail.gmail.com>
References: <20160816005032.28881-1-ab@fmap.me> <CAKi4VA+3z3dqN89yazY2UJ40KmTAHzgW0UfiGfY3odbngqmj7A@mail.gmail.com>
Date: Mon, 05 Dec 2016 07:35:51 -0500
Message-ID: <8737i25za0.fsf@shlevy-laptop.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-modules.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Hi Lucas,

Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
>
> An environment variable for the library IMO is not a good option. If
> you take a look on how we separate the responsibility of each
> component you will see that we parse environment vars on the tools
> (e.g. modprobe) not on the library.
>

Can you explain a bit why an environment variable is not OK here? The
code path using get_kernel_release is shared by many tools, and as
things currently stand there is already a global setting fixed in this
file. If we were to move this out to the tools, we would have to
duplicate this code in several places and any external tools linked
against kmod (e.g. systemd) will need to be updated as well. By default
users of this interface will not know that they need to check the env
var, because as things stand the code will just work, so it's likely
that new uses, in and out of kmod, will start out not respecting
MODULE_DIR and only after someone notices things aren't working for a
case relying on it will they be changed.

Thanks,
Shea

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYRV8nAAoJEFwL1pV9hv4n1SUP/ignsBJmhgqr1jaF6mzWBlRn
vAlOyXpRrZ104Zd/5Ak6XUeL2KeknvWZtxgvgSTOX59aKsZr4vcpspCVv/eZnCgI
eHkl0v6Fl74WhPcwx6/le05RUTtOwK/sLw5ICMFnJ8YYfqlMDLYMPkYItlD9Wdwm
l0VKRGKrmUiUc9gGj6HstUq+W7QmP9Rk0/Ibt01+vPAmDYbFPcR003aHMK86hWG3
g6MNFtdK8vtg/xEptfAiiFnXJ6U6mUL4d2TJum5QCBnURZbcb7AhOhoPkfjxbR5A
s2D5BwNQo0hcrvO2UvxZlnNj3N3jWDqOsrwtwvTI6U5JkSq+ZyrweXpX+03OUPKP
JmCpkXWOGh1xyK8azAlmVUZAuMGoplwDhhsCIrwPcIxT985EyHfsVQ+LLjsc3k68
l3fe5frAWE+to3IXoc+pCJl7QcxbIS44wiAOWcn/9U/B1ZufNa96c0NeBTrOxv9d
1DNk0D+YSql/rhX/qXeoLaiU7SsXuYlAB62Jw9hf06wl1yMptA8HP1JIJF8QrjDD
eP/hSJfGhwcwbGwL0xr8umMhV2qd8Ww8oEVf80cOqqRAQQz62nBz1R4dhPWO0lSI
rbS0kOY1k71lJh63TyhDw7/92IKMAkYZ/VsuWrxhOl+/r9O/wPmyhlRs7hdbDJBT
xovx6fEV8YCqgaPxXkAr
=zF9l
-----END PGP SIGNATURE-----
--=-=-=--
