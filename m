Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38251 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796AbbIKU4A (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 11 Sep 2015 16:56:00 -0400
From: Laura Abbott <labbott@fedoraproject.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Laura Abbott <labbott@fedoraproject.org>,
	linux-modules@vger.kernel.org
Subject: [PATCH 4/4] depmod: Add error message for bad version
Date: Fri, 11 Sep 2015 13:55:56 -0700
Message-Id: <1442004956-3868-5-git-send-email-labbott@fedoraproject.org>
In-Reply-To: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
References: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


Currently, if a value that doesn't match a kernel version
("%u.%u") is passed in, depmod silently falls back to
using uname. Make it clear to the user that this is happening
by giving a message to the user.
---
 tools/depmod.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/depmod.c b/tools/depmod.c
index 30f6191..f491542 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2480,6 +2480,11 @@ static int do_depmod(int argc, char *argv[])
 		cfg.kversion = argv[optind];
 		optind++;
 	} else {
+		if (optind < argc) {
+			ERR("Bad version passed %s\n", argv[optind]);
+			ERR("Falling back to uname\n");
+		}
+
 		if (uname(&un) < 0) {
 			CRIT("uname() failed: %s\n", strerror(errno));
 			goto cmdline_failed;
-- 
2.4.3

