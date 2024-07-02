Received: from relay1-q.mailbaby.net (relay1-q.mailbaby.net [67.217.63.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63891C3D
	for <linux-modules@vger.kernel.org>; Tue,  2 Jul 2024 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.217.63.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719899396; cv=none; b=d4vyAZc4raHDg2sKC3XnuFVjFjSl0Lo6rdzy31cwaKj5dJixawGUHgG/pWL42kOSAgvI5jQC8ilYDL3T6HkccFW5fVU/dLKRFkGbfEJI7IfBa1iIb57601H4ns9GiOuH66Q1qjtmN9Wcpbi72Sb1xmo8oJD4nb2ixRUPOm+0k8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719899396; c=relaxed/simple;
	bh=jZFHz7qk29RqwEyiJGu1UAgq5doWP0aOqvcNZeq1qyE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e9+dZfed79y9VcelLsVvLenqtSneLG9rtZu8zoMBsh66eq9XSdQhdP3uJCbYpd32R9nnLUNJn5WX6EArHZUXTHm6yKoZCZQe0jvkYiv3ONB+DMWoXLaBrbdor9Tl/xk/jUhCLkB15N2J8TitDzq2OCZa9n2+QkwTWQT6AV9HqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev; spf=fail smtp.mailfrom=agatha.dev; dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b=cEppydcu; dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b=SSgQ+pJT; arc=none smtp.client-ip=67.217.63.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=agatha.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b="cEppydcu";
	dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b="SSgQ+pJT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=kLRQSdBWD5O01x5quSpu5x32+TFH2X1iwkgzQjlFJjA=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type;
 b=cEppydcumRHOK6OYUsUc6CgWJ/jZqaWpY6ikj6FFyaRX8jcJWgVN6iMG707phaTdN1+Q38HLq
 vsGw5pdbjcXT4rF6Cf5WMOVfdgcrwi/Z+/ou1WGSznzh3JEisVIFFCjbEpb6GY+Y4Ps6ckF7HNc
 fd7pvRvlnvATGNGMP960Mlg=
Received: from mia3000.dnsiaas.com ([192.155.110.18] mia3000.dnsiaas.com)
 (Authenticated sender: mb6724)
 by relay1-q.mailbaby.net (MailBabyMTA) with ESMTPSA id 19071f93f2f0009a32.003
 for <linux-modules@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 02 Jul 2024 05:44:38 +0000
X-Zone-Loop: 5b901c33db9a0388cc15ed1dd3ac9f96f2b9c2eea9e8
X-Get-Message-Sender-Via: mb6724: authenticated_id: code@agatha.dev
X-NS-SCAN: PASS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=agatha.dev;
	s=default; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kLRQSdBWD5O01x5quSpu5x32+TFH2X1iwkgzQjlFJjA=; b=SSgQ+pJT2Yl7bYtV2EO+AWkUR2
	FSUJgsvxdh2Tyb+URU8u5J32pWw1wBQf0bTZYzlHdr7qcLSWVM/61IiMuNkZhJ1AEM2w+qTnrX/+S
	fYOcPdLrFtSquHIZmqwN6v8SrRZuA4FnY5uConT45d22leIVQgz5sx3xjdVRwxO4MAQJysGF3aLGW
	p4RGDuZjGcUmn1IDSwvUotHfBHdExtcaJ3UVK5dYW5IRxE28EUmoK1ZUEvWS+1BZYyI2TnioevqDc
	A3TUO4530o/UqOqA/JR1NXTndChf1LjluWL+qUq0BV5QHB/CDFJsKwqnXK9lxItsR9irWRlVuxY/z
	Ox7pNlkQ==;
Received: from [186.250.91.79] (port=19818 helo=kurupi-arch.blackcat)
	by mia3000.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <code@agatha.dev>)
	id 1sOWJe-00000001HnP-3X5k;
	Tue, 02 Jul 2024 01:44:35 -0400
Date: Tue, 2 Jul 2024 02:44:31 -0300
From: =?utf-8?Q?=C3=81gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
To: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>
Cc: =?utf-8?Q?=C3=81gatha?= Isabelle Chris Moreira Guedes <patch-reply@agatha.dev>, 
	Jookia <contact@jookia.org>
Subject: [PATCH] staging: Fix missing warning/taint on builtin code
Message-ID: <yf3ewok3u7fu7f4yqlcovcvedkhyjtibvwzlgbcjwf7ijcsktt@vrk54srlnk2n>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4942; i=code@agatha.dev;
 h=from:subject; bh=M0JBCO3WgTHKX1tSFWBSzLK4B1xEvuxIrpd2ceDc2cc=;
 b=owGbwMvMwCX2vcdPlI2bz4fxtFoSQ1pz70ebCxU2Be1Cu9PScgqb/szZ482lx3KG47noiWOBG
 ZUVL1o6SlkYxLgYZMUUWXjKhRO04v+kvyvaGQIzh5UJZAgDF6cATKSOmeE3u+Kjl738rt4mxs88
 c8w3XlZg5eN4cHDvscq3tw0LdzYtYWTY3j7hpX+XtIP85q8P5V9y1v//db1xpuOaZ8wfTqzXdn/
 BAgA=
X-Developer-Key: i=code@agatha.dev; a=openpgp;
 fpr=0C7713602A5FFC67EE72B954F78C4E15060B0E4C
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g43t564sfxvjtdzc"
Content-Disposition: inline
X-AuthUser: me@agatha.dev


--g43t564sfxvjtdzc
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

Signed-off-by: =C1gatha Isabelle Chris Moreira Guedes <code@agatha.dev>
---
ACKNOWLEDGEMENTS
Thanks for Jookia, heat and ukleinek for the important comments &
suggestions on this patch prior to submission.

 drivers/staging/Makefile |  2 ++
 include/linux/init.h     |  6 ++++++
 include/linux/module.h   | 33 +++++++++++++++++++++++++++++++++
 init/main.c              | 20 ++++++++++++++++++++
 kernel/module/main.c     |  4 +---
 5 files changed, 62 insertions(+), 3 deletions(-)

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
index 58cef4c2e59a..68c37600958f 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -397,4 +397,10 @@ void __init parse_early_options(char *cmdline);
 #define __exit_p(x) NULL
 #endif
=20
+#ifdef CONFIG_STAGING
+#ifndef __ASSEMBLY__
+extern void staging_taint(const char *code_id, bool module);
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_STAGING */
+
 #endif /* _LINUX_INIT_H */
diff --git a/include/linux/module.h b/include/linux/module.h
index 330ffb59efe5..ffe58f5d143b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -76,6 +76,39 @@ extern struct module_attribute module_uevent;
 extern int init_module(void);
 extern void cleanup_module(void);
=20
+#ifdef CONFIG_STAGING
+
+#define __lower_define_initcall(fn, id) ___define_initcall(fn, id, .initca=
ll##id)
+
+/**
+ * __staging_define_initcall(fn,id) - staging initialization entry point
+ * @fn: the function to run at kernel boot time
+ * @id: the initcall level
+ *
+ * __staging_define_initcall() will ensure the drive's init function is al=
ways
+ * called during initcalls for staging code by producing a wrapper functio=
n.
+ * It applies if a module from the drivers/staging subtree is builtin to t=
he
+ * kernel. It reproduces the behavior in load_module() by tainting the ker=
nel
+ * and logging a warning about the code quality.
+ */
+
+#define __staging_define_initcall(fn, id) \
+	static int __init __staging_wrapped_##fn(void) \
+	{ \
+		staging_taint(__FILE__, false); \
+		return fn(); \
+	} \
+__lower_define_initcall(__staging_wrapped_##fn, id)
+
+#ifdef STAGING_CODE
+
+#undef __define_initcall
+#define __define_initcall(fn, id) __staging_define_initcall(fn, id)
+
+#endif /* STAGING_CODE */
+
+#endif /* CONFIG_STAGING */
+
 #ifndef MODULE
 /**
  * module_init() - driver initialization entry point
diff --git a/init/main.c b/init/main.c
index 206acdde51f5..fca889f3bcc0 100644
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
+	char *code_type =3D module ? "module" : "builtin driver at";
+
+	pr_warn("%s %s: The kernel contains code from staging directory"
+		"the quality is unknown, you have been warned.\n",
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


--g43t564sfxvjtdzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQMdxNgKl/8Z+5yuVT3jE4VBgsOTAUCZoOTugAKCRD3jE4VBgsO
TPWCAPwOyNBuM1QEcscgmuuJFibaalLbh+ZZc4yb3TVJkqpGNQEAvqpNDfRaKcZJ
+PyayOxrPy9KDV4NYowEE0s3RC/32Ac=
=ReiF
-----END PGP SIGNATURE-----

--g43t564sfxvjtdzc--
