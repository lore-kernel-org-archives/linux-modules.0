Received: from relay2-q.mailbaby.net (relay2-q.mailbaby.net [68.168.211.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7091862
	for <linux-modules@vger.kernel.org>; Fri,  5 Jul 2024 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.168.211.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720139184; cv=none; b=jLqfcMbJtst5+90qfbIycLQgRr5traUNMAUzuD6h9rvj/iM0ZpNUjEX18doVlkx7e/T/e0AXsaWdjh+2IaitdLDpFdSIjA4/lVlIxhuM8QsUPsmDc9EU7Idz4yzhgXxk6tdnLLqE8vGTSVvKwYshQebv533DJ92Oc40AX3QAiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720139184; c=relaxed/simple;
	bh=FBpbhAGsRerAZotohFT3bTnT7U4BB4jCQI2eb3VtOm8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i6hEXB8JHy5SIngQ1pY+A82zqMOdwxOv+JLsqddGsP5kzKuM/aeM24Gyp2Oha/YZJE5XUBq0IfK49H5VFWtuOAbm9jlFWUlUdjzAOnemoGdv3lK4BKRRBa0yeLb1OcHaNNxJVQyFIk3Mh4oLdFF9oawfdQqvCLezW0ZZyWvO+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev; spf=fail smtp.mailfrom=agatha.dev; dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b=SYgaGYaX; dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b=wxh2VTmq; arc=none smtp.client-ip=68.168.211.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=agatha.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b="SYgaGYaX";
	dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b="wxh2VTmq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=lbCCbfpAK9yQ72EmN2rHBfOcaxTYvE1fdr8yXnyWw+8=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type;
 b=SYgaGYaX9SbpjXjhN9Id9yI3It6QYm4ooviJ4u0K0kfPMUFuSZlEeWsoB700YnGZuCIiS5Wpl
 am9A9GNahVazC76NACpwoZBxac7c+HzISz6a/6YXUi+xwsrx9v/oZ4C40DXkQwLC+HbI2e8rOlN
 QW/m0k45v0EeYwmuyzlXgWQ=
Received: from mia3000.dnsiaas.com ([192.155.110.18] mia3000.dnsiaas.com)
 (Authenticated sender: mb6724)
 by relay2-q.mailbaby.net (MailBabyMTA) with ESMTPSA id 1908043f1df000336f.004
 for <linux-modules@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 05 Jul 2024 00:20:54 +0000
X-Zone-Loop: 17c20a73d7fe5e72aae7d1efb8ce12247b08a661613a
X-Get-Message-Sender-Via: mb6724: authenticated_id: code@agatha.dev
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=agatha.dev;
	s=default; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lbCCbfpAK9yQ72EmN2rHBfOcaxTYvE1fdr8yXnyWw+8=; b=wxh2VTmq2x1nEFIlpEZvlpcLfD
	Rvd3kmAYMSTimLlaXGjenKoxJvETMuksrms29zCw7VYz/qMWyHNXtMq9XxIP0luFkkAQ9YP5fsmb1
	Dt+2l2XkW8UqniJzpFH1rbMcxxePohfSeXTWsGb7P3BJ9G2TW1J7a9jsFHTPhWEpPrWtWDekueERa
	785fL5GbOCf+iU21lW6tSFTIirliFvcgOMNzIEJcxrajKS66804joO2A6DqpNyGcKIyg7ZLNvUtDV
	IMoSdM3sDh9PkJxqqaCh4MoFhCFO8cxDS+ID4Nsng3doBHA0ElKsXDgoqOHfCuA4lEsFgj1kbMoIm
	NKiYOO/w==;
Received: from [186.250.91.79] (port=20444 helo=kurupi-arch.blackcat)
	by mia3000.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <code@agatha.dev>)
	id 1sPWh2-00000007ihG-08yn;
	Thu, 04 Jul 2024 20:20:52 -0400
Date: Thu, 4 Jul 2024 21:20:49 -0300
From: =?utf-8?Q?=C3=81gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, patch-reply@agatha.dev
Subject: [PATCH v2] init: staging: Fix missing warning/taint on builtin code
Message-ID: <n5plxnkubcnbuyv7l24i4cwsauh4odwk6g5yiys6oiiwj3i34r@izcjggvv2om2>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7004; i=code@agatha.dev;
 h=from:subject; bh=s8si9TH2BBN48BhHEG1UljdI8wlTApNCHVg3kyKmO3A=;
 b=owGbwMvMwCX2vcdPlI2bz4fxtFoSQ1q7quvtuNnra3cGZV5/8OPVFTmzwsP2bItK1386H3C6u
 al5gcrejlIWBjEuBlkxRRaecuEErfg/6e+KdobAzGFlAhnCwMUpABNxc2P4Z1Sx+7RjdaqB0eXp
 eWu1GpI4jLTvdGQdd3hyyH337rXlPQz/MyzXvldyYOrZoJS2Wk5F5sTFGTW7a3ttym5u3vZ6oY4
 RNwA=
X-Developer-Key: i=code@agatha.dev; a=openpgp;
 fpr=0C7713602A5FFC67EE72B954F78C4E15060B0E4C
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="joaqmbrrn46rr3ud"
Content-Disposition: inline
X-AuthUser: me@agatha.dev


--joaqmbrrn46rr3ud
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

Signed-off-by: =C1gatha Isabelle Chris Moreira Guedes <code@agatha.dev>
---
CHANGELOG
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
 init/main.c              | 20 +++++++++++
 kernel/module/main.c     |  4 +--
 4 files changed, 88 insertions(+), 14 deletions(-)

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
index 206acdde51f5..a297675dd397 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1602,3 +1602,23 @@ static noinline void __init kernel_init_freeable(voi=
d)
=20
 	integrity_load_keys();
 }
+
+#ifdef CONFIG_STAGING
+/**
+ * staging_init_taint() - We need to taint the kernel whenever staging code
+ * is initialized (from built-in drivers) or loaded (as modules) and issue
+ * a warning the first time it happens.
+ */
+void staging_taint(const char *code_id, bool module)
+{
+	char *code_type =3D module ? "module" : "builtin driver";
+
+	pr_warn("%s %s: The kernel contains code from staging directory"
+		", the quality is unknown, you have been warned.\n",
+		code_type, code_id);
+
+	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
+}
+EXPORT_SYMBOL(staging_taint);
+
+#endif /* CONFIG_STAGING */
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


--joaqmbrrn46rr3ud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQMdxNgKl/8Z+5yuVT3jE4VBgsOTAUCZoc8WAAKCRD3jE4VBgsO
TAv9AP4gR/WH9Mpl8+MCf19elx1EHvHiMwTuH/+P+ipUxsAR0gD/TS7Hk98Kqzb/
PnHqZnRxEka6FUZIyEUy419SnxBXHwY=
=E+nt
-----END PGP SIGNATURE-----

--joaqmbrrn46rr3ud--
