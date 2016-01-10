Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:53676 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411AbcAJPSp (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sun, 10 Jan 2016 10:18:45 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id DD16B535983
	for <linux-modules@vger.kernel.org>; Sun, 10 Jan 2016 16:10:32 +0100 (CET)
Date: Sun, 10 Jan 2016 07:10:25 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: linux-modules@vger.kernel.org
Cc: 810367@bugs.debian.org, kmod@packages.debian.org
Subject: [PATCH] depmod: Don't insert comment in modules.devname if otherwise
 empty
Message-ID: <20160110151023.GA9659@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This allows tools to detect the file as empty, such as via systemd's
ConditionFileNotEmpty.
---

The string constant extends past 80 columns, per CODING-STYLE.

The motivation for this patch came from Debian bug 810367.  This change
would allow kmod-static-nodes.service to use ConditionFileNotEmpty
instead of ConditionPathExists.

 tools/depmod.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index a585d47..6e9bb4d 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1999,8 +1999,7 @@ static int output_builtin_bin(struct depmod *depmod, FILE *out)
 static int output_devname(struct depmod *depmod, FILE *out)
 {
 	size_t i;
-
-	fputs("# Device nodes to trigger on-demand module loading.\n", out);
+	bool empty = true;
 
 	for (i = 0; i < depmod->modules.count; i++) {
 		const struct mod *mod = depmod->modules.array[i];
@@ -2036,10 +2035,15 @@ static int output_devname(struct depmod *depmod, FILE *out)
 		}
 
 		if (devname != NULL) {
-			if (type != '\0')
+			if (type != '\0') {
+				if (empty) {
+					fputs("# Device nodes to trigger on-demand module loading.\n",
+					      out);
+					empty = false;
+				}
 				fprintf(out, "%s %s %c%u:%u\n", mod->modname,
 					devname, type, major, minor);
-			else
+                        } else
 				ERR("Module '%s' has devname (%s) but "
 				    "lacks major and minor information. "
 				    "Ignoring.\n", mod->modname, devname);
-- 
2.7.0.rc3

