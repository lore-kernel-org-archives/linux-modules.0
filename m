Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522862;
	b=FbRgEpAX3oL4CdM9QFLFVZ05jenVRxhJVFD+B4zHFCiCXiF9uMIgRa20qqbC2aIs1fk0
	 u0mjOyvCy2TQCkPTgdFKeUNP1awotfIdJhQfqLGgG5IwQBP1CREvFHkiDdWPhC8brEsfM
	 jx3y9gOSe0iIRoEomSEoEOd5U14WGX4vRJnNj+RKAsCY+7IybtBqEqUlw7woSWYvHXl/S
	 wyOmwC6eV+rtjYTbqTZJr9y9KbSN1fsCT3Co/aGoN42nlmpl9+iqDGoVEiriaJxZAjeRI
	 jWV9/kzELk0XdshgiAQGu7o16jcIjTyPbhcKkeImx0ZYG+a3ZVUPssKJnTbKS93C1Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522862;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=P3acyG8CXAbmnNq9GP7DVTcQrdRx9w754IDsdjCYGhk=;
	b=mo8I71emBsKySl3YraPgt4X8c5mBqOf4A/Di91SodCFcMkRQqIPoD4ygWHsWgECv84Ze
	 OdRKn4rMNjKek93MSW4hZmXw27AwOla66rFGUSF8wan9tYtkFpmLusfyi6p86Nk2YQUgw
	 qtfAvkak26s43QjAyChY+SPNZ2Fs4oS/l4yKMXBl0X9/m2Ml4iMBqqpANQaIA38bj8nJ1
	 0X793DRfunHaurp+BVvw5F6dofLmwMGczdbg0WpgY9K8MnGVUSls/isgOML07FQv/az1r
	 3jNkcW2kmZ3SWjALL18vwcVJisvQUNWzKlMdH7wMPyswljUKd1/BlNPSVc14jVErMZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MWjZy/uO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC1606A32D;
	Tue, 24 Nov 2026 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWjZy/uO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D15C1F0093E;
	Tue, 24 Nov 2026 12:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795522861;
	bh=P3acyG8CXAbmnNq9GP7DVTcQrdRx9w754IDsdjCYGhk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MWjZy/uObPhIPc+c+CnVb/mWpDaOjrZjKVyrQlAFVf3h35qPDXeINrkXW8E4EFySs
	 ULY4yIEtmyl3iaiWDAxL8m64NdYaMt/WM6zmP7uKGbHOIfMxsayJz5XAJEDdSFVrW1
	 93Z0Enym6gOEhp3ajMN5EhzOPAWTXz717U/ynn1AmHUh5oB58k0/aNNkTZ3iXBDJif
	 QsS6wSTj0Uqykv0h2CTSGjSD9Hr+cxHF4TwzmFso5Lj+IfmsF54+/7AKj3rmjMMiiI
	 JHqIU8B4xuWKDNpAx513H/ZySpbSaZNwW6fTEfnANKFWY59H5NMloYGakSkoo7MzEd
	 dJI9y5DQQUTag==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 12:20:14 +0000
Subject: [PATCH v6 4/7] modpost: emit module descriptors as assembly
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-build-speedup-v6-4-141a4f861c67@kernel.org>
References: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
In-Reply-To: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Nicolas Schier <n.schier@fritz.com>, Kees Cook <kees@kernel.org>
Cc: ljs@kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=31971; i=ljs@kernel.org;
 h=from:subject:message-id; bh=S/euX+qADf7z5CD/W7en5b3LE28SAHTBbbcqXemGmq0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZG/5XHV1/s/lpFqtzk0X7joTOjvS6527nHHy3rDsb+
 PNr80rDjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEzEaTPD/+yAnKOntQ4v5y3m
 f6t8+PPZ7SpxvTum90bZf+2PLTl9cB4jw2GXx4eulrrtvMjJdvSFh2rDH3mmZOmTl3ff7sgI9NI
 /zQcA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

modpost generates a descriptor for every module in the form of a
<module>.mod.c file with .modinfo strings, the __this_module descriptor,
exported symbol tables and (with CONFIG_MODVERSIONS set), the CRC of
imported symbols.

These files are compiled like any other kernel C file with all of the
-include preamble, as well as including linux/module.h, header dependencies
generated by fixdep of a few hundred headers, an objtool run and if LTO is
being performed, a link is performed to generate native code.

On an x86-64 allmodconfig build 11,189 *.mod.c files are built, each
taking ~0.24s of CPU time to compile, and module finalisation as a whole
6,300 CPU seconds, or 64 seconds of wall time when run over 128 threads.

It also generates ~1.3 GiB of *.mod.o.cmd files that every subsequent build
has to read back.

Avoid all this by emitting the descriptors as assembly instead.

The layout required (size and alignment of struct module, struct
modversion_info, the module's name offsets, init, and exit fields and
whether the architecture uses PREL32 ksymtab references) can all be derived
from scripts/mod/module-offsets.h.

The fields of __this_module are emitted in offset order rather than
declaration order, as CONFIG_RANDSTRUCT shuffles struct module so the name,
init and exit fields can land anywhere.

An assembly file avoids all of the issues previously mentioned so this
conversion results in a very significant performance win on kernel build.

As a consequence of this change, since module-offsets.c includes
linux/module.h, scripts/mod is now built after the generated headers in
prepare0, rather than before.

Also update .gitignore and make clean to handle .mod.S files, but keep
.mod.c files there to ensure that users do not end up with untracked
changes/dirty trees after the change takes effect.

The sections were confirmed to be byte-for-byte identical to the C version
produced - each of .modinfo, .gnu.linkonce.this_module, __ksymtab*,
__ksymtab_strings, __kcrctab*, __kflagstab*, __versions,
__version_ext_crcs, __version_ext_names and their relocations - for all
8,135 modules of a clang allmodconfig build with CONFIG_COMPILE_TEST off
and CONFIG_MODVERSIONS, CONFIG_EXTENDED_MODVERSIONS and
CONFIG_MODULE_SRCVERSION_ALL on, and for a sample built with gcc.

What differs is what the compiler added around them: the __UNIQUE_ID_*
locals, the KASAN constructor for the .mod.c globals, and on x86 a
.note.gnu.property that the linker already drops from any module containing
an assembly file and the loader never reads.

None of these have any impact on the build, however.

The assembly carries no debug information, so in order to keep describing
__this_module in each module's debug information, define it weakly in
module-common.c too, in a section which the module link discards.

Nothing initialises struct module::arch from C any more, so
MODULE_ARCH_INIT is removed from include/linux/module.h and from m68k, the
only architecture that defined it.

x86_64 kernels built with gcc and clang, with CONFIG_MODVERSIONS,
CONFIG_EXTENDED_MODVERSIONS and CONFIG_MODULE_SRCVERSION_ALL, were booted,
every module and an external one loaded and unloaded, and the srcversions
checked against modinfo, i386 and arm64 defconfigs (gcc and clang) and a
ThinLTO build were also built as part of testing.

An x86_64 CONFIG_RANDSTRUCT_FULL build with clang, which places the name
field after init and exit, was checked the same way and produces the same
.gnu.linkonce.this_module sections and relocations as the C version.

On the x86_64 allmodconfig with clang 22, "make modules" with every
*.mod.o and *.ko deleted goes from 64.5s (6,306 CPU-s) to 28.5s (518
CPU-s).

A consequence of this change is that the make jobs are now so small that
make cannot dispatch them quick enough, however the next commit in the
series addresses this issue.

This impacts clean and no-op builds with a large number of modules most
noticeably.

Whole build, 128-thread Threadripper 9980X, best of N runs:

                                         before   after     delta
                                         -------------------------------
  x86 allmodconfig, no-op make, gcc        12.7s     2.3s    -10.4s (-82%)
  x86 allmodconfig, no-op make, clang      13.9s     2.8s    -11.2s (-80%)
  x86 allmodconfig, clean, gcc            342.6s   306.6s    -36.0s (-11%)
  x86 allmodconfig, clean, clang          340.1s   290.2s    -49.8s (-15%)

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 .gitignore                     |   1 +
 Makefile                       |   4 +-
 arch/m68k/include/asm/module.h |   6 -
 include/linux/module.h         |   3 -
 include/linux/vermagic.h       |   2 +-
 scripts/Makefile.modfinal      |  10 +-
 scripts/Makefile.modpost       |   2 +-
 scripts/mod/.gitignore         |   1 +
 scripts/mod/Makefile           |   8 +
 scripts/mod/modpost.c          | 584 +++++++++++++++++++++++++++++------------
 scripts/mod/module-offsets.c   |  32 +++
 scripts/module-common.c        |   3 +
 scripts/tags.sh                |   5 +-
 13 files changed, 477 insertions(+), 184 deletions(-)

diff --git a/.gitignore b/.gitignore
index f3efefe2db77..e54400fb781d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -39,6 +39,7 @@
 *.lzo
 *.mod
 *.mod.c
+*.mod.S
 *.o
 *.o.*
 *.patch
diff --git a/Makefile b/Makefile
index 809ae80d5d70..b41f613e42e4 100644
--- a/Makefile
+++ b/Makefile
@@ -1413,8 +1413,8 @@ archprepare: outputmakefile archheaders archscripts scripts include/config/kerne
 	include/generated/rustc_cfg remove-stale-files
 
 prepare0: archprepare
-	$(Q)$(MAKE) $(build)=scripts/mod
 	$(Q)$(MAKE) $(build)=. prepare
+	$(Q)$(MAKE) $(build)=scripts/mod
 
 # All the preparing..
 prepare: prepare0
@@ -2259,7 +2259,7 @@ clean: $(clean-dirs)
 		-o -name '*.dt.yaml' -o -name 'dtbs-list' \
 		-o -name '*.dwo' -o -name '*.lst' \
 		-o -name '*.su' -o -name '*.mod' \
-		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
+		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' -o -name '*.mod.S' \
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
diff --git a/arch/m68k/include/asm/module.h b/arch/m68k/include/asm/module.h
index 36cb06cc03e6..e3af97a4322c 100644
--- a/arch/m68k/include/asm/module.h
+++ b/arch/m68k/include/asm/module.h
@@ -20,12 +20,6 @@ struct mod_arch_specific {
 
 #ifdef CONFIG_MMU
 
-#define MODULE_ARCH_INIT {				\
-	.fixup_start		= __start_fixup,	\
-	.fixup_end		= __stop_fixup,		\
-}
-
-
 #define m68k_fixup(type, addr)			\
 	"	.section \".m68k_fixup\",\"aw\"\n"	\
 	"	.long " #type "," #addr "\n"	\
diff --git a/include/linux/module.h b/include/linux/module.h
index 76f4f3596477..068dfc8f156c 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -582,9 +582,6 @@ struct module {
 	struct _ddebug_info dyndbg_info;
 #endif
 } ____cacheline_aligned __randomize_layout;
-#ifndef MODULE_ARCH_INIT
-#define MODULE_ARCH_INIT {}
-#endif
 
 #ifdef CONFIG_MODULES
 
diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
index 335c360d4f9b..09f05d02664c 100644
--- a/include/linux/vermagic.h
+++ b/include/linux/vermagic.h
@@ -3,7 +3,7 @@
 #define _LINUX_VERMAGIC_H
 
 #ifndef INCLUDE_VERMAGIC
-#error "This header can be included from kernel/module.c or *.mod.c only"
+#error "This header can be included from kernel/module.c or scripts/module-common.c only"
 #endif
 
 #include <generated/utsrelease.h>
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 01a37ec872b9..75e9effdf02c 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -20,10 +20,14 @@ __modfinal: $(modules:%.o=%.ko)
 modname = $(notdir $(@:.mod.o=))
 part-of-module = y
 GCOV_PROFILE := n
-ccflags-remove-y := $(CC_FLAGS_CFI)
 
-%.mod.o: %.mod.c FORCE
-	$(call if_changed_rule,cc_o_c)
+# modpost lays the <module>.mod.S out completely (write_mod_S_file()), so it
+# needs only the assembler and no dependency tracking.
+quiet_cmd_as_mod_o = AS [M]  $@
+      cmd_as_mod_o = $(CC) $(_a_flags) $(modkern_aflags) -c -o $@ $<
+
+%.mod.o: %.mod.S FORCE
+	$(call if_changed,as_mod_o)
 
 .module-common.o: $(srctree)/scripts/module-common.c FORCE
 	$(call if_changed_rule,cc_o_c)
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index d7d45067d08b..eecf5f5c99b4 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -13,7 +13,7 @@
 # Stage 2 is handled by this file and does the following
 # 1) Find all modules listed in modules.order
 # 2) modpost is then used to
-# 3)  create one <module>.mod.c file per module
+# 3)  create one <module>.mod.S file per module
 # 4)  create one Module.symvers file with CRC for all exported symbols
 
 # Step 3 is used to place certain information in the module's ELF
diff --git a/scripts/mod/.gitignore b/scripts/mod/.gitignore
index 0465ec33c9bf..620ab4362094 100644
--- a/scripts/mod/.gitignore
+++ b/scripts/mod/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /devicetable-offsets.h
+/module-offsets.h
 /elfconfig.h
 /mk_elfconfig
 /modpost
diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index c729bc936bae..fbd5099e0441 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -13,10 +13,18 @@ $(obj)/$(devicetable-offsets-file): $(obj)/devicetable-offsets.s FORCE
 
 targets += $(devicetable-offsets-file) devicetable-offsets.s
 
+module-offsets-file := module-offsets.h
+
+$(obj)/$(module-offsets-file): $(obj)/module-offsets.s FORCE
+	$(call filechk,offsets,__MODULE_OFFSETS_H__)
+
+targets += $(module-offsets-file) module-offsets.s
+
 # dependencies on generated files need to be listed explicitly
 
 $(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o $(obj)/symsearch.o: $(obj)/elfconfig.h
 $(obj)/file2alias.o: $(obj)/$(devicetable-offsets-file)
+$(obj)/modpost.o: $(obj)/$(module-offsets-file)
 
 quiet_cmd_elfconfig = MKELF   $@
       cmd_elfconfig = $(obj)/mk_elfconfig < $< > $@
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 83caf29b4bf2..811a45b6e627 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -26,6 +26,7 @@
 #include <list.h>
 #include <xalloc.h>
 #include "modpost.h"
+#include "module-offsets.h"
 #include "../../include/linux/license.h"
 
 #define MODULE_NS_PREFIX "module:"
@@ -1915,39 +1916,6 @@ static void check_modname_len(struct module *mod)
 		mod_error(mod, "module name is too long\n");
 }
 
-/**
- * Header for the generated file
- **/
-static void add_header(struct buffer *b, struct module *mod)
-{
-	buf_printf(b, "#include <linux/module.h>\n");
-	buf_printf(b, "#include <linux/export-internal.h>\n");
-	buf_printf(b, "#include <linux/compiler.h>\n");
-	buf_printf(b, "\n");
-	buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
-	buf_printf(b, "\n");
-	buf_printf(b, "__visible struct module __this_module\n");
-	buf_printf(b, "__section(\".gnu.linkonce.this_module\") = {\n");
-	buf_printf(b, "\t.name = KBUILD_MODNAME,\n");
-	if (mod->has_init)
-		buf_printf(b, "\t.init = init_module,\n");
-	if (mod->has_cleanup)
-		buf_printf(b, "#ifdef CONFIG_MODULE_UNLOAD\n"
-			      "\t.exit = cleanup_module,\n"
-			      "#endif\n");
-	buf_printf(b, "\t.arch = MODULE_ARCH_INIT,\n");
-	buf_printf(b, "};\n");
-
-	if (!external_module)
-		buf_printf(b, "\nMODULE_INFO(intree, \"Y\");\n");
-
-	if (strstarts(mod->name, "drivers/staging"))
-		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
-
-	if (strstarts(mod->name, "tools/testing"))
-		buf_printf(b, "\nMODULE_INFO(test, \"Y\");\n");
-}
-
 static void add_exported_symbols(struct buffer *buf, struct module *mod)
 {
 	struct symbol *sym;
@@ -1985,123 +1953,6 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 	}
 }
 
-/**
- * Record CRCs for unresolved symbols, supporting long names
- */
-static void add_extended_versions(struct buffer *b, struct module *mod)
-{
-	struct symbol *s;
-
-	if (!extended_modversions)
-		return;
-
-	buf_printf(b, "\n");
-	buf_printf(b, "static const u32 ____version_ext_crcs[]\n");
-	buf_printf(b, "__used __section(\"__version_ext_crcs\") = {\n");
-	list_for_each_entry(s, &mod->unresolved_symbols, list) {
-		if (!s->module)
-			continue;
-		if (!s->crc_valid) {
-			mod_warn(mod, "symbol '%s' has no CRC!\n", s->name);
-			continue;
-		}
-		buf_printf(b, "\t0x%08x,\n", s->crc);
-	}
-	buf_printf(b, "};\n");
-
-	buf_printf(b, "static const char ____version_ext_names[]\n");
-	buf_printf(b, "__used __section(\"__version_ext_names\") =\n");
-	list_for_each_entry(s, &mod->unresolved_symbols, list) {
-		if (!s->module)
-			continue;
-		if (!s->crc_valid)
-			/*
-			 * We already warned on this when producing the crc
-			 * table.
-			 * We need to skip its name too, as the indexes in
-			 * both tables need to align.
-			 */
-			continue;
-		buf_printf(b, "\t\"%s\\0\"\n", s->name);
-	}
-	buf_printf(b, ";\n");
-}
-
-/**
- * Record CRCs for unresolved symbols
- **/
-static void add_versions(struct buffer *b, struct module *mod)
-{
-	struct symbol *s;
-
-	if (!basic_modversions)
-		return;
-
-	buf_printf(b, "\n");
-	buf_printf(b, "static const struct modversion_info ____versions[]\n");
-	buf_printf(b, "__used __section(\"__versions\") = {\n");
-
-	list_for_each_entry(s, &mod->unresolved_symbols, list) {
-		if (!s->module)
-			continue;
-		if (!s->crc_valid) {
-			mod_warn(mod, "symbol '%s' has no CRC!\n", s->name);
-			continue;
-		}
-		if (strlen(s->name) >= MODULE_NAME_LEN) {
-			if (extended_modversions) {
-				/* this symbol will only be in the extended info */
-				continue;
-			} else {
-				mod_error(mod, "too long symbol '%s'\n", s->name);
-				break;
-			}
-		}
-		buf_printf(b, "\t{ 0x%08x, \"%s\" },\n",
-			   s->crc, s->name);
-	}
-
-	buf_printf(b, "};\n");
-}
-
-static void add_depends(struct buffer *b, struct module *mod)
-{
-	struct symbol *s;
-	int first = 1;
-
-	/* Clear ->seen flag of modules that own symbols needed by this. */
-	list_for_each_entry(s, &mod->unresolved_symbols, list) {
-		if (s->module)
-			s->module->seen = s->module->is_vmlinux;
-	}
-
-	buf_printf(b, "\n");
-	buf_printf(b, "MODULE_INFO(depends, \"");
-	list_for_each_entry(s, &mod->unresolved_symbols, list) {
-		const char *p;
-		if (!s->module)
-			continue;
-
-		if (s->module->seen)
-			continue;
-
-		s->module->seen = true;
-		p = get_basename(s->module->name);
-		buf_printf(b, "%s%s", first ? "" : ",", p);
-		first = 0;
-	}
-	buf_printf(b, "\");\n");
-}
-
-static void add_srcversion(struct buffer *b, struct module *mod)
-{
-	if (mod->srcversion[0]) {
-		buf_printf(b, "\n");
-		buf_printf(b, "MODULE_INFO(srcversion, \"%s\");\n",
-			   mod->srcversion);
-	}
-}
-
 static void write_buf(struct buffer *b, const char *fname)
 {
 	FILE *file;
@@ -2186,30 +2037,430 @@ static void write_vmlinux_export_c_file(struct module *mod)
 	free(buf.p);
 }
 
-/* do sanity checks, and generate *.mod.c file */
-static void write_mod_c_file(struct module *mod)
+#if MOD_SIZEOF_LONG == 8
+#define MOD_PTR_DIRECTIVE	".quad"
+#else
+#define MOD_PTR_DIRECTIVE	".long"
+#endif
+
+/* See KSYM_FUNC() in include/linux/export-internal.h. */
+#if MOD_FUNC_PLABEL
+#define MOD_FUNC_PREFIX		"P%"
+#else
+#define MOD_FUNC_PREFIX		""
+#endif
+
+/* See __KSYM_ALIGN in include/linux/export-internal.h. */
+#if MOD_PREL32_RELOCATIONS || MOD_SIZEOF_LONG == 4
+#define KSYM_ALIGN		4
+#else
+#define KSYM_ALIGN		8
+#endif
+
+/* Append the body of an assembler string literal, escaped as needed. */
+static void buf_escaped(struct buffer *buf, const char *str)
 {
-	struct buffer buf = { };
-	struct module_alias *alias, *next;
-	char fname[PATH_MAX];
-	int ret;
+	unsigned char chr;
 
-	add_header(&buf, mod);
-	add_exported_symbols(&buf, mod);
-	add_versions(&buf, mod);
-	add_extended_versions(&buf, mod);
-	add_depends(&buf, mod);
+	while ((chr = *str++)) {
+		if (chr == '"' || chr == '\\')
+			buf_printf(buf, "\\%c", chr);
+		else if (isprint(chr))
+			buf_printf(buf, "%c", chr);
+		else
+			buf_printf(buf, "\\%03o", chr);
+	}
+}
 
-	buf_printf(&buf, "\n");
+static void buf_asciz(struct buffer *buf, const char *str)
+{
+	buf_printf(buf, "\t.asciz \"");
+	buf_escaped(buf, str);
+	buf_printf(buf, "\"\n");
+}
+
+/* The equivalent of MODULE_INFO(tag, info). */
+static void add_asm_modinfo(struct buffer *buf, const char *tag,
+			    const char *info)
+{
+	buf_printf(buf, "\t.section .modinfo,\"a\",%%progbits\n");
+	buf_printf(buf, "\t.asciz \"%s=", tag);
+	buf_escaped(buf, info);
+	buf_printf(buf, "\"\n");
+}
+
+/* See __KSYM_REF() in include/linux/export-internal.h. */
+static void add_asm_ksym_ref(struct buffer *buf, const char *prefix,
+			     const char *sym)
+{
+#if MOD_PREL32_RELOCATIONS
+	buf_printf(buf, "\t.long %s%s - .\n", prefix, sym);
+#else
+	buf_printf(buf, "\t" MOD_PTR_DIRECTIVE " %s%s\n", prefix, sym);
+#endif
+}
+
+/* The equivalent of KSYMTAB_FUNC()/KSYMTAB_DATA() and SYMBOL_FLAGS(). */
+static void add_asm_ksymtab(struct buffer *buf, const struct symbol *sym)
+{
+	const char *name = sym->name;
+
+	/* The name and namespace strings the entry refers to. */
+	buf_printf(buf, "\t.section \"__ksymtab_strings\",\"aMS\",%%progbits,1\n");
+	buf_printf(buf, "__kstrtab_%s:\n", name);
+	buf_asciz(buf, name);
+	buf_printf(buf, "__kstrtabns_%s:\n", name);
+	buf_asciz(buf, sym->namespace);
+
+	buf_printf(buf, "\t.section \"___ksymtab+%s\", \"a\"\n", name);
+	buf_printf(buf, "\t.balign %d\n", KSYM_ALIGN);
+	buf_printf(buf, "__ksymtab_%s:\n", name);
+	add_asm_ksym_ref(buf, sym->is_func ? MOD_FUNC_PREFIX : "", name);
+	add_asm_ksym_ref(buf, "__kstrtab_", name);
+	add_asm_ksym_ref(buf, "__kstrtabns_", name);
+
+	buf_printf(buf, "\t.section \"___kflagstab+%s\", \"a\"\n", name);
+	buf_printf(buf, "__flags_%s:\n", name);
+	buf_printf(buf, "\t.byte 0x%02x\n", get_symbol_flags(sym));
+}
+
+/* The equivalent of SYMBOL_CRC(). */
+static void add_asm_crc(struct buffer *buf, const struct symbol *sym)
+{
+	buf_printf(buf, "\t.section \"___kcrctab+%s\",\"a\"\n", sym->name);
+	buf_printf(buf, "\t.balign 4\n");
+	buf_printf(buf, "__crc_%s:\n", sym->name);
+	buf_printf(buf, "\t.long 0x%08x\n", sym->crc);
+}
+
+/* The exported symbols and, with modversions, their CRCs. */
+static void add_asm_exported_symbols(struct buffer *buf, struct module *mod)
+{
+	struct symbol *sym;
+
+	list_for_each_entry(sym, &mod->exported_symbols, list) {
+		if (trim_unused_exports && !sym->used)
+			continue;
+
+		add_asm_ksymtab(buf, sym);
+
+		if (!modversions)
+			continue;
+
+		if (!sym->crc_valid)
+			mod_warn(mod, "EXPORT symbol '%s' version generation failed, symbol will not be versioned.\n"
+				 "Is '%s' prototyped in <asm/asm-prototypes.h>?\n",
+				 sym->name, sym->name);
+		add_asm_crc(buf, sym);
+	}
+}
+
+/* Zero fill up to the offset. */
+static void asm_skip_to(struct buffer *buf, unsigned int *pos,
+			unsigned int offset)
+{
+	if (offset < *pos)
+		fatal("__this_module field at offset %u overlaps the previous one\n",
+		      offset);
+	if (offset > *pos)
+		buf_printf(buf, "\t.skip %u\n", offset - *pos);
+
+	*pos = offset;
+}
+
+/* A non-zero field of __this_module: its offset and the name or symbol in it. */
+struct this_module_field {
+	unsigned int offset;
+	bool is_name;
+	const char *value;
+};
+
+#define THIS_MODULE_MAX_FIELDS	5
+
+static int compare_field_offsets(const void *ptr_a, const void *ptr_b)
+{
+	const struct this_module_field *field_a = ptr_a, *field_b = ptr_b;
+
+	if (field_a->offset != field_b->offset)
+		return field_a->offset < field_b->offset ? -1 : 1;
+
+	return 0;
+}
+
+/*
+ * The fields of __this_module which are not zero, in offset order. The order
+ * is only known from module-offsets.h, CONFIG_RANDSTRUCT shuffles struct module.
+ */
+static unsigned int get_this_module_fields(const struct module *mod,
+					   const char *modname,
+					   struct this_module_field *fields)
+{
+	unsigned int nr_fields = 0;
+
+	fields[nr_fields++] = (struct this_module_field)
+		{ MOD_OFF_module_name, true, modname };
+	if (mod->has_init)
+		fields[nr_fields++] = (struct this_module_field)
+			{ MOD_OFF_module_init, false, MOD_FUNC_PREFIX "init_module" };
+#ifdef MOD_OFF_module_exit
+	if (mod->has_cleanup)
+		fields[nr_fields++] = (struct this_module_field)
+			{ MOD_OFF_module_exit, false, MOD_FUNC_PREFIX "cleanup_module" };
+#endif
+#ifdef MOD_OFF_module_arch_fixup_start
+	fields[nr_fields++] = (struct this_module_field)
+		{ MOD_OFF_module_arch_fixup_start, false, "__start_fixup" };
+	fields[nr_fields++] = (struct this_module_field)
+		{ MOD_OFF_module_arch_fixup_end, false, "__stop_fixup" };
+#endif
+	qsort(fields, nr_fields, sizeof(*fields), compare_field_offsets);
+
+	return nr_fields;
+}
+
+/* Emit one field of __this_module, returning its size. */
+static unsigned int add_asm_this_module_field(struct buffer *buf,
+					      const struct this_module_field *field)
+{
+	if (field->is_name) {
+		buf_printf(buf, "\t.ascii \"%s\"\n", field->value);
+		return strlen(field->value);
+	}
+
+	buf_printf(buf, "\t" MOD_PTR_DIRECTIVE " %s\n", field->value);
+	return MOD_SIZEOF_LONG;
+}
+
+/*
+ * The equivalent of:
+ *
+ *	__visible struct module __this_module __section(".gnu.linkonce.this_module")
+ *		= { .name = KBUILD_MODNAME, .init = init_module, .exit = cleanup_module };
+ *
+ * Everything not listed is zero, except the m68k fixup bounds in .arch.
+ */
+static void add_asm_this_module(struct buffer *buf, const struct module *mod,
+				const char *modname)
+{
+	struct this_module_field fields[THIS_MODULE_MAX_FIELDS];
+	unsigned int nr_fields = get_this_module_fields(mod, modname, fields);
+	unsigned int pos = 0, i;
+
+	buf_printf(buf, "\n\t.section .gnu.linkonce.this_module,\"aw\",%%progbits\n");
+	buf_printf(buf, "\t.balign %d\n", MOD_ALIGNOF_struct_module);
+	buf_printf(buf, "\t.globl __this_module\n");
+	buf_printf(buf, "\t.type __this_module, %%object\n");
+	buf_printf(buf, "\t.size __this_module, %d\n", MOD_SIZEOF_struct_module);
+	buf_printf(buf, "__this_module:\n");
+
+	for (i = 0; i < nr_fields; i++) {
+		asm_skip_to(buf, &pos, fields[i].offset);
+		pos += add_asm_this_module_field(buf, &fields[i]);
+	}
+
+	asm_skip_to(buf, &pos, MOD_SIZEOF_struct_module);
+}
+
+/*
+ * An unresolved symbol without a module is not versioned; one without a CRC
+ * cannot be, so warn about it unless the caller already has.
+ */
+static bool skip_unversioned(struct module *mod, const struct symbol *sym,
+			     bool silent)
+{
+	if (!sym->module)
+		return true;
+	if (sym->crc_valid)
+		return false;
+
+	if (!silent)
+		mod_warn(mod, "symbol '%s' has no CRC!\n", sym->name);
+	return true;
+}
+
+/* One struct modversion_info: the CRC, then the name padded to the end. */
+static void add_asm_version(struct buffer *buf, const struct symbol *sym)
+{
+	buf_printf(buf, "\t" MOD_PTR_DIRECTIVE " 0x%08x\n", sym->crc);
+	buf_printf(buf, "\t.ascii \"%s\"\n", sym->name);
+	buf_printf(buf, "\t.skip %zu\n", MOD_SIZEOF_struct_modversion_info -
+		   MOD_OFF_modversion_info_name - strlen(sym->name));
+}
+
+/*
+ * The equivalent of:
+ *
+ *	static const struct modversion_info ____versions[]
+ *	__used __section("__versions") = { { crc, "name" }, ... };
+ *
+ * for unresolved symbols.
+ */
+static void add_asm_versions(struct buffer *buf, struct module *mod)
+{
+	struct symbol *sym;
+
+	if (!basic_modversions)
+		return;
+
+	buf_printf(buf, "\n\t.section __versions,\"a\",%%progbits\n");
+	buf_printf(buf, "\t.balign %d\n", MOD_ALIGNOF_struct_modversion_info);
+	list_for_each_entry(sym, &mod->unresolved_symbols, list) {
+		if (skip_unversioned(mod, sym, false))
+			continue;
+
+		if (strlen(sym->name) >= MOD_NAME_LEN) {
+			/* Only the extended table can hold it. */
+			if (extended_modversions)
+				continue;
+
+			mod_error(mod, "too long symbol '%s'\n", sym->name);
+			break;
+		}
+
+		add_asm_version(buf, sym);
+	}
+}
+
+/*
+ * The equivalent of:
+ *	static const u32 ____version_ext_crcs[] __section("__version_ext_crcs") = { crc, ... };
+ *	static const char ____version_ext_names[] __section("__version_ext_names") = "name\0" ...;
+ *
+ * for unresolved symbols.
+ */
+static void add_asm_extended_versions(struct buffer *buf, struct module *mod)
+{
+	struct symbol *sym;
+
+	if (!extended_modversions)
+		return;
+
+	buf_printf(buf, "\n\t.section __version_ext_crcs,\"a\",%%progbits\n");
+	buf_printf(buf, "\t.balign 4\n");
+	list_for_each_entry(sym, &mod->unresolved_symbols, list) {
+		if (skip_unversioned(mod, sym, false))
+			continue;
+
+		buf_printf(buf, "\t.long 0x%08x\n", sym->crc);
+	}
+
+	/* The names must line up with the CRCs, which already warned. */
+	buf_printf(buf, "\t.section __version_ext_names,\"a\",%%progbits\n");
+	list_for_each_entry(sym, &mod->unresolved_symbols, list) {
+		if (skip_unversioned(mod, sym, true))
+			continue;
+
+		buf_asciz(buf, sym->name);
+	}
+	/* The terminator of the string literal this used to be. */
+	buf_printf(buf, "\t.byte 0\n");
+}
+
+/* MODULE_INFO(depends, ...): the modules this one needs, each once. */
+static void add_asm_depends(struct buffer *buf, struct module *mod)
+{
+	struct buffer deps = { };
+	struct symbol *sym;
+	bool first = true;
+
+	/* Clear ->seen of the modules that own symbols this one needs. */
+	list_for_each_entry(sym, &mod->unresolved_symbols, list) {
+		if (sym->module)
+			sym->module->seen = sym->module->is_vmlinux;
+	}
+
+	list_for_each_entry(sym, &mod->unresolved_symbols, list) {
+		struct module *owner = sym->module;
+
+		if (!owner || owner->seen)
+			continue;
+
+		owner->seen = true;
+		buf_printf(&deps, "%s%s", first ? "" : ",",
+			   get_basename(owner->name));
+		first = false;
+	}
+	buf_write(&deps, "", 1);
+
+	buf_printf(buf, "\n");
+	add_asm_modinfo(buf, "depends", deps.p);
+	free(deps.p);
+}
+
+/*
+ * KBUILD_MODNAME: the basename of the module with '-' and ',' replaced by
+ * '_' (see name-fix in scripts/Makefile.lib).
+ */
+static char *get_kbuild_modname(const struct module *mod)
+{
+	char *name = xstrdup(get_basename(mod->name));
+	char *curr;
+
+	for (curr = name; *curr; curr++) {
+		if (*curr == '-' || *curr == ',')
+			*curr = '_';
+	}
+
+	return name;
+}
+
+/* The module's name, its descriptor, and where it comes from. */
+static void add_asm_header(struct buffer *buf, const struct module *mod,
+			   const char *modname)
+{
+	buf_printf(buf, "/* Generated by modpost, see scripts/Makefile.modfinal */\n\n");
+
+	add_asm_modinfo(buf, "name", modname);
+	add_asm_this_module(buf, mod, modname);
+	buf_printf(buf, "\n");
+
+	if (!external_module)
+		add_asm_modinfo(buf, "intree", "Y");
+	if (strstarts(mod->name, "drivers/staging"))
+		add_asm_modinfo(buf, "staging", "Y");
+	if (strstarts(mod->name, "tools/testing"))
+		add_asm_modinfo(buf, "test", "Y");
+}
+
+static void add_asm_aliases(struct buffer *buf, struct module *mod)
+{
+	struct module_alias *alias, *next;
+
+	buf_printf(buf, "\n");
 	list_for_each_entry_safe(alias, next, &mod->aliases, node) {
-		buf_printf(&buf, "MODULE_ALIAS(\"%s\");\n", alias->str);
+		add_asm_modinfo(buf, "alias", alias->str);
 		list_del(&alias->node);
 		free(alias);
 	}
+}
+
+static void add_asm_srcversion(struct buffer *buf, const struct module *mod)
+{
+	if (!mod->srcversion[0])
+		return;
 
-	add_srcversion(&buf, mod);
+	buf_printf(buf, "\n");
+	add_asm_modinfo(buf, "srcversion", mod->srcversion);
+}
+
+static void write_mod_S_file(struct module *mod)
+{
+	struct buffer buf = { };
+	char fname[PATH_MAX];
+	char *modname = get_kbuild_modname(mod);
+	int ret;
 
-	ret = snprintf(fname, sizeof(fname), "%s.mod.c", mod->name);
+	add_asm_header(&buf, mod, modname);
+	buf_printf(&buf, "\n");
+	add_asm_exported_symbols(&buf, mod);
+	add_asm_versions(&buf, mod);
+	add_asm_extended_versions(&buf, mod);
+	add_asm_depends(&buf, mod);
+	add_asm_aliases(&buf, mod);
+	add_asm_srcversion(&buf, mod);
+	buf_printf(&buf, "\n\t.section .note.GNU-stack,\"\",%%progbits\n");
+
+	ret = snprintf(fname, sizeof(fname), "%s.mod.S", mod->name);
 	if (ret >= sizeof(fname)) {
 		error("%s: too long path was truncated\n", fname);
 		goto free;
@@ -2218,6 +2469,7 @@ static void write_mod_c_file(struct module *mod)
 	write_if_changed(&buf, fname);
 
 free:
+	free(modname);
 	free(buf.p);
 }
 
@@ -2457,7 +2709,7 @@ int main(int argc, char **argv)
 		if (mod->is_vmlinux)
 			write_vmlinux_export_c_file(mod);
 		else
-			write_mod_c_file(mod);
+			write_mod_S_file(mod);
 	}
 
 	if (missing_namespace_deps)
diff --git a/scripts/mod/module-offsets.c b/scripts/mod/module-offsets.c
new file mode 100644
index 000000000000..904f8cad6314
--- /dev/null
+++ b/scripts/mod/module-offsets.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Layout of the structures modpost emits into *.mod.S. */
+#define COMPILE_OFFSETS
+#include <linux/kbuild.h>
+#include <linux/module.h>
+
+int main(void)
+{
+	DEFINE(MOD_SIZEOF_LONG, sizeof(long));
+	DEFINE(MOD_PREL32_RELOCATIONS, IS_ENABLED(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS));
+	DEFINE(MOD_FUNC_PLABEL, IS_ENABLED(CONFIG_PARISC) && IS_ENABLED(CONFIG_64BIT));
+
+	DEFINE(MOD_SIZEOF_struct_module, sizeof(struct module));
+	DEFINE(MOD_ALIGNOF_struct_module, __alignof__(struct module));
+	OFFSET(MOD_OFF_module_name, module, name);
+	OFFSET(MOD_OFF_module_init, module, init);
+#ifdef CONFIG_MODULE_UNLOAD
+	OFFSET(MOD_OFF_module_exit, module, exit);
+#endif
+#if defined(CONFIG_M68K) && defined(CONFIG_MMU)
+	/* The only architecture whose .arch is not all zeroes. */
+	OFFSET(MOD_OFF_module_arch_fixup_start, module, arch.fixup_start);
+	OFFSET(MOD_OFF_module_arch_fixup_end, module, arch.fixup_end);
+#endif
+	DEFINE(MOD_NAME_LEN, MODULE_NAME_LEN);
+
+	DEFINE(MOD_SIZEOF_struct_modversion_info, sizeof(struct modversion_info));
+	DEFINE(MOD_ALIGNOF_struct_modversion_info, __alignof__(struct modversion_info));
+	OFFSET(MOD_OFF_modversion_info_name, modversion_info, name);
+
+	return 0;
+}
diff --git a/scripts/module-common.c b/scripts/module-common.c
index 12fbc6d3aae8..a75533e709fb 100644
--- a/scripts/module-common.c
+++ b/scripts/module-common.c
@@ -20,6 +20,9 @@ BUILD_LTO_INFO;
 
 MODULE_INFO(vermagic, VERMAGIC_STRING);
 
+/* modpost generates assembly so provide for debug info. */
+__weak __section(".discard.this_module") struct module __this_module;
+
 #ifdef CONFIG_MITIGATION_RETPOLINE
 MODULE_INFO(retpoline, "Y");
 #endif
diff --git a/scripts/tags.sh b/scripts/tags.sh
index 41e38df96984..c33d0f58a9d4 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -14,8 +14,9 @@ fi
 
 # RCS_FIND_IGNORE has escaped ()s -- remove them.
 ignore="$(echo "$RCS_FIND_IGNORE" | sed 's|\\||g' )"
-# tags and cscope files should also ignore MODVERSION *.mod.c files
-ignore="$ignore ( -name *.mod.c ) -prune -o"
+# tags and cscope files should also ignore the modpost-generated *.mod.S files
+# and any *.mod.c left behind from before they were assembly
+ignore="$ignore ( -name *.mod.c -o -name *.mod.S ) -prune -o"
 
 # ignore arbitrary directories
 if [ -n "${IGNORE_DIRS}" ]; then

-- 
2.56.1

