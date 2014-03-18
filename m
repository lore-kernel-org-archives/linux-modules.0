Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from tulikuusama.dnainternet.net ([83.102.40.132]:54364 "EHLO
	tulikuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751543AbaCSCLO (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 18 Mar 2014 22:11:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by tulikuusama.dnainternet.net (Postfix) with ESMTP id C221241162
	for <linux-modules@vger.kernel.org>; Wed, 19 Mar 2014 04:05:49 +0200 (EET)
Received: from tulikuusama.dnainternet.net ([83.102.40.132])
	by localhost (tulikuusama.dnainternet.net [127.0.0.1]) (DNA Postiturva, port 10041)
	with ESMTP id Zj+7I18RH-Nl for <linux-modules@vger.kernel.org>;
	Wed, 19 Mar 2014 04:05:48 +0200 (EET)
Received: from luumupuu.dnainternet.net (luumupuu.dnainternet.net [83.102.40.213])
	by tulikuusama.dnainternet.net (Postfix) with ESMTP id 2A639411C6
	for <linux-modules@vger.kernel.org>; Wed, 19 Mar 2014 04:04:56 +0200 (EET)
Received: from mail.onse.fi (unknown [109.204.245.192])
	by luumupuu.dnainternet.net (Postfix) with ESMTP id 3C86C5FDC7
	for <linux-modules@vger.kernel.org>; Wed, 19 Mar 2014 01:26:10 +0200 (EET)
From: Anssi Hannula <anssi@mageia.org>
To: linux-modules@vger.kernel.org
Subject: [PATCH 1/2] depmod: do not allow partial matches with "search" directive
Date: Wed, 19 Mar 2014 01:26:00 +0200
Message-Id: <1395185161-13687-1-git-send-email-anssi@mageia.org>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Currently e.g. "search foo foobar built-in" will cause unpredictable
results if baz.ko is in both foo/ and foobar/, since "foo" in search may
match both of those directories and the preferred module therefore
depends on processing order.

Fix the code to ensure that the match is performed on full pathname
components only.
---
 tools/depmod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 9f83ee8..328e578 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1153,10 +1153,10 @@ static int depmod_module_is_higher_priority(const struct depmod *depmod, const s
 		DBG("search %s\n", se->builtin ? "built-in" : se->path);
 		if (se->builtin)
 			bprio = i;
-		else if (newlen >= se->len &&
+		else if (newlen > se->len && newpath[se->len] == '/' &&
 			 memcmp(se->path, newpath, se->len) == 0)
 			newprio = i;
-		else if (oldlen >= se->len &&
+		else if (oldlen > se->len && oldpath[se->len] == '/' &&
 			 memcmp(se->path, oldpath, se->len) == 0)
 			oldprio = i;
 	}
-- 
1.8.1.5

