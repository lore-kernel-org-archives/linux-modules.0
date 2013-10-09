Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43126 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753532Ab3JIWxs (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 9 Oct 2013 18:53:48 -0400
From: Saul Wold <sgw@linux.intel.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH] Makefile.am: add mkdir testsuite and standaline build target
Date: Wed,  9 Oct 2013 15:53:47 -0700
Message-Id: <1381359227-29867-1-git-send-email-sgw@linux.intel.com>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

If we are not building in the existing source tree, the testsuite
directory will not exist so the cp of the stamp-rootfs would fail.

Also added buildtest-TESTS so they could be build in the cross env,
without running the tests.

Signed-off-by: Saul Wold <sgw@linux.intel.com>
---
 Makefile.am | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index c165868..018e6ed 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -131,7 +131,7 @@ endif
 
 ROOTFS = testsuite/rootfs
 ROOTFS_PRISTINE = $(top_srcdir)/testsuite/rootfs-pristine
-CREATE_ROOTFS = $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) && \
+CREATE_ROOTFS = $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) && mkdir -p $(dir $(ROOTFS)) && \
 				cp -r $(ROOTFS_PRISTINE) $(ROOTFS) && \
 				touch testsuite/stamp-rootfs && \
 				find $(ROOTFS) -type d -exec chmod +w {} \; )
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

