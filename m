Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0F12E1FD
	for <linux-modules@vger.kernel.org>; Wed, 27 Mar 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548713; cv=none; b=f3cQxNFQMv5ZF1VPccddYHrq8ub4DitXUsFmfENoMzMSxwVhdVeXIMb1he31xyffgpu94rwPF+tdPpjSZzSXrRKaPEoA4wGaEO2FHTSrTK7pJzYdtubVAArvhlkIdEe/Da5ECOfyAD178SNObSK4gGaIhwwlOrcQLEcxk8Ap9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548713; c=relaxed/simple;
	bh=HxJ6RYTgWhDhf0x47FmNd4KAxA87HuB9paHnDEah+Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qwx47qLYEyzCK83/khpEUXdpNVoaCXGC9a83EW9YZndbPUGp4aLhn1mdCXDNlHNU0Kmoqub8YK0hjZNOLf1tQRx6+cGlc+tVvSlXirh1Y8c4MmCfJr5S/myXgB8igVsrG2TMfJE5jVLojnrLnu+LehoE3VnNLjANoXcWQ1D/Uwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqVn+J/w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqVn+J/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711548709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqpa6+NlZijAJfLqiO7xlzVReEa/WqyvZrc6kYfZzzw=;
	b=SqVn+J/wsDuqSMrUE6xlaSS3rVCfxJx3uUC4lNO6mOolPMRS/XlpHSL5OTYUBfjtPvaD+n
	4unY4w5YlufOduJCNmlePDTZqUbJCklkRx6U+i7P0oUUKJ28gw6FnhN8NcUO/ZYK7tA1eh
	lFTED1+5dFqLDUvKmXW8zfYpcl3Q99U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-DVKQDeWmOz21IJlnbh2dJg-1; Wed, 27 Mar 2024 10:11:46 -0400
X-MC-Unique: DVKQDeWmOz21IJlnbh2dJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1A0F85A58B;
	Wed, 27 Mar 2024 14:11:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.90])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 42E4C40C6CB1;
	Wed, 27 Mar 2024 14:11:44 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lucas.demarchi@intel.com
Cc: emil.velikov@collabora.com,
	gustavo.sousa@intel.com,
	jtornosm@redhat.com,
	linux-modules@vger.kernel.org,
	mcgrof@kernel.org,
	md@linux.it
Subject: [PATCH v2 patch] libkmod: add weak dependecies
Date: Wed, 27 Mar 2024 15:11:16 +0100
Message-ID: <20240327141116.97587-1-jtornosm@redhat.com>
In-Reply-To: <7vowjj4oo64a2vquvqaszmzcdvbrlkntcze2btnogvkwwtuddv@uz72wpi2t55s>
References: <7vowjj4oo64a2vquvqaszmzcdvbrlkntcze2btnogvkwwtuddv@uz72wpi2t55s>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

It has been seen that for some network mac drivers (i.e. lan78xx) the
related module for the phy is loaded dynamically depending on the current
hardware. In this case, the associated phy is read using mdio bus and then
the associated phy module is loaded during runtime (kernel function
phy_request_driver_module). However, no software dependency is defined, so
the user tools will no be able to get this dependency. For example, if
dracut is used and the hardware is present, lan78xx will be included but no
phy module will be added, and in the next restart the device will not work
from boot because no related phy will be found during initramfs stage.

In order to solve this, we could define a normal 'pre' software dependency
in lan78xx module with all the possible phy modules (there may be some),
but proceeding in that way, all the possible phy modules would be loaded
while only one is necessary.

The idea is to create a new type of dependency, that we are going to call
'weak' to be used only by the user tools that need to detect this situation.
In that way, for example, dracut could check the 'weak' dependency of the
modules involved in order to install these dependencies in initramfs too.
That is, for the commented lan78xx module, defining the 'weak' dependency
with the possible phy modules list, only the necessary phy would be loaded
on demand keeping the same behavior, but all the possible phy modules would
be available from initramfs.

A new function 'kmod_module_get_weakdeps' in libkmod will be added for
this to avoid breaking the API and maintain backward compatibility. This
general procedure could be useful for other similar cases (not only for
dynamic phy loading).

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- Better to create a new type of dependency 'weak' as Lucas De Marchi
suggests.
- Complete modprobe.d(5) with the comments from Lucas De Marchi.

 libkmod/docs/libkmod-sections.txt |   2 +
 libkmod/libkmod-config.c          | 212 ++++++++++++++++++++++++++++++
 libkmod/libkmod-internal.h        |   3 +
 libkmod/libkmod-module.c          |  58 +++++++-
 libkmod/libkmod.h                 |   3 +
 libkmod/libkmod.sym               |   2 +
 man/modprobe.d.5.xml              |  24 ++++
 tools/depmod.c                    |  25 ++++
 tools/modprobe.c                  |   1 +
 9 files changed, 326 insertions(+), 4 deletions(-)

diff --git a/libkmod/docs/libkmod-sections.txt b/libkmod/docs/libkmod-sections.txt
index 33d9eec..978b064 100644
--- a/libkmod/docs/libkmod-sections.txt
+++ b/libkmod/docs/libkmod-sections.txt
@@ -37,6 +37,7 @@ kmod_config_get_remove_commands
 kmod_config_get_aliases
 kmod_config_get_options
 kmod_config_get_softdeps
+kmod_config_get_weakdeps
 kmod_config_iter_get_key
 kmod_config_iter_get_value
 kmod_config_iter_next
@@ -62,6 +63,7 @@ kmod_module_remove_module
 kmod_module_get_module
 kmod_module_get_dependencies
 kmod_module_get_softdeps
+kmod_module_get_weakdeps
 kmod_module_apply_filter
 kmod_module_get_filtered_blacklist
 kmod_module_get_install_commands
diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index e83621b..a571b6b 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -58,6 +58,12 @@ struct kmod_softdep {
 	unsigned int n_post;
 };
 
+struct kmod_weakdep {
+	char *name;
+	const char **weak;
+	unsigned int n_weak;
+};
+
 const char *kmod_blacklist_get_modname(const struct kmod_list *l)
 {
 	return l->data;
@@ -110,6 +116,16 @@ const char * const *kmod_softdep_get_post(const struct kmod_list *l, unsigned in
 	return dep->post;
 }
 
+const char *kmod_weakdep_get_name(const struct kmod_list *l) {
+	const struct kmod_weakdep *dep = l->data;
+	return dep->name;
+}
+
+const char * const *kmod_weakdep_get_weak(const struct kmod_list *l, unsigned int *count) {
+	const struct kmod_weakdep *dep = l->data;
+	*count = dep->n_weak;
+	return dep->weak;
+}
 static int kmod_config_add_command(struct kmod_config *config,
 						const char *modname,
 						const char *command,
@@ -392,6 +408,112 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 	return 0;
 }
 
+static int kmod_config_add_weakdep(struct kmod_config *config,
+							const char *modname,
+							const char *line)
+{
+	struct kmod_list *list;
+	struct kmod_weakdep *dep;
+	const char *s, *p;
+	char *itr;
+	unsigned int n_weak = 0;
+	size_t modnamelen = strlen(modname) + 1;
+	size_t buflen = 0;
+	bool was_space = false;
+
+	DBG(config->ctx, "modname=%s\n", modname);
+
+	/* analyze and count */
+	for (p = s = line; ; s++) {
+		size_t plen;
+
+		if (*s != '\0') {
+			if (!isspace(*s)) {
+				was_space = false;
+				continue;
+			}
+
+			if (was_space) {
+				p = s + 1;
+				continue;
+			}
+			was_space = true;
+
+			if (p >= s)
+				continue;
+		}
+		plen = s - p;
+
+		if (*s != '\0' || (*s == '\0' && !was_space)) {
+			buflen += plen + 1;
+			n_weak++;
+		}
+		p = s + 1;
+		if (*s == '\0')
+			break;
+	}
+
+	DBG(config->ctx, "%u weak\n", n_weak);
+
+	dep = malloc(sizeof(struct kmod_weakdep) + modnamelen +
+		     n_weak * sizeof(const char *) +
+		     buflen);
+	if (dep == NULL) {
+		ERR(config->ctx, "out-of-memory modname=%s\n", modname);
+		return -ENOMEM;
+	}
+	dep->n_weak = n_weak;
+	dep->weak = (const char **)((char *)dep + sizeof(struct kmod_weakdep));
+	dep->name = (char *)(dep->weak + n_weak);
+
+	memcpy(dep->name, modname, modnamelen);
+
+	/* copy strings */
+	itr = dep->name + modnamelen;
+	n_weak = 0;
+	was_space = false;
+	for (p = s = line; ; s++) {
+		size_t plen;
+
+		if (*s != '\0') {
+			if (!isspace(*s)) {
+				was_space = false;
+				continue;
+			}
+
+			if (was_space) {
+				p = s + 1;
+				continue;
+			}
+			was_space = true;
+
+			if (p >= s)
+				continue;
+		}
+		plen = s - p;
+
+		if (*s != '\0' || (*s == '\0' && !was_space)) {
+			dep->weak[n_weak] = itr;
+			memcpy(itr, p, plen);
+			itr[plen] = '\0';
+			itr += plen + 1;
+			n_weak++;
+		}
+		p = s + 1;
+		if (*s == '\0')
+			break;
+	}
+
+	list = kmod_list_append(config->weakdeps, dep);
+	if (list == NULL) {
+		free(dep);
+		return -ENOMEM;
+	}
+	config->weakdeps = list;
+
+	return 0;
+}
+
 static char *softdep_to_char(struct kmod_softdep *dep) {
 	const size_t sz_preprefix = sizeof("pre: ") - 1;
 	const size_t sz_postprefix = sizeof("post: ") - 1;
@@ -461,6 +583,44 @@ static char *softdep_to_char(struct kmod_softdep *dep) {
 	return s;
 }
 
+static char *weakdep_to_char(struct kmod_weakdep *dep) {
+	size_t sz;
+	const char *start, *end;
+	char *s, *itr;
+
+	/*
+	 * Rely on the fact that dep->weak[] and are strv's that point to a
+	 * contiguous buffer
+	 */
+	if (dep->n_weak > 0) {
+		start = dep->weak[0];
+		end = dep->weak[dep->n_weak - 1]
+					+ strlen(dep->weak[dep->n_weak - 1]);
+		sz = end - start;
+	} else
+		sz = 0;
+
+	itr = s = malloc(sz);
+	if (s == NULL)
+		return NULL;
+
+	if (sz) {
+		char *p;
+
+		/* include last '\0' */
+		memcpy(itr, dep->weak[0], sz + 1);
+		for (p = itr; p < itr + sz; p++) {
+			if (*p == '\0')
+				*p = ' ';
+		}
+		itr = p;
+	}
+
+	*itr = '\0';
+
+	return s;
+}
+
 static void kmod_config_free_softdep(struct kmod_config *config,
 							struct kmod_list *l)
 {
@@ -468,6 +628,13 @@ static void kmod_config_free_softdep(struct kmod_config *config,
 	config->softdeps = kmod_list_remove(l);
 }
 
+static void kmod_config_free_weakdep(struct kmod_config *config,
+							struct kmod_list *l)
+{
+	free(l->data);
+	config->weakdeps = kmod_list_remove(l);
+}
+
 static void kcmdline_parse_result(struct kmod_config *config, char *modname,
 						char *param, char *value)
 {
@@ -703,6 +870,14 @@ static int kmod_config_parse(struct kmod_config *config, int fd,
 				goto syntax_error;
 
 			kmod_config_add_softdep(config, modname, softdeps);
+		} else if (streq(cmd, "weakdep")) {
+			char *modname = strtok_r(NULL, "\t ", &saveptr);
+			char *weakdeps = strtok_r(NULL, "\0", &saveptr);
+
+			if (underscores(modname) < 0 || weakdeps == NULL)
+				goto syntax_error;
+
+			kmod_config_add_weakdep(config, modname, weakdeps);
 		} else if (streq(cmd, "include")
 				|| streq(cmd, "config")) {
 			ERR(ctx, "%s: command %s is deprecated and not parsed anymore\n",
@@ -746,6 +921,9 @@ void kmod_config_free(struct kmod_config *config)
 	while (config->softdeps)
 		kmod_config_free_softdep(config, config->softdeps);
 
+	while (config->weakdeps)
+		kmod_config_free_weakdep(config, config->weakdeps);
+
 	for (; config->paths != NULL;
 				config->paths = kmod_list_remove(config->paths))
 		free(config->paths->data);
@@ -889,6 +1067,7 @@ int kmod_config_new(struct kmod_ctx *ctx, struct kmod_config **p_config,
 	size_t i;
 
 	conf_files_insert_sorted(ctx, &list, kmod_get_dirname(ctx), "modules.softdep");
+	conf_files_insert_sorted(ctx, &list, kmod_get_dirname(ctx), "modules.weakdep");
 
 	for (i = 0; config_paths[i] != NULL; i++) {
 		const char *path = config_paths[i];
@@ -973,6 +1152,7 @@ enum config_type {
 	CONFIG_TYPE_ALIAS,
 	CONFIG_TYPE_OPTION,
 	CONFIG_TYPE_SOFTDEP,
+	CONFIG_TYPE_WEAKDEP,
 };
 
 struct kmod_config_iter {
@@ -991,6 +1171,12 @@ static const char *softdep_get_plain_softdep(const struct kmod_list *l)
 	return s;
 }
 
+static const char *weakdep_get_plain_weakdep(const struct kmod_list *l)
+{
+	char *s = weakdep_to_char(l->data);
+	return s;
+}
+
 static struct kmod_config_iter *kmod_config_iter_new(const struct kmod_ctx* ctx,
 							enum config_type type)
 {
@@ -1033,6 +1219,12 @@ static struct kmod_config_iter *kmod_config_iter_new(const struct kmod_ctx* ctx,
 		iter->get_value = softdep_get_plain_softdep;
 		iter->intermediate = true;
 		break;
+	case CONFIG_TYPE_WEAKDEP:
+		iter->list = config->weakdeps;
+		iter->get_key = kmod_weakdep_get_name;
+		iter->get_value = weakdep_get_plain_weakdep;
+		iter->intermediate = true;
+		break;
 	}
 
 	return iter;
@@ -1163,6 +1355,26 @@ KMOD_EXPORT struct kmod_config_iter *kmod_config_get_softdeps(const struct kmod_
 	return kmod_config_iter_new(ctx, CONFIG_TYPE_SOFTDEP);
 }
 
+/**
+ * kmod_config_get_weakdeps:
+ * @ctx: kmod library context
+ *
+ * Retrieve an iterator to deal with the weakdeps maintained inside the
+ * library. See kmod_config_iter_get_key(), kmod_config_iter_get_value() and
+ * kmod_config_iter_next(). At least one call to kmod_config_iter_next() must
+ * be made to initialize the iterator and check if it's valid.
+ *
+ * Returns: a new iterator over the weakdeps or NULL on failure. Free it with
+ * kmod_config_iter_free_iter().
+ */
+KMOD_EXPORT struct kmod_config_iter *kmod_config_get_weakdeps(const struct kmod_ctx *ctx)
+{
+	if (ctx == NULL)
+		return NULL;;
+
+	return kmod_config_iter_new(ctx, CONFIG_TYPE_WEAKDEP);
+}
+
 /**
  * kmod_config_iter_get_key:
  * @iter: iterator over a certain configuration
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 26a7e28..52ddbe6 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -128,6 +128,7 @@ struct kmod_config {
 	struct kmod_list *remove_commands;
 	struct kmod_list *install_commands;
 	struct kmod_list *softdeps;
+	struct kmod_list *weakdeps;
 
 	struct kmod_list *paths;
 };
@@ -146,6 +147,8 @@ const char *kmod_softdep_get_name(const struct kmod_list *l) __attribute__((nonn
 const char * const *kmod_softdep_get_pre(const struct kmod_list *l, unsigned int *count) __attribute__((nonnull(1, 2)));
 const char * const *kmod_softdep_get_post(const struct kmod_list *l, unsigned int *count);
 
+const char *kmod_weakdep_get_name(const struct kmod_list *l) __attribute__((nonnull(1)));
+const char * const *kmod_weakdep_get_weak(const struct kmod_list *l, unsigned int *count) __attribute__((nonnull(1, 2)));
 
 /* libkmod-module.c */
 int kmod_module_new_from_alias(struct kmod_ctx *ctx, const char *alias, const char *name, struct kmod_module **mod);
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 585da41..4f23ffb 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -1589,7 +1589,7 @@ void kmod_module_set_install_commands(struct kmod_module *mod, const char *cmd)
 	mod->install_commands = cmd;
 }
 
-static struct kmod_list *lookup_softdep(struct kmod_ctx *ctx, const char * const * array, unsigned int count)
+static struct kmod_list *lookup_dep(struct kmod_ctx *ctx, const char * const * array, unsigned int count)
 {
 	struct kmod_list *ret = NULL;
 	unsigned i;
@@ -1601,7 +1601,7 @@ static struct kmod_list *lookup_softdep(struct kmod_ctx *ctx, const char * const
 
 		err = kmod_module_new_from_lookup(ctx, depname, &lst);
 		if (err < 0) {
-			ERR(ctx, "failed to lookup soft dependency '%s', continuing anyway.\n", depname);
+			ERR(ctx, "failed to lookup dependency '%s', continuing anyway.\n", depname);
 			continue;
 		} else if (lst != NULL)
 			ret = kmod_list_append_list(ret, lst);
@@ -1650,9 +1650,59 @@ KMOD_EXPORT int kmod_module_get_softdeps(const struct kmod_module *mod,
 			continue;
 
 		array = kmod_softdep_get_pre(l, &count);
-		*pre = lookup_softdep(mod->ctx, array, count);
+		*pre = lookup_dep(mod->ctx, array, count);
 		array = kmod_softdep_get_post(l, &count);
-		*post = lookup_softdep(mod->ctx, array, count);
+		*post = lookup_dep(mod->ctx, array, count);
+
+		/*
+		 * find only the first command, as modprobe from
+		 * module-init-tools does
+		 */
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * kmod_module_get_weakdeps:
+ * @mod: kmod module
+ * @weak: where to save the list of weak dependencies.
+ *
+ * Get weak dependencies for this kmod module. Weak dependencies come
+ * from configuration file and are not cached in @mod because it may include
+ * dependency cycles that would make we leak kmod_module. Any call
+ * to this function will search for this module in configuration, allocate a
+ * list and return the result.
+ *
+ * @weak is newly created list of kmod_module and
+ * should be unreferenced with kmod_module_unref_list().
+ *
+ * Returns: 0 on success or < 0 otherwise.
+ */
+KMOD_EXPORT int kmod_module_get_weakdeps(const struct kmod_module *mod,
+						struct kmod_list **weak)
+{
+	const struct kmod_list *l;
+	const struct kmod_config *config;
+
+	if (mod == NULL || weak == NULL)
+		return -ENOENT;
+
+	assert(*weak == NULL);
+
+	config = kmod_get_config(mod->ctx);
+
+	kmod_list_foreach(l, config->weakdeps) {
+		const char *modname = kmod_weakdep_get_name(l);
+		const char * const *array;
+		unsigned count;
+
+		if (fnmatch(modname, mod->name, 0) != 0)
+			continue;
+
+		array = kmod_weakdep_get_weak(l, &count);
+		*weak = lookup_dep(mod->ctx, array, count);
 
 		/*
 		 * find only the first command, as modprobe from
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index 7251aa7..fce66d1 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -112,6 +112,7 @@ struct kmod_config_iter *kmod_config_get_remove_commands(const struct kmod_ctx *
 struct kmod_config_iter *kmod_config_get_aliases(const struct kmod_ctx *ctx);
 struct kmod_config_iter *kmod_config_get_options(const struct kmod_ctx *ctx);
 struct kmod_config_iter *kmod_config_get_softdeps(const struct kmod_ctx *ctx);
+struct kmod_config_iter *kmod_config_get_weakdeps(const struct kmod_ctx *ctx);
 const char *kmod_config_iter_get_key(const struct kmod_config_iter *iter);
 const char *kmod_config_iter_get_value(const struct kmod_config_iter *iter);
 bool kmod_config_iter_next(struct kmod_config_iter *iter);
@@ -196,6 +197,8 @@ const char *kmod_module_get_remove_commands(const struct kmod_module *mod);
 struct kmod_list *kmod_module_get_dependencies(const struct kmod_module *mod);
 int kmod_module_get_softdeps(const struct kmod_module *mod,
 				struct kmod_list **pre, struct kmod_list **post);
+int kmod_module_get_weakdeps(const struct kmod_module *mod,
+				struct kmod_list **weak);
 int kmod_module_get_filtered_blacklist(const struct kmod_ctx *ctx,
 					const struct kmod_list *input,
 					struct kmod_list **output) __attribute__ ((deprecated));
diff --git a/libkmod/libkmod.sym b/libkmod/libkmod.sym
index 0c04fda..0d6d338 100644
--- a/libkmod/libkmod.sym
+++ b/libkmod/libkmod.sym
@@ -21,6 +21,7 @@ global:
 	kmod_config_get_aliases;
 	kmod_config_get_options;
 	kmod_config_get_softdeps;
+	kmod_config_get_weakdeps;
 	kmod_config_iter_get_key;
 	kmod_config_iter_get_value;
 	kmod_config_iter_next;
@@ -42,6 +43,7 @@ global:
 
 	kmod_module_get_dependencies;
 	kmod_module_get_softdeps;
+	kmod_module_get_weakdeps;
 	kmod_module_get_filtered_blacklist;
 
 	kmod_module_get_name;
diff --git a/man/modprobe.d.5.xml b/man/modprobe.d.5.xml
index 2bf6537..cc90da6 100644
--- a/man/modprobe.d.5.xml
+++ b/man/modprobe.d.5.xml
@@ -212,6 +212,30 @@
           </para>
         </listitem>
       </varlistentry>
+      <varlistentry>
+        <term>weakdep <replaceable>modulename</replaceable> <replaceable>modules...</replaceable>
+        </term>
+        <listitem>
+          <para>
+            The <command>weakdep</command> command allows you to specify weak module
+            dependencies. Those are similar to pre softdep, with the
+            difference that userspace doesn't attempt to load that
+            dependency before the specified module. Instead the kernel
+            may request one or multiple of them during module probe,
+            depending on the hardware it's binding to. The purpose of
+            weak module is to allow a driver to specify that a certain
+            dependency may be needed, so it should be present in the
+            filesystem (e.g. in initramfs) when that module is probed.
+          </para>
+	  <para>
+            Example: Assume "weakdep c a b". A program creating an
+            initramfs knows it should add a, b, and c to the filesystem
+            since a and b may be required/desired at runtime. When c is
+            loaded and is being probed, it may issue calls to
+            request_module() causing a or b to also be loaded.
+          </para>
+        </listitem>
+      </varlistentry>
     </variablelist>
   </refsect1>
   <refsect1><title>COMPATIBILITY</title>
diff --git a/tools/depmod.c b/tools/depmod.c
index 43fc354..06618fa 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2296,6 +2296,30 @@ static int output_softdeps(struct depmod *depmod, FILE *out)
 	return 0;
 }
 
+static int output_weakdeps(struct depmod *depmod, FILE *out)
+{
+	size_t i;
+
+	fputs("# Weak dependencies extracted from modules themselves.\n", out);
+
+	for (i = 0; i < depmod->modules.count; i++) {
+		const struct mod *mod = depmod->modules.array[i];
+		struct kmod_list *l;
+
+		kmod_list_foreach(l, mod->info_list) {
+			const char *key = kmod_module_info_get_key(l);
+			const char *value = kmod_module_info_get_value(l);
+
+			if (!streq(key, "weakdep"))
+				continue;
+
+			fprintf(out, "weakdep %s %s\n", mod->modname, value);
+		}
+	}
+
+	return 0;
+}
+
 static int output_symbols(struct depmod *depmod, FILE *out)
 {
 	struct hash_iter iter;
@@ -2574,6 +2598,7 @@ static int depmod_output(struct depmod *depmod, FILE *out)
 		{ "modules.alias", output_aliases },
 		{ "modules.alias.bin", output_aliases_bin },
 		{ "modules.softdep", output_softdeps },
+		{ "modules.weakdep", output_weakdeps },
 		{ "modules.symbols", output_symbols },
 		{ "modules.symbols.bin", output_symbols_bin },
 		{ "modules.builtin.bin", output_builtin_bin },
diff --git a/tools/modprobe.c b/tools/modprobe.c
index 5306bef..4328da6 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -182,6 +182,7 @@ static int show_config(struct kmod_ctx *ctx)
 		{ "alias", kmod_config_get_aliases },
 		{ "options", kmod_config_get_options },
 		{ "softdep", kmod_config_get_softdeps },
+		{ "weakdep", kmod_config_get_weakdeps },
 	};
 	size_t i;
 
-- 
2.44.0

