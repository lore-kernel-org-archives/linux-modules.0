Received: from relay1-v.mailbaby.net (relay1-v.mailbaby.net [205.209.127.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78BBC8E9
	for <linux-modules@vger.kernel.org>; Sat,  6 Jul 2024 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.209.127.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720236025; cv=pass; b=bR7WZkmO/7tHjUBPjbVsRug18eJ/x1I2t6Gv+3Ez3CCkbdlKG2UmxEBclQaqQdbRRpSEU5pQjVWyVhBOlWqJHfl/JyY51RcbJFNTuMTtHPr6PtuOHa0I5rrMKhm4haai4LLjo4lF9K2gVcryMnY+yylb3OnXP3sSZHAoI5PMckI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720236025; c=relaxed/simple;
	bh=4ep5+8AkBid+sCO/TyPnryHDWWr5VFv9luh4OOI6b/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N1hpGxN2Yn+qu5JGsQHapjOYsiPoTJfDbyy6XT1uy7FIxFzpSADYE3MqoZmhDxHlIcBBLzomFJHv8Wbi1Mls++z1TFie0bkxG4lQ3oTqJXdl1sNszD6Zwbcs8HIXbQlGADJbCUpSuVdIsHpRCPMQUEUzkLxt2D8UdL9NOlZc8os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev; spf=fail smtp.mailfrom=agatha.dev; dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b=Pgc7SMe7; dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b=NLYvE2/0; arc=pass smtp.client-ip=205.209.127.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=agatha.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b="Pgc7SMe7";
	dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b="NLYvE2/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=epiaVvOA15QK2Ysa3FT/IPGTWs6jUTlcGOuKsi0N74o=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type;
 b=Pgc7SMe7Q3gtAu0wozIyp1bzAeoyE84n/6MyEGR8tnHQsrlhar41FvA/Cul53Y9My2IL5odwx
 QiD78/evp1ZtFC14mWoO80btUGZ6WnD/3xt2eP/oYemCBaDb650b+uzrSHR1NDHTiU5cksbkzIO
 GwpZ+C6XHsQcUsXMgOtCSw0=
Received: from mia3000.dnsiaas.com ([192.155.110.18] mia3000.dnsiaas.com)
 (Authenticated sender: mb6724)
 by relay1-v.mailbaby.net (MailBabyMTA) with ESMTPSA id 1908609dc8900051fb.004
 for <linux-modules@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 06 Jul 2024 03:15:11 +0000
X-Zone-Loop: 5c838fd613db7fce6b06f86e8318deee16cbf30ab36e
X-Get-Message-Sender-Via: mb6724: authenticated_id: code@agatha.dev
ARC-Authentication-Results: i=1;	rspamd6.mailbaby.net;	auth=pass
 smtp.auth=mb6724 smtp.mailfrom=code@agatha.dev
ARC-Seal: i=1; s=detka; d=mailbaby.net; t=1720235712; a=rsa-sha256;
	cv=none;
	b=C0jB+Jj3SayJ0AEU0sijKP2Cvw9wyeOsg5+qhXrZMaqal7cvJ57Dhke3dGkE/k0guSTlza
	v7PKfUiNwsVh9x12axU2WcGUSeuGaOZDzOnFk+lGmEnZ3u5iwMkD38UU6q5Oh8/cgJ67PW
	5tC5latBp9YBIAciHHUgaMdRwVGqE/n5XszRMme/AEX1Gfndy/gXPReHxLd/OkDalpDgG4
	rraZqYtuJYc5rhmfJfg42En3VkSmP9wE5Tnhw04Ha5luMNOuy3gF865w8hUvbrA4flYSDO
	U3RaQzHrXChJ7RlNmTyu3mZzCyZOYVy3P8sjo2SBsFgnx/t2sp5FkdDLAuFwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbaby.net;	s=detka; t=1720235712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=epiaVvOA15QK2Ysa3FT/IPGTWs6jUTlcGOuKsi0N74o=;
	b=dmHfkEE66uwF+Q+TQpR/gbTdslpm5ELmTPSEFEa/mKpVAB7443DoEEgQfF3LCkXw7gfdQc
	UlDVAqYOLJgL+KXh+2D5EV3hdxesj9xut8Q4myHghwa3pXPv4WxMTtEqeZ74Y15HamXtEo
	shTm4DLq9Vk9tdmH0iVJlw+jnnnUa+xkvOOBOVlw2O5tt2MuUVI78s9VS3TwAlw+WvBZHL
	UKtjC5+wo8OTQ0uVay+vNb2dXU5QyeWX+bSYL5OJssTb3k7TURmxAvuhFQJ1y5+ndHYTym
	bL5x6l+OWNSwwAmm+VigYoV5WW6jptmvPPI5bMeeJIlB44JKXjinFZSc/El6dg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=agatha.dev;
	s=default; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=epiaVvOA15QK2Ysa3FT/IPGTWs6jUTlcGOuKsi0N74o=; b=NLYvE2/071nMtlFigMDlQO4JHG
	8R7qe+ghqa3sx52sy/MbMfcntSS+kQuECVQLHK7J8WdLG4RIjWwlI22pO5hSiZiEEEUQr2s3FU1B7
	02QUVZPyxealz4TwFvZ2wM5B7Z4ikdYwtRvZ4ZWcWKqzQKWYed9VmcECKa0PjpxMB9uA6fLRYAe99
	VqS/3eAq2wdPebbukmVFyswnrKo9Az20ga27CHpNJuw5aHwBoGHPjKkLjMpknjb3o79A+JOF/rkXX
	TNKB6p0Go0tKurXBvTrRX0Yu2C2g5RQZYuQyLTuxEoDst+uNON23tlGrqLFWOHzpxhi5cAAGIab1D
	FjzVY1Sw==;
Received: from [186.250.91.79] (port=19853 helo=kurupi-arch.blackcat)
	by mia3000.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <code@agatha.dev>)
	id 1sPvtB-00000002xKn-0jII;
	Fri, 05 Jul 2024 23:15:05 -0400
Date: Sat, 6 Jul 2024 00:15:01 -0300
From: =?utf-8?Q?=C3=81gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, patch-reply@agatha.dev
Subject: [PATCH v3] init: staging: Fix missing warning/taint on builtin code
Message-ID: <zsk54zosv6tht4j4nma4ix7lq2knxi3ylqadd2foznc72nkaa3@xbc7gpozx6ai>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7027; i=code@agatha.dev;
 h=from:subject; bh=2N64iY0WzzrYpa0gGuys+S2/an0+U6QK2sl6yQ5X708=;
 b=owGbwMvMwCX2vcdPlI2bz4fxtFoSQ1rH+tkzQpKPXzfqip2QJfzzte7U3wxtHJ/MzT5M+yBWf
 +N52dP9HaUsDGJcDLJiiiw85cIJWvF/0t8V7QyBmcPKBDKEgYtTACbysYThf+Hl5ebuG/+qXdc6
 u4E396CX4kXX3dM91WQe2qzKnCwj7c3IcGLmoRnRiodCUvx3ih6Y9d2975d7an2K9FKjVy8/O3W
 s5QIA
X-Developer-Key: i=code@agatha.dev; a=openpgp;
 fpr=0C7713602A5FFC67EE72B954F78C4E15060B0E4C
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vnmlwtyqmbxxnyuw"
Content-Disposition: inline
X-AuthUser: me@agatha.dev


--vnmlwtyqmbxxnyuw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix the absence of warning message and kernel tainting when initializing
drivers from the `drivers/staging` subtree from initcalls (when
configured as built-in).

When such a driver is built as module and the module is loaded, the
`load_module()` function taints the kernel to signal code of unknown
quality is loaded, and produces a warning like this:

[    8.076352] rts5208: module is from the staging directory, the
quality is unknown, you have been warned.

The same behaviour is absent, however, when a staging driver is compiled
as built-in on the kernel image, since loading it happens through
initcalls and not through load_module().

This might prevent relevant information of being available on a bug
report (i.e. on a panic log) among other possible problems.

NOTES:
- The patch is written in such a way that all non-staging drivers are
  kept the way they were, except for staging drivers built with
  `-DSTAGING_CODE`.
- Since it changes some macros related to clang LTO as well, I tested it
  and it works properly in kernels compiled with both clang and gcc.
- Some `checkpatch.pl` errors, warnings and checks (with `--strict`) are
  present. Some were already there, some I introduced but I think
  they're unavoidable. Some IMHO don=B4t make sense at all, I think they
  would apply for most regular macros but initcall macros are just way
  different.

Fixes: 061b1bd394ca ("Staging: add TAINT_CRAP for all drivers/staging code")
Signed-off-by: =C1gatha Isabelle Chris Moreira Guedes <code@agatha.dev>
---
CHANGELOG
v3:
- Added some missing suggestions from Uwe's suggestions after I detected
  the oversight (the Fixes: tag).
- I also noticed a possible build break, so I removed the
  `#ifdef CONFIG_STAGING` enclosuring the definition of
  `staging_taint()`.
- Improved again the string details after further explanation of Dan's
  original suggestion in v2.

v2:
- Changed the way we hook into the initcalls as suggested by Uwe, and
  moved the logic from `include/linux/module.h` to
  `include/linux/init.h`.
- Adjusted accordingly to work with both GCC and clang with
  `CONFIG_LTO_CLANG=3Dy`, since some init scripts required that.
- Fixed the missing space pointed out by Dan & other minor string
  details.
- Changed the subject, since it became somewhat more of an init thing
  than a staging thing.

 drivers/staging/Makefile |  2 ++
 include/linux/init.h     | 76 ++++++++++++++++++++++++++++++++++------
 init/main.c              | 18 ++++++++++
 kernel/module/main.c     |  4 +--
 4 files changed, 86 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 5390879b5d1b..7cea13436426 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for staging directory
=20
+subdir-ccflags-y +=3D -DSTAGING_CODE
+
 obj-y				+=3D media/
 obj-$(CONFIG_FB_OLPC_DCON)	+=3D olpc_dcon/
 obj-$(CONFIG_RTL8192E)		+=3D rtl8192e/
diff --git a/include/linux/init.h b/include/linux/init.h
index 58cef4c2e59a..c7afee978b42 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -188,6 +188,8 @@ extern struct module __this_module;
=20
 #ifndef __ASSEMBLY__
=20
+extern void staging_taint(const char *code_id, bool module);
+
 /*
  * initcalls are now grouped by functionality into separate
  * subsections. Ordering inside the subsections is determined
@@ -220,6 +222,14 @@ extern struct module __this_module;
 	__PASTE(__,						\
 	__PASTE(__iid, id))))
=20
+#define __define_stub_fn(___stub, fn, __taintcall)		\
+	int __init ___stub(void);				\
+	int __init ___stub(void)				\
+	{							\
+		__taintcall();					\
+		return fn();					\
+	}							\
+
 #ifdef CONFIG_LTO_CLANG
 /*
  * With LTO, the compiler doesn't necessarily obey link order for
@@ -230,31 +240,75 @@ extern struct module __this_module;
 #define __initcall_section(__sec, __iid)			\
 	#__sec ".init.." #__iid
=20
+#define ___define_initcall_stub(__stub, fn, __taintcall)	\
+	__define_stub_fn(__stub, fn, __taintcall)		\
+	__ADDRESSABLE(__stub)
+#else
+#define __initcall_section(__sec, __iid)			\
+	#__sec ".init"
+
+#define ___define_initcall_stub(__stub, fn, __taintcall)	\
+	__ADDRESSABLE(fn)
+#endif /* CONFIG_LTO_CLANG */
+
+#ifdef STAGING_CODE
+
 /*
  * With LTO, the compiler can rename static functions to avoid
  * global naming collisions. We use a global stub function for
  * initcalls to create a stable symbol name whose address can be
  * taken in inline assembly when PREL32 relocations are used.
+ *
+ * Moreover, when there's staging code, regardless of LTO, we
+ * need to wrap the function inside a new one to taint the
+ * kernel and warn about it in the log. So we need this special
+ * symbol name for the wrapper regardless of that.
  */
 #define __initcall_stub(fn, __iid, id)				\
 	__initcall_name(initstub, __iid, id)
=20
+#define __staging_taint_fn()					\
+	staging_taint(KBUILD_MODNAME, false)
+
+#ifdef CONFIG_LTO_CLANG
+
 #define __define_initcall_stub(__stub, fn)			\
-	int __init __stub(void);				\
-	int __init __stub(void)					\
-	{ 							\
-		return fn();					\
-	}							\
-	__ADDRESSABLE(__stub)
-#else
-#define __initcall_section(__sec, __iid)			\
-	#__sec ".init"
+	___define_initcall_stub(__stub, fn, __staging_taint_fn)
+
+#else /* no CONFIG_LTO_CLANG */
+
+#define __define_initcall_stub(_stub, fn)			\
+	__define_stub_fn(_stub, fn, __staging_taint_fn)		\
+	__ADDRESSABLE(_stub)
+
+#endif /* CONFIG_LTO_CLANG */
+
+#else /* no STAGING_CODE */
+
+#ifdef CONFIG_LTO_CLANG
+
+/*
+ * Same case as before, it's not staging code but there's LTO
+ */
+#define __initcall_stub(fn, __iid, id)				\
+	__initcall_name(initstub, __iid, id)
=20
+#else /* no CONFIG_LTO_CLANG*/
+
+/* For no LTO outside staging code, the vast majority of drivers
+ * can just be built with their regular symbol names as they
+ * just have been built all the time
+ */
 #define __initcall_stub(fn, __iid, id)	fn
=20
+#endif /* CONFIG_LTO_CLANG */
+
+#define __staging_taint_fn()
+
 #define __define_initcall_stub(__stub, fn)			\
-	__ADDRESSABLE(fn)
-#endif
+	___define_initcall_stub(__stub, fn, __staging_taint_fn)
+
+#endif /* STAGING_CODE */
=20
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
 #define ____define_initcall(fn, __stub, __name, __sec)		\
diff --git a/init/main.c b/init/main.c
index 206acdde51f5..e35eeec1fbe4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1602,3 +1602,21 @@ static noinline void __init kernel_init_freeable(voi=
d)
=20
 	integrity_load_keys();
 }
+
+/**
+ * staging_init_taint() - We need to taint the kernel whenever staging code
+ * is initialized (from built-in drivers) or loaded (as modules) and issue
+ * a warning the first time it happens.
+ */
+void staging_taint(const char *code_id, bool module)
+{
+	char *code_type =3D module ? "module" : "builtin driver";
+
+	pr_warn("%s %s: The kernel contains code from staging directory, "
+		"the quality is unknown, you have been warned.\n",
+		code_type, code_id);
+
+	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
+}
+EXPORT_SYMBOL(staging_taint);
+
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d18a94b973e1..d7d33336ab43 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2039,9 +2039,7 @@ static void module_augment_kernel_taints(struct modul=
e *mod, struct load_info *i
 	check_modinfo_retpoline(mod, info);
=20
 	if (get_modinfo(info, "staging")) {
-		add_taint_module(mod, TAINT_CRAP, LOCKDEP_STILL_OK);
-		pr_warn("%s: module is from the staging directory, the quality "
-			"is unknown, you have been warned.\n", mod->name);
+		staging_taint(mod->name, true);
 	}
=20
 	if (is_livepatch_module(mod)) {
--=20
2.45.2


--vnmlwtyqmbxxnyuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQMdxNgKl/8Z+5yuVT3jE4VBgsOTAUCZoi2rwAKCRD3jE4VBgsO
TB90AP0XRBi9BPtaDpj4qwSgH06Ig8tX6A7U42NwKsM7FyH1pwD/W6U5tl6K6prj
Y/NtFWow1IfUb5yQLkrbJMutIwOKWAk=
=ZLxQ
-----END PGP SIGNATURE-----

--vnmlwtyqmbxxnyuw--
