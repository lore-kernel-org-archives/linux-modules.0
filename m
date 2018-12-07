Return-Path: <SRS0=TU6G=OQ=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A94C07E85
	for <linux-modules@archiver.kernel.org>; Fri,  7 Dec 2018 15:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D73920837
	for <linux-modules@archiver.kernel.org>; Fri,  7 Dec 2018 15:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D73920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeLGPqC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:46:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:60648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbeLGPqC (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 7 Dec 2018 10:46:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83929ADCE
        for <linux-modules@vger.kernel.org>; Fri,  7 Dec 2018 15:46:00 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] depmod: Prevent module dependency files corruption due to parallel invocation.
Date:   Fri,  7 Dec 2018 16:45:57 +0100
Message-Id: <20181207154557.5865-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.19.2
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
Adding PID and random number to the filename should be reasonably
reliable. Adding O_EXCL as mkstemp does fails creating the file rather
than corrupting existing file.

Also prevent dependency files missing. This happens because target files
are removed before renaming the temporary file.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 tools/depmod.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 989d9077926c..5526ac892cf8 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -29,6 +29,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <sys/stat.h>
+#include <sys/time.h>
 #include <sys/utsname.h>
 
 #include <shared/array.h>
@@ -2398,6 +2399,10 @@ static int depmod_output(struct depmod *depmod, FILE *out)
 	};
 	const char *dname = depmod->cfg->dirname;
 	int dfd, err = 0;
+	struct timeval tv;
+
+	gettimeofday(&tv, NULL);
+	srand(tv.tv_sec);
 
 	if (out != NULL)
 		dfd = -1;
@@ -2412,15 +2417,17 @@ static int depmod_output(struct depmod *depmod, FILE *out)
 
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
+			snprintf(tmp, sizeof(tmp), "%s.%i.%i", itr->name, getpid(),
+					rand());
+			tmp[NAME_MAX] = 0;
 			fd = openat(dfd, tmp, flags, mode);
 			if (fd < 0) {
 				ERR("openat(%s, %s, %o, %o): %m\n",
@@ -2451,7 +2458,6 @@ static int depmod_output(struct depmod *depmod, FILE *out)
 			break;
 		}
 
-		unlinkat(dfd, itr->name, 0);
 		if (renameat(dfd, tmp, dfd, itr->name) != 0) {
 			err = -errno;
 			CRIT("renameat(%s, %s, %s, %s): %m\n",
-- 
2.19.2

