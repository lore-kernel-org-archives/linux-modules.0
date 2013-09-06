Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41438 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750708Ab3IFN1I (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 6 Sep 2013 09:27:08 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: linux-modules@vger.kernel.org
Cc: thomas.petazzoni@free-electrons.com
Subject: [PATCHv2] Add configure check for _Static_assert()
Date: Fri,  6 Sep 2013 15:27:04 +0200
Message-Id: <1378474024-5391-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Commit 8efede20ef ("Use _Static_assert") introduced the usage of
_Static_assert(). However, _Static_assert() is a fairly new thing,
since it was introduced only in gcc 4.6. In order to support older
compilers, this patch adds a configure.in test that checks whether
_Static_assert() is usable or not, and adjust the behavior of the
assert_cc() macro accordingly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Changes since v1:
 * When _Static_assert() is not available, rely on the previously used
   sizeof() trick, as suggested by Lucas de Marchi.
---
 configure.ac    | 6 ++++++
 libkmod/macro.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/configure.ac b/configure.ac
index 40e54cf..cbe12f3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -52,6 +52,12 @@ AC_CHECK_MEMBERS([struct stat.st_mtim], [], [], [#include <sys/stat.h>])
 # Check kernel headers
 AC_CHECK_HEADERS_ONCE([linux/module.h])
 
+AC_MSG_CHECKING([whether _Static_assert() is supported])
+AC_COMPILE_IFELSE(
+	[AC_LANG_SOURCE([[_Static_assert(1, "Test");]])],
+        [AC_DEFINE([HAVE_STATIC_ASSERT], [1], [Define is _Static_assert() is available])
+	 AC_MSG_RESULT([yes])],
+	[AC_MSG_RESULT([no])])
 
 #####################################################################
 # --with-
diff --git a/libkmod/macro.h b/libkmod/macro.h
index c6ba855..10392a3 100644
--- a/libkmod/macro.h
+++ b/libkmod/macro.h
@@ -21,8 +21,13 @@
 
 #include <stddef.h>
 
+#if defined(HAVE_STATIC_ASSERT)
 #define assert_cc(expr) \
 	_Static_assert((expr), #expr)
+#else
+#define assert_cc(expr) \
+       do { (void) sizeof(char [1 - 2*!(expr)]); } while(0)
+#endif
 
 #if HAVE_TYPEOF
 #define check_types_match(expr1, expr2)		\
-- 
1.8.1.2

