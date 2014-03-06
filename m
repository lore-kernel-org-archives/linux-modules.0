Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43797 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232AbaCFOFl (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 6 Mar 2014 09:05:41 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <linux-modules@vger.kernel.org>
CC: Michal Marek <mmarek@suse.cz>
Subject: [PATCH 2/8] testsuite: give a more suitable description to test
Date: Thu, 6 Mar 2014 11:06:43 -0300
Message-ID: <1394114809-2737-2-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
References: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

We are not only checking if those options are correctly parsed from
kcmdline, but if in fact they are being passed to the final
(f)init_module call. This is why we use 'modprobe --show-depends'
instead of the simpler 'modprobe -c'.
---
 testsuite/test-modprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index 492b4d8..b5eaba3 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -176,7 +176,7 @@ static noreturn int modprobe_param_kcmdline(const struct test *t)
 	exit(EXIT_FAILURE);
 }
 static DEFINE_TEST(modprobe_param_kcmdline,
-	.description = "check if params are parsed correctly from kcmdline",
+	.description = "check if params from kcmdline are passed in fact passed to (f)init_module call",
 	.config = {
 		[TC_UNAME_R] = "4.4.4",
 		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline",
-- 
1.9.0

