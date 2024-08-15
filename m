Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1644AEE9
	for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743557; cv=none; b=g9RHex9FSHxrqA/t/LQCkz7D+wmE6AwlMzMJ451CXesCuvuCfNDWTcYJJtNJD8fDQYq1DuPgYq3TZP0JI6gW4dkn/tgbyUgm6vPuuLPT/fSwPb7e56ZALrPLefz9AW3plocStqSie+935JUy81ZtBNcE9bABjKgaT1Qxqk0HTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743557; c=relaxed/simple;
	bh=bxNi2EoDMx8FMXT38cuDVktpfAT2lY3rDO58JAquwyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dy2BOTnYk0fwt3y0D8aaYFxTw2WCVikLslvSAAoPh//B4m4BvQl3XNndA/LB9p0LBJPh5XMN4JeeMdQhwaQ2nn/no3UclcxsXBy2LpUhx2qKdQM5f4gIScJAzEqLv+PvdOwLp0IrsxEbLJKBQ237yIZAj5rIjfRQldStHGyvONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lRmZryVA; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRmZryVA"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e116b9b670eso1941916276.3
        for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723743555; x=1724348355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNdMzoDNg3SBOXN5kIH+J4L0OFXsoxTK6BvqXkHiFPI=;
        b=lRmZryVAuljBTeCQQ5Pg/29DbAh358SPMGDjmQoQYPniBMCNl06C/2+RO9c7NRzVcI
         ImzSKMs3ewupqw99eDAgTA3que5TnTssxim6Nw/NWNOV21Y1vgFFQ+uwVy8Gkd8f6Ccm
         DXzrqBPH+IiyBoPWWNWqKpj/wNWBFPSwheWR0KMzKYv4lyrIU8WXRsND/qwtLMFWfefQ
         wwCTQvvbyOkoE2vjCx5tP92AV9N8iRUHmSlJ12ExW9VJfx9MrwJVuOXRvfhX9+o2uuuG
         6INwTVz89Ts1bYJOnRLq5C6h+epS21UTSJmtdNcRJo9SmP7TE0KDgGMVkXaVTxz18wnb
         mhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743555; x=1724348355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNdMzoDNg3SBOXN5kIH+J4L0OFXsoxTK6BvqXkHiFPI=;
        b=NE3EIfiPsRtJbwC6M7N/4qCMSocxSmWeGibeawE3QPRXweSU/R4idUVAEPHgEGfnvi
         o3RKn9/xvibHrm8Z6bjUt8TNJwKWrUboHIIzN+bxIveAtwWAxj8vBLEs8m7p5V0Ur5Ta
         IVKHIkpL4IAyVUdWXv4Q+BqvKTnc5ukUBJiNR01F3CuZtcOU1yUYFXz8rQQcSX92pK/N
         QJ+5DtVwCQfAM2KxR+Mm1acahF6SRngllgbjea6ZWv6DbBFM0XX6Z3zeM/XGvK48wjxT
         M0tJtSLQjsBggfRmuGPXfZtbtPFqNTccKqYJC8l35IvJPQefCJ+AHF3lV3aD4TePSyv/
         sg3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxsr8asN/rZ8TxIRXylUoSLaB87FletVB/h9r1dDrF+pxbYaj7FnDQPyZ5P5sy5lsGk27l4zmX4aGSFeJpMYAdAZX23/Sr4d+kYkqMlA==
X-Gm-Message-State: AOJu0Yxt4gwmV8OwGeY6cuAC/HfEOeXchyAgfRS215YNXwyiH68HbfwP
	PJnIQvQsgburcNmBTQ31JM5eNLrLdvtG9O5vSIQF0e8+SJziAYFpRQq4nNpmIJSL9j5EZUI7cWy
	M4GdIBD3RHYVwuBEVw3OBl8MfAQ==
X-Google-Smtp-Source: AGHT+IHPxCk3ILqts0dwN0ruCt7oiCn01RaYOO920w1P76dXAowMtUZ+z4/p1v1TXr/x0jIKsh3oPHsRIw4e5lInAac=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:8741:0:b0:e11:69f2:e39 with SMTP
 id 3f1490d57ef6-e1180f6c6e6mr24578276.9.1723743554965; Thu, 15 Aug 2024
 10:39:14 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:39:05 +0000
In-Reply-To: <20240815173903.4172139-21-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=10595; i=samitolvanen@google.com;
 h=from:subject; bh=bxNi2EoDMx8FMXT38cuDVktpfAT2lY3rDO58JAquwyI=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmvj03rj9tt5wrj9Oop0GTFoXQSq5wmqtqxKtMp
 Yzs8ToZK7mJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZr49NwAKCRBMtfaEi7xW
 7mv2C/9J/fisIDuw3uC7zNCeENccXXNMNEhImxup017WiI9C1raumF4b/TiPX5pmVOdkHrJdeX4
 6oogEA4PsDGD+qbP8sy4vD5fYnCEuna2ddzJdaWVJ6HuVQJltUoGfWVvPXXTUszFTmudEPJl0rk
 /Zmz0qeSwOHm6bffSaADMYck0ZHk4hs3UOQcgnDI1bB0kz7PuAZl3QQver9NXKuDznRVDZ7sTUJ
 mD/vGvuaijFMWy3aq7xpYknhl2lewDMrxeD6mvxcI62tubo/paaXe1ETXxflVEBPEAzj2JEXJ1I
 olO/JpOgWoNF4WXHHopciA6KbQSoRwjTDNcpvExHA4Fw05buwgqQlw4gN3NGok0IuGlzmDbDzQ6
 bdZ4QkOWLpmjJfSG65LHtUmaQWUzo6jX90b4X2fdrk4Q6EIjuUd/lOj12i1uLldHrIn0I6mp1x0 Cmmjs/xYFQCoQX5Q9jq0JguOpEwQ8OF+5ZnfXYRAhKhZmxlLyEp/wfDTAm1QvuuEseQBo=
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240815173903.4172139-22-samitolvanen@google.com>
Subject: [PATCH v2 01/19] tools: Add gendwarfksyms
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a basic DWARF parser, which uses libdw to traverse the debugging
information in an object file and looks for functions and variables.
In follow-up patches, this will be expanded to produce symbol versions
for CONFIG_MODVERSIONS from DWARF.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/module/Kconfig                 |   8 ++
 scripts/Makefile                      |   1 +
 scripts/gendwarfksyms/.gitignore      |   2 +
 scripts/gendwarfksyms/Makefile        |   7 ++
 scripts/gendwarfksyms/dwarf.c         |  87 +++++++++++++++
 scripts/gendwarfksyms/gendwarfksyms.c | 146 ++++++++++++++++++++++++++
 scripts/gendwarfksyms/gendwarfksyms.h |  78 ++++++++++++++
 7 files changed, 329 insertions(+)
 create mode 100644 scripts/gendwarfksyms/.gitignore
 create mode 100644 scripts/gendwarfksyms/Makefile
 create mode 100644 scripts/gendwarfksyms/dwarf.c
 create mode 100644 scripts/gendwarfksyms/gendwarfksyms.c
 create mode 100644 scripts/gendwarfksyms/gendwarfksyms.h

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 4047b6d48255..a506d4ac660f 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -168,6 +168,14 @@ config MODVERSIONS
 	  make them incompatible with the kernel you are running.  If
 	  unsure, say N.
 
+config GENDWARFKSYMS
+	bool
+	depends on DEBUG_INFO
+	# Requires full debugging information, split DWARF not supported.
+	depends on !DEBUG_INFO_REDUCED && !DEBUG_INFO_SPLIT
+	# Requires ELF object files.
+	depends on !LTO
+
 config ASM_MODVERSIONS
 	bool
 	default HAVE_ASM_MODVERSIONS && MODVERSIONS
diff --git a/scripts/Makefile b/scripts/Makefile
index dccef663ca82..2fd0199662e9 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -54,6 +54,7 @@ targets += module.lds
 
 subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
 subdir-$(CONFIG_MODVERSIONS) += genksyms
+subdir-$(CONFIG_GENDWARFKSYMS) += gendwarfksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
 
 # Let clean descend into subdirs
diff --git a/scripts/gendwarfksyms/.gitignore b/scripts/gendwarfksyms/.gitignore
new file mode 100644
index 000000000000..ab8c763b3afe
--- /dev/null
+++ b/scripts/gendwarfksyms/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/gendwarfksyms
diff --git a/scripts/gendwarfksyms/Makefile b/scripts/gendwarfksyms/Makefile
new file mode 100644
index 000000000000..c1389c161f9c
--- /dev/null
+++ b/scripts/gendwarfksyms/Makefile
@@ -0,0 +1,7 @@
+hostprogs-always-y += gendwarfksyms
+
+gendwarfksyms-objs += gendwarfksyms.o
+gendwarfksyms-objs += dwarf.o
+
+HOST_EXTRACFLAGS := -I $(srctree)/tools/include
+HOSTLDLIBS_gendwarfksyms := -ldw -lelf
diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
new file mode 100644
index 000000000000..65a29d0bd8f4
--- /dev/null
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Google LLC
+ */
+
+#include "gendwarfksyms.h"
+
+/*
+ * Type string processing
+ */
+static int process(struct state *state, const char *s)
+{
+	s = s ?: "<null>";
+
+	if (debug)
+		fputs(s, stderr);
+
+	return 0;
+}
+
+bool match_all(Dwarf_Die *die)
+{
+	return true;
+}
+
+int process_die_container(struct state *state, Dwarf_Die *die,
+			  die_callback_t func, die_match_callback_t match)
+{
+	Dwarf_Die current;
+	int res;
+
+	res = checkp(dwarf_child(die, &current));
+	while (!res) {
+		if (match(&current))
+			check(func(state, &current));
+		res = checkp(dwarf_siblingof(&current, &current));
+	}
+
+	return 0;
+}
+
+/*
+ * Symbol processing
+ */
+static int process_subprogram(struct state *state, Dwarf_Die *die)
+{
+	return check(process(state, "subprogram;\n"));
+}
+
+static int process_variable(struct state *state, Dwarf_Die *die)
+{
+	return check(process(state, "variable;\n"));
+}
+
+static int process_exported_symbols(struct state *state, Dwarf_Die *die)
+{
+	int tag = dwarf_tag(die);
+
+	switch (tag) {
+	/* Possible containers of exported symbols */
+	case DW_TAG_namespace:
+	case DW_TAG_class_type:
+	case DW_TAG_structure_type:
+		return check(process_die_container(
+			state, die, process_exported_symbols, match_all));
+
+	/* Possible exported symbols */
+	case DW_TAG_subprogram:
+	case DW_TAG_variable:
+		if (tag == DW_TAG_subprogram)
+			check(process_subprogram(state, die));
+		else
+			check(process_variable(state, die));
+
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+int process_module(Dwfl_Module *mod, Dwarf *dbg, Dwarf_Die *cudie)
+{
+	struct state state = { .mod = mod, .dbg = dbg };
+
+	return check(process_die_container(
+		&state, cudie, process_exported_symbols, match_all));
+}
diff --git a/scripts/gendwarfksyms/gendwarfksyms.c b/scripts/gendwarfksyms/gendwarfksyms.c
new file mode 100644
index 000000000000..27f2d6423c45
--- /dev/null
+++ b/scripts/gendwarfksyms/gendwarfksyms.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Google LLC
+ */
+
+#include <fcntl.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <string.h>
+#include <unistd.h>
+#include "gendwarfksyms.h"
+
+/*
+ * Options
+ */
+
+/* Print out debugging information to stderr */
+bool debug;
+
+static const struct {
+	const char *arg;
+	bool *flag;
+	const char **param;
+} options[] = {
+	{ "--debug", &debug, NULL },
+};
+
+static int usage(void)
+{
+	error("usage: gendwarfksyms [options] elf-object-file ...");
+	return -1;
+}
+
+static const char *object_files[MAX_INPUT_FILES];
+static unsigned int object_count;
+
+static int parse_options(int argc, const char **argv)
+{
+	for (int i = 1; i < argc; i++) {
+		bool flag = false;
+
+		for (int j = 0; j < ARRAY_SIZE(options); j++) {
+			if (strcmp(argv[i], options[j].arg))
+				continue;
+
+			*options[j].flag = true;
+
+			if (options[j].param) {
+				if (++i >= argc) {
+					error("%s needs an argument",
+					      options[j].arg);
+					return -1;
+				}
+
+				*options[j].param = argv[i];
+			}
+
+			flag = true;
+			break;
+		}
+
+		if (!flag)
+			object_files[object_count++] = argv[i];
+	}
+
+	return object_count ? 0 : -1;
+}
+
+static int process_modules(Dwfl_Module *mod, void **userdata, const char *name,
+			   Dwarf_Addr base, void *arg)
+{
+	Dwarf_Addr dwbias;
+	Dwarf_Die cudie;
+	Dwarf_CU *cu = NULL;
+	Dwarf *dbg;
+	int res;
+
+	debug("%s", name);
+	dbg = dwfl_module_getdwarf(mod, &dwbias);
+
+	do {
+		res = dwarf_get_units(dbg, cu, &cu, NULL, NULL, &cudie, NULL);
+		if (res < 0) {
+			error("dwarf_get_units failed: no debugging information?");
+			return -1;
+		} else if (res == 1) {
+			break; /* No more units */
+		}
+
+		check(process_module(mod, dbg, &cudie));
+	} while (cu);
+
+	return DWARF_CB_OK;
+}
+
+static const Dwfl_Callbacks callbacks = {
+	.section_address = dwfl_offline_section_address,
+	.find_debuginfo = dwfl_standard_find_debuginfo,
+};
+
+int main(int argc, const char **argv)
+{
+	unsigned int n;
+
+	if (parse_options(argc, argv) < 0)
+		return usage();
+
+	for (n = 0; n < object_count; n++) {
+		Dwfl *dwfl;
+		int fd;
+
+		fd = open(object_files[n], O_RDONLY);
+		if (fd == -1) {
+			error("open failed for '%s': %s", object_files[n],
+			      strerror(errno));
+			return -1;
+		}
+
+		dwfl = dwfl_begin(&callbacks);
+		if (!dwfl) {
+			error("dwfl_begin failed for '%s': %s", object_files[n],
+			      dwarf_errmsg(-1));
+			return -1;
+		}
+
+		if (!dwfl_report_offline(dwfl, object_files[n], object_files[n],
+					 fd)) {
+			error("dwfl_report_offline failed for '%s': %s",
+			      object_files[n], dwarf_errmsg(-1));
+			return -1;
+		}
+
+		dwfl_report_end(dwfl, NULL, NULL);
+
+		if (dwfl_getmodules(dwfl, &process_modules, NULL, 0)) {
+			error("dwfl_getmodules failed for '%s'",
+			      object_files[n]);
+			return -1;
+		}
+
+		dwfl_end(dwfl);
+		close(fd);
+	}
+
+	return 0;
+}
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
new file mode 100644
index 000000000000..5ab7ce7d4efb
--- /dev/null
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 Google LLC
+ */
+
+#include <dwarf.h>
+#include <elfutils/libdw.h>
+#include <elfutils/libdwfl.h>
+#include <linux/hashtable.h>
+#include <inttypes.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#ifndef __GENDWARFKSYMS_H
+#define __GENDWARFKSYMS_H
+
+/*
+ * Options -- in gendwarfksyms.c
+ */
+extern bool debug;
+
+#define MAX_INPUT_FILES 128
+
+/*
+ * Output helpers
+ */
+#define __PREFIX "gendwarfksyms: "
+#define __println(prefix, format, ...)                                \
+	fprintf(stderr, prefix __PREFIX "%s: " format "\n", __func__, \
+		##__VA_ARGS__)
+
+#define debug(format, ...)                                    \
+	do {                                                  \
+		if (debug)                                    \
+			__println("", format, ##__VA_ARGS__); \
+	} while (0)
+
+#define warn(format, ...) __println("warning: ", format, ##__VA_ARGS__)
+#define error(format, ...) __println("error: ", format, ##__VA_ARGS__)
+
+/*
+ * Error handling helpers
+ */
+#define __check(expr, test, rv)                                 \
+	({                                                      \
+		int __res = expr;                               \
+		if (test) {                                     \
+			error("`%s` failed: %d", #expr, __res); \
+			return rv;                              \
+		}                                               \
+		__res;                                          \
+	})
+
+/* Error == non-zero values */
+#define check(expr) __check(expr, __res, -1)
+/* Error == negative values */
+#define checkp(expr) __check(expr, __res < 0, __res)
+
+/*
+ * dwarf.c
+ */
+
+struct state {
+	Dwfl_Module *mod;
+	Dwarf *dbg;
+};
+
+typedef int (*die_callback_t)(struct state *state, Dwarf_Die *die);
+typedef bool (*die_match_callback_t)(Dwarf_Die *die);
+extern bool match_all(Dwarf_Die *die);
+
+extern int process_die_container(struct state *state, Dwarf_Die *die,
+				 die_callback_t func,
+				 die_match_callback_t match);
+
+extern int process_module(Dwfl_Module *mod, Dwarf *dbg, Dwarf_Die *cudie);
+
+#endif /* __GENDWARFKSYMS_H */
-- 
2.46.0.184.g6999bdac58-goog

