Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A96C433E0
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 14:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFBA64D99
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 14:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhA1Ou3 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 28 Jan 2021 09:50:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:26919 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232417AbhA1Osb (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 28 Jan 2021 09:48:31 -0500
IronPort-SDR: RZuQ5X0C2l2077sWcmauMel01oYo/1CJZmOXtjTXpbW79LI+7wz8Xzt5TpuZBIH0xrIwCdbPaM
 9HYeweIZcrYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="176735461"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="176735461"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 06:47:47 -0800
IronPort-SDR: v5TtMa2jDMJsgKv05gMD1nScS3ix+NReZBJamthNewp7vLCsR1OIMuuSVVUXqLQTjWXotGjeiZ
 HTmYbqN7keVA==
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="505330555"
Received: from tnachmax-mobl1.ger.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.213.186.171])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 06:47:44 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Petr Vorel <petr.vorel@gmail.com>
Subject: [PATCH 1/2] testsuite: use skip for modules-order-compressed
Date:   Thu, 28 Jan 2021 06:47:23 -0800
Message-Id: <20210128144724.102147-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Instead of removing the test completely, use the new skip infra to skip
that test.
---
 testsuite/test-depmod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index 261559c..d52602d 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -25,7 +25,6 @@
 
 #include "testsuite.h"
 
-#ifdef ENABLE_ZLIB
 #define MODULES_ORDER_UNAME "4.4.4"
 #define MODULES_ORDER_ROOTFS TESTSUITE_ROOTFS "test-depmod/modules-order-compressed"
 #define MODULES_ORDER_LIB_MODULES MODULES_ORDER_ROOTFS "/lib/modules/" MODULES_ORDER_UNAME
@@ -42,7 +41,8 @@ static noreturn int depmod_modules_order_for_compressed(const struct test *t)
 }
 
 DEFINE_TEST(depmod_modules_order_for_compressed,
-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+#if defined(KMOD_SYSCONFDIR_NOT_ETC) || \
+    !defined(ENABLE_ZLIB)
         .skip = true,
 #endif
 	.description = "check if depmod let aliases in right order when using compressed modules",
-- 
2.30.0

