Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from photon.sai.msu.ru ([93.180.26.182]:44291 "EHLO
	photon.sai.msu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbaDKTlM (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 11 Apr 2014 15:41:12 -0400
Date: Fri, 11 Apr 2014 23:31:51 +0400
From: matwey.kornilov@gmail.com
To: linux-modules@vger.kernel.org
Subject: [PATCH] Fix recursion loop in mod_count_all_dependencies()
Message-ID: <53484327.5Nr2aWdyWz5+36kD%matwey.kornilov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

>From 48d4d7ba1acbb5c0955f75c6bdda9cf0935240fd Mon Sep 17 00:00:00 2001
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Fri, 11 Apr 2014 19:43:18 +0400
Subject: [PATCH] Fix recursion loop in mod_count_all_dependencies() when
 subgraph has a cycle.

When cycle is detected in mod_count_all_dependencies, use total count of
modules as an upper bound of needed memory. Correct number of nodes is determined by
subsequent call of mod_fill_all_unique_dependencies().
---
 tools/depmod.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 1aedaaf..c83dee1 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1682,12 +1682,20 @@ static int depmod_load(struct depmod *depmod)
 	return 0;
 }
 
-static size_t mod_count_all_dependencies(const struct mod *mod)
+static size_t mod_count_all_dependencies(const struct mod *mod, size_t upper_bound)
 {
 	size_t i, count = 0;
+	/* cycle is detected */
+	if (mod->dep_loop)
+		return upper_bound;
+
 	for (i = 0; i < mod->deps.count; i++) {
 		const struct mod *d = mod->deps.array[i];
-		count += 1 + mod_count_all_dependencies(d);
+		const size_t child = mod_count_all_dependencies(d, upper_bound);
+		if(child == upper_bound)
+			return child;
+
+		count += 1 + child;
 	}
 	return count;
 }
@@ -1722,12 +1730,12 @@ static int mod_fill_all_unique_dependencies(const struct mod *mod, const struct
 	return err;
 }
 
-static const struct mod **mod_get_all_sorted_dependencies(const struct mod *mod, size_t *n_deps)
+static const struct mod **mod_get_all_sorted_dependencies(const struct mod *mod, size_t *n_deps, size_t count)
 {
 	const struct mod **deps;
 	size_t last = 0;
 
-	*n_deps = mod_count_all_dependencies(mod);
+	*n_deps = mod_count_all_dependencies(mod, count);
 	if (*n_deps == 0)
 		return NULL;
 
@@ -1771,7 +1779,7 @@ static int output_deps(struct depmod *depmod, FILE *out)
 		if (mod->deps.count == 0)
 			goto end;
 
-		deps = mod_get_all_sorted_dependencies(mod, &n_deps);
+		deps = mod_get_all_sorted_dependencies(mod, &n_deps, depmod->modules.count);
 		if (deps == NULL) {
 			ERR("could not get all sorted dependencies of %s\n", p);
 			goto end;
@@ -1819,7 +1827,7 @@ static int output_deps_bin(struct depmod *depmod, FILE *out)
 			continue;
 		}
 
-		deps = mod_get_all_sorted_dependencies(mod, &n_deps);
+		deps = mod_get_all_sorted_dependencies(mod, &n_deps, depmod->modules.count);
 		if (deps == NULL && n_deps > 0) {
 			ERR("could not get all sorted dependencies of %s\n", p);
 			continue;
-- 
1.8.1.4

