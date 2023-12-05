Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="NWkWJRKh"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1291FBA
	for <linux-modules@vger.kernel.org>; Tue,  5 Dec 2023 07:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1701791724;
	bh=9viZOf7Ab65GVYkS2K8ZKxYov3D36a8+s/wN4VvJzZg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=NWkWJRKhpeVQzLZ6DzTokK0zXzV9dwug+8Z2J4RCm5NEsz02dnGMBnb1jYqoUkiEu
	 +pVhvAl/nba5wAWL9Rw+uHParPBRA5Bysa9a2WP06GZwG1PUrdbxAsXGByq6y0XPAJ
	 ZSXzLmjFKNDQnJH40H+0bXYdHs2jI3xTw7+Pqgx24a6Hu/IhGO2V+zlcb+dEzLfmYr
	 5WY9ot/CztnoifRvzbKOUhREXOEE4cr09iv5aE9HspsaR8mwW+ftMVUm0i/fXXkMTS
	 JYzYFa8Ed74ghhgc3OiyPnTqBMXf4t/EnME5XYRydmoNAXLuHylmbKutGLMek0axz+
	 DndultAeeqigw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id B4623129D0
	for <linux-modules@vger.kernel.org>; Tue,  5 Dec 2023 16:55:24 +0100 (CET)
Date: Tue, 5 Dec 2023 16:55:24 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: linux-modules@vger.kernel.org
Subject: [PATCH kmod 3/3] Add modprobe -I/--ignore-cmdline
Message-ID: <c302d0b1da1410dd496444f267fee6d5373dbb71.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
References: <d15ca533d7f50ffd27a11fc2fdbec8aa07659b70.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="icqj2exlsspkx7d5"
Content-Disposition: inline
In-Reply-To: <d15ca533d7f50ffd27a11fc2fdbec8aa07659b70.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103


--icqj2exlsspkx7d5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Previously, if you'd misconfigured the cmdline your system would be
completely poisoned.

In this real scenario, ixgbe.allow_supported_sfp=3D1,1,1,1 was set.
This yielded
  [ 3852.901900] ixgbe: `1,1,1,1' invalid for parameter `allow_unsupported_=
sfp'
  [ 3852.904595] ixgbe: unknown parameter 'allow_supported_sfp' ignored
and
  # modprobe -r ixgbe
  # modprobe ixgbe allow_supported_sfp=3D1
since, indeed,
  # modprobe -nv ixgbe
  insmod /lib/modules/5.16.0-1-amd64/kernel/drivers/net/ethernet/intel/ixgb=
e/ixgbe.ko allow_unsupported_sfp=3D1,1,1,1
  # modprobe -nv ixgbe allow_supported_sfp=3D1
  insmod /lib/modules/5.16.0-1-amd64/kernel/drivers/net/ethernet/intel/ixgb=
e/ixgbe.ko allow_unsupported_sfp=3D1,1,1,1 allow_supported_sfp=3D1
this leaves you with a tens-of-minutes-long reboot
(or with an explicit insmod, which no-one came up with at the time,
 and which requires manual dependency-chasing).

With -I, the module can be correctly loaded since the cmdline-derived
parameter no longer stops the module loading:
  # modprobe -nvI ixgbe allow_supported_sfp=3D1
  insmod /lib/modules/5.16.0-1-amd64/kernel/drivers/net/ethernet/intel/ixgb=
e/ixgbe.ko allow_supported_sfp=3D1
  # modprobe -I ixgbe allow_supported_sfp=3D1
  [ 4497.032342] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
  [ 4497.034624] ixgbe: Copyright (c) 1999-2016 Intel Corporation.

This in many ways mirrors -C /dev/null and -i.
You could, I s'pose, unshare -m and mount --bind /dev/null /proc/cmdline.
But you could say the same of -C in general.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 man/modprobe.xml | 16 ++++++++++++++++
 tools/modprobe.c |  9 +++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/man/modprobe.xml b/man/modprobe.xml
index 91f9e27..ab9dbb0 100644
--- a/man/modprobe.xml
+++ b/man/modprobe.xml
@@ -47,6 +47,7 @@
       <arg><option>-C <replaceable>config-file</replaceable></option></arg>
       <arg><option>-n</option></arg>
       <arg><option>-i</option></arg>
+      <arg><option>-I</option></arg>
       <arg><option>-q</option></arg>
       <arg><option>-b</option></arg>
       <arg><replaceable>modulename</replaceable></arg>
@@ -58,6 +59,7 @@
       <arg><option>-v</option></arg>
       <arg><option>-n</option></arg>
       <arg><option>-i</option></arg>
+      <arg><option>-I</option></arg>
       <arg rep=3D'repeat'><option><replaceable>modulename</replaceable></o=
ption></arg>
     </cmdsynopsis>
     <cmdsynopsis>
@@ -318,6 +320,20 @@
           </para>
         </listitem>
       </varlistentry>
+      <varlistentry>
+        <term>
+          <option>-I</option>
+        </term>
+        <term>
+          <option>--ignore-cmdline</option>
+        </term>
+        <listitem>
+          <para>
+            This option causes <command>modprobe</command> to ignore
+            any configuration specified via the kernel command line.
+          </para>
+        </listitem>
+      </varlistentry>
       <varlistentry>
         <term>
           <option>-n</option>
diff --git a/tools/modprobe.c b/tools/modprobe.c
index e891028..f0e406b 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -59,7 +59,7 @@ static int remove_holders =3D 0;
 static unsigned long long wait_msec =3D 0;
 static int quiet_inuse =3D 0;
=20
-static const char cmdopts_s[] =3D "arw:RibfDcnC:d:S:sqvVh";
+static const char cmdopts_s[] =3D "arw:RiIbfDcnC:d:S:sqvVh";
 static const struct option cmdopts[] =3D {
 	{"all", no_argument, 0, 'a'},
=20
@@ -72,6 +72,7 @@ static const struct option cmdopts[] =3D {
 	{"first-time", no_argument, 0, 3},
 	{"ignore-install", no_argument, 0, 'i'},
 	{"ignore-remove", no_argument, 0, 'i'},
+	{"ignore-cmdline", no_argument, 0, 'I'},
 	{"use-blacklist", no_argument, 0, 'b'},
 	{"force", no_argument, 0, 'f'},
 	{"force-modversion", no_argument, 0, 2},
@@ -835,6 +836,7 @@ static int do_modprobe(int argc, char **orig_argv)
 	const char *dirname =3D NULL;
 	const char *root =3D NULL;
 	const char *kversion =3D NULL;
+	int ignore_cmdline =3D 0;
 	int use_all =3D 0;
 	int do_remove =3D 0;
 	int do_show_config =3D 0;
@@ -881,6 +883,9 @@ static int do_modprobe(int argc, char **orig_argv)
 		case 'i':
 			ignore_commands =3D 1;
 			break;
+		case 'I':
+			ignore_cmdline =3D 1;
+			break;
 		case 'b':
 			use_blacklist =3D 1;
 			break;
@@ -1004,7 +1009,7 @@ static int do_modprobe(int argc, char **orig_argv)
 		dirname =3D dirname_buf;
 	}
=20
-	ctx =3D kmod_new(dirname, config_paths);
+	ctx =3D kmod_new_flags(dirname, config_paths, ignore_cmdline ? KMOD_NEW_I=
GNORE_CMDLINE : 0);
 	if (!ctx) {
 		ERR("kmod_new() failed!\n");
 		err =3D -1;
--=20
2.39.2

--icqj2exlsspkx7d5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmVvR+wACgkQvP0LAY0m
WPHrog/6Annk4bCNtJwLy9PJfmVFUp21jdkK0fFYQL0MzbKN4OVJm/mNDQR8Vvmb
9yMm/W+YLGZT0P+4ikhzB1HRIOpR4Bve+OP2zMX65H5mkz0zxWEddz8i+tndzmQh
ACrrLDK+8br1EsoJu99geaeW2YfRkEiBVQmJIRaeXM2EH9Ai/uyLmjPHKr9heUCm
FFWPqCBHKA46UTC8UDuYcHxM8bRy1sGQsdyy+YPApyx1ndgTTBTZZhEgt8G98EL8
owRqh8b3nm7ZGxgVJWzr9PKwHYVcJ3aV0lf/aCvXtk8PpX706BvJo7ZvhGtwbm/S
FBXaJxxgmIbpaPPecFVfB/o5hVPz/FucZy4RRdzi01IPNDx+vn/pnzxMwCnTxnsh
t02r/GAYQmtwpYbpw43Lge5Z2DZbOXJT9Avz7aheEWEnANiejSWXyvfQys3azz/E
/wDEFhPqmt9s51JAiRfWryhaWXONPqmN/wxVBcbj3H3pd6KImMpzFsfv+UX/Jkh+
joDnNC73lHZbJqVXkF/y/BlXyNyfe1V6FAZqGf0LkUt4mx+Mq52dM5Zne4btUfIZ
bwmZ1omX7av6MbTmskzzlP/w7F2rJDA1CsqXwqxcXrwSB5BNp/EqSVIdfA+7nA7R
35Narr4AQyZECdEbvbVyHwSY5NT8TzFhbl9wzfI7EK4x+A6zcJc=
=6r5N
-----END PGP SIGNATURE-----

--icqj2exlsspkx7d5--
