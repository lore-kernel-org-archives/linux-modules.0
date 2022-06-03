Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC132CCA473
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 21:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347895AbiFCVvQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245040AbiFCVvP (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Jun 2022 17:51:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60C457B3E
        for <linux-modules@vger.kernel.org>; Fri,  3 Jun 2022 14:51:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s12so7745585plp.0
        for <linux-modules@vger.kernel.org>; Fri, 03 Jun 2022 14:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2PRvvpLQMhlbz5fltbIQ3jz0H+VVi+ZnfxsdiR5bLag=;
        b=QzymgcgujrjYO7TPtpzexsoNOzlKNnlPntlsiRgPGwIQQFbE1uYxpP5Cpoebgw2A3L
         rKdGY6IIn6zoEZJVH3zuJRO6IYxI4kMls5Dhe2u2JcUCrVCIkPysluYpZ1E9OICfh/V4
         yVQ+hlNonEkhZCtXAT96zzBVBLGtMZQ4WYthcApzQPZfag7bzLEaAKqI2WhiRZzhSaEM
         kZzTUCroxbalq+LjGgJYq1z+qm5++PgZpt3z1W1fW5rii+0c/KRg3h97X3pvZitwPbkq
         8qRqoxp7EZEKoBsPB91/c2m51TFtLiEWq3SY0mJBXdreuwX9ZkesdyBIIPupTkzF8sKU
         xq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2PRvvpLQMhlbz5fltbIQ3jz0H+VVi+ZnfxsdiR5bLag=;
        b=FLlU46Vq/dcLXbz5vl/OYIR1Ph3kSbmFpWemiLWMdyQ+IHfxSsqqwO30OnLjxco9f3
         9nIoN6vIgFwTsbQdt1NyzfWIjQ1Tjp5YQRbY/xVMISMcil4CVi91+iNle20nnWjiAXbV
         tSxtvdDUh/diQJ99KHfpbG/Z+5HiHp7+wLtoXSfmFms3nUpZabglwfqDXSo8W40Qa49W
         xfRJLUBgrroHMr/9hnKNTF0OL5G77uTSiCQmU21puE1lJZzEm9Cc3gCGI1iceH9TSpCg
         O62juCMrkUN57XH1Ttve9dwpBPVnpjJKgEeMc3PhXRBvi6+lCLSKMeOwQR2QhlrymyqR
         ZCKQ==
X-Gm-Message-State: AOAM532fD3RFUReJqP1yna3buh2ixq3p3+LPdbw5g04y3o8vrRiz/aMw
        H7zJtnGts9Qua5tU+QniWNSg4JFTNwI=
X-Google-Smtp-Source: ABdhPJwLRDhgxFH9cxbQOivnpV82yzV9zj8nfLXbFURfGDYMLEUODncJxET0cMVfVrijZr8+5iWt3g==
X-Received: by 2002:a17:903:228c:b0:163:baf6:582a with SMTP id b12-20020a170903228c00b00163baf6582amr11896195plh.43.1654293073610;
        Fri, 03 Jun 2022 14:51:13 -0700 (PDT)
Received: from ldmartin-desk2.. ([50.45.187.67])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b00163ffe73300sm6032866plg.137.2022.06.03.14.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 14:51:12 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 8/8] modprobe: Add --wait
Date:   Fri,  3 Jun 2022 14:50:47 -0700
Message-Id: <20220603215047.9607-9-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
References: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Retry module removal if it fails due to EAGAIN. This allows user to pass
--wait <timeout>, during which `modprobe -r` will keep trying to remove
the module.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 man/modprobe.xml | 17 ++++++++++++
 tools/modprobe.c | 70 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/man/modprobe.xml b/man/modprobe.xml
index 0372b6b..db39c7a 100644
--- a/man/modprobe.xml
+++ b/man/modprobe.xml
@@ -388,6 +388,23 @@
           </para>
         </listitem>
       </varlistentry>
+      <varlistentry>
+        <term>
+          <option>-w</option>
+        </term>
+        <term>
+        <option>--wait=</option>TIMEOUT_MSEC
+        </term>
+        <listitem>
+          <para>
+            This option causes <command>modprobe -r</command> to continue trying to
+            remove a module if it fails due to the module being busy, i.e. its refcount
+            is not 0 at the time the call is made. Modprobe tries to remove the module
+            with an incremental sleep time between each tentative up until the maximum
+            wait time in milliseconds passed in this option.
+          </para>
+        </listitem>
+      </varlistentry>
       <varlistentry>
         <term>
           <option>-S</option>
diff --git a/tools/modprobe.c b/tools/modprobe.c
index caaf87f..2a2ae21 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -32,6 +32,7 @@
 #include <sys/wait.h>
 
 #include <shared/array.h>
+#include <shared/util.h>
 #include <shared/macro.h>
 
 #include <libkmod/libkmod.h>
@@ -55,14 +56,18 @@ static int force = 0;
 static int strip_modversion = 0;
 static int strip_vermagic = 0;
 static int remove_holders = 0;
+static unsigned long long wait_msec = 0;
 static int quiet_inuse = 0;
 
-static const char cmdopts_s[] = "arRibfDcnC:d:S:sqvVh";
+static const char cmdopts_s[] = "arw:RibfDcnC:d:S:sqvVh";
 static const struct option cmdopts[] = {
 	{"all", no_argument, 0, 'a'},
+
 	{"remove", no_argument, 0, 'r'},
 	{"remove-dependencies", no_argument, 0, 5},
 	{"remove-holders", no_argument, 0, 5},
+	{"wait", required_argument, 0, 'w'},
+
 	{"resolve-alias", no_argument, 0, 'R'},
 	{"first-time", no_argument, 0, 3},
 	{"ignore-install", no_argument, 0, 'i'},
@@ -110,6 +115,9 @@ static void help(void)
 		"\t-r, --remove                Remove modules instead of inserting\n"
 		"\t    --remove-dependencies   Deprecated: use --remove-holders\n"
 		"\t    --remove-holders        Also remove module holders (use together with -r)\n"
+		"\t-w, --wait <MSEC>           When removing a module, wait up to MSEC for\n"
+		"\t                            module's refcount to become 0 so it can be\n"
+		"\t                            removed (use together with -r)\n"
 		"\t    --first-time            Fail if module already inserted or removed\n"
 		"\t-i, --ignore-install        Ignore install commands\n"
 		"\t-i, --ignore-remove         Ignore remove commands\n"
@@ -322,6 +330,8 @@ end:
 static int rmmod_do_remove_module(struct kmod_module *mod)
 {
 	const char *modname = kmod_module_get_name(mod);
+	unsigned long long interval_msec = 0, t0_msec = 0,
+		      tend_msec = 0;
 	int flags = 0, err;
 
 	SHOW("rmmod %s\n", modname);
@@ -332,13 +342,45 @@ static int rmmod_do_remove_module(struct kmod_module *mod)
 	if (force)
 		flags |= KMOD_REMOVE_FORCE;
 
-	err = kmod_module_remove_module(mod, flags);
-	if (err == -EEXIST) {
-		if (!first_time)
-			err = 0;
-		else
-			LOG("Module %s is not in kernel.\n", modname);
-	}
+	if (wait_msec)
+		flags |= KMOD_REMOVE_NOLOG;
+
+	do {
+		err = kmod_module_remove_module(mod, flags);
+		if (err == -EEXIST) {
+			if (!first_time)
+				err = 0;
+			else
+				LOG("Module %s is not in kernel.\n", modname);
+			break;
+		} else if (err == -EAGAIN && wait_msec) {
+			unsigned long long until_msec;
+
+			if (!t0_msec) {
+				t0_msec = now_msec();
+				tend_msec = t0_msec + wait_msec;
+				interval_msec = 1;
+			}
+
+			until_msec = get_backoff_delta_msec(t0_msec, tend_msec,
+							  &interval_msec);
+			err = sleep_until_msec(until_msec);
+
+			if (!t0_msec)
+				err = -ENOTSUP;
+
+			if (err < 0) {
+				ERR("Failed to sleep: %s\n", strerror(-err));
+				err = -EAGAIN;
+				break;
+			}
+		} else {
+			break;
+		}
+	} while (interval_msec);
+
+	if (err < 0 && wait_msec)
+		ERR("could not remove '%s': %s\n", modname, strerror(-err));
 
 	return err;
 }
@@ -418,7 +460,7 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 	}
 
 	/* 3. @mod itself, but check for refcnt first */
-	if (!cmd && !ignore_loaded) {
+	if (!cmd && !ignore_loaded && !wait_msec) {
 		int usage = kmod_module_get_refcnt(mod);
 
 		if (usage > 0) {
@@ -800,6 +842,16 @@ static int do_modprobe(int argc, char **orig_argv)
 		case 5:
 			remove_holders = 1;
 			break;
+		case 'w': {
+			char *endptr = NULL;
+			wait_msec = strtoul(optarg, &endptr, 0);
+			if (!*optarg || *endptr) {
+				ERR("unexpected wait value '%s'.\n", optarg);
+				err = -1;
+				goto done;
+			}
+			break;
+		}
 		case 3:
 			first_time = 1;
 			break;
-- 
2.36.1

