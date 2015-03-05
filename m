Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59389 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964931AbbCEQIh (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 5 Mar 2015 11:08:37 -0500
From: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
To: <linux-modules@vger.kernel.org>
Subject: [PATCH 1/3] testsuite: remove .gitignore files when populating rootfs
Date: Thu, 5 Mar 2015 13:06:37 -0300
Message-ID: <1425571599-26032-1-git-send-email-caio.oliveira@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Usually this file is added to keep a directory existing in the
repository but without any real content. In rootfs this can be
problematic if a directory will have all its files inspected. This
happens for kmod_module_get_holders().

Side-note: the 'test-loaded.c' is hit by this problem but doesn't
"notice" because the invalid module returned by get_holders() is not
checked. The modules in its loop are only used to get the name and
generate an output, and NULL was a valid value to generate the name.
---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 896ae63..d9da17d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -216,6 +216,7 @@ ROOTFS_PRISTINE = $(top_srcdir)/testsuite/rootfs-pristine
 CREATE_ROOTFS = $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) && mkdir -p $(dir $(ROOTFS)) && \
 				cp -r $(ROOTFS_PRISTINE) $(ROOTFS) && \
 				find $(ROOTFS) -type d -exec chmod +w {} \; && \
+				find $(ROOTFS) -type f -name .gitignore -exec rm -f {} \; && \
 				$(top_srcdir)/testsuite/populate-modules.sh \
 					$(MODULE_PLAYGROUND) $(ROOTFS) ) && \
 				touch testsuite/stamp-rootfs
-- 
2.3.0

