Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:51860 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752961AbaAZODv (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sun, 26 Jan 2014 09:03:51 -0500
Received: from mail619.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 7855AFFC995
	for <linux-modules@vger.kernel.org>; Sun, 26 Jan 2014 14:50:44 +0100 (CET)
Date: Sun, 26 Jan 2014 14:46:07 +0100
From: Stephen Kitt <steve@sk2.org>
To: linux-modules@vger.kernel.org
Subject: [PATCH] Remove "rmmod -w" documentation and getopt entry
Message-ID: <20140126144607.07463138@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/xcABbmwr+E7q1HFfR_vXSKr"; protocol="application/pgp-signature"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

--Sig_/xcABbmwr+E7q1HFfR_vXSKr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

The changelog for version 11 mentions that the "--wait" option on rmmod is =
no
longer documented, but it still appears in rmmod.xml. In addition, the geto=
pt
handling in rmmod.c no longer supports "-w" or "--wait", but the cmdopts
declaration still includes it.

This patch removes the cmdopts declaration and the documentation.

Signed-off-by: Stephen Kitt <steve@sk2.org>

diff --git a/man/rmmod.xml b/man/rmmod.xml
index d9a6295..14c94dd 100644
--- a/man/rmmod.xml
+++ b/man/rmmod.xml
@@ -39,7 +39,6 @@
     <cmdsynopsis>
       <command>rmmod</command>
       <arg><option>-f</option></arg>
-      <arg><option>-w</option></arg>
       <arg><option>-s</option></arg>
       <arg><option>-v</option></arg>
       <arg><replaceable>modulename</replaceable></arg>
@@ -94,22 +93,6 @@
         </listitem>
       </varlistentry>
       <varlistentry>
-        <term><option>-w</option> <option>--wait</option>
-        </term>
-        <listitem>
-          <para>
-            Normally, <command>rmmod</command> will refuse to unload modul=
es
-            which are in use.  With this option, <command>rmmod</command> =
will
-            isolate the module, and wait until the module is no longer use=
d.
-            Nothing new will be able to use the module, but it's up to you=
 to
-            make sure the current users eventually finish with it.  See
-            <citerefentry>
-              <refentrytitle>lsmod</refentrytitle><manvolnum>8</manvolnum>
-            </citerefentry>) for information on usage counts.
-          </para>
-        </listitem>
-      </varlistentry>
-      <varlistentry>
         <term>
           <option>-s</option>
         </term>
diff --git a/tools/rmmod.c b/tools/rmmod.c
index fd0fac5..df2f041 100644
--- a/tools/rmmod.c
+++ b/tools/rmmod.c
@@ -40,7 +40,6 @@ static const struct option cmdopts[] =3D {
        {"syslog", no_argument, 0, 's'},
        {"verbose", no_argument, 0, 'v'},
        {"version", no_argument, 0, 'V'},
-       {"wait", no_argument, 0, 'w'},
        {"help", no_argument, 0, 'h'},
        {NULL, 0, 0, 0}
 };

--Sig_/xcABbmwr+E7q1HFfR_vXSKr
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJS5RGlAAoJEHWXeKmja0lPjpoP/3vKnNHUegPYg5n1XCtgJCJ5
T/KAlm3nT7boFQRbCB4xi0ik2fe8+THEGf7+tHoZfoeQh4JAG+bLz31Sv3DGGPfu
XQrQREUCwzLGVVzg+zC0lOlg/Hdk76DGA1C7xs+5h4bqs7rhdiKEg8351kfJ7Lh4
aAWUXz3aV7FSgM0udVRu41leUw/l8Y/lbffNHFVw8jF0SPYxnYXOrp+nOGHDjx38
RWyY3fIk7QElhE8cYUauGZn0Y0WmPbaR08jEorlKjQQIvmssymvCvthhF97frlS5
hP1D0Bw4VkfkqhOn9TFckdY8owrlyZ4jh/0VWE13b3v1NfngHAB44YayeHv38ZVw
BQSirchA8l9wxaraN3VE1KQqDmGzPaAEwt1QZ5IlPcoS/EAhLwK6/cnT5RqWEFWc
xvTYDYkzjgOehUVYXUxgQ+5cSX0NZOhQi4L+8GaVWcrWY0G6C1N53PkBZoyHHiIQ
AaB+vce22EY5sUCVfECJiDr3s4jTijAtR5D1WcFBAxY+ajEqaofledVqS9onFA7m
1Rqd8RSS2AT2dkFOoktyFzqbtF+AO7MnlL3f8kVy58uQ39YBbaXe7JUctYZnR7sA
ZXVOrg5eXu3vWZlJguET4nK7QY8hTc0qqcAWYYyRRhzrwZvU2n1v2E7nAs7dp50Z
QsEE1loBqVUXzCiWh9iw
=HBuU
-----END PGP SIGNATURE-----

--Sig_/xcABbmwr+E7q1HFfR_vXSKr--
