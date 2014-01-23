Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34370 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295AbaAWTT2 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 23 Jan 2014 14:19:28 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s0NJJSVk028204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-modules@vger.kernel.org>; Thu, 23 Jan 2014 14:19:28 -0500
Received: from redhat.com ([10.15.16.226])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s0NJJQb6011927
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linux-modules@vger.kernel.org>; Thu, 23 Jan 2014 14:19:27 -0500
Date: Thu, 23 Jan 2014 14:19:25 -0500
From: Lukas Berk <lberk@redhat.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH] man: insmod documentation fix
Message-ID: <20140123191925.GA11585@redhat.com>
Reply-To: Lukas Berk <lberk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


--i9LlY+UWpKt15+FH
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey,

Just a quick documentation spacing fix.

Cheers,

Lukas

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-man-insmod-documentation-fix.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 0efbedbb0f1250e2810943aa19364451d9111c8f Mon Sep 17 00:00:00 2001
=46rom: Lukas Berk <lberk@redhat.com>
Date: Thu, 23 Jan 2014 14:08:58 -0500
Subject: [PATCH] man: insmod documentation fix

Add comma between lsmod(8) and modinfo(8)

Signed-off-by: Lukas Berk <lberk@redhat.com>
---
 man/insmod.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/insmod.xml b/man/insmod.xml
index db0672c..8ff4e20 100644
--- a/man/insmod.xml
+++ b/man/insmod.xml
@@ -75,7 +75,7 @@
       </citerefentry>,
       <citerefentry>
         <refentrytitle>lsmod</refentrytitle><manvolnum>8</manvolnum>
-      </citerefentry>
+      </citerefentry>,
       <citerefentry>
         <refentrytitle>modinfo</refentrytitle><manvolnum>8</manvolnum>
       </citerefentry>
--=20
1.8.3.1


--sdtB3X0nJg68CQEu--

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJS4Ws9AAoJEAaRCclx+kwJwG0QAJCtc6k9S5DmyQbtJ8ZPn9+P
NJiCOr6WXdal4SI80l2RkgEtQYDndUoMtJXMhwA957LqtamlvnLcE1H6NQoamPFv
YjZK0wJe2sjXnGZStsMSb5RuGGUYtSAnMmRKgys8BcUMEruZbCWRMMQ3JgGBBwjr
+ShvEHKbDFDaQcgn4Ia58pXx8G3UNTKaX0hiDx1brB+YV1fP+ZVXEVuPZhRjrlIk
Y3QyDPy3zVRuDsoy6F6MRohnpsvfIcoh655CkZ+8u3CyWHKMcgTOQAqw3hK1kX50
UWZsvf6giGE4I1pX4nwpqCYOIXnmsFR0Pq1j5fOoiGbt6gpSZtdlceS7V9P0V5nt
CuePsAcsTTpjXpAs1eRZEJ4ZQzuwyR69wScLkwep4hxV5HHvn52BlEBfv9Dw7XPH
ROBG0XDLXOfq6E59cM3ZUIYD/O5pn9RPs8bY8YbJ0eL841XXyuTDmdOpblIqH6gl
nTdHY8tJQQMAo0nW81YUtK8MDnRm6CpVSubjo4Ec2MRJ1nn58vwyeyth/xJL5sSQ
uSHZDs+KH1iUH2pEwpDK+tyI7iBV6SxozMLzRV+sK5pCILNNBhnBqOD+t43S41vV
9mPBwn2fYlkZZM/h8ZZdtA4+BWAbW1aR7IrGq6Yavwo3GKk/DViWMnnsn8nwPl7R
poiyLevksihFJo3SVdxk
=eLbv
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
