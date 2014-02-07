Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:55419 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbaBGTxz (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 7 Feb 2014 14:53:55 -0500
Message-ID: <52F539D1.3010204@ubuntu.com>
Date: Fri, 07 Feb 2014 14:53:53 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: linux-modules@vger.kernel.org
Subject: kmod has no man page
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

There is no man page for kmod.  Rather than add one, I would suggest
simply eliminating this apparently useless binary ( the only thing it
seems to let you do is lsmod ) and replace the symlinks of the actual
commands with hard links.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS9TnRAAoJEI5FoCIzSKrwD+MH/18DIXXlpGg0XyQICB6hfP79
Ru64/THjd2UxRLEC6WzdF69riCVALixS76vO8FzFvdpMm5xJXCWKYMJEiTfRLIwp
9ANVjM3xKEwmrMsezRMb0jWjgrYuXfoLW41v4duf8rgap8VVFGfluP0Y7UALSy+u
NsBhlwfEi91Hh6+sPK6gUyYUmiHc8xRD1UjS+0jYk7R4vW3DP/0ZZb/fOap6S8aI
omgfPGkH36w/GXgC6ue2gmUVJpOTmz5qfZdY2LGQR6ek1Mbw3tJk/ugxMo/A9UaB
MloxBAj72qmf9CNG2W9GejzmyR3t/LEAp5h6nOLOBX2kzXsx/jKJnEL3Pefa+m8=
=MUXW
-----END PGP SIGNATURE-----
