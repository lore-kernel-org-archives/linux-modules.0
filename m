Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-ye0-f181.google.com ([209.85.213.181]:52758 "EHLO
	mail-ye0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757560Ab3G3GsL (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 30 Jul 2013 02:48:11 -0400
Received: by mail-ye0-f181.google.com with SMTP id q2so1755085yen.12
        for <linux-modules@vger.kernel.org>; Mon, 29 Jul 2013 23:48:10 -0700 (PDT)
Received: from localhost.localdomain ([201.53.216.53])
        by mx.google.com with ESMTPSA id b50sm89541063yhl.1.2013.07.29.23.48.09
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 23:48:10 -0700 (PDT)
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-modules@vger.kernel.org
Subject: [PATCH 3/3] build: Install bash completion data
Date: Tue, 30 Jul 2013 03:48:15 -0300
Message-Id: <1375166895-20350-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1375166895-20350-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1375166895-20350-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

---
 Makefile.am  |  7 ++++++-
 configure.ac | 12 +++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 57b7372..91a766a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -89,6 +89,10 @@ pkgconfig_DATA = libkmod/libkmod.pc
 EXTRA_DIST += libkmod/libkmod.pc.in
 CLEANFILES += libkmod/libkmod.pc
 
+bashcompletiondir=@bashcompletiondir@
+dist_bashcompletion_DATA = \
+	shell-completion/bash/kmod
+
 install-exec-hook:
 	if test "$(libdir)" != "$(rootlibdir)"; then \
 		$(MKDIR_P) $(DESTDIR)$(rootlibdir) && \
@@ -207,7 +211,8 @@ testsuite-distclean:
 DISTCLEAN_LOCAL_HOOKS += testsuite-distclean
 EXTRA_DIST += testsuite/rootfs-pristine
 
-DISTCHECK_CONFIGURE_FLAGS=--enable-gtk-doc --sysconfdir=/etc --with-zlib
+DISTCHECK_CONFIGURE_FLAGS=--enable-gtk-doc --sysconfdir=/etc --with-zlib \
+	--with-bashcompletiondir=$$dc_install_base/$(bashcompletiondir)
 
 distclean-local: $(DISTCLEAN_LOCAL_HOOKS)
 
diff --git a/configure.ac b/configure.ac
index 194dfab..15c69d4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -82,6 +82,15 @@ AS_IF([test "x$with_zlib" != "xno"], [
 	AC_MSG_NOTICE([zlib support not requested])
 ])
 
+AC_ARG_WITH([bashcompletiondir],
+	AS_HELP_STRING([--with-bashcompletiondir=DIR], [Bash completions directory]),
+	[],
+	[AS_IF([$($PKG_CONFIG --exists bash-completion)], [
+		with_bashcompletiondir=$($PKG_CONFIG --variable=completionsdir bash-completion)
+	] , [
+		with_bashcompletiondir=${datadir}/bash-completion/completions
+	])])
+AC_SUBST([bashcompletiondir], [$with_bashcompletiondir])
 
 #####################################################################
 # --enable-
@@ -194,7 +203,7 @@ AC_CONFIG_FILES([
 AC_OUTPUT
 AC_MSG_RESULT([
 	$PACKAGE $VERSION
-	======
+	=======
 
 	prefix:			${prefix}
 	sysconfdir:		${sysconfdir}
@@ -202,6 +211,7 @@ AC_MSG_RESULT([
 	rootlibdir:		${rootlibdir}
 	includedir:		${includedir}
 	bindir:			${bindir}
+	Bash completions dir:   ${with_bashcompletiondir}
 
 	compiler:		${CC}
 	cflags:			${with_cflags} ${CFLAGS}
-- 
1.8.3.4

