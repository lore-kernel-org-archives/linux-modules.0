Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:57413 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499AbaI2TSP (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 29 Sep 2014 15:18:15 -0400
Received: by mail-wi0-f174.google.com with SMTP id cc10so795415wib.7
        for <linux-modules@vger.kernel.org>; Mon, 29 Sep 2014 12:18:14 -0700 (PDT)
From: Thomas De Schampheleire <patrickdepinguin@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Randy MacLeod <Randy.MacLeod@windriver.com>
Subject: [PATCH] Add back-up implementation of be32toh()
Date: Mon, 29 Sep 2014 21:18:04 +0200
Message-Id: <1412018284-3411-1-git-send-email-patrickdepinguin@gmail.com>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Randy MacLeod <Randy.MacLeod@windriver.com>

Older systems may not have the be32toh function defined. Check for this
and fall back to checking the endianness and calling bswap_32 directly
if needed.  This works on both old and new systems.

[Thomas De Schampheleire <thomas.de.schampheleire@gmail.com>:
address comments raised by Lucas De Marchi [1], update commit message]
[1] http://www.spinics.net/lists/linux-modules/msg01129.html
---
 configure.ac                |    3 +++
 libkmod/libkmod-signature.c |    1 +
 libkmod/missing.h           |   10 ++++++++++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7781ce1..cd676bc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -53,6 +53,9 @@ AC_CHECK_MEMBERS([struct stat.st_mtim], [], [], [#include <sys/stat.h>])
 # musl 1.0 and bionic 4.4 don't have strndupa
 AC_CHECK_DECLS_ONCE([strndupa])
 
+# RHEL 5 and older do not have be32toh
+AC_CHECK_DECLS_ONCE([be32toh])
+
 # Check kernel headers
 AC_CHECK_HEADERS_ONCE([linux/module.h])
 
diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index a3ac15e..28f993e 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -25,6 +25,7 @@
 #include <stdio.h>
 
 #include "libkmod-internal.h"
+#include "missing.h"
 
 /* These types and tables were copied from the 3.7 kernel sources.
  * As this is just description of the signature format, it should not be
diff --git a/libkmod/missing.h b/libkmod/missing.h
index 8d47af8..4c0d136 100644
--- a/libkmod/missing.h
+++ b/libkmod/missing.h
@@ -43,3 +43,13 @@ static inline int finit_module(int fd, const char *uargs, int flags)
 		memcpy(__new, __old, __len);				\
 	 })
 #endif
+
+#if !HAVE_DECL_BE32TOH
+#include <endian.h>
+#include <byteswap.h>
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define be32toh(x) bswap_32 (x)
+#else
+#define be32toh(x) (x)
+#endif
+#endif
-- 
1.7.1

