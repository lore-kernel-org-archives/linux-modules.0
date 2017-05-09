Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: [PATCHv2 1/4] depmod: create depmod dir independent search function
Date: Tue,  9 May 2017 22:09:21 +0300
Message-Id: <20170509190924.9087-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20170509190924.9087-1-yauheni.kaliuta@redhat.com>
References: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
 <20170509190924.9087-1-yauheni.kaliuta@redhat.com>
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
index ded64500a50f..cfed864ff6c1 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1191,29 +1191,42 @@ static int depmod_modules_search_dir(struct depmod *depmod, DIR *d, size_t basel
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
2.12.2.639.g584f8975d2d9
