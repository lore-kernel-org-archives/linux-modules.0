Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931BFC4361B
	for <linux-modules@archiver.kernel.org>; Fri, 18 Dec 2020 16:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4956A23B6C
	for <linux-modules@archiver.kernel.org>; Fri, 18 Dec 2020 16:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgLRQDP (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:03:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:59177 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbgLRQDP (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 18 Dec 2020 11:03:15 -0500
IronPort-SDR: +Z4oRpbjrgptmSeeSe4Iw3QPUFOzRYbgChrCPIx/ZEY3wLl6FFS5bFvWh3rb6K/bP582G6TtKR
 FXosenADRf/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="155257958"
X-IronPort-AV: E=Sophos;i="5.78,430,1599548400"; 
   d="scan'208";a="155257958"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 08:02:16 -0800
IronPort-SDR: Y20jIAu+qcDm3SNJV2Y1y4NZAlMt3dVnqugzaw1Ob7epV/YUMFEht0HMueISWcOVGmDF61powg
 L4pkfBFLjB9A==
X-IronPort-AV: E=Sophos;i="5.78,430,1599548400"; 
   d="scan'208";a="388582585"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 08:02:15 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Joe Buehler <aspam@cox.net>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 2/3] shared: fix UNIQ definition
Date:   Fri, 18 Dec 2020 08:02:08 -0800
Message-Id: <20201218160209.4037174-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218160209.4037174-1-lucas.demarchi@intel.com>
References: <20201218160209.4037174-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

We need a macro indirection for UNIQ to work. Otherwise it won't be
unique at all since it will just append "UNIQ" to the name:

In file included from testsuite/test-init.c:30:
testsuite/testsuite.h:142:27: error: redefinition of ‘stest_load_resourcesUNIQ’
---
 shared/macro.h        | 7 +++++--
 testsuite/testsuite.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/shared/macro.h b/shared/macro.h
index 4fc5405..b59f7dc 100644
--- a/shared/macro.h
+++ b/shared/macro.h
@@ -45,9 +45,14 @@
 	})
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + _array_size_chk(arr))
+
 #define XSTRINGIFY(x) #x
 #define STRINGIFY(x) XSTRINGIFY(x)
 
+#define XCONCATENATE(x, y) x ## y
+#define CONCATENATE(x, y) XCONCATENATE(x, y)
+#define UNIQ(x) CONCATENATE(x, __COUNTER__)
+
 /* Temporaries for importing index handling */
 #define NOFAIL(x) (x)
 #define fatal(x...) do { } while (0)
@@ -69,5 +74,3 @@
 #define noreturn __attribute__((noreturn))
 #endif
 #endif
-
-#define UNIQ __COUNTER__
diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
index 7ed96bf..f190249 100644
--- a/testsuite/testsuite.h
+++ b/testsuite/testsuite.h
@@ -139,7 +139,7 @@ int test_run(const struct test *t);
 
 /* Test definitions */
 #define DEFINE_TEST(_name, ...) \
-	static const struct test s##_name##UNIQ \
+	static const struct test UNIQ(s##_name) \
 	__attribute__((used, section("kmod_tests"), aligned(8))) = { \
 		.name = #_name, \
 		.func = _name, \
-- 
2.29.2

