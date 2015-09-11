Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54653 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753929AbbIKU4A (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 11 Sep 2015 16:56:00 -0400
From: Laura Abbott <labbott@fedoraproject.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Laura Abbott <labbott@fedoraproject.org>,
	linux-modules@vger.kernel.org
Subject: [PATCH 3/4] depmod: Fix message printing before log_setup_kmod_log
Date: Fri, 11 Sep 2015 13:55:55 -0700
Message-Id: <1442004956-3868-4-git-send-email-labbott@fedoraproject.org>
In-Reply-To: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
References: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


Until log_setup_kmod_log is called, the only messages that
can be printed are the default level. Bump a few deprecated
messages to ERR to ensure they get printed and drop some DBG
prints that will never occur unless the compiled default is DBG.
---
 tools/depmod.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 2a08b6e..30f6191 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2455,10 +2455,10 @@ static int do_depmod(int argc, char *argv[])
 		case 'r':
 		case 'm':
 			if (idx > 0)
-				WRN("Ignored deprecated option --%s\n",
+				ERR("Ignored deprecated option --%s\n",
 				    cmdopts[idx].name);
 			else
-				WRN("Ignored deprecated option -%c\n", c);
+				ERR("Ignored deprecated option -%c\n", c);
 
 			break;
 		case 'h':
@@ -2498,11 +2498,9 @@ static int do_depmod(int argc, char *argv[])
 		if (out == stdout)
 			goto done;
 		/* ignore up-to-date errors (< 0) */
-		if (depfile_up_to_date(cfg.dirname) == 1) {
-			DBG("%s/modules.dep is up to date!\n", cfg.dirname);
+		if (depfile_up_to_date(cfg.dirname) == 1)
 			goto done;
-		}
-		DBG("%s/modules.dep is outdated, do -a\n", cfg.dirname);
+
 		all = 1;
 	}
 
-- 
2.4.3

