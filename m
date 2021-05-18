Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6873BC433ED
	for <linux-modules@archiver.kernel.org>; Tue, 18 May 2021 15:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A226108B
	for <linux-modules@archiver.kernel.org>; Tue, 18 May 2021 15:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241516AbhERPFw (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 May 2021 11:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343903AbhERPFv (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 May 2021 11:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621350273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iKPWCOY+7BJzQZbuk9mKFXN/pAKCXadqHU89lMrvr4A=;
        b=bDwW6SgXNrWQkoUzKuPWB0ecASMksFSzzpU0DZ4nR7nw0c3SheZ71XLASNFEeRzR4dmV8x
        x6iWuSnU+qa9TTXMlqLzEVSeSfnsSnKar351RCtbZLRouA8CAJZStuuTZy6L4CJQzM3VLk
        8TSpy+TtTM6+taZVgQ2zSh5pvOBicQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351--2RQoz-dNR-KRh-NNSSNTg-1; Tue, 18 May 2021 11:04:31 -0400
X-MC-Unique: -2RQoz-dNR-KRh-NNSSNTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2558AE7B40;
        Tue, 18 May 2021 15:04:30 +0000 (UTC)
Received: from rvarghes.bos.com (ovpn-114-37.phx2.redhat.com [10.3.114.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0063410074E0;
        Tue, 18 May 2021 15:04:28 +0000 (UTC)
From:   Reuben Varghese <rvarghes@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     lucas.de.marchi@gmail.com, yauheni.kaliuta@redhat.com,
        reubenvarghese1 <rvarghes@redhat.com>
Subject: [PATCH v2 1/3] Refactor all instances of blacklist to blocklist
Date:   Tue, 18 May 2021 08:03:17 -0700
Message-Id: <20210518150319.60941-2-rvarghes@redhat.com>
In-Reply-To: <20210518150319.60941-1-rvarghes@redhat.com>
References: <CAKi4VA+QqSkZMk+8=-9j7qH+_e7CRjW1mc+tVZ2V9Y+f=khe0w@mail.gmail.com>
 <20210518150319.60941-1-rvarghes@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: reubenvarghese1 <rvarghes@redhat.com>

As the linux community has now embraced using inclusive language,
this commit introduces inclusive language to the kmod module by
refactoring all instances of the term blacklist to the term blocklist

Signed-off-by: Reuben Varghese <rvarghes@redhat.com>
---
 Makefile.am                                   |  6 +--
 NEWS                                          | 12 ++---
 libkmod/docs/libkmod-sections.txt             |  4 +-
 libkmod/libkmod-config.c                      | 42 +++++++--------
 libkmod/libkmod-internal.h                    |  4 +-
 libkmod/libkmod-module.c                      | 52 +++++++++----------
 libkmod/libkmod.h                             | 12 ++---
 libkmod/libkmod.sym                           |  4 +-
 libkmod/python/kmod/_libkmod_h.pxd            |  2 +-
 libkmod/python/kmod/kmod.pyx                  |  2 +-
 testsuite/.gitignore                          |  6 +--
 .../etc/modprobe.d/modprobe.conf              |  2 -
 .../etc/modprobe.d/modprobe.conf              |  2 +
 .../{test-blacklist.c => test-blocklist.c}    | 12 ++---
 tools/insert.c                                |  6 +--
 tools/modprobe.c                              | 18 +++----
 16 files changed, 93 insertions(+), 93 deletions(-)
 delete mode 100644 testsuite/rootfs-pristine/test-blacklist/etc/modprobe.d/modprobe.conf
 create mode 100644 testsuite/rootfs-pristine/test-blocklist/etc/modprobe.d/modprobe.conf
 rename testsuite/{test-blacklist.c => test-blocklist.c} (90%)

diff --git a/Makefile.am b/Makefile.am
index 24a586e..21af237 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -356,7 +356,7 @@ TESTSUITE = \
 	testsuite/test-initstate \
 	testsuite/test-testsuite testsuite/test-loaded \
 	testsuite/test-modinfo testsuite/test-util testsuite/test-new-module \
-	testsuite/test-modprobe testsuite/test-blacklist \
+	testsuite/test-modprobe testsuite/test-blocklist \
 	testsuite/test-dependencies testsuite/test-depmod \
 	testsuite/test-list
 
@@ -398,8 +398,8 @@ testsuite_test_new_module_LDADD = $(TESTSUITE_LDADD)
 testsuite_test_new_module_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 testsuite_test_modprobe_LDADD = $(TESTSUITE_LDADD)
 testsuite_test_modprobe_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
-testsuite_test_blacklist_LDADD = $(TESTSUITE_LDADD)
-testsuite_test_blacklist_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
+testsuite_test_blocklist_LDADD = $(TESTSUITE_LDADD)
+testsuite_test_blocklist_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 testsuite_test_dependencies_LDADD = $(TESTSUITE_LDADD)
 testsuite_test_dependencies_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 testsuite_test_depmod_LDADD = $(TESTSUITE_LDADD)
diff --git a/NEWS b/NEWS
index ae56657..d5db35e 100644
--- a/NEWS
+++ b/NEWS
@@ -452,10 +452,10 @@ kmod 10
 - New features:
 	- Read coresize from /sys if supported
 
-	- Add flag to kmod_module_probe_insert() to apply blacklisting during
+	- Add flag to kmod_module_probe_insert() to apply blocklisting during
 	  probe only if mod is an alias. Now modprobe uses this flag by default.
 	  This is needed to fix a change in behavior regarding module-init-tools
-	  and ultimately makes us loading a blacklisted module.
+	  and ultimately makes us loading a blocklisted module.
 
 - Better formatting in man pages
 
@@ -516,7 +516,7 @@ kmod 6
 - New API in libkmod:
 	- kmod_module_apply_filter(): a generic function to apply filters in a
 	  list of modules. This deprecates the use of
-	  kmod_module_get_filtered_blacklist()
+	  kmod_module_get_filtered_blocklist()
 
 - More tests in testsuite
 
@@ -570,7 +570,7 @@ kmod 4
 ======
 
 - New APIs in libkmod to:
-	- Get configuration lists: blacklists, install commands, remove
+	- Get configuration lists: blocklists, install commands, remove
 	  commands, aliases, options and softdeps
 	- Dump indexes
 
@@ -598,7 +598,7 @@ kmod 3
 	- Get dependency symbols
 	- Check if resources are still valid or if libkmod must be reloaded
 	- Insert module like modprobe, checking (soft-)dependencies, commands,
-	  blacklist. It can run commands by itself and to call a callback
+	  blocklist. It can run commands by itself and to call a callback
 	  function.
 
 - Support to load modules compressed with xz
@@ -663,7 +663,7 @@ In the libkmod it's currently possible to:
 	- Insert modules: options from configuration and extra options can be
 	  passed, but flags are not implemented, yet
 	- Remove modules
-	- Filter list of modules using blacklist
+	- Filter list of modules using blocklist
 	- For each module, get the its list of options and install/remove
 	  commands
 	- Indexes can be loaded on startup to speedup lookups later
diff --git a/libkmod/docs/libkmod-sections.txt b/libkmod/docs/libkmod-sections.txt
index e59ab7a..c07f74e 100644
--- a/libkmod/docs/libkmod-sections.txt
+++ b/libkmod/docs/libkmod-sections.txt
@@ -30,7 +30,7 @@ kmod_list_prev
 <SECTION>
 <FILE>libkmod-config</FILE>
 kmod_config_iter
-kmod_config_get_blacklists
+kmod_config_get_blocklists
 kmod_config_get_install_commands
 kmod_config_get_remove_commands
 kmod_config_get_aliases
@@ -61,7 +61,7 @@ kmod_module_get_module
 kmod_module_get_dependencies
 kmod_module_get_softdeps
 kmod_module_apply_filter
-kmod_module_get_filtered_blacklist
+kmod_module_get_filtered_blocklist
 kmod_module_get_install_commands
 kmod_module_get_remove_commands
 kmod_module_get_name
diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index 4fdd40f..ec148c6 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -58,7 +58,7 @@ struct kmod_softdep {
 	unsigned int n_post;
 };
 
-const char *kmod_blacklist_get_modname(const struct kmod_list *l)
+const char *kmod_blocklist_get_modname(const struct kmod_list *l)
 {
 	return l->data;
 }
@@ -227,7 +227,7 @@ static void kmod_config_free_alias(struct kmod_config *config,
 	config->aliases = kmod_list_remove(l);
 }
 
-static int kmod_config_add_blacklist(struct kmod_config *config,
+static int kmod_config_add_blocklist(struct kmod_config *config,
 							const char *modname)
 {
 	_cleanup_free_ char *p;
@@ -239,20 +239,20 @@ static int kmod_config_add_blacklist(struct kmod_config *config,
 	if (!p)
 		return -ENOMEM;
 
-	list = kmod_list_append(config->blacklists, p);
+	list = kmod_list_append(config->blocklists, p);
 	if (!list)
 		return -ENOMEM;
 
 	p = NULL;
-	config->blacklists = list;
+	config->blocklists = list;
 	return 0;
 }
 
-static void kmod_config_free_blacklist(struct kmod_config *config,
+static void kmod_config_free_blocklist(struct kmod_config *config,
 							struct kmod_list *l)
 {
 	free(l->data);
-	config->blacklists = kmod_list_remove(l);
+	config->blocklists = kmod_list_remove(l);
 }
 
 static int kmod_config_add_softdep(struct kmod_config *config,
@@ -476,13 +476,13 @@ static void kcmdline_parse_result(struct kmod_config *config, char *modname,
 
 	DBG(config->ctx, "%s %s\n", modname, param);
 
-	if (streq(modname, "modprobe") && !strncmp(param, "blacklist=", 10)) {
+	if (streq(modname, "modprobe") && !strncmp(param, "blocklist=", 10)) {
 		for (;;) {
 			char *t = strsep(&value, ",");
 			if (t == NULL)
 				break;
 
-			kmod_config_add_blacklist(config, t);
+			kmod_config_add_blocklist(config, t);
 		}
 	} else {
 		if (underscores(modname) < 0) {
@@ -662,13 +662,13 @@ static int kmod_config_parse(struct kmod_config *config, int fd,
 				goto syntax_error;
 
 			kmod_config_add_alias(config, alias, modname);
-		} else if (streq(cmd, "blacklist")) {
+		} else if (streq(cmd, "blocklist")) {
 			char *modname = strtok_r(NULL, "\t ", &saveptr);
 
 			if (underscores(modname) < 0)
 				goto syntax_error;
 
-			kmod_config_add_blacklist(config, modname);
+			kmod_config_add_blocklist(config, modname);
 		} else if (streq(cmd, "options")) {
 			char *modname = strtok_r(NULL, "\t ", &saveptr);
 			char *options = strtok_r(NULL, "\0", &saveptr);
@@ -727,8 +727,8 @@ void kmod_config_free(struct kmod_config *config)
 	while (config->aliases)
 		kmod_config_free_alias(config, config->aliases);
 
-	while (config->blacklists)
-		kmod_config_free_blacklist(config, config->blacklists);
+	while (config->blocklists)
+		kmod_config_free_blocklist(config, config->blocklists);
 
 	while (config->options)
 		kmod_config_free_options(config, config->options);
@@ -965,7 +965,7 @@ oom:
  **********************************************************************/
 
 enum config_type {
-	CONFIG_TYPE_BLACKLIST = 0,
+	CONFIG_TYPE_BLOCKLIST = 0,
 	CONFIG_TYPE_INSTALL,
 	CONFIG_TYPE_REMOVE,
 	CONFIG_TYPE_ALIAS,
@@ -1001,9 +1001,9 @@ static struct kmod_config_iter *kmod_config_iter_new(const struct kmod_ctx* ctx,
 	iter->type = type;
 
 	switch (type) {
-	case CONFIG_TYPE_BLACKLIST:
-		iter->list = config->blacklists;
-		iter->get_key = kmod_blacklist_get_modname;
+	case CONFIG_TYPE_BLOCKLIST:
+		iter->list = config->blocklists;
+		iter->get_key = kmod_blocklist_get_modname;
 		break;
 	case CONFIG_TYPE_INSTALL:
 		iter->list = config->install_commands;
@@ -1042,23 +1042,23 @@ static struct kmod_config_iter *kmod_config_iter_new(const struct kmod_ctx* ctx,
  */
 
 /**
- * kmod_config_get_blacklists:
+ * kmod_config_get_blocklists:
  * @ctx: kmod library context
  *
- * Retrieve an iterator to deal with the blacklist maintained inside the
+ * Retrieve an iterator to deal with the blocklist maintained inside the
  * library. See kmod_config_iter_get_key(), kmod_config_iter_get_value() and
  * kmod_config_iter_next(). At least one call to kmod_config_iter_next() must
  * be made to initialize the iterator and check if it's valid.
  *
- * Returns: a new iterator over the blacklists or NULL on failure. Free it
+ * Returns: a new iterator over the blocklists or NULL on failure. Free it
  * with kmod_config_iter_free_iter().
  */
-KMOD_EXPORT struct kmod_config_iter *kmod_config_get_blacklists(const struct kmod_ctx *ctx)
+KMOD_EXPORT struct kmod_config_iter *kmod_config_get_blocklists(const struct kmod_ctx *ctx)
 {
 	if (ctx == NULL)
 		return NULL;;
 
-	return kmod_config_iter_new(ctx, CONFIG_TYPE_BLACKLIST);
+	return kmod_config_iter_new(ctx, CONFIG_TYPE_BLOCKLIST);
 }
 
 /**
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 398af9c..89b81dd 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -113,7 +113,7 @@ struct kmod_config_path {
 struct kmod_config {
 	struct kmod_ctx *ctx;
 	struct kmod_list *aliases;
-	struct kmod_list *blacklists;
+	struct kmod_list *blocklists;
 	struct kmod_list *options;
 	struct kmod_list *remove_commands;
 	struct kmod_list *install_commands;
@@ -124,7 +124,7 @@ struct kmod_config {
 
 int kmod_config_new(struct kmod_ctx *ctx, struct kmod_config **config, const char * const *config_paths) __attribute__((nonnull(1, 2,3)));
 void kmod_config_free(struct kmod_config *config) __attribute__((nonnull(1)));
-const char *kmod_blacklist_get_modname(const struct kmod_list *l) __attribute__((nonnull(1)));
+const char *kmod_blocklist_get_modname(const struct kmod_list *l) __attribute__((nonnull(1)));
 const char *kmod_alias_get_name(const struct kmod_list *l) __attribute__((nonnull(1)));
 const char *kmod_alias_get_modname(const struct kmod_list *l) __attribute__((nonnull(1)));
 const char *kmod_option_get_options(const struct kmod_list *l) __attribute__((nonnull(1)));
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 76a6dc3..f176283 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -614,24 +614,24 @@ KMOD_EXPORT int kmod_module_unref_list(struct kmod_list *list)
 }
 
 /**
- * kmod_module_get_filtered_blacklist:
+ * kmod_module_get_filtered_blocklist:
  * @ctx: kmod library context
- * @input: list of kmod_module to be filtered with blacklist
+ * @input: list of kmod_module to be filtered with blocklist
  * @output: where to save the new list
  *
  * This function should not be used. Use kmod_module_apply_filter instead.
  *
- * Given a list @input, this function filter it out with config's blacklist
+ * Given a list @input, this function filter it out with config's blocklist
  * and save it in @output.
  *
  * Returns: 0 on success or < 0 otherwise. @output is saved with the updated
  * list.
  */
-KMOD_EXPORT int kmod_module_get_filtered_blacklist(const struct kmod_ctx *ctx,
+KMOD_EXPORT int kmod_module_get_filtered_blocklist(const struct kmod_ctx *ctx,
 						const struct kmod_list *input,
 						struct kmod_list **output)
 {
-	return kmod_module_apply_filter(ctx, KMOD_FILTER_BLACKLIST, input, output);
+	return kmod_module_apply_filter(ctx, KMOD_FILTER_BLOCKLIST, input, output);
 }
 
 static const struct kmod_list *module_get_dependencies_noref(const struct kmod_module *mod)
@@ -894,15 +894,15 @@ init_finished:
 	return err;
 }
 
-static bool module_is_blacklisted(struct kmod_module *mod)
+static bool module_is_blocklisted(struct kmod_module *mod)
 {
 	struct kmod_ctx *ctx = mod->ctx;
 	const struct kmod_config *config = kmod_get_config(ctx);
-	const struct kmod_list *bl = config->blacklists;
+	const struct kmod_list *bl = config->blocklists;
 	const struct kmod_list *l;
 
 	kmod_list_foreach(l, bl) {
-		const char *modname = kmod_blacklist_get_modname(l);
+		const char *modname = kmod_blocklist_get_modname(l);
 
 		if (streq(modname, mod->name))
 			return true;
@@ -915,7 +915,7 @@ static bool module_is_blacklisted(struct kmod_module *mod)
  * kmod_module_apply_filter
  * @ctx: kmod library context
  * @filter_type: bitmask to filter modules out, valid types are
- * KMOD_FILTER_BLACKLIST: filter modules in blacklist out;
+ * KMOD_FILTER_BLOCKLIST: filter modules in blocklist out;
  * KMOD_FILTER_BUILTIN: filter builtin modules out.
  * @input: list of kmod_module to be filtered
  * @output: where to save the new list
@@ -944,8 +944,8 @@ KMOD_EXPORT int kmod_module_apply_filter(const struct kmod_ctx *ctx,
 		struct kmod_module *mod = li->data;
 		struct kmod_list *node;
 
-		if ((filter_type & KMOD_FILTER_BLACKLIST) &&
-				module_is_blacklisted(mod))
+		if ((filter_type & KMOD_FILTER_BLOCKLIST) &&
+				module_is_blocklisted(mod))
 			continue;
 
 		if ((filter_type & KMOD_FILTER_BUILTIN)
@@ -1219,13 +1219,13 @@ static int kmod_module_get_probe_list(struct kmod_module *mod,
  * KMOD_PROBE_FAIL_ON_LOADED: if KMOD_PROBE_IGNORE_LOADED is not specified
  * and the module is already live in kernel, the function will fail if this
  * flag is specified;
- * KMOD_PROBE_APPLY_BLACKLIST_ALL: probe will apply KMOD_FILTER_BLACKLIST
+ * KMOD_PROBE_APPLY_BLOCKLIST_ALL: probe will apply KMOD_FILTER_BLOCKLIST
  * filter to this module and its dependencies. If any of the dependencies (or
- * the module) is blacklisted, the probe will fail, unless the blacklisted
+ * the module) is blocklisted, the probe will fail, unless the blocklisted
  * module is already live in kernel;
- * KMOD_PROBE_APPLY_BLACKLIST: probe will fail if the module is blacklisted;
- * KMOD_PROBE_APPLY_BLACKLIST_ALIAS_ONLY: probe will fail if the module is an
- * alias and is blacklisted.
+ * KMOD_PROBE_APPLY_BLOCKLIST: probe will fail if the module is blocklisted;
+ * KMOD_PROBE_APPLY_BLOCKLIST_ALIAS_ONLY: probe will fail if the module is an
+ * alias and is blocklisted.
  * @extra_options: module's options to pass to Linux Kernel. It applies only
  * to @mod, not to its dependencies.
  * @run_install: function to run when @mod is backed by an install command.
@@ -1235,7 +1235,7 @@ static int kmod_module_get_probe_list(struct kmod_module *mod,
  * output or in dry-run mode.
  *
  * Insert a module in Linux kernel resolving dependencies, soft dependencies,
- * install commands and applying blacklist.
+ * install commands and applying blocklist.
  *
  * If @run_install is NULL, this function will fork and exec by calling
  * system(3). Don't pass a NULL argument in @run_install if your binary is
@@ -1271,14 +1271,14 @@ KMOD_EXPORT int kmod_module_probe_insert_module(struct kmod_module *mod,
 
 	/*
 	 * Ugly assignement + check. We need to check if we were told to check
-	 * blacklist and also return the reason why we failed.
-	 * KMOD_PROBE_APPLY_BLACKLIST_ALIAS_ONLY will take effect only if the
+	 * blocklist and also return the reason why we failed.
+	 * KMOD_PROBE_APPLY_BLOCKLIST_ALIAS_ONLY will take effect only if the
 	 * module is an alias, so we also need to check it
 	 */
-	if ((mod->alias != NULL && ((err = flags & KMOD_PROBE_APPLY_BLACKLIST_ALIAS_ONLY)))
-			|| (err = flags & KMOD_PROBE_APPLY_BLACKLIST_ALL)
-			|| (err = flags & KMOD_PROBE_APPLY_BLACKLIST)) {
-		if (module_is_blacklisted(mod))
+	if ((mod->alias != NULL && ((err = flags & KMOD_PROBE_APPLY_BLOCKLIST_ALIAS_ONLY)))
+			|| (err = flags & KMOD_PROBE_APPLY_BLOCKLIST_ALL)
+			|| (err = flags & KMOD_PROBE_APPLY_BLOCKLIST)) {
+		if (module_is_blocklisted(mod))
 			return err;
 	}
 
@@ -1287,17 +1287,17 @@ KMOD_EXPORT int kmod_module_probe_insert_module(struct kmod_module *mod,
 	if (err < 0)
 		return err;
 
-	if (flags & KMOD_PROBE_APPLY_BLACKLIST_ALL) {
+	if (flags & KMOD_PROBE_APPLY_BLOCKLIST_ALL) {
 		struct kmod_list *filtered = NULL;
 
 		err = kmod_module_apply_filter(mod->ctx,
-				KMOD_FILTER_BLACKLIST, list, &filtered);
+				KMOD_FILTER_BLOCKLIST, list, &filtered);
 		if (err < 0)
 			return err;
 
 		kmod_module_unref_list(list);
 		if (filtered == NULL)
-			return KMOD_PROBE_APPLY_BLACKLIST_ALL;
+			return KMOD_PROBE_APPLY_BLOCKLIST_ALL;
 
 		list = filtered;
 	}
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index 3cab2e5..694ff6e 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -106,7 +106,7 @@ struct kmod_list *kmod_list_last(const struct kmod_list *list);
  * key/value stored by kmod
  */
 struct kmod_config_iter;
-struct kmod_config_iter *kmod_config_get_blacklists(const struct kmod_ctx *ctx);
+struct kmod_config_iter *kmod_config_get_blocklists(const struct kmod_ctx *ctx);
 struct kmod_config_iter *kmod_config_get_install_commands(const struct kmod_ctx *ctx);
 struct kmod_config_iter *kmod_config_get_remove_commands(const struct kmod_ctx *ctx);
 struct kmod_config_iter *kmod_config_get_aliases(const struct kmod_ctx *ctx);
@@ -160,14 +160,14 @@ enum kmod_probe {
 	KMOD_PROBE_FAIL_ON_LOADED =		0x00020,
 
 	/* codes below can be used in return value, too */
-	KMOD_PROBE_APPLY_BLACKLIST_ALL =	0x10000,
-	KMOD_PROBE_APPLY_BLACKLIST =		0x20000,
-	KMOD_PROBE_APPLY_BLACKLIST_ALIAS_ONLY =	0x40000,
+	KMOD_PROBE_APPLY_BLOCKLIST_ALL =	0x10000,
+	KMOD_PROBE_APPLY_BLOCKLIST =		0x20000,
+	KMOD_PROBE_APPLY_BLOCKLIST_ALIAS_ONLY =	0x40000,
 };
 
 /* Flags to kmod_module_apply_filter() */
 enum kmod_filter {
-	KMOD_FILTER_BLACKLIST = 0x00001,
+	KMOD_FILTER_BLOCKLIST = 0x00001,
 	KMOD_FILTER_BUILTIN = 0x00002,
 };
 
@@ -191,7 +191,7 @@ const char *kmod_module_get_remove_commands(const struct kmod_module *mod);
 struct kmod_list *kmod_module_get_dependencies(const struct kmod_module *mod);
 int kmod_module_get_softdeps(const struct kmod_module *mod,
 				struct kmod_list **pre, struct kmod_list **post);
-int kmod_module_get_filtered_blacklist(const struct kmod_ctx *ctx,
+int kmod_module_get_filtered_blocklist(const struct kmod_ctx *ctx,
 					const struct kmod_list *input,
 					struct kmod_list **output) __attribute__ ((deprecated));
 int kmod_module_apply_filter(const struct kmod_ctx *ctx,
diff --git a/libkmod/libkmod.sym b/libkmod/libkmod.sym
index 5f5e1fb..f667323 100644
--- a/libkmod/libkmod.sym
+++ b/libkmod/libkmod.sym
@@ -15,7 +15,7 @@ global:
 	kmod_load_resources;
 	kmod_unload_resources;
 	kmod_validate_resources;
-	kmod_config_get_blacklists;
+	kmod_config_get_blocklists;
 	kmod_config_get_install_commands;
 	kmod_config_get_remove_commands;
 	kmod_config_get_aliases;
@@ -41,7 +41,7 @@ global:
 
 	kmod_module_get_dependencies;
 	kmod_module_get_softdeps;
-	kmod_module_get_filtered_blacklist;
+	kmod_module_get_filtered_blocklist;
 
 	kmod_module_get_name;
 	kmod_module_get_path;
diff --git a/libkmod/python/kmod/_libkmod_h.pxd b/libkmod/python/kmod/_libkmod_h.pxd
index 7191953..df2ff1a 100644
--- a/libkmod/python/kmod/_libkmod_h.pxd
+++ b/libkmod/python/kmod/_libkmod_h.pxd
@@ -70,7 +70,7 @@ cdef extern from 'libkmod/libkmod.h':
 
     # Flags to kmod_module_probe_insert_module
     # codes below can be used in return value, too
-    enum: KMOD_PROBE_APPLY_BLACKLIST
+    enum: KMOD_PROBE_APPLY_BLOCKLIST
 
     #ctypedef int (*install_callback_t)(
     #    kmod_module *m, const_char_ptr cmdline, const_void_ptr data)
diff --git a/libkmod/python/kmod/kmod.pyx b/libkmod/python/kmod/kmod.pyx
index 3e73a1c..ae2ffff 100644
--- a/libkmod/python/kmod/kmod.pyx
+++ b/libkmod/python/kmod/kmod.pyx
@@ -70,7 +70,7 @@ cdef class Kmod (object):
             mod.from_mod_list_item(item)
             yield mod
 
-    def lookup(self, alias_name, flags=_libkmod_h.KMOD_PROBE_APPLY_BLACKLIST):
+    def lookup(self, alias_name, flags=_libkmod_h.KMOD_PROBE_APPLY_BLOCKLIST):
         "iterate through modules matching `alias_name`"
         cdef _list.ModList ml = _list.ModList()
         cdef _list.ModListItem mli
diff --git a/testsuite/.gitignore b/testsuite/.gitignore
index 9d26b88..aa4b1c6 100644
--- a/testsuite/.gitignore
+++ b/testsuite/.gitignore
@@ -6,7 +6,7 @@
 /test-strbuf
 /test-array
 /test-util
-/test-blacklist
+/test-blocklist
 /test-dependencies
 /test-depmod
 /test-init
@@ -29,8 +29,8 @@
 /test-array.trs
 /test-util.log
 /test-util.trs
-/test-blacklist.log
-/test-blacklist.trs
+/test-blocklist.log
+/test-blocklist.trs
 /test-dependencies.log
 /test-dependencies.trs
 /test-depmod.log
diff --git a/testsuite/rootfs-pristine/test-blacklist/etc/modprobe.d/modprobe.conf b/testsuite/rootfs-pristine/test-blacklist/etc/modprobe.d/modprobe.conf
deleted file mode 100644
index 126612f..0000000
--- a/testsuite/rootfs-pristine/test-blacklist/etc/modprobe.d/modprobe.conf
+++ /dev/null
@@ -1,2 +0,0 @@
-blacklist floppy
-blacklist pcspkr
diff --git a/testsuite/rootfs-pristine/test-blocklist/etc/modprobe.d/modprobe.conf b/testsuite/rootfs-pristine/test-blocklist/etc/modprobe.d/modprobe.conf
new file mode 100644
index 0000000..be813b0
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-blocklist/etc/modprobe.d/modprobe.conf
@@ -0,0 +1,2 @@
+blocklist floppy
+blocklist pcspkr
diff --git a/testsuite/test-blacklist.c b/testsuite/test-blocklist.c
similarity index 90%
rename from testsuite/test-blacklist.c
rename to testsuite/test-blocklist.c
index d03eedb..2555b0e 100644
--- a/testsuite/test-blacklist.c
+++ b/testsuite/test-blocklist.c
@@ -27,7 +27,7 @@
 
 #include <libkmod/libkmod.h>
 
-/* good luck bulding a kmod_list outside of the library... makes this blacklist
+/* good luck bulding a kmod_list outside of the library... makes this blocklist
  * function rather pointless */
 #include <libkmod/libkmod-internal.h>
 
@@ -35,7 +35,7 @@
 #undef ERR
 #include "testsuite.h"
 
-static int blacklist_1(const struct test *t)
+static int blocklist_1(const struct test *t)
 {
 	struct kmod_ctx *ctx;
 	struct kmod_list *list = NULL, *l, *filtered;
@@ -57,7 +57,7 @@ static int blacklist_1(const struct test *t)
 		list = kmod_list_append(list, mod);
 	}
 
-	err = kmod_module_apply_filter(ctx, KMOD_FILTER_BLACKLIST, list,
+	err = kmod_module_apply_filter(ctx, KMOD_FILTER_BLOCKLIST, list,
 								&filtered);
 	if (err < 0) {
 		ERR("Could not filter: %s\n", strerror(-err));
@@ -94,13 +94,13 @@ fail_lookup:
 	return EXIT_FAILURE;
 }
 
-DEFINE_TEST(blacklist_1,
+DEFINE_TEST(blocklist_1,
 #if defined(KMOD_SYSCONFDIR_NOT_ETC)
         .skip = true,
 #endif
-	.description = "check if modules are correctly blacklisted",
+	.description = "check if modules are correctly blocklisted",
 	.config = {
-		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-blacklist/",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-blocklist/",
 	},
 	.need_spawn = true,
 );
diff --git a/tools/insert.c b/tools/insert.c
index 0ebcef9..aec1d78 100644
--- a/tools/insert.c
+++ b/tools/insert.c
@@ -45,8 +45,8 @@ static void help(void)
 static const char *mod_strerror(int err)
 {
 	switch (err) {
-	case KMOD_PROBE_APPLY_BLACKLIST:
-		return "Module is blacklisted";
+	case KMOD_PROBE_APPLY_BLOCKLIST:
+		return "Module is blocklisted";
 	case -EEXIST:
 		return "Module already in kernel";
 	case -ENOENT:
@@ -106,7 +106,7 @@ static int do_insert(int argc, char *argv[])
 	kmod_list_foreach(l, list) {
 		struct kmod_module *mod = kmod_module_get_module(l);
 
-		err = kmod_module_probe_insert_module(mod, KMOD_PROBE_APPLY_BLACKLIST, NULL, NULL, NULL, NULL);
+		err = kmod_module_probe_insert_module(mod, KMOD_PROBE_APPLY_BLOCKLIST, NULL, NULL, NULL, NULL);
 		if (err != 0) {
 			r = EXIT_FAILURE;
 			ERR("Could not insert '%s': %s\n", kmod_module_get_name(mod), mod_strerror(err));
diff --git a/tools/modprobe.c b/tools/modprobe.c
index 9387537..95b3a72 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -50,7 +50,7 @@ static int ignore_loaded = 0;
 static int lookup_only = 0;
 static int first_time = 0;
 static int ignore_commands = 0;
-static int use_blacklist = 0;
+static int use_blocklist = 0;
 static int force = 0;
 static int strip_modversion = 0;
 static int strip_vermagic = 0;
@@ -66,7 +66,7 @@ static const struct option cmdopts[] = {
 	{"first-time", no_argument, 0, 3},
 	{"ignore-install", no_argument, 0, 'i'},
 	{"ignore-remove", no_argument, 0, 'i'},
-	{"use-blacklist", no_argument, 0, 'b'},
+	{"use-blocklist", no_argument, 0, 'b'},
 	{"force", no_argument, 0, 'f'},
 	{"force-modversion", no_argument, 0, 2},
 	{"force-vermagic", no_argument, 0, 1},
@@ -112,7 +112,7 @@ static void help(void)
 		"\t    --first-time            Fail if module already inserted or removed\n"
 		"\t-i, --ignore-install        Ignore install commands\n"
 		"\t-i, --ignore-remove         Ignore remove commands\n"
-		"\t-b, --use-blacklist         Apply blacklist to resolved alias.\n"
+		"\t-b, --use-blocklist         Apply blocklist to resolved alias.\n"
 		"\t-f, --force                 Force module insertion or removal.\n"
 		"\t                            implies --force-modversions and\n"
 		"\t                            --force-vermagic\n"
@@ -166,7 +166,7 @@ static int show_config(struct kmod_ctx *ctx)
 		const char *name;
 		struct kmod_config_iter *(*get_iter)(const struct kmod_ctx *ctx);
 	} ci[] = {
-		{ "blacklist", kmod_config_get_blacklists },
+		{ "blocklist", kmod_config_get_blocklists },
 		{ "install", kmod_config_get_install_commands },
 		{ "remove", kmod_config_get_remove_commands },
 		{ "alias", kmod_config_get_aliases },
@@ -545,10 +545,10 @@ static int insmod(struct kmod_ctx *ctx, const char *alias,
 	if (do_show || verbose > DEFAULT_VERBOSE)
 		show = &print_action;
 
-	flags |= KMOD_PROBE_APPLY_BLACKLIST_ALIAS_ONLY;
+	flags |= KMOD_PROBE_APPLY_BLOCKLIST_ALIAS_ONLY;
 
-	if (use_blacklist)
-		flags |= KMOD_PROBE_APPLY_BLACKLIST;
+	if (use_blocklist)
+		flags |= KMOD_PROBE_APPLY_BLOCKLIST;
 	if (first_time)
 		flags |= KMOD_PROBE_FAIL_ON_LOADED;
 
@@ -563,7 +563,7 @@ static int insmod(struct kmod_ctx *ctx, const char *alias,
 		}
 
 		if (err >= 0)
-			/* ignore flag return values such as a mod being blacklisted */
+			/* ignore flag return values such as a mod being blocklisted */
 			err = 0;
 		else {
 			switch (err) {
@@ -798,7 +798,7 @@ static int do_modprobe(int argc, char **orig_argv)
 			ignore_commands = 1;
 			break;
 		case 'b':
-			use_blacklist = 1;
+			use_blocklist = 1;
 			break;
 		case 'f':
 			force = 1;
-- 
2.27.0

