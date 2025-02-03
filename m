Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3281D5166
	for <linux-modules@vger.kernel.org>; Mon,  3 Feb 2025 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738617998; cv=none; b=Ot4a4OJVcUw2X+vEQMWYRX6/afjYgJRWRdywT0Ep3GPS6VqCHpj7nFNui+6aYovc/0kBBC6doTJLwkltXmPUtipUl33pLM8Q10uIfmSnDf0IhOvkOYfpmgYCGVK7ASNPtkKv2D3/+KSEFgkbocVsMpFtyQDJtsjmbYtV46vRLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738617998; c=relaxed/simple;
	bh=JeDac0q7kV6pCKlgWMuLm1akLXt+s+WKT6IT+w2VOew=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ifEJ0U5r9KHn8xFTQ/XJYIzdDE1L4KR08cNUB5Nof6Q7uZFuow4dsLmz8h367EURjrMqvmvME9dKshmvq6XqXK54A35OUNOENSHzdehekKS5iUQfAvW1otSGixkG1VVF3pVrtUXtLEBZ/7x3VB4hcTZqWbZkonWoqrJnzNCdvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T6U9qiRe; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6U9qiRe"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f816a85facso9066433a91.3
        for <linux-modules@vger.kernel.org>; Mon, 03 Feb 2025 13:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738617995; x=1739222795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xjzG1KpOB33WO7MG4/hnojjzcuAojKCRhLZ9X+LEtag=;
        b=T6U9qiReiV9A1GVTwHgWeFB7H3+8Sv13EzJXP3NcC59QcclvEBRba2KBLmvlIjNtBk
         fzlSvW+s803cNkM8er694Bwx6dk3MPE4485DT+eJfbLFFAn9/VSgN7yuhsE0PihnICMT
         ZDRLYsIb2HNQBhhIwYRHcO014dFnL8ux1bFqe8fZFub32MlXnXP9VlV8mAwRjars1sQc
         B6m7zilFTMnL0gCZVDssPKJULL2rJMeXc8kPSIt9bce/p+OwMTjPUNl1iAmh4ZjCDXoN
         pjpm4+ukp3zWqV6m6ok2gc2SH3tJZWR2PJ6kDJcHy30f21bPGAG2oUg+BZaF+C6+zsFL
         qNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738617995; x=1739222795;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjzG1KpOB33WO7MG4/hnojjzcuAojKCRhLZ9X+LEtag=;
        b=vJAioIMcQtz9stOKCG7Gz0duzDDpjlmU+76x53R+OpMJ9QcdxH3l1502XO9yfcOz3I
         LAVYdEgM4hHgg5VhlXkJDTjzcEG1wbVpz9BLWessXIp1fvk460KjcEX7WJoJmyA05ugL
         JgLB2x7174V5/d+XoHRrkhMR76bpMsi1zxxjoh3szJOJs0++wPjNPlOX46cCXjQkcC7i
         Ki0R8MMveMuM6N6ooaeyq1v+VuLCw0wTiyIkGNcUJcnwx/RTPnwSHqtrG1li2CZVL9Kk
         IhKJzFErJPWT6YXVnX6O7r2TvQ292ffz5F1xfRugHOMbhDmLZjfdqPiegjzADZPoHq3X
         lcXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8p5IigU1nhgVWnOM1DaJQf0DpRl/rsZFSjVGsPhyqwTW0trOdj3FQK1l7BwXZzsxdkbuz79GmD5+9Elpr@vger.kernel.org
X-Gm-Message-State: AOJu0YwwKEcpq6l3QOan1kyjjcpaKaNJPhBLWNlW24mZ9mHLKwk0kMO4
	Iv3C2rV+Hci4yHzmXlbswj6uWVGtI+tyy+r9/XqPB6jfvTpj0sPsDhtcF4UffNqjy/M/blPJCU5
	wyVfK5FlbenOf7JQ8wZqw2Qcp3w==
X-Google-Smtp-Source: AGHT+IFp8Bb1uts8l0ivJKmHnFfAT/7nzBCLJaIOvCG8JcYD0WSwRz844mjcXsBSV6UmkLE4IXKqBJ2dFLizO3GXShk=
X-Received: from pfbik10.prod.google.com ([2002:a05:6a00:8d0a:b0:72b:ccb:c99b])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e88:b0:725:df1a:288 with SMTP id d2e1a72fcca58-72fd0c74f49mr37105211b3a.24.1738617994983;
 Mon, 03 Feb 2025 13:26:34 -0800 (PST)
Date: Mon,  3 Feb 2025 21:26:32 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=8722; i=samitolvanen@google.com;
 h=from:subject; bh=JeDac0q7kV6pCKlgWMuLm1akLXt+s+WKT6IT+w2VOew=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOkLTdpPikoo/T7Vf3b7ZPFZ8dkdAeH/J8trcKxRl+sXP
 mjcE7iko5SFQYyDQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAEykyI7hr1x8j3Yj5+52gziL
 jIn8a78dnuehxTixh22uB2fupqveqgz/DNeevHjKdQpLxy2Zu+Ih/q9W9RUXfbTQM/nluW7O/e1 tfAA=
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203212631.565818-2-samitolvanen@google.com>
Subject: [PATCH] gendwarfksyms: Add a separate pass to resolve FQNs
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"

Using dwarf_getscopes_die to resolve fully-qualified names turns out to
be rather slow, and also results in duplicate scopes being processed,
which doesn't help. Simply adding an extra pass to resolve names for all
DIEs before processing exports is noticeably faster.

For the object files with the most exports in a defconfig+Rust build,
the performance improvement is consistently >50%:

rust/bindings.o: 1038 exports
    before: 9.5980 +- 0.0183 seconds time elapsed  ( +-  0.19% )
     after: 4.3116 +- 0.0287 seconds time elapsed  ( +-  0.67% )

rust/core.o: 424 exports
    before: 5.3584 +- 0.0204 seconds time elapsed  ( +-  0.38% )
     after: 0.05348 +- 0.00129 seconds time elapsed  ( +-  2.42% )
            ^ Not a mistake.

net/core/dev.o: 190 exports
    before: 9.0507 +- 0.0297 seconds time elapsed  ( +-  0.33% )
     after: 3.2882 +- 0.0165 seconds time elapsed  ( +-  0.50% )

rust/kernel.o: 129 exports
    before: 6.8571 +- 0.0317 seconds time elapsed  ( +-  0.46% )
     after: 2.9096 +- 0.0316 seconds time elapsed  ( +-  1.09% )

net/core/skbuff.o: 120 exports
    before: 5.4805 +- 0.0291 seconds time elapsed  ( +-  0.53% )
     after: 2.0339 +- 0.0231 seconds time elapsed  ( +-  1.14% )

drivers/gpu/drm/display/drm_dp_helper.o: 101 exports
    before: 1.7877 +- 0.0187 seconds time elapsed  ( +-  1.05% )
     after: 0.69245 +- 0.00994 seconds time elapsed  ( +-  1.44% )

net/core/sock.o: 97 exports
    before: 5.8327 +- 0.0653 seconds time elapsed  ( +-  1.12% )
     after: 2.0784 +- 0.0291 seconds time elapsed  ( +-  1.40% )

drivers/net/phy/phy_device.o: 95 exports
    before: 3.0671 +- 0.0371 seconds time elapsed  ( +-  1.21% )
     after: 1.2127 +- 0.0207 seconds time elapsed  ( +-  1.70% )

drivers/pci/pci.o: 93 exports
    before: 1.1130 +- 0.0113 seconds time elapsed  ( +-  1.01% )
     after: 0.4848 +- 0.0127 seconds time elapsed  ( +-  2.63% )

kernel/sched/core.o: 83 exports
    before: 3.5092 +- 0.0223 seconds time elapsed  ( +-  0.64% )
     after: 1.1231 +- 0.0145 seconds time elapsed  ( +-  1.29% )

Overall, a defconfig+DWARF5 build with gendwarfksyms and Rust is 14.8%
faster with this patch applied on my test system. Without Rust, there's
still a 10.4% improvement in build time when gendwarfksyms is used.

Note that symbol versions are unchanged with this patch.

Suggested-by: Giuliano Procida <gprocida@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/gendwarfksyms/die.c           |   2 +-
 scripts/gendwarfksyms/dwarf.c         | 152 ++++++++++++++------------
 scripts/gendwarfksyms/gendwarfksyms.h |   2 +
 scripts/gendwarfksyms/types.c         |   2 +-
 4 files changed, 86 insertions(+), 72 deletions(-)

diff --git a/scripts/gendwarfksyms/die.c b/scripts/gendwarfksyms/die.c
index 66bd4c9bc952..6183bbbe7b54 100644
--- a/scripts/gendwarfksyms/die.c
+++ b/scripts/gendwarfksyms/die.c
@@ -6,7 +6,7 @@
 #include <string.h>
 #include "gendwarfksyms.h"
 
-#define DIE_HASH_BITS 15
+#define DIE_HASH_BITS 16
 
 /* {die->addr, state} -> struct die * */
 static HASHTABLE_DEFINE(die_map, 1 << DIE_HASH_BITS);
diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 534d9aa7c114..eed247d8abfc 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2024 Google LLC
  */
 
+#define _GNU_SOURCE
 #include <assert.h>
 #include <inttypes.h>
 #include <stdarg.h>
@@ -193,79 +194,17 @@ static void process_fmt(struct die *cache, const char *fmt, ...)
 	va_end(args);
 }
 
-#define MAX_FQN_SIZE 64
-
-/* Get a fully qualified name from DWARF scopes */
-static char *get_fqn(Dwarf_Die *die)
+static void update_fqn(struct die *cache, Dwarf_Die *die)
 {
-	const char *list[MAX_FQN_SIZE];
-	Dwarf_Die *scopes = NULL;
-	bool has_name = false;
-	char *fqn = NULL;
-	char *p;
-	int count = 0;
-	int len = 0;
-	int res;
-	int i;
-
-	res = checkp(dwarf_getscopes_die(die, &scopes));
-	if (!res) {
-		list[count] = get_name_attr(die);
-
-		if (!list[count])
-			return NULL;
-
-		len += strlen(list[count]);
-		count++;
-
-		goto done;
-	}
-
-	for (i = res - 1; i >= 0 && count < MAX_FQN_SIZE; i--) {
-		if (dwarf_tag(&scopes[i]) == DW_TAG_compile_unit)
-			continue;
-
-		list[count] = get_name_attr(&scopes[i]);
-
-		if (list[count]) {
-			has_name = true;
-		} else {
-			list[count] = "<anonymous>";
-			has_name = false;
-		}
+	struct die *fqn;
 
-		len += strlen(list[count]);
-		count++;
-
-		if (i > 0) {
-			list[count++] = "::";
-			len += 2;
-		}
+	if (!cache->fqn) {
+		if (!__die_map_get((uintptr_t)die->addr, DIE_FQN, &fqn) &&
+		    *fqn->fqn)
+			cache->fqn = xstrdup(fqn->fqn);
+		else
+			cache->fqn = "";
 	}
-
-	free(scopes);
-
-	if (count == MAX_FQN_SIZE)
-		warn("increase MAX_FQN_SIZE: reached the maximum");
-
-	/* Consider the DIE unnamed if the last scope doesn't have a name */
-	if (!has_name)
-		return NULL;
-done:
-	fqn = xmalloc(len + 1);
-	*fqn = '\0';
-
-	p = fqn;
-	for (i = 0; i < count; i++)
-		p = stpcpy(p, list[i]);
-
-	return fqn;
-}
-
-static void update_fqn(struct die *cache, Dwarf_Die *die)
-{
-	if (!cache->fqn)
-		cache->fqn = get_fqn(die) ?: "";
 }
 
 static void process_fqn(struct die *cache, Dwarf_Die *die)
@@ -1148,8 +1087,81 @@ static void process_symbol_ptr(struct symbol *sym, void *arg)
 	cache_free(&state.expansion_cache);
 }
 
+static int resolve_fqns(struct state *parent, struct die *unused,
+			Dwarf_Die *die)
+{
+	struct state state;
+	struct die *cache;
+	const char *name;
+	bool use_prefix;
+	char *prefix = NULL;
+	char *fqn = "";
+	int tag;
+
+	if (!__die_map_get((uintptr_t)die->addr, DIE_FQN, &cache))
+		return 0;
+
+	tag = dwarf_tag(die);
+
+	/*
+	 * Only namespaces and structures need to pass a prefix to the next
+	 * scope.
+	 */
+	use_prefix = tag == DW_TAG_namespace || tag == DW_TAG_class_type ||
+		     tag == DW_TAG_structure_type;
+
+	state.expand.current_fqn = NULL;
+	name = get_name_attr(die);
+
+	if (parent && parent->expand.current_fqn && (use_prefix || name)) {
+		/*
+		 * The fqn for the current DIE, and if needed, a prefix for the
+		 * next scope.
+		 */
+		if (asprintf(&prefix, "%s::%s", parent->expand.current_fqn,
+			     name ? name : "<anonymous>") < 0)
+			error("asprintf failed");
+
+		if (use_prefix)
+			state.expand.current_fqn = prefix;
+
+		/*
+		 * Use fqn only if the DIE has a name. Otherwise fqn will
+		 * remain empty.
+		 */
+		if (name) {
+			fqn = prefix;
+			/* prefix will be freed by die_map. */
+			prefix = NULL;
+		}
+	} else if (name) {
+		/* No prefix from the previous scope. Use only the name. */
+		fqn = xstrdup(name);
+
+		if (use_prefix)
+			state.expand.current_fqn = fqn;
+	}
+
+	/* If the DIE has a non-empty name, cache it. */
+	if (*fqn) {
+		cache = die_map_get(die, DIE_FQN);
+		/* Move ownership of fqn to die_map. */
+		cache->fqn = fqn;
+		cache->state = DIE_FQN;
+	}
+
+	check(process_die_container(&state, NULL, die, resolve_fqns,
+				    match_all));
+
+	free(prefix);
+	return 0;
+}
+
 void process_cu(Dwarf_Die *cudie)
 {
+	check(process_die_container(NULL, NULL, cudie, resolve_fqns,
+				    match_all));
+
 	check(process_die_container(NULL, NULL, cudie, process_exported_symbols,
 				    match_all));
 
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 197a1a8123c6..2feec168bf73 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -139,6 +139,7 @@ void symbol_free(void);
 
 enum die_state {
 	DIE_INCOMPLETE,
+	DIE_FQN,
 	DIE_UNEXPANDED,
 	DIE_COMPLETE,
 	DIE_SYMBOL,
@@ -170,6 +171,7 @@ static inline const char *die_state_name(enum die_state state)
 {
 	switch (state) {
 	CASE_CONST_TO_STR(DIE_INCOMPLETE)
+	CASE_CONST_TO_STR(DIE_FQN)
 	CASE_CONST_TO_STR(DIE_UNEXPANDED)
 	CASE_CONST_TO_STR(DIE_COMPLETE)
 	CASE_CONST_TO_STR(DIE_SYMBOL)
diff --git a/scripts/gendwarfksyms/types.c b/scripts/gendwarfksyms/types.c
index 6c03265f4d10..6f37289104ff 100644
--- a/scripts/gendwarfksyms/types.c
+++ b/scripts/gendwarfksyms/types.c
@@ -248,7 +248,7 @@ static char *get_type_name(struct die *cache)
 		warn("found incomplete cache entry: %p", cache);
 		return NULL;
 	}
-	if (cache->state == DIE_SYMBOL)
+	if (cache->state == DIE_SYMBOL || cache->state == DIE_FQN)
 		return NULL;
 	if (!cache->fqn || !*cache->fqn)
 		return NULL;

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.48.1.362.g079036d154-goog

