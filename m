Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935350AbcKWPWq (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 23 Nov 2016 10:22:46 -0500
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules@vger.kernel.org
Cc: aris@redhat.com, Lucas De Marchi <lucas.demarchi@intel.com>,
        yauheni.kaliuta@redhat.com
Subject: [PATCH RFC 2/3] depmod: search key: move builtin detection under the add function
Date: Wed, 23 Nov 2016 17:23:38 +0200
Message-Id: <20161123152339.27531-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20161123152339.27531-1-yauheni.kaliuta@redhat.com>
References: <20161123152339.27531-1-yauheni.kaliuta@redhat.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Prepare to implement external directories support.

It's better to isolated behaviour difference under the
cfg_search_add() call, then make the client code aware of it.

In case of external modules/directories support, there will be
one more keyword added, so making the clients aware of it makes
even less sense.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/depmod.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index a96501d1cbfb..81360a651811 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -452,10 +452,11 @@ struct cfg {
 	struct cfg_search *searches;
 };
 
-static int cfg_search_add(struct cfg *cfg, const char *path, uint8_t builtin)
+static int cfg_search_add(struct cfg *cfg, const char *path)
 {
 	struct cfg_search *s;
 	size_t len;
+	uint8_t builtin = streq(path, CFG_BUILTIN_KEY);
 
 	if (builtin)
 		len = 0;
@@ -568,8 +569,7 @@ static int cfg_file_parse(struct cfg *cfg, const char *filename)
 		if (streq(cmd, "search")) {
 			const char *sp;
 			while ((sp = strtok_r(NULL, "\t ", &saveptr)) != NULL) {
-				uint8_t builtin = streq(sp, CFG_BUILTIN_KEY);
-				cfg_search_add(cfg, sp, builtin);
+				cfg_search_add(cfg, sp);
 			}
 		} else if (streq(cmd, "override")) {
 			const char *modname = strtok_r(NULL, "\t ", &saveptr);
@@ -763,7 +763,7 @@ static int cfg_load(struct cfg *cfg, const char * const *cfg_paths)
 	 * list here. But only if there was no "search" option specified.
 	 */
 	if (cfg->searches == NULL)
-		cfg_search_add(cfg, "updates", 0);
+		cfg_search_add(cfg, "updates");
 
 	return 0;
 }
-- 
2.9.3

