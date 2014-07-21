Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:49697 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933552AbaGUTes (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 21 Jul 2014 15:34:48 -0400
Received: by mail-yk0-f182.google.com with SMTP id q9so4220546ykb.41
        for <linux-modules@vger.kernel.org>; Mon, 21 Jul 2014 12:34:47 -0700 (PDT)
From: Daniel Hilst SellI <danielhilst@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Daniel Hilst SellI <danielhilst@gmail.com>
Subject: [PATCH] depmod: New option for m-i-t prior 3.6 compatibility
Date: Mon, 21 Jul 2014 16:33:52 -0300
Message-Id: <1405971232-1187-1-git-send-email-danielhilst@gmail.com>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

New option (-N, --no-relative) create databases with absolute paths.
This option is made to create databases compatible with
module-init-tools prior 3.6 version.
---
 man/depmod.xml | 16 ++++++++++++++++
 tools/depmod.c | 21 +++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/man/depmod.xml b/man/depmod.xml
index 380ee7d..ddcad32 100644
--- a/man/depmod.xml
+++ b/man/depmod.xml
@@ -49,6 +49,7 @@
       <arg><option>-E <replaceable>Module.symvers</replaceable></option></arg>
       <arg><option>-F <replaceable>System.map</replaceable></option></arg>
       <arg><option>-n</option></arg>
+      <arg><option>-N</option></arg>
       <arg><option>-v</option></arg>
       <arg><option>-A</option></arg>
       <arg><option>-P <replaceable>prefix</replaceable></option></arg>
@@ -63,6 +64,7 @@
       <arg><option>-F <replaceable>System.map</replaceable></option></arg>
       <arg><option>-m</option></arg>
       <arg><option>-n</option></arg>
+      <arg><option>-N</option></arg>
       <arg><option>-v</option></arg>
       <arg><option>-P <replaceable>prefix</replaceable></option></arg>
       <arg><option>-w</option></arg>
@@ -247,6 +249,20 @@
       </varlistentry>
       <varlistentry>
         <term>
+          <option>-N</option>
+        </term>
+        <term>
+          <option>--no-relative</option>
+        </term>
+        <listitem>
+          <para>
+            Don't use relative names on databases. Use this option if
+            your database is being used by module-init-tools prior 3.6.
+          </para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term>
           <option>-P</option>
         </term>
         <listitem>
diff --git a/tools/depmod.c b/tools/depmod.c
index e90ff83..137b541 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -48,7 +48,7 @@ static const char *default_cfg_paths[] = {
 	NULL
 };
 
-static const char cmdopts_s[] = "aAb:C:E:F:euqrvnP:wmVh";
+static const char cmdopts_s[] = "aAb:C:E:F:euqrvnNP:wmVh";
 static const struct option cmdopts[] = {
 	{ "all", no_argument, 0, 'a' },
 	{ "quick", no_argument, 0, 'A' },
@@ -63,6 +63,7 @@ static const struct option cmdopts[] = {
 	{ "verbose", no_argument, 0, 'v' },
 	{ "show", no_argument, 0, 'n' },
 	{ "dry-run", no_argument, 0, 'n' },
+	{ "--no-relative", no_argument, 0, 'N' },
 	{ "symbol-prefix", required_argument, 0, 'P' },
 	{ "warn", no_argument, 0, 'w' },
 	{ "map", no_argument, 0, 'm' }, /* deprecated */
@@ -85,6 +86,7 @@ static void help(void)
 		"\t-A, --quick          Only does the work if there's a new module\n"
 		"\t-e, --errsyms        Report not supplied symbols\n"
 		"\t-n, --show           Write the dependency file on stdout only\n"
+		"\t-N, --no-relative     Dont use relative paths on databases"
 		"\t-P, --symbol-prefix  Architecture symbol prefix\n"
 		"\t-C, --config=PATH    Read configuration from PATH\n"
 		"\t-v, --verbose        Enable verbose mode\n"
@@ -572,10 +574,12 @@ struct cfg {
 	const char *kversion;
 	char dirname[PATH_MAX];
 	size_t dirnamelen;
+	size_t basedirnamelen;
 	char sym_prefix;
 	uint8_t check_symvers;
 	uint8_t print_unknown;
 	uint8_t warn_dups;
+	uint8_t no_relative;
 	struct cfg_override *overrides;
 	struct cfg_search *searches;
 };
@@ -1067,9 +1071,12 @@ static int depmod_module_add(struct depmod *depmod, struct kmod_module *kmod)
 	lastslash = strrchr(mod->path, '/');
 	mod->baselen = lastslash - mod->path;
 	if (strncmp(mod->path, cfg->dirname, cfg->dirnamelen) == 0 &&
-			mod->path[cfg->dirnamelen] == '/')
-		mod->relpath = mod->path + cfg->dirnamelen + 1;
-	else
+	    mod->path[cfg->dirnamelen] == '/') {
+		if (cfg->no_relative)
+			mod->relpath = mod->path + cfg->basedirnamelen;
+		else
+			mod->relpath = mod->path + cfg->dirnamelen + 1;
+	} else
 		mod->relpath = NULL;
 
 	err = hash_add_unique(depmod->modules_by_name, mod->modname, mod);
@@ -2565,6 +2572,9 @@ static int do_depmod(int argc, char *argv[])
 		case 'n':
 			out = stdout;
 			break;
+		case 'N':
+			cfg.no_relative = 1;
+			break;
 		case 'P':
 			if (optarg[1] != '\0') {
 				CRIT("-P only takes a single char\n");
@@ -2617,6 +2627,9 @@ static int do_depmod(int argc, char *argv[])
 				  "%s/lib/modules/%s",
 				  root == NULL ? "" : root, cfg.kversion);
 
+	if (cfg.no_relative && root)
+		cfg.basedirnamelen = strlen(root);
+
 	if (optind == argc)
 		all = 1;
 
-- 
2.0.2

