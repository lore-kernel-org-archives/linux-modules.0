Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBE2C77B75
	for <linux-modules@archiver.kernel.org>; Tue, 18 Apr 2023 07:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDRHSO (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 Apr 2023 03:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjDRHSN (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 Apr 2023 03:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12384C28;
        Tue, 18 Apr 2023 00:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A81262D7F;
        Tue, 18 Apr 2023 07:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8266AC433EF;
        Tue, 18 Apr 2023 07:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681802283;
        bh=SBkw+Rl/R2V6yVsXQAH0zMIyTFbmLbUrynptNaG25HE=;
        h=From:To:Cc:Subject:Date:From;
        b=JoJopI2hLvvz45LqFEsYWB0LavG63McovtFt7vl4iutbwrt/EuhjRfKpEdwsgfOxb
         hlSuumS7K//WJmEs7+jYi/xHmMWWVcdWxlqu9ZrcEsjzayRDCzd8+Dt3k1nLMp9EDR
         0cibxuJkuIbD0r3CqZfb/rOKwP4XiqLVc7yHWW2S6tLgTiomZS5kr37qqhSVfUuvif
         vHBgiO2umshsip0Am6wfzmM8JCbJCQA9rhU7WEuqfdrKDCmKOv9oS3uaEirfp6vXIq
         ZbRhPnqkpoG6S0yc56nyiGs6s2hqkTEctrI+3nE1AYgaXHp3X7msA5iyVEvMIBTHNu
         jfCqp/pnicsVw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] module: stats: fix invalid_mod_bytes typo
Date:   Tue, 18 Apr 2023 09:17:51 +0200
Message-Id: <20230418071758.3163529-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

This was caught by randconfig builds but does not show up in
build testing without CONFIG_MODULE_DECOMPRESS:

kernel/module/stats.c: In function 'mod_stat_bump_invalid':
kernel/module/stats.c:229:42: error: 'invalid_mod_byte' undeclared (first use in this function); did you mean 'invalid_mod_bytes'?
  229 |   atomic_long_add(info->compressed_len, &invalid_mod_byte);
      |                                          ^~~~~~~~~~~~~~~~
      |                                          invalid_mod_bytes

Fixes: 0d4ab68ce983 ("module: add debug stats to help identify memory pressure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This was probably already reported, sending the fix just in case everyone
else else missed it so far.
---
 kernel/module/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/stats.c b/kernel/module/stats.c
index cdcd60695399..32959ec9581f 100644
--- a/kernel/module/stats.c
+++ b/kernel/module/stats.c
@@ -226,7 +226,7 @@ void mod_stat_bump_invalid(struct load_info *info, int flags)
 	atomic_inc(&failed_load_modules);
 #if defined(CONFIG_MODULE_DECOMPRESS)
 	if (flags & MODULE_INIT_COMPRESSED_FILE)
-		atomic_long_add(info->compressed_len, &invalid_mod_byte);
+		atomic_long_add(info->compressed_len, &invalid_mod_bytes);
 #endif
 }
 
-- 
2.39.2

