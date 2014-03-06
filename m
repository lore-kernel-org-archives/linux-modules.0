Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19786 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299AbaCFOFz (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 6 Mar 2014 09:05:55 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <linux-modules@vger.kernel.org>
CC: Michal Marek <mmarek@suse.cz>
Subject: [PATCH 6/8] build-sys: Do not require xsltproc for installation of man pages
Date: Thu, 6 Mar 2014 11:06:47 -0300
Message-ID: <1394114809-2737-6-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
References: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Same reason as found in this commit to systemd:

	commit 4ca39b280fce3c60d2fdecbd478fd9bf7f9d3e64
	Author: Mike Gilbert <floppym@gentoo.org>
	Date:   Sun Feb 23 11:21:13 2014 -0500

	    configure: Do not require xsltproc for installation of man pages

	    The release tarballs ship with pre-generated man pages, so we do not
	    need xsltproc for a typical end-user build.

	    Developers will probably have xsltproc anyway, but if not they will now
	    encounter a build-time failure instead of an error in configure.
---
 configure.ac | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4d9496e..54a52ea 100644
--- a/configure.ac
+++ b/configure.ac
@@ -36,6 +36,7 @@ AC_C_BIGENDIAN
 AC_PROG_SED
 AC_PROG_MKDIR_P
 PKG_PROG_PKG_CONFIG
+AC_PATH_PROG([XSLTPROC], [xsltproc])
 
 
 #####################################################################
@@ -111,10 +112,7 @@ AC_ARG_ENABLE([manpages],
         AS_HELP_STRING([--disable-manpages], [disable manpages @<:@default=enabled@:>@]),
 	[], enable_manpages=yes)
 AM_CONDITIONAL([BUILD_MANPAGES], [test "x$enable_manpages" = "xyes"])
-AC_PATH_PROG([XSLTPROC], [xsltproc], [no])
-AS_IF([test "x$XSLTPROC" = "xno" && test "x$enable_manpages" = "xyes"], [
-	AC_MSG_ERROR([xsltproc command not found, try ./configure --disable-manpages])
-])
+AS_IF(["x$enable_manpages" != "xno"], ["have_manpages=yes"])
 
 AC_ARG_ENABLE([logging],
 	AS_HELP_STRING([--disable-logging], [disable system logging @<:@default=enabled@:>@]),
-- 
1.9.0

