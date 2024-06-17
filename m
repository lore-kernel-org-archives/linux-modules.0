Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919519925C
	for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647127; cv=none; b=eS5lWc97fiXVc6xXGijf+HRijO97Evivo2EnI5Q4Q+qPqTfRS2frUZwIOWiTSlp298nqS8TC2PqsGfuh7mr2UmWO7sMUSHZFoVW0+LsV2jH5xC/ENo5bAXfFhoN+Vvk8Lik084gbxVPB4IxD8eLfh57uKolQmFHBkUAqygp5kW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647127; c=relaxed/simple;
	bh=5QGYkwk/E4Q6+rrK8r8Qc7nJUUivw+COjNp3jkT0e4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=roHdR2xu0W6qAFya0skwibJ31kU2+fdmS4xN4JXseQA6Qq4VEGnydSd/NkS/gmxIn46WiBHyJ/xxqxPaTkTQQwY3ZFqqCSDjPmOX/G3evZQ+bQYGIoN6Z0G33H3g+tcDGRqe53tw8TXDaie2HyKZqakA2pd+e6pCKh7VGb7OmnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iXz3uAKZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXz3uAKZ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f717559ed9so46009115ad.1
        for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718647125; x=1719251925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJS2qGel4yduzddYByEwVYwl3lRWbRkhbTBiPKp6MJw=;
        b=iXz3uAKZCrCWghYIvjohFkJ6vRF9lz1mbVCpSKEB/Tkp+JB9LPaZYzcMsL7mKGAYRl
         WvxeMng4y/EdAHiAjPYJj46V6IjNlpzhZeINF+LNYCDmCKZJRJeUYF4edSQzXaH4yfDe
         srvIKKq3QTxL6CE38KCpIjzQJoV9kpiNXb/mM20ncgDmg53MlWZ/11UIITMtSLMHYYaI
         w0JglBiHwF+1Nc2kB8/rQMt55UD7zpCs9G6HY19fT9vwHGw7DJvH8tDwxQmXvbSsHo9n
         ft4guXJuG9ZaXzgOv3/6HpOPQDC+ZWaXt+EG/WjKlKfqciI9wiXAws3TegOge6bbLLt/
         Y70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647125; x=1719251925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJS2qGel4yduzddYByEwVYwl3lRWbRkhbTBiPKp6MJw=;
        b=B8jVGlcMntMpYP1/jc5aqMA/smYHaQ786BWoGeI4z4d448MwP4IDZfSFh8QgfvXKBK
         6xAyD91/XYro/6hbyTtz1lH+IAvZ/4lWFoQtRb/hUsWSPq7xr9NhXc68vBLBAdhES77D
         ZF6BRGYzZIj1IgHgUBGntIFeLA1z25RjKQMGZewbxOfyy1LpjCZoyMFIHeuVTH2Q0yPJ
         w9qb0FQOD7jiaeVxqVlexIWszKdjcb1zpa0Ycd5pd/zQxT+bwBeksUrrZMfkptvX8DO6
         sT+Vzz+C0a26fF+/n0f/wus8j3wTpUnsGmftsuQP8/4hQOr/naz7u5L027diuf2/krvn
         YB5g==
X-Forwarded-Encrypted: i=1; AJvYcCVTAX4N/u0ZRhcvaWaeejPg0dUXbzb2jVvM/izrx2MBSXMMJxmPJTvYaFHM67K6dk2LlAQRptKg5/Yr0Bxw1yPsEnVPvrsE/FH11ToC4w==
X-Gm-Message-State: AOJu0YwHjBz+9v2Fio8UZaD5onNpNLRvC+OKpQ8sC1+v4GoNdhJVDxfh
	DSpA+NV5zshTxQDGseC7aN+6uq3ZiOhPPcUcZx4eB+n7S5a7qo5kjYQB09rzPGJHzBdimb3JdgA
	4FlR81hUMZa8p/9jgsMzXD5tATA==
X-Google-Smtp-Source: AGHT+IHKjC0CX34pVUQa0Y9ornsY1/i5bBR74aqDPFW/EAbpIF5+uvTPtCpotMJonL0QUGth2SATiIUukrIzaTeaK4E=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:e844:b0:1f7:1046:d68e with
 SMTP id d9443c01a7336-1f98b2219aamr78555ad.2.1718647125429; Mon, 17 Jun 2024
 10:58:45 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:58:30 +0000
In-Reply-To: <20240617175818.58219-17-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240617175818.58219-17-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7777; i=samitolvanen@google.com;
 h=from:subject; bh=5QGYkwk/E4Q6+rrK8r8Qc7nJUUivw+COjNp3jkT0e4c=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmcHk74/KgDUBKZV1popDzLuA1ek3BXMxcD3VZW
 UgpxTvuAOaJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZnB5OwAKCRBMtfaEi7xW
 7lHEDACSFEate7TcAPTNQ4VH8+1rvGKNRy8wDm6Wogha8iHjE2xIT43/mQo3hROAVqmGPCSkE32
 hkohns20j3NH5LfafCAGjKGhxZsbj45Kdn7AFuTSnkGtl4ECfEJey22w+/nuN3REdRqgxfmMkHI
 NlPZ5EjzUbkbYis2utWtxpYVZqbp5nJE84yxMyRcAZ4soi5urhHbrfrxkf+NE+c8HoXYktaPLev
 sEJaOA0fhjb4SPvjB/ka5gKBzKfXWhtd/+lOnlH1PSh6cjOSISo/iOFrILp2qDT+xtd39yc5JVI
 WXNeKbYAfsXjEYmgoQ12w9P2p+2o4gWQFk//vt6oHF0+l7cqKt+qZsUxSWqwhgedNuqak6mVZ+N
 +feeicpA/NEz1AYhDPAsC2ntCbFFkZkE7USv6x6bsQc4juevI35vYQkzYS4NWHyc114AxKA81pL 3i/wGpEEuPNREU6RybCZiSy0wP5sDp335z1IXSkf2s03lrV2NzbhcWlcqZVpQRbaXbv4U=
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617175818.58219-28-samitolvanen@google.com>
Subject: [PATCH 11/15] gendwarfksyms: Limit structure expansion
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Expand each structure type only once per exported symbol. This
is necessary to support self-referential structures, which would
otherwise result in infinite recursion. Expanding each structure type
just once is enough to catch ABI changes.

For pointers to structure types, limit expansion to three levels
inside the pointer. This should be plenty for catching ABI differences
and stops us from pulling in half the kernel for structs that contain
pointers to large structs like task_struct.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/gendwarfksyms/cache.c         | 49 ++++++++++++++++
 tools/gendwarfksyms/gendwarfksyms.h |  9 ++-
 tools/gendwarfksyms/types.c         | 87 ++++++++++++++++++++++++++---
 3 files changed, 136 insertions(+), 9 deletions(-)

diff --git a/tools/gendwarfksyms/cache.c b/tools/gendwarfksyms/cache.c
index 85a2adeb649d..1d6eb27d799d 100644
--- a/tools/gendwarfksyms/cache.c
+++ b/tools/gendwarfksyms/cache.c
@@ -158,3 +158,52 @@ int cache_add_die(struct cached_die *cd, Dwarf_Die *die)
 	ci->type = DIE;
 	return 0;
 }
+
+/* A list of structure types that were already expanded for the current symbol */
+struct expanded {
+	uintptr_t addr;
+	struct hlist_node hash;
+};
+
+/* die->addr -> struct expanded */
+DEFINE_HASHTABLE(expansion_cache, DIE_HASH_BITS);
+
+int cache_mark_expanded(Dwarf_Die *die)
+{
+	struct expanded *es;
+
+	es = malloc(sizeof(struct expanded));
+	if (!es) {
+		error("malloc failed");
+		return -1;
+	}
+
+	es->addr = (uintptr_t)die->addr;
+	hash_add(expansion_cache, &es->hash, es->addr);
+	return 0;
+}
+
+bool cache_was_expanded(Dwarf_Die *die)
+{
+	struct expanded *es;
+	uintptr_t addr = (uintptr_t)die->addr;
+
+	hash_for_each_possible(expansion_cache, es, hash, addr) {
+		if (es->addr == addr)
+			return true;
+	}
+
+	return false;
+}
+
+void cache_clear_expanded(void)
+{
+	struct hlist_node *tmp;
+	struct expanded *es;
+	int i;
+
+	hash_for_each_safe(expansion_cache, i, tmp, es, hash) {
+		free(es);
+	}
+	hash_init(expansion_cache);
+}
diff --git a/tools/gendwarfksyms/gendwarfksyms.h b/tools/gendwarfksyms/gendwarfksyms.h
index 4646eaf5c85e..568f3727017e 100644
--- a/tools/gendwarfksyms/gendwarfksyms.h
+++ b/tools/gendwarfksyms/gendwarfksyms.h
@@ -95,7 +95,7 @@ struct cached_item {
 	struct cached_item *next;
 };
 
-enum cached_die_state { INCOMPLETE, COMPLETE };
+enum cached_die_state { INCOMPLETE, UNEXPANDED, COMPLETE };
 
 struct cached_die {
 	enum cached_die_state state;
@@ -111,6 +111,10 @@ extern int cache_add_linebreak(struct cached_die *pd, int linebreak);
 extern int cache_add_die(struct cached_die *pd, Dwarf_Die *die);
 extern void cache_free(void);
 
+extern int cache_mark_expanded(Dwarf_Die *die);
+extern bool cache_was_expanded(Dwarf_Die *die);
+extern void cache_clear_expanded(void);
+
 /*
  * types.c
  */
@@ -120,6 +124,9 @@ struct state {
 	Dwarf *dbg;
 	struct symbol *sym;
 	Dwarf_Die origin;
+	unsigned int ptr_expansion_depth;
+	bool in_pointer_type;
+	bool expand;
 	unsigned long crc;
 };
 
diff --git a/tools/gendwarfksyms/types.c b/tools/gendwarfksyms/types.c
index fa74e6fc26e3..da3aa2ad9f57 100644
--- a/tools/gendwarfksyms/types.c
+++ b/tools/gendwarfksyms/types.c
@@ -381,14 +381,21 @@ static int __process_structure_type(struct state *state,
 	check(process(state, cache, " {"));
 	check(process_linebreak(cache, 1));
 
-	check(process_die_container(state, cache, die, process_func,
-				    match_func));
+	if (state->expand) {
+		check(cache_mark_expanded(die));
+		check(process_die_container(state, cache, die, process_func,
+					    match_func));
+	} else {
+		check(process(state, cache, "<unexpanded>"));
+	}
 
 	check(process_linebreak(cache, -1));
 	check(process(state, cache, "}"));
 
-	check(process_byte_size_attr(state, cache, die));
-	check(process_alignment_attr(state, cache, die));
+	if (state->expand) {
+		check(process_byte_size_attr(state, cache, die));
+		check(process_alignment_attr(state, cache, die));
+	}
 
 	return 0;
 }
@@ -475,9 +482,38 @@ static int process_cached(struct state *state, struct cached_die *cache,
 
 static void state_init(struct state *state)
 {
+	state->ptr_expansion_depth = 0;
+	state->in_pointer_type = false;
+	state->expand = true;
 	state->crc = 0xffffffff;
 }
 
+static void state_restore(struct state *state, struct state *saved)
+{
+	state->ptr_expansion_depth = saved->ptr_expansion_depth;
+	state->in_pointer_type = saved->in_pointer_type;
+	state->expand = saved->expand;
+}
+
+static void state_save(struct state *state, struct state *saved)
+{
+	state_restore(saved, state);
+}
+
+static bool is_pointer_type(int tag)
+{
+	return tag == DW_TAG_pointer_type || tag == DW_TAG_reference_type;
+}
+
+static bool is_expanded_type(int tag)
+{
+	return tag == DW_TAG_class_type || tag == DW_TAG_structure_type ||
+	       tag == DW_TAG_union_type || tag == DW_TAG_enumeration_type;
+}
+
+/* The maximum depth for expanding structures in pointers */
+#define MAX_POINTER_EXPANSION_DEPTH 3
+
 #define PROCESS_TYPE(type)                                       \
 	case DW_TAG_##type##_type:                               \
 		check(process_##type##_type(state, cache, die)); \
@@ -486,19 +522,52 @@ static void state_init(struct state *state)
 static int process_type(struct state *state, struct cached_die *parent,
 			Dwarf_Die *die)
 {
+	enum cached_die_state want_state = COMPLETE;
 	struct cached_die *cache = NULL;
+	struct state saved;
 	int tag = dwarf_tag(die);
 
+	state_save(state, &saved);
+
 	/*
-	 * If we have the DIE already cached, use it instead of walking
+	 * Structures and enumeration types are expanded only once per
+	 * exported symbol. This is sufficient for detecting ABI changes
+	 * within the structure.
+	 *
+	 * If the exported symbol contains a pointer to a structure,
+	 * at most MAX_POINTER_EXPANSION_DEPTH levels are expanded into
+	 * the referenced structure.
+	 */
+	state->in_pointer_type = saved.in_pointer_type || is_pointer_type(tag);
+
+	if (state->in_pointer_type &&
+	    state->ptr_expansion_depth >= MAX_POINTER_EXPANSION_DEPTH)
+		state->expand = false;
+	else
+		state->expand = saved.expand && !cache_was_expanded(die);
+
+	/* Keep track of pointer expansion depth */
+	if (state->expand && state->in_pointer_type && is_expanded_type(tag))
+		state->ptr_expansion_depth++;
+
+	/*
+	 * If we have want_state already cached, use it instead of walking
 	 * through DWARF.
 	 */
 	if (!no_cache) {
-		check(cache_get(die, COMPLETE, &cache));
+		if (!state->expand && is_expanded_type(tag))
+			want_state = UNEXPANDED;
+
+		check(cache_get(die, want_state, &cache));
+
+		if (cache->state == want_state) {
+			if (want_state == COMPLETE && is_expanded_type(tag))
+				check(cache_mark_expanded(die));
 
-		if (cache->state == COMPLETE) {
 			check(process_cached(state, cache, die));
 			check(cache_add_die(parent, die));
+
+			state_restore(state, &saved);
 			return 0;
 		}
 	}
@@ -540,10 +609,11 @@ static int process_type(struct state *state, struct cached_die *parent,
 
 	if (!no_cache) {
 		/* Update cache state and append to the parent (if any) */
-		cache->state = COMPLETE;
+		cache->state = want_state;
 		check(cache_add_die(parent, die));
 	}
 
+	state_restore(state, &saved);
 	return 0;
 }
 
@@ -596,6 +666,7 @@ static int process_exported_symbols(struct state *state,
 		else
 			check(process_variable(state, die));
 
+		cache_clear_expanded();
 		return check(
 			symbol_set_crc(state->sym, state->crc ^ 0xffffffff));
 	default:
-- 
2.45.2.627.g7a2c4fd464-goog

