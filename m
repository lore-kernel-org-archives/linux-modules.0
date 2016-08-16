Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from fmap.me ([91.92.66.84]:33940 "EHLO smtp.fmap.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbcHPA6O (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 15 Aug 2016 20:58:14 -0400
From: Nikolay Amiantov <ab@fmap.me>
To: linux-modules@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>, Nikolay Amiantov <ab@fmap.me>
Subject: [PATCH 4/4] libkmod: add --with-modulesdirs configure option
Date: Tue, 16 Aug 2016 03:50:32 +0300
Message-Id: <20160816005032.28881-5-ab@fmap.me>
In-Reply-To: <20160816005032.28881-1-ab@fmap.me>
References: <20160816005032.28881-1-ab@fmap.me>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Let the user override default /lib/modules path. One can also
define several directories to be looked in order by specifying them
separated with a colon, like this:

./configure --with-modulesdirs=/lib/modules:/usr/local/lib/modules
---
 Makefile.am       | 1 +
 configure.ac      | 6 ++++++
 libkmod/libkmod.c | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index d4eeb7e..5c9f603 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -19,6 +19,7 @@ AM_CPPFLAGS = \
 	-include $(top_builddir)/config.h \
 	-I$(top_srcdir) \
 	-DSYSCONFDIR=\""$(sysconfdir)"\" \
+	-DMODULESDIRS=\""$(shell echo $(modulesdirs) | $(SED) 's|:|\\",\\"|g')"\" \
 	${zlib_CFLAGS}
 
 AM_CFLAGS = $(OUR_CFLAGS)
diff --git a/configure.ac b/configure.ac
index 23510c8..66490cf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -202,6 +202,12 @@ GTK_DOC_CHECK([1.14],[--flavour no-tmpl-flat])
 ], [
 AM_CONDITIONAL([ENABLE_GTK_DOC], false)])
 
+AC_ARG_WITH([modulesdirs],
+	AS_HELP_STRING([--with-modulesdirs=DIRS], [Kernel modules directories, separated by :]),
+	[],
+	[with_modulesdirs=/lib/modules])
+AC_SUBST([modulesdirs], [$with_modulesdirs])
+
 
 #####################################################################
 # Default CFLAGS and LDFLAGS
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index be9358d..291c08d 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -207,7 +207,7 @@ static int log_priority(const char *priority)
 }
 
 static const char *dirname_default_prefixes[] = {
-	"/lib/modules",
+	MODULESDIRS,
 	NULL
 };
 
-- 
2.9.2

