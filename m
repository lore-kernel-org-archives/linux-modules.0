Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: [PATCH 2/2] depmod: module_is_higher_priority: fix modname length calculation
Date: Thu,  7 Dec 2017 21:16:08 +0200
Message-Id: <20171207191608.14293-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20171207191608.14293-1-yauheni.kaliuta@redhat.com>
References: <20171207191608.14293-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

depmod_module_is_higher_priority checks module's path if it is under
module root directory and if so uses relative to the root path to
lookup the module in override and search lists.

Originally only relative path was used in the function, so the
variables with full path and and path length were changed:

       newpath += cfg->dirnamelen + 1;
       newlen -= cfg->dirnamelen + 1;
       oldpath += cfg->dirnamelen + 1;
       oldlen -= cfg->dirnamelen + 1;

Commit 7da6884e7357ac05772e90f6d7e63b1948103fc4 (depmod: implement
external directories support) changed the logic since it need the
full path to the module for comparations as well.

Unfortunately, it introduce a mistake in calculation of the relative
paths replacing '-=' with assignment to a new variable -- the
'cfg->dirnamelen + 1' value must be substracted all together. It
breaks, for example, overrides lookup.

Fix the calculation by putting braces around the value in the
subsctuction expression.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/depmod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 7ff3e9ed191e..921dc5cc93eb 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1118,11 +1118,11 @@ static int depmod_module_is_higher_priority(const struct depmod *depmod, const s
 
 	if (strncmp(newpath, cfg->dirname, cfg->dirnamelen) == 0) {
 		relnewpath = newpath + cfg->dirnamelen + 1;
-		relnewlen = newlen - cfg->dirnamelen + 1;
+		relnewlen = newlen - (cfg->dirnamelen + 1);
 	}
 	if (strncmp(oldpath, cfg->dirname, cfg->dirnamelen) == 0) {
 		reloldpath = oldpath + cfg->dirnamelen + 1;
-		reloldlen = oldlen - cfg->dirnamelen + 1;
+		reloldlen = oldlen - (cfg->dirnamelen + 1);
 	}
 
 	for (ov = cfg->overrides; ov != NULL; ov = ov->next) {
-- 
2.15.1
