Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55997 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138AbaDDJc3 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 4 Apr 2014 05:32:29 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 2237BABE5
	for <linux-modules@vger.kernel.org>; Fri,  4 Apr 2014 09:32:26 +0000 (UTC)
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Subject: [PATCH 2/3] testsuite: Mark empty tests as skipped
Date: Fri,  4 Apr 2014 11:32:15 +0200
Message-Id: <1396603936-13045-2-git-send-email-mmarek@suse.cz>
In-Reply-To: <1396603936-13045-1-git-send-email-mmarek@suse.cz>
References: <1396603936-13045-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---
 testsuite/testsuite.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
index f2a75e5..33f0a1e 100644
--- a/testsuite/testsuite.h
+++ b/testsuite/testsuite.h
@@ -147,7 +147,8 @@ int test_run(const struct test *t);
 								\
 			return test_run(t);			\
 		}						\
-								\
+		if (!tests[0])					\
+			exit(77);				\
 		for (i = 0; tests[i] != NULL; i++) {		\
 			if (test_run(tests[i]) != 0)		\
 				exit(EXIT_FAILURE);		\
-- 
1.8.4.5

