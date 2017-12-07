Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753566AbdLGOb2 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 7 Dec 2017 09:31:28 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B387CABB4
        for <linux-modules@vger.kernel.org>; Thu,  7 Dec 2017 14:31:27 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
To: linux-modules@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] depmod: Don't add .TOC. when it's in the kernel.
Date: Thu,  7 Dec 2017 15:31:19 +0100
Message-Id: <20171207143119.7046-1-msuchanek@suse.de>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

d46136bb59c4 ("depmod: Ignore PowerPC64 ABIv2 .TOC. symbol") adds fake
.TOC. unconditionally but when there is .TOC. in the kernel adding the
fake one breaks resolving .TOC.

Fixes: d46136bb59c4 ("depmod: Ignore PowerPC64 ABIv2 .TOC. symbol")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 tools/depmod.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 7ff3e9ed191e..9db602d76ee4 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2480,7 +2480,8 @@ static void depmod_add_fake_syms(struct depmod *depmod)
 	/* On S390, this is faked up too */
 	depmod_symbol_add(depmod, "_GLOBAL_OFFSET_TABLE_", true, 0, NULL);
 	/* On PowerPC64 ABIv2, .TOC. is more or less _GLOBAL_OFFSET_TABLE_ */
-	depmod_symbol_add(depmod, "TOC.", true, 0, NULL);
+	if (!depmod_symbol_find(depmod, "TOC."))
+		depmod_symbol_add(depmod, "TOC.", true, 0, NULL);
 }
 
 static int depmod_load_symvers(struct depmod *depmod, const char *filename)
-- 
2.13.6

