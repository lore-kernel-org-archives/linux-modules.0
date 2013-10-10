Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15327 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264Ab3JJBJx (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 9 Oct 2013 21:09:53 -0400
From: Saul Wold <sgw@linux.intel.com>
To: linux-modules@vger.kernel.org
Cc: sgw@linux.intel.com
Subject: [PATCH] Makefile.am: Add target to all cross-compilation of testsuite
Date: Wed,  9 Oct 2013 18:09:52 -0700
Message-Id: <1381367392-11293-1-git-send-email-sgw@linux.intel.com>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

The buildtest-TESTS target allows for cross-compilation of the testsuites
without the actual running of the tests that check normally does.

Signed-off-by: Saul Wold <sgw@linux.intel.com>
---
 Makefile.am | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index c165868..e22165c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -217,6 +217,9 @@ DISTCHECK_CONFIGURE_FLAGS=--enable-gtk-doc --sysconfdir=/etc --with-zlib
 
 distclean-local: $(DISTCLEAN_LOCAL_HOOKS)
 
+buildtest-TESTS:
+	$(MAKE) $(AM_MAKEFLAGS) $(check_LTLIBRARIES) $(check_PROGRAMS)
+
 # ------------------------------------------------------------------------------
 # custom release helpers
 # ------------------------------------------------------------------------------
-- 
1.8.3.1

