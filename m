Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9747735DA7B
	for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520532; cv=none; b=NApnYN+vWF2AVDHpWudGL0B1MzLFsObsQsN2XMPdlcXdGmd8IFZCEwsM2JGpZ+E7ojcoh9a14jJW4wE8NbPSURaM6geJLd/uaxltLN+ralF7JDmcqNz8a6LO6n+TwAOxc2GkmYbjulPOIewf9iPcO42zPqqZ7d7cL7GxWoySzp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520532; c=relaxed/simple;
	bh=acmpE5f+cy4H0euAd/sWLVbXBhuyRVdVfvkTY1QfTl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y5e0cVVCiklvbX4qY+wWc1Mh3o0iYoG9KtQToxtLEJ6HFcnRUROwzw/t999tdNjfQONmunoslL+U5QMCttnBJ/j71DJuzOXoXzXMGhhzTkAjI+s4MOiMohz7Vod+3iZcystXb+NuDXg063JzgOEdIcH0KbnQMFS8ZrddwAiwUvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxxfzpKF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxxfzpKF"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44b330c5cc6so6126540f8f.1
        for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 00:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520529; x=1780125329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Inkv515K3CDOqGmxKUbJA66Ndin1wkzy98GUXdhIoyc=;
        b=mxxfzpKFQLv/7ag+vvXGxDsuILctm7/pEpYZRMdTe5mKxLbRf0qYZ/gSm6r+PxjJy5
         a+z2C0MXJcysZu3SMpV8t4X7A3zhccRscwiVXl4Fih2A7VuqVw5lFSmpJOMHxqhpLgPe
         PV9G4lECnPeeUX7LGSHPwcOX395GARUl1qibhbgmu+agawoQ+yObUByTs7URUSkd8uXB
         H5p0EqYIYa8A+YV9Y9YxjfPGNyzDdGTAZAzH8qLq5bE6qaow/aP0fC4pIU9lZa8bV3WZ
         Id68iJQAlgkbBcOvDqM2C2RUvMK+aXaIRpG7GY+lsRAQ3pWtFSsdgN53wTSn36UVJT5y
         yemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520529; x=1780125329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Inkv515K3CDOqGmxKUbJA66Ndin1wkzy98GUXdhIoyc=;
        b=nVWZCQjtx4Qpw+mcZ8WXWsBsgatOw311SMakgWRvk1EFzlQiUNi2qm0JN3+xOlb2mC
         wB07aeh+6Dkr4cTcRTZoA+VMtliUcaDEmWmTTmhCqe73x1bATPgiET6wLT2mU1Jrt25E
         ufhpmU+bdAkGv8coE6vfUOShLT3k3OWCclK5EDoTrJLeOsnSnJIR8/lTMAcEcPQztRow
         BE8tDY1gyUPUGWCfOzTsMsbMTu48WfgwzWuTVMxBy7pEWPs9GnvLgN6VUiYpvHj0029W
         d+ZPeYIo//TMe5OB/qL38khGSbbor6n9RxkpJttuoF4ncDWU/MwpLJmMr7vLeeaS2dJc
         dbQg==
X-Forwarded-Encrypted: i=1; AFNElJ8iXi0zo7w1HHl0Tybf2Sd4mV/aj91k5Ih5Y0XmfmIZe5PEpJ/mJ5hg6A/I8SkVQMN4zgur7w3tQUFD/2KC@vger.kernel.org
X-Gm-Message-State: AOJu0YzjwFi+5GngkKAFr0ylrnhn//EypFXCL+scDzos1ocQXtrS8JUL
	mm43N5aICK1aoSJEjfhgOE3WSz6WT/yWQFkL9mFK/b77aavSrg0Nkr/csXtBAso2jrY=
X-Gm-Gg: Acq92OHdm1eBX1hd9xVpQxuNWbTxPe3/MyVTSU0AS4tkIr9bD6CGG+u81+ZhAwVyx69
	sN54zznYtWsX/0byZwxS+pgNey9EgaecNSjpDmwEZM5EGKk8brLAsmsajLr2RYo4xrIns0q2aj0
	0BF1qiArn6Qmpg7pYSvNw15/gDCxz55rgXPPd812Z4W1QBSWyJe2eUzdVXtzk94is4JPLQKIe4a
	rtZRrXkNPEcN5IjsNlGwSdqKunks1o40gvNsRlgImihTFFI8MEj9owUujS5Vp2STiRX1N65lSF7
	V5qyQfdcRTBBuTSTfy6PvbPSEOK7aQnpEOq1/YnO59EOh8DVjOYv6bdg2yOXjshmMTuhdVSp/An
	kViyAXYACjYtdDpg8ePOzxplsZkxOU+pKsMI0b/kbWOnC3QTksuUWN8VsQD3UZCq0ORK/xFxBNt
	xtSH15AX8mYB9QjFQYn7yR6XwaGpaWKhA6jnnQg68=
X-Received: by 2002:a05:6000:610:b0:45e:742c:f195 with SMTP id ffacd0b85a97d-45eb3690ba8mr10344352f8f.12.1779520526578;
        Sat, 23 May 2026 00:15:26 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:26 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:49 -0600
Subject: [PATCH v2 16/24] dyndbg: replace classmap list with an array-slice
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-16-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=6627;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=acmpE5f+cy4H0euAd/sWLVbXBhuyRVdVfvkTY1QfTl8=;
 b=+LlT89h5Zas1rnf6o1vCdzF04GdcJrVVBC0DVNyp/lojUnxHBDsi3KbK2sf4iEP6Z6JU0GAQD
 gRp8te91A/gDPQKNAolv23w1WGUsRCb95To3FYv6z7PAbLpnCZHB4aQ
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Classmaps are stored in an elf section/array, but currently are
individually list-linked onto dyndbg's per-module ddebug_table for
operation. This is unnecessary.

Just like dyndbg's descriptors, classes are packed in compile order;
so even with many builtin modules employing multiple classmaps, each
modules' maps are packed contiguously, and can be treated as a
array-start-address & array-length.

So this drops the whole list building operation done in
ddebug_attach_module_classes(), and removes the list-head members of
the classmap structs.  The "select-by-modname" condition is reused to
find the start,end of the subrange of classmaps belonging to the module.

NOTES:

There are multiple modules named "main" but thats an artifact of how
KBUILD_MODNAME gets its value, and none of those repeats are
contiguous.  The legacy code segmenting the builtin descriptors
depends upon this, we are "reusing" that dependency.

The "filter-by-modname" on classmaps should really be done in
ddebug_add_module(1); ie closer to dynamic_debug_init(2), which
already splits up pr-debug descriptors into subranges by modname, then
calls (1) on each.  (2) knows nothing of classmaps currently, and
doesn't need to.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: RvB after SoB
---
 include/linux/dynamic_debug.h |  1 -
 lib/dynamic_debug.c           | 65 +++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index e724f6b93663..0a137a586510 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -73,7 +73,6 @@ enum ddebug_class_map_type {
 };
 
 struct ddebug_class_map {
-	struct list_head link;
 	struct module *mod;
 	const char *mod_name;	/* needed for builtins */
 	const char **class_names;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d4cce0f4f197..7f03b331d185 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -46,10 +46,11 @@ extern struct ddebug_class_map __start___dyndbg_classes[];
 extern struct ddebug_class_map __stop___dyndbg_classes[];
 
 struct ddebug_table {
-	struct list_head link, maps;
+	struct list_head link;
 	const char *mod_name;
-	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
+	struct ddebug_class_map *classes;
+	unsigned int num_ddebugs, num_classes;
 };
 
 struct ddebug_query {
@@ -150,12 +151,13 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 }
 
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							  const char *class_string, int *class_id)
+							const char *class_string,
+							int *class_id)
 {
 	struct ddebug_class_map *map;
-	int idx;
+	int i, idx;
 
-	list_for_each_entry(map, &dt->maps, link) {
+	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -166,7 +168,6 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	return NULL;
 }
 
-#define __outvar /* filled by callee */
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -228,7 +229,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
-	int __outvar valid_class;
+	int valid_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -1061,9 +1062,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1147,30 +1149,34 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
-static void ddebug_attach_module_classes(struct ddebug_table *dt,
-					 struct ddebug_class_map *classes,
-					 int num_classes)
+static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
 {
 	struct ddebug_class_map *cm;
-	int i, j, ct = 0;
+	int i, nc = 0;
 
-	for (cm = classes, i = 0; i < num_classes; i++, cm++) {
+	/*
+	 * Find this module's classmaps in a subrange/wholerange of
+	 * the builtin/modular classmap vector/section.  Save the start
+	 * and length of the subrange at its edges.
+	 */
+	for (cm = di->classes, i = 0; i < di->num_classes; i++, cm++) {
 
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
-
-			v2pr_info("class[%d]: module:%s base:%d len:%d ty:%d\n", i,
-				  cm->mod_name, cm->base, cm->length, cm->map_type);
-
-			for (j = 0; j < cm->length; j++)
-				v3pr_info(" %d: %d %s\n", j + cm->base, j,
-					  cm->class_names[j]);
-
-			list_add(&cm->link, &dt->maps);
-			ct++;
+			if (!nc) {
+				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
+					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
+				dt->classes = cm;
+			}
+			nc++;
+		} else if (nc) {
+			/* end of matching classmaps */
+			break;
 		}
 	}
-	if (ct)
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, ct);
+	if (nc) {
+		dt->num_classes = nc;
+		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
+	}
 }
 
 /*
@@ -1202,10 +1208,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1318,8 +1323,8 @@ static void ddebug_remove_all_tables(void)
 	mutex_lock(&ddebug_lock);
 	while (!list_empty(&ddebug_tables)) {
 		struct ddebug_table *dt = list_entry(ddebug_tables.next,
-						      struct ddebug_table,
-						      link);
+						     struct ddebug_table,
+						     link);
 		ddebug_table_free(dt);
 	}
 	mutex_unlock(&ddebug_lock);

-- 
2.54.0

