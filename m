Return-Path: <SRS0=Ow/D=43=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425DDC3F2C6
	for <linux-modules@archiver.kernel.org>; Tue, 10 Mar 2020 05:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C7D2467D
	for <linux-modules@archiver.kernel.org>; Tue, 10 Mar 2020 05:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgCJFBl (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 10 Mar 2020 01:01:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:16458 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgCJFBl (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 10 Mar 2020 01:01:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 22:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="353525577"
Received: from ldmartin1-desk.jf.intel.com ([10.165.21.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2020 22:01:39 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Yanko Kaneti <yaneti@declera.com>, gladkov.alexey@gmail.com,
        auke-jan.h.kok@intel.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 3/6] libkmod: simplify lookup when builtin.modinfo.bin file is missing
Date:   Mon,  9 Mar 2020 22:00:26 -0700
Message-Id: <20200310050029.27678-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310050029.27678-1-lucas.demarchi@intel.com>
References: <20200310050029.27678-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

When we try to lookup a module and builtin.modinfo.bin is missing, we
would do the right thing because the caller was replacing the return
code with 0 (and the list was not modified).

Make it simpler by allowing the caller to check and differentiate the
errors between module not found and index not found.
---
 libkmod/libkmod-module.c |  8 ++++----
 libkmod/libkmod.c        | 25 +++++++++++--------------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 714ee21..76a6dc3 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -577,13 +577,13 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
 
 	DBG(ctx, "lookup modules.builtin.modinfo %s\n", alias);
 	err = kmod_lookup_alias_from_kernel_builtin_file(ctx, alias, list);
-	CHECK_ERR_AND_FINISH(err, fail, list, finish);
-
-	if (err == 0) {
+	if (err == -ENOSYS) {
+		/* Optional index missing, try the old one */
 		DBG(ctx, "lookup modules.builtin %s\n", alias);
 		err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
-		CHECK_ERR_AND_FINISH(err, fail, list, finish);
 	}
+	CHECK_ERR_AND_FINISH(err, fail, list, finish);
+
 
 finish:
 	DBG(ctx, "lookup %s=%d, list=%p\n", alias, err, *list);
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index c9d9e2a..39f58d9 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -528,20 +528,17 @@ int kmod_lookup_alias_from_kernel_builtin_file(struct kmod_ctx *ctx,
 						struct kmod_list **list)
 {
 	struct kmod_list *l;
-	int ret = kmod_lookup_alias_from_alias_bin(ctx,
-						KMOD_INDEX_MODULES_BUILTIN_ALIAS,
-						name, list);
-	if (ret > 0) {
-		kmod_list_foreach(l, *list) {
-			struct kmod_module *mod = l->data;
-			kmod_module_set_builtin(mod, true);
-		}
-	} else if (ret == -ENOSYS) {
-		/*
-		 * If the system does not support this yet, then
-		 * there is no need to return an error.
-		 */
-		ret = 0;
+	int ret;
+
+	assert(*list == NULL);
+
+	ret = kmod_lookup_alias_from_alias_bin(ctx,
+					       KMOD_INDEX_MODULES_BUILTIN_ALIAS,
+					       name, list);
+
+	kmod_list_foreach(l, *list) {
+		struct kmod_module *mod = l->data;
+		kmod_module_set_builtin(mod, true);
 	}
 
 	return ret;
-- 
2.25.1

