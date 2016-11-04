Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47795 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756489AbcKDJeM (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 4 Nov 2016 05:34:12 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AEBF0AB9B
        for <linux-modules@vger.kernel.org>; Fri,  4 Nov 2016 09:34:10 +0000 (UTC)
From: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
To: linux-modules@vger.kernel.org
Cc: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Subject: [PATCH] depmod: ignore related modules in depmod_report_cycles
Date: Fri,  4 Nov 2016 10:33:57 +0100
Message-Id: <1478252037-5340-1-git-send-email-yousaf.kaukab@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Only print actual cyclic dependencies. Don't print count of all the
modules as it includes other modules which have dependencies but not
necessarily cyclic.

Printing related modules causes buffer overflow as m->modnamesz is not
included in buffer size calculations (loop == m is never true).
This buffer overflow causes kmod to crash.

Reported-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
---
As count of modules in cyclic dependency chain is not known at the
start of this function, so it is not printed anymore. The output
when cyclic dependency is detected is changed as following:

Old:
depmod: ERROR: Found 8 modules in dependency cycles!

New:
depmod: ERROR: Modules found in dependency cycles!

I hope it wouldn't be a problem.

 tools/depmod.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index ad01f66..2813ef1 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1456,7 +1456,7 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 {
 	const char sep[] = " -> ";
 	int ir = 0;
-	ERR("Found %u modules in dependency cycles!\n", n_roots);
+	ERR("Modules found in dependency cycles!\n");
 
 	while (n_roots > 0) {
 		int is, ie;
@@ -1491,6 +1491,7 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 			if (m->visited) {
 				int i, n = 0, sz = 0;
 				char *buf;
+				bool is_cyclic = false;
 
 				for (i = ie - 1; i >= 0; i--) {
 					struct mod *loop = depmod->modules.array[edges[i]];
@@ -1498,9 +1499,15 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 					n++;
 					if (loop == m) {
 						sz += loop->modnamesz - 1;
+						is_cyclic = true;
 						break;
 					}
 				}
+				/* Current module not found in dependency list.
+				 * Must be a related module. Ignore it.
+				 */
+				if (!is_cyclic)
+					continue;
 
 				buf = malloc(sz + n * strlen(sep) + 1);
 				sz = 0;
-- 
2.7.4

