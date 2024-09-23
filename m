Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F601A3AAB
	for <linux-modules@vger.kernel.org>; Mon, 23 Sep 2024 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115579; cv=none; b=jIOnG3hdrinuBCh7grtz7mpLugTU1MgOmNJKjkCH1XIaVVgllqK/m4L4/Gznb8tKFKwSx11O+QpthtSgcGxiohm7nRDFhCBZ6yxtG870pwWorr6Vq3KxdERZbLyPqbRA80bhcM4+JyKwR3jpW+UXwS+c7p8WOFLSSoMA1CsNyfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115579; c=relaxed/simple;
	bh=laL39BCEF1vO4bPX+whfqr94UBUcQ7hjGSB8gg4m9nA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dPOWG+P4k/zLQsZfaSno00Un8lw4lp08SCw1vaBQKeKyz0NLF4l7SmfAlP093eb01GPFqXettWAuvD17xt2yr3g93jWxHS262jCb1bP0oWqDwvny4GzZYeLDgc9VWE+f4nvZPDpFeBSCsQJe4YgV2yPW8xim5A9eh+GJus5Ye1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ri6gpi58; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ri6gpi58"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1dc0585fbfso6505823276.3
        for <linux-modules@vger.kernel.org>; Mon, 23 Sep 2024 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727115576; x=1727720376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kkPce0rZ8yrGArv9CTYYGTdGaCslopSteUVWh/sw0Jc=;
        b=Ri6gpi58TBoG5X1FIMhiodcXkZHh4eZaVklV08r+vajw+VEE0J0byWR3smK9RrUv7+
         hRhiu66PLhBGwl1pVr3yqrXvPZGrmbwIaAte05OMkgx5RqZFo705Tej4LQpassTu8RYg
         Uyz2nJe99yg69cqr2soENTow00KdotvCTO3kPDenO8uDLw1jM5XFNwUNIBXwxhVpQt+d
         USrI+4m+OnpbAfFaycUMyYiUFWxk0EggScDpwUtoY0ymqZMYtqBZm6WFnZl30j2vPZI+
         XoJ74wsr6hOHv/sdFzURIkZWT4fylsLmUR+cq+HF845LlYTD2cUPqOkEhG5OX0ROSBgS
         3kFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115576; x=1727720376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkPce0rZ8yrGArv9CTYYGTdGaCslopSteUVWh/sw0Jc=;
        b=SUMtXFUQoJoh5bFin0V52dj9J7DeIQ/7KU8fxi58MUzkvL3q1U1Fcaxo/xhGf5uV5i
         VQmtOYjgpF8I8S44TgI4kbaXqSx33sYRNAXtNtJU8DSfwaNGKS1dOqaFTUC3ruY7GGWa
         Vzl/EQ1oNDHbhe9m11Fb7e+M+LDTY0TwBqhmHJDwX+oRDU43G+sdZ7p4l54r26J0J7UM
         GRImiXjeqikrTQHsUsTsD7TithtajyiDYthLFlExQXjR4XpgPmaFOJQ+AIj+ynDBGBM9
         fXNbJ6OiPrGJOKTq42+6CaTsQbsoioVWUipU3sis3R80z6/jfo0MbBIEzR1Cs+AVaxvJ
         XX0w==
X-Forwarded-Encrypted: i=1; AJvYcCXw5Cjd2qMSWkP/TJ/YyB0zmacLuQQJsTGqVrQPfRPsIC3hWmNCyZiVWcGUq03UpMT+/Z9D+qxmpL/Kck3g@vger.kernel.org
X-Gm-Message-State: AOJu0YzHU0d+NRcjHtxF/uMKLJ/8kJMOCNFngGIP+P8MJrHr0bdc2CBH
	lxwKpWMkbPFn+yNo1LHAJnBjRqOugn7HjIcv/0J21v0mumm8ZMEBRPgKG+RLt2bOfcK8wT90XP0
	7GgSixetCRtsP73ge+8G/k8bH9g==
X-Google-Smtp-Source: AGHT+IFpJAOnY2xEvQeJy6OEMCEWO2JQSZDOv+6UB6KUd6XvMz5bKLXgxnuuCaeF+f8dJzr1U88mT4tMwf6IJJcQk20=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:68d:b0:e20:1596:87b8 with
 SMTP id 3f1490d57ef6-e2252fd9b4dmr122835276.11.1727115576387; Mon, 23 Sep
 2024 11:19:36 -0700 (PDT)
Date: Mon, 23 Sep 2024 18:19:03 +0000
In-Reply-To: <20240923181846.549877-22-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240923181846.549877-22-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7756; i=samitolvanen@google.com;
 h=from:subject; bh=laL39BCEF1vO4bPX+whfqr94UBUcQ7hjGSB8gg4m9nA=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDGkfN/L9rnt4ZUUhk7u+efx1UcVeU6XZL74WmFjocyg/1
 tH0aZ3aUcrCIMbBICumyNLydfXW3d+dUl99LpKAmcPKBDKEgYtTACYSasvI8E8m7WJ8zRduq89m
 Bl5c/w5bPPK87yBWs2f6r7U/Dj9ON2dkeD/JsmPW35cmORuEnU55Tal+Yjv/8l7xrTu2Lvhoen9 RIgcA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240923181846.549877-39-samitolvanen@google.com>
Subject: [PATCH v3 17/20] gendwarfksyms: Add support for symbol type pointers
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

The compiler may choose not to emit type information in DWARF for
external symbols. Clang, for example, does this for symbols not
defined in the current TU.

To provide a way to work around this issue, add support for
__gendwarfksyms_ptr_<symbol> pointers that force the compiler to emit
the necessary type information in DWARF also for the missing symbols.

Example usage:

  #define GENDWARFKSYMS_PTR(sym) \
      static typeof(sym) *__gendwarfksyms_ptr_##sym __used  \
          __section(".discard.gendwarfksyms") = &sym;

  extern int external_symbol(void);
  GENDWARFKSYMS_PTR(external_symbol);

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/gendwarfksyms/dwarf.c              | 55 +++++++++++++++++++++-
 scripts/gendwarfksyms/examples/symbolptr.c | 29 ++++++++++++
 scripts/gendwarfksyms/gendwarfksyms.h      |  7 +++
 scripts/gendwarfksyms/symbols.c            | 27 +++++++++++
 4 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 scripts/gendwarfksyms/examples/symbolptr.c

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index f11cafa69309..c2ce66e4e333 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -989,6 +989,31 @@ static void process_variable(struct state *state, Dwarf_Die *die)
 	process_symbol(state, die, __process_variable);
 }
 
+static void save_symbol_ptr(struct state *state)
+{
+	Dwarf_Die ptr_type;
+	Dwarf_Die type;
+
+	if (!get_ref_die_attr(&state->die, DW_AT_type, &ptr_type) ||
+	    dwarf_tag(&ptr_type) != DW_TAG_pointer_type)
+		error("%s must be a pointer type!",
+		      get_symbol_name(&state->die));
+
+	if (!get_ref_die_attr(&ptr_type, DW_AT_type, &type))
+		error("%s pointer missing a type attribute?",
+		      get_symbol_name(&state->die));
+
+	/*
+	 * Save the symbol pointer DIE in case the actual symbol is
+	 * missing from the DWARF. Clang, for example, intentionally
+	 * omits external symbols from the debugging information.
+	 */
+	if (dwarf_tag(&type) == DW_TAG_subroutine_type)
+		symbol_set_ptr(state->sym, &type);
+	else
+		symbol_set_ptr(state->sym, &ptr_type);
+}
+
 static int process_exported_symbols(struct state *unused, struct die *cache,
 				    Dwarf_Die *die)
 {
@@ -1012,7 +1037,9 @@ static int process_exported_symbols(struct state *unused, struct die *cache,
 
 		state_init(&state);
 
-		if (tag == DW_TAG_subprogram)
+		if (is_symbol_ptr(get_symbol_name(&state.die)))
+			save_symbol_ptr(&state);
+		else if (tag == DW_TAG_subprogram)
 			process_subprogram(&state, &state.die);
 		else
 			process_variable(&state, &state.die);
@@ -1025,8 +1052,34 @@ static int process_exported_symbols(struct state *unused, struct die *cache,
 	}
 }
 
+static void process_symbol_ptr(struct symbol *sym, void *arg)
+{
+	struct state state;
+	Dwarf *dwarf = arg;
+
+	if (sym->state != SYMBOL_UNPROCESSED || !sym->ptr_die_addr)
+		return;
+
+	debug("%s", sym->name);
+	state_init(&state);
+	state.sym = sym;
+
+	if (!dwarf_die_addr_die(dwarf, (void *)sym->ptr_die_addr, &state.die))
+		error("dwarf_die_addr_die failed for symbol ptr: '%s'",
+		      sym->name);
+
+	if (dwarf_tag(&state.die) == DW_TAG_subroutine_type)
+		process_subprogram(&state, &state.die);
+	else
+		process_variable(&state, &state.die);
+
+	cache_clear_expanded(&state.expansion_cache);
+}
+
 void process_cu(Dwarf_Die *cudie)
 {
 	check(process_die_container(NULL, NULL, cudie, process_exported_symbols,
 				    match_all));
+
+	symbol_for_each(process_symbol_ptr, dwarf_cu_getdwarf(cudie->cu));
 }
diff --git a/scripts/gendwarfksyms/examples/symbolptr.c b/scripts/gendwarfksyms/examples/symbolptr.c
new file mode 100644
index 000000000000..c808f07d8268
--- /dev/null
+++ b/scripts/gendwarfksyms/examples/symbolptr.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Google LLC
+ *
+ * Example for symbol pointers. When compiled with Clang, gendwarfkyms
+ * uses a symbol pointer for `f`.
+ *
+ * $ clang -g -c examples/symbolptr.c examples/symbolptr.o
+ * $ echo -e "f\ng" | ./gendwarfksyms -d examples/symbolptr.o
+ */
+
+/* Kernel macros for userspace testing. */
+#ifndef __used
+#define __used __attribute__((__used__))
+#endif
+#ifndef __section
+#define __section(section) __attribute__((__section__(section)))
+#endif
+
+#define __GENDWARFKSYMS_EXPORT(sym)				\
+	static typeof(sym) *__gendwarfksyms_ptr_##sym __used	\
+		__section(".discard.gendwarfksyms") = &sym;
+
+extern void f(int *arg);
+void g(int *arg);
+void g(int *arg) {}
+
+__GENDWARFKSYMS_EXPORT(f);
+__GENDWARFKSYMS_EXPORT(g);
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 7a927e55f567..b3bfb25d3313 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -92,6 +92,10 @@ extern int symtypes;
  * symbols.c
  */
 
+/* See symbols.c:is_symbol_ptr */
+#define SYMBOL_PTR_PREFIX "__gendwarfksyms_ptr_"
+#define SYMBOL_PTR_PREFIX_LEN (sizeof(SYMBOL_PTR_PREFIX) - 1)
+
 static inline unsigned int addr_hash(uintptr_t addr)
 {
 	return hash_ptr((const void *)addr);
@@ -115,14 +119,17 @@ struct symbol {
 	struct hlist_node name_hash;
 	enum symbol_state state;
 	uintptr_t die_addr;
+	uintptr_t ptr_die_addr;
 	unsigned long crc;
 };
 
 typedef void (*symbol_callback_t)(struct symbol *, void *arg);
 
+bool is_symbol_ptr(const char *name);
 void symbol_read_exports(FILE *file);
 void symbol_read_symtab(int fd);
 struct symbol *symbol_get(const char *name);
+void symbol_set_ptr(struct symbol *sym, Dwarf_Die *ptr);
 void symbol_set_die(struct symbol *sym, Dwarf_Die *die);
 void symbol_set_crc(struct symbol *sym, unsigned long crc);
 void symbol_for_each(symbol_callback_t func, void *arg);
diff --git a/scripts/gendwarfksyms/symbols.c b/scripts/gendwarfksyms/symbols.c
index 924f52ee4acd..5e6d3a62bdcf 100644
--- a/scripts/gendwarfksyms/symbols.c
+++ b/scripts/gendwarfksyms/symbols.c
@@ -39,6 +39,20 @@ static int __for_each_addr(struct symbol *sym, symbol_callback_t func,
 	return processed;
 }
 
+/*
+ * For symbols without debugging information (e.g. symbols defined in other
+ * TUs), we also match __gendwarfksyms_ptr_<symbol_name> symbols, which the
+ * kernel uses to ensure type information is present in the TU that exports
+ * the symbol. A __gendwarfksyms_ptr pointer must have the same type as the
+ * exported symbol, e.g.:
+ *
+ *   typeof(symname) *__gendwarf_ptr_symname = &symname;
+ */
+bool is_symbol_ptr(const char *name)
+{
+	return name && !strncmp(name, SYMBOL_PTR_PREFIX, SYMBOL_PTR_PREFIX_LEN);
+}
+
 static int for_each(const char *name, bool name_only, symbol_callback_t func,
 		    void *data)
 {
@@ -47,6 +61,8 @@ static int for_each(const char *name, bool name_only, symbol_callback_t func,
 
 	if (!name || !*name)
 		return 0;
+	if (is_symbol_ptr(name))
+		name += SYMBOL_PTR_PREFIX_LEN;
 
 	hash_for_each_possible_safe(symbol_names, match, tmp, name_hash,
 				    hash_str(name)) {
@@ -84,6 +100,17 @@ void symbol_set_crc(struct symbol *sym, unsigned long crc)
 		error("no matching symbols: '%s'", sym->name);
 }
 
+static void set_ptr(struct symbol *sym, void *data)
+{
+	sym->ptr_die_addr = (uintptr_t)((Dwarf_Die *)data)->addr;
+}
+
+void symbol_set_ptr(struct symbol *sym, Dwarf_Die *ptr)
+{
+	if (checkp(for_each(sym->name, false, set_ptr, ptr)) == 0)
+		error("no matching symbols: '%s'", sym->name);
+}
+
 static void set_die(struct symbol *sym, void *data)
 {
 	sym->die_addr = (uintptr_t)((Dwarf_Die *)data)->addr;
-- 
2.46.0.792.g87dc391469-goog

