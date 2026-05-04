Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD39D322B8F
	for <linux-modules@vger.kernel.org>; Mon,  4 May 2026 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927539; cv=none; b=rYqL+JHTDkZh6aVrj9mo/TK/sPU1mVkTyce5Fd/zSfba8oBJJlY5Squ/fOWWKgQwKNzbu0rnrCM3YtR9Ol9sXmj/F17VI1lGP16yVcGVzDsOtn6jP/Hoz1f1S+FaMdZ9S3PbpYSkKlNpt+wQ4pp8P8OoJab+/hvgTofWsQ2w6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927539; c=relaxed/simple;
	bh=cvpyPjgBUZvJMXWxvbAPJHHdCeJYjPF8j74Dxznr/8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovfwxPEZLewKV3SbndjaDVrvjlIlW0NnvL9+UGVP3jfhXKROjGeTb8SGxdF87yuYKiC6EYrfxJUK+f79owuLxqIBJ2qHuBwC07QE5SKOJVAt5zRlio5USYk6jpbU5xrx27rLGG9dVAOPE4+x+bl+APOInMyAM7T0cVEOwtQ5J24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASaDpn5w; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASaDpn5w"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6966d16b978so1642638eaf.3
        for <linux-modules@vger.kernel.org>; Mon, 04 May 2026 13:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777927533; x=1778532333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iZawPPQ+X0bNikqrWnKmDXKxMGCDUmFmcpPVDJmjyY=;
        b=ASaDpn5wA4gWGDrf0Kl8uWNHLeXv+bTtBCKiBOBe3Iwc/7PkYl850tuQo2qe+/meA0
         z92SqfFhWlYaW6WE1vZ+CcAc4zUh0x6D9jVf8cd+0tVdBHjwPukCJueYODe8WLxIDC0T
         e7AVEpG7eHMxc9N3il/MU+VsSH/zB8R2V0uVspLiPJABlQa1e/Nz4nHmATTidqaa7Rfp
         dsEAmY+NaKW9Wa0oOJgC7wufudAxP4itvtFppUgiFOR28G1GbAr6zjRoxG7JcAYyPSSj
         g03qRQyYcOvJwEZx7pyFyq7J8nPB16k21Dg/uq9KGiiHT9m8TpH7Altg6dN4o8wm8fbW
         7+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927533; x=1778532333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+iZawPPQ+X0bNikqrWnKmDXKxMGCDUmFmcpPVDJmjyY=;
        b=Cfnrawxu3AnBCnDFNGaJp7qceyo7jdd191eSFGhX01soenwkrCC34jygGxdL7hFYxa
         4c7UwcXJGNuTf0fs1A7jnxkj7z/1ka02TQaUHLEhflAliQ8X5OqYhSPhKdhmiSVqtR9A
         o4o/FaxcUAdYRvKplU2D3+3H6/Bwy+bkWTD162bYQlp0Bx6q5ymVCz4LDbTh3p1GnEPL
         vGCWIPPqWw+aTEPIu3Y7ByPEgcbaVdMWc7yu4uXeLnUEpik5vl0Epl/OicPCnLemA8GI
         yLAyTa0SQDomicsCI/DghmNceSWslhkYFb+PfpS3SXePTxJsABJUVAqVxr5tEQcLzo5L
         AWMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3/YkMJGG2riHsDinbI7uZA5qjaHMdGsUWrQ0NOW48OpA2nnfFQd3WWRYw5WgSdre2F5jlTgJtFCNTBKU+@vger.kernel.org
X-Gm-Message-State: AOJu0YyhM52DwEGH5BsiZgQnQxB7Fr+GdQ8zFed0xN0vPYRAbL9ba/SA
	J3Qn+rLsZZn2oSJs8c8s2jpv5ZhulNrVbZUoBHi/pbPSUSijslhBu3QF
X-Gm-Gg: AeBDiesDn3ycOKJ3b3fySkKGHQ/QHJ3Ic1DAduQwvVE4CSGhWVfP4Q/XmiclNDBLqmS
	qPQr1VCTGr9LZHdHDsRptlP4UdREtK3FhyEBsS+JM2P/E5rLTBxc1nmau3VnpDqUgKiSMS7rop2
	hw4v9sHCq0EpMq27mFadE0RqgWky3qrgrzj+1fk8OyCF3HGxlciqJf4e1ksXsqfSvg+Bn1CKERz
	GeSiulj5m86juXgPPJiTc5wo0OyxdA3LN4mboeRqpUZvfyrwR9NvmG8f8Klgf0n6REqNT7/PV10
	gVcsOBEF9bJD6tl7mr+oZ1BQB22mUZxADnKU6IRVL0NmQW4ki6Pul4NF6oMulrWDs9uF82BFRo5
	gX5Zt9LtRLtQ9ZX9biY3t4q5ZvJhRkC4WZXAEaEKFeZb78rsrXb6KKoaZHUK6qt1yIu4rVyVmDN
	hIUp9iqW13inH7ukGGzKLTZK7raiTVCorqPJ6V8qyqtn+tu10AUin9lj8jjDTqFUrF79BWVF4z
X-Received: by 2002:a05:6820:2214:b0:696:1450:ff14 with SMTP id 006d021491bc7-69697c64d5fmr5570398eaf.37.1777927533407;
        Mon, 04 May 2026 13:45:33 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69689266bacsm7144713eaf.0.2026.05.04.13.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:45:33 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 04 May 2026 14:45:19 -0600
Subject: [PATCH 13/17] dyndbg: move mod_name down from struct ddebug_table
 to _ddebug_info
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dd-cleanups-2-v1-13-6fdd24040642@gmail.com>
References: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
In-Reply-To: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Shuah Khan <shuah@kernel.org>, Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777927513; l=7701;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=cvpyPjgBUZvJMXWxvbAPJHHdCeJYjPF8j74Dxznr/8s=;
 b=gGm7NM5Z53+s6mQeyZ3eOhd7I+c2zrov3fuZtR3kvuJGMbp1FsRdwJg/yxIU1eSPQ6b+pHLZB
 oDV+KfE3Wx0DS6iG+/RBAYW3DROE5RQXNmD9Hy3uiWqrfGfYPETGaLc
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

struct _ddebug_info already has most of dyndbg's info for a module;
push debug_table.mod_name down into it, finishing the encapsulation.

This allows refactoring several callchains, passing &_ddebug_info
instead of &ddebug_table, and hoisting the "&dt->info" deref up
instead of repeating it thru the callchans

ddebug_table contains a _ddebug_info member, so its users keep access
to mod_name, just now with "->info." added in.

In static ddebug_add_module(&di), reinforce the cursor-model by
dropping the modname arg, and setting di->mod_name at each caller.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v12
. moved up 1 position in series, ahead of hoist...
---
 include/linux/dynamic_debug.h |  1 +
 lib/dynamic_debug.c           | 50 ++++++++++++++++++++++---------------------
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 7a4bf40c1eb8..7d60da0b9506 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -108,6 +108,7 @@ struct _ddebug_class_maps {
 };
 
 struct _ddebug_info {
+	const char *mod_name;
 	struct _ddebug_descs descs;
 	struct _ddebug_class_maps maps;
 };
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 83c5b27314da..4065c57637f2 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -46,7 +46,6 @@ extern struct _ddebug_class_map __stop___dyndbg_classes[];
 
 struct ddebug_table {
 	struct list_head link;
-	const char *mod_name;
 	struct _ddebug_info info;
 };
 
@@ -253,10 +252,11 @@ static int ddebug_change(const struct ddebug_query *query,
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry(dt, &ddebug_tables, link) {
+		struct _ddebug_info *di = &dt->info;
 
 		/* match against the module name */
 		if (query->module &&
-		    !match_wildcard(query->module, dt->mod_name))
+		    !match_wildcard(query->module, di->mod_name))
 			continue;
 
 		if (query->class_string) {
@@ -268,8 +268,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			valid_class = _DPRINTK_CLASS_DFLT;
 		}
 
-		for (i = 0; i < dt->info.descs.len; i++) {
-			struct _ddebug *dp = &dt->info.descs.start[i];
+		for (i = 0; i < di->descs.len; i++) {
+			struct _ddebug *dp = &di->descs.start[i];
 
 			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
@@ -289,7 +289,7 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
-				  dt->mod_name, dp->function,
+				  di->mod_name, dp->function,
 				  ddebug_describe_flags(dp->flags, &fbuf),
 				  ddebug_describe_flags(newflags, &nbuf));
 			dp->flags = newflags;
@@ -1156,12 +1156,12 @@ static bool ddebug_class_in_range(const int class_id, const struct _ddebug_class
 		class_id < map->base + map->length);
 }
 
-static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
+static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp)
 {
 	struct _ddebug_class_map *map;
 	int i;
 
-	for_subvec(i, map, &dt->info, maps)
+	for_subvec(i, map, di, maps)
 		if (ddebug_class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1189,13 +1189,13 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
-		   iter->table->mod_name, dp->function,
+		   iter->table->info.mod_name, dp->function,
 		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_putc(m, '"');
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter->table, dp);
+		class = ddebug_class_name(&iter->table->info, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
@@ -1256,7 +1256,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * and length of the subrange at its edges.
 	 */
 	for_subvec(i, cm, di, maps) {
-		if (!strcmp(cm->mod_name, dt->mod_name)) {
+		if (!strcmp(cm->mod_name, dt->info.mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
 					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
@@ -1267,7 +1267,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	}
 	if (nc) {
 		dt->info.maps.len = nc;
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
+		vpr_info("module:%s attached %d classes\n", dt->info.mod_name, nc);
 	}
 }
 
@@ -1275,27 +1275,26 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
+static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
 
 	if (!di->descs.len)
 		return 0;
 
-	v3pr_info("add-module: %s %d sites\n", modname, di->descs.len);
+	v3pr_info("add-module: %s %d sites\n", di->mod_name, di->descs.len);
 
 	dt = kzalloc_obj(*dt);
 	if (dt == NULL) {
-		pr_err("error adding module: %s\n", modname);
+		pr_err("error adding module: %s\n", di->mod_name);
 		return -ENOMEM;
 	}
 	/*
-	 * For built-in modules, name lives in .rodata and is
-	 * immortal. For loaded modules, name points at the name[]
-	 * member of struct module, which lives at least as long as
-	 * this struct ddebug_table.
+	 * For built-in modules, name (as supplied in di by its
+	 * callers) lives in .rodata and is immortal. For loaded
+	 * modules, name points at the name[] member of struct module,
+	 * which lives at least as long as this struct ddebug_table.
 	 */
-	dt->mod_name = modname;
 	dt->info = *di;
 
 	INIT_LIST_HEAD(&dt->link);
@@ -1307,7 +1306,7 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	vpr_info("%3u debug prints in module %s\n", di->descs.len, modname);
+	vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mod_name);
 	return 0;
 }
 
@@ -1370,7 +1369,7 @@ static int ddebug_remove_module(const char *mod_name)
 
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
-		if (dt->mod_name == mod_name) {
+		if (dt->info.mod_name == mod_name) {
 			ddebug_table_free(dt);
 			ret = 0;
 			break;
@@ -1390,7 +1389,8 @@ static int ddebug_module_notify(struct notifier_block *self, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_COMING:
-		ret = ddebug_add_module(&mod->dyndbg_info, mod->name);
+		mod->dyndbg_info.mod_name = mod->name;
+		ret = ddebug_add_module(&mod->dyndbg_info);
 		if (ret)
 			WARN(1, "Failed to allocate memory: dyndbg may not work properly.\n");
 		break;
@@ -1488,7 +1488,8 @@ static int __init dynamic_debug_init(void)
 			mod_ct++;
 			di.descs.len = mod_sites;
 			di.descs.start = iter_mod_start;
-			ret = ddebug_add_module(&di, modname);
+			di.mod_name = modname;
+			ret = ddebug_add_module(&di);
 			if (ret)
 				goto out_err;
 
@@ -1499,7 +1500,8 @@ static int __init dynamic_debug_init(void)
 	}
 	di.descs.len = mod_sites;
 	di.descs.start = iter_mod_start;
-	ret = ddebug_add_module(&di, modname);
+	di.mod_name = modname;
+	ret = ddebug_add_module(&di);
 	if (ret)
 		goto out_err;
 

-- 
2.54.0

