Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:45177 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760160Ab3LIBxt (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Sun, 8 Dec 2013 20:53:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 3E4C133F24A
	for <linux-modules@vger.kernel.org>; Mon,  9 Dec 2013 01:53:49 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: linux-modules@vger.kernel.org
Subject: [PATCH] add a flag to control linking of internal kmod library
Date: Sun,  8 Dec 2013 20:53:52 -0500
Message-Id: <1386554032-5877-1-git-send-email-vapier@gentoo.org>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

We shouldn't be penalizing everyone because some distros' initramfs
tooling sucks.  So add a configure flag for controlling the linkage
of the internal kmod library and default it to off.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 Makefile.am  | 8 ++++++--
 configure.ac | 5 +++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index bdf758e..ee89ab1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -116,8 +116,12 @@ tools_kmod_SOURCES = tools/kmod.c tools/kmod.h tools/lsmod.c \
 		     tools/modinfo.c tools/modprobe.c \
 		     tools/depmod.c tools/log.h tools/log.c \
 		     tools/static-nodes.c
-tools_kmod_LDADD = libkmod/libkmod-util.la \
-		   libkmod/libkmod-internal.la
+tools_kmod_LDADD = libkmod/libkmod-util.la
+if ENABLE_INTERNAL_STATIC
+tools_kmod_LDADD += libkmod/libkmod-internal.la
+else
+tools_kmod_LDADD += libkmod/libkmod.la
+endif
 
 ${noinst_SCRIPTS}: tools/kmod
 	$(AM_V_GEN) ($(RM) $@; \
diff --git a/configure.ac b/configure.ac
index 5b484d6..fe83541 100644
--- a/configure.ac
+++ b/configure.ac
@@ -102,6 +102,11 @@ AC_SUBST([bashcompletiondir], [$with_bashcompletiondir])
 # --enable-
 #####################################################################
 
+AC_ARG_ENABLE([internal-static],
+        AS_HELP_STRING([--enable-internal-static], [enable static linking of internal kmod libraries for simple initramfs usage @<:@default=disabled@:>@]),
+	[], enable_internal_static=no)
+AM_CONDITIONAL([ENABLE_INTERNAL_STATIC], [test "x$enable_internal_static" = "xyes"])
+
 AC_ARG_ENABLE([tools],
         AS_HELP_STRING([--disable-tools], [disable building tools that provide same functionality as module-init-tools @<:@default=enabled@:>@]),
 	[], enable_tools=yes)
-- 
1.8.4.3

