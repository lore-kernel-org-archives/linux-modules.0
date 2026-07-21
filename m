Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F47476CC2
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667463; cv=none; b=OZ5TWKLr5Zr2/YeSeyM4W4wCnBh80gDNDKEe3iv7OZ8RbgQ8WdL9NA7vzHWE6BTXGhyUAu+AagnAPVFJVRHuO3++s2LA33bM3/qNR5hB6gd2hrmk18Lhbu/jIno01i1C5KsSUebuQNDz95060hMt2CVapmE4vv7z/d++/eQD4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667463; c=relaxed/simple;
	bh=UvvdNmjYasQcfrXvHNJC1I4lW9B4CfA7EsDivJfXS3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJ86cIE4ENJNsRMr99YxjdrtBH4dY1M5bO2IPX6/6CBu13/+2hJeQ75EJ1sUGu3suV01UMhb8JL7/zIh10T1DG25wLMLk2wHdGFxMVanmkdO3l7riEuKWQ6r4RoRapDeQMi6ectRqE+IBokiZ4FugINSVYoTpOC9g+fGunKzj1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1GFSb5z; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1GFSb5z"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb63dbd229so3276739a34.1
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667458; x=1785272258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ENoNkwvV1VjhwDC+HDQhxn3UZGq4A9V7zaG+rkGi914=;
        b=U1GFSb5zqUvmW5n6pBP35Osu8lFWkgdvQxJhj16hN7r6jfQKg59DTB3v1DohmpnTVC
         FIvNkcZzwS7XuHptMoVLF21lcWKyIIRffdyqt6bi1e7dKr9EguHg4cDirdOaOoFdjkE2
         3K67GmAw49e99B4riRNapYVOhFSTO9g8qnnlH7s+HKzVGeA9ciBqifYGKawhGhtXYNJF
         3E6J3r85voG21K+cda10zUoygsiLmksnuzDtV3ak9wa6B+RSLunmNQ6A3q9fQvvMPm2u
         EOTTQWK9zwIQoCR0De9YH/QGZ3GJ/BeYmxM0dkkz/MiXEcdra/vfFSxYkksgfMOQ/EBQ
         ZvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667458; x=1785272258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENoNkwvV1VjhwDC+HDQhxn3UZGq4A9V7zaG+rkGi914=;
        b=VNcydH62XeS987U41uxk5nb0P3KikTVfMRIyZYmh5gILKCaoQHHuYunvC56/uieqmw
         nNYAbTeM4TbFusisegvm+qcjA5QTHy/IhABlQO7nNZZY33otyw4DeAkH8YdvedwUVvAl
         cctPXWMH1fORUriqJngnuqpm9hZAlAXe66pTekQ647FU3ByQ6pw8KoFluJxyXbHpuFuU
         4kN/Th6Si+F8yTTEnRwlW+w8/1zTjbww7WqFLaPdE7IjU+3WHhnUlIpytMIYF5Bl5sGa
         xq/AYkGVIvxyUf8DhzozMTKNrAa30ZRdf6SguWjqESKiqWJ++UbiAbJXE5MzUlUwsUJR
         Z8RA==
X-Forwarded-Encrypted: i=1; AHgh+Rokn4aM6HZugtlNY6RVPhMVqdb3CVJNHM9q/ev9f+HaTlShu6p0Q3Ftf4evR1Mwnb6AaXdXNevcIWkGX3qO@vger.kernel.org
X-Gm-Message-State: AOJu0YwXO2dY93ee0VqRjpYVx9jscKYHcQNTmDQT/y/o5db6+YUsOyQ6
	clSjOrT7skKxFwv15rfK4W4cUWFPsBrzO4HmUpl9td8s6qVFe04FU+TbRv8J5w==
X-Gm-Gg: AfdE7cllLelRf2T3PvlG/iBQhDTKh9Lqj5Y9cg3I0I7JIr3YW5y/l6Z8JX5mtQ2jVtB
	V2IyjHw3/pZUcvWcVi6hc6/2NbKQT+5zG/3stq3u7AfBA7+Qq89Hf7ZvwOPvgqpF5i57d8drt2s
	e8u4nULTxS6+TYsGkHs+fFHA8XmEqYysOsd9R+vNGpMS+gueS0Pehi/okvDclg7Nd4UkTMV/h9v
	OHKyZDa1gAM9MaZiKvNl/cG0FXFuLkaqPnv55Ig2cyEFUNmG9pxUCeFulhqIDcWeG5jFrbnwB9p
	HPSrHv1pG4uTDtn0+4RIkApIVCRm/cmnFX4ojhtyqigI8eoZFfjVzqBmIQOwcjgsFbZrBHtNv2I
	pttol+5s3VJjgqg7fYNY1incHStcmAWmQ72kKMELBTHQPcasdY/cGB4TDt7TeNnBLEk0hVxKSx7
	JEvkj+SI0tRxMBm5ZtzcXxqicmrx68EqoMlhMADctSNHUUtPpPd0qcbh8gShXFB0Zt54fK9jN5m
	FpFAbBrSe1RKwrWxCEfR8OA2ZviL0PMUKkL
X-Received: by 2002:a05:6830:3145:b0:7ec:4121:f56 with SMTP id 46e09a7af769-7ee22cf01f7mr775083a34.1.1784667457927;
        Tue, 21 Jul 2026 13:57:37 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:37 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:11 -0600
Subject: [PATCH v7 22/29] dyndbg: replace classmap list with an array-slice
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-22-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=6080;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=UvvdNmjYasQcfrXvHNJC1I4lW9B4CfA7EsDivJfXS3s=;
 b=rxFb6ZGkhDYPOqJFnpXJBtHWBS8ZQjQtuLRf6dKIjo9UoKzjlViHh8BkvzPU1dmnhjOTXeusH
 jGrglaXPkxLDXjXuuf/29jJltCrzIWLhb4BlsqAUxv9rCUycIZ58+HJ
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Classmaps are stored in an elf section/array, but currently are
individually list-linked onto dyndbg's per-module ddebug_table for
operation. This is unnecessary.

Just like dyndbg's descriptors, classmaps are packed in compile order;
so even with many builtin modules employing multiple classmaps, each
modules' maps are packed contiguously, and can be treated as a
array-start-address & array-length.

So this drops the whole list building operation done in
ddebug_attach_module_classes(), and removes the list-head members of
the classmap structs.  The "select-by-modname" condition is reused to
find the start,end of the subrange of classmaps belonging to the module.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: RvB after SoB
---
 include/linux/dynamic_debug.h |  1 -
 lib/dynamic_debug.c           | 65 +++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 17cc1ae7baef..5e484862f814 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -87,7 +87,6 @@ enum ddebug_class_map_type {
 };
 
 struct ddebug_class_map {
-	struct list_head link;
 	struct module *mod;
 	const char *mod_name;	/* needed for builtins */
 	const char **class_names;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 364a55fc9447..5abf6ff6be52 100644
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
@@ -149,12 +150,13 @@ static void v3pr_info_dq(const struct ddebug_query *query, const char *msg)
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
@@ -231,7 +232,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
-	int __outvar valid_class;
+	int valid_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -1070,9 +1071,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1156,30 +1158,34 @@ static const struct proc_ops proc_fops = {
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
@@ -1211,10 +1217,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1327,8 +1332,8 @@ static void ddebug_remove_all_tables(void)
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
2.55.0

