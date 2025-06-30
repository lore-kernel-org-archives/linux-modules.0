Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8063E28C2C2
	for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293653; cv=none; b=AYyxyXp+chlQPp4PPgtZP1OjRb5QL89A9nwTkYF4xzjZuDIT8GSyjIJmuQHs8Ih8p8NbRgTo8PxsegngHrKYgOq0+lyCbFspeuZSJJWm2vsFgXJwezO5Ylp0x8tj10IYE3/AVQo+IVEu/1Z+5bCoCPIcnv8y5CcSJAugZImLAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293653; c=relaxed/simple;
	bh=9db6x0EMOe6E9j32qrzyr5EJwVkIl5FELxN4JFxD+Vo=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=KJnpjWHDQW4pRzY1BVmmMTuWf+P4aThsCf8Nv9+qyBwZHoNzs4Jgd2seumxZfs22WYFI1FSAVUrm/nRzq2SVHA4OakLJetZ59d8pAOE8HFzKx/q6+S/VBxxhAsFsi3/A11uj5vwWDr5dGB5wIRzpznZ1J/dPYX801glWzfaN2l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C1YWcxWl; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C1YWcxWl"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso2020052f8f.0
        for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751293650; x=1751898450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jA1+PqXVtq5JGGyS5bMqoIcyAvEWva/WB/dyQOqqHmU=;
        b=C1YWcxWldsyRsfw5atRt3hcl6Q/3ThDImMsaj5pdObRaAl656fgCPpQ56T3UiycROw
         MZVfJs4dur9pjWmuGEUbtRCvc4HWxg7m2Qs9BwDWO3EPJjq5XD8zHEC2YxzTHrec8The
         tM1Bi5WPxS4HGcivDb1MCOE771QltsSwpBunAGRVQ6sHLAEG1a7wlo0sNdaKXWtdZXVn
         t/mcPBeUR4z+QTFnUY0pYi3SevSp0y0EI2KVwRwujvnOVILyEWQ23KRdW+xCbeK24q8z
         OjDswGQuIuvv58fYY3bbSE6djrFciRlKGZIrONwLBhBhquRajAgPXKVAIhnga4YO3S/i
         Q98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751293650; x=1751898450;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jA1+PqXVtq5JGGyS5bMqoIcyAvEWva/WB/dyQOqqHmU=;
        b=tvBKhGeFKnU84HFRmRhB9GM3zHV3LuEW34uP71UVQTlpBm9MlFJ/G5bNqBYff4HB5C
         5H0IkY88Mr0jYRW0CYgW3I4buc+wNu40TI+qQm5R0Sz7WSHHISjiVilJmh5tro6fg+nG
         QuA7z+jzdHo9CZ1TqxrOxFkLC2v+mXNxuK7BheWGHnhiu9oXwbJv/MC5te4jTbKjIF81
         s/z07KONqhTxDyM+kcaz30YqgE6g3liO1nz0apYNd19pLLjya7gio1AtPCWzcWzvsUC7
         2fl79d2n5srYvOs+Ji65L9iek8eqGihXO7y4poqBKzMKpdRg0FC3hAMPOK+IH1e9irR6
         rnVw==
X-Forwarded-Encrypted: i=1; AJvYcCUUwePlQNxSk1NDCKi7+lgckuhfY1mC4+7by9Z2rYCBpEshDFT+SwtkLOtDYXIb6X5jBm/5AwxTKsYTgkyu@vger.kernel.org
X-Gm-Message-State: AOJu0YzWwMFh329ajdH1ZamLic14XOUc2EigDKFQuo8aoTFtLFuQe+pw
	3Eaz60T32nuHt+z9leGcXQhc1oxtt7x8CbG3ClJHJHpuF+jPtkOKbo2WELxgB9TR9twKl498y8D
	x9S0P5Wbza7Ilcg==
X-Google-Smtp-Source: AGHT+IGBSz5ftj1hVRQWPOaVGaFLmn6ZsnaOVoP8vhVwAtD0CuhsE+mmDdNHq577mQqHbTmGbmGPqxLU19jd1Q==
X-Received: from wmbay32.prod.google.com ([2002:a05:600c:1e20:b0:453:910:1a18])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c10c:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-4538ef7f8d3mr97825305e9.7.1751293649607;
 Mon, 30 Jun 2025 07:27:29 -0700 (PDT)
Date: Mon, 30 Jun 2025 15:27:02 +0100
In-Reply-To: <CAGvU0HkKacQKB1q9NWcqChLGoMB+1vu9UdqYc+tBRbTTc3++GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630142713.1816049-1-gprocida@google.com>
Subject: [PATCH] gendwarfksyms: use preferred form of sizeof for allocation
From: Giuliano Procida <gprocida@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Giuliano Procida <gprocida@google.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The preferred form is to supply the variable being allocated to rather
than an explicit type name which might become stale.

Also do this for memset and qsort arguments.

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 scripts/gendwarfksyms/cache.c   | 2 +-
 scripts/gendwarfksyms/die.c     | 4 ++--
 scripts/gendwarfksyms/dwarf.c   | 2 +-
 scripts/gendwarfksyms/kabi.c    | 2 +-
 scripts/gendwarfksyms/symbols.c | 2 +-
 scripts/gendwarfksyms/types.c   | 8 ++++----
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/gendwarfksyms/cache.c b/scripts/gendwarfksyms/cache.c
index c9c19b86a686..1c640db93db3 100644
--- a/scripts/gendwarfksyms/cache.c
+++ b/scripts/gendwarfksyms/cache.c
@@ -15,7 +15,7 @@ void cache_set(struct cache *cache, unsigned long key, int value)
 {
 	struct cache_item *ci;
 
-	ci = xmalloc(sizeof(struct cache_item));
+	ci = xmalloc(sizeof(*ci));
 	ci->key = key;
 	ci->value = value;
 	hash_add(cache->cache, &ci->hash, hash_32(key));
diff --git a/scripts/gendwarfksyms/die.c b/scripts/gendwarfksyms/die.c
index 6183bbbe7b54..052f7a3f975a 100644
--- a/scripts/gendwarfksyms/die.c
+++ b/scripts/gendwarfksyms/die.c
@@ -33,7 +33,7 @@ static struct die *create_die(Dwarf_Die *die, enum die_state state)
 {
 	struct die *cd;
 
-	cd = xmalloc(sizeof(struct die));
+	cd = xmalloc(sizeof(*cd));
 	init_die(cd);
 	cd->addr = (uintptr_t)die->addr;
 
@@ -123,7 +123,7 @@ static struct die_fragment *append_item(struct die *cd)
 {
 	struct die_fragment *df;
 
-	df = xmalloc(sizeof(struct die_fragment));
+	df = xmalloc(sizeof(*df));
 	df->type = FRAGMENT_EMPTY;
 	list_add_tail(&df->list, &cd->fragments);
 	return df;
diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 13ea7bf1ae7d..3538a7d9cb07 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -634,7 +634,7 @@ static int get_union_kabi_status(Dwarf_Die *die, Dwarf_Die *placeholder,
 	 * Note that the user of this feature is responsible for ensuring
 	 * that the structure actually remains ABI compatible.
 	 */
-	memset(&state.kabi, 0, sizeof(struct kabi_state));
+	memset(&state.kabi, 0, sizeof(state.kabi));
 
 	res = checkp(process_die_container(&state, NULL, die,
 					   check_union_member_kabi_status,
diff --git a/scripts/gendwarfksyms/kabi.c b/scripts/gendwarfksyms/kabi.c
index b3ade713778f..e3c2a3ccf51a 100644
--- a/scripts/gendwarfksyms/kabi.c
+++ b/scripts/gendwarfksyms/kabi.c
@@ -228,7 +228,7 @@ void kabi_read_rules(int fd)
 		if (type == KABI_RULE_TYPE_UNKNOWN)
 			error("unsupported kABI rule type: '%s'", field);
 
-		rule = xmalloc(sizeof(struct rule));
+		rule = xmalloc(sizeof(*rule));
 
 		rule->type = type;
 		rule->target = xstrdup(get_rule_field(&rule_str, &left));
diff --git a/scripts/gendwarfksyms/symbols.c b/scripts/gendwarfksyms/symbols.c
index 327f87389c34..35ed594f0749 100644
--- a/scripts/gendwarfksyms/symbols.c
+++ b/scripts/gendwarfksyms/symbols.c
@@ -146,7 +146,7 @@ void symbol_read_exports(FILE *file)
 			continue;
 		}
 
-		sym = xcalloc(1, sizeof(struct symbol));
+		sym = xcalloc(1, sizeof(*sym));
 		sym->name = name;
 		sym->addr.section = SHN_UNDEF;
 		sym->state = SYMBOL_UNPROCESSED;
diff --git a/scripts/gendwarfksyms/types.c b/scripts/gendwarfksyms/types.c
index 51c1471e8684..9c3b053bf061 100644
--- a/scripts/gendwarfksyms/types.c
+++ b/scripts/gendwarfksyms/types.c
@@ -45,7 +45,7 @@ static int type_list_append(struct list_head *list, const char *s, void *owned)
 	if (!s)
 		return 0;
 
-	entry = xmalloc(sizeof(struct type_list_entry));
+	entry = xmalloc(sizeof(*entry));
 	entry->str = s;
 	entry->owned = owned;
 	list_add_tail(&entry->list, list);
@@ -122,7 +122,7 @@ static struct type_expansion *type_map_add(const char *name,
 	struct type_expansion *e;
 
 	if (__type_map_get(name, &e)) {
-		e = xmalloc(sizeof(struct type_expansion));
+		e = xmalloc(sizeof(*e));
 		type_expansion_init(e);
 		e->name = xstrdup(name);
 
@@ -202,11 +202,11 @@ static void type_map_write(FILE *file)
 
 	hash_for_each_safe(type_map, e, tmp, hash)
 		++count;
-	es = xmalloc(count * sizeof(struct type_expansion *));
+	es = xmalloc(count * sizeof(*es));
 	hash_for_each_safe(type_map, e, tmp, hash)
 		es[i++] = e;
 
-	qsort(es, count, sizeof(struct type_expansion *), cmp_expansion_name);
+	qsort(es, count, sizeof(*es), cmp_expansion_name);
 
 	for (i = 0; i < count; ++i) {
 		checkp(fputs(es[i]->name, file));
-- 
2.50.0.727.gbf7dc18ff4-goog

