Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEEAC10F1D
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 20:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiLSUq3 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiLSUqZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D00D1275B
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r7-20020a25c107000000b006ff55ac0ee7so11967378ybf.15
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6S5anngOGqBeJ8dWJgoyIXF8JBImIfN2OM+kqAQMiJE=;
        b=gnQMVJ3xF+K9w4Ke8/SF9LQfX63JngjuAaaKEfwICm0afC0ubsmlLvX2d+aJYYPPut
         xwDVxhQ+UVNR6WozYsWHk2OzoMgMuRCsS7/M2n8kC3agf1OnnvKkjN3Vajtk5OGqxQFA
         7xXkYzcDyqKcOR4oR0UgA1nDOo/Cmx29kWXiVsRI8HQqaTtfntgrPzQGh9MJJepxkBbX
         bU/wUvhMA1u9zzQq9V+8A6YAURGA388ei9l+gpGY8fr57zm3z7k2LLw5klooWKkMe/iT
         G7qCAr3jLShHNmsds2xY+/62uvMpDO/xyAprxT1lJZ4oAusILamm3Cvn4cN/R3SAIwlB
         PvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6S5anngOGqBeJ8dWJgoyIXF8JBImIfN2OM+kqAQMiJE=;
        b=ZhdnmKvcJNYq1nfWp5nDDU6Q7cey3vDw+P4M36OFZyP580Z1uk19H2bdnDV8lh2zp4
         +go5NBpecGxp2dT58jWIVDFvO9ZIf/7mDC32x+sGTGF87WGFgxMiZNTOhoF3OYTTGKt/
         WKGpyM5sEacjXrpXRnSJUmPomDbXpXz5kt971xBac5loosPs95RdUftjoZWCg7z/zlTx
         n6ASAq0GgZyGTmj8FllzSv21oGKYVMEqbKDTidQ2cdqZmzqkWN6LyqXbQHz3+o1q5e4/
         7okAzzJxcloUeJUrNc2hA75f/0lyNMiKWWbfuFlRGUWGEPbDJ0y/zQIGgjfVm1CcyyuW
         FUyw==
X-Gm-Message-State: ANoB5plRWzNS1hQpSYYEPngd/qHEQugxoOOSbV+s9+cz6vRaC7TgJgxh
        kVvzOPrjcbJjq0BBVoo0MtQSGScw9ZM9M0aBKC4CKVadGsdjPZmB8oLfh3J15hJ6Rmva0SEy0DP
        EykRWnjINOBlcX32cIf5RKGFIMVsxreq/DMeYeED4W1gVfpCLUZe/24IlK5tHWzIsBotB2srzEl
        L5nj0=
X-Google-Smtp-Source: AA0mqf7kZBjoNWYV8TibcRALWUvI1Rfi91G32OQZdtuSY8fGUv9/eoVoqpXctVBvfvV0GPpqkHk4vvZGgsZlRtU=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a25:e807:0:b0:6f8:a76c:7a23 with SMTP id
 k7-20020a25e807000000b006f8a76c7a23mr45891538ybd.513.1671482783822; Mon, 19
 Dec 2022 12:46:23 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:10 -0600
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com> <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-3-allenwebb@google.com>
Subject: [PATCH v9 02/10] rockchip-mailbox: Fix typo
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

A one character difference in the name supplied to MODULE_DEVICE_TABLE
breaks a future patch set, so fix the typo.

Cc: stable@vger.kernel.org
Fixes: f70ed3b5dc8b ("mailbox: rockchip: Add Rockchip mailbox driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/mailbox/rockchip-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index 979acc810f30..ca50f7f176f6 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -159,7 +159,7 @@ static const struct of_device_id rockchip_mbox_of_match[] = {
 	{ .compatible = "rockchip,rk3368-mailbox", .data = &rk3368_drv_data},
 	{ },
 };
-MODULE_DEVICE_TABLE(of, rockchp_mbox_of_match);
+MODULE_DEVICE_TABLE(of, rockchip_mbox_of_match);
 
 static int rockchip_mbox_probe(struct platform_device *pdev)
 {
-- 
2.37.3

