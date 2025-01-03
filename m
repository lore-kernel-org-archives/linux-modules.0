Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3AD1BFE0C
	for <linux-modules@vger.kernel.org>; Fri,  3 Jan 2025 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735937143; cv=none; b=Lr9O66tAE4WzVDhzTVP36U4pNxThg+2XcVbqtGg0jhtXGr+bKqeusMg4lt249ni/nxSPh5G27Jbuq64PMmJ6TtBQKi+8NLNSopMfmX7+zCA4bKUCXknLs1/KxsiZYzUYOXDQxv806BwF+rzLy1fbdLEgTOEBmbpaeSvkYdi19Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735937143; c=relaxed/simple;
	bh=fzVr6fKgzEIFdsA0UPXmH/kse9QbLqY2nS3Tewl8NWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SBdkBv+49Dyo451HukmEXDkyENP0BO75YGbRjalanGYPyxlK0XZaQpIQv8fCKedFtU1xn4oaVtDy2iO4dRP3z9+RyrMm288K8UjPaKhfKXJiQACVMTMTr1cfCli+SSHdLOBxXlwB2iEdt/UPPz//V/WwN+cP8kL9xKXu14ZLUIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BLl2zajI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BLl2zajI"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so26104214a91.3
        for <linux-modules@vger.kernel.org>; Fri, 03 Jan 2025 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735937139; x=1736541939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zLpQS/gnu91PnGj0lISTgfkEEEKsnzRIWAV6qflhe7M=;
        b=BLl2zajI6cBi4SnB/4/NYYQAfTpP0pphLvm8YYN24qJei3jSIkzm0xQNqQbhY3YPDx
         I96yFC2yVTahvtAVvoMjkKuup7STcdYIGiUdc3Uk+hqkdZK+XT/9ZnjvC8o+asN3/5tc
         z3ZpMHCOgiPeheF97TdXPU2qwL/SzbWPOTpUzBY5s4URFUquAqoSI1nL9Bit7Fzoorgk
         SbmMGlLHnvYrlKipZVSAEBOqSqAPVtCy4VHnw52lZYUjsqPcxsZVo3lYASNlDp29AZGO
         SRN7s2DYVQRYAAkckpYmh4jIUx9eqIHKw72o9T7/t1xm8kIjNOWhpfufqr2OVIsgLXuu
         tqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735937139; x=1736541939;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLpQS/gnu91PnGj0lISTgfkEEEKsnzRIWAV6qflhe7M=;
        b=HZSL4olXqRsQXci1AvuJGia8kAW9UFMvBikIB1jbZrAVC7qQ0dpNmEf4j5lA/W2izc
         iiK8VoQt194tjGQOLNl8+srLndRIXjZc4G5n8nv6vEFy7yiUqNEQnh2LXpCxjpjqX0Xe
         uhpJznyDxNf13DXPDS69hwnruEEWbOlnRIzNS1j/0ix2tp2xu1oKE9Ik9ukQcQu9AAaQ
         bdPYbmrLr1Mim6SeN2aybbzdr643MGzy4eNG7USxUmWggKO7hPfsaJlFu+bwSE2swHUY
         KPonkDZurBVtYSMRwRuqEfeBiZsCsfbc62UvG4YNzPHOo8ITp7+P70Akx6I5meGEakX5
         OHQw==
X-Forwarded-Encrypted: i=1; AJvYcCUTJQ0Fvcb9mt4OUQXkWoqJzscBLSuQFuMQDQJ/y5ZA87yqVAcFHyF3R1NMS0RNI5J+QwMG8RM2s+80/iPr@vger.kernel.org
X-Gm-Message-State: AOJu0YxcBqwlyPyquWamZPrl4Oyl94fGh7daBfkldsF7TQCBWhXFSBVn
	+sOZzUemED1wWDfuiLtdQLxYDNdmbPIe1zfwpVDNrE0aIZdlIXiI0L4RVGokOKwbaGHit1v4DMB
	00r+6HJE8vo11Lhg+5EVTqG/t7g==
X-Google-Smtp-Source: AGHT+IGl2m3cfV3NcHN2pmSUPzbHYXMeL1GQeg153FdINlJb1CXi4JHEU0Jr2m5E4C1AlhmO4tCc0lI59vsX9oWlMck=
X-Received: from pfwy1.prod.google.com ([2002:a05:6a00:1c81:b0:727:3a40:52d7])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3994:b0:1e0:d867:c875 with SMTP id adf61e73a8af0-1e5e080ab04mr67786488637.36.1735937138689;
 Fri, 03 Jan 2025 12:45:38 -0800 (PST)
Date: Fri,  3 Jan 2025 20:45:24 +0000
In-Reply-To: <20250103204521.1885406-20-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250103204521.1885406-20-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7376; i=samitolvanen@google.com;
 h=from:subject; bh=fzVr6fKgzEIFdsA0UPXmH/kse9QbLqY2nS3Tewl8NWY=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOkVPkmKi7U3RycW7Oc3uZjhfHKvw9mfG+MOhb7ZH8axz
 0H4omBhRykLgxgHg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZgI2xmG/4UfWwXfXY42n3hF
 TmrnmldTP9bKZTvHf+yqurov+SBD3CaG/7HlabOMJ2b/ZTpkOC863lpJRzZ/h1PFRt7QW6kspw5 X8QMA
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250103204521.1885406-22-samitolvanen@google.com>
Subject: [PATCH v8 02/18] gendwarfksyms: Add address matching
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

The compiler may choose not to emit type information in DWARF for all
aliases, but it's possible for each alias to be exported separately.
To ensure we find type information for the aliases as well, read
{section, address} tuples from the symbol table and match symbols also
by address.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/gendwarfksyms/gendwarfksyms.c |   2 +
 scripts/gendwarfksyms/gendwarfksyms.h |  13 +++
 scripts/gendwarfksyms/symbols.c       | 161 ++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)

diff --git a/scripts/gendwarfksyms/gendwarfksyms.c b/scripts/gendwarfksyms/gendwarfksyms.c
index a1d13353c6bc..cd8bfe973a5c 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.c
+++ b/scripts/gendwarfksyms/gendwarfksyms.c
@@ -105,6 +105,8 @@ int main(int argc, char **argv)
 			error("open failed for '%s': %s", argv[n],
 			      strerror(errno));
 
+		symbol_read_symtab(fd);
+
 		dwfl = dwfl_begin(&callbacks);
 		if (!dwfl)
 			error("dwfl_begin failed for '%s': %s", argv[n],
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 5c8288c71fdd..cb9fd78a58da 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -63,14 +63,27 @@ extern int dump_dies;
  * symbols.c
  */
 
+static inline unsigned int addr_hash(uintptr_t addr)
+{
+	return hash_ptr((const void *)addr);
+}
+
+struct symbol_addr {
+	uint32_t section;
+	Elf64_Addr address;
+};
+
 struct symbol {
 	const char *name;
+	struct symbol_addr addr;
+	struct hlist_node addr_hash;
 	struct hlist_node name_hash;
 };
 
 typedef void (*symbol_callback_t)(struct symbol *, void *arg);
 
 void symbol_read_exports(FILE *file);
+void symbol_read_symtab(int fd);
 struct symbol *symbol_get(const char *name);
 void symbol_free(void);
 
diff --git a/scripts/gendwarfksyms/symbols.c b/scripts/gendwarfksyms/symbols.c
index 592eacf72694..98febb524dd5 100644
--- a/scripts/gendwarfksyms/symbols.c
+++ b/scripts/gendwarfksyms/symbols.c
@@ -7,9 +7,38 @@
 
 #define SYMBOL_HASH_BITS 12
 
+/* struct symbol_addr -> struct symbol */
+static HASHTABLE_DEFINE(symbol_addrs, 1 << SYMBOL_HASH_BITS);
 /* name -> struct symbol */
 static HASHTABLE_DEFINE(symbol_names, 1 << SYMBOL_HASH_BITS);
 
+static inline unsigned int symbol_addr_hash(const struct symbol_addr *addr)
+{
+	return hash_32(addr->section ^ addr_hash(addr->address));
+}
+
+static unsigned int __for_each_addr(struct symbol *sym, symbol_callback_t func,
+				    void *data)
+{
+	struct hlist_node *tmp;
+	struct symbol *match = NULL;
+	unsigned int processed = 0;
+
+	hash_for_each_possible_safe(symbol_addrs, match, tmp, addr_hash,
+				    symbol_addr_hash(&sym->addr)) {
+		if (match == sym)
+			continue; /* Already processed */
+
+		if (match->addr.section == sym->addr.section &&
+		    match->addr.address == sym->addr.address) {
+			func(match, data);
+			++processed;
+		}
+	}
+
+	return processed;
+}
+
 static unsigned int for_each(const char *name, symbol_callback_t func,
 			     void *data)
 {
@@ -24,9 +53,13 @@ static unsigned int for_each(const char *name, symbol_callback_t func,
 		if (strcmp(match->name, name))
 			continue;
 
+		/* Call func for the match, and all address matches */
 		if (func)
 			func(match, data);
 
+		if (match->addr.section != SHN_UNDEF)
+			return __for_each_addr(match, func, data) + 1;
+
 		return 1;
 	}
 
@@ -58,6 +91,7 @@ void symbol_read_exports(FILE *file)
 
 		sym = xcalloc(1, sizeof(struct symbol));
 		sym->name = name;
+		sym->addr.section = SHN_UNDEF;
 
 		hash_add(symbol_names, &sym->name_hash, hash_str(sym->name));
 		++nsym;
@@ -84,6 +118,132 @@ struct symbol *symbol_get(const char *name)
 	return sym;
 }
 
+typedef void (*elf_symbol_callback_t)(const char *name, GElf_Sym *sym,
+				      Elf32_Word xndx, void *arg);
+
+static void elf_for_each_global(int fd, elf_symbol_callback_t func, void *arg)
+{
+	size_t sym_size;
+	GElf_Shdr shdr_mem;
+	GElf_Shdr *shdr;
+	Elf_Data *xndx_data = NULL;
+	Elf_Scn *scn;
+	Elf *elf;
+
+	if (elf_version(EV_CURRENT) != EV_CURRENT)
+		error("elf_version failed: %s", elf_errmsg(-1));
+
+	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
+	if (!elf)
+		error("elf_begin failed: %s", elf_errmsg(-1));
+
+	scn = elf_nextscn(elf, NULL);
+
+	while (scn) {
+		shdr = gelf_getshdr(scn, &shdr_mem);
+		if (!shdr)
+			error("gelf_getshdr failed: %s", elf_errmsg(-1));
+
+		if (shdr->sh_type == SHT_SYMTAB_SHNDX) {
+			xndx_data = elf_getdata(scn, NULL);
+			if (!xndx_data)
+				error("elf_getdata failed: %s", elf_errmsg(-1));
+			break;
+		}
+
+		scn = elf_nextscn(elf, scn);
+	}
+
+	sym_size = gelf_fsize(elf, ELF_T_SYM, 1, EV_CURRENT);
+	scn = elf_nextscn(elf, NULL);
+
+	while (scn) {
+		shdr = gelf_getshdr(scn, &shdr_mem);
+		if (!shdr)
+			error("gelf_getshdr failed: %s", elf_errmsg(-1));
+
+		if (shdr->sh_type == SHT_SYMTAB) {
+			unsigned int nsyms;
+			unsigned int n;
+			Elf_Data *data = elf_getdata(scn, NULL);
+
+			if (!data)
+				error("elf_getdata failed: %s", elf_errmsg(-1));
+
+			if (shdr->sh_entsize != sym_size)
+				error("expected sh_entsize (%lu) to be %zu",
+				      shdr->sh_entsize, sym_size);
+
+			nsyms = shdr->sh_size / shdr->sh_entsize;
+
+			for (n = 1; n < nsyms; ++n) {
+				const char *name = NULL;
+				Elf32_Word xndx = 0;
+				GElf_Sym sym_mem;
+				GElf_Sym *sym;
+
+				sym = gelf_getsymshndx(data, xndx_data, n,
+						       &sym_mem, &xndx);
+				if (!sym)
+					error("gelf_getsymshndx failed: %s",
+					      elf_errmsg(-1));
+
+				if (GELF_ST_BIND(sym->st_info) == STB_LOCAL)
+					continue;
+
+				if (sym->st_shndx != SHN_XINDEX)
+					xndx = sym->st_shndx;
+
+				name = elf_strptr(elf, shdr->sh_link,
+						  sym->st_name);
+				if (!name)
+					error("elf_strptr failed: %s",
+					      elf_errmsg(-1));
+
+				/* Skip empty symbol names */
+				if (*name)
+					func(name, sym, xndx, arg);
+			}
+		}
+
+		scn = elf_nextscn(elf, scn);
+	}
+
+	check(elf_end(elf));
+}
+
+static void set_symbol_addr(struct symbol *sym, void *arg)
+{
+	struct symbol_addr *addr = arg;
+
+	if (sym->addr.section == SHN_UNDEF) {
+		sym->addr = *addr;
+		hash_add(symbol_addrs, &sym->addr_hash,
+			 symbol_addr_hash(&sym->addr));
+
+		debug("%s -> { %u, %lx }", sym->name, sym->addr.section,
+		      sym->addr.address);
+	} else if (sym->addr.section != addr->section ||
+		   sym->addr.address != addr->address) {
+		warn("multiple addresses for symbol %s?", sym->name);
+	}
+}
+
+static void elf_set_symbol_addr(const char *name, GElf_Sym *sym,
+				Elf32_Word xndx, void *arg)
+{
+	struct symbol_addr addr = { .section = xndx, .address = sym->st_value };
+
+	/* Set addresses for exported symbols */
+	if (addr.section != SHN_UNDEF)
+		for_each(name, set_symbol_addr, &addr);
+}
+
+void symbol_read_symtab(int fd)
+{
+	elf_for_each_global(fd, elf_set_symbol_addr, NULL);
+}
+
 void symbol_free(void)
 {
 	struct hlist_node *tmp;
@@ -94,5 +254,6 @@ void symbol_free(void)
 		free(sym);
 	}
 
+	hash_init(symbol_addrs);
 	hash_init(symbol_names);
 }
-- 
2.47.1.613.gc27f4b7a9f-goog

