Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D254662
	for <linux-modules@vger.kernel.org>; Fri, 10 May 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340099; cv=none; b=h02ymG/9lezuBs8UDV9gQP8IXCukMFWwgnSYkeghRkwa0LzUV825Z+MBVVsC4O3KH1BxYZWJKDZkPuWvF9caeUR92wuuV1GZZKiHb8Mz74V2jCMcXiLAiQNYlNWCO2UKkTURJmnsMkpiGmJEuTdl7W5RZD/O812+paDCxvxLPdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340099; c=relaxed/simple;
	bh=Qg7obT9d97nW/Bj9Zjun0D2JnS97mHIIq7G4J6jLkEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DWf1ExLHzb76SzCT5IK4988QIk+tcRrGgzL6lynmxM2G62qT7Zj6zfAFffhQRO/DbWM/rpE2tHW8fmlJUbi/CcVacX7umV1m52JpIZhel1YLDRP0mdEeOO2GWEm+uHeDiLJYMisLbouwnMke8xDmjYuRDMXcGWinOj0BR8GkAXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Uhk65CAp; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Uhk65CAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=10191; q=dns/txt;
  s=iport; t=1715340097; x=1716549697;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L62N3ZzLFkJPskgT8bq9QBAkpOkTSQvskgC/EL/XzPA=;
  b=Uhk65CApNaRsOf02CuygqNa1CAeAN2AD91t5wi4CsGfZFO+cvQ9K54pD
   HTiVJcfNNIhmbNOqhk1/NdTJ2qQUwmiy2pHdgBO/ko+Awi/365Az4BeMN
   BEDhBEtuAPQ5EaxOc5iSf9SzcwC0ZROC0vVO3VGD8mAKUFaDL/azVTFIy
   Y=;
X-CSE-ConnectionGUID: LBIQ+0UjRZeYepFZtvHCAQ==
X-CSE-MsgGUID: zRQRIt1RReCge+SWVqoQAw==
X-IPAS-Result: =?us-ascii?q?A0AvAQAgAj5mmJNdJa1agliEGEJIlj6LdJIZgSUDVg8BA?=
 =?us-ascii?q?QEPRAQBAYUGiDoCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQYBAQUBAQECAQcFF?=
 =?us-ascii?q?AEBAQEBAQEBHhkFDhAnhgGGXCsLAUaBUIMAgmUCAbE2gXkzgQHeMYFrGIEwj?=
 =?us-ascii?q?QeFZCcbgUlEgRWBO4ItiwcEhg6JOopagh+HfYVUSoEjA1khAhEBVRMNCgs+C?=
 =?us-ascii?q?RYCFgMbFAQwDwkLJgMqBjYCEgwGBgZZIBYJBCMDCAQDRAMgcREDBBoECwd1g?=
 =?us-ascii?q?zEEE0QDgTiJfYIJgTQpgXeBDoMQS4R2gXcOYYkgDwcFSUADCxgNSBEsNRQbB?=
 =?us-ascii?q?iIfbgelTj0+EwETgSlsB5NACoMgjDuCHYEynzmEHaEsGjOEBaYviByQRoJUo?=
 =?us-ascii?q?VCEY4FlOoFbTSMVO4JnUhkPji0NCdAKIzU7AgcLAQEDCYpoAQE?=
IronPort-Data: A9a23:UX9wnazhqFyEoAxvlkJ6t+cfxirEfRIJ4+MujC+fZmUNrF6WrkUBz
 mdNWG2GO63bZ2P0fNl0Ydjk8x8OvZXWyNZhSldpq1hgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlpCCea/lH0auSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 YOaT/H3Ygf/h2YpazpMsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE88jmSH
 rurIBmRpws1zj91Yj+Xuu+Tnn4iHtY+CTOzZk9+AMBOtPTtShsaic7XPNJEAateZq7gc9pZk
 L2hvrToIesl0zGldOk1C3Fl/y9C0aJu3JXmGDvnjM6p/UD3fmPC8elwLGofBNhNkgp3KTkmG
 f0wMjsBaFWIgPi7heviDOJtnc8kasLsOevzuFk5kmqfVqlgEMuFGvmVjTNb9G9YasRmA/3ea
 tAfbidHZxXbaBoJMVASYH47tL3x3CWlKGAH+Dp5o4Il2VHp7RAo6oLgG9XYOee1e9xSp2+H8
 zeuE2PRWUxCa4fFllJp6EmEgvLElDi9VI9UEbSi/f5rqFKWz20XThYRUDOTp7+igU6/Vsh3I
 lIRvCYjxYA29Uq2Xpz4WBGlpHOflgATVsAWEOAg7gyJjK3O7G6k6nMsVDVNbpkts9U7AGVzk
 FSIhNjuQzdotdV5VE5x6J+whxKLenAoL1UwaB4JVSU3/8fDi6gK20enoslYLIa5idj8GDfVy
 j+MrTQji7h7sSLt//vhlbwgq2z1zqUlXjIIChPrsnVJBz6Viaa/bICurFPc9/sFdd/fRViat
 39CkM+bhAzvMX1vvHLTKAnuNOj1jxpgDNE6qQUxd3XG32/xk0NPhagKvFlDyL5Ba67ogwPBb
 k7Joh9275ROJnasZqIfS9vuUplwkvm8S4u5Dqy8gj9yjn5ZKV7vEMZGOB744owRuBdEfVwXY
 M7EIZj2UR7294w+kWfuLwvi7VPb7ntjnTyIH8+TI+WP2ruFb3ndUqYeLFaLdag46qjCyDg5A
 P4BX/ZmPy53CbWkCgGOqNZ7BQlTcRATW8usw+QJLbHrH+aTMDx7YxMn6el/K9UNcmU8vrqgw
 0xRrWcElwCh3yKZdlTih7IKQOqHYKuTZEkTZUQEVWtEEVB6CWpzxM/zr6cKQIQ=
IronPort-HdrOrdr: A9a23:j41pbKNRJcyPw8BcTs6jsMiBIKoaSvp037Dk7SxMoHtuA66lfq
 +V8sjzuSWftN9zYgBCpTn/Asi9qBrnnPYf3WB7B9iftWfd1VdABbsSiLcKuweBJ8U7ndQtsp
 uJtMNFebnNMWQ=
X-Talos-CUID: =?us-ascii?q?9a23=3ASiVlLmijd4YU5aUwZxGlDW9RYTJuVlf89TSIHk2?=
 =?us-ascii?q?CO2tYRaW7e0OO2IhNqp87?=
X-Talos-MUID: 9a23:Zw8k1Ai+Yu/b8Ej5X+LQ9MMpJv1R2YWyUXo3nL4Jtoq/ChJpPA60k2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,150,1712620800"; 
   d="scan'208";a="212423578"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 11:21:30 +0000
Received: from sjc-ads-1541.cisco.com (sjc-ads-1541.cisco.com [171.70.59.233])
	by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id 44ABLTuC031338;
	Fri, 10 May 2024 11:21:30 GMT
From: Valerii Chernous <vchernou@cisco.com>
To: linux-modules@vger.kernel.org
Cc: xe-linux-external@cisco.com, Nicolas Schier <n.schier@avm.de>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [MODALTS v0.1 3/4] kmod: add modules.alternatives to modprobe
Date: Fri, 10 May 2024 04:21:27 -0700
Message-Id: <20240510112128.2417494-3-vchernou@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.70.59.233, sjc-ads-1541.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com

Cc: xe-linux-external@cisco.com
Cc: Valerii Chernous <vchernou@cisco.com>
Signed-off-by: Valerii Chernous <vchernou@cisco.com>
---
 libkmod/libkmod-internal.h |   2 +
 libkmod/libkmod-module.c   |  74 ++++++++++++++++++++++-
 libkmod/libkmod.c          | 118 ++++++++++++++++++++++++++++++++++++-
 libkmod/libkmod.h          |   6 ++
 4 files changed, 196 insertions(+), 4 deletions(-)

diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 0a274e7..44acfb1 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -107,6 +107,8 @@ int kmod_lookup_alias_from_kernel_builtin_file(struct kmod_ctx *ctx, const char
 int kmod_lookup_alias_from_builtin_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
 bool kmod_lookup_alias_is_builtin(struct kmod_ctx *ctx, const char *name) __attribute__((nonnull(1, 2)));
 int kmod_lookup_alias_from_commands(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
+int kmod_lookup_alternatives_from_modalt_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
+char *kmod_search_modalternatives(struct kmod_ctx *ctx, const char *name) __attribute__((nonnull(1, 2)));
 void kmod_set_modules_visited(struct kmod_ctx *ctx, bool visited) __attribute__((nonnull((1))));
 void kmod_set_modules_required(struct kmod_ctx *ctx, bool required) __attribute__((nonnull((1))));
 
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 2cdec34..5f4a877 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -107,7 +107,7 @@ struct kmod_module {
 	bool required : 1;
 };
 
-static inline const char *path_join(const char *path, size_t prefixlen,
+const char *path_join(const char *path, size_t prefixlen,
 							char buf[PATH_MAX])
 {
 	size_t pathlen;
@@ -700,11 +700,83 @@ static const struct kmod_list *module_get_dependencies_noref(const struct kmod_m
 
 		if (!mod->init.dep)
 			return NULL;
+
+		update_mod_deps_correspond_to_alternatives((struct kmod_module *)mod);
 	}
 
 	return mod->dep;
 }
 
+int update_mod_deps_correspond_to_alternatives(struct kmod_module *mod)
+{
+	if (is_index_available(mod->ctx, KMOD_INDEX_MODULES_ALTERNATIVES)) {
+		struct kmod_list *l;
+		struct kmod_list *preferred_l = NULL;
+		struct kmod_list *final_l = NULL;
+		int n;
+
+		DBG(mod->ctx, "Update deps alternatives for mod: %s\n",
+		    mod->name != NULL ? mod->name : "undef");
+		kmod_list_foreach(l, mod->dep) {
+			struct kmod_list *l_alt;
+			char buf[PATH_MAX*2];
+			struct kmod_module *dep = (struct kmod_module *)l->data;
+			struct kmod_module *preferred;
+
+			snprintf(buf, sizeof(buf), "%s#_#%s", mod->name, dep->name);
+			preferred = NULL;
+			n = kmod_lookup_alternatives_from_modalt_file(mod->ctx, buf, &l_alt);
+			if (n == 0 || n == -ENOENT) {
+				preferred = dep;
+				kmod_module_ref(preferred);
+			} else if ( n < 0) {
+				kmod_module_unref_list(preferred_l);
+				return n;
+			} else {
+				struct kmod_list *l2;
+				kmod_list_foreach(l2, l_alt) {
+					struct stat st;
+					struct kmod_module *alt = (struct kmod_module *)l2->data;
+					// if no preferrable alternative use first as preferred //
+					if (preferred == NULL)
+						preferred = alt;
+					snprintf(buf, sizeof(buf), "/sys/module/%s", alt->name);
+					if (stat(buf, &st) == 0 && S_ISDIR(st.st_mode)) {
+						// if one from alternative providers loaded use it as alternative //
+						preferred = alt;
+						break;
+					}
+				}
+				kmod_module_ref(preferred);
+				kmod_module_unref_list(l_alt);
+			}
+			preferred_l = kmod_list_append(preferred_l, preferred);
+		}
+		kmod_list_foreach_reverse(l, preferred_l) {
+			struct kmod_list *l2 = NULL;
+			struct kmod_module *dep = (struct kmod_module *)l->data;
+			final_l = kmod_list_insert_before(final_l, dep);
+			if (dep->dep == NULL) {
+				n = kmod_lookup_alias_from_moddep_file(mod->ctx, dep->name, &l2);
+				if (n < 0) {
+					DBG(mod->ctx, "Loading subdeps for %s failed\n", dep->name);
+					kmod_module_unref_list(preferred_l);
+					return n;
+				}
+			}
+			// remove duplicates from final dependencies and add all sub deps to current deps
+			kmod_list_foreach_reverse(l2, dep->dep) {
+				final_l = kmod_list_remove_data(final_l, l2->data);
+				final_l = kmod_list_insert_before(final_l, l2->data);
+			}
+		}
+		kmod_module_unref_list(mod->dep);
+		mod->dep = final_l;
+	} else
+		DBG(mod->ctx, "Alternatives indexes[%d]) didn't load\n", (int)KMOD_INDEX_MODULES_ALTERNATIVES);
+	return 0;
+}
+
 /**
  * kmod_module_get_dependencies:
  * @mod: kmod module
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 213b424..e5646b2 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -40,7 +40,7 @@
 
 #define KMOD_HASH_SIZE (256)
 #define KMOD_LRU_MAX (128)
-#define _KMOD_INDEX_MODULES_SIZE KMOD_INDEX_MODULES_BUILTIN + 1
+#define _KMOD_INDEX_MODULES_SIZE KMOD_INDEX_MODULES_ALTERNATIVES + 1
 
 /**
  * SECTION:libkmod
@@ -59,6 +59,7 @@ static const struct {
 	[KMOD_INDEX_MODULES_SYMBOL] = { .fn = "modules.symbols", .prefix = "alias "},
 	[KMOD_INDEX_MODULES_BUILTIN_ALIAS] = { .fn = "modules.builtin.alias", .prefix = "" },
 	[KMOD_INDEX_MODULES_BUILTIN] = { .fn = "modules.builtin", .prefix = ""},
+	[KMOD_INDEX_MODULES_ALTERNATIVES] = { .fn = "modules.alternatives", .prefix = ""},
 };
 
 static const char *const default_config_paths[] = {
@@ -655,6 +656,105 @@ char *kmod_search_moddep(struct kmod_ctx *ctx, const char *name)
 	return line;
 }
 
+char *kmod_search_modalternatives(struct kmod_ctx *ctx, const char *name)
+{
+	struct index_file *idx;
+	char fn[PATH_MAX];
+	char *line;
+
+	if (ctx->indexes[KMOD_INDEX_MODULES_ALTERNATIVES]) {
+		DBG(ctx, "use mmaped index '%s' mod alternative=%s\n",
+				index_files[KMOD_INDEX_MODULES_ALTERNATIVES].fn, name);
+		return index_mm_search(ctx->indexes[KMOD_INDEX_MODULES_ALTERNATIVES],
+									name);
+	}
+
+	snprintf(fn, sizeof(fn), "%s/%s.bin", ctx->dirname,
+					index_files[KMOD_INDEX_MODULES_ALTERNATIVES].fn);
+
+	DBG(ctx, "file=%s mod alternative name=%s\n", fn, name);
+
+	idx = index_file_open(fn);
+	if (idx == NULL) {
+		DBG(ctx, "could not open mod alternatives file '%s'\n", fn);
+		return NULL;
+	}
+
+	line = index_search(idx, name);
+	index_file_close(idx);
+
+	return line;
+}
+
+int kmod_lookup_alternatives_from_modalt_file(struct kmod_ctx *ctx, const char *name,
+						struct kmod_list **list)
+{
+	char *line;
+	int n = 0, err = 0;
+	const char *dirname;
+	size_t dirnamelen;
+	char buf[PATH_MAX];
+	char *p, *saveptr;
+
+	*list = NULL;
+	/*
+	 * Module alternatives names do not contain ':'. Return early if we know it will
+	 * not be found.
+	 */
+	if (strchr(name, ':'))
+		return 0;
+
+	line = kmod_search_modalternatives(ctx, name);
+	if (line == NULL)
+		return 0;
+
+	p = strchr(line, ':');
+	if (p == NULL) {
+		err = -ENOENT;
+		goto fail;
+	}
+	*p = '\0';
+	p++;
+
+	dirname = kmod_get_dirname(ctx);
+	dirnamelen = strlen(dirname);
+	if (dirnamelen + 2 >= PATH_MAX)
+		return 0;
+	memcpy(buf, dirname, dirnamelen);
+	buf[dirnamelen] = '/';
+	dirnamelen++;
+	buf[dirnamelen] = '\0';
+
+	for (p = strtok_r(p, " \t", &saveptr); p != NULL;
+                                p = strtok_r(NULL, " \t", &saveptr)) {
+		struct kmod_module *mod;
+		const char *path;
+		path = path_join(p, dirnamelen, buf);
+		if (path == NULL) {
+			ERR(ctx, "could not join path '%s' and '%s'.\n", dirname, p);
+			err = -ENOENT;
+			goto fail;
+		}
+		err = kmod_module_new_from_path(ctx, path, &mod);
+		if (err < 0) {
+			ERR(ctx, "ctx=%p path=%s error=%s\n", ctx, path, strerror(-err));
+			goto fail;
+		}
+		*list = kmod_list_append(*list, mod);
+		n++;
+	}
+
+	free(line);
+	return n;
+
+fail:
+	kmod_module_unref_list(*list);
+	*list = NULL;
+	free(line);
+	return err;
+}
+
+
 int kmod_lookup_alias_from_moddep_file(struct kmod_ctx *ctx, const char *name,
 						struct kmod_list **list)
 {
@@ -681,6 +781,7 @@ int kmod_lookup_alias_from_moddep_file(struct kmod_ctx *ctx, const char *name,
 
 		*list = kmod_list_append(*list, mod);
 		kmod_module_parse_depline(mod, line);
+		update_mod_deps_correspond_to_alternatives(mod);
 	}
 
 finish:
@@ -916,12 +1017,12 @@ KMOD_EXPORT int kmod_load_resources(struct kmod_ctx *ctx)
 				    &ctx->indexes[i]);
 
 		/*
-		 * modules.builtin.alias are considered optional since it's
+		 * modules.builtin.alias and modules.alternatives are considered optional since it's
 		 * recently added and older installations may not have it;
 		 * we allow failing for any reason
 		 */
 		if (ret) {
-			if (i != KMOD_INDEX_MODULES_BUILTIN_ALIAS)
+			if (i != KMOD_INDEX_MODULES_BUILTIN_ALIAS && i != KMOD_INDEX_MODULES_ALTERNATIVES)
 				break;
 			ret = 0;
 		}
@@ -1022,3 +1123,14 @@ enum kmod_file_compression_type kmod_get_kernel_compression(const struct kmod_ct
 {
 	return ctx->kernel_compression;
 }
+
+bool is_index_available(const struct kmod_ctx *ctx, enum kmod_index index)
+{
+	if (ctx == NULL)
+		return false;
+	if (index >= _KMOD_INDEX_MODULES_SIZE)
+		return false;
+	if (ctx->indexes[index] == NULL)
+		return false;
+	return true;
+}
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index 7251aa7..f3bd3d7 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -25,6 +25,7 @@
 #include <stdarg.h>
 #include <stdbool.h>
 #include <inttypes.h>
+#include <limits.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -72,6 +73,7 @@ enum kmod_index {
 	KMOD_INDEX_MODULES_SYMBOL,
 	KMOD_INDEX_MODULES_BUILTIN_ALIAS,
 	KMOD_INDEX_MODULES_BUILTIN,
+	KMOD_INDEX_MODULES_ALTERNATIVES,
 	/* Padding to make sure enum is not mapped to char */
 	_KMOD_INDEX_PAD = 1U << 31,
 };
@@ -264,6 +266,10 @@ int kmod_module_dependency_symbol_get_bind(const struct kmod_list *entry);
 uint64_t kmod_module_dependency_symbol_get_crc(const struct kmod_list *entry);
 void kmod_module_dependency_symbols_free_list(struct kmod_list *list);
 
+bool is_index_available(const struct kmod_ctx *ctx, enum kmod_index index);
+int update_mod_deps_correspond_to_alternatives(struct kmod_module *mod);
+const char *path_join(const char *path, size_t prefixlen, char buf[PATH_MAX]);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
-- 
2.35.6

