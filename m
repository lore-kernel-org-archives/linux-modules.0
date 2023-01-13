Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E9BC677F1
	for <linux-modules@archiver.kernel.org>; Fri, 13 Jan 2023 21:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjAMViF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 13 Jan 2023 16:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjAMViA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 13 Jan 2023 16:38:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E84DEA4
        for <linux-modules@vger.kernel.org>; Fri, 13 Jan 2023 13:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673645880; x=1705181880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OkADgsApOgJmG5r/N88c4H6dFaskNqMOXt+mZ0vbtC8=;
  b=b2xDvC9U2tc90uYQQeO9WLEGSYym69+MYsIxvL9co3T0GX6e77blOHvq
   sZKkz2d0T13nMopI6r+qUYVcTtMGhCUAmEk0hgo409/w25BBiYtLZ5OQE
   nAB3BXlkobE62wzAaf6FO+monLXDF59b2IokHoAgYLXMKSljnuL6e2D5u
   d/S4djfdGYfCWGajpyduU5Nr9uBUjJMCUH3UHk4giRkQRSDnKSD4yj/kD
   o8XIrT0wfnWUypBrlYG6+VvuuXCn18e38Q0x02S9OCW4MEulddRCPIYNd
   VvZtSTIROCG2rqROglk0QSfykN++kgpkq+Or1dmXsXgBnbzqmjPBuIhtR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="307661050"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="307661050"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:37:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="800725268"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="800725268"
Received: from kcknighx-mobl.amr.corp.intel.com (HELO gjsousa-mobl2.intel.com) ([10.212.91.228])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:37:56 -0800
From:   Gustavo Sousa <gustavo.sousa@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>
Subject: [PATCH v2 2/3] modprobe: Move insertion block into separate function
Date:   Fri, 13 Jan 2023 18:37:44 -0300
Message-Id: <20230113213745.227703-3-gustavo.sousa@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111152936.101040-1-gustavo.sousa@intel.com>
References: <20230111152936.101040-1-gustavo.sousa@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

That same logic will be used for enabling modprobe for paths in the next
patch. As such, prepare for that by extracting that block into its own
function.

Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
---
 tools/modprobe.c | 77 ++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index 3240c2b72edd..d4012fab39f8 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -569,15 +569,53 @@ static void print_action(struct kmod_module *m, bool install,
 		printf("insmod %s %s\n", kmod_module_get_path(m), options);
 }
 
+static int insmod_insert(struct kmod_module *mod, int flags,
+				const char *extra_options)
+{
+	int err = 0;
+	void (*show)(struct kmod_module *m, bool install,
+						const char *options) = NULL;
+
+	if (do_show || verbose > DEFAULT_VERBOSE)
+		show = &print_action;
+
+	if (lookup_only)
+		printf("%s\n", kmod_module_get_name(mod));
+	else
+		err = kmod_module_probe_insert_module(mod, flags,
+				extra_options, NULL, NULL, show);
+
+	if (err >= 0)
+		/* ignore flag return values such as a mod being blacklisted */
+		err = 0;
+	else {
+		switch (err) {
+		case -EEXIST:
+			ERR("could not insert '%s': Module already in kernel\n",
+						kmod_module_get_name(mod));
+			break;
+		case -ENOENT:
+			ERR("could not insert '%s': Unknown symbol in module, "
+					"or unknown parameter (see dmesg)\n",
+					kmod_module_get_name(mod));
+			break;
+		default:
+			ERR("could not insert '%s': %s\n",
+					kmod_module_get_name(mod),
+					strerror(-err));
+			break;
+		}
+	}
+
+	return err;
+}
+
 static int insmod(struct kmod_ctx *ctx, const char *alias,
 						const char *extra_options)
 {
 	struct kmod_list *l, *list = NULL;
 	int err, flags = 0;
 
-	void (*show)(struct kmod_module *m, bool install,
-						const char *options) = NULL;
-
 	err = kmod_module_new_from_lookup(ctx, alias, &list);
 
 	if (list == NULL || err < 0) {
@@ -596,8 +634,6 @@ static int insmod(struct kmod_ctx *ctx, const char *alias,
 		flags |= KMOD_PROBE_IGNORE_LOADED;
 	if (dry_run)
 		flags |= KMOD_PROBE_DRY_RUN;
-	if (do_show || verbose > DEFAULT_VERBOSE)
-		show = &print_action;
 
 	flags |= KMOD_PROBE_APPLY_BLACKLIST_ALIAS_ONLY;
 
@@ -608,36 +644,7 @@ static int insmod(struct kmod_ctx *ctx, const char *alias,
 
 	kmod_list_foreach(l, list) {
 		struct kmod_module *mod = kmod_module_get_module(l);
-
-		if (lookup_only)
-			printf("%s\n", kmod_module_get_name(mod));
-		else {
-			err = kmod_module_probe_insert_module(mod, flags,
-					extra_options, NULL, NULL, show);
-		}
-
-		if (err >= 0)
-			/* ignore flag return values such as a mod being blacklisted */
-			err = 0;
-		else {
-			switch (err) {
-			case -EEXIST:
-				ERR("could not insert '%s': Module already in kernel\n",
-							kmod_module_get_name(mod));
-				break;
-			case -ENOENT:
-				ERR("could not insert '%s': Unknown symbol in module, "
-						"or unknown parameter (see dmesg)\n",
-						kmod_module_get_name(mod));
-				break;
-			default:
-				ERR("could not insert '%s': %s\n",
-						kmod_module_get_name(mod),
-						strerror(-err));
-				break;
-			}
-		}
-
+		err = insmod_insert(mod, flags, extra_options);
 		kmod_module_unref(mod);
 	}
 
-- 
2.39.0

