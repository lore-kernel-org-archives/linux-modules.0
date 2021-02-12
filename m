Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3F9C433E6
	for <linux-modules@archiver.kernel.org>; Fri, 12 Feb 2021 09:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE58764E38
	for <linux-modules@archiver.kernel.org>; Fri, 12 Feb 2021 09:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBLJqq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 12 Feb 2021 04:46:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:64849 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhBLJqn (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 12 Feb 2021 04:46:43 -0500
IronPort-SDR: u6GIZSrqVdne6waJinyH098xjaPWLtY9N+Z+0q3xKyhBS45wyo5TktrImojySl3fy0Iq6BqZeW
 mwqCcPBFp4wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="182458956"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="182458956"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:46:01 -0800
IronPort-SDR: +nwaz3mrxqK+3PlGWyQVfDrb2FTEKRaU2wvbvEc2fHR93V/NaLL7XlsfrCrmTaxZQ8KG+3zClL
 9BlBaIXqND4Q==
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="381387376"
Received: from aaramire-mobl2.amr.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.212.210.126])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:46:00 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 3/4] testsuite: allow to re-use single function for tests
Date:   Fri, 12 Feb 2021 01:45:23 -0800
Message-Id: <20210212094524.170861-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210212094524.170861-1-lucas.demarchi@intel.com>
References: <20210212094524.170861-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Add a new DEFINE_TEST_WITH_FUNC() that accepts the function
alongside the test name. This will allow us to share a single function
for different tests.
---
 testsuite/testsuite.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
index c74b648..44d1730 100644
--- a/testsuite/testsuite.h
+++ b/testsuite/testsuite.h
@@ -140,14 +140,16 @@ int test_run(const struct test *t);
 
 
 /* Test definitions */
-#define DEFINE_TEST(_name, ...) \
+#define DEFINE_TEST_WITH_FUNC(_name, _func, ...) \
 	static const struct test UNIQ(s##_name) \
 	__attribute__((used, section("kmod_tests"), aligned(8))) = { \
 		.name = #_name, \
-		.func = _name, \
+		.func = _func, \
 		## __VA_ARGS__ \
 	};
 
+#define DEFINE_TEST(_name, ...) DEFINE_TEST_WITH_FUNC(_name, _name, __VA_ARGS__)
+
 #define TESTSUITE_MAIN() \
 	extern struct test __start_kmod_tests[] __attribute__((weak, visibility("hidden")));	\
 	extern struct test __stop_kmod_tests[] __attribute__((weak, visibility("hidden")));	\
-- 
2.30.0

