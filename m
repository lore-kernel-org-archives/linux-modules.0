Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35309 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930AbbI1WjT (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 28 Sep 2015 18:39:19 -0400
From: Laura Abbott <labbott@fedoraproject.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Laura Abbott <labbott@fedoraproject.org>,
	linux-modules@vger.kernel.org
Subject: [PATCHv2 3/5] Change default log level
Date: Mon, 28 Sep 2015 15:39:12 -0700
Message-Id: <1443479954-31484-3-git-send-email-labbott@fedoraproject.org>
In-Reply-To: <1443479954-31484-1-git-send-email-labbott@fedoraproject.org>
References: <1443479954-31484-1-git-send-email-labbott@fedoraproject.org>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


The default log level is currently LOG_ERR. Tools can override this
default but there is a non-trivial amount of setup that needs to
happen before the log level can be changed. Since tools may want to
use the warn level for things such as deprecated flags, change the
default to LOG_WARNING to ensure messages get printed.
---
 tools/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/log.c b/tools/log.c
index e29a150..3317a35 100644
--- a/tools/log.c
+++ b/tools/log.c
@@ -29,7 +29,7 @@
 #define PRIO_MAX_SIZE 32
 
 static bool log_use_syslog;
-static int log_priority = LOG_ERR;
+static int log_priority = LOG_WARNING;
 
 static const char *prio_to_str(char buf[static PRIO_MAX_SIZE], int prio)
 {
-- 
2.4.3

