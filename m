Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:32962 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664Ab3JJGtu (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 10 Oct 2013 02:49:50 -0400
From: Saul Wold <sgw@linux.intel.com>
To: linux-modules@vger.kernel.org
Cc: sgw@linux.intel.com
Subject: [PATCH] Makefile.am: add mkdir testsuite
Date: Wed,  9 Oct 2013 23:49:48 -0700
Message-Id: <1381387788-5058-1-git-send-email-sgw@linux.intel.com>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

If we are note building in the existing source tree and have disabled
dependency-tracking then the testsuite directory is not created during
the configure phase and will not exist when the cp of ROOTFS_PRISTINE
occurs, thus causing an error and fail.

Signed-off-by: Saul Wold <sgw@linux.intel.com>
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 91a766a..4ff42ae 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -130,7 +130,7 @@ endif
 
 ROOTFS = testsuite/rootfs
 ROOTFS_PRISTINE = $(top_srcdir)/testsuite/rootfs-pristine
-CREATE_ROOTFS = $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) && \
+CREATE_ROOTFS = $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) && mkdir -p $(dir $(ROOTFS)) && \
 				cp -r $(ROOTFS_PRISTINE) $(ROOTFS) && \
 				touch testsuite/stamp-rootfs && \
 				find $(ROOTFS) -type d -exec chmod +w {} \; )
-- 
1.8.3.1

