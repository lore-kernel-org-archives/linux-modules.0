Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C33C77B60
	for <linux-modules@archiver.kernel.org>; Sun, 19 Mar 2023 21:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCSV14 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 19 Mar 2023 17:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCSV1x (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 19 Mar 2023 17:27:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA1B1B2F1;
        Sun, 19 Mar 2023 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=psuLoCB7yMo0lQ1qK6AoFWy0yUy3JveB/SBuC3I8l14=; b=JqNqxtSTJBKuFUjhNtyLe1tRpu
        REERQ0T2uRXb/KuQjDj2q+827LAgGqwwcdDo0UwlK6lSdwkJoctjxJDYjaf/oFcHZXHpNVPtKByDo
        MJzwa7JQm2W9qjCFA5+MV1MhGv/dj+gPO5xz+AoB69YYfDY87Nf1VqFG4BCKbghs4hLMdo/UG3u1q
        j5AL7curNFHa6ODUxQkodxSKykBVgwLiHw36cSc+97+SghEcJPcUC21Eg1rV9vz97Jl/FylW1utBo
        ofsyEu+uViWLN1waouyNIqZw2ufh/Q6474CYzO4Rm+uhf5v9RzL68eHiREitIQpi/t9aOoNw/nkBv
        vahukfig==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0Z9-007Tr5-2W;
        Sun, 19 Mar 2023 21:27:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 04/12] module: move early sanity checks into a helper
Date:   Sun, 19 Mar 2023 14:27:38 -0700
Message-Id: <20230319212746.1783033-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230319212746.1783033-1-mcgrof@kernel.org>
References: <20230319212746.1783033-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Move early sanity checkers for the module into a helper.
This let's us make it clear when we are working with the
local copy of the module prior to allocation.

This produces no functional changes, it just makes subsequent
changes easier to read.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 427284ab31f1..933cef72ae13 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2668,6 +2668,31 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
 	return 0;
 }
 
+/* Module within temporary copy, this doesn't do any allocation  */
+static int early_mod_check(struct load_info *info, int flags)
+{
+	int err;
+
+	/*
+	 * Now that we know we have the correct module name, check
+	 * if it's blacklisted.
+	 */
+	if (blacklisted(info->name)) {
+		pr_err("Module %s is blacklisted\n", info->name);
+		return -EPERM;
+	}
+
+	err = rewrite_section_headers(info, flags);
+	if (err)
+		return err;
+
+	/* Check module struct version now, before we try to use module. */
+	if (!check_modstruct_version(info, info->mod))
+		return ENOEXEC;
+
+	return 0;
+}
+
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
@@ -2711,26 +2736,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err)
 		goto free_copy;
 
-	/*
-	 * Now that we know we have the correct module name, check
-	 * if it's blacklisted.
-	 */
-	if (blacklisted(info->name)) {
-		err = -EPERM;
-		pr_err("Module %s is blacklisted\n", info->name);
-		goto free_copy;
-	}
-
-	err = rewrite_section_headers(info, flags);
+	err = early_mod_check(info, flags);
 	if (err)
 		goto free_copy;
 
-	/* Check module struct version now, before we try to use module. */
-	if (!check_modstruct_version(info, info->mod)) {
-		err = -ENOEXEC;
-		goto free_copy;
-	}
-
 	/* Figure out module layout, and allocate all the memory. */
 	mod = layout_and_allocate(info, flags);
 	if (IS_ERR(mod)) {
-- 
2.39.1

