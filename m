Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F60C77B7C
	for <linux-modules@archiver.kernel.org>; Sun, 21 May 2023 09:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjEUJm0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 21 May 2023 05:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjEUJmU (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 21 May 2023 05:42:20 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8A0ED
        for <linux-modules@vger.kernel.org>; Sun, 21 May 2023 02:42:18 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2ea0:0:640:a1b2:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id D98B260047
        for <linux-modules@vger.kernel.org>; Sun, 21 May 2023 12:42:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2gcQMu6Wo8c0-O58qaOEp;
        Sun, 21 May 2023 12:42:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1684662134;
        bh=+W1ebVQ8wxAxVdRhQKJhM/aCMtTw/BgUPYu/MF11KIc=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=LtdloUYZT4eKv+k4OORUuNuWFiy+ndZZSc8vVCEFTlFJnMH0oM4bAGgshbZzQ0znt
         KqXcMnZTRqPX0lcNmGEGEcZOOkov82RLZ+8daLH9aV9LRXk2KGULHoWhBRvdeT8M9q
         rF/x6i+R+6ooi8FYB4TtTY9s9NGSiXGjY2FYdafc=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     linux-modules@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] depmod: simplify and cleanup depmod_modules_sort()
Date:   Sun, 21 May 2023 12:41:58 +0300
Message-Id: <20230521094158.81384-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

In depmod_modules_sort(), there is no particular reason to read
modules.order twice. For sorting purposes, it's enough to assign
keys (sort indexes) to line number - UINT_MAX (assuming that
modules.order can't contain more than UINT_MAX lines in total).

Check for more possible errors, return convenient error codes
and handle the latter in do_depmod() as well.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 tools/depmod.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index a15126e..de6669e 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1479,18 +1479,18 @@ static FILE *dfdopen(const char *dname, const char *filename, int flags,
 	return ret;
 }
 
-
-
-static void depmod_modules_sort(struct depmod *depmod)
+static int depmod_modules_sort(struct depmod *depmod)
 {
 	char line[PATH_MAX];
 	const char *order_file = "modules.order";
 	FILE *fp;
-	unsigned idx = 0, total = 0;
+	int ret = 0;
+	struct mod *mod;
+	unsigned idx = 0;
 
 	fp = dfdopen(depmod->cfg->dirname, order_file, O_RDONLY, "r");
 	if (fp == NULL)
-		return;
+		return -errno;
 
 	while (fgets(line, sizeof(line), fp) != NULL) {
 		size_t len = strlen(line);
@@ -1500,35 +1500,33 @@ static void depmod_modules_sort(struct depmod *depmod)
 		if (line[len - 1] != '\n') {
 			ERR("%s/%s:%u corrupted line misses '\\n'\n",
 				depmod->cfg->dirname, order_file, idx);
+			ret = -EINVAL;
 			goto corrupted;
 		}
-	}
-	total = idx + 1;
-	idx = 0;
-	fseek(fp, 0, SEEK_SET);
-	while (fgets(line, sizeof(line), fp) != NULL) {
-		size_t len = strlen(line);
-		struct mod *mod;
-
-		idx++;
-		if (len == 0)
-			continue;
 		line[len - 1] = '\0';
-
 		mod = hash_find(depmod->modules_by_uncrelpath, line);
 		if (mod == NULL)
 			continue;
-		mod->sort_idx = idx - total;
+		mod->sort_idx = idx - UINT_MAX;
+	}
+
+	if (ferror(fp)) {
+		ERR("error reading %s/%s (%s)\n", depmod->cfg->dirname,
+		    order_file, strerror(errno));
+		ret = -errno;
+		goto corrupted;
 	}
 
 	array_sort(&depmod->modules, mod_cmp);
+
 	for (idx = 0; idx < depmod->modules.count; idx++) {
-		struct mod *m = depmod->modules.array[idx];
-		m->idx = idx;
+		mod = depmod->modules.array[idx];
+		mod->idx = idx;
 	}
 
 corrupted:
 	fclose(fp);
+	return ret;
 }
 
 static int depmod_symbol_add(struct depmod *depmod, const char *name,
@@ -3125,7 +3123,9 @@ static int do_depmod(int argc, char *argv[])
 		goto cmdline_modules_failed;
 	}
 
-	depmod_modules_sort(&depmod);
+	err = depmod_modules_sort(&depmod);
+	if (err < 0 && err != -ENOENT)
+		goto cmdline_modules_failed;
 	err = depmod_load(&depmod);
 	if (err < 0)
 		goto cmdline_modules_failed;
-- 
2.40.1

