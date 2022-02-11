Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4DEC433F5
	for <linux-modules@archiver.kernel.org>; Fri, 11 Feb 2022 08:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245655AbiBKImq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 11 Feb 2022 03:42:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348094AbiBKIml (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Feb 2022 03:42:41 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982B5193
        for <linux-modules@vger.kernel.org>; Fri, 11 Feb 2022 00:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644568960; x=1676104960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N2yPuX/b0pPAWd6DDpikCrXk284krLJuKzKZM5FT240=;
  b=Kv2p72MQGnZ3c7eRovY3SMshoPqQXWlmW+9gb9n/B6cYCO1jEvqOw92S
   QLUUI42L+I8vaBPuiATS1l/imHROGga5r/QWqlMIJV2/8pcaUbrKQzeW3
   WTt01PMaEhRcZUmTNvWwFwEWdErVY1xzDIxIKMvPUgiQJM5a/PPEh1hoC
   KkxCZN0p8dSrdMZksiBVae9S8pKxPhWxrBTPV0BeHx01448f167VvAyVF
   eVEPKNaW1nxIiyAc8q+VSUQq6J8lb2jqSfaOZP0Ob1h3SPbrPF522dDhF
   gLLbxIGTIz0wURFYheDlPanMvXr8hjseFUwfDsofx1p5ZNzX/wpLbJlWK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="310427007"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="310427007"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 00:42:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="526876371"
Received: from cheryeoh-mobl.amr.corp.intel.com (HELO ldmartin-desk2.wifi.hicv.net) ([10.209.59.32])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 00:42:39 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     gladkov.alexey@gmail.com
Subject: [PATCH 2/3] depmod: Do not duplicate builtin index
Date:   Fri, 11 Feb 2022 00:42:29 -0800
Message-Id: <20220211084230.4489-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211084230.4489-1-lucas.demarchi@intel.com>
References: <20220211084230.4489-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Now that libkmod uses modules.builtin.bin again, we don't need to add
the module names in modules.builtin.alias.bin and just add the aliases.

After this change, here are the new sizes for the indexes:

Before	After	index
21k	6.4K	modules.builtin.alias.bin
11k	 11K	modules.builtin.bin
---
 tools/depmod.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index eb810b8..ac6ead8 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2405,7 +2405,7 @@ static int output_devname(struct depmod *depmod, FILE *out)
 
 static int output_builtin_alias_bin(struct depmod *depmod, FILE *out)
 {
-	int ret = 0, count = 0;
+	int ret = 0;
 	struct index_node *idx;
 	struct kmod_list *l, *builtin = NULL;
 
@@ -2450,9 +2450,6 @@ static int output_builtin_alias_bin(struct depmod *depmod, FILE *out)
 		}
 
 		kmod_module_info_free_list(info_list);
-
-		index_insert(idx, modname, modname, 0);
-		count++;
 	}
 
 out:
-- 
2.35.1

