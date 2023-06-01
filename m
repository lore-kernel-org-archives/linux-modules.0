Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABD4C7EE23
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jun 2023 21:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjFAVZT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjFAVZR (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Jun 2023 17:25:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5C9195
        for <linux-modules@vger.kernel.org>; Thu,  1 Jun 2023 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685654716; x=1717190716;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l+tHxzkKSTjhOvRvB5vLR8waAn2RbTo8d6mNLLDbGkw=;
  b=QFL7NEQZBe4HkGC2IRjUwkaK6BrdtpRYqCs6KFLNXG1+KYep+bhvAD/J
   d6e0FkWgc7MFLooZaxnZ2FxNEx1ZVwEe4MRo2Jew0MZlWqMCl6kzU68St
   XM8agJxNQI8qgbKm0hpuFd2PAG3R23MjEO0zaM4r7SMda5ku10OcJl+33
   BKTVF6lCnebzTiSUzN9nD5jp/k4Iy1yYXIEWl//0xrqkdLjB6KaZp5nOq
   cduM36WNesX0n3tpMUpA5GzRKksNq/AoQv689i25lvs20gSbIWpolcZ+V
   DMV8y6My5LsbThqxcywQ/MXX34kckShcE0sMNor1SYeOH8n3D1EAWHjqU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358117253"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="358117253"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="710671492"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="710671492"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:24:14 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>, stable@kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] module/decompress: Fix error checking on zstd decompression
Date:   Thu,  1 Jun 2023 14:23:31 -0700
Message-Id: <20230601212331.567483-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

While implementing support for in-kernel decompression in kmod,
finit_module() was returning a very suspicious value:

	finit_module(3, "", MODULE_INIT_COMPRESSED_FILE) = 18446744072717407296

It turns out the check for module_get_next_page() failing is wrong,
and hence the decompression was not really taking place. Invert
the condition to fix it.

Fixes: 169a58ad824d ("module/decompress: Support zstd in-kernel decompression")
Cc: stable@kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 kernel/module/decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index e97232b125eb..8a5d6d63b06c 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -257,7 +257,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	do {
 		struct page *page = module_get_next_page(info);
 
-		if (!IS_ERR(page)) {
+		if (IS_ERR(page)) {
 			retval = PTR_ERR(page);
 			goto out;
 		}
-- 
2.40.1

