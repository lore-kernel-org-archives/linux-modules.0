Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:63082 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeACW3e (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 3 Jan 2018 17:29:34 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules@vger.kernel.org
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 2/6] build: use tool from configure
Date: Wed,  3 Jan 2018 14:29:20 -0800
Message-Id: <20180103222924.26347-3-lucas.demarchi@intel.com>
In-Reply-To: <20180103222924.26347-1-lucas.demarchi@intel.com>
References: <20180103222924.26347-1-lucas.demarchi@intel.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This way we make sure the tool will be the one we actually configured
before going through sudo.
---
 Makefile.am  | 4 ++--
 configure.ac | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index b7ee6b1..3ea4274 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -504,5 +504,5 @@ tar-sync: kmod-$(VERSION).tar.xz kmod-$(VERSION).tar.sign
 # ------------------------------------------------------------------------------
 
 mkosi:
-	-mkdir $(top_srcdir)/testsuite/mkosi/mkosi.cache
-	mkosi -C $(top_srcdir)/testsuite/mkosi --build-sources ../../ -fi
+	-$(MKDIR_P) $(top_srcdir)/testsuite/mkosi/mkosi.cache
+	$(MKOSI) -C $(top_srcdir)/testsuite/mkosi --build-sources ../../ -fi
diff --git a/configure.ac b/configure.ac
index ca94bf8..932e87d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -31,6 +31,7 @@ AC_PROG_MKDIR_P
 AC_PROG_LN_S
 PKG_PROG_PKG_CONFIG
 AC_PATH_PROG([XSLTPROC], [xsltproc])
+AC_PATH_PROG([MKOSI], [mkosi])
 
 AC_PROG_CC_C99
 
-- 
2.14.3

