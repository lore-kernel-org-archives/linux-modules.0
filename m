Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57609 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581AbaDDLS5 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 4 Apr 2014 07:18:57 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id E61A8AB43
	for <linux-modules@vger.kernel.org>; Fri,  4 Apr 2014 11:18:55 +0000 (UTC)
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Subject: [PATCH v3 2/3] testsuite: Do not run tests with *.ko.gz if zlib is not enabled
Date: Fri,  4 Apr 2014 13:18:49 +0200
Message-Id: <1396610330-16034-3-git-send-email-mmarek@suse.cz>
In-Reply-To: <1396610330-16034-1-git-send-email-mmarek@suse.cz>
References: <1396610330-16034-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---
 testsuite/test-depmod.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index b6023f1..25c2e9b 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -135,7 +135,9 @@ static DEFINE_TEST(depmod_search_order_same_prefix2,
 
 
 static const struct test *tests[] = {
+#ifdef ENABLE_ZLIB
 	&sdepmod_modules_order_for_compressed,
+#endif
 	&sdepmod_search_order_simple,
 	&sdepmod_search_order_same_prefix,
 	&sdepmod_search_order_same_prefix2,
-- 
1.8.4.5

