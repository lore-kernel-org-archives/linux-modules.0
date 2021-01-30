Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFC8C433DB
	for <linux-modules@archiver.kernel.org>; Sat, 30 Jan 2021 09:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA8E64E04
	for <linux-modules@archiver.kernel.org>; Sat, 30 Jan 2021 09:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhA3Jgm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:36:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:24255 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233382AbhA3DLJ (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 29 Jan 2021 22:11:09 -0500
IronPort-SDR: ky4+TjWc8H0PY9JMGA31oxUbU0sMo579mgNfiyaM/THg8XMjXUksMJVwn1UxeVVr5zEgo0GFv6
 gzJ7b0wgy/Bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="159676031"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="159676031"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:36:13 -0800
IronPort-SDR: rmDd0XLItYeCniqnCVevM4mFQPEZ57ldEd8BsOwMgkU/g4spwdWV1J1ZZhCHIB/diIQWZFkkSt
 RkWlbf2KpJ5w==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="389572779"
Received: from ggehle-mobl.amr.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.213.162.217])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:36:10 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Petr Vorel <petr.vorel@gmail.com>
Subject: [PATCH 1/2] testsuite: compress modules if feature is enabled
Date:   Fri, 29 Jan 2021 18:35:59 -0800
Message-Id: <20210130023600.24239-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Since the output needs to be the same, regardless if the module is
compressed, change populate-modules.sh to conditionally compress the
module if that feature is enabled.

This way we can execute the tests with any build-time configuration and
it should still pass.

Suggested-by: Michal Suchánek <msuchanek@suse.de>
---
 Makefile.am                   |  2 +-
 testsuite/populate-modules.sh | 27 ++++++++++++++++++---------
 testsuite/test-depmod.c       |  2 --
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index b29e943..24a586e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -249,7 +249,7 @@ CREATE_ROOTFS = $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) && mkdir -p $(dir $(ROOTFS)) &
 				find $(ROOTFS) -type d -exec chmod +w {} \; && \
 				find $(ROOTFS) -type f -name .gitignore -exec rm -f {} \; && \
 				$(top_srcdir)/testsuite/populate-modules.sh \
-					$(MODULE_PLAYGROUND) $(ROOTFS) ) && \
+					$(MODULE_PLAYGROUND) $(ROOTFS) $(top_builddir)/config.h ) && \
 				touch testsuite/stamp-rootfs
 
 build-module-playground:
diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
index b0cc932..ae43884 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/populate-modules.sh
@@ -4,6 +4,12 @@ set -e
 
 MODULE_PLAYGROUND=$1
 ROOTFS=$2
+CONFIG_H=$3
+
+feature_enabled() {
+	local feature=$1
+	grep KMOD_FEATURES  $CONFIG_H | head -n 1 | grep -q \+$feature
+}
 
 declare -A map
 map=(
@@ -99,15 +105,18 @@ done
 
 # start poking the final rootfs...
 
-# gzip these modules
-for m in "${gzip_array[@]}"; do
-    gzip "$ROOTFS/$m"
-done
-
-# zstd-compress these modules
-for m in "${zstd_array[@]}"; do
-    zstd --rm $ROOTFS/$m
-done
+# compress modules with each format if feature is enabled
+if feature_enabled ZLIB; then
+	for m in "${gzip_array[@]}"; do
+	    gzip "$ROOTFS/$m"
+	done
+fi
+
+if feature_enabled ZSTD; then
+	for m in "${zstd_array[@]}"; do
+	    zstd --rm $ROOTFS/$m
+	done
+fi
 
 for m in "${attach_sha1_array[@]}"; do
     cat "${MODULE_PLAYGROUND}/dummy.sha1" >>"${ROOTFS}/$m"
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index 261559c..d7802d7 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -25,7 +25,6 @@
 
 #include "testsuite.h"
 
-#ifdef ENABLE_ZLIB
 #define MODULES_ORDER_UNAME "4.4.4"
 #define MODULES_ORDER_ROOTFS TESTSUITE_ROOTFS "test-depmod/modules-order-compressed"
 #define MODULES_ORDER_LIB_MODULES MODULES_ORDER_ROOTFS "/lib/modules/" MODULES_ORDER_UNAME
@@ -57,7 +56,6 @@ DEFINE_TEST(depmod_modules_order_for_compressed,
 			{ }
 		},
 	});
-#endif
 
 #define SEARCH_ORDER_SIMPLE_ROOTFS TESTSUITE_ROOTFS "test-depmod/search-order-simple"
 static noreturn int depmod_search_order_simple(const struct test *t)
-- 
2.30.0

