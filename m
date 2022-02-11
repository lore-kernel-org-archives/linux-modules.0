Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A7FC433EF
	for <linux-modules@archiver.kernel.org>; Fri, 11 Feb 2022 08:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348103AbiBKImp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 11 Feb 2022 03:42:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348092AbiBKImk (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Feb 2022 03:42:40 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D5DE5E
        for <linux-modules@vger.kernel.org>; Fri, 11 Feb 2022 00:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644568959; x=1676104959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=awLmTMsee8Wj05CPICoM3fem6XnfDv255JW7hE6gris=;
  b=U5bd4dm8D0EoTDaP1u7YeMX9x4od7MKMc2LL5chCkckoG6ICeFA5s4D4
   92j0C4Ur/kcnow5C23f2g1DQJCMCmNPorxjuk4EDyIlIYtJxcGO5G8ZTg
   BaD42yuwsJ3JQiznvV0JLrxmwKSYHCvarbY+OEWPPOm4o/CDzlNkJ+hfC
   Gsdhm7RckjzRm2Dto1N4jVx8fHnteZKAF8xLox5KxkeqEB1kpQxb2guDb
   mQrzOX3pc8jcG3UZ3Ei2Utndsjz2D/2zCJrr2ewFxNCIqPC8u/3LfEIIB
   rZL1IC3pxJk1nPQEvbcikZfrxe6ViUFIyEIWOIRl68oowjTUkH86yL2sp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="310427004"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="310427004"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 00:42:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="526876367"
Received: from cheryeoh-mobl.amr.corp.intel.com (HELO ldmartin-desk2.wifi.hicv.net) ([10.209.59.32])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 00:42:38 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     gladkov.alexey@gmail.com
Subject: [PATCH 1/3] libkmod: Prefer builtin index over builtin.alias
Date:   Fri, 11 Feb 2022 00:42:28 -0800
Message-Id: <20220211084230.4489-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
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
 libkmod/libkmod-module.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 6f7747c..40d394a 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -576,13 +576,14 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
 	err = kmod_lookup_alias_from_aliases_file(ctx, alias, list);
 	CHECK_ERR_AND_FINISH(err, fail, list, finish);
 
+	DBG(ctx, "lookup modules.builtin %s\n", alias);
+	err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
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

