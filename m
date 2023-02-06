Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DBFC6379F
	for <linux-modules@archiver.kernel.org>; Mon,  6 Feb 2023 14:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjBFOIA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjBFOHl (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 6 Feb 2023 09:07:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C96A2B601
        for <linux-modules@vger.kernel.org>; Mon,  6 Feb 2023 06:05:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q8so8744660wmo.5
        for <linux-modules@vger.kernel.org>; Mon, 06 Feb 2023 06:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHamnqqe8JBTkyQJ0qbtdVhkEvR3h+VdbLtXBit5Lfk=;
        b=kxr8sZ6YpJyYkltbbrtODapduabkio8K1UtoJOkqiKGUaFCinHkDJdjX7NtKQeWUu6
         yrR1F2mxvQwBdFi2ggmY6EVIlx6qDhayH/gbN4/WGXZibZqF5UZ9gUy6WRhQL3p4TfT0
         wIFzvAp6tQ+LG93RAFUaKwdgcmxwQjeicERgrLSCw2iEqcYmSfyCtn7MyFptQlR7Bdw2
         2iaqWAqVOROjmBXD+iYIx3Tq/8yECVk90xvcLkPN9L8LkqdBy5+21bV8VbgEOj4NHJ2H
         QOt2lRP64y56IpSWjMDaHAvbWiE9Qi6yPLmoMoGoId/p8RikDmzHHCk7nYktFCSiUCNA
         ss0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHamnqqe8JBTkyQJ0qbtdVhkEvR3h+VdbLtXBit5Lfk=;
        b=ukzWvDpL9xh1Caw+2MDXjIW80p55WuBpLNm2GYRv0TPK+87241+DNlP0ikqQLDDBwi
         hp8xbVqni3W0Vwg1oy1KdRyUOGrGRTAS5u3oKTQYtZU8exfN4ECaOPvGhXcIgFUSVqEk
         UL1lq2euCfDLXG4/d4zXIvqzStRjYTMru6DJMgTzqkjQVRBHpM/2JUP+/KY/ynenKRed
         dcqQWQzr7WVYlqDpNFjbvUCZ0cm+AT1CToEI1ji4XTvXCRqOme3UNiaU7aSO5GblMm/p
         +9whF36qcWLr1K5iDbeSo9Xr4YyLEO3HJoZd7i/vy+FrH1CK8heoe7OLa/4aYcN5E8P/
         WDvQ==
X-Gm-Message-State: AO0yUKUwl3Z3E6IXrowT3B5UsafDQJJlULIGWKceC1Q+aAEq9yDYvrXU
        +oND7CcRojbxkCyT+Hw3ay4mPf0OTnY=
X-Google-Smtp-Source: AK7set8RCGTmIGVjc7bpoOE5JUVNHQ8r0R5Z0jAHQWND1WDiVn0DpwKVq7QthiuMUpr0QpYuFo9j0Q==
X-Received: by 2002:a05:600c:43c5:b0:3dc:5674:66e6 with SMTP id f5-20020a05600c43c500b003dc567466e6mr19570966wmn.25.1675692294943;
        Mon, 06 Feb 2023 06:04:54 -0800 (PST)
Received: from localhost ([2a00:5f00:102:0:9503:21c4:e16b:65c3])
        by smtp.gmail.com with UTF8SMTPSA id t8-20020a05600c198800b003dff870ce0esm5334759wmq.2.2023.02.06.06.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:04:54 -0800 (PST)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com
Subject: [PATCH 4/4] testsuite/depmod: use defines for the rootfs/lib_modules
Date:   Mon,  6 Feb 2023 14:04:49 +0000
Message-Id: <20230206140449.574631-5-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206140449.574631-1-emil.l.velikov@gmail.com>
References: <20230206140449.574631-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Emil Velikov <emil.velikov@collabora.com>

The uname used across the tests is same, so drop "_ORDER" from the macro
name and use it throughout. Similarly - add respective LIB_MODULES
defines and use them in the tests.

Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
 testsuite/test-depmod.c | 50 ++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index 010f259..b333e7b 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -25,9 +25,9 @@
 
 #include "testsuite.h"
 
-#define MODULES_ORDER_UNAME "4.4.4"
+#define MODULES_UNAME "4.4.4"
 #define MODULES_ORDER_ROOTFS TESTSUITE_ROOTFS "test-depmod/modules-order-compressed"
-#define MODULES_ORDER_LIB_MODULES MODULES_ORDER_ROOTFS "/lib/modules/" MODULES_ORDER_UNAME
+#define MODULES_ORDER_LIB_MODULES MODULES_ORDER_ROOTFS "/lib/modules/" MODULES_UNAME
 static noreturn int depmod_modules_order_for_compressed(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
@@ -43,7 +43,7 @@ static noreturn int depmod_modules_order_for_compressed(const struct test *t)
 DEFINE_TEST(depmod_modules_order_for_compressed,
 	.description = "check if depmod let aliases in right order when using compressed modules",
 	.config = {
-		[TC_UNAME_R] = MODULES_ORDER_UNAME,
+		[TC_UNAME_R] = MODULES_UNAME,
 		[TC_ROOTFS] = MODULES_ORDER_ROOTFS,
 	},
 	.output = {
@@ -54,10 +54,9 @@ DEFINE_TEST(depmod_modules_order_for_compressed,
 		},
 	});
 
-#define MODULES_OUTDIR_UNAME "4.4.4"
 #define MODULES_OUTDIR_ROOTFS TESTSUITE_ROOTFS "test-depmod/modules-outdir"
-#define MODULES_OUTDIR_LIB_MODULES_OUTPUT MODULES_OUTDIR_ROOTFS "/outdir/lib/modules/" MODULES_OUTDIR_UNAME
-#define MODULES_OUTDIR_LIB_MODULES_INPUT MODULES_OUTDIR_ROOTFS "/lib/modules/" MODULES_OUTDIR_UNAME
+#define MODULES_OUTDIR_LIB_MODULES_OUTPUT MODULES_OUTDIR_ROOTFS "/outdir/lib/modules/" MODULES_UNAME
+#define MODULES_OUTDIR_LIB_MODULES_INPUT MODULES_OUTDIR_ROOTFS "/lib/modules/" MODULES_UNAME
 static noreturn int depmod_modules_outdir(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
@@ -74,7 +73,7 @@ static noreturn int depmod_modules_outdir(const struct test *t)
 DEFINE_TEST(depmod_modules_outdir,
 	.description = "check if depmod honours the outdir option",
 	.config = {
-		[TC_UNAME_R] = MODULES_OUTDIR_UNAME,
+		[TC_UNAME_R] = MODULES_UNAME,
 		[TC_ROOTFS] = MODULES_OUTDIR_ROOTFS,
 	},
 	.output = {
@@ -86,6 +85,7 @@ DEFINE_TEST(depmod_modules_outdir,
 	});
 
 #define SEARCH_ORDER_SIMPLE_ROOTFS TESTSUITE_ROOTFS "test-depmod/search-order-simple"
+#define SEARCH_ORDER_SIMPLE_LIB_MODULES SEARCH_ORDER_SIMPLE_ROOTFS "/lib/modules/" MODULES_UNAME
 static noreturn int depmod_search_order_simple(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
@@ -103,18 +103,19 @@ DEFINE_TEST(depmod_search_order_simple,
 #endif
 	.description = "check if depmod honor search order in config",
 	.config = {
-		[TC_UNAME_R] = "4.4.4",
+		[TC_UNAME_R] = MODULES_UNAME,
 		[TC_ROOTFS] = SEARCH_ORDER_SIMPLE_ROOTFS,
 	},
 	.output = {
 		.files = (const struct keyval[]) {
-			{ SEARCH_ORDER_SIMPLE_ROOTFS "/lib/modules/4.4.4/correct-modules.dep",
-			  SEARCH_ORDER_SIMPLE_ROOTFS "/lib/modules/4.4.4/modules.dep" },
+			{ SEARCH_ORDER_SIMPLE_LIB_MODULES "/correct-modules.dep",
+			  SEARCH_ORDER_SIMPLE_LIB_MODULES "/modules.dep" },
 			{ }
 		},
 	});
 
 #define SEARCH_ORDER_SAME_PREFIX_ROOTFS TESTSUITE_ROOTFS "test-depmod/search-order-same-prefix"
+#define SEARCH_ORDER_SAME_PREFIX_LIB_MODULES SEARCH_ORDER_SAME_PREFIX_ROOTFS "/lib/modules/" MODULES_UNAME
 static noreturn int depmod_search_order_same_prefix(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
@@ -132,13 +133,13 @@ DEFINE_TEST(depmod_search_order_same_prefix,
 #endif
 	.description = "check if depmod honor search order in config with same prefix",
 	.config = {
-		[TC_UNAME_R] = "4.4.4",
+		[TC_UNAME_R] = MODULES_UNAME,
 		[TC_ROOTFS] = SEARCH_ORDER_SAME_PREFIX_ROOTFS,
 	},
 	.output = {
 		.files = (const struct keyval[]) {
-			{ SEARCH_ORDER_SAME_PREFIX_ROOTFS "/lib/modules/4.4.4/correct-modules.dep",
-			  SEARCH_ORDER_SAME_PREFIX_ROOTFS "/lib/modules/4.4.4/modules.dep" },
+			{ SEARCH_ORDER_SAME_PREFIX_LIB_MODULES "/correct-modules.dep",
+			  SEARCH_ORDER_SAME_PREFIX_LIB_MODULES "/modules.dep" },
 			{ }
 		},
 	});
@@ -158,7 +159,7 @@ static noreturn int depmod_detect_loop(const struct test *t)
 DEFINE_TEST(depmod_detect_loop,
 	.description = "check if depmod detects module loops correctly",
 	.config = {
-		[TC_UNAME_R] = "4.4.4",
+		[TC_UNAME_R] = MODULES_UNAME,
 		[TC_ROOTFS] = DETECT_LOOP_ROOTFS,
 	},
 	.expected_fail = true,
@@ -167,6 +168,7 @@ DEFINE_TEST(depmod_detect_loop,
 	});
 
 #define SEARCH_ORDER_EXTERNAL_FIRST_ROOTFS TESTSUITE_ROOTFS "test-depmod/search-order-external-first"
+#define SEARCH_ORDER_EXTERNAL_FIRST_LIB_MODULES SEARCH_ORDER_EXTERNAL_FIRST_ROOTFS "/lib/modules/" MODULES_UNAME
 static noreturn int depmod_search_order_external_first(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
@@ -184,18 +186,19 @@ DEFINE_TEST(depmod_search_order_external_first,
 #endif
 	.description = "check if depmod honor external keyword with higher priority",
 	.config = {
-		[TC_UNAME_R] = "4.4.4",
+		[TC_UNAME_R] = MODULES_UNAME,
 		[TC_ROOTFS] = SEARCH_ORDER_EXTERNAL_FIRST_ROOTFS,
 	},
 	.output = {
 		.files = (const struct keyval[]) {
-			{ SEARCH_ORDER_EXTERNAL_FIRST_ROOTFS "/lib/modules/4.4.4/correct-modules.dep",
-			  SEARCH_ORDER_EXTERNAL_FIRST_ROOTFS "/lib/modules/4.4.4/modules.dep" },
+			{ SEARCH_ORDER_EXTERNAL_FIRST_LIB_MODULES "/correct-modules.dep",
+			  SEARCH_ORDER_EXTERNAL_FIRST_LIB_MODULES "/modules.dep" },
 			{ }
 		},
 	});
 
 #define SEARCH_ORDER_EXTERNAL_LAST_ROOTFS TESTSUITE_ROOTFS "test-depmod/search-order-external-last"
+#define SEARCH_ORDER_EXTERNAL_LAST_LIB_MODULES SEARCH_ORDER_EXTERNAL_LAST_ROOTFS "/lib/modules/" MODULES_UNAME
 static noreturn int depmod_search_order_external_last(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
@@ -213,18 +216,19 @@ DEFINE_TEST(depmod_search_order_external_last,
 #endif
 	.description = "check if depmod honor external keyword with lower priority",
 	.config = {
-		[TC_UNAME_R] = "4.4.4",
+		[TC_UNAME_R] = MODULES_UNAME,
 		[TC_ROOTFS] = SEARCH_ORDER_EXTERNAL_LAST_ROOTFS,
 	},
 	.output = {
 		.files = (const struct keyval[]) {
-			{ SEARCH_ORDER_EXTERNAL_LAST_ROOTFS "/lib/modules/4.4.4/correct-modules.dep",
-			  SEARCH_ORDER_EXTERNAL_LAST_ROOTFS "/lib/modules/4.4.4/modules.dep" },
+			{ SEARCH_ORDER_EXTERNAL_LAST_LIB_MODULES "/correct-modules.dep",
+			  SEARCH_ORDER_EXTERNAL_LAST_LIB_MODULES "/modules.dep" },
 			{ }
 		},
 	});
 
 #define SEARCH_ORDER_OVERRIDE_ROOTFS TESTSUITE_ROOTFS "test-depmod/search-order-override"
+#define SEARCH_ORDER_OVERRIDE_LIB_MODULES SEARCH_ORDER_OVERRIDE_ROOTFS "/lib/modules/" MODULES_UNAME
 static noreturn int depmod_search_order_override(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
@@ -242,13 +246,13 @@ DEFINE_TEST(depmod_search_order_override,
 #endif
 	.description = "check if depmod honor override keyword",
 	.config = {
-		[TC_UNAME_R] = "4.4.4",
+		[TC_UNAME_R] = MODULES_UNAME,
 		[TC_ROOTFS] = SEARCH_ORDER_OVERRIDE_ROOTFS,
 	},
 	.output = {
 		.files = (const struct keyval[]) {
-			{ SEARCH_ORDER_OVERRIDE_ROOTFS "/lib/modules/4.4.4/correct-modules.dep",
-			  SEARCH_ORDER_OVERRIDE_ROOTFS "/lib/modules/4.4.4/modules.dep" },
+			{ SEARCH_ORDER_OVERRIDE_LIB_MODULES "/correct-modules.dep",
+			  SEARCH_ORDER_OVERRIDE_LIB_MODULES "/modules.dep" },
 			{ }
 		},
 	});
-- 
2.39.1

