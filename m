Return-Path: <SRS0=8Ewy=4J=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A262C35656
	for <linux-modules@archiver.kernel.org>; Fri, 21 Feb 2020 16:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFEE24656
	for <linux-modules@archiver.kernel.org>; Fri, 21 Feb 2020 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582304022;
	bh=+dBalqeHbkB16OOHh7t+joA5Fmqf1qQkMMbnAWtR1R8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=u5HU/eXh8/whqjweuioxt206lvNwM+ez1MZhkhHzwJcHGIHQvZVKNHQOMGKZ1cGUE
	 PRpkqdDfKPv75WzoKnnV/Hc3RTF6P4lEuXZu/jbMgHfC/IAPSBiE/7zD9hvc0p+e6g
	 Gzb2lR/Lt8U04w7onfuM1UH8ImQ2Zah6p9BmkN5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBUQxm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:53:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgBUQxm (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 21 Feb 2020 11:53:42 -0500
Received: from linux-8ccs.suse.de (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987FA222C4;
        Fri, 21 Feb 2020 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582304021;
        bh=+dBalqeHbkB16OOHh7t+joA5Fmqf1qQkMMbnAWtR1R8=;
        h=From:To:Cc:Subject:Date:From;
        b=A66owhOGHOa6wBqb4GUoeFsiYUISWXY4hnRpDjhzoy4ietrCJE3t5hlGzYQSXuwXM
         Mli13dfnsWcZNC+0jPas/lv5vaFJSUyO1UFKNrVFhqxLBqIhod1waraxjqRqNpca1y
         wuPntloLi2yHMLnITPThJG6ZOjtASpL2TEoQiI74=
From:   Jessica Yu <jeyu@kernel.org>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Matthias Maennich <maennich@google.com>,
        linux-modules@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] depmod: account for new namespace field in Module.symvers (for kernel versions >= 5.4)
Date:   Fri, 21 Feb 2020 17:52:43 +0100
Message-Id: <20200221165243.25100-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

depmod -e -E is broken for kernel versions >= 5.4, because a new
namespace field was added to Module.symvers. Each line is tab delimited
with 5 fields in total. E.g.,

	0xb352177e\tfind_first_bit\tnamespace\tvmlinux\tEXPORT_SYMBOL

When a symbol doesn't have a namespace, then the namespace field is empty:

	0xb352177e\tfind_first_bit\t\tvmlinux\tEXPORT_SYMBOL

Fix up depmod_load_symvers() so it finds the crc, symbol, and module
("where") fields correctly. Since there can be empty fields, strsep() is
used instead of strtok(), since strtok() cannot handle empty fields
(i.e., two delimiters in succession).

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---

Hi,

I was not sure what the best way of determining the symvers format was. I
guess counting delimiters isn't the prettiest way, but if anyone has a
better idea, let me know. Thanks!

 tools/depmod.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index fbbce10..c5b9612 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2577,7 +2577,9 @@ static int depmod_load_symvers(struct depmod *depmod, const char *filename)
 {
 	char line[10240];
 	FILE *fp;
-	unsigned int linenum = 0;
+	unsigned int linenum = 0, cnt = 0;
+	bool uses_namespaces = false;
+	char *ptr;
 
 	fp = fopen(filename, "r");
 	if (fp == NULL) {
@@ -2587,7 +2589,26 @@ static int depmod_load_symvers(struct depmod *depmod, const char *filename)
 	}
 	DBG("load symvers: %s\n", filename);
 
-	/* eg. "0xb352177e\tfind_first_bit\tvmlinux\tEXPORT_SYMBOL" */
+	/*
+	 * First, check for >=5.4 Module.symvers format:
+	 * "0xb352177e\tfind_first_bit\tnamespace\tvmlinux\tEXPORT_SYMBOL"
+	 * If there are 5 fields (4 tabs), assume we're using the new format.
+	 */
+	fgets(line, sizeof(line), fp);
+	ptr = line;
+	while ((ptr = strchr(ptr, '\t')) != NULL) {
+		cnt++;
+		ptr++;
+	}
+	if (cnt > 3)
+		uses_namespaces = true;
+	rewind(fp);
+
+	/*
+	 * eg. "0xb352177e\tfind_first_bit\tvmlinux\tEXPORT_SYMBOL"
+	 * Or if kernel version >=5.4:
+	 * "0xb352177e\tfind_first_bit\tnamespace\tvmlinux\tEXPORT_SYMBOL"
+	 */
 	while (fgets(line, sizeof(line), fp) != NULL) {
 		const char *ver, *sym, *where;
 		char *verend;
@@ -2595,9 +2616,13 @@ static int depmod_load_symvers(struct depmod *depmod, const char *filename)
 
 		linenum++;
 
-		ver = strtok(line, " \t");
-		sym = strtok(NULL, " \t");
-		where = strtok(NULL, " \t");
+		ptr = (char *)line;
+		ver = strsep(&ptr, "\t");
+		sym = strsep(&ptr, "\t");
+		if (uses_namespaces) /* skip namespace field */
+			strsep(&ptr, "\t");
+		where = strsep(&ptr, "\t");
+
 		if (!ver || !sym || !where)
 			continue;
 
-- 
2.16.4

