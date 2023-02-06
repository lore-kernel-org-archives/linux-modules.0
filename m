Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C1DC61DA4
	for <linux-modules@archiver.kernel.org>; Mon,  6 Feb 2023 14:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjBFOH6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjBFOHi (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 6 Feb 2023 09:07:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605772B2A9
        for <linux-modules@vger.kernel.org>; Mon,  6 Feb 2023 06:05:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso10869721wms.0
        for <linux-modules@vger.kernel.org>; Mon, 06 Feb 2023 06:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGdWqnZSbKRssP5heC6adBvLX0QWY9/QH/+MlM4kKBY=;
        b=dSHXsCprBlKGORBc1atLAzXz28aWSf91dB1Fb8qU+vwIU4B/FdV+ufz9Ijnotp9Wag
         +DkPYdUYa+xR5M9pA8nmzhXU6Y1LclPti6GmwhoYvOA0KlWom6bNyI5qpwQG1Cz66+Ht
         dm25ODCDFe1m2jk43GPg7aPQJ1MdtO635jpeAn/veGiJKrlUotrSly6ImLSkkfUT9XMu
         6iQ8WiKVnRRUymkC8eOBT84c41LFSFUIOZiJGuCr/Mgu3+SF4e6Nak1rakyp77mEeXfO
         ddIaGHjiBjsXptNObwJapCNpT2BAo8NPwHh/RLa7/g9xjJTakl5J42p2oeQfYSnm/AZi
         HA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGdWqnZSbKRssP5heC6adBvLX0QWY9/QH/+MlM4kKBY=;
        b=k1XB9Oq8vn9d6GZu+Ls0Dts0800dH8yIbYYvzFH/QDJoX4MLz0NbMdA4MU9k8UiZZC
         BFTB5QjgAz1/QGqS/WIo9EgSmHeym0I0JgEXYJQI8BfcJkqt1mIC31n2bvB6EIDMygqV
         NvlC/Y57JzmoweauGHJb0lL10CN0yvW8tjcNSvOH2y20Ymmkm0nZ8uN05zezs9aUlN0i
         g/ydedu0Y9zBNUi12ApYIjlBay/wlVLx6e2ZIznNC9sIyEBdwKY4oT5uoP1qVUjbV4Jh
         QI44TUD3eJepZgrBMg2CRlIl18PG1A8IyAuNFoY6htKgvXiJ8aKs15EZqFT063rThQim
         d+SA==
X-Gm-Message-State: AO0yUKW+5oUWFJx8PDXbBeqSV2s0fm6qpvV9ZLcd3MpVwWSecuS4+I/o
        TRlK6n8drDA+/VymC9XenXrZS+ZA/2c=
X-Google-Smtp-Source: AK7set8tMBq/Ec+B0fEL6py5UfBX7dlPk0ulG37gJAQ9OrkZmG+4tcVZWfcRANH3411xKaySwZv/cw==
X-Received: by 2002:a05:600c:1d04:b0:3cf:85f7:bbc4 with SMTP id l4-20020a05600c1d0400b003cf85f7bbc4mr19564273wms.2.1675692291972;
        Mon, 06 Feb 2023 06:04:51 -0800 (PST)
Received: from localhost ([2a00:5f00:102:0:9503:21c4:e16b:65c3])
        by smtp.gmail.com with UTF8SMTPSA id x33-20020a05600c18a100b003dd7edcc960sm10718585wmp.45.2023.02.06.06.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:04:51 -0800 (PST)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com
Subject: [PATCH 1/4] treewide: add some static const notations
Date:   Mon,  6 Feb 2023 14:04:46 +0000
Message-Id: <20230206140449.574631-2-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206140449.574631-1-emil.l.velikov@gmail.com>
References: <20230206140449.574631-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Emil Velikov <emil.velikov@collabora.com>

Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
 libkmod/libkmod-module.c    | 4 ++--
 libkmod/libkmod.c           | 4 ++--
 testsuite/test-new-module.c | 8 ++++----
 testsuite/test-util.c       | 4 ++--
 testsuite/testsuite.c       | 2 +-
 tools/depmod.c              | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 12d8ed1..c7232e0 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -551,7 +551,7 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
 						const char *given_alias,
 						struct kmod_list **list)
 {
-	const lookup_func lookup[] = {
+	static const lookup_func lookup[] = {
 		kmod_lookup_alias_from_config,
 		kmod_lookup_alias_from_moddep_file,
 		kmod_lookup_alias_from_symbols_file,
@@ -619,7 +619,7 @@ KMOD_EXPORT int kmod_module_new_from_name_lookup(struct kmod_ctx *ctx,
 						 const char *modname,
 						 struct kmod_module **mod)
 {
-	const lookup_func lookup[] = {
+	static const lookup_func lookup[] = {
 		kmod_lookup_alias_from_moddep_file,
 		kmod_lookup_alias_from_builtin_file,
 		kmod_lookup_alias_from_kernel_builtin_file,
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 7c2b889..2670f9a 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -50,7 +50,7 @@
  * and is passed to all library operations.
  */
 
-static struct _index_files {
+static const struct {
 	const char *fn;
 	const char *prefix;
 } index_files[] = {
@@ -61,7 +61,7 @@ static struct _index_files {
 	[KMOD_INDEX_MODULES_BUILTIN] = { .fn = "modules.builtin", .prefix = ""},
 };
 
-static const char *default_config_paths[] = {
+static const char *const default_config_paths[] = {
 	SYSCONFDIR "/modprobe.d",
 	"/run/modprobe.d",
 	"/usr/local/lib/modprobe.d",
diff --git a/testsuite/test-new-module.c b/testsuite/test-new-module.c
index 360065c..9872b78 100644
--- a/testsuite/test-new-module.c
+++ b/testsuite/test-new-module.c
@@ -29,7 +29,7 @@
 
 static int from_name(const struct test *t)
 {
-	static const char *modnames[] = {
+	static const char *const modnames[] = {
 		"ext4",
 		"balbalbalbbalbalbalbalbalbalbal",
 		"snd-hda-intel",
@@ -37,7 +37,7 @@ static int from_name(const struct test *t)
 		"iTCO_wdt",
 		NULL,
 	};
-	const char **p;
+	const char *const *p;
 	struct kmod_ctx *ctx;
 	struct kmod_module *mod;
 	const char *null_config = NULL;
@@ -72,11 +72,11 @@ DEFINE_TEST(from_name,
 
 static int from_alias(const struct test *t)
 {
-	static const char *modnames[] = {
+	static const char *const modnames[] = {
 		"ext4.*",
 		NULL,
 	};
-	const char **p;
+	const char *const *p;
 	struct kmod_ctx *ctx;
 	int err;
 
diff --git a/testsuite/test-util.c b/testsuite/test-util.c
index 5766584..e3243e8 100644
--- a/testsuite/test-util.c
+++ b/testsuite/test-util.c
@@ -31,7 +31,7 @@
 
 static int alias_1(const struct test *t)
 {
-	static const char *input[] = {
+	static const char *const input[] = {
 		"test1234",
 		"test[abcfoobar]2211",
 		"bar[aaa][bbbb]sss",
@@ -42,7 +42,7 @@ static int alias_1(const struct test *t)
 
 	char buf[PATH_MAX];
 	size_t len;
-	const char **alias;
+	const char *const *alias;
 
 	for (alias = input; *alias != NULL; alias++) {
 		int ret;
diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
index 6a2d296..318343a 100644
--- a/testsuite/testsuite.c
+++ b/testsuite/testsuite.c
@@ -53,7 +53,7 @@ static const struct option options[] = {
 #define OVERRIDE_LIBDIR ABS_TOP_BUILDDIR "/testsuite/.libs/"
 #define TEST_TIMEOUT_USEC 2 * USEC_PER_SEC
 
-struct _env_config {
+static const struct {
 	const char *key;
 	const char *ldpreload;
 } env_config[_TC_LAST] = {
diff --git a/tools/depmod.c b/tools/depmod.c
index 5536597..a2c39b3 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -50,7 +50,7 @@ static int verbose = DEFAULT_VERBOSE;
 
 static const char CFG_BUILTIN_KEY[] = "built-in";
 static const char CFG_EXTERNAL_KEY[] = "external";
-static const char *default_cfg_paths[] = {
+static const char *const default_cfg_paths[] = {
 	SYSCONFDIR "/depmod.d",
 	"/run/depmod.d",
 	"/usr/local/lib/depmod.d",
-- 
2.39.1

