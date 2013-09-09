Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:63275 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab3IISAJ (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 9 Sep 2013 14:00:09 -0400
Received: by mail-wi0-f176.google.com with SMTP id cb5so3778594wib.15
        for <linux-modules@vger.kernel.org>; Mon, 09 Sep 2013 11:00:08 -0700 (PDT)
From: Tom Gundersen <teg@jklm.no>
To: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Tom Gundersen <teg@jklm.no>,
	Kay Sievers <kay@vrfy.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] depmod: warn on invalid devname specification
Date: Mon,  9 Sep 2013 20:01:01 +0200
Message-Id: <1378749661-8841-1-git-send-email-teg@jklm.no>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

During the last merge window (3.12) a couple of modules gained devname
aliases, but without the necessary major and minor information. These were
then silently ignored when generating modules.devname.

Complain loudly to avoid such errors sneaking in undetected in the future:

    depmod: ERROR: Module 'zram' has devname (zram) but lacks major and minor information. Ignoring.
    depmod: ERROR: Module 'uhid' has devname (uhid) but lacks major and minor information. Ignoring.

Cc: Kay Sievers <kay@vrfy.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
---
 tools/depmod.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 985cf3a..5855b2a 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2120,11 +2120,18 @@ static int output_devname(struct depmod *depmod, FILE *out)
 				minor = min;
 			}
 
-			if (type != '\0' && devname != NULL) {
+			if (type != '\0' && devname != NULL)
+				break;
+		}
+
+		if (devname != NULL) {
+			if (type != '\0')
 				fprintf(out, "%s %s %c%u:%u\n", mod->modname,
 					devname, type, major, minor);
-				break;
-			}
+			else
+				ERR("Module '%s' has devname (%s) but "
+				    "lacks major and minor information. "
+				    "Ignoring.\n", mod->modname, devname);
 		}
 	}
 
-- 
1.8.4

