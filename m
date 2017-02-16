Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:32024 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932793AbdBPR2d (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 16 Feb 2017 12:28:33 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules@vger.kernel.org
Cc: James Minor <james.minor@ni.com>, julia.cartwright@ni.com,
        zach.brown@ni.com, ken.sharp@ni.com
Subject: [PATCH 2/2] libkmod-config: fix parsing quoted kernel cmdline on params
Date: Thu, 16 Feb 2017 09:28:31 -0800
Message-Id: <20170216172831.3019-2-lucas.demarchi@intel.com>
In-Reply-To: <20170216172831.3019-1-lucas.demarchi@intel.com>
References: <20170216172831.3019-1-lucas.demarchi@intel.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

We can only accept quoted values, not module names or parameter names.
---
 libkmod/libkmod-config.c                                   | 14 ++++++++++++++
 .../test-modprobe/module-param-kcmdline5/proc/cmdline      |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index 18f300a..aaac0a1 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -517,10 +517,24 @@ static int kmod_config_parse_kcmdline(struct kmod_config *config)
 	for (p = buf, modname = buf; *p != '\0' && *p != '\n'; p++) {
 		if (*p == '"') {
 			is_quoted = !is_quoted;
+
+			if (is_quoted) {
+				/* don't consider a module until closing quotes */
+				is_module = false;
+			} else if (param != NULL && value != NULL) {
+				/*
+				 * If we are indeed expecting a value and
+				 * closing quotes, then this can be considered
+				 * a valid option for a module
+				 */
+				is_module = true;
+			}
+
 			continue;
 		}
 		if (is_quoted)
 			continue;
+
 		switch (*p) {
 		case ' ':
 			*p = '\0';
diff --git a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline5/proc/cmdline b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline5/proc/cmdline
index 0c796b3..84e0168 100644
--- a/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline5/proc/cmdline
+++ b/testsuite/rootfs-pristine/test-modprobe/module-param-kcmdline5/proc/cmdline
@@ -1 +1 @@
-psmouse.foo psmouse.bar=1 psmouse.foobar="test 1" " notamodule" "noteamodule2 " notamodule3 " quiet rw
+psmouse.foo psmouse.bar=1 psmouse.foobar="test 1" psmouse."invalid option" " notamodule" "noteamodule2 " notamodule3 quiet rw
-- 
2.9.3

