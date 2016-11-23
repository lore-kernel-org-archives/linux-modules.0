Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938747AbcKWPWr (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 23 Nov 2016 10:22:47 -0500
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules@vger.kernel.org
Cc: aris@redhat.com, Lucas De Marchi <lucas.demarchi@intel.com>,
        yauheni.kaliuta@redhat.com
Subject: [PATCH RFC 3/3] depmod: implement external directories support
Date: Wed, 23 Nov 2016 17:23:39 +0200
Message-Id: <20161123152339.27531-4-yauheni.kaliuta@redhat.com>
In-Reply-To: <20161123152339.27531-1-yauheni.kaliuta@redhat.com>
References: <20161123152339.27531-1-yauheni.kaliuta@redhat.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

The idea is to add a configuration keyword, external, which
will list directories for scanning for particular kernel version
mask:

external 4.10 /the/modules/dir /second/modules/dir

And extend "search" keyword to set it's priority with pseudo dir
"external" (as it's done for built-in):

search subdir external subdir2 built-in subdir3

(actually, the version is the same as for override keyword: * or
posix regexp, so example above is a bit incorrect).

All other logic left the same: if there are duplicates, only one
is under consideration and it is unloadable if it is bad.

The resulting modules.dep will contain entries a-la:

/the/modules/dir/module1.ko:
kernel/module2.ko: /the/modules/dir/module1.ko

(here /lib/modules/$(uname -r)/kernel/module2.ko depends of
symbols, provided by /the/modules/dir/module1.ko and external has
higher priority).

modprobe and modinfo understand it out of box.

This is a pretty simple extention of existing logic, since now
depmod already is able to:

a) scan modules with full path from command line without -a
switch;
b) detects broken symbol dependencies and broken modversions,
what assumes, that modules are already are not built for the
existing kernel.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/depmod.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 150 insertions(+), 22 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 81360a651811..5eb22032ead7 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -45,6 +45,7 @@
 static int verbose = DEFAULT_VERBOSE;
 
 static const char CFG_BUILTIN_KEY[] = "built-in";
+static const char CFG_EXTERNAL_KEY[] = "external";
 static const char *default_cfg_paths[] = {
 	"/run/depmod.d",
 	SYSCONFDIR "/depmod.d",
@@ -433,9 +434,21 @@ struct cfg_override {
 	char path[];
 };
 
+enum search_type {
+	SEARCH_PATH,
+	SEARCH_BUILTIN,
+	SEARCH_EXTERNAL
+};
+
 struct cfg_search {
 	struct cfg_search *next;
-	uint8_t builtin;
+	enum search_type type;
+	size_t len;
+	char path[];
+};
+
+struct cfg_external {
+	struct cfg_external *next;
 	size_t len;
 	char path[];
 };
@@ -450,15 +463,27 @@ struct cfg {
 	uint8_t warn_dups;
 	struct cfg_override *overrides;
 	struct cfg_search *searches;
+	struct cfg_external *externals;
 };
 
+static enum search_type cfg_define_search_type(const char *path)
+{
+	if (streq(path, CFG_BUILTIN_KEY))
+		return SEARCH_BUILTIN;
+	if (streq(path, CFG_EXTERNAL_KEY))
+		return SEARCH_EXTERNAL;
+	return SEARCH_PATH;
+}
+
 static int cfg_search_add(struct cfg *cfg, const char *path)
 {
 	struct cfg_search *s;
 	size_t len;
-	uint8_t builtin = streq(path, CFG_BUILTIN_KEY);
+	enum search_type type;
+
+	type = cfg_define_search_type(path);
 
-	if (builtin)
+	if (type != SEARCH_PATH)
 		len = 0;
 	else
 		len = strlen(path) + 1;
@@ -468,15 +493,15 @@ static int cfg_search_add(struct cfg *cfg, const char *path)
 		ERR("search add: out of memory\n");
 		return -ENOMEM;
 	}
-	s->builtin = builtin;
-	if (builtin)
+	s->type = type;
+	if (type != SEARCH_PATH)
 		s->len = 0;
 	else {
 		s->len = len - 1;
 		memcpy(s->path, path, len);
 	}
 
-	DBG("search add: %s, builtin=%hhu\n", path, builtin);
+	DBG("search add: %s, search type=%hhu\n", path, type);
 
 	s->next = cfg->searches;
 	cfg->searches = s;
@@ -524,6 +549,32 @@ static void cfg_override_free(struct cfg_override *o)
 	free(o);
 }
 
+static int cfg_external_add(struct cfg *cfg, const char *path)
+{
+	struct cfg_external *ext;
+	size_t len = strlen(path);
+
+	ext = malloc(sizeof(struct cfg_external) + len + 1);
+	if (ext == NULL) {
+		ERR("external add: out of memory\n");
+		return -ENOMEM;
+	}
+
+	strcpy(ext->path, path);
+	ext->len = len;
+
+	DBG("external add: %s\n", ext->path);
+
+	ext->next = cfg->externals;
+	cfg->externals = ext;
+	return 0;
+}
+
+static void cfg_external_free(struct cfg_external *ext)
+{
+	free(ext);
+}
+
 static int cfg_kernel_matches(const struct cfg *cfg, const char *pattern)
 {
 	regex_t re;
@@ -587,6 +638,20 @@ static int cfg_file_parse(struct cfg *cfg, const char *filename)
 			}
 
 			cfg_override_add(cfg, modname, subdir);
+		} else if (streq(cmd, "external")) {
+			const char *version = strtok_r(NULL, "\t ", &saveptr);
+			const char *dir = strtok_r(NULL, "\t ", &saveptr);
+
+			if (version == NULL || dir == NULL)
+				goto syntax_error;
+
+			if (!cfg_kernel_matches(cfg, version)) {
+				INF("%s:%u: external directory did not match %s\n",
+				    filename, linenum, version);
+				goto done_next;
+			}
+
+			cfg_external_add(cfg, dir);
 		} else if (streq(cmd, "include")
 				|| streq(cmd, "make_map_files")) {
 			INF("%s:%u: command %s not implemented yet\n",
@@ -781,6 +846,12 @@ static void cfg_free(struct cfg *cfg)
 		cfg->searches = cfg->searches->next;
 		cfg_search_free(tmp);
 	}
+
+	while (cfg->externals) {
+		struct cfg_external *tmp = cfg->externals;
+		cfg->externals = cfg->externals->next;
+		cfg_external_free(tmp);
+	}
 }
 
 
@@ -988,6 +1059,33 @@ static int depmod_module_del(struct depmod *depmod, struct mod *mod)
 	return 0;
 }
 
+static const char *search_to_string(const struct cfg_search *s)
+{
+	switch(s->type) {
+	case SEARCH_EXTERNAL:
+		return "external";
+	case SEARCH_BUILTIN:
+		return "built-in";
+	default:
+		return s->path;
+	}
+}
+
+static bool depmod_is_path_starts_with(const char *path,
+				       size_t pathlen,
+				       const char *prefix,
+				       size_t prefix_len)
+{
+	if (pathlen <= prefix_len)
+		return false;
+	if (path[prefix_len] != '/')
+		return false;
+	if (memcmp(path, prefix, prefix_len) != 0)
+		return false;
+
+	return true;
+}
+
 /* returns if existing module @mod is higher priority than newpath.
  * note this is the inverse of module-init-tools is_higher_priority()
  */
@@ -996,6 +1094,7 @@ static int depmod_module_is_higher_priority(const struct depmod *depmod, const s
 	const struct cfg *cfg = depmod->cfg;
 	const struct cfg_override *ov;
 	const struct cfg_search *se;
+	const struct cfg_external *ext;
 
 	/* baselen includes the last '/' and mod->baselen doesn't. So it's
 	 * actually correct to use modnamelen in the first and modnamesz in
@@ -1004,35 +1103,55 @@ static int depmod_module_is_higher_priority(const struct depmod *depmod, const s
 	size_t oldlen = mod->baselen + mod->modnamesz;
 	const char *oldpath = mod->path;
 	int i, bprio = -1, oldprio = -1, newprio = -1;
-
-	assert(strncmp(newpath, cfg->dirname, cfg->dirnamelen) == 0);
-	assert(strncmp(oldpath, cfg->dirname, cfg->dirnamelen) == 0);
-
-	newpath += cfg->dirnamelen + 1;
-	newlen -= cfg->dirnamelen + 1;
-	oldpath += cfg->dirnamelen + 1;
-	oldlen -= cfg->dirnamelen + 1;
+	size_t relnewlen = 0;
+	size_t reloldlen = 0;
+	const char *relnewpath = NULL;
+	const char *reloldpath = NULL;
 
 	DBG("comparing priorities of %s and %s\n",
 	    oldpath, newpath);
 
+	if (strncmp(newpath, cfg->dirname, cfg->dirnamelen) == 0) {
+		relnewpath = newpath + cfg->dirnamelen + 1;
+		relnewlen = newlen - cfg->dirnamelen + 1;
+	}
+	if (strncmp(oldpath, cfg->dirname, cfg->dirnamelen) == 0) {
+		reloldpath = oldpath + cfg->dirnamelen + 1;
+		reloldlen = oldlen - cfg->dirnamelen + 1;
+	}
+
 	for (ov = cfg->overrides; ov != NULL; ov = ov->next) {
 		DBG("override %s\n", ov->path);
-		if (newlen == ov->len && memcmp(ov->path, newpath, newlen) == 0)
+		if (relnewlen == ov->len &&
+		    memcmp(ov->path, relnewpath, relnewlen) == 0)
 			return 0;
-		if (oldlen == ov->len && memcmp(ov->path, oldpath, oldlen) == 0)
+		if (reloldlen == ov->len &&
+		    memcmp(ov->path, reloldpath, reloldlen) == 0)
 			return 1;
 	}
 
 	for (i = 0, se = cfg->searches; se != NULL; se = se->next, i++) {
-		DBG("search %s\n", se->builtin ? "built-in" : se->path);
-		if (se->builtin)
+		DBG("search %s\n", search_to_string(se));
+		if (se->type == SEARCH_BUILTIN)
 			bprio = i;
-		else if (newlen > se->len && newpath[se->len] == '/' &&
-			 memcmp(se->path, newpath, se->len) == 0)
+		else if (se->type == SEARCH_EXTERNAL) {
+			for (ext = cfg->externals; ext != NULL; ext = ext->next, i++) {
+				if (depmod_is_path_starts_with(newpath,
+							       newlen,
+							       ext->path,
+							       ext->len))
+					newprio = i;
+				if (depmod_is_path_starts_with(oldpath,
+							       oldlen,
+							       ext->path,
+							       ext->len))
+					oldprio = i;
+			}
+		} else if (relnewlen > se->len && relnewpath[se->len] == '/' &&
+			 memcmp(se->path, relnewpath, se->len) == 0)
 			newprio = i;
-		else if (oldlen > se->len && oldpath[se->len] == '/' &&
-			 memcmp(se->path, oldpath, se->len) == 0)
+		else if (reloldlen > se->len && reloldpath[se->len] == '/' &&
+			 memcmp(se->path, reloldpath, se->len) == 0)
 			oldprio = i;
 	}
 
@@ -1215,10 +1334,19 @@ static int depmod_modules_search_path(struct depmod *depmod,
 static int depmod_modules_search(struct depmod *depmod)
 {
 	int err;
+	struct cfg_external *ext;
 
 	err = depmod_modules_search_path(depmod, depmod->cfg->dirname);
 	if (err < 0)
 		return err;
+
+	for (ext = depmod->cfg->externals; ext != NULL; ext = ext->next) {
+		err = depmod_modules_search_path(depmod, ext->path);
+		if (err < 0 && err == -ENOENT)
+			/* ignore external dir absense */
+			continue;
+	}
+
 	return 0;
 }
 
-- 
2.9.3

