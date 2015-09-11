Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36209 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895AbbIKUz7 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 11 Sep 2015 16:55:59 -0400
From: Laura Abbott <labbott@fedoraproject.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Laura Abbott <labbott@fedoraproject.org>,
	linux-modules@vger.kernel.org
Subject: [PATCH 1/4] build: Properly check for Cython
Date: Fri, 11 Sep 2015 13:55:53 -0700
Message-Id: <1442004956-3868-2-git-send-email-labbott@fedoraproject.org>
In-Reply-To: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
References: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


Cython is necessary to compile if --enable-python is used.
Currently, the configuration just sets Cython to ':' if
it isn't found. ':' is a valid command which results in
confusing build errors:

  CCLD     libkmod/libkmod.la
  CCLD     libkmod/libkmod-internal.la
ar: `u' modifier ignored since `D' is the default (see `U')
  CYTHON  libkmod/python/kmod/kmod.c
  CC       libkmod/python/kmod/libkmod_python_kmod_kmod_la-kmod.lo
gcc: error: ./libkmod/python/kmod/kmod.c: No such file or directory
gcc: fatal error: no input files

Explicitly check if cython is available and then error out
if it isn't found.
---
 configure.ac | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index d4f84bd..1648a17 100644
--- a/configure.ac
+++ b/configure.ac
@@ -162,7 +162,10 @@ AC_ARG_ENABLE([python],
 	[], [enable_python=no])
 AS_IF([test "x$enable_python" = "xyes"], [
 	AM_PATH_PYTHON(,,[:])
-	AC_PATH_PROG([CYTHON], [cython], [:])
+	AC_PATH_PROG([CYTHON], [cython], [no])
+	if test x"$CYTHON" == x"no"; then
+		AC_MSG_ERROR([Please install Cython before building])
+	fi
 
 	PKG_CHECK_MODULES([PYTHON], [python-${PYTHON_VERSION}],
 			  [have_python=yes],
-- 
2.4.3

