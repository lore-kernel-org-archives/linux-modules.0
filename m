Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5B31E826
	for <linux-modules@vger.kernel.org>; Mon,  4 May 2026 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927534; cv=none; b=JT2LtDgUnw5PA9zAh50CHlMXtjwevzncJk6dtYd9TUdoK/Lv2vGvO6xYbp3fyUlMng7LPsuRAnDWoHnZ8LaWVUV/J4Gz62gvB7RzoB8pX2dBSTTWqmTMsz0HxPIL8U7tkvaTZpARhgNX0xzFu3s8yIl2rpeLvBMzQ+2tKxUQT4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927534; c=relaxed/simple;
	bh=YzpVlr+neWT2/LWkGMoyvfkqvUybg/U4Va9v6w4EBao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qcifi8NeHoI2rp13qFJ+6sITOfy8ePPkCFt4/CF82vwpGKg1aM4B5tN8rZ6mloRm7YIhT5R2VcqcX/QMKp2Ap0d913g5yZL89x75gx5WGGI1Zm6aEQtkbxRSbz+LaUdJjYH/sA4UoU2eELHVFVBayupOrMGb7wCOYl/a4SQu1Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWNmFoR/; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWNmFoR/"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40946982a78so1591195fac.2
        for <linux-modules@vger.kernel.org>; Mon, 04 May 2026 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777927530; x=1778532330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wim9cqsthvYPUEudyHNLJdRCqnGrz1B6yKCAEeqHKQ4=;
        b=gWNmFoR/r+RRFSfvPgkWY1bCzRqckrilykMfFS6SWkV7NYGAkRmZCndWCdsQayyUcC
         3siNgwin+1sUuFU/P1pzwhxo2UG+o9nTOYm/9HbA9FWpTq704h/Hte4ZKt76KYPEWrtq
         WxW5WUlhvBR5lAYN12YszuxkGmonctUOepIy8yNoNyXDEDHBLyfOjhyX4GmqIm+npeyl
         WSC0qRrBM/LpFan21jVgmCBQBSCxvG7fouTHj/xGkO4rZhB4QV3ANR9rMvtE1rARn8P5
         oxlRyPLZjoP2L0qJcve4pANdsh7C9hNIW5OSvdvWxV0fGIi6nI4O95gUf9p899S2oOHE
         I9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927530; x=1778532330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wim9cqsthvYPUEudyHNLJdRCqnGrz1B6yKCAEeqHKQ4=;
        b=Ut541YtbM041cO80mBf1U601sgEWRwV9inxsr4IC/hkHpOHwi0rbqUrS155sbRKP7h
         RzSqwdhW7mrC3LlPFdJr8w4sML3BMS1H6ppMETu9FAPmLpDdR2q3IhjHbLTMHgPPPGg/
         8HZ6jk+6Nmzj09066mMmgMNvq5qu1h63N/CSZImCZus81w/sEtiaxiBRBMJ9cWlGB4yh
         CoBbAJo1YkhjUojo+BXYxmHDqyoK/7CTmSsb6qFXpqtnqn+VmFYk5i90AXxN3qBS8zTW
         D7tcKFCQQj6fsHs5hUbZSEoGT+xRGAUUGW57FkwjLt1PMN4+QyAPDjlTYVF5ed9Q5JzD
         jP+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/2QRRdu7bGaURiA/t45OPZcg8uQTmMu43K/0dDRadsntxoXXoGUdhTUV2ET4amuPKyMQSp+T6wYONaqkvR@vger.kernel.org
X-Gm-Message-State: AOJu0YxPB8Skxd/qY58NBgjGDrqoXgpXHeG68UBPAG0fipMkFUGHi/0q
	KWlWB8u5yRDlQf/3A1ozKFBXFodEARXTQbQv6huDbzOZx+zk5ztzogJI
X-Gm-Gg: AeBDieu15YIhfSqbvkK+m12fQ561CYqqIM3uPuc91DS704nGpVaKlOGT6mH0X9tLq6R
	bZFLqiYCkw29fZ892N7D5dp9oJydYu6T0Cg5qBeKYwAdMTlyKAg+sUxztm//KIz/ZUEpAzdiHic
	AvDCN5SN0BtpdEiac7jrqhKJk5YIEk7AWOkKut6uJU4nwXL0xFxY00uxL2eIwsVVsoVK4XVtJcM
	NwYEAQZ0b8BUhA/1mkb1x8YDPFSR9mDetdE7Opic8v6cVsfhPEKfElMSMFvnAproqPd1HHnLRwg
	fWOprCMpc9P+9uIKyjePeWWNj9O8YVaRVV//Gj9mQZKFRd8pco5eT//gbYvj1XnUWHUzK1rmw9U
	snl1hul5Fe3GDxwL3/hX93No9Ri4ZbEYR1eRbKdD1rXF28e7RuYz2dRO/MTxPX+03ZrEV7t0GoO
	yMBItJeNejq/fle2IrvYR2OBoWlGl9W8da9Kfgq80V1/ScH8gO0jSbfE1q6QRcQhYX45xhNXSNd
	VemuigBEnk=
X-Received: by 2002:a05:6820:16a6:b0:685:d435:1471 with SMTP id 006d021491bc7-696979c86d7mr5810090eaf.10.1777927529681;
        Mon, 04 May 2026 13:45:29 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69689266bacsm7144713eaf.0.2026.05.04.13.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:45:29 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 04 May 2026 14:45:16 -0600
Subject: [PATCH 10/17] dyndbg: replace classmap list with a vector
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dd-cleanups-2-v1-10-6fdd24040642@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777927513; l=6247;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=YzpVlr+neWT2/LWkGMoyvfkqvUybg/U4Va9v6w4EBao=;
 b=Xdmn0YJItXbm6bnC/BTN5CwaHPz2R1X2hVi1LxvxVQ3JOz+xoR9SD3arQcO3wa2SIKiXYiFpH
 HEAIxQg15qTDsi1qRF0aVyx6PYq12W6mDI5A77AeZLtdtFbEuYICDDs
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
ddebug_attach_module_classes(), and removes the list-head members.
The "select-by-modname" condition is reused to find the start,end of
the subrange.

NOTE: This "filter-by-modname" on classmaps should really be done in
ddebug_add_module(1); ie at least one step closer to ddebug_init(2),
which already splits up pr-debug descriptors into subranges by
modname, then calls (1) on each.  (2) knows nothing of classmaps
currently, and doesn't need to.  For now, just add comment.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  1 -
 lib/dynamic_debug.c           | 62 ++++++++++++++++++++++---------------------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 92627a03b4d1..9fd36339db52 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -84,7 +84,6 @@ enum class_map_type {
 };
 
 struct ddebug_class_map {
-	struct list_head link;
 	struct module *mod;
 	const char *mod_name;	/* needed for builtins */
 	const char **class_names;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a18f4bc63473..94a66c8537ab 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -45,10 +45,11 @@ extern struct ddebug_class_map __start___dyndbg_classes[];
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
@@ -149,12 +150,13 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
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
@@ -165,7 +167,6 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	return NULL;
 }
 
-#define __outvar /* filled by callee */
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -227,7 +228,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
-	int __outvar valid_class;
+	int valid_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -1134,9 +1135,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1220,30 +1222,31 @@ static const struct proc_ops proc_fops = {
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
@@ -1275,10 +1278,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1391,8 +1393,8 @@ static void ddebug_remove_all_tables(void)
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

