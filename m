Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55996 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbaDDJc3 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 4 Apr 2014 05:32:29 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 2237BAB0E
	for <linux-modules@vger.kernel.org>; Fri,  4 Apr 2014 09:32:26 +0000 (UTC)
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Subject: [PATCH 1/3] testsuite: Do not run tests with *.ko.gz if zlib is not enabled
Date: Fri,  4 Apr 2014 11:32:14 +0200
Message-Id: <1396603936-13045-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Unfortunately, all the depmod tests depend on zlib.
---
 testsuite/test-depmod.c   | 2 ++
 testsuite/test-modprobe.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index b6023f1..86e89a4 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -135,10 +135,12 @@ static DEFINE_TEST(depmod_search_order_same_prefix2,
 
 
 static const struct test *tests[] = {
+#ifdef ENABLE_ZLIB
 	&sdepmod_modules_order_for_compressed,
 	&sdepmod_search_order_simple,
 	&sdepmod_search_order_same_prefix,
 	&sdepmod_search_order_same_prefix2,
+#endif
 	NULL,
 };
 
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index d7663e6..c49e75b 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -332,7 +332,9 @@ static const struct test *tests[] = {
 	&smodprobe_show_alias_to_none,
 	&smodprobe_builtin,
 	&smodprobe_softdep_loop,
+#ifdef ENABLE_ZLIB
 	&smodprobe_install_cmd_loop,
+#endif
 	&smodprobe_param_kcmdline,
 	&smodprobe_param_kcmdline2,
 	&smodprobe_param_kcmdline3,
-- 
1.8.4.5

