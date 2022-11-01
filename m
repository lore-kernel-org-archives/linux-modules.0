Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F8BC433FE
	for <linux-modules@archiver.kernel.org>; Tue,  1 Nov 2022 21:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKAVW5 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 1 Nov 2022 17:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiKAVW5 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 1 Nov 2022 17:22:57 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Nov 2022 14:22:55 PDT
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95A691AF
        for <linux-modules@vger.kernel.org>; Tue,  1 Nov 2022 14:22:55 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pyanoKD2rsfCIpybRoWfKG; Tue, 01 Nov 2022 22:15:22 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:15:22 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-modules@vger.kernel.org
Subject: [PATCH 18/30] module: Use kstrtobool() instead of strtobool()
Date:   Tue,  1 Nov 2022 22:14:06 +0100
Message-Id: <bb37ff26b0c748d0ca883d8f301190cd1177aad2.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is part of a serie that axes all usages of strtobool().
Each patch can be applied independently from the other ones.

The last patch of the serie removes the definition of strtobool().

You may not be in copy of the cover letter. So, if needed, it is available
at [1].

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 kernel/module/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index ff2dfd1f548d..79e17522e196 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -17,6 +17,7 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
+#include <linux/kstrtox.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/elf.h>
@@ -2649,7 +2650,7 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
 	int ret;
 
 	if (strcmp(param, "async_probe") == 0) {
-		if (strtobool(val, &mod->async_probe_requested))
+		if (kstrtobool(val, &mod->async_probe_requested))
 			mod->async_probe_requested = true;
 		return 0;
 	}
-- 
2.34.1

