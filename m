Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48415 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994AbaCaNTD (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 31 Mar 2014 09:19:03 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 957CBACC6
	for <linux-modules@vger.kernel.org>; Mon, 31 Mar 2014 13:19:02 +0000 (UTC)
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Subject: [PATCH 1/2] libkmod: Ignore errors from softdeps
Date: Mon, 31 Mar 2014 15:18:50 +0200
Message-Id: <1396271931-7431-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Before we had softdeps, the usual idiom was

install foo /sbin/modprobe bar; /sbin/modprobe --ignore-install foo

ignoring errors from the first modprobe invocation. This also matches
the behavior of module-init-tools' implementation of softdep.
---
 libkmod/libkmod-internal.h |  2 ++
 libkmod/libkmod-module.c   | 40 ++++++++++++++++++++++++++++++++++++----
 libkmod/libkmod.c          | 10 ++++++++++
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 0180124..93a00c1 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -93,6 +93,7 @@ int kmod_lookup_alias_from_moddep_file(struct kmod_ctx *ctx, const char *name, s
 int kmod_lookup_alias_from_builtin_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
 int kmod_lookup_alias_from_commands(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
 void kmod_set_modules_visited(struct kmod_ctx *ctx, bool visited) __attribute__((nonnull((1))));
+void kmod_set_modules_required(struct kmod_ctx *ctx, bool required) __attribute__((nonnull((1))));
 
 char *kmod_search_moddep(struct kmod_ctx *ctx, const char *name) __attribute__((nonnull(1,2)));
 
@@ -142,6 +143,7 @@ void kmod_module_set_install_commands(struct kmod_module *mod, const char *cmd)
 void kmod_module_set_remove_commands(struct kmod_module *mod, const char *cmd) __attribute__((nonnull(1)));
 void kmod_module_set_visited(struct kmod_module *mod, bool visited) __attribute__((nonnull(1)));
 void kmod_module_set_builtin(struct kmod_module *mod, bool builtin) __attribute__((nonnull((1))));
+void kmod_module_set_required(struct kmod_module *mod, bool required) __attribute__((nonnull(1)));
 
 /* libkmod-hash.c */
 
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index a6c8a6e..1d90f34 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -87,6 +87,13 @@ struct kmod_module {
 	bool ignorecmd : 1;
 
 	/*
+	 * set by kmod_module_get_probe_list: indicates whether this is the
+	 * module the user asked for or its dependency, or whether this
+	 * is a softdep only
+	 */
+	bool required : 1;
+
+	/*
 	 * if module was created by searching the modules.builtin file, this
 	 * is set. There's nothing much useful one can do with such a
 	 * "module", except knowing it's builtin.
@@ -208,6 +215,11 @@ void kmod_module_set_builtin(struct kmod_module *mod, bool builtin)
 	mod->builtin = builtin;
 }
 
+void kmod_module_set_required(struct kmod_module *mod, bool required)
+{
+	mod->required = required;
+}
+
 /*
  * Memory layout with alias:
  *
@@ -1033,6 +1045,7 @@ static char *module_options_concat(const char *opt, const char *xopt)
 }
 
 static int __kmod_module_get_probe_list(struct kmod_module *mod,
+						bool required,
 						bool ignorecmd,
 						struct kmod_list **list);
 
@@ -1052,7 +1065,7 @@ static int __kmod_module_fill_softdep(struct kmod_module *mod,
 
 	kmod_list_foreach(l, pre) {
 		struct kmod_module *m = l->data;
-		err = __kmod_module_get_probe_list(m, false, list);
+		err = __kmod_module_get_probe_list(m, false, false, list);
 		if (err < 0)
 			goto fail;
 	}
@@ -1068,7 +1081,7 @@ static int __kmod_module_fill_softdep(struct kmod_module *mod,
 
 	kmod_list_foreach(l, post) {
 		struct kmod_module *m = l->data;
-		err = __kmod_module_get_probe_list(m, false, list);
+		err = __kmod_module_get_probe_list(m, false, false, list);
 		if (err < 0)
 			goto fail;
 	}
@@ -1082,6 +1095,7 @@ fail:
 
 /* re-entrant */
 static int __kmod_module_get_probe_list(struct kmod_module *mod,
+						bool required,
 						bool ignorecmd,
 						struct kmod_list **list)
 {
@@ -1096,6 +1110,19 @@ static int __kmod_module_get_probe_list(struct kmod_module *mod,
 	mod->visited = true;
 
 	dep = kmod_module_get_dependencies(mod);
+	if (required) {
+		/*
+		 * Called from kmod_module_probe_insert_module(); set the
+		 * ->required flag on mod and all its dependencies before
+		 * they are possibly visited through some softdeps.
+		 */
+		mod->required = true;
+		kmod_list_foreach(l, dep) {
+			struct kmod_module *m = l->data;
+			m->required = true;
+		}
+	}
+
 	kmod_list_foreach(l, dep) {
 		struct kmod_module *m = l->data;
 		err = __kmod_module_fill_softdep(m, list);
@@ -1133,8 +1160,9 @@ static int kmod_module_get_probe_list(struct kmod_module *mod,
 	 * Make sure we don't get screwed by previous calls to this function
 	 */
 	kmod_set_modules_visited(mod->ctx, false);
+	kmod_set_modules_required(mod->ctx, false);
 
-	err = __kmod_module_get_probe_list(mod, ignorecmd, list);
+	err = __kmod_module_get_probe_list(mod, true, ignorecmd, list);
 	if (err < 0) {
 		kmod_module_unref_list(*list);
 		*list = NULL;
@@ -1295,8 +1323,12 @@ finish_module:
 				(flags & KMOD_PROBE_FAIL_ON_LOADED))
 			break;
 
-		if (err == -EEXIST)
+		/*
+		 * Ignore errors from softdeps
+		 */
+		if (err == -EEXIST || !m->required)
 			err = 0;
+
 		else if (err < 0)
 			break;
 	}
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index ef83e31..fe68134 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -720,6 +720,16 @@ void kmod_set_modules_visited(struct kmod_ctx *ctx, bool visited)
 		kmod_module_set_visited((struct kmod_module *)v, visited);
 }
 
+void kmod_set_modules_required(struct kmod_ctx *ctx, bool required)
+{
+	struct hash_iter iter;
+	const void *v;
+
+	hash_iter_init(ctx->modules_by_name, &iter);
+	while (hash_iter_next(&iter, NULL, &v))
+		kmod_module_set_required((struct kmod_module *)v, required);
+}
+
 static bool is_cache_invalid(const char *path, unsigned long long stamp)
 {
 	struct stat st;
-- 
1.8.4.5

