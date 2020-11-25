Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA386C2D0E4
	for <linux-modules@archiver.kernel.org>; Wed, 25 Nov 2020 01:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBEC206E5
	for <linux-modules@archiver.kernel.org>; Wed, 25 Nov 2020 01:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgKYBbm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 24 Nov 2020 20:31:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7729 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbgKYBbm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 24 Nov 2020 20:31:42 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cgjyp0pX6zkb2G;
        Wed, 25 Nov 2020 09:31:14 +0800 (CST)
Received: from huawei.com (10.174.176.87) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Nov 2020
 09:31:33 +0800
From:   Shuo Wang <wangshuo47@huawei.com>
To:     <lucas.de.marchi@gmail.com>, <patchwork-bot@kernel.org>,
        <linux-modules@vger.kernel.org>
CC:     <hushiyuan@huawei.com>
Subject: [PATCH] NEWS: fix typo
Date:   Wed, 25 Nov 2020 09:31:21 +0800
Message-ID: <20201125013121.4196-1-wangshuo47@huawei.com>
X-Mailer: git-send-email 2.19.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

---
 NEWS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/NEWS b/NEWS
index 1c80582..39fe945 100644
--- a/NEWS
+++ b/NEWS
@@ -415,7 +415,7 @@ kmod 11
 - New features:
 	- libkmod now keeps a file opened after the first call to
 	  kmod_module_get_{info,versions,symbols,dependency_symbols}. This
-	  reduces signficantly the amount of time depmod tool takes to
+	  reduces significantly the amount of time depmod tool takes to
 	  execute. Particularly if compressed modules are used.
 	- Remove --with-rootprefix from build system. It was not a great idea
 	  after all and should not be use since it causes more harm then
-- 
2.23.0

