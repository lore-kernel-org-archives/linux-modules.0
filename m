Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA2DC63797
	for <linux-modules@archiver.kernel.org>; Mon,  6 Feb 2023 14:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjBFOH6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjBFOHj (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 6 Feb 2023 09:07:39 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A617B2B2AD
        for <linux-modules@vger.kernel.org>; Mon,  6 Feb 2023 06:05:10 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n13so8745441wmr.4
        for <linux-modules@vger.kernel.org>; Mon, 06 Feb 2023 06:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctRx9fT9L3vd/ciSZN+DpcKSqEvWjIAFf6OeQLFe/ts=;
        b=gYumNrmQWbVIW77Z/TDyXANqPNjvS77fsHxxSrX+OhwZQEjrZd42kAMKlehgBEQ/Ws
         WpQ4KioHVijrmD0z81srS4xEGGPDmhrmPEJNyOVxVLlpsIFqC4/ILBTj+vDvmUWmmb8x
         DmWftratePofCp6UBKCOuXK4eHyXNqadDYHJBqYs63bprIxudSuzQVvs9OvxwA1h60hK
         e1TwDhQZXA5EMzl0rs7H82FvbupiuOriufE0mbHEvBt70Ffq6Vlbjej5tB+878QR20Ad
         c1G/LSLocyChvtlqwRRBCLU8B8QCaq9t/037FfeGgqAS8UfRS52u/y22wNQo+d1RqGe2
         UHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctRx9fT9L3vd/ciSZN+DpcKSqEvWjIAFf6OeQLFe/ts=;
        b=KcPPYJ8XmWm8XeKFvECtNzMdWTM1Z++h88noUfnNiy3lQgxP9Cu4d2iJb/yoRnlK5F
         xK2xyXJpZZPA74EBAZO6/8tShG+p/x7wEH2iKKzDof2aEZjK1KBj0+QLqTjaD9S1uVa2
         xMgEO1XF9khLrQUylJ2xt98MmImM5tZbL2dJzIXUJtSa5DQqfw2rfnYJHsEMlsVZ+7oJ
         9Xt/wA8EG0nlDXb7iskc3XUvLQycCMRH6C+VVsW+p8+A3f+DbN/CTwWOJptZ9S1raEaZ
         hfDqqNPtouCcjUmZlWlgZL7+suSoeusIU6I2SxhDbQBzqdP/dvQb1vUR4ohjAKN2jSMf
         Bf+Q==
X-Gm-Message-State: AO0yUKX9xAKywEpOOWOUGqbL1dIiFTypC/2zYf5l0Sb/ZV2/Hje5TH5U
        vf8uxYqxRYJX7jttqbFOlkWISnk43G4=
X-Google-Smtp-Source: AK7set9jZqLVpIFEKFBPQHBU0xMERSY22+XlJNtmDwlucrUkGaC4713QbtZwKSHMR9jwpi6aThn/ng==
X-Received: by 2002:a05:600c:4f4d:b0:3dc:57e8:1d1c with SMTP id m13-20020a05600c4f4d00b003dc57e81d1cmr1343733wmq.9.1675692293975;
        Mon, 06 Feb 2023 06:04:53 -0800 (PST)
Received: from localhost ([2a00:5f00:102:0:9503:21c4:e16b:65c3])
        by smtp.gmail.com with UTF8SMTPSA id p17-20020a05600c205100b003dd1bd0b915sm13094689wmg.22.2023.02.06.06.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:04:53 -0800 (PST)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com
Subject: [PATCH 3/4] testsuite: fixup KMOD_SYSCONFDIR_NOT_ETC tests
Date:   Mon,  6 Feb 2023 14:04:48 +0000
Message-Id: <20230206140449.574631-4-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206140449.574631-1-emil.l.velikov@gmail.com>
References: <20230206140449.574631-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Emil Velikov <emil.velikov@collabora.com>

Currently some tests lack a config segment in `.../etc`, yet they're
skipped when KMOD_SYSCONFDIR_NOT_ETC is set. Inversely - some tests have
a config snippet, yet are not skipped.

Go through the lot and fix them all. While there make sure we use tab
for code indentation, as per the style guide.

Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
NOTE: this is based off my earlier patch adding outdir. If this patch is
applied prior the depmod_modules_outdir hunk should be dropped.
---
 testsuite/test-blacklist.c  |  2 +-
 testsuite/test-depmod.c     | 22 +++++++++++-----------
 testsuite/test-modprobe.c   |  7 +++++--
 testsuite/test-new-module.c |  3 +++
 4 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/testsuite/test-blacklist.c b/testsuite/test-blacklist.c
index d03eedb..6531fa2 100644
--- a/testsuite/test-blacklist.c
+++ b/testsuite/test-blacklist.c
@@ -96,7 +96,7 @@ fail_lookup:
 
 DEFINE_TEST(blacklist_1,
 #if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
+	.skip = true,
 #endif
 	.description = "check if modules are correctly blacklisted",
 	.config = {
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index 6465230..010f259 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -41,9 +41,6 @@ static noreturn int depmod_modules_order_for_compressed(const struct test *t)
 }
 
 DEFINE_TEST(depmod_modules_order_for_compressed,
-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
-#endif
 	.description = "check if depmod let aliases in right order when using compressed modules",
 	.config = {
 		[TC_UNAME_R] = MODULES_ORDER_UNAME,
@@ -75,9 +72,6 @@ static noreturn int depmod_modules_outdir(const struct test *t)
 }
 
 DEFINE_TEST(depmod_modules_outdir,
-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
-#endif
 	.description = "check if depmod honours the outdir option",
 	.config = {
 		[TC_UNAME_R] = MODULES_OUTDIR_UNAME,
@@ -104,6 +98,9 @@ static noreturn int depmod_search_order_simple(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(depmod_search_order_simple,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+	.skip = true,
+#endif
 	.description = "check if depmod honor search order in config",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -130,6 +127,9 @@ static noreturn int depmod_search_order_same_prefix(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(depmod_search_order_same_prefix,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+	.skip = true,
+#endif
 	.description = "check if depmod honor search order in config with same prefix",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -156,9 +156,6 @@ static noreturn int depmod_detect_loop(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(depmod_detect_loop,
-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
-#endif
 	.description = "check if depmod detects module loops correctly",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -183,7 +180,7 @@ static noreturn int depmod_search_order_external_first(const struct test *t)
 }
 DEFINE_TEST(depmod_search_order_external_first,
 #if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
+	.skip = true,
 #endif
 	.description = "check if depmod honor external keyword with higher priority",
 	.config = {
@@ -211,6 +208,9 @@ static noreturn int depmod_search_order_external_last(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(depmod_search_order_external_last,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+	.skip = true,
+#endif
 	.description = "check if depmod honor external keyword with lower priority",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -238,7 +238,7 @@ static noreturn int depmod_search_order_override(const struct test *t)
 }
 DEFINE_TEST(depmod_search_order_override,
 #if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
+	.skip = true,
 #endif
 	.description = "check if depmod honor override keyword",
 	.config = {
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index 3ddb976..6b763d8 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -84,7 +84,7 @@ static noreturn int modprobe_show_alias_to_none(const struct test *t)
 }
 DEFINE_TEST(modprobe_show_alias_to_none,
 #if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
+	.skip = true,
 #endif
 	.description = "check if modprobe --show-depends doesn't explode with an alias to nothing",
 	.config = {
@@ -176,7 +176,7 @@ static noreturn int modprobe_softdep_loop(const struct test *t)
 }
 DEFINE_TEST(modprobe_softdep_loop,
 #if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
+	.skip = true,
 #endif
 	.description = "check if modprobe breaks softdep loop",
 	.config = {
@@ -200,6 +200,9 @@ static noreturn int modprobe_install_cmd_loop(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(modprobe_install_cmd_loop,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+	.skip = true,
+#endif
 	.description = "check if modprobe breaks install-commands loop",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
diff --git a/testsuite/test-new-module.c b/testsuite/test-new-module.c
index 9872b78..dcb9934 100644
--- a/testsuite/test-new-module.c
+++ b/testsuite/test-new-module.c
@@ -106,6 +106,9 @@ static int from_alias(const struct test *t)
 	return EXIT_SUCCESS;
 }
 DEFINE_TEST(from_alias,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+	.skip = true,
+#endif
 	.description = "check if aliases are parsed correctly",
 	.config = {
 		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-new-module/from_alias/",
-- 
2.39.1

