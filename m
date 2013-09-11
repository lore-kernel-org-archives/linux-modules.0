Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from furnace.wzff.de ([176.9.216.40]:15568 "EHLO furnace.wzff.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225Ab3IKB0d (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Tue, 10 Sep 2013 21:26:33 -0400
Message-ID: <522FC4B0.8090704@barfooze.de>
Date: Wed, 11 Sep 2013 03:17:36 +0200
From: John Spencer <maillist-kmod@barfooze.de>
MIME-Version: 1.0
To: linux-modules <linux-modules@vger.kernel.org>
CC: John Spencer <maillist-kmod@barfooze.de>
Subject: [PATCH] make kmod compatible with GCC < 4.6
Content-Type: multipart/mixed;
 boundary="------------090702030600010506070301"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090702030600010506070301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hello list, find attached a patch that fixes compilation with 
non-bleeding-edge compilers (we use GCC 4.5.4 in production).

the missing C11 feature is emulated on compilers that feature a __LINE__ 
macro.

best regards
--JS

--------------090702030600010506070301
Content-Type: text/x-patch;
 name="kmod-static-assert.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kmod-static-assert.patch"

[PATCH] make kmod compatible with GCC < 4.6

--- kmod-15.org/libkmod/macro.h
+++ kmod-15/libkmod/macro.h
@@ -21,8 +21,25 @@
 
 #include <stddef.h>
 
+#if (defined(__STDC_VERSION__) && __STDC_VERSION__ +0 >= 201112L) || \
+    (defined(__GNUC__) && (__GNUC__ +0) * 10 + (__GNUC_MINOR__ +0) >= 46)
+
 #define assert_cc(expr) \
 	_Static_assert((expr), #expr)
+
+#elif defined(__LINE__)
+
+#define PASTE2__(A, B) A ## B
+#define PASTE__(A, B) PASTE2__(A, B)
+#define STATIC_ASSERT__(COND) typedef char PASTE__(static_assertion, __LINE__) [(COND)?1:-1]
+#define assert_cc(expr) \
+	STATIC_ASSERT__((expr))
+
+#else
+#warning "compiler has no support for static assertions"
+#define assert_cc(expr) do {} while(0)
+
+#endif
 
 #if HAVE_TYPEOF
 #define check_types_match(expr1, expr2)		\

--------------090702030600010506070301--
