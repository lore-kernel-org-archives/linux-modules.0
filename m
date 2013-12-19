Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from server102.greatnet.de ([83.133.97.2]:47095 "EHLO
	server102.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875Ab3LSShz (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 19 Dec 2013 13:37:55 -0500
Received: from [0.0.0.0] (linux.hrz.fh-zwickau.de [141.32.208.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by server102.greatnet.de (Postfix) with ESMTPSA id BD42998553F
	for <linux-modules@vger.kernel.org>; Thu, 19 Dec 2013 19:31:53 +0100 (CET)
Message-ID: <52B33B88.2090306@mageta.org>
Date: Thu, 19 Dec 2013 19:31:36 +0100
From: Benjamin Block <bebl@mageta.org>
Reply-To: bebl@mageta.org
MIME-Version: 1.0
To: linux-modules@vger.kernel.org
Subject: Can't load modules with parameters given
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9UOMIv22dn20vBlpR73DuB63fqJ5moAPv"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9UOMIv22dn20vBlpR73DuB63fqJ5moAPv
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I have a rather strange problem currently. I am trying to load a module
with some parameters (bnx2x with disable_tpa=3D1) and it fails because
this parameter is unknown according to dmesg. But modinfo lists this
exact paramter and it is also included in the source. And while this is
not an in-tree driver, I could also replicate the same behavior with
in-tree device drivers (like bonding with the parameter tx_queues):

$ modprobe bonding # works fine
$ rmmod bonding
$ modprobe bonding tx_queues=3D32
modprobe: ERROR: could not insert 'bonding': Unknown symbol in module,
or unknown parameter (see dmesg)

and dmesg tells me:
	bonding: Unknown parameter `tx_queues'
and nothing else (as with bnx2x, this parameter is listed by modinfo).

Is there some obvious kernel-config-option I could have messed up or
something else like this?

I am using a Gentoo-Userspace kmod (v15) with a Ubuntu-Kernel (3.8.13.13
- this is a version with some ubuntu-patches applied) - I know, the
combination is rather strange. Any ideas?

best regards,
- Benjamin


--9UOMIv22dn20vBlpR73DuB63fqJ5moAPv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQGcBAEBAgAGBQJSszuYAAoJEEbgTgVnoy6eAhYL/2ffxnqGorcQglgf/qoy+PSR
q9UhnO00v4eazh1nVlFnmXYzPCUtjRuknx7DuhMytQmjQZDNR7bkPjBu1Mv2nnE5
r6Vcl+Q2LaqX1qhH8zp5HBcyheE0RWbmDmqMzoQZA5EGDYQBSJwRprlLcZ6eqfXd
VbfMhbXhT7eaibBGCfv/nzBhovSwLZ1fmM0h1rhqhD0PPS9CkfFZ5cBbc4qTsIUs
e3WUlpa3iGo30GkCE4CXZOf4Gs0H8h54Y1I5GCWP2Hg6BVWsxYjwj74U0Mlgs+IU
iXQoIz1askMMsYmOcZUXOaBnMy5e2J5aqR+iq7olPdsGc5o8qbcbT9yWQMfgStjA
Xt4WwlboGzcyfnFMYWtegjBBXT5LTcA7Tot+cjETJ0uPiwgP3ELFzmOzeJQImRwo
syCSOUD6AXc2B+ObKxPfI1j7Yi2Ddo3TcblmSiOo9zreDIEC+Sx7i/4iW1vsO6Ah
vfgGvqqRkoN8mlRX7k66sidBBPZ8oUQkZVetlKlc+g==
=XEQQ
-----END PGP SIGNATURE-----

--9UOMIv22dn20vBlpR73DuB63fqJ5moAPv--
