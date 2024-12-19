Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D01FDE29
	for <linux-modules@vger.kernel.org>; Thu, 19 Dec 2024 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734642493; cv=none; b=Kv4goSSeIbmG3mb9WK74sheSJcKRd+Ink0/RADRZJ0pbQfqcqsFSctDTM9L1/7IqMfboRSCvurvPJb3IwgWIls9q10PLapE9nmsD3Osaie+OW6dWPPyGEAwqYVVLH0lsCPIYcOaj9DxLdHT+HPzDEO/x/df5lRfQnHpRbnwY3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734642493; c=relaxed/simple;
	bh=QbryxAaCawxBZfMRQq7TBeM1EywZwyCC1hWjsgkRH/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nc706BR7OgJJDDLHmzkL8DLhhaMmZVgpIM9wLH534lPc/TaVjByaGsTGHGnMjxerooWaW4Z8CCjWWBLyT5tVYYUFHK+BnBmgfHifITOply2/shpUu69J2SB1HApvr2sfUS3qP/NqW3QXyCAw7CR7uBrfpsdl3wMoyWoo1BwHY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gYEcx0Wh; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYEcx0Wh"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-801d5add29eso801050a12.3
        for <linux-modules@vger.kernel.org>; Thu, 19 Dec 2024 13:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734642490; x=1735247290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zls+2kQ0MueTIF/Klfb6OSdTqOjwM1Bn5x2gnO5coH4=;
        b=gYEcx0WhHeWLF/TvWGDq/Fof7e1QTrGZeazeAmUA/h78NZBDoJsEhAXKocIHoESIz8
         VuxXpBCr362MMoIRLYFwLNmwDxBnb4avsJxe+ObsxjhV/sMX52jHw6J0YqhgeTrpyEAg
         EI3ltJPthSP8OaH616yBYHpjg3fYIjkc1gcuWr5xEAkjQfRpBRIz/GExstTRbN211CcZ
         nmkHW/JBqgK5mrjrUhl/QRmhpO9qNgHryB9GP+LCcEJWge6vx/pUkUpfzZD+GEHGaLzq
         K1DOCgiKcHdFUuPiaOm++XikP4J932ARqJVU5MNuHltCX1tmIGLkKmZyn1oKRm6r1LdC
         SCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734642490; x=1735247290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zls+2kQ0MueTIF/Klfb6OSdTqOjwM1Bn5x2gnO5coH4=;
        b=vVVdRoCUFSLgG+yafMFjxNzKzPjKBGlEIgnONvFRKEtTpjY4/1N3CJ5/TxU7PDK+jD
         r3dBjNunU4PVmXs8bu615zLTvFyEfjhNETdzSucdWFPdZ6B7bCPnaSqm8LOAQFSLeolO
         X6Uk5cQSKMpQoJ4z9KIedubicU0iNQwPXVYCTMBy4b/JRUbSYqr/Zuy53cmUWcVYTL4M
         DoskDqD7qssgLC0LiF6NnqQKvUFI8EO0FGxNO8RJBxMzBZY0NjnJ8WhesFPKMItZXTJ8
         RMd0oF6U6SxBmw11NYf/UquDq8xQs3ZE4Vs+izCbv2KCnX0CwOXT9d0ZV1dzV7f8IFrP
         lVsA==
X-Forwarded-Encrypted: i=1; AJvYcCUESoZ+DCkCy3/bcR53Udw9DSMzwWozKSjq4WtozjD2XoERfLqGA9QEPbd0J3EvN3dkbPPVrRdq61cq4fo0@vger.kernel.org
X-Gm-Message-State: AOJu0YxXA885YSiEyNj7rSDiqo2d2zfqZ1vpdrov4Fxd4ruYUzsCU8hd
	QhhTXDR+c9Qbfh4qEXCw44dDWnI84AtdLF8LKA8lXzE/Y6ScxRZHN7EnNlhRnTCjyOkk5HZujuX
	1DBgMaROQO9RVHEvfc1L4vbpcPg==
X-Google-Smtp-Source: AGHT+IFH+9afOGlxylZhHE1k+fERcM66+sdoH8sF6V9jFmEpMxL9JVsGX5eicBVFC+xXT/v7Typ9iXR4yCcVLImIn1Y=
X-Received: from pfbcw25.prod.google.com ([2002:a05:6a00:4519:b0:727:3c81:f42a])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:33a6:b0:1e5:c43f:f36d with SMTP id adf61e73a8af0-1e5e046189cmr865018637.18.1734642489781;
 Thu, 19 Dec 2024 13:08:09 -0800 (PST)
Date: Thu, 19 Dec 2024 21:07:49 +0000
In-Reply-To: <20241219210736.2990838-20-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241219210736.2990838-20-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=12931; i=samitolvanen@google.com;
 h=from:subject; bh=QbryxAaCawxBZfMRQq7TBeM1EywZwyCC1hWjsgkRH/c=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOkp3XJSZZyG0Wuus1qsmPZEUPhhv0XL871W6zbExiz9z
 q1jve1HRykLgxgHg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZhIZiwjw56T6lkz/nzqTJyb
 3pb5489WFpmld5OOJiW/VLLZblfQJMXI8H9FYp+e5m/ubwYlT43XHJ7iuJuzIH+/X1V4vk7ZoSo 2TgA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241219210736.2990838-32-samitolvanen@google.com>
Subject: [PATCH v7 12/18] gendwarfksyms: Add symbol versioning
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Calculate symbol versions from the fully expanded type strings in
type_map, and output the versions in a genksyms-compatible format.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/gendwarfksyms/Makefile        |   2 +-
 scripts/gendwarfksyms/dwarf.c         |  25 +++++-
 scripts/gendwarfksyms/gendwarfksyms.c |  10 ++-
 scripts/gendwarfksyms/gendwarfksyms.h |  13 ++-
 scripts/gendwarfksyms/symbols.c       |  53 +++++++++++
 scripts/gendwarfksyms/types.c         | 122 +++++++++++++++++++++++++-
 6 files changed, 216 insertions(+), 9 deletions(-)

diff --git a/scripts/gendwarfksyms/Makefile b/scripts/gendwarfksyms/Makefile
index 6540282dc746..e889b958957b 100644
--- a/scripts/gendwarfksyms/Makefile
+++ b/scripts/gendwarfksyms/Makefile
@@ -8,4 +8,4 @@ gendwarfksyms-objs += dwarf.o
 gendwarfksyms-objs += symbols.o
 gendwarfksyms-objs += types.o
 
-HOSTLDLIBS_gendwarfksyms := -ldw -lelf
+HOSTLDLIBS_gendwarfksyms := -ldw -lelf -lz
diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index a9966a23167a..bdf899d60707 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -740,12 +740,33 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 /*
  * Exported symbol processing
  */
+static struct die *get_symbol_cache(struct state *state, Dwarf_Die *die)
+{
+	struct die *cache;
+
+	cache = die_map_get(die, DIE_SYMBOL);
+
+	if (cache->state != DIE_INCOMPLETE)
+		return NULL; /* We already processed a symbol for this DIE */
+
+	cache->tag = dwarf_tag(die);
+	return cache;
+}
+
 static void process_symbol(struct state *state, Dwarf_Die *die,
 			   die_callback_t process_func)
 {
+	struct die *cache;
+
+	symbol_set_die(state->sym, die);
+
+	cache = get_symbol_cache(state, die);
+	if (!cache)
+		return;
+
 	debug("%s", state->sym->name);
-	check(process_func(state, NULL, die));
-	state->sym->state = SYMBOL_MAPPED;
+	check(process_func(state, cache, die));
+	cache->state = DIE_SYMBOL;
 	if (dump_dies)
 		fputs("\n", stderr);
 }
diff --git a/scripts/gendwarfksyms/gendwarfksyms.c b/scripts/gendwarfksyms/gendwarfksyms.c
index 76a38b733ad2..fd2429ea198f 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.c
+++ b/scripts/gendwarfksyms/gendwarfksyms.c
@@ -23,6 +23,8 @@ int dump_dies;
 int dump_die_map;
 /* Print out type strings (i.e. type_map) */
 int dump_types;
+/* Print out expanded type strings used for symbol versions */
+int dump_versions;
 /* Write a symtypes file */
 int symtypes;
 static const char *symtypes_file;
@@ -35,6 +37,7 @@ static void usage(void)
 	      "      --dump-dies      Dump DWARF DIE contents\n"
 	      "      --dump-die-map   Print debugging information about die_map changes\n"
 	      "      --dump-types     Dump type strings\n"
+	      "      --dump-versions  Dump expanded type strings used for symbol versions\n"
 	      "  -T, --symtypes file  Write a symtypes file\n"
 	      "  -h, --help           Print this message\n"
 	      "\n",
@@ -69,9 +72,10 @@ static int process_module(Dwfl_Module *mod, void **userdata, const char *name,
 	} while (cu);
 
 	/*
-	 * Use die_map to expand type strings and write them to `symfile`.
+	 * Use die_map to expand type strings, write them to `symfile`, and
+	 * calculate symbol versions.
 	 */
-	generate_symtypes(symfile);
+	generate_symtypes_and_versions(symfile);
 	die_map_free();
 
 	return DWARF_CB_OK;
@@ -92,6 +96,7 @@ int main(int argc, char **argv)
 				 { "dump-dies", 0, &dump_dies, 1 },
 				 { "dump-die-map", 0, &dump_die_map, 1 },
 				 { "dump-types", 0, &dump_types, 1 },
+				 { "dump-versions", 0, &dump_versions, 1 },
 				 { "symtypes", 1, NULL, 'T' },
 				 { "help", 0, NULL, 'h' },
 				 { 0, 0, NULL, 0 } };
@@ -164,6 +169,7 @@ int main(int argc, char **argv)
 	if (symfile)
 		check(fclose(symfile));
 
+	symbol_print_versions();
 	symbol_free();
 
 	return 0;
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 98d5b2315f21..203534abcd35 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -23,6 +23,7 @@ extern int debug;
 extern int dump_dies;
 extern int dump_die_map;
 extern int dump_types;
+extern int dump_versions;
 extern int symtypes;
 
 /*
@@ -95,6 +96,7 @@ static inline unsigned int addr_hash(uintptr_t addr)
 enum symbol_state {
 	SYMBOL_UNPROCESSED,
 	SYMBOL_MAPPED,
+	SYMBOL_PROCESSED
 };
 
 struct symbol_addr {
@@ -109,6 +111,7 @@ struct symbol {
 	struct hlist_node name_hash;
 	enum symbol_state state;
 	uintptr_t die_addr;
+	unsigned long crc;
 };
 
 typedef void (*symbol_callback_t)(struct symbol *, void *arg);
@@ -116,6 +119,10 @@ typedef void (*symbol_callback_t)(struct symbol *, void *arg);
 void symbol_read_exports(FILE *file);
 void symbol_read_symtab(int fd);
 struct symbol *symbol_get(const char *name);
+void symbol_set_die(struct symbol *sym, Dwarf_Die *die);
+void symbol_set_crc(struct symbol *sym, unsigned long crc);
+void symbol_for_each(symbol_callback_t func, void *arg);
+void symbol_print_versions(void);
 void symbol_free(void);
 
 /*
@@ -126,7 +133,8 @@ enum die_state {
 	DIE_INCOMPLETE,
 	DIE_UNEXPANDED,
 	DIE_COMPLETE,
-	DIE_LAST = DIE_COMPLETE
+	DIE_SYMBOL,
+	DIE_LAST = DIE_SYMBOL
 };
 
 enum die_fragment_type {
@@ -156,6 +164,7 @@ static inline const char *die_state_name(enum die_state state)
 	CASE_CONST_TO_STR(DIE_INCOMPLETE)
 	CASE_CONST_TO_STR(DIE_UNEXPANDED)
 	CASE_CONST_TO_STR(DIE_COMPLETE)
+	CASE_CONST_TO_STR(DIE_SYMBOL)
 	}
 
 	error("unexpected die_state: %d", state);
@@ -252,6 +261,6 @@ void process_cu(Dwarf_Die *cudie);
  * types.c
  */
 
-void generate_symtypes(FILE *file);
+void generate_symtypes_and_versions(FILE *file);
 
 #endif /* __GENDWARFKSYMS_H */
diff --git a/scripts/gendwarfksyms/symbols.c b/scripts/gendwarfksyms/symbols.c
index 0d2ce7284a53..4c499ba6c86d 100644
--- a/scripts/gendwarfksyms/symbols.c
+++ b/scripts/gendwarfksyms/symbols.c
@@ -66,6 +66,36 @@ static unsigned int for_each(const char *name, symbol_callback_t func,
 	return 0;
 }
 
+static void set_crc(struct symbol *sym, void *data)
+{
+	unsigned long *crc = data;
+
+	if (sym->state == SYMBOL_PROCESSED && sym->crc != *crc)
+		warn("overriding version for symbol %s (crc %lx vs. %lx)",
+		     sym->name, sym->crc, *crc);
+
+	sym->state = SYMBOL_PROCESSED;
+	sym->crc = *crc;
+}
+
+void symbol_set_crc(struct symbol *sym, unsigned long crc)
+{
+	if (for_each(sym->name, set_crc, &crc) == 0)
+		error("no matching symbols: '%s'", sym->name);
+}
+
+static void set_die(struct symbol *sym, void *data)
+{
+	sym->die_addr = (uintptr_t)((Dwarf_Die *)data)->addr;
+	sym->state = SYMBOL_MAPPED;
+}
+
+void symbol_set_die(struct symbol *sym, Dwarf_Die *die)
+{
+	if (for_each(sym->name, set_die, die) == 0)
+		error("no matching symbols: '%s'", sym->name);
+}
+
 static bool is_exported(const char *name)
 {
 	return for_each(name, NULL, NULL) > 0;
@@ -120,6 +150,16 @@ struct symbol *symbol_get(const char *name)
 	return sym;
 }
 
+void symbol_for_each(symbol_callback_t func, void *arg)
+{
+	struct hlist_node *tmp;
+	struct symbol *sym;
+
+	hash_for_each_safe(symbol_names, sym, tmp, name_hash) {
+		func(sym, arg);
+	}
+}
+
 typedef void (*elf_symbol_callback_t)(const char *name, GElf_Sym *sym,
 				      Elf32_Word xndx, void *arg);
 
@@ -246,6 +286,19 @@ void symbol_read_symtab(int fd)
 	elf_for_each_global(fd, elf_set_symbol_addr, NULL);
 }
 
+void symbol_print_versions(void)
+{
+	struct hlist_node *tmp;
+	struct symbol *sym;
+
+	hash_for_each_safe(symbol_names, sym, tmp, name_hash) {
+		if (sym->state != SYMBOL_PROCESSED)
+			warn("no information for symbol %s", sym->name);
+
+		printf("#SYMVER %s 0x%08lx\n", sym->name, sym->crc);
+	}
+}
+
 void symbol_free(void)
 {
 	struct hlist_node *tmp;
diff --git a/scripts/gendwarfksyms/types.c b/scripts/gendwarfksyms/types.c
index 21d7a34228eb..6c03265f4d10 100644
--- a/scripts/gendwarfksyms/types.c
+++ b/scripts/gendwarfksyms/types.c
@@ -6,6 +6,7 @@
 #define _GNU_SOURCE
 #include <inttypes.h>
 #include <stdio.h>
+#include <zlib.h>
 
 #include "gendwarfksyms.h"
 
@@ -178,6 +179,33 @@ static void type_map_free(void)
 	hash_init(type_map);
 }
 
+/*
+ * CRC for a type, with an optional fully expanded type string for
+ * debugging.
+ */
+struct version {
+	struct type_expansion type;
+	unsigned long crc;
+};
+
+static void version_init(struct version *version)
+{
+	version->crc = crc32(0, NULL, 0);
+	type_expansion_init(&version->type);
+}
+
+static void version_free(struct version *version)
+{
+	type_expansion_free(&version->type);
+}
+
+static void version_add(struct version *version, const char *s)
+{
+	version->crc = crc32(version->crc, (void *)s, strlen(s));
+	if (dump_versions)
+		type_expansion_append(&version->type, s, NULL);
+}
+
 /*
  * Type reference format: <prefix>#<name>, where prefix:
  * 	s -> structure
@@ -187,6 +215,12 @@ static void type_map_free(void)
  *
  * Names with spaces are additionally wrapped in single quotes.
  */
+static inline bool is_type_prefix(const char *s)
+{
+	return (s[0] == 's' || s[0] == 'u' || s[0] == 'e' || s[0] == 't') &&
+	       s[1] == '#';
+}
+
 static char get_type_prefix(int tag)
 {
 	switch (tag) {
@@ -214,6 +248,8 @@ static char *get_type_name(struct die *cache)
 		warn("found incomplete cache entry: %p", cache);
 		return NULL;
 	}
+	if (cache->state == DIE_SYMBOL)
+		return NULL;
 	if (!cache->fqn || !*cache->fqn)
 		return NULL;
 
@@ -231,6 +267,39 @@ static char *get_type_name(struct die *cache)
 	return name;
 }
 
+static void __calculate_version(struct version *version, struct list_head *list)
+{
+	struct type_list_entry *entry;
+	struct type_expansion *e;
+
+	/* Calculate a CRC over an expanded type string */
+	list_for_each_entry(entry, list, list) {
+		if (is_type_prefix(entry->str)) {
+			check(type_map_get(entry->str, &e));
+
+			/*
+			 * It's sufficient to expand each type reference just
+			 * once to detect changes.
+			 */
+			if (cache_was_expanded(&expansion_cache, e)) {
+				version_add(version, entry->str);
+			} else {
+				cache_mark_expanded(&expansion_cache, e);
+				__calculate_version(version, &e->expanded);
+			}
+		} else {
+			version_add(version, entry->str);
+		}
+	}
+}
+
+static void calculate_version(struct version *version, struct list_head *list)
+{
+	version_init(version);
+	__calculate_version(version, list);
+	cache_free(&expansion_cache);
+}
+
 static void __type_expand(struct die *cache, struct type_expansion *type,
 			  bool recursive);
 
@@ -337,7 +406,49 @@ static void expand_type(struct die *cache, void *arg)
 	free(name);
 }
 
-void generate_symtypes(FILE *file)
+static void expand_symbol(struct symbol *sym, void *arg)
+{
+	struct type_expansion type;
+	struct version version;
+	struct die *cache;
+
+	/*
+	 * No need to expand again unless we want a symtypes file entry
+	 * for the symbol. Note that this means `sym` has the same address
+	 * as another symbol that was already processed.
+	 */
+	if (!symtypes && sym->state == SYMBOL_PROCESSED)
+		return;
+
+	if (__die_map_get(sym->die_addr, DIE_SYMBOL, &cache))
+		return; /* We'll warn about missing CRCs later. */
+
+	type_expand(cache, &type, false);
+
+	/* If the symbol already has a version, don't calculate it again. */
+	if (sym->state != SYMBOL_PROCESSED) {
+		calculate_version(&version, &type.expanded);
+		symbol_set_crc(sym, version.crc);
+		debug("%s = %lx", sym->name, version.crc);
+
+		if (dump_versions) {
+			checkp(fputs(sym->name, stderr));
+			checkp(fputs(" ", stderr));
+			type_list_write(&version.type.expanded, stderr);
+			checkp(fputs("\n", stderr));
+		}
+
+		version_free(&version);
+	}
+
+	/* These aren't needed in type_map unless we want a symtypes file. */
+	if (symtypes)
+		type_map_add(sym->name, &type);
+
+	type_expansion_free(&type);
+}
+
+void generate_symtypes_and_versions(FILE *file)
 {
 	cache_init(&expansion_cache);
 
@@ -355,7 +466,14 @@ void generate_symtypes(FILE *file)
 	die_map_for_each(expand_type, NULL);
 
 	/*
-	 *   2. If a symtypes file is requested, write type_map contents to
+	 *   2. For each exported symbol, expand the die_map type, and use
+	 *      type_map expansions to calculate a symbol version from the
+	 *      fully expanded type string.
+	 */
+	symbol_for_each(expand_symbol, NULL);
+
+	/*
+	 *   3. If a symtypes file is requested, write type_map contents to
 	 *      the file.
 	 */
 	type_map_write(file);
-- 
2.47.1.613.gc27f4b7a9f-goog

