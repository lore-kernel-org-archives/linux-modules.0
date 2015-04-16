Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from attila.bofh.it ([85.94.204.146]:54206 "EHLO attila.bofh.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753851AbbDPLhh (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 16 Apr 2015 07:37:37 -0400
Date: Thu, 16 Apr 2015 12:56:12 +0200
To: linux-modules@vger.kernel.org
Subject: Bug#782692: kmod: spurious spaces in lsmod output
Message-ID: <20150416105612.GA3204@bongo.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: md@Linux.IT (Marco d'Itri)
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

----- Forwarded message from Santiago Vila <sanvila@unex.es> -----

From: Santiago Vila <sanvila@unex.es>
To: submit@bugs.debian.org
Subject: Bug#782692: kmod: spurious spaces in lsmod output

Package: kmod
Version: 18-3
Severity: minor

While using "localyesconfig" to build a custom kernel I noticed that lsmod
output now has trailing spaces when the list of "Used by" modules is empty.

The following (untested but trivial) patch should fix it. It just delays
the space to the point where we are sure that there are more things to print.

Thanks.

diff --git a/tools/lsmod.c b/tools/lsmod.c
index e953c7e..c1bab7f 100644
--- a/tools/lsmod.c
+++ b/tools/lsmod.c
@@ -64,15 +64,17 @@ static int do_lsmod(int argc, char *argv[])
 		struct kmod_list *holders, *hitr;
 		int first = 1;
 
-		printf("%-19s %8ld  %d ", name, size, use_count);
+		printf("%-19s %8ld  %d", name, size, use_count);
 		holders = kmod_module_get_holders(mod);
 		kmod_list_foreach(hitr, holders) {
 			struct kmod_module *hm = kmod_module_get_module(hitr);
 
 			if (!first)
 				putchar(',');
-			else
+			else {
+				putchar(' ');
 				first = 0;
+			}
 
 			fputs(kmod_module_get_name(hm), stdout);
 			kmod_module_unref(hm);

----- End forwarded message -----

-- 
ciao,
Marco
