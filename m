Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72636C38142
	for <linux-modules@archiver.kernel.org>; Sun, 22 Jan 2023 19:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjAVTfF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 22 Jan 2023 14:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjAVTfF (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 22 Jan 2023 14:35:05 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9CE1A965;
        Sun, 22 Jan 2023 11:35:02 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 33606E0003;
        Sun, 22 Jan 2023 19:34:59 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org (open list:MODULE SUPPORT),
        linux-kernel@vger.kernel.org (open list:MODULE SUPPORT)
Cc:     Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] module.h: Fix full name of the GPL
Date:   Sun, 22 Jan 2023 20:34:43 +0100
Message-Id: <20230122193443.60267-1-didi.debian@cknow.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 include/linux/module.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 8c5909c0076c..329fa0b56642 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -186,14 +186,14 @@ extern void cleanup_module(void);
  * The following license idents are currently accepted as indicating free
  * software modules
  *
- *	"GPL"				[GNU Public License v2]
- *	"GPL v2"			[GNU Public License v2]
- *	"GPL and additional rights"	[GNU Public License v2 rights and more]
- *	"Dual BSD/GPL"			[GNU Public License v2
+ *	"GPL"				[GNU General Public License v2]
+ *	"GPL v2"			[GNU General Public License v2]
+ *	"GPL and additional rights"	[GNU General Public License v2 rights and more]
+ *	"Dual BSD/GPL"			[GNU General Public License v2
  *					 or BSD license choice]
- *	"Dual MIT/GPL"			[GNU Public License v2
+ *	"Dual MIT/GPL"			[GNU General Public License v2
  *					 or MIT license choice]
- *	"Dual MPL/GPL"			[GNU Public License v2
+ *	"Dual MPL/GPL"			[GNU General Public License v2
  *					 or Mozilla license choice]
  *
  * The following other idents are available
-- 
2.39.0

