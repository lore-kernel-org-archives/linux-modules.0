Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935350AbcKWPWo (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 23 Nov 2016 10:22:44 -0500
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules@vger.kernel.org
Cc: aris@redhat.com, Lucas De Marchi <lucas.demarchi@intel.com>,
        yauheni.kaliuta@redhat.com
Subject: [PATCH RFC 1/3] depmod: create depmod dir independent search function
Date: Wed, 23 Nov 2016 17:23:37 +0200
Message-Id: <20161123152339.27531-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20161123152339.27531-1-yauheni.kaliuta@redhat.com>
References: <20161123152339.27531-1-yauheni.kaliuta@redhat.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Prepare to implement external directories support.

The patch splits depmod_modules_search() function to two
functions: depmod_modules_search(), called by the high level with
intention to search all possible modules, and
depmod_module_search_path(), which takes path as a parameter and
scans modules under the path only. Initially it is used to scan
the same depmod->cfg->dirname path only.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/depmod.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index f2b370f146bb..a96501d1cbfb 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1186,29 +1186,42 @@ static int depmod_modules_search_dir(struct depmod *depmod, DIR *d, size_t basel
 	return err;
 }
 
-static int depmod_modules_search(struct depmod *depmod)
+static int depmod_modules_search_path(struct depmod *depmod,
+				      const char *path)
 {
-	char path[PATH_MAX];
-	DIR *d = opendir(depmod->cfg->dirname);
+	char path_buf[PATH_MAX];
+	DIR *d;
 	size_t baselen;
 	int err;
+
+	d = opendir(path);
 	if (d == NULL) {
 		err = -errno;
-		ERR("could not open directory %s: %m\n", depmod->cfg->dirname);
+		ERR("could not open directory %s: %m\n", path);
 		return err;
 	}
 
-	baselen = depmod->cfg->dirnamelen;
-	memcpy(path, depmod->cfg->dirname, baselen);
-	path[baselen] = '/';
+	baselen = strlen(path);
+	memcpy(path_buf, path, baselen);
+	path_buf[baselen] = '/';
 	baselen++;
-	path[baselen] = '\0';
+	path_buf[baselen] = '\0';
 
-	err = depmod_modules_search_dir(depmod, d, baselen, path);
+	err = depmod_modules_search_dir(depmod, d, baselen, path_buf);
 	closedir(d);
 	return err;
 }
 
+static int depmod_modules_search(struct depmod *depmod)
+{
+	int err;
+
+	err = depmod_modules_search_path(depmod, depmod->cfg->dirname);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
 static int mod_cmp(const void *pa, const void *pb) {
 	const struct mod *a = *(const struct mod **)pa;
 	const struct mod *b = *(const struct mod **)pb;
-- 
2.9.3

