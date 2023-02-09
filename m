Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03343C61DA4
	for <linux-modules@archiver.kernel.org>; Thu,  9 Feb 2023 19:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBITUM (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 9 Feb 2023 14:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjBITUK (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 9 Feb 2023 14:20:10 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4196E2CFD4
        for <linux-modules@vger.kernel.org>; Thu,  9 Feb 2023 11:20:08 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r3so2953668edq.13
        for <linux-modules@vger.kernel.org>; Thu, 09 Feb 2023 11:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiyBkO032oSQiU7dazrdMhg/i2nmUMHCVJc0aEx//g4=;
        b=VJlVpBsqcJgq/OvglkZU4E+B4e2RMAPdB1lVOBBJrSVXl6iwZPK+W6MJJfI33GYR2T
         1HeepbbQR3qbcVU2lM9qS7zz1XnKEidCn+Z+0y1ipOCA5dLLJ90Fbx4eZCIwFK5Kd2hS
         VibvAECu+qXaNRtTVCgvNxloYfhriQsy/mrdBF7MvjfRwqB5Rl6pg3H5LNph5F2ZjBC3
         y5sfduPDl8/QNLm1PDwkXFLc2puiynT9C1m1jdeo0qkxzaTAZemynGSeHlQ7vQ+kkShX
         wuaz6LcEyB1CfF1f6hklyqn3nzA9hzzCc8Ih2z1JAI9W9AIoHEBAaSnjaYIpqrpNJ3Qp
         JfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiyBkO032oSQiU7dazrdMhg/i2nmUMHCVJc0aEx//g4=;
        b=og5YWalY6QwASyvxxPrn/fDLSNFnqrjNG1JgppMGUVN4hBzvM8tn9ENkbv3oEVQR9L
         EMIkO12iJVXYBNA53c4e/wHRx171vQKzTPe9ukQ3gL/inHos3We7Z0Wh04SqnX4Mx0ev
         QtCGnTM28Po4nxJISXYZ9WGsdIQzrfIiVVe7yjZTIxdXZ4lNrzBJmmQ3YNJkc/IsmlsY
         Q+nYtpdpiMQPxUoYo3ceQxfWtj3rSVvRhJyxHwgX3JHAGFuxOW/N2TcYjLC5dJTfgRtz
         DSS0Q0t+Um/megWe2lpAcOJS57b/8sFknKag/TQRVlKXAPyL3pofMPTPWjHmAciR2QkP
         Z4aA==
X-Gm-Message-State: AO0yUKXe6yTO2xgjPvYVxspqCGJu2sWFiPR9xIjKSSgo8VnQclCwYuWC
        KHKKnSUa6ciROMeXKjCq9Ux1IKwD6jo=
X-Google-Smtp-Source: AK7set/ZHG9ZsWWP0U77ktwXunDg+hLEubtZtlVPQFXru1pH3W2Zu2FBIwElG+8diMotlcbsQYYzWA==
X-Received: by 2002:a50:ab1e:0:b0:4ab:15da:27ff with SMTP id s30-20020a50ab1e000000b004ab15da27ffmr6750897edc.22.1675970405947;
        Thu, 09 Feb 2023 11:20:05 -0800 (PST)
Received: from ldmartin-desk2.lan ([134.134.137.81])
        by smtp.gmail.com with ESMTPSA id k26-20020a50c09a000000b004a21304f5a0sm1188942edf.72.2023.02.09.11.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 11:20:05 -0800 (PST)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 2/2] testsuite: Handle different sysconfdir
Date:   Thu,  9 Feb 2023 11:19:46 -0800
Message-Id: <20230209191946.243317-2-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209191946.243317-1-lucas.de.marchi@gmail.com>
References: <20230209191946.243317-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Instead of skipping tests if sysconfdir isn't /etc, just handle it
during the rootfs setup logic.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 Makefile.am                |  6 +-----
 configure.ac               |  3 ---
 testsuite/setup-rootfs.sh  |  8 ++++++++
 testsuite/test-blacklist.c |  3 ---
 testsuite/test-depmod.c    | 15 ---------------
 testsuite/test-modprobe.c  |  6 ------
 6 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 021b315..61dbdf0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -244,7 +244,7 @@ EXTRA_DIST += testsuite/setup-rootfs.sh
 MODULE_PLAYGROUND = testsuite/module-playground
 ROOTFS = testsuite/rootfs
 ROOTFS_PRISTINE = $(top_srcdir)/testsuite/rootfs-pristine
-CREATE_ROOTFS = $(AM_V_GEN) $(top_srcdir)/testsuite/setup-rootfs.sh $(ROOTFS_PRISTINE) $(ROOTFS) $(MODULE_PLAYGROUND) $(top_builddir)/config.h
+CREATE_ROOTFS = $(AM_V_GEN) $(top_srcdir)/testsuite/setup-rootfs.sh $(ROOTFS_PRISTINE) $(ROOTFS) $(MODULE_PLAYGROUND) $(top_builddir)/config.h $(sysconfdir)
 
 build-module-playground:
 	$(AM_V_GEN)if test "$(top_srcdir)" != "$(top_builddir)"; then \
@@ -330,10 +330,6 @@ TESTSUITE_LDADD = \
 	testsuite/libtestsuite.la libkmod/libkmod-internal.la \
 	shared/libshared.la
 
-if KMOD_SYSCONFDIR_NOT_ETC
-TESTSUITE_CPPFLAGS += -DKMOD_SYSCONFDIR_NOT_ETC
-endif
-
 check_LTLIBRARIES += testsuite/libtestsuite.la
 testsuite_libtestsuite_la_SOURCES = \
 	testsuite/testsuite.c testsuite/testsuite.h
diff --git a/configure.ac b/configure.ac
index 12e0518..892f5d9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -225,9 +225,6 @@ GTK_DOC_CHECK([1.14],[--flavour no-tmpl-flat])
 ], [
 AM_CONDITIONAL([ENABLE_GTK_DOC], false)])
 
-# Some tests are skipped when sysconfdir != /etc.
-AM_CONDITIONAL([KMOD_SYSCONFDIR_NOT_ETC], [test "x$sysconfdir" != "x/etc"])
-
 #####################################################################
 # Default CFLAGS and LDFLAGS
 #####################################################################
diff --git a/testsuite/setup-rootfs.sh b/testsuite/setup-rootfs.sh
index d155a30..4440ddc 100755
--- a/testsuite/setup-rootfs.sh
+++ b/testsuite/setup-rootfs.sh
@@ -6,6 +6,7 @@ ROOTFS_PRISTINE=$1
 ROOTFS=$2
 MODULE_PLAYGROUND=$3
 CONFIG_H=$4
+SYSCONFDIR=$5
 
 # create rootfs from rootfs-pristine
 
@@ -15,6 +16,13 @@ create_rootfs() {
 	cp -r "$ROOTFS_PRISTINE" "$ROOTFS"
 	find "$ROOTFS" -type d -exec chmod +w {} \;
 	find "$ROOTFS" -type f -name .gitignore -exec rm -f {} \;
+
+	if [ "$SYSCONFDIR" != "/etc" ]; then
+		find "$ROOTFS" -type d -name etc -printf "%h\n" | while read -r e; do
+			mkdir -p "$(dirname $e/$SYSCONFDIR)"
+			mv $e/{etc,$SYSCONFDIR}
+		done
+	fi
 }
 
 feature_enabled() {
diff --git a/testsuite/test-blacklist.c b/testsuite/test-blacklist.c
index d03eedb..969567d 100644
--- a/testsuite/test-blacklist.c
+++ b/testsuite/test-blacklist.c
@@ -95,9 +95,6 @@ fail_lookup:
 }
 
 DEFINE_TEST(blacklist_1,
-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
-#endif
 	.description = "check if modules are correctly blacklisted",
 	.config = {
 		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-blacklist/",
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index d910459..9360694 100644
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
 		[TC_UNAME_R] = MODULES_UNAME,
@@ -74,9 +71,6 @@ static noreturn int depmod_modules_outdir(const struct test *t)
 }
 
 DEFINE_TEST(depmod_modules_outdir,
-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
-#endif
 	.description = "check if depmod honours the outdir option",
 	.config = {
 		[TC_UNAME_R] = MODULES_UNAME,
@@ -159,9 +153,6 @@ static noreturn int depmod_detect_loop(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(depmod_detect_loop,
-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
-#endif
 	.description = "check if depmod detects module loops correctly",
 	.config = {
 		[TC_UNAME_R] = MODULES_UNAME,
@@ -186,9 +177,6 @@ static noreturn int depmod_search_order_external_first(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(depmod_search_order_external_first,
-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
-#endif
 	.description = "check if depmod honor external keyword with higher priority",
 	.config = {
 		[TC_UNAME_R] = MODULES_UNAME,
@@ -243,9 +231,6 @@ static noreturn int depmod_search_order_override(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(depmod_search_order_override,
-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
-#endif
 	.description = "check if depmod honor override keyword",
 	.config = {
 		[TC_UNAME_R] = MODULES_UNAME,
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index 3ddb976..309f3e3 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -83,9 +83,6 @@ static noreturn int modprobe_show_alias_to_none(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(modprobe_show_alias_to_none,
-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
-#endif
 	.description = "check if modprobe --show-depends doesn't explode with an alias to nothing",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
@@ -175,9 +172,6 @@ static noreturn int modprobe_softdep_loop(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 DEFINE_TEST(modprobe_softdep_loop,
-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
-        .skip = true,
-#endif
 	.description = "check if modprobe breaks softdep loop",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
-- 
2.39.1

