Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BCFC433FE
	for <linux-modules@archiver.kernel.org>; Wed, 16 Feb 2022 07:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiBPH40 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:56:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiBPH4W (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 16 Feb 2022 02:56:22 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DBCE98
        for <linux-modules@vger.kernel.org>; Tue, 15 Feb 2022 23:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644998169; x=1676534169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u5582xut7HgpztMpmwe2JYbpMKb9B32vVCg9+6HiNCo=;
  b=RPaB59+ddTBKYj8YTCEIp9BuwMv+cz5fjx5jw2wMlBMwDuSicfj/2DpI
   ARld8Se5wPh5Pb57OIX6S3kGo/MnmxO2q6s2PQVP+Utflh+9aCoDS9OTy
   88HUaV2hcYBzrOpu1V9BpKJ/D6u9v2ScfDwgBxJW1GN2v28hzoOPbhBPR
   7RRrRCLRDaq4JZnZavjIe98+o4HAeMc/W9K5jpMg+5TtQC6w02zeDHwA+
   ZUbxhMyQqzbhM4BI+4qLumP6tNSqkbz2Tmuo4Rrs5tdknaLfLTYIuBUKb
   S/1Xotp9WnpNwd+wHRkSRTHP7q5IpVkb/9mXmBQkuUtWxUiID1DfhKoAi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311286605"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="311286605"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="636377649"
Received: from dcanchal-mobl1.ger.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.212.233.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 7/8] modinfo: Update help message with "modulename"
Date:   Tue, 15 Feb 2022 23:55:32 -0800
Message-Id: <20220216075533.185693-8-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216075533.185693-1-lucas.demarchi@intel.com>
References: <20220216075533.185693-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

man page correctly states the a module name can be used in place of a
file name:

	modinfo [-0] [-F field] [-k kernel] [modulename|filename...]

Update the help message accordingly.
---
 tools/modinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/modinfo.c b/tools/modinfo.c
index f6a971f..f51b7e4 100644
--- a/tools/modinfo.c
+++ b/tools/modinfo.c
@@ -337,7 +337,7 @@ static const struct option cmdopts[] = {
 static void help(void)
 {
 	printf("Usage:\n"
-		"\t%s [options] filename [args]\n"
+		"\t%s [options] <modulename|filename> [args]\n"
 		"Options:\n"
 		"\t-a, --author                Print only 'author'\n"
 		"\t-d, --description           Print only 'description'\n"
-- 
2.35.1

