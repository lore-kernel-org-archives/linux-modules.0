Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1441DF744
	for <linux-modules@vger.kernel.org>; Thu, 21 Nov 2024 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221784; cv=none; b=MmDuJEv++FOGU7idIIXGoy67RYsof63Ct3FmwSFG5yQ/1M/bNWWq0pPMsyZz8Yb06KxC0xx6iZsYLdUQtpZWunlNjbC+RBxNoK+IpRyK6el+UbP90ZoaFYtwmNF9R8JOsysiNmQ4t0g0fTc6j9/hpjnS61HPRQPjSgEZof3/wkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221784; c=relaxed/simple;
	bh=/hdGw2AMYmpvv/2VNqR8g2SLZ1yvF33svcNLehCNsFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G/CHhiUozYz7RVgEl1jd9GxoTeL6hCVPFmnZSWrropt7Oe/CVi0Nv0MQfpgK6b1hLNplzFIsv6NUybpuSJfHhW/QSENmCX2m1KM4k4BvWPUQKqgTX/X0Idkj4Y+xFrOfFRPe873aEZbNgBJDlYJC1DCondEWeyRb7bWAvZNNW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3+zDeRD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3+zDeRD"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ea3f3121c3so1335961a91.1
        for <linux-modules@vger.kernel.org>; Thu, 21 Nov 2024 12:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732221782; x=1732826582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGEg1qXK77lm4N1fnb9Y00A/EET9bECvkjvbo/F/zjw=;
        b=G3+zDeRD7vTFBZ1pzkX4aoalQKj6VD0pcjOVinlQsAPON7rEAPq16p3PqbCUcL9Tjg
         MWByM0uVF5M2dKrAr54juBQUYthj3+hiRDtEaDrfoevZXqnBrKhEhrP9PsH4sSYHxhJn
         nG2pGR3oY64WoXTaVPGtSwILF4cC+Db1Dft2oWFiSf68EnzGGD22RGSDoPYQoj9PP39f
         2ZktpQaqCv5Wx5TN7+1wuxRF6VDkuiRK39sVI0az27sJ7rwAApQf8A9qQfubKHvqa9TB
         pQGKYLUHzwnhT+9Bn2hQdLVhk1H8MH7/UjBWdFKBeJ6JiaFDx6hYjn02aNxw/NdxPvI9
         E/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221782; x=1732826582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGEg1qXK77lm4N1fnb9Y00A/EET9bECvkjvbo/F/zjw=;
        b=YVNiiLvov7UsqKlUUYFR54JvSQBdn28SdQHRBNllIaQJ8CwoF2ylG2PwTTI4Tbpc5A
         4SnhlrPpYE0fpLpGd/AWRvH05LSgMuK1ak9tZEIKNq8ki3wds8o0t03py5S9gSXSxZ0S
         M0c9cx64m/T6Mzmyfqf2PjANmD5D+Kkv2d0whMRYdnGS6XSK3iLLHO42Yw9epzTvVezW
         6xY098LcptOz4EWx/fcc7th06zsF0XCzUXmLaJWsw12xE1SRPQVyUCsgXpCRtbaRT0tr
         zfg75T8NTl48HAaFYXVT3SWj8EtU8ogqspkyFbukMNS0EYTDuBV2s4AAMjaOrk/uEXyH
         yEEg==
X-Forwarded-Encrypted: i=1; AJvYcCW7cHLoIKODT4CulbLifguNy8fPlCPTdtEf/0jeGyhPaSmVe/CIkZtFNRpPh2pUyrIasRSbaTJ7L3IvWRhI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyecl3JJ7gVfc+GSZTrFtFG8gz8KBr9eKDkG6kqCYQpV7Qy+vYO
	aIXqRb1LuA7BPSBGb4n3W+lr6YlR1sdtN+VD8Lg/aRAaAv5PiKyCExCQXBk8xUsWufPjENx+m9U
	ue2fwH1vGMbHHbw2ICYZhKv1JoA==
X-Google-Smtp-Source: AGHT+IHfwjcoY8jkfISWJK/O1nY0fH9JfL5LYeGGFHC4bx6+x3AmKF8Bm+QLBomODF7fBL2XX9uILvlwCN85kw1XO2g=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:90b:2784:b0:2e2:cc47:f1b7 with
 SMTP id 98e67ed59e1d1-2eb0e0169dcmr122a91.1.1732221781805; Thu, 21 Nov 2024
 12:43:01 -0800 (PST)
Date: Thu, 21 Nov 2024 20:42:36 +0000
In-Reply-To: <20241121204220.2378181-20-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121204220.2378181-20-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7893; i=samitolvanen@google.com;
 h=from:subject; bh=/hdGw2AMYmpvv/2VNqR8g2SLZ1yvF33svcNLehCNsFo=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOn2s03EM776qTVYfl7fUBawp22/UL8Ev/fBQ0uF3087U
 CwjVbGlo5SFQYyDQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAEwkzZGRYfbHhOXKl7XtJ875
 c0hk4hzDxn790p2+DqpLJjOt87tbu5+RYdYDhnlS2WWbVtR8+5RevbTwgwJzQ8ux3+uZV6toWuz 2YgUA
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121204220.2378181-35-samitolvanen@google.com>
Subject: [PATCH v6 15/18] gendwarfksyms: Add support for symbol type pointers
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
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/gendwarfksyms/dwarf.c              | 55 +++++++++++++++++++++-
 scripts/gendwarfksyms/examples/symbolptr.c | 33 +++++++++++++
 scripts/gendwarfksyms/gendwarfksyms.h      |  7 +++
 scripts/gendwarfksyms/symbols.c            | 27 +++++++++++
 4 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 scripts/gendwarfksyms/examples/symbolptr.c

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 2c96caf8d6e2..38842903f84b 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -1060,6 +1060,31 @@ static void process_variable(struct state *state, Dwarf_Die *die)
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
@@ -1083,7 +1108,9 @@ static int process_exported_symbols(struct state *unused, struct die *cache,
 
 		state_init(&state);
 
-		if (tag == DW_TAG_subprogram)
+		if (is_symbol_ptr(get_symbol_name(&state.die)))
+			save_symbol_ptr(&state);
+		else if (tag == DW_TAG_subprogram)
 			process_subprogram(&state, &state.die);
 		else
 			process_variable(&state, &state.die);
@@ -1096,10 +1123,36 @@ static int process_exported_symbols(struct state *unused, struct die *cache,
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
+	cache_free(&state.expansion_cache);
+}
+
 void process_cu(Dwarf_Die *cudie)
 {
 	check(process_die_container(NULL, NULL, cudie, process_exported_symbols,
 				    match_all));
 
+	symbol_for_each(process_symbol_ptr, dwarf_cu_getdwarf(cudie->cu));
+
 	cache_free(&srcfile_cache);
 }
diff --git a/scripts/gendwarfksyms/examples/symbolptr.c b/scripts/gendwarfksyms/examples/symbolptr.c
new file mode 100644
index 000000000000..88bc1bd60da8
--- /dev/null
+++ b/scripts/gendwarfksyms/examples/symbolptr.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Google LLC
+ *
+ * Example for symbol pointers. When compiled with Clang, gendwarfkyms
+ * uses a symbol pointer for `f`.
+ *
+ * $ clang -g -c examples/symbolptr.c -o examples/symbolptr.o
+ * $ echo -e "f\ng\np" | ./gendwarfksyms -d examples/symbolptr.o
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
+extern void f(unsigned int arg);
+void g(int *arg);
+void g(int *arg) {}
+
+struct s;
+extern struct s *p;
+
+__GENDWARFKSYMS_EXPORT(f);
+__GENDWARFKSYMS_EXPORT(g);
+__GENDWARFKSYMS_EXPORT(p);
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 5fd743108b6f..86b3a3f2f558 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -94,6 +94,10 @@ extern int symtypes;
  * symbols.c
  */
 
+/* See symbols.c:is_symbol_ptr */
+#define SYMBOL_PTR_PREFIX "__gendwarfksyms_ptr_"
+#define SYMBOL_PTR_PREFIX_LEN (sizeof(SYMBOL_PTR_PREFIX) - 1)
+
 static inline unsigned int addr_hash(uintptr_t addr)
 {
 	return hash_ptr((const void *)addr);
@@ -117,14 +121,17 @@ struct symbol {
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
index e0c9007f7250..e00c86fa0ba2 100644
--- a/scripts/gendwarfksyms/symbols.c
+++ b/scripts/gendwarfksyms/symbols.c
@@ -39,6 +39,20 @@ static unsigned int __for_each_addr(struct symbol *sym, symbol_callback_t func,
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
 static unsigned int for_each(const char *name, symbol_callback_t func,
 			     void *data)
 {
@@ -47,6 +61,8 @@ static unsigned int for_each(const char *name, symbol_callback_t func,
 
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
+	if (for_each(sym->name, set_ptr, ptr) == 0)
+		error("no matching symbols: '%s'", sym->name);
+}
+
 static void set_die(struct symbol *sym, void *data)
 {
 	sym->die_addr = (uintptr_t)((Dwarf_Die *)data)->addr;
-- 
2.47.0.371.ga323438b13-goog

