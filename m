Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:36611 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbaIVAVE (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sun, 21 Sep 2014 20:21:04 -0400
Received: by mail-qc0-f169.google.com with SMTP id r5so5470416qcx.0
        for <linux-modules@vger.kernel.org>; Sun, 21 Sep 2014 17:21:02 -0700 (PDT)
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
To: linux-modules@vger.kernel.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Subject: [PATCH] depmod: always initialize "deps" in mod_get_all_sorted_dependencies()
Date: Sun, 21 Sep 2014 21:20:54 -0300
Message-Id: <1411345254-239686-1-git-send-email-crrodriguez@opensuse.org>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Fixed Coverity CID #48861
---
 tools/depmod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index e90ff83..bcefa09 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1798,14 +1798,14 @@ static int mod_fill_all_unique_dependencies(const struct mod *mod, const struct
 
 static const struct mod **mod_get_all_sorted_dependencies(const struct mod *mod, size_t *n_deps)
 {
-	const struct mod **deps;
+	const struct mod **deps = NULL;
 	size_t last = 0;
 
 	*n_deps = mod_count_all_dependencies(mod);
 	if (*n_deps == 0)
 		return NULL;
 
-	deps = malloc(sizeof(struct mod *) * (*n_deps));
+	deps = calloc(1, sizeof(struct mod *) * (*n_deps));
 	if (deps == NULL)
 		return NULL;
 
-- 
2.1.0

