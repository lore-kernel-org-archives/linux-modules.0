Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail1.sysgo.com ([176.9.26.183]:53874 "EHLO mail1.sysgo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbaBZQTm (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 26 Feb 2014 11:19:42 -0500
From: Andrej Krutak <andrej.krutak@sysgo.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH] Re: modprobe documentation discrepancy (modules.dep support)
Date: Wed, 26 Feb 2014 17:19:40 +0100
Message-ID: <4873416.CU5HjpvjRz@kru>
In-Reply-To: <1627264.ihO3vEG55s@kru>
References: <1627264.ihO3vEG55s@kru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi again,

below is a patch to (re-)add support for modules.dep (in addition to
modules.dep.bin), in a very dirty way. Basically I just took parts of the 
original code from module-init-tools...

Also, it fixes the CHECK_ERR_AND_FINISH macro.


However, this doesn't fix the whole "problem" - 'modprobe nonexistingmodule'
is called, no error is printed, because of the faulty processing of subsequent
non-existent files (like modules.builtin.bin etc. - which depmod.pl doesn't 
generate).

To fully fix this, one would have to also add support for the other
legacy files. Well, at least a support to handle the missing files gracefully.

Fixing this is important for when you want to cross-compile the kernel in a 
non-linux environment. I didn't find find any other tool than depmod.pl that 
could generate all the files required by modprobe (but depmod.pl, as mentioned 
before, doesn't generate other .bin files) - and kmod/module-init-tools can't 
be cross-compiled for cygwin/mingw32...


Best regards,
Andrej Krutak
SYSGO

---
 libkmod/libkmod-module.c |    4 +-
 libkmod/libkmod.c        |  107 
+++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 4 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 3d3325f..e737d30 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -473,7 +473,7 @@ KMOD_EXPORT struct kmod_module *kmod_module_ref(struct 
kmod_module *mod)
 		if ((_err) < 0)						\
 			goto _label_err;				\
 		if (*(_list) != NULL)					\
-			goto finish;					\
+			goto label_finish;					\
 	} while (0)
 
 /**
@@ -553,7 +553,7 @@ finish:
 	DBG(ctx, "lookup %s=%d, list=%p\n", alias, err, *list);
 	return err;
 fail:
-	DBG(ctx, "Failed to lookup %s\n", alias);
+	DBG(ctx, "Failed to lookup %s (%d)\n", alias, err);
 	kmod_module_unref_list(*list);
 	*list = NULL;
 	return err;
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index ef83e31..4a60416 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -533,11 +533,106 @@ finish:
 	return err;
 }
 
+/**
+ * modname_equal - compare module names (up to len), with '_' and '-' equal
+ *
+ * @a:		first module name
+ * @b:		second module name
+ * @len:	length to compare
+ *
+ */
+static int modname_equal(const char *a, const char *b, unsigned int len)
+{
+	unsigned int i;
+
+	if (strlen(b) != len)
+		return 0;
+
+	for (i = 0; i < len; i++) {
+		if ((a[i] == '_' || a[i] == '-')
+		    && (b[i] == '_' || b[i] == '-'))
+			continue;
+		if (a[i] != b[i])
+			return 0;
+	}
+	return 1;
+}
+
+static char *my_basename(const char *path)
+{
+	const char *base = strrchr(path, '/');
+	if (base)
+		return (char *) base + 1;
+	return (char *) path;
+}
+
+
+/**
+ * add_modules_dep_line - parse a dep line from the module.dep[.bin] file
+ *
+ * @line:	input file line
+ * @name:	module name
+ *
+ * Add dependency information if this line of the dep file matches mod name
+ */
+static int is_module_line(char *line,
+				const char *name)
+{
+	char *ptr;
+	int len;
+	char *modname;
+	int rv;
+
+	line = strdup(line);
+
+	/* Ignore lines without : or which start with a # */
+	ptr = strchr(line, ':');
+	if (ptr == NULL || line[strspn(line, "\t ")] == '#') {
+		free(line);
+		return 0;
+	}
+
+	/* Is this the module we are looking for? */
+	*ptr = '\0';
+	modname = my_basename(line);
+
+	len = strlen(modname);
+	if (strchr(modname, '.'))
+		len = strchr(modname, '.') - modname;
+
+	rv = modname_equal(modname, name, len);
+
+	free(line);
+	return rv;
+}
+
+static char *kmod_search_moddep_legacy(struct kmod_ctx *ctx, const char 
*name, const char *fn)
+{
+	char *line;
+	FILE *modules_dep;
+	
+	modules_dep = fopen(fn, "r");
+	if (!modules_dep)
+		return NULL;
+
+	/* Stop at first line, as we can have duplicates (eg. symlinks
+           from boot/ */
+	while ((line = getline_wrapped(modules_dep, NULL)) != NULL) {
+		if (is_module_line(line, name))
+			break;
+		free(line);
+	}
+	fclose(modules_dep);
+
+	return line;
+}
+
 char *kmod_search_moddep(struct kmod_ctx *ctx, const char *name)
 {
 	struct index_file *idx;
 	char fn[PATH_MAX];
 	char *line;
+	
 
 	if (ctx->indexes[KMOD_INDEX_MODULES_DEP]) {
 		DBG(ctx, "use mmaped index '%s' modname=%s\n",
@@ -553,8 +648,16 @@ char *kmod_search_moddep(struct kmod_ctx *ctx, const char 
*name)
 
 	idx = index_file_open(fn);
 	if (idx == NULL) {
-		DBG(ctx, "could not open moddep file '%s'\n", fn);
-		return NULL;
+		struct stat st;
+		
+		snprintf(fn, sizeof(fn), "%s/%s", ctx->dirname,
+					index_files[KMOD_INDEX_MODULES_DEP].fn);
+		if (stat(fn, &st) != 0) {
+			DBG(ctx, "could not open moddep file '%s[.bin]'\n", fn);
+			return NULL;
+		}
+		
+		return kmod_search_moddep_legacy(ctx, name, fn);
 	}
 
 	line = index_search(idx, name);
-- 
1.7.9.5


