Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from sirokuusama.dnainternet.net ([83.102.40.133]:42812 "EHLO
	sirokuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757290AbaCSCL3 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 18 Mar 2014 22:11:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id B766C41314
	for <linux-modules@vger.kernel.org>; Wed, 19 Mar 2014 04:05:01 +0200 (EET)
Received: from sirokuusama.dnainternet.net ([83.102.40.133])
	by localhost (sirokuusama.dnainternet.net [127.0.0.1]) (DNA Postiturva, port 10041)
	with ESMTP id 1KSGKo1bBtBp for <linux-modules@vger.kernel.org>;
	Wed, 19 Mar 2014 04:05:01 +0200 (EET)
Received: from oliivipuu.dnainternet.net (oliivipuu.dnainternet.net [83.102.40.215])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id 1373F410A3
	for <linux-modules@vger.kernel.org>; Wed, 19 Mar 2014 04:05:00 +0200 (EET)
Received: from mail.onse.fi (unknown [109.204.245.192])
	by oliivipuu.dnainternet.net (Postfix) with ESMTP id A0CB15FD8B
	for <linux-modules@vger.kernel.org>; Wed, 19 Mar 2014 01:26:13 +0200 (EET)
From: Anssi Hannula <anssi@mageia.org>
To: linux-modules@vger.kernel.org
Subject: [PATCH 2/2] depmod: fix debug print parameter order
Date: Wed, 19 Mar 2014 01:26:01 +0200
Message-Id: <1395185161-13687-2-git-send-email-anssi@mageia.org>
In-Reply-To: <1395185161-13687-1-git-send-email-anssi@mageia.org>
References: <1395185161-13687-1-git-send-email-anssi@mageia.org>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---
 tools/depmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 328e578..37e6afd 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1167,7 +1167,7 @@ static int depmod_module_is_higher_priority(const struct depmod *depmod, const s
 		oldprio = bprio;
 
 	DBG("priorities: built-in: %d, old: %d, new: %d\n",
-	    bprio, newprio, oldprio);
+	    bprio, oldprio, newprio);
 
 	return newprio <= oldprio;
 }
-- 
1.8.1.5

