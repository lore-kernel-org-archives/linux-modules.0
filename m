Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65418 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756699AbaEISPM (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 9 May 2014 14:15:12 -0400
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <linux-modules@vger.kernel.org>
CC: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Gustavo Sverzut Barbieri <barbieri@gmail.com>
Subject: [PATCH] depmod: Make dependency loops be fatal
Date: Fri, 9 May 2014 15:14:59 -0300
Message-ID: <1399659299-31241-1-git-send-email-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Since the beginning depmod just warned about dependency loops and upon
creation of modules.dep{,.bin} it skipped the modules that were part of
a loop. However just skipping the modules may come as a surprise to
kernel module developers: they will need to try to load the module (or
to pay attention to the log messages) to notice thavt the module has not
been put in the index. Also, differently from module-init-tools we were
not skipping modules that depend on modules with dependency loops,
leading to a segfault in depmod.

So this is a summary of the change in behavior with this patch:

Loop 1)
    A -> B -> C -
    ^           |
    '------------

    Before:
        depmod: WARNING: found 3 modules in dependency cycles!
        depmod: WARNING: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleB.ko in dependency cycle!
        depmod: WARNING: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleC.ko in dependency cycle!
        depmod: WARNING: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleA.ko in dependency cycle!

        return code: 0

    After:
        depmod: ERROR: Found 3 modules in dependency cycles!
        depmod: ERROR: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleB.ko in dependency cycle!
        depmod: ERROR: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleC.ko in dependency cycle!
        depmod: ERROR: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleA.ko in dependency cycle!

        return code: 2

Loop 2)
    A -> B -> C -
         ^      |
         '-------

    Before:
        depmod: WARNING: found 2 modules in dependency cycles!
        depmod: WARNING: /tmp/test-kmod//lib/modules/3.14.2-1-ARCH/kernel/moduleB.ko in dependency cycle!
        depmod: WARNING: /tmp/test-kmod//lib/modules/3.14.2-1-ARCH/kernel/moduleC.ko in dependency cycle!
        Segmentation fault (core dumped)

    After:
        depmod: ERROR: Found 2 modules in dependency cycles!
        depmod: ERROR: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleB.ko in dependency cycle!
        depmod: ERROR: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleC.ko in dependency cycle!

        return code: 2

The segfault above could be fixed, but let's just fail everything
because dependency cycles should be fixed in the modules rather than
just be skipped in the index.
---
 tools/depmod.c | 55 +++++++++----------------------------------------------
 1 file changed, 9 insertions(+), 46 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 1aedaaf..7ac1e26 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -927,7 +927,6 @@ struct mod {
 	int dep_sort_idx; /* topological sort index */
 	uint16_t idx; /* index in depmod->modules.array */
 	uint16_t users; /* how many modules depend on this one */
-	uint8_t dep_loop : 1;
 	char modname[];
 };
 
@@ -944,7 +943,6 @@ struct depmod {
 	struct hash *modules_by_uncrelpath;
 	struct hash *modules_by_name;
 	struct hash *symbols;
-	unsigned int dep_loops;
 };
 
 static void mod_free(struct mod *mod)
@@ -1337,12 +1335,6 @@ static int depmod_modules_search(struct depmod *depmod)
 static int mod_cmp(const void *pa, const void *pb) {
 	const struct mod *a = *(const struct mod **)pa;
 	const struct mod *b = *(const struct mod **)pb;
-	if (a->dep_loop == b->dep_loop)
-		return a->sort_idx - b->sort_idx;
-	else if (a->dep_loop)
-		return 1;
-	else if (b->dep_loop)
-		return -1;
 	return a->sort_idx - b->sort_idx;
 }
 
@@ -1566,12 +1558,6 @@ static int dep_cmp(const void *pa, const void *pb)
 {
 	const struct mod *a = *(const struct mod **)pa;
 	const struct mod *b = *(const struct mod **)pb;
-	if (a->dep_loop == b->dep_loop)
-		return a->dep_sort_idx - b->dep_sort_idx;
-	else if (a->dep_loop)
-		return 1;
-	else if (b->dep_loop)
-		return -1;
 	return a->dep_sort_idx - b->dep_sort_idx;
 }
 
@@ -1592,6 +1578,7 @@ static int depmod_calculate_dependencies(struct depmod *depmod)
 	const struct mod **itrm;
 	uint16_t *users, *roots, *sorted;
 	uint16_t i, n_roots = 0, n_sorted = 0, n_mods = depmod->modules.count;
+	int ret = 0;
 
 	users = malloc(sizeof(uint16_t) * n_mods * 3);
 	if (users == NULL)
@@ -1640,27 +1627,26 @@ static int depmod_calculate_dependencies(struct depmod *depmod)
 	}
 
 	if (n_sorted < n_mods) {
-		WRN("found %u modules in dependency cycles!\n",
+		ERR("Found %u modules in dependency cycles!\n",
 		    n_mods - n_sorted);
+		ret = -EINVAL;
 		for (i = 0; i < n_mods; i++) {
 			struct mod *m;
 			if (users[i] == 0)
 				continue;
 			m = depmod->modules.array[i];
-			WRN("%s in dependency cycle!\n", m->path);
-			m->dep_loop = 1;
-			m->dep_sort_idx = INT32_MAX;
-			depmod->dep_loops++;
+			ERR("%s in dependency cycle!\n", m->path);
 		}
+		goto exit;
 	}
 
 	depmod_sort_dependencies(depmod);
 
-	DBG("calculated dependencies and ordering (%u loops, %hu modules)\n",
-	    depmod->dep_loops, n_mods);
+	DBG("calculated dependencies and ordering (%hu modules)\n", n_mods);
 
+exit:
 	free(users);
-	return 0;
+	return ret;
 }
 
 static int depmod_load(struct depmod *depmod)
@@ -1761,11 +1747,6 @@ static int output_deps(struct depmod *depmod, FILE *out)
 		const char *p = mod_get_compressed_path(mod);
 		size_t j, n_deps;
 
-		if (mod->dep_loop) {
-			DBG("Ignored %s due dependency loops\n", p);
-			continue;
-		}
-
 		fprintf(out, "%s:", p);
 
 		if (mod->deps.count == 0)
@@ -1779,12 +1760,6 @@ static int output_deps(struct depmod *depmod, FILE *out)
 
 		for (j = 0; j < n_deps; j++) {
 			const struct mod *d = deps[j];
-			if (d->dep_loop) {
-				DBG("Ignored %s (dependency of %s) "
-				    "due dependency loops\n",
-				    mod_get_compressed_path(d), p);
-				continue;
-			}
 			fprintf(out, " %s", mod_get_compressed_path(d));
 		}
 		free(deps);
@@ -1814,11 +1789,6 @@ static int output_deps_bin(struct depmod *depmod, FILE *out)
 		size_t j, n_deps, linepos, linelen, slen;
 		int duplicate;
 
-		if (mod->dep_loop) {
-			DBG("Ignored %s due dependency loops\n", p);
-			continue;
-		}
-
 		deps = mod_get_all_sorted_dependencies(mod, &n_deps);
 		if (deps == NULL && n_deps > 0) {
 			ERR("could not get all sorted dependencies of %s\n", p);
@@ -1828,12 +1798,6 @@ static int output_deps_bin(struct depmod *depmod, FILE *out)
 		linelen = strlen(p) + 1;
 		for (j = 0; j < n_deps; j++) {
 			const struct mod *d = deps[j];
-			if (d->dep_loop) {
-				DBG("Ignored %s (dependency of %s) "
-				    "due dependency loops\n",
-				    mod_get_compressed_path(d), p);
-				continue;
-			}
 			linelen += 1 + strlen(mod_get_compressed_path(d));
 		}
 
@@ -1854,8 +1818,7 @@ static int output_deps_bin(struct depmod *depmod, FILE *out)
 		for (j = 0; j < n_deps; j++) {
 			const struct mod *d = deps[j];
 			const char *dp;
-			if (d->dep_loop)
-				continue;
+
 			line[linepos] = ' ';
 			linepos++;
 
-- 
1.9.2

