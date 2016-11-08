Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933077AbcKHQqi (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Nov 2016 11:46:38 -0500
From: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
To: linux-modules@vger.kernel.org, lucas.demarchi@intel.com
Cc: bjorn.andersson@linaro.org, afaerber@suse.de,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Subject: [PATCH v1 2/2] depmod: ignore related modules in depmod_report_cycles
Date: Tue,  8 Nov 2016 17:45:50 +0100
Message-Id: <1478623550-18716-2-git-send-email-yousaf.kaukab@suse.com>
In-Reply-To: <1478623550-18716-1-git-send-email-yousaf.kaukab@suse.com>
References: <1478623550-18716-1-git-send-email-yousaf.kaukab@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Only print actual cyclic dependencies. Print count of all the modules
in cyclic dependency at the end of the function so that dependent
modules which are not in cyclic chain can be ignored.

Printing dependent modules which are not in cyclic chain causes buffer
overflow as m->modnamesz is not included in buffer size calculations
(loop == m is never true). This buffer overflow causes kmod to crash.

Update depmod test to reflect the change as well.

Reported-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
---
Change-log:
 v1: Keep the old output stings. Only change their order
     Add test case to reproduce the problem

 .../rootfs-pristine/test-depmod/detect-loop/correct.txt     |  2 +-
 tools/depmod.c                                              | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/testsuite/rootfs-pristine/test-depmod/detect-loop/correct.txt b/testsuite/rootfs-pristine/test-depmod/detect-loop/correct.txt
index 4eb26df..01ecb89 100644
--- a/testsuite/rootfs-pristine/test-depmod/detect-loop/correct.txt
+++ b/testsuite/rootfs-pristine/test-depmod/detect-loop/correct.txt
@@ -1,3 +1,3 @@
-depmod: ERROR: Found 5 modules in dependency cycles!
 depmod: ERROR: Cycle detected: mod_loop_d -> mod_loop_e -> mod_loop_d
 depmod: ERROR: Cycle detected: mod_loop_b -> mod_loop_c -> mod_loop_a -> mod_loop_b
+depmod: ERROR: Found 5 modules in dependency cycles!
diff --git a/tools/depmod.c b/tools/depmod.c
index ad01f66..f2b370f 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1456,7 +1456,7 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 {
 	const char sep[] = " -> ";
 	int ir = 0;
-	ERR("Found %u modules in dependency cycles!\n", n_roots);
+	int num_cyclic = 0;
 
 	while (n_roots > 0) {
 		int is, ie;
@@ -1491,6 +1491,7 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 			if (m->visited) {
 				int i, n = 0, sz = 0;
 				char *buf;
+				bool is_cyclic = false;
 
 				for (i = ie - 1; i >= 0; i--) {
 					struct mod *loop = depmod->modules.array[edges[i]];
@@ -1498,9 +1499,17 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
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
+
+				num_cyclic += n;
 
 				buf = malloc(sz + n * strlen(sep) + 1);
 				sz = 0;
@@ -1538,6 +1547,8 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 			}
 		}
 	}
+
+	ERR("Found %d modules in dependency cycles!\n", num_cyclic);
 }
 
 static int depmod_calculate_dependencies(struct depmod *depmod)
-- 
1.8.5.6

