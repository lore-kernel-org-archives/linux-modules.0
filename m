Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5264EC433E0
	for <linux-modules@archiver.kernel.org>; Fri, 12 Feb 2021 09:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 211DA60241
	for <linux-modules@archiver.kernel.org>; Fri, 12 Feb 2021 09:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBLJrE (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 12 Feb 2021 04:47:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:64847 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhBLJrA (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 12 Feb 2021 04:47:00 -0500
IronPort-SDR: 5oRipH/8zSKQgqoqlB4odakxdCWOiGvT3u+ZaOojMHzK2II+JsWVQGL7ubcx+WQzZS56GyZp0n
 FfzT3ugoPavQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="182458958"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="182458958"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:46:02 -0800
IronPort-SDR: rM01DAaFmAG/tEvZYVEiZSdCD5CUTGyUJVydpLb7kEGZi819jwHhL+jMLAfvX7c85l9cVlDsaD
 jlKg7PgLRB1g==
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="381387386"
Received: from aaramire-mobl2.amr.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.212.210.126])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:46:01 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 4/4] test-modprobe: share single function for kcmdline tests
Date:   Fri, 12 Feb 2021 01:45:24 -0800
Message-Id: <20210212094524.170861-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210212094524.170861-1-lucas.demarchi@intel.com>
References: <20210212094524.170861-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

---
 testsuite/test-modprobe.c | 95 +++++----------------------------------
 1 file changed, 10 insertions(+), 85 deletions(-)

diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index dbc54f3..0255f1a 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -213,7 +213,7 @@ DEFINE_TEST(modprobe_install_cmd_loop,
 	.modules_loaded = "mod-loop-b,mod-loop-a",
 	);
 
-static noreturn int modprobe_param_kcmdline(const struct test *t)
+static noreturn int modprobe_param_kcmdline_show_deps(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
 	const char *const args[] = {
@@ -225,7 +225,7 @@ static noreturn int modprobe_param_kcmdline(const struct test *t)
 	test_spawn_prog(progname, args);
 	exit(EXIT_FAILURE);
 }
-DEFINE_TEST(modprobe_param_kcmdline,
+DEFINE_TEST(modprobe_param_kcmdline_show_deps,
 	.description = "check if params from kcmdline are passed to (f)init_module call",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -237,7 +237,7 @@ DEFINE_TEST(modprobe_param_kcmdline,
 	.modules_loaded = "",
 	);
 
-static noreturn int modprobe_param_kcmdline2(const struct test *t)
+static noreturn int modprobe_param_kcmdline(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
 	const char *const args[] = {
@@ -249,7 +249,7 @@ static noreturn int modprobe_param_kcmdline2(const struct test *t)
 	test_spawn_prog(progname, args);
 	exit(EXIT_FAILURE);
 }
-DEFINE_TEST(modprobe_param_kcmdline2,
+DEFINE_TEST_WITH_FUNC(modprobe_param_kcmdline2, modprobe_param_kcmdline,
 	.description = "check if params with no value are parsed correctly from kcmdline",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -261,19 +261,7 @@ DEFINE_TEST(modprobe_param_kcmdline2,
 	.modules_loaded = "",
 	);
 
-static noreturn int modprobe_param_kcmdline3(const struct test *t)
-{
-	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
-	const char *const args[] = {
-		progname,
-		"-c",
-		NULL,
-	};
-
-	test_spawn_prog(progname, args);
-	exit(EXIT_FAILURE);
-}
-DEFINE_TEST(modprobe_param_kcmdline3,
+DEFINE_TEST_WITH_FUNC(modprobe_param_kcmdline3, modprobe_param_kcmdline,
 	.description = "check if unrelated strings in kcmdline are correctly ignored",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -285,19 +273,7 @@ DEFINE_TEST(modprobe_param_kcmdline3,
 	.modules_loaded = "",
 	);
 
-static noreturn int modprobe_param_kcmdline4(const struct test *t)
-{
-	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
-	const char *const args[] = {
-		progname,
-		"-c",
-		NULL,
-	};
-
-	test_spawn_prog(progname, args);
-	exit(EXIT_FAILURE);
-}
-DEFINE_TEST(modprobe_param_kcmdline4,
+DEFINE_TEST_WITH_FUNC(modprobe_param_kcmdline4, modprobe_param_kcmdline,
 	.description = "check if unrelated strings in kcmdline are correctly ignored",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -309,19 +285,7 @@ DEFINE_TEST(modprobe_param_kcmdline4,
 	.modules_loaded = "",
 	);
 
-static noreturn int modprobe_param_kcmdline5(const struct test *t)
-{
-	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
-	const char *const args[] = {
-		progname,
-		"-c",
-		NULL,
-	};
-
-	test_spawn_prog(progname, args);
-	exit(EXIT_FAILURE);
-}
-DEFINE_TEST(modprobe_param_kcmdline5,
+DEFINE_TEST_WITH_FUNC(modprobe_param_kcmdline5, modprobe_param_kcmdline,
 	.description = "check if params with spaces are parsed correctly from kcmdline",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -333,20 +297,7 @@ DEFINE_TEST(modprobe_param_kcmdline5,
 	.modules_loaded = "",
 	);
 
-
-static noreturn int modprobe_param_kcmdline6(const struct test *t)
-{
-	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
-	const char *const args[] = {
-		progname,
-		"-c",
-		NULL,
-	};
-
-	test_spawn_prog(progname, args);
-	exit(EXIT_FAILURE);
-}
-DEFINE_TEST(modprobe_param_kcmdline6,
+DEFINE_TEST_WITH_FUNC(modprobe_param_kcmdline6, modprobe_param_kcmdline,
 	.description = "check if dots on other parts of kcmdline don't confuse our parser",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -358,20 +309,7 @@ DEFINE_TEST(modprobe_param_kcmdline6,
 	.modules_loaded = "",
 	);
 
-
-static noreturn int modprobe_param_kcmdline7(const struct test *t)
-{
-	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
-	const char *const args[] = {
-		progname,
-		"-c",
-		NULL,
-	};
-
-	test_spawn_prog(progname, args);
-	exit(EXIT_FAILURE);
-}
-DEFINE_TEST(modprobe_param_kcmdline7,
+DEFINE_TEST_WITH_FUNC(modprobe_param_kcmdline7, modprobe_param_kcmdline,
 	.description = "check if dots on other parts of kcmdline don't confuse our parser",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -383,20 +321,7 @@ DEFINE_TEST(modprobe_param_kcmdline7,
 	.modules_loaded = "",
 	);
 
-
-static noreturn int modprobe_param_kcmdline8(const struct test *t)
-{
-	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
-	const char *const args[] = {
-		progname,
-		"-c",
-		NULL,
-	};
-
-	test_spawn_prog(progname, args);
-	exit(EXIT_FAILURE);
-}
-DEFINE_TEST(modprobe_param_kcmdline8,
+DEFINE_TEST_WITH_FUNC(modprobe_param_kcmdline8, modprobe_param_kcmdline,
 	.description = "check if dots on other parts of kcmdline don't confuse our parser",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
-- 
2.30.0

