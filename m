Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50817088F
	for <linux-modules@vger.kernel.org>; Fri, 10 May 2024 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340174; cv=none; b=dpcadxoS9Faxk/g6HF2ofKX6ZB8GJEcQY++Fjy5zRZ6SavNMkTvb2GkLVGp/1TfBN/GoEyGGIl56T4n08mZZ0HMtjrVO0OManwOwwbDo3vthDJW8/93dUZA1ibTMlA/4BBLECCZZfN9h6BToaXqZVRxCokgDUOJ9Zsjs9tMHUys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340174; c=relaxed/simple;
	bh=UwoIUQjKJGLVRQ9kJgr8dhwklwHwNBjwEHRpwEj+Y/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mlk+9808Si5RBHy/XlbLEhcKD4egykodZwhOcvEyRDRUxd2mmOe3+s4W5RwTVclwFiVXIEmavKsynoXO4kDQWCZ8wGV2pSOmfwyQBDgGPzvQV4Hbix1zQMusA+l8Wj9dfzB36gJtCuaUzNVBs7juCRK5/7z81Fy05p7IkQWrnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=jedzXyR1; arc=none smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="jedzXyR1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11356; q=dns/txt;
  s=iport; t=1715340160; x=1716549760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FM6IXRcIoLolCf5wF4zHEmnkOQI6vbe0BxNzLrmoQaE=;
  b=jedzXyR17EScKd/Qh32YjxuXI8tBTlbpl4E5FSOboQReljhB0N6d/wlG
   F9escskNWAHBrYbDP9Tpa/XqnuEI8cHm02mXYNq6PJocskQv1TmnWhWlO
   nZVYnoqZnEihrEwEe+Wj8GPbVXffj0oWTAXDS5zA8FH5sXgMVcnvz+NFe
   Q=;
X-CSE-ConnectionGUID: 0yzc3ISMQbamOIayOguemA==
X-CSE-MsgGUID: Eb2k3aayQsC95yoxOVNsYg==
X-IPAS-Result: =?us-ascii?q?A0ANAAAgAj5mmJNdJa1aHAEBAQEBAQcBARIBAQQEAQGBe?=
 =?us-ascii?q?wcBAQsBhBdCSIxyiUyBFopekhmBJQNWDwEBAQ9EBAEBhQaIOgImNAkOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBBgEBBQEBAQIBBwUUAQEBAQEBAQEeGQUOECeGAYZcK?=
 =?us-ascii?q?wsBRi18J4MAgmUCAbE2gXkzgQHeMYFrGIEwAY0GhWQnG4FJRIEVgTuBN3aLB?=
 =?us-ascii?q?wSGNIQ9hFeCaYJwgTmFZ4d9hVRKgSMDWSECEQFVEw0KCz4JFgIWAxsUBDAPC?=
 =?us-ascii?q?QsmAyoGNgISDAYGBlkgFgkEIwMIBANEAyBxEQMEGgQLB3WDMQQTRAOBOIl9g?=
 =?us-ascii?q?z0pgXeBDoMQS4R2gXcOYYkgDwcFSUADCxgNSBEsNRQbBiIfbgelRwcBLE4TA?=
 =?us-ascii?q?RMvCXmBIg8tA5ItHQqDIIw7gh2BMp85hB2hLBozqjSIHJBGpCSEY4FlOoFbT?=
 =?us-ascii?q?SMVO4JnUhkPjiwBDQnQCiM1OwIHCwEBAwmKCGABAQ?=
IronPort-Data: A9a23:Mg3l/qKqAPf54bDsFE+R+ZUlxSXFcZb7ZxGr2PjKsXjdYENS1DEDx
 mBLDzqAaarcNzf0f4xzO4TjoR4Bv5/Uz4BkQQAd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcYZsCCea/0/xWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVvd0
 T/Oi5eHYgP9hmcsajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKmWDNrfnL
 wpr5OjRElLxp3/BOPv8+lrIWhFirorpAOS7oiE+t55OLfR1jndaPq4TbJLwYKrM4tmDt4gZJ
 N5l7fRcReq1V0HBsLx1bvVWL81xFfVX6rScAEOaiMaaymrnemrLzOhjCWhjaOX0+s4vaY1P3
 eYTJDZIZReZiqfvmfSwS/JngYIoK8yD0IE34y47i2qGS6d9B8mfHM0m5vcAtNs0rt5FHfvEY
 c0EQTFudx/HJRZIPz/7Dbpkxb3w2SmuK2MwRFS9iKBt4DPaxR1Iy5O8bcvSavu0Y95kkRPNz
 o7B1z+kWk5BboP3JSC+2naxjebU2y/2HocbDra499ZlhVSSwioYDxh+fV39uvK5i0Okc9tBL
 goY90IGqak06VzuS97xQhm1u1aasRMGHdldCes37EeK0KW83uqCLnIPQjgEY9s8uYpvHHoh1
 0SCmJXiAjkHXKCppWy1rqaGpmiTAg0sJ2YHQg4NXCwK/tTmidRm5v7QdepLHKmwh9zzPDj/x
 TGWsSQz74n/a+ZVjc1XGniZ2lqRSoj1c+Ij2unAsouYAu5RfoWpYcmj7kLWqK8Zao2YVVKG+
 nMDnqByDdzi77nTykRho81UQNlFAspp1hWH3zaD+LF6q1yQF4aLJ9w43d2HDB4B3jw4UTHoe
 lTPngha+YVeOnCnBYcuPNvsUZt7kfa/SYy5PhwxUjaoSsUgHONg1Hw+DXN8I0iy+KTRufhmZ
 sfFK5rE4YgyUPk6lFJauNvxIZdwm3hhnjmMLXwK5x+myrGZLGWEUqsINUDGb+Yyqsu5TPb9r
 b5i2z+x40wHCoXWO3CPmaZKdAxiBSZgX/je9ZcIHtNv1yI7QgnN/deLn+N4E2Gk9owI/tr1E
 oaVBhAClgCg2yKWQehIA1g6AI7SsV9EhSpTFUQR0ZyAghDPva7HAH8jSqYK
IronPort-HdrOrdr: A9a23:2yamT6nWoaCZC9+Qfi066LTD5yzpDfIj3DAbv31ZSRFFG/FwWf
 rDoB19726XtN9/Yh8dcLy7UpVoIkmslqKdn7NxAV7KZmCP01dAR7sM0WKN+VDd8gTFh4tgPN
 9bE5SXzLbLfD9HZQGQ2njdL+od
X-Talos-CUID: =?us-ascii?q?9a23=3AUogDe2lWdSpHJI5NvTr5wOGVY0bXOSXM3nyLAnS?=
 =?us-ascii?q?dMGxgTZq0QE63975pluM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AmipAVw9gXLRcy99+QzrgNqOQf+piuaf1AUkcqI4?=
 =?us-ascii?q?t6pSVMjxXBRGGvTviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,150,1712620800"; 
   d="scan'208";a="212078906"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 11:21:29 +0000
Received: from sjc-ads-1541.cisco.com (sjc-ads-1541.cisco.com [171.70.59.233])
	by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id 44ABLTuA031338;
	Fri, 10 May 2024 11:21:29 GMT
From: Valerii Chernous <vchernou@cisco.com>
To: linux-modules@vger.kernel.org
Cc: xe-linux-external@cisco.com, Nicolas Schier <n.schier@avm.de>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [MODALTS v0.1 1/4] tools/depmod.c: use symbol alternatives for modules.dep
Date: Fri, 10 May 2024 04:21:25 -0700
Message-Id: <20240510112128.2417494-1-vchernou@cisco.com>
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

Add depmod cmd line switch -D to extend symbol search dependencies algorithm
Currently, depmod use only one symbol provider into symbols hash table
So if some symbol exported by different modules only one symbol provider
will be presented into symbols hash table(the latest found during modules parsing)
All other alternatives will be deleted from hash table
As result depmod can point dependency to module different correspond to build time dependencies
and create invalid dependency
To avoid this issue "-D" flag extend items of symbols hash table to symbol list,
check build time depencies and choissing proper symbol alternative if found
corresponding module name into available modules list
In case if no corresponding found it use latest found symbol alternative as previous alorithm

Cc: xe-linux-external@cisco.com
Cc: Valerii Chernous <vchernou@cisco.com>
Signed-off-by: Valerii Chernous <vchernou@cisco.com>
---
 libkmod/libkmod-internal.h |   5 ++
 libkmod/libkmod-module.c   |   5 --
 shared/util.c              |  20 ++++++
 shared/util.h              |   1 +
 tools/depmod.c             | 144 +++++++++++++++++++++++++++++++++----
 5 files changed, 155 insertions(+), 20 deletions(-)

diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 3bc6e11..0a274e7 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -68,6 +68,11 @@ enum kmod_file_compression_type {
 	KMOD_FILE_COMPRESSION_ZLIB,
 };
 
+struct kmod_module_info {
+        char *key;
+        char value[];
+};
+
 struct kmod_list *kmod_list_append(struct kmod_list *list, const void *data) _must_check_ __attribute__((nonnull(2)));
 struct kmod_list *kmod_list_prepend(struct kmod_list *list, const void *data) _must_check_ __attribute__((nonnull(2)));
 struct kmod_list *kmod_list_remove(struct kmod_list *list) _must_check_;
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index d309948..2cdec34 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2261,11 +2261,6 @@ static struct kmod_elf *kmod_module_get_elf(const struct kmod_module *mod)
 	return kmod_file_get_elf(mod->file);
 }
 
-struct kmod_module_info {
-	char *key;
-	char value[];
-};
-
 static struct kmod_module_info *kmod_module_info_new(const char *key, size_t keylen, const char *value, size_t valuelen)
 {
 	struct kmod_module_info *info;
diff --git a/shared/util.c b/shared/util.c
index e2bab83..ea4b9c0 100644
--- a/shared/util.c
+++ b/shared/util.c
@@ -546,3 +546,23 @@ unsigned long long stat_mstamp(const struct stat *st)
 	return (unsigned long long) st->st_mtime;
 #endif
 }
+
+int str_in_coma_separated_str_list(const char *where, const char *what)
+{
+	char *p = strstr(where, what);
+	if (p) {
+		int is_head_ok, is_tail_ok;
+		size_t l = strlen(what);
+		if (p == where || (p > where && *(p-1) == ','))
+			is_head_ok = 1;
+		else
+			is_head_ok = 0;
+		if (*(p+l) == 0 || *(p+l) == ',')
+			is_tail_ok = 1;
+		else
+			is_tail_ok = 0;
+		if (is_head_ok == 1 && is_tail_ok == 1)
+			return p - where;
+	}
+	return -1;
+}
diff --git a/shared/util.h b/shared/util.h
index c4a3916..4337bd6 100644
--- a/shared/util.h
+++ b/shared/util.h
@@ -17,6 +17,7 @@
 #define strstartswith(a, b) (strncmp(a, b, strlen(b)) == 0)
 char *strchr_replace(char *s, char c, char r);
 void *memdup(const void *p, size_t n) __attribute__((nonnull(1)));
+int str_in_coma_separated_str_list(const char *where, const char *what);
 
 /* module-related functions                                                 */
 /* ************************************************************************ */
diff --git a/tools/depmod.c b/tools/depmod.c
index 43fc354..24f79c4 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -59,7 +59,7 @@ static const char *const default_cfg_paths[] = {
 	NULL
 };
 
-static const char cmdopts_s[] = "aAb:o:C:E:F:euqrvnP:wmVh";
+static const char cmdopts_s[] = "aAb:o:C:E:F:DeuqrvnP:wmVh";
 static const struct option cmdopts[] = {
 	{ "all", no_argument, 0, 'a' },
 	{ "quick", no_argument, 0, 'A' },
@@ -68,6 +68,7 @@ static const struct option cmdopts[] = {
 	{ "config", required_argument, 0, 'C' },
 	{ "symvers", required_argument, 0, 'E' },
 	{ "filesyms", required_argument, 0, 'F' },
+	{ "deps-alternatives", no_argument, 0, 'D' },
 	{ "errsyms", no_argument, 0, 'e' },
 	{ "unresolved-error", no_argument, 0, 'u' }, /* deprecated */
 	{ "quiet", no_argument, 0, 'q' }, /* deprecated */
@@ -95,6 +96,7 @@ static void help(void)
 		"Options:\n"
 		"\t-a, --all            Probe all modules\n"
 		"\t-A, --quick          Only does the work if there's a new module\n"
+		"\t-D, --deps-alternatives	using symbols alternatives for generating modules deps\n"
 		"\t-e, --errsyms        Report not supplied symbols\n"
 		"\t-n, --show           Write the dependency file on stdout only\n"
 		"\t-P, --symbol-prefix  Architecture symbol prefix\n"
@@ -476,6 +478,7 @@ struct cfg {
 	uint8_t check_symvers;
 	uint8_t print_unknown;
 	uint8_t warn_dups;
+	uint8_t use_deps_alternatives;
 	struct cfg_override *overrides;
 	struct cfg_search *searches;
 	struct cfg_external *externals;
@@ -924,10 +927,12 @@ struct mod {
 	uint16_t users; /* how many modules depend on this one */
 	bool visited; /* helper field to report cycles */
 	struct vertex *vertex; /* helper field to report cycles */
+	struct kmod_module_info *deps_from_mod_info;
 	char modname[];
 };
 
 struct symbol {
+	struct symbol *next;
 	struct mod *owner;
 	uint64_t crc;
 	char name[];
@@ -975,13 +980,40 @@ static int mod_add_dependency(struct mod *mod, struct symbol *sym)
 	return 0;
 }
 
-static void symbol_free(struct symbol *sym)
+static void symbol_free_sub(struct symbol *sym)
 {
 	DBG("free %p sym=%s, owner=%p %s\n", sym, sym->name, sym->owner,
 	    sym->owner != NULL ? sym->owner->path : "");
 	free(sym);
 }
 
+static void symbol_free(struct symbol *sym)
+{
+	struct symbol *sym_i, *sym_i_tmp;
+	sym_i = sym;
+	while (sym_i != NULL) {
+		sym_i_tmp = sym_i;
+		sym_i = sym_i->next;
+		symbol_free_sub(sym_i_tmp);
+	}
+}
+
+static struct kmod_module_info *depmod_get_mod_info(struct mod *mod, const char *key)
+{
+	struct kmod_list *l;
+	struct kmod_module_info *rval = NULL;
+
+	kmod_list_foreach(l, mod->info_list) {
+		struct kmod_module_info *info;
+		info = (struct kmod_module_info *)l->data;
+		if (strcmp(info->key, key) == 0 ) {
+			rval = info;
+			break;
+		}
+	}
+	return rval;
+}
+
 static int depmod_init(struct depmod *depmod, struct cfg *cfg,
 							struct kmod_ctx *ctx)
 {
@@ -1537,8 +1569,9 @@ static int depmod_symbol_add(struct depmod *depmod, const char *name,
 					const struct mod *owner)
 {
 	size_t namelen;
-	int err;
 	struct symbol *sym;
+	int err = 0;
+	struct symbol *sym_l = NULL, *sym_li = NULL;
 
 	if (!prefix_skipped && (name[0] == depmod->cfg->sym_prefix))
 		name++;
@@ -1548,20 +1581,49 @@ static int depmod_symbol_add(struct depmod *depmod, const char *name,
 	if (sym == NULL)
 		return -ENOMEM;
 
+	sym->next = NULL;
 	sym->owner = (struct mod *)owner;
 	sym->crc = crc;
 	memcpy(sym->name, name, namelen);
 
-	err = hash_add(depmod->symbols, sym->name, sym);
-	if (err < 0) {
-		free(sym);
-		return err;
+	if (depmod->cfg->use_deps_alternatives == 0) {
+	    err = hash_add(depmod->symbols, sym->name, sym);
+	    if (err < 0)
+		goto err_ext;
+	} else {
+	    sym_l = hash_find(depmod->symbols, sym->name);
+	    for (sym_li = sym_l; sym_li != NULL; sym_li = sym_li->next)
+		if (sym_li->crc == sym->crc && sym_li->owner == sym->owner)
+		    break;
+	    if (sym_li != NULL)
+		// symbol already in the list
+		goto clr_ext;
+	    else {
+		if (sym_l != NULL) {
+		    // insert new sym at second pos to left start list pointer from
+		    // hash without changes
+		    sym->next = sym_l->next;
+		    sym_l->next = sym;
+		} else {
+		    // new symbol
+		    err = hash_add(depmod->symbols, sym->name, sym);
+		    if (err < 0)
+			goto err_ext;
+		}
+	    }
 	}
 
-	DBG("add %p sym=%s, owner=%p %s\n", sym, sym->name, owner,
+	DBG("add %p sym=%s,crc(%#"PRIx64"), owner=%p %s\n", sym, name, crc, owner,
 	    owner != NULL ? owner->path : "");
 
 	return 0;
+
+err_ext:
+	ERR("Failed to add %p sym=%s,crc(%#"PRIx64"), owner=%p %s\n", sym, name, crc, owner,
+	        owner != NULL ? owner->path : "");
+clr_ext:
+	symbol_free(sym);
+	return err;
 }
 
 static struct symbol *depmod_symbol_find(const struct depmod *depmod,
@@ -1571,7 +1633,7 @@ static struct symbol *depmod_symbol_find(const struct depmod *depmod,
 		name++;
 	if (name[0] == depmod->cfg->sym_prefix)
 		name++;
-	return hash_find(depmod->symbols, name);
+	return (struct symbol *)hash_find(depmod->symbols, name);
 }
 
 static int depmod_load_modules(struct depmod *depmod)
@@ -1615,6 +1677,40 @@ load_info:
 	return 0;
 }
 
+static struct symbol *depmod_symbol_get_primary(const struct depmod *depmod,
+							const char *name,
+							struct mod *mod)
+{
+	struct symbol *sym, *sym_l;
+	sym_l = depmod_symbol_find(depmod, name);
+	if (sym_l == NULL)
+		sym = NULL;
+	else if (sym_l->next == NULL)
+		sym = sym_l;
+	else {
+		struct symbol *sym_li;
+		if (mod->deps_from_mod_info == NULL && mod->info_list != NULL)
+			mod->deps_from_mod_info = depmod_get_mod_info(mod, "depends");
+		if (mod->deps_from_mod_info == NULL)
+			sym = sym_l;
+		else {
+			sym = NULL;
+			for (sym_li = sym_l; sym_li != NULL; sym_li = sym_li->next) {
+				if (sym_li->owner->modname != NULL &&
+				    str_in_coma_separated_str_list(mod->deps_from_mod_info->value, sym_li->owner->modname) >= 0) {
+					sym = sym_li;
+					break;
+				}
+			}
+			if (sym == NULL) {
+				DBG("Can't find proper owner for symbol: %s use first from list\n", name);
+				sym = sym_l;
+			}
+		}
+	}
+	return sym;
+}
+
 static int depmod_load_module_dependencies(struct depmod *depmod, struct mod *mod)
 {
 	const struct cfg *cfg = depmod->cfg;
@@ -1625,7 +1721,7 @@ static int depmod_load_module_dependencies(struct depmod *depmod, struct mod *mo
 		const char *name = kmod_module_dependency_symbol_get_symbol(l);
 		uint64_t crc = kmod_module_dependency_symbol_get_crc(l);
 		int bindtype = kmod_module_dependency_symbol_get_bind(l);
-		struct symbol *sym = depmod_symbol_find(depmod, name);
+		struct symbol *sym = depmod_symbol_get_primary(depmod, name, mod);
 		uint8_t is_weak = bindtype == KMOD_SYMBOL_WEAK;
 
 		if (sym == NULL) {
@@ -2306,12 +2402,27 @@ static int output_symbols(struct depmod *depmod, FILE *out)
 	hash_iter_init(depmod->symbols, &iter);
 
 	while (hash_iter_next(&iter, NULL, &v)) {
-		const struct symbol *sym = v;
-		if (sym->owner == NULL)
-			continue;
-
-		fprintf(out, "alias symbol:%s %s\n",
+		if (depmod->cfg->use_deps_alternatives == 0) {
+			const struct symbol *sym = v;
+			if (sym->owner == NULL)
+				continue;
+			fprintf(out, "alias symbol:%s %s\n",
 					sym->name, sym->owner->modname);
+		} else {
+			struct symbol *sym_li;
+			int is_printed = 0;
+			for ( sym_li = (struct symbol*)v; sym_li != NULL; sym_li = sym_li->next) {
+				if (sym_li->owner == NULL)
+					continue;
+				if ( is_printed == 0 ) {
+					fprintf(out, "alias symbol:%s", sym_li->name);
+					is_printed = 1;
+				}
+				fprintf(out, " %s", sym_li->owner->modname);
+			}
+			if ( is_printed == 1 )
+				fprintf(out,"\n");
+		}
 	}
 
 	return 0;
@@ -2956,6 +3067,9 @@ static int do_depmod(int argc, char *argv[])
 			config_paths[n_config_paths] = NULL;
 			break;
 		}
+		case 'D':
+			cfg.use_deps_alternatives = 1;
+			break;
 		case 'E':
 			module_symvers = optarg;
 			cfg.check_symvers = 1;
-- 
2.35.6

