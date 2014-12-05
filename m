Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:33567 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933000AbaLEAtU (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 4 Dec 2014 19:49:20 -0500
Received: from [192.168.188.1] (82-69-24-248.dsl.in-addr.zen.co.uk [82.69.24.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ikelos)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 5C505340299
	for <linux-modules@vger.kernel.org>; Fri,  5 Dec 2014 00:49:19 +0000 (UTC)
Message-ID: <54810109.7030409@gentoo.org>
Date: Fri, 05 Dec 2014 00:49:13 +0000
From: Mike Auty <ikelos@gentoo.org>
MIME-Version: 1.0
To: linux-modules@vger.kernel.org
Subject: [PATCH] build: Do not force diagnostics-color flag
Content-Type: text/plain; charset=utf-8
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

The -fdiagnostics-color flag is only available on GCC >= 4.9, for
older versions this could raise an error in certain circumstances
(such as when using ccache).  Instead, since -fdiagnostic-color=auto
by default  in gcc-4.9, simply set the required environment variable
to the default one if it's undefined.

Based mostly on the systemd commit f44541bc by Michal Schmidt.
---
 Makefile.am  | 3 +++
 configure.ac | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index ea5cbac..51825f0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -11,6 +11,9 @@ BUILT_FILES =
 ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
 AM_MAKEFLAGS = --no-print-directory

+GCC_COLORS ?=
'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
+export GCC_COLORS
+
 AM_CPPFLAGS = \
 	-include $(top_builddir)/config.h \
 	-I$(top_srcdir)/libkmod \
diff --git a/configure.ac b/configure.ac
index 2709f08..f28bfed 100644
--- a/configure.ac
+++ b/configure.ac
@@ -201,7 +201,6 @@ CC_CHECK_FLAGS_APPEND(with_cflags, [CFLAGS], [\
 		       -Wuninitialized \
 		       -fno-common \
 		       -fdiagnostics-show-option \
-		       -fdiagnostics-color=auto \
 		       -fvisibility=hidden \
 		       -ffunction-sections \
 		       -fdata-sections])
-- 
2.2.0
