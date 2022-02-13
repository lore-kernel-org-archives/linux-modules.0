Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5013DC433EF
	for <linux-modules@archiver.kernel.org>; Sun, 13 Feb 2022 07:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiBMHn6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 13 Feb 2022 02:43:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiBMHn5 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 13 Feb 2022 02:43:57 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A9A33B
        for <linux-modules@vger.kernel.org>; Sat, 12 Feb 2022 23:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644738232; x=1676274232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EHdzggEumbThpQUoPtKvH0UBqfVP8iIHUF2IWmrXrZk=;
  b=Kf13VTIpx/Ta0Gmzw5rm/Ucl6rctOkDly1Lj6MAVccBK50MrozRl3XG5
   v+2NhSrpoeHmcYkzQCsa9st5IYLw1rNSGzRBrRiy8USyyRoQ59y7Sm1L1
   RYwJuUwP3LvYxMD9MYDLSkgwWWQHY95rJhulh8gU7jr8EgeffWVIm6YiY
   dWFs20ObqkLsFxbXnCUppfwpHGxboTaN5JTJpym1iUUeOOIIoJVbmbWeP
   4V8GW8ZNXwClXzKgKc5k0Xc6RqIGwytlOGa4cFva0SeAM6PYQt6fM3aut
   8oN4pzC0OuWRgrVn5bUO+OMDQ/wUNHDW3GvbO3M3EKwgIbbFof3V7Bkm1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="310666861"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="310666861"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 23:43:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="634511210"
Received: from wedelapa-mobl.amr.corp.intel.com (HELO ldmartin-desk2.wifi.hicv.net) ([10.212.196.249])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 23:43:51 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: [PATCH v2] libkmod: Prefer builtin index over builtin.alias
Date:   Sat, 12 Feb 2022 21:43:35 -1000
Message-Id: <20220213074335.15774-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAKi4VAJs8mC23vpvkryrdJiX2fJgkPPzb763Og4Y0vZv_JH8Gw@mail.gmail.com>
References: <CAKi4VAJs8mC23vpvkryrdJiX2fJgkPPzb763Og4Y0vZv_JH8Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The modules.builtin.alias.bin is way larger than the
modules.builtin.bin.  On a normal "distro kernel":

	21k modules.builtin.alias.bin
	11k modules.builtin.bin

From the kernel we get both modules.builtin and modules.builtin.modinfo.
depmod generates modules.builtin.bin and modules.builtin.alias.bin
from them respectively. modules.bultin is not going away: it's not
deprecated by the new index added. So, let's just stop duplicating the
information inside modules.builtin.alias.bin and just use the other
index.
---
 libkmod/libkmod-module.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 6f7747c..6423339 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -576,13 +576,15 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
 	err = kmod_lookup_alias_from_aliases_file(ctx, alias, list);
 	CHECK_ERR_AND_FINISH(err, fail, list, finish);
 
+	DBG(ctx, "lookup modules.builtin %s\n", alias);
+	err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
+	CHECK_ERR_AND_FINISH(err, fail, list, finish);
+
 	DBG(ctx, "lookup modules.builtin.modinfo %s\n", alias);
 	err = kmod_lookup_alias_from_kernel_builtin_file(ctx, alias, list);
-	if (err == -ENOSYS) {
-		/* Optional index missing, try the old one */
-		DBG(ctx, "lookup modules.builtin %s\n", alias);
-		err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
-	}
+	/* Optional index missing, ignore */
+	if (err == -ENOSYS)
+		err = 0;
 	CHECK_ERR_AND_FINISH(err, fail, list, finish);
 
 
-- 
2.35.1

