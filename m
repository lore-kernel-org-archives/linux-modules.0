Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C76C433DB
	for <linux-modules@archiver.kernel.org>; Tue, 19 Jan 2021 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487A92250E
	for <linux-modules@archiver.kernel.org>; Tue, 19 Jan 2021 15:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbhASPFK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 19 Jan 2021 10:05:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:39977 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391698AbhASOzW (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 19 Jan 2021 09:55:22 -0500
IronPort-SDR: RQKG49JKx8KoFCSYy3gdxpF4tHKUMRsG1Yytqig/q7+l3G9wtIxCq6kWTJ2krX43Wq4B3YZGk4
 4H3H4h59NVxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="179023528"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="179023528"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 06:54:22 -0800
IronPort-SDR: UtpXDQyd1UOken36U0p2DC4oN9/enEi/3X13A/k/Cqy2/N9bv0LULtDbqMu8pnAlR6MBJbzaVH
 B/urSehjc58g==
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="365772525"
Received: from caophong-mobl.amr.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.213.166.105])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 06:54:20 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Jan Tojnar <jtojnar@gmail.com>
Subject: [PATCH 2/3] depmod: fix precedence order
Date:   Tue, 19 Jan 2021 06:52:37 -0800
Message-Id: <20210119145238.12774-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119145238.12774-1-lucas.demarchi@intel.com>
References: <20210119145238.12774-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Configuration in /etc should have higher prio than /run.
Given how rarely configuration in /run is used with depmod, this is
likely not to cause any problems, even if it's a change in behavior.
---
 tools/depmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 3f31cdf..8e1d9ec 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -51,8 +51,8 @@ static int verbose = DEFAULT_VERBOSE;
 static const char CFG_BUILTIN_KEY[] = "built-in";
 static const char CFG_EXTERNAL_KEY[] = "external";
 static const char *default_cfg_paths[] = {
-	"/run/depmod.d",
 	SYSCONFDIR "/depmod.d",
+	"/run/depmod.d",
 	"/lib/depmod.d",
 	NULL
 };
-- 
2.30.0

