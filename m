Return-Path: <SRS0=eugf=O2=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25537C43613
	for <linux-modules@archiver.kernel.org>; Mon, 17 Dec 2018 22:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A4521473
	for <linux-modules@archiver.kernel.org>; Mon, 17 Dec 2018 22:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeLQWqt (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:46:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:60898 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732023AbeLQWqt (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 17 Dec 2018 17:46:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F20EEB041;
        Mon, 17 Dec 2018 22:46:47 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v3 2/3] depmod: prevent module dependency files corruption due to parallel invocation.
Date:   Mon, 17 Dec 2018 23:46:28 +0100
Message-Id: <20181217224629.22687-3-msuchanek@suse.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217224629.22687-1-msuchanek@suse.de>
References: <20181207154557.5865-1-msuchanek@suse.de>
 <20181217224629.22687-1-msuchanek@suse.de>
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
v3:
 - remove superfluous code to terminate the string - snprintf should do
 it
 - remove superfluous O_TRUNC - not needed with O_EXCL
---
 tools/depmod.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 18c0d61b2db3..0f7e33ccfd59 100644
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
@@ -2416,11 +2420,12 @@ static int depmod_output(struct depmod *depmod, FILE *out)
 		int r, ferr;
 
 		if (fp == NULL) {
-			int flags = O_CREAT | O_TRUNC | O_WRONLY;
+			int flags = O_CREAT | O_EXCL | O_WRONLY;
 			int mode = 0644;
 			int fd;
 
-			snprintf(tmp, sizeof(tmp), "%s.tmp", itr->name);
+			snprintf(tmp, sizeof(tmp), "%s.%i.%li.%li", itr->name, getpid(),
+					tv.tv_usec, tv.tv_sec);
 			fd = openat(dfd, tmp, flags, mode);
 			if (fd < 0) {
 				ERR("openat(%s, %s, %o, %o): %m\n",
-- 
2.19.2

