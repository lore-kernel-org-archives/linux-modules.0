Return-Path: <luto@amacapital.net>
Return-Path: <luto@amacapital.net>
From: Andy Lutomirski <luto@amacapital.net>
To: linux-modules <linux-modules@vger.kernel.org>,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH] Add --moddir to depmod and modprobe to override the target directory
Date: Fri, 28 Feb 2014 12:43:56 -0800
Message-Id: <2dfe2833a247d602a0038d28a3636a6d74bd1845.1393620082.git.luto@amacapital.net>
In-Reply-To: <CALCETrXs6o0t5hJutE-uz4a7q8eGqRuhCXwJwbog4B606P0+pw@mail.gmail.com>
References: <CALCETrXs6o0t5hJutE-uz4a7q8eGqRuhCXwJwbog4B606P0+pw@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>

Currently, depmod and modprobe can only use directories of the form
ROOT/lib/modules/VERSION, where ROOT and VERSION can be specified on
the command line.  Additionally, when used with explicitly-listed
modules depmod requires absolute paths, making it difficult to
generate a nonstandard module layout without symlink hacks and
absolute paths.

This lifts both restrictions with a new --moddir option.  --moddir
specifies an exact directory name and, when --moddir is used, depmod
will accept relative module paths on the command line.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 man/depmod.xml   | 29 +++++++++++++++++++++++++++++
 man/modprobe.xml | 18 ++++++++++++++++++
 tools/depmod.c   | 56 ++++++++++++++++++++++++++++++++++++++++++++------------
 tools/modprobe.c | 16 ++++++++++++++++
 4 files changed, 107 insertions(+), 12 deletions(-)

diff --git a/man/depmod.xml b/man/depmod.xml
index a9b61d9..1a8c10e 100644
--- a/man/depmod.xml
+++ b/man/depmod.xml
@@ -65,6 +65,7 @@
       <arg><option>-n</option></arg>
       <arg><option>-v</option></arg>
       <arg><option>-P <replaceable>prefix</replaceable></option></arg>
+      <arg><option>--moddir <replaceable>moddir</replaceable></option></arg>
       <arg><option>-w</option></arg>
       <arg><option><replaceable>version</replaceable></option></arg>
       <arg rep='repeat'><option><replaceable>filename</replaceable></option></arg>
@@ -148,6 +149,34 @@
             option if you are a distribution vendor who needs to pre-generate
             the meta-data files rather than running depmod again later.
           </para>
+	  <para>
+	    The <command>--moddir</command> option can be used instead.
+	  </para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term>
+          <option>--moddir <replaceable>moddir</replaceable></option>
+        </term>
+        <listitem>
+          <para>
+            If your modules are not currently in the (normal) directory
+            <filename>/lib/modules/</filename><replaceable>version</replaceable>,
+            but in a staging area, you can specify a
+            <replaceable>moddir</replaceable> to override the directory
+            in which <command>depmod</command> writes its output and
+            possibly searches for modules.
+	  </para>
+	  <para>
+	    If <command>--moddir</command> is specified, then module
+	    file names listed on the command line are permitted to use
+	    relative paths; relative paths will be interpreted relative
+	    to <replaceable>moddir</replaceable>.
+	  </para>
+	  <para>
+	    This option cannot be used with <command>-b</command> or
+	    with an explicit kernel version.
+          </para>
         </listitem>
       </varlistentry>
       <varlistentry>
diff --git a/man/modprobe.xml b/man/modprobe.xml
index 4c6c832..735acf1 100644
--- a/man/modprobe.xml
+++ b/man/modprobe.xml
@@ -407,6 +407,24 @@
       </varlistentry>
       <varlistentry>
         <term>
+          <option>--moddir <replaceable>moddir</replaceable></option>
+        </term>
+        <listitem>
+          <para>
+            If your modules are not currently in the (normal) directory
+            <filename>/lib/modules/</filename><replaceable>version</replaceable>,
+            but in a staging area, you can specify a
+            <replaceable>moddir</replaceable> to override the directory
+            in which <command>modprobe</command> searches.
+	  </para>
+	  <para>
+	    This option cannot be used with <command>--set-version</command> or
+	    <command>--dirname</command>.
+          </para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term>
           <option>--show-depends</option>
         </term>
         <listitem>
diff --git a/tools/depmod.c b/tools/depmod.c
index b1b5874..5cba93b 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -48,6 +48,9 @@ static const char *default_cfg_paths[] = {
 	NULL
 };
 
+enum LONGOPTS {
+	MODDIR_OPT = 1000,
+};
 static const char cmdopts_s[] = "aAb:C:E:F:euqrvnP:wmVh";
 static const struct option cmdopts[] = {
 	{ "all", no_argument, 0, 'a' },
@@ -66,6 +69,7 @@ static const struct option cmdopts[] = {
 	{ "symbol-prefix", required_argument, 0, 'P' },
 	{ "warn", no_argument, 0, 'w' },
 	{ "map", no_argument, 0, 'm' }, /* deprecated */
+	{ "moddir", required_argument, 0, MODDIR_OPT },
 	{ "version", no_argument, 0, 'V' },
 	{ "help", no_argument, 0, 'h' },
 	{ }
@@ -94,6 +98,8 @@ static void help(void)
 		"\n"
 		"The following options are useful for people managing distributions:\n"
 		"\t-b, --basedir=DIR    Use an image of a module tree.\n"
+		"\t--moddir=MODDIR      Specify a target directory and allow relative\n"
+		"\t                     paths.  Do not use -b or specify a version.\n"
 		"\t-F, --filesyms=FILE  Use the file instead of the\n"
 		"\t                     current kernel symbols.\n"
 		"\t-E, --symvers=FILE   Use Module.symvers file to check\n"
@@ -1045,7 +1051,8 @@ static void depmod_shutdown(struct depmod *depmod)
 	kmod_unref(depmod->ctx);
 }
 
-static int depmod_module_add(struct depmod *depmod, struct kmod_module *kmod)
+static int depmod_module_add(struct depmod *depmod, struct kmod_module *kmod,
+			     const char *relpath)
 {
 	const struct cfg *cfg = depmod->cfg;
 	const char *modname, *lastslash;
@@ -1070,11 +1077,14 @@ static int depmod_module_add(struct depmod *depmod, struct kmod_module *kmod)
 	mod->path = strdup(kmod_module_get_path(kmod));
 	lastslash = strrchr(mod->path, '/');
 	mod->baselen = lastslash - mod->path;
-	if (strncmp(mod->path, cfg->dirname, cfg->dirnamelen) == 0 &&
-			mod->path[cfg->dirnamelen] == '/')
+	if (relpath) {
+		mod->relpath = strdup(relpath);
+	} else if (strncmp(mod->path, cfg->dirname, cfg->dirnamelen) == 0 &&
+			mod->path[cfg->dirnamelen] == '/') {
 		mod->relpath = mod->path + cfg->dirnamelen + 1;
-	else
+	} else {
 		mod->relpath = NULL;
+	}
 
 	err = hash_add_unique(depmod->modules_by_name, mod->modname, mod);
 	if (err < 0) {
@@ -1082,7 +1092,7 @@ static int depmod_module_add(struct depmod *depmod, struct kmod_module *kmod)
 		goto fail;
 	}
 
-	if (mod->relpath != NULL) {
+	if (mod->relpath != NULL && !relpath) {
 		size_t uncrelpathlen = lastslash - mod->relpath + modnamelen
 				       + kmod_exts[KMOD_EXT_UNC].len;
 		mod->uncrelpath = memdup(mod->relpath, uncrelpathlen + 1);
@@ -1221,7 +1231,7 @@ add:
 		return err;
 	}
 
-	err = depmod_module_add(depmod, kmod);
+	err = depmod_module_add(depmod, kmod, NULL);
 	if (err < 0) {
 		ERR("could not add module %s: %s\n",
 		    path, strerror(-err));
@@ -2467,6 +2477,7 @@ static int do_depmod(int argc, char *argv[])
 	const char *system_map = NULL;
 	const char *module_symvers = NULL;
 	const char *null_kmod_config = NULL;
+	const char *moddir = NULL;
 	struct utsname un;
 	struct kmod_ctx *ctx = NULL;
 	struct cfg cfg;
@@ -2540,6 +2551,9 @@ static int do_depmod(int argc, char *argv[])
 				WRN("Ignored deprecated option -%c\n", c);
 
 			break;
+		case MODDIR_OPT:
+			moddir = optarg;
+			break;
 		case 'h':
 			help();
 			free(config_paths);
@@ -2556,7 +2570,14 @@ static int do_depmod(int argc, char *argv[])
 		}
 	}
 
-	if (optind < argc && is_version_number(argv[optind])) {
+	if (moddir && root) {
+		ERR("--moddir and -b cannot be used together.\n");
+		goto cmdline_failed;
+	}
+
+	if (moddir) {
+		cfg.kversion = NULL;
+	} else if (optind < argc && is_version_number(argv[optind])) {
 		cfg.kversion = argv[optind];
 		optind++;
 	} else {
@@ -2567,9 +2588,20 @@ static int do_depmod(int argc, char *argv[])
 		cfg.kversion = un.release;
 	}
 
-	cfg.dirnamelen = snprintf(cfg.dirname, PATH_MAX,
-				  "%s/lib/modules/%s",
-				  root == NULL ? "" : root, cfg.kversion);
+	if (moddir) {
+		if (chdir(moddir) != 0) {
+			CRIT("chdir(%s): %s\n", moddir, strerror(errno));
+			goto cmdline_failed;
+		}
+
+		strcpy(cfg.dirname, ".");
+		cfg.dirnamelen = 1;
+	} else {
+		cfg.dirnamelen = snprintf(cfg.dirname, PATH_MAX,
+					  "%s/lib/modules/%s",
+					  root == NULL ? "" : root,
+					  cfg.kversion);
+	}
 
 	if (optind == argc)
 		all = 1;
@@ -2638,7 +2670,7 @@ static int do_depmod(int argc, char *argv[])
 			const char *path = argv[i];
 			struct kmod_module *mod;
 
-			if (path[0] != '/') {
+			if (path[0] != '/' && !moddir) {
 				CRIT("%s: not absolute path.\n", path);
 				goto cmdline_modules_failed;
 			}
@@ -2650,7 +2682,7 @@ static int do_depmod(int argc, char *argv[])
 				goto cmdline_modules_failed;
 			}
 
-			err = depmod_module_add(&depmod, mod);
+			err = depmod_module_add(&depmod, mod, path);
 			if (err < 0) {
 				CRIT("could not add module %s: %s\n",
 				     path, strerror(-err));
diff --git a/tools/modprobe.c b/tools/modprobe.c
index 6b34658..b6d8693 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -56,6 +56,9 @@ static int strip_vermagic = 0;
 static int remove_dependencies = 0;
 static int quiet_inuse = 0;
 
+enum LONGOPTS {
+	MODDIR_OPT = 1000,
+};
 static const char cmdopts_s[] = "arRibfDcnC:d:S:sqvVh";
 static const struct option cmdopts[] = {
 	{"all", no_argument, 0, 'a'},
@@ -82,6 +85,7 @@ static const struct option cmdopts[] = {
 	{"config", required_argument, 0, 'C'},
 	{"dirname", required_argument, 0, 'd'},
 	{"set-version", required_argument, 0, 'S'},
+	{"moddir", required_argument, 0, MODDIR_OPT},
 
 	{"syslog", no_argument, 0, 's'},
 	{"quiet", no_argument, 0, 'q'},
@@ -131,6 +135,8 @@ static void help(void)
 		"\t-C, --config=FILE           Use FILE instead of default search paths\n"
 		"\t-d, --dirname=DIR           Use DIR as filesystem root for /lib/modules\n"
 		"\t-S, --set-version=VERSION   Use VERSION instead of `uname -r`\n"
+		"\t--moddir=MODDIR             Specify a target directory and allow\n"
+		"\t                            relative paths.  Do not use with -d or -s.\n"
 
 		"\t-s, --syslog                print to syslog, not stderr\n"
 		"\t-q, --quiet                 disable messages\n"
@@ -749,6 +755,7 @@ static int do_modprobe(int argc, char **orig_argv)
 	const char *dirname = NULL;
 	const char *root = NULL;
 	const char *kversion = NULL;
+	const char *moddir = NULL;
 	int use_all = 0;
 	int do_remove = 0;
 	int do_show_config = 0;
@@ -835,6 +842,9 @@ static int do_modprobe(int argc, char **orig_argv)
 		case 'S':
 			kversion = optarg;
 			break;
+		case MODDIR_OPT:
+			moddir = optarg;
+			break;
 		case 's':
 			env_modprobe_options_append("-s");
 			use_syslog = 1;
@@ -878,8 +888,14 @@ static int do_modprobe(int argc, char **orig_argv)
 		}
 	}
 
+	if (moddir != NULL)
+		dirname = moddir;
 	if (root != NULL || kversion != NULL) {
 		struct utsname u;
+		if (moddir != NULL) {
+			ERR("--moddir cannot be used with -d or -S.\n");
+			goto done;
+		}
 		if (root == NULL)
 			root = "";
 		if (kversion == NULL) {
-- 
1.8.5.3
