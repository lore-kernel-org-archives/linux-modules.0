Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA13BED61
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477148; cv=none; b=Da7HMa6biJebCodzBdsZK3yaKPJnbWceKt1teYPvKNoQQdXGY6uqDnLVCC01v7acYUDl0HcJxrqlHH/PtUkcjMOWFSmZLprU+hjeEbbVabUROzWk/813lK4Os7u5cftnO48PsnaBygTyt3MrAtAO1nwdpDLqzXXmvLH8gbYj8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477148; c=relaxed/simple;
	bh=VmJymj+0Q4j0I1EUqeIf+e6mGGIOu0+7A0bFbmKKNM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/WdiLp0hwQ4tx4e4vRw/07DT8JTIW/ebBwGQvK2gDNmQtFEevPoVfz5sc3sXCjUjlvG4eZtJ3xb2/qiY9yhgpoQjvxyUw3kuQrQ14c/CZ/6qOmNrCGomWjaELEHxjkTW8JrCXLSpzAlhFfV4lYG7AIaqao45a1FHAKJkjeiN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czaKf0OB; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czaKf0OB"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-495c49f8eccso154773b6e.3
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 19:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477145; x=1784081945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EN4UcL3zm6fGsCZOvS0KoGzU55UOa/Q5NkzEE56WU1k=;
        b=czaKf0OBFiqeUVkSqhqI6NKCWjj+Jo336x7/BgYpwdaxJJ7WMVsfHegLu6PIf1CHRY
         c819kZ+72SojaDmh4aW0Fq3jbALih/OT0tpA6qEfM7p+pSxPA3RVhkFO54xNG22KPTpc
         tiPQpq6Txs8n0LZh6sKSdyKAzf6jcpI1tU6qrGd3/4kjc2a54JDgcUsYMhmQzINcNAKn
         L8UWtVdmihjTPkxNizFv+DbYuwpi1eULCoyzMbl7AhqS9CnLGPk0lXmd7+LYbc0chKrV
         kOodagSphPPyASz2Avqg25Bf8hDBFeRzGk2j589lHRXMIaoP4LARXZE4CUvelT1V6Bqg
         tTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477145; x=1784081945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EN4UcL3zm6fGsCZOvS0KoGzU55UOa/Q5NkzEE56WU1k=;
        b=Hoj+hYoFHTgDtHZOCrsxNrlh2c65TJDMGPIaPGaortRh/Us9YqUkm8SDmq290nGNjy
         08seSsTx4Ou4TYuzQJBEPraZzVYQYMLHDYi/gMT8qAyy0oj04mw6YTKQd1JME+Z00Jcc
         7qRauKvoocwpOLdegOQGDnwinK7uszhTMednzruSdvMtQlPdyNZZCaolrG1simMQZ+NR
         TfYekJGZ1OMEj7WrqzlLAFNYFgMZ4B+Pu9E+Mudyng2g9T+Dynaw3N18R6xeQ/qe5mjb
         Lf2ov41D7wspnt/8vDaDCa5TlfFpbRG8AKD5FTlKwMeUjLT/sTnSCOMbiaO/P9foa2r+
         HIRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Ecv4mEltkBD1DfjlywNwMPCeYiycGXZYF7tKMdlkgv3UvLzdrRmVwLGQNfdCH9NfaC1yRStd6AorsGChw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9objKAJuDiqzxcqH42CFX4/hboU8KRHkhK/hZZY8IFuCt2GOT
	nhGxGemHMmfcbvui2ZG6N704ucViJIK6ky7LMkGa9oE/utxVHfV82KWT
X-Gm-Gg: AfdE7ck3QfV0xM5MWV/OHQv1NCB0QC+aRJE/pC4oSOb9tob8RNJjtn9y2xhqQavJGV+
	Byi2MQVH7ZyKUxeF2kog5jYvvKJgFoJ0ME9Txjl9m6bld7MbPwaQaJ7lO0oFeIF42F5nBZuMLIw
	K+2s4jL6a4IOa2LvrARR+6QysH/zBEjeKJ3CHNhkzZQPJpPeYCrsQHBmqkBI4J0fXLPbSKZXvMW
	OLWWY7r9jnmVJzz+hVht4lT0ICIcapo6EwIhwsGoWGffdTZc0YBb2qaFtWcTTQCQKDcfLLmUW3+
	C+fpzJzDuEH9PsTZzLwLcOfDbyr/ADEDCXeS7E/9vPSRxajxRIfKv5wcTRVBlBmuw6OD+eVPkhJ
	gYRkI3uwiQEiK4momDMLdWiJ/k3hJE55xRTW9Mv1tOnAt/QmaTkm3LkRDe1GCsCeCibolK59duc
	zhzLLuF8KPV8XkGWC24ShIsjRgI0Cle91hueIfOjojqotFr358AtA=
X-Received: by 2002:a05:6808:1246:b0:48b:1e49:24a8 with SMTP id 5614622812f47-4a20297844dmr337734b6e.11.1783477145037;
        Tue, 07 Jul 2026 19:19:05 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:19:04 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:21 -0600
Subject: [PATCH v6 21/24] dyndbg: move mod_name down from struct
 ddebug_table to _ddebug_info
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-21-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=7925;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=VmJymj+0Q4j0I1EUqeIf+e6mGGIOu0+7A0bFbmKKNM4=;
 b=u7+JnKK+nZcJfYq78mfTf6102Kub+Si+g2yZV+HEA8aAAMpkLahrZG23vfpUaYkh/uwMC1AW8
 l6AHq3C2EWzDbj8DQdS9CwODuBBtn3J5oaUO5U55HV/Uhc2T/wulU21
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

struct _ddebug_info already has most of dyndbg's info for a module;
push debug_table.mod_name down into it, finishing the encapsulation.

This allows refactoring several callchains, passing &_ddebug_info
instead of &ddebug_table, and hoisting the "&dt->info" deref up
instead of repeating it thru the callchans

ddebug_table contains a _ddebug_info member, so code with a ptr to a
ddebug_table still have access to mod_name, just now with "->info."
added in.

In static ddebug_add_module(&di), reinforce the cursor-model by
dropping the modname arg, and setting di->mod_name at each caller.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB

old-v12
. moved up 1 position in series, ahead of hoist...
---
 include/linux/dynamic_debug.h |  1 +
 lib/dynamic_debug.c           | 52 ++++++++++++++++++++++---------------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index ca27bdd92693..355f2cb11733 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -111,6 +111,7 @@ struct _ddebug_class_maps {
 };
 
 struct _ddebug_info {
+	const char *mod_name;
 	struct _ddebug_descs descs;
 	struct _ddebug_class_maps maps;
 };
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5a884cbd6294..a9965ec1807a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -46,7 +46,6 @@ extern struct ddebug_class_map __stop___dyndbg_class_maps[];
 
 struct ddebug_table {
 	struct list_head link;
-	const char *mod_name;
 	struct _ddebug_info info;
 };
 
@@ -249,11 +248,12 @@ static int ddebug_change(const struct ddebug_query *query,
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry(dt, &ddebug_tables, link) {
+		struct _ddebug_info *di = &dt->info;
 
 		/* match against the module name */
 		if (query->module &&
-		    !match_wildcard_hyphen(query->module, dt->mod_name) &&
-		    !match_wildcard_hyphen(query->module, kbasename(dt->mod_name)))
+		    !match_wildcard_hyphen(query->module, di->mod_name) &&
+		    !match_wildcard_hyphen(query->module, kbasename(di->mod_name)))
 			continue;
 
 		if (query->class_string) {
@@ -265,8 +265,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			valid_class = _DPRINTK_CLASS_DFLT;
 		}
 
-		for (i = 0; i < dt->info.descs.len; i++) {
-			struct _ddebug *dp = &dt->info.descs.start[i];
+		for (i = 0; i < di->descs.len; i++) {
+			struct _ddebug *dp = &di->descs.start[i];
 
 			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
@@ -286,7 +286,7 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
-				  dt->mod_name, dp->function,
+				  di->mod_name, dp->function,
 				  ddebug_describe_flags(dp->flags, &fbuf),
 				  ddebug_describe_flags(newflags, &nbuf));
 			dp->flags = newflags;
@@ -1086,12 +1086,12 @@ static bool ddebug_class_in_range(const int class_id, const struct ddebug_class_
 		class_id < map->base + map->length);
 }
 
-static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
+static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp)
 {
 	struct ddebug_class_map *map;
 	int i;
 
-	for_subvec(i, map, &dt->info, maps)
+	for_subvec(i, map, di, maps)
 		if (ddebug_class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1119,13 +1119,13 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
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
@@ -1186,7 +1186,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * and length of the subrange at its edges.
 	 */
 	for_subvec(i, cm, di, maps) {
-		if (!strcmp(cm->mod_name, dt->mod_name)) {
+		if (!strcmp(cm->mod_name, dt->info.mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
 					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
@@ -1200,7 +1200,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	}
 	if (nc) {
 		dt->info.maps.len = nc;
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
+		vpr_info("module:%s attached %d classes\n", dt->info.mod_name, nc);
 	}
 }
 
@@ -1208,27 +1208,26 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
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
@@ -1240,7 +1239,7 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	vpr_info("%3u debug prints in module %s\n", di->descs.len, modname);
+	vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mod_name);
 	return 0;
 }
 
@@ -1303,7 +1302,7 @@ static int ddebug_remove_module(const char *mod_name)
 
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
-		if (dt->mod_name == mod_name) {
+		if (dt->info.mod_name == mod_name) {
 			ddebug_table_free(dt);
 			ret = 0;
 			break;
@@ -1323,7 +1322,8 @@ static int ddebug_module_notify(struct notifier_block *self, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_COMING:
-		ret = ddebug_add_module(&mod->dyndbg_info, mod->name);
+		mod->dyndbg_info.mod_name = mod->name;
+		ret = ddebug_add_module(&mod->dyndbg_info);
 		if (ret)
 			WARN(1, "Failed to allocate memory: dyndbg may not work properly.\n");
 		break;
@@ -1421,7 +1421,8 @@ static int __init dynamic_debug_init(void)
 			mod_ct++;
 			di.descs.len = mod_sites;
 			di.descs.start = iter_mod_start;
-			ret = ddebug_add_module(&di, modname);
+			di.mod_name = modname;
+			ret = ddebug_add_module(&di);
 			if (ret)
 				goto out_err;
 
@@ -1432,7 +1433,8 @@ static int __init dynamic_debug_init(void)
 	}
 	di.descs.len = mod_sites;
 	di.descs.start = iter_mod_start;
-	ret = ddebug_add_module(&di, modname);
+	di.mod_name = modname;
+	ret = ddebug_add_module(&di);
 	if (ret)
 		goto out_err;
 

-- 
2.55.0

