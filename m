Return-Path: <SRS0=3Epf=OT=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EF7C67839
	for <linux-modules@archiver.kernel.org>; Mon, 10 Dec 2018 21:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCFB2084E
	for <linux-modules@archiver.kernel.org>; Mon, 10 Dec 2018 21:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCFB2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeLJV3w (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:29:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:35798 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728088AbeLJV3w (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 10 Dec 2018 16:29:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 951F3AF59
        for <linux-modules@vger.kernel.org>; Mon, 10 Dec 2018 21:29:50 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v2 3/3] depmod: shut up gcc insufficinet buffer warning.
Date:   Mon, 10 Dec 2018 22:29:34 +0100
Message-Id: <b45014c93b47d9100d0add3d9458e6ec29d0f188.1544476531.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1544476531.git.msuchanek@suse.de>
References: <cover.1544476531.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

In a couple of places depmod concatenates the module directory and filename
with snprintf. This can technically overflow creating an unterminated string if
module directory name is long. Use openat instead as is done elsewhere in
depmod. This avoids the snprintf, the extra buffer on stack, and the gcc
warning. It may even fix a corner case when the module direcotry name is just
under PATH_MAX.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 tools/depmod.c | 51 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 3b6d16e76160..fb76f823c016 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1389,19 +1389,42 @@ static int depmod_modules_build_array(struct depmod *depmod)
 	return 0;
 }
 
+static FILE * dfdopen(const char * dname, const char * filename, int flags, const char * mode)
+	{
+	int fd, dfd;
+	FILE * ret;
+
+	dfd = open(dname, O_RDONLY);
+	if (dfd < 0) {
+		WRN("could not open directory %s: %m\n", dname);
+		return NULL;
+	}
+
+	fd = openat(dfd, filename, flags);
+	if (fd < 0) {
+		WRN("could not open %s at %s: %m\n", filename, dname);
+		ret = NULL;
+	} else {
+		ret = fdopen(fd, mode);
+		if (!ret)
+			WRN("could not associate stream with %s: %m\n", filename);
+	}
+	close(dfd);
+	return ret;
+}
+
+
+
 static void depmod_modules_sort(struct depmod *depmod)
 {
-	char order_file[PATH_MAX], line[PATH_MAX];
+	char line[PATH_MAX];
+	const char * order_file = "modules.order";
 	FILE *fp;
 	unsigned idx = 0, total = 0;
 
-	snprintf(order_file, sizeof(order_file), "%s/modules.order",
-		 depmod->cfg->dirname);
-	fp = fopen(order_file, "r");
-	if (fp == NULL) {
-		WRN("could not open %s: %m\n", order_file);
+	fp = dfdopen(depmod->cfg->dirname, order_file, O_RDONLY, "r");
+	if (fp == NULL)
 		return;
-	}
 
 	while (fgets(line, sizeof(line), fp) != NULL) {
 		size_t len = strlen(line);
@@ -1409,8 +1432,8 @@ static void depmod_modules_sort(struct depmod *depmod)
 		if (len == 0)
 			continue;
 		if (line[len - 1] != '\n') {
-			ERR("%s:%u corrupted line misses '\\n'\n",
-				order_file, idx);
+			ERR("%s/%s:%u corrupted line misses '\\n'\n",
+				depmod->cfg->dirname, order_file, idx);
 			goto corrupted;
 		}
 	}
@@ -2287,18 +2310,14 @@ static int output_builtin_bin(struct depmod *depmod, FILE *out)
 {
 	FILE *in;
 	struct index_node *idx;
-	char infile[PATH_MAX], line[PATH_MAX], modname[PATH_MAX];
+	char line[PATH_MAX], modname[PATH_MAX];
 
 	if (out == stdout)
 		return 0;
 
-	snprintf(infile, sizeof(infile), "%s/modules.builtin",
-							depmod->cfg->dirname);
-	in = fopen(infile, "r");
-	if (in == NULL) {
-		WRN("could not open %s: %m\n", infile);
+	in = dfdopen(depmod->cfg->dirname, "modules.builtin", O_RDONLY, "r");
+	if (in == NULL)
 		return 0;
-	}
 
 	idx = index_create();
 	if (idx == NULL) {
-- 
2.19.2

