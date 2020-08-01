Return-Path: <SRS0=lTjl=BL=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D493CC433E0
	for <linux-modules@archiver.kernel.org>; Sat,  1 Aug 2020 16:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5BF52080C
	for <linux-modules@archiver.kernel.org>; Sat,  1 Aug 2020 16:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=devup.no header.i=@devup.no header.b="HlefGt0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgHAQCx (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 1 Aug 2020 12:02:53 -0400
Received: from out1.migadu.com ([91.121.223.63]:27732 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgHAQCx (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 1 Aug 2020 12:02:53 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devup.no; s=default;
        t=1596297770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f2LlhuJWjXirtewQgsWA1cwm0a2pxrj2LsHLsGxo8KE=;
        b=HlefGt0sFvFdEDAB7TporlXuHmU/e3W4hFyqm7M7Jo7tZ0kZptusAT8cKCNwmybRb4/UOG
        yJcI6z2CpoMrOOy+nd+xjHEafuN7uaEAsmxRSx8WokCT4NECQ/JZXbXt8A3T7AQqNwTMGi
        /h9CePN/zkwU89iEcTimwf/T2amdbuA=
From:   Marius Bakke <marius@devup.no>
To:     linux-modules <linux-modules@vger.kernel.org>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH v2 2/2] testsuite: Automatically skip tests that fail when sysconfdir != /etc.
Date:   Sat,  1 Aug 2020 18:02:22 +0200
Message-Id: <20200801160222.7464-2-marius@devup.no>
In-Reply-To: <87k0yipdd7.fsf@gnu.org>
References: <87k0yipdd7.fsf@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

---
 Makefile.am                | 12 +++++-------
 configure.ac               |  2 ++
 testsuite/test-blacklist.c |  3 +++
 testsuite/test-depmod.c    | 12 ++++++++++++
 testsuite/test-modprobe.c  |  6 ++++++
 5 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 8eadb99..cfebc37 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -265,13 +265,7 @@ TESTSUITE_OVERRIDE_LIBS = \
 TESTSUITE_OVERRIDE_LIBS_LDFLAGS = \
 	avoid-version -module -shared -export-dynamic -rpath /nowhere -ldl
 
-check-sysconfdir:
-	$(AM_V_at)if test "$(sysconfdir)" != "/etc" -a "$(sysconfdir)" != "/etc/"; then \
-		echo "warning: Some tests will fail without --sysconfdir=/etc" >&2; \
-	fi
-.PHONY: check-sysconfdir
-
-check-am: rootfs check-sysconfdir
+check-am: rootfs
 
 
 EXTRA_DIST += \
@@ -326,6 +320,10 @@ TESTSUITE_LDADD = \
 	testsuite/libtestsuite.la libkmod/libkmod-internal.la \
 	shared/libshared.la
 
+if KMOD_SYSCONFDIR_NOT_ETC
+TESTSUITE_CPPFLAGS += -DKMOD_SYSCONFDIR_NOT_ETC
+endif
+
 check_LTLIBRARIES += testsuite/libtestsuite.la
 testsuite_libtestsuite_la_SOURCES = \
 	testsuite/testsuite.c testsuite/testsuite.h
diff --git a/configure.ac b/configure.ac
index 4a65d6b..2115b03 100644
--- a/configure.ac
+++ b/configure.ac
@@ -213,6 +213,8 @@ GTK_DOC_CHECK([1.14],[--flavour no-tmpl-flat])
 ], [
 AM_CONDITIONAL([ENABLE_GTK_DOC], false)])
 
+# Some tests are skipped when sysconfdir != /etc.
+AM_CONDITIONAL([KMOD_SYSCONFDIR_NOT_ETC], [test "x$sysconfdir" != "x/etc"])
 
 #####################################################################
 # Default CFLAGS and LDFLAGS
diff --git a/testsuite/test-blacklist.c b/testsuite/test-blacklist.c
index 969567d..d03eedb 100644
--- a/testsuite/test-blacklist.c
+++ b/testsuite/test-blacklist.c
@@ -95,6 +95,9 @@ fail_lookup:
 }
 
 DEFINE_TEST(blacklist_1,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+        .skip = true,
+#endif
 	.description = "check if modules are correctly blacklisted",
 	.config = {
 		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-blacklist/",
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index 47dafb4..261559c 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -42,6 +42,9 @@ static noreturn int depmod_modules_order_for_compressed(const struct test *t)
 }
 
 DEFINE_TEST(depmod_modules_order_for_compressed,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+        .skip = true,
+#endif
 	.description = "check if depmod let aliases in right order when using compressed modules",
 	.config = {
 		[TC_UNAME_R] = MODULES_ORDER_UNAME,
@@ -121,6 +124,9 @@ static noreturn int depmod_detect_loop(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(depmod_detect_loop,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+        .skip = true,
+#endif
 	.description = "check if depmod detects module loops correctly",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -144,6 +150,9 @@ static noreturn int depmod_search_order_external_first(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(depmod_search_order_external_first,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+        .skip = true,
+#endif
 	.description = "check if depmod honor external keyword with higher priority",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -196,6 +205,9 @@ static noreturn int depmod_search_order_override(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(depmod_search_order_override,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+        .skip = true,
+#endif
 	.description = "check if depmod honor override keyword",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index f908d56..f6bed8b 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -83,6 +83,9 @@ static noreturn int modprobe_show_alias_to_none(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(modprobe_show_alias_to_none,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+        .skip = true,
+#endif
 	.description = "check if modprobe --show-depends doesn't explode with an alias to nothing",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -172,6 +175,9 @@ static noreturn int modprobe_softdep_loop(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(modprobe_softdep_loop,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+        .skip = true,
+#endif
 	.description = "check if modprobe breaks softdep loop",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
-- 
2.28.0

