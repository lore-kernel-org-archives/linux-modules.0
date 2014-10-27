Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:42588 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaJ0QzM (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 27 Oct 2014 12:55:12 -0400
Received: by mail-wg0-f47.google.com with SMTP id a1so2436829wgh.18
        for <linux-modules@vger.kernel.org>; Mon, 27 Oct 2014 09:55:10 -0700 (PDT)
From: Tom Gundersen <teg@jklm.no>
To: linux-modules@vger.kernel.org
Cc: Tom Gundersen <teg@jklm.no>
Subject: [PATCH] static-nodes: indicate that creation of static nodes should only happen at boot
Date: Mon, 27 Oct 2014 17:55:03 +0100
Message-Id: <1414428903-2381-1-git-send-email-teg@jklm.no>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

udev will only manage static nodes that exist at the time udev is started, so
creating static nodes later on will likely not behave as expected. In
particular, recreating the static nodes at run-time will reset any permissions
udev may have applied to the nodes at boot.

See <https://bugzilla.redhat.com/show_bug.cgi?id=1147248> and the discussion
following <http://permalink.gmane.org/gmane.comp.sysutils.systemd.devel/23795>.

Note that this requires (the yet to be released) systemd v217 or a backport
of systemd patch 8c94052ee543c3598a3c7b0c46688150aa2c6168.
---
 tools/static-nodes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/static-nodes.c b/tools/static-nodes.c
index 0195390..4bdacc8 100644
--- a/tools/static-nodes.c
+++ b/tools/static-nodes.c
@@ -95,7 +95,7 @@ static int write_tmpfiles(FILE *out, char modname[], char devname[], char type,
 			return EXIT_FAILURE;
 	}
 
-	ret = fprintf(out, "%c /dev/%s 0600 - - - %u:%u\n",
+	ret = fprintf(out, "%c! /dev/%s 0600 - - - %u:%u\n",
 		      type, devname, maj, min);
 	if (ret < 0)
 		return EXIT_FAILURE;
-- 
2.1.0

