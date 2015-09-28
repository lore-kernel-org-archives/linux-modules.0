Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39012 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930AbbI1WjV (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 28 Sep 2015 18:39:21 -0400
From: Laura Abbott <labbott@fedoraproject.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Laura Abbott <labbott@fedoraproject.org>,
	linux-modules@vger.kernel.org
Subject: [PATCHv2 5/5] depmod: Don't fall back to uname on bad version
Date: Mon, 28 Sep 2015 15:39:14 -0700
Message-Id: <1443479954-31484-5-git-send-email-labbott@fedoraproject.org>
In-Reply-To: <1443479954-31484-1-git-send-email-labbott@fedoraproject.org>
References: <1443479954-31484-1-git-send-email-labbott@fedoraproject.org>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


Currently, if a value that doesn't match a kernel version
("%u.%u") is passed in, depmod silently falls back to
using uname. Rather than try and work around the caller passing
bad data, just exit out instead.
---
 tools/depmod.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 348735f..a585d47 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2476,7 +2476,11 @@ static int do_depmod(int argc, char *argv[])
 		}
 	}
 
-	if (optind < argc && is_version_number(argv[optind])) {
+	if (optind < argc) {
+		if (!is_version_number(argv[optind])) {
+			ERR("Bad version passed %s\n", argv[optind]);
+			goto cmdline_failed;
+		}
 		cfg.kversion = argv[optind];
 		optind++;
 	} else {
-- 
2.4.3

