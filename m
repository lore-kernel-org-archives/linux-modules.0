Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53954 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930AbbI1WjU (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 28 Sep 2015 18:39:20 -0400
From: Laura Abbott <labbott@fedoraproject.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Laura Abbott <labbott@fedoraproject.org>,
	linux-modules@vger.kernel.org
Subject: [PATCHv2 4/5] depmod: Remove unprinted debug messages
Date: Mon, 28 Sep 2015 15:39:13 -0700
Message-Id: <1443479954-31484-4-git-send-email-labbott@fedoraproject.org>
In-Reply-To: <1443479954-31484-1-git-send-email-labbott@fedoraproject.org>
References: <1443479954-31484-1-git-send-email-labbott@fedoraproject.org>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


In between the start of the program and the call to log_setup_kmod_log,
the only messages that will be printed are the ones at or above the
global default level. Debug messages in this range will never be printed
so remove them.
---
 tools/depmod.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 2a08b6e..348735f 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2498,11 +2498,8 @@ static int do_depmod(int argc, char *argv[])
 		if (out == stdout)
 			goto done;
 		/* ignore up-to-date errors (< 0) */
-		if (depfile_up_to_date(cfg.dirname) == 1) {
-			DBG("%s/modules.dep is up to date!\n", cfg.dirname);
+		if (depfile_up_to_date(cfg.dirname) == 1)
 			goto done;
-		}
-		DBG("%s/modules.dep is outdated, do -a\n", cfg.dirname);
 		all = 1;
 	}
 
-- 
2.4.3

