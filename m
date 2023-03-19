Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A1CC6FD1F
	for <linux-modules@archiver.kernel.org>; Sun, 19 Mar 2023 21:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCSV16 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 19 Mar 2023 17:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCSV1x (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 19 Mar 2023 17:27:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499A41B2D6;
        Sun, 19 Mar 2023 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TNKFBczfmqBEiVAXmn3NstMmKpWyY8bTvwWC8VMgfwI=; b=2YNfX4Gb7NFUDeTL79AD09p50C
        URGSVTO2wXU3RJdLci6jM5vAak1lK0yKaMOkQremNdmxdSBxlQS3zTgyXcLG79TOYw1K7fy23WN1U
        ZXbEJlCnGf0DhpBmAuXrIGI5zJZdO99JvWLxy7KRu0XfXkhk/Fzkb/BKr6S6StW4eub6khk6PfvD/
        Hj6P8gHE26VKga8efzNkoQtRibpITDaXE+gWtDCaXHHPtbHhHFcQ1E7PthftYOl6vlqk3FK3DHWl8
        5HAhRd+CRdGcLZyUwjchp3jrvHg12hlEQlhKi3Xof6O1ci6KsSwYvTqzwlScyf++bJ7pAEnltdmbD
        mH9Ac19w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0Z9-007TrB-2r;
        Sun, 19 Mar 2023 21:27:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 07/12] module: split taint work out of check_modinfo_livepatch()
Date:   Sun, 19 Mar 2023 14:27:41 -0700
Message-Id: <20230319212746.1783033-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230319212746.1783033-1-mcgrof@kernel.org>
References: <20230319212746.1783033-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The work to taint the kernel due to a module should be split
up eventually. To aid with this, split up the tainting on
check_modinfo_livepatch().

This let's us bring more early checks together which do return
a value, and makes changes easier to read later where we stuff
all the work to do the taints in one single routine.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5e64485ac05a..cfb2ff5185fe 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1808,12 +1808,8 @@ static int check_modinfo_livepatch(struct module *mod, struct load_info *info)
 		/* Nothing more to do */
 		return 0;
 
-	if (set_livepatch_module(mod)) {
-		add_taint_module(mod, TAINT_LIVEPATCH, LOCKDEP_STILL_OK);
-		pr_notice_once("%s: tainting kernel with TAINT_LIVEPATCH\n",
-				mod->name);
+	if (set_livepatch_module(mod))
 		return 0;
-	}
 
 	pr_err("%s: module is marked as livepatch module, but livepatch support is disabled",
 	       mod->name);
@@ -1993,6 +1989,11 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 	if (err)
 		return err;
 
+	if (is_livepatch_module(mod)) {
+		add_taint_module(mod, TAINT_LIVEPATCH, LOCKDEP_STILL_OK);
+		pr_notice_once("%s: tainting kernel with TAINT_LIVEPATCH\n",
+				mod->name);
+	}
 	module_license_taint_check(mod, get_modinfo(info, "license"));
 
 	if (get_modinfo(info, "test")) {
-- 
2.39.1

