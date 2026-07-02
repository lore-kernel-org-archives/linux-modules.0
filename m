Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9ED3C584F
	for <linux-modules@vger.kernel.org>; Thu,  2 Jul 2026 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010507; cv=none; b=O9tlyLH3eiSceKQL8akjyzkH8PjX1zEP6l2bmmeCbrd0RJJdtNVaiiMjBM6nUnZfyFld6Zhpx0xNkMUYn23IBhZnwo8j7ZTgu3t/bNAPKNP2MBPaFmb2Y5mCaECFv5fRV1SwZFDhWy8/Nik2Frm28mhVx2Jh4JgZmEkfFUfOK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010507; c=relaxed/simple;
	bh=c3BBwhRiGNmC7/aSqCqz+kX8F9c85BuKaXEN1Y8J75o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFaFT1NouA7GMiB+UkDSGdn6XOtkfL6jCyyR8lu9Nvq1Q8X2fYb4Nqpd993ozD51y43WzHTv7jqxpZd1dh3tJyAfA6PqfvMCrgQCLgbl8AjLBF40m3An6tAwJqNzJBjkUiBRP5sWeeFW5Fhr0XBs4AgMQmxL5P4PzLhjqFgqYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xy3XQoBT; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy3XQoBT"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69d7aa0ac14so1490203eaf.3
        for <linux-modules@vger.kernel.org>; Thu, 02 Jul 2026 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010498; x=1783615298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8ui5kiNu8AyePyrViIEmPdvMCPaGrwSHEnfqXhRkN4=;
        b=Xy3XQoBT0MFCOFuE9Xd6x362QxCfVDY9tWecP4rUQVHkCMbSF6DYpp9rmlBSccXz8m
         e2TCyUExZq6UsDFENUe1lpJJw3JF7ie3pCp209P8U/PSRGbNRcePpXtSJHpHa+q9WFUk
         kEmjd3ixvgWbXdGswLod5qZR1DUH16XH4EN2faJTm9uE43JaY7K1uv70bkpHuQB5M3Jc
         IzzipemZQlS563YX4yeeoadopiJtYmS7+9LtePDZxoHPnjahIK4JOW6oWdSx0s8gcIQo
         oRLCKugqSXnLDxbVKPc6GkngCJX2JsjehT9owzRS8yS92KBuiu9SlCnGrRc5UvOg093P
         97OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010498; x=1783615298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D8ui5kiNu8AyePyrViIEmPdvMCPaGrwSHEnfqXhRkN4=;
        b=K0Eh7TwAxmLtIoB3+P5ORKVedu4c+5W/Fqj1pG/irYegGHhlmvO8IeLIGc+FhImWGf
         E3o2PXpFccj6jwr29YLK6dxsxGY1pdidfRbrJ5MWQtuAmAgr/8rtUBxdJxyvA1+5SZdc
         tRfsPrkIpxJI3lWtT+pEN9heg2+a5ffso7WFN+Bbz3UcwoeIAfaxcbExlwRjLDX1grSY
         vDetiRGHvefLx7p6L/hLh9mJzrjnGO/FQTA6FO4VqKsVU27wOKEQmIoKcoM2peI6eN/I
         qTAfbhR6UpbshG8tzjOys8WLLjvbLOT4KEH+W0U9nTCceS0PAtvhvdWUKnQoLzoq2Zh5
         lkRg==
X-Forwarded-Encrypted: i=1; AFNElJ/d7A7INvqTjZ34jolq0cxeS8VQhj3z+ocUs3JpJDAq6RvGlFPMvXokWduCXC3UfzBeBEj/mQysxDG+X3r7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+apWJoKsUslP3S8POjkTbQF+KjiK9i9HbnZn8O/gq1nHi1iza
	F5g4jHeFVXK4bLUo5gL/+XlxjkB2ljJFR2BAgwGMwpMbVUxkhQaXv6xG
X-Gm-Gg: AfdE7clDoi9yC+0CmyZAo4blItVerAcsE9vXYwvINWgIv6JuRwH2cgMNOdajsCe60Y7
	7UA1YnTPw6+hAwYdyqySq6WlTks82XtGDhy7sIiORrtWOUNLgtxIpDkgAmFfxtgqU1O5m7vNDmQ
	4H6K+gI3VN249tHOZc9P/xvHt5eJNOxC+C0N69JHdD8M8n5j6BlfeZRJPult/T58jJF55JrTJvi
	2lxk33nkzRuq56JfNpzvpMxy48dDGoQd17Q2GvqTUXavjvEvMVDjnQHxL4jQJhGmbXhQh0ddWyj
	/kx/IFKkOc+bf1vcbJK0wyukNJov+4WepOWqt3Go+64WXE7OGK4JhZm4cYgA2znIg/GSAZHGvqZ
	GjhFjajfnh8XQI8Xb4XUQvBnF/hdJv2LMSoF0m2DUYFpnLKKxrvdrdKUOQTWJsA9mIl0ICcolDg
	dnLnCqvq6St3jJR0iLaiFAlh+R6t/49RS2wcwUwULTxLBx3zSaEceL+EpqvFL1NQ==
X-Received: by 2002:a05:6820:1806:b0:69e:b7f4:2a14 with SMTP id 006d021491bc7-6a309a13352mr4236028eaf.26.1783010498313;
        Thu, 02 Jul 2026 09:41:38 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:37 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:41:08 -0600
Subject: [PATCH v5 16/18] dyndbg: move mod_name down from struct
 ddebug_table to _ddebug_info
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-16-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=7925;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=c3BBwhRiGNmC7/aSqCqz+kX8F9c85BuKaXEN1Y8J75o=;
 b=p0nWTornlGbFtk9tXAUpmQR28OJfnTMVU4EhaEH5B9VscV5u2xPrUKRh2R0w4p5qnV9atKJye
 FiNMTp8xzrHBvcNzOZk/gut6JVQV540xkYwzndld/KhCBxLpy6B1Acg
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
2.54.0

