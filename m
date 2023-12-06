Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="MCog+ApG"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFEEA5
	for <linux-modules@vger.kernel.org>; Wed,  6 Dec 2023 12:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1701895042;
	bh=QczK4NO5cruQMnXpYWJCk8Q9/BAGnUKBzBvc8hk0TDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MCog+ApG6bDchDEq/9CP0kxdp6PZ6OaFDZa97zie9IgABrrbJNpquUyWgCupwieU5
	 QqanT0dq3W0lH+AZyUmryZQSbL+DNhdfQ90jUvzwI+IdsyDFvp66qVqQnPMhO05iIz
	 a7Eo8MIKeLfOapAX+5aI+wCJlJm8MbGKoqkMrlHXmjumdrT50FZoB2i8x7NW8Y3iOj
	 DLfGyZOvuyoD/uwAxnyhgPpJdwc7JtfpZiwUUe01p5H6SBSfbCheMF1pMFtqnyM+Je
	 UmSucarHCpHtWGOM72jyhPRtb4w9M8Zcrj00h9Y5gsyuDkxhHfsxXZdd+MOfzTC/sc
	 gXDPbFpuLLEVA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id F197713118;
	Wed,  6 Dec 2023 21:37:21 +0100 (CET)
Date: Wed, 6 Dec 2023 21:37:21 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org
Subject: Re: [PATCH kmod 2/3] Add KMOD_NEW_IGNORE_CMDLINE
Message-ID: <z3lxzhymtgvvri2uhwylgazzlvg25junsdu4jjtxfhvfwksm3j@tarta.nabijaczleweli.xyz>
References: <d15ca533d7f50ffd27a11fc2fdbec8aa07659b70.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
 <b666b75fa732407e7e390ba27ebacaf663e93f7d.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
 <sotwbaob52hnasqhtcz7nkezh3n3t4tnt3fmbllfmsjgi6nqvj@xva63byuafir>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xehrwray7oxbuskj"
Content-Disposition: inline
In-Reply-To: <sotwbaob52hnasqhtcz7nkezh3n3t4tnt3fmbllfmsjgi6nqvj@xva63byuafir>
User-Agent: NeoMutt/20231103


--xehrwray7oxbuskj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 09:14:55AM -0600, Lucas De Marchi wrote:
> On Tue, Dec 05, 2023 at 04:55:22PM +0100, Ahelenia Ziemia=C5=84ska wrote:
> 	touch foo
> 	sudo mount --bind foo /proc/cmdline
> This has been what I always used for local/test scenarios.
This is also what I came up with post factum, but it's clearly not obvious,
since the responding user did resort to rebooting.

> I wonder if
> this really needs a more "official" way like your are doing to be
> added to the library rather than just the tools.
I don't disagree; below is a scissor-patch that effectivaly
canonicalises modprobe -I ... to be
"unshare -rm sh -c 'mount --bind /dev/null /proc/cmdline; modprobe ...'"
(the -r is removed if you're already root).

I've used this approach (exactly this snippet in various arrangements)
extensively in various test suites to string up fake procfses,
and it ought to work in all environments you'd be validly running modprobe
(it won't work if you're non-root in a chroot: unlikely).

Best,
-- >8 --
Subject: [PATCH v2] Add modprobe -I/--ignore-cmdline

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

Yes, you could do this manually with
  unshare -m; mount --bind /dev/null /proc/cmdline
but if you aren't primed to look for it,
or aren't familiar with the mechanism in the first place,
you can't

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 man/modprobe.xml | 16 ++++++++++++++++
 tools/modprobe.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

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
index e891028..de013b1 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -21,11 +21,13 @@
 #include <errno.h>
 #include <getopt.h>
 #include <limits.h>
+#include <sched.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <sys/mount.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/utsname.h>
@@ -59,7 +61,7 @@ static int remove_holders =3D 0;
 static unsigned long long wait_msec =3D 0;
 static int quiet_inuse =3D 0;
=20
-static const char cmdopts_s[] =3D "arw:RibfDcnC:d:S:sqvVh";
+static const char cmdopts_s[] =3D "arw:RiIbfDcnC:d:S:sqvVh";
 static const struct option cmdopts[] =3D {
 	{"all", no_argument, 0, 'a'},
=20
@@ -72,6 +74,7 @@ static const struct option cmdopts[] =3D {
 	{"first-time", no_argument, 0, 3},
 	{"ignore-install", no_argument, 0, 'i'},
 	{"ignore-remove", no_argument, 0, 'i'},
+	{"ignore-cmdline", no_argument, 0, 'I'},
 	{"use-blacklist", no_argument, 0, 'b'},
 	{"force", no_argument, 0, 'f'},
 	{"force-modversion", no_argument, 0, 2},
@@ -825,6 +828,32 @@ static char **prepend_options_from_env(int *p_argc, ch=
ar **orig_argv)
 	return new_argv;
 }
=20
+#define UNSHARE_REQ(...) if(!(__VA_ARGS__)) return false;
+#define UNSHARE_FILE(path, ...)   \
+	{                               \
+		FILE * f =3D fopen(path, "we"); \
+		UNSHARE_REQ(f);               \
+		fprintf(f, __VA_ARGS__);      \
+		fclose(f);                    \
+	}
+static bool clear_cmdline(void)
+{
+	int uid =3D geteuid();
+	if(uid) {
+		int gid =3D getegid();
+		UNSHARE_REQ(!unshare(CLONE_NEWUSER));
+		UNSHARE_FILE("/proc/self/setgroups", "deny");
+		UNSHARE_FILE("/proc/self/uid_map", "0 %d 1", uid);
+		UNSHARE_FILE("/proc/self/gid_map", "0 %d 1", gid);
+	}
+
+	UNSHARE_REQ(!unshare(CLONE_NEWNS));
+	UNSHARE_REQ(!mount("none", "/", NULL, MS_REC | MS_PRIVATE, NULL));
+
+	UNSHARE_REQ(!mount("/dev/null", "/proc/cmdline", NULL, MS_BIND, NULL));
+	return true;
+}
+
 static int do_modprobe(int argc, char **orig_argv)
 {
 	struct kmod_ctx *ctx;
@@ -835,6 +864,7 @@ static int do_modprobe(int argc, char **orig_argv)
 	const char *dirname =3D NULL;
 	const char *root =3D NULL;
 	const char *kversion =3D NULL;
+	int ignore_cmdline =3D 0;
 	int use_all =3D 0;
 	int do_remove =3D 0;
 	int do_show_config =3D 0;
@@ -881,6 +911,9 @@ static int do_modprobe(int argc, char **orig_argv)
 		case 'i':
 			ignore_commands =3D 1;
 			break;
+		case 'I':
+			ignore_cmdline =3D 1;
+			break;
 		case 'b':
 			use_blacklist =3D 1;
 			break;
@@ -1004,6 +1037,14 @@ static int do_modprobe(int argc, char **orig_argv)
 		dirname =3D dirname_buf;
 	}
=20
+	if (ignore_cmdline) {
+		if (!clear_cmdline()) {
+			ERR("clear_cmdline() failed!\n");
+			err =3D -1;
+			goto done;
+		}
+	}
+
 	ctx =3D kmod_new(dirname, config_paths);
 	if (!ctx) {
 		ERR("kmod_new() failed!\n");
--=20
2.39.2


--xehrwray7oxbuskj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmVw234ACgkQvP0LAY0m
WPENWw/+JX3wuRAZNUdVtIvNTJe17mTu6HbZQ7LSLtWMwU3XaUCPjh54zIGkMljK
C36U/qoZGzvesSwgjW4YtyBc3elLT57Jt9rGyQW0DR8Ru9/feBwsBGKXeb9ZA5J1
Cw7gjPu9RmNXUc2yXL5OJcqzAHpxj2fU0bfnAMISjZKNcjfHVn7N0aUKEt+LNQII
sIRgY8GLVx5xBDqfqiJeYCZq4VoMFMf8G2za5iwJrqhtDbf9tOl++HOGJl3acDjb
Qn7YICsEMS3O6IFq0XK38fp1o12stQ6IIWifL99DsT3B6mgItuuNYZtke0gfRJNH
m96JuM9LYMTEdDYz2LiFhjXMarBkhbwP5p39e53xm7SMWnE/5FwT6FzO2Jl4BPYs
CV5zBd3ktFeT30QujR99oGecwVZcQZ1eZwq9Nvxa3WrfvSkV6ScgdzAmLOYPcyJs
jLOqfQRY6f39sbpc7+TU+rjoF8dGMciqs7FZVKzbnnjDyDmnogsJZoyruBn8WvBQ
D2EcQ1PFj4tQ6qPoOCKOonF/hmBYtlMr+b8wOciWgewFZLXjjzGKjL9nuDjk1ZHm
mu+4B53gnDokE4Pk96Qp+lqe1+v6pR5QKXYAI0DknPUQ8t/iZ9O3JbNh1vBf9uX8
hrpI8lpJzPofKa2JSSBYYQkMMlFv0aPRcpsJduZBEgcji/n+UJs=
=RpRK
-----END PGP SIGNATURE-----

--xehrwray7oxbuskj--
