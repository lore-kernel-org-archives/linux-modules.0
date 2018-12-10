Return-Path: <SRS0=3Epf=OT=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64E7C6783B
	for <linux-modules@archiver.kernel.org>; Mon, 10 Dec 2018 21:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935D620821
	for <linux-modules@archiver.kernel.org>; Mon, 10 Dec 2018 21:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935D620821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeLJV3w (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:29:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:35792 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728059AbeLJV3w (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 10 Dec 2018 16:29:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61B12AEF3
        for <linux-modules@vger.kernel.org>; Mon, 10 Dec 2018 21:29:50 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v2 2/3] depmod: prevent module dependency files corruption due to parallel invocation.
Date:   Mon, 10 Dec 2018 22:29:33 +0100
Message-Id: <636a25c106ac3da29803025248a237e9d23f4e9d.1544476531.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1544476531.git.msuchanek@suse.de>
References: <cover.1544476531.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Depmod does not use unique filename for temporary files. There is no
guarantee the user does not attempt to run mutiple depmod processes in
parallel. If that happens a temporary file might be created by
depmod(1st), truncated by depmod(2nd), and renamed to final name by
depmod(1st) resulting in corrupted file seen by user.

Due to missing mkstempat() this is more complex than it should be.
Adding PID and timestamp to the filename should be reasonably reliable.
Adding O_EXCL as mkstemp does fails creating the file rather than
corrupting existing file.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 tools/depmod.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 18c0d61b2db3..3b6d16e76160 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -29,6 +29,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <sys/stat.h>
+#include <sys/time.h>
 #include <sys/utsname.h>
 
 #include <shared/array.h>
@@ -2398,6 +2399,9 @@ static int depmod_output(struct depmod *depmod, FILE *out)
 	};
 	const char *dname = depmod->cfg->dirname;
 	int dfd, err = 0;
+	struct timeval tv;
+
+	gettimeofday(&tv, NULL);
 
 	if (out != NULL)
 		dfd = -1;
@@ -2412,15 +2416,17 @@ static int depmod_output(struct depmod *depmod, FILE *out)
 
 	for (itr = depfiles; itr->name != NULL; itr++) {
 		FILE *fp = out;
-		char tmp[NAME_MAX] = "";
+		char tmp[NAME_MAX + 1] = "";
 		int r, ferr;
 
 		if (fp == NULL) {
-			int flags = O_CREAT | O_TRUNC | O_WRONLY;
+			int flags = O_CREAT | O_TRUNC | O_WRONLY | O_EXCL;
 			int mode = 0644;
 			int fd;
 
-			snprintf(tmp, sizeof(tmp), "%s.tmp", itr->name);
+			snprintf(tmp, sizeof(tmp), "%s.%i.%li.%li", itr->name, getpid(),
+					tv.tv_usec, tv.tv_sec);
+			tmp[NAME_MAX] = 0;
 			fd = openat(dfd, tmp, flags, mode);
 			if (fd < 0) {
 				ERR("openat(%s, %s, %o, %o): %m\n",
-- 
2.19.2

