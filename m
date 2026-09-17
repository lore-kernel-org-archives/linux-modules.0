Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E053A894;
	Thu, 17 Sep 2026 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652274; cv=none; b=M0KDBhGY2Ed1PvdrK7Ru950aRrQG+Glc9pQFJoy9FjU0m8JQIK8cLF+PuYQOf7zSXir1tWTTG/V+7oYR68QcCSZUR62Av5n2d1xxqEommUlhECGcQkPZCqWSgTU0V3vCOp5hL1mlfGmQauSBGv4Ejn82HmhcGLmLMEnUKuieAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652274; c=relaxed/simple;
	bh=xh4wlRvsk939Pl52au3kjKab92niFFtEBjsWaz7VB5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QibHBXMrWHqAqzKfs8LGJN0BrT+J2JMIfl1TbBMulT0nSHE4hTTMIYfUwhj8SOI81qcH9MNVOXlt5lgMMDAMSrwf7sLcziub8Hx6zp/VaLgqTZG/5vjv/nKaaIKxwLY6ynz266vhy6OJ9UhnXr/JlFOdXGHQQsLZBFhqL2fV60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TByjVq/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TByjVq/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D231F00899;
	Thu, 17 Sep 2026 13:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789652258;
	bh=f1a+j0+fi1MSaLp99MSKvFF20eIKoyd7NYsGOdoBIKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TByjVq/b5AIIBXXfKFi8tQBqhDZqPD8mnI9Lv82hBtruAPjD0jNlqYTjs52mQxBbp
	 tANZlrMrNnTBvH5CzJ2RGetiDT2hkvR6a7ATkNu1mEmU7es5OinJp87Dn/wtCyxsCR
	 nX/ogkigY8UFWV8ZYSEtQvOcaLWoFIitu4Hpm4o3QdWU7BogAp5T+70zazGUPENeeN
	 KVvE4K0UnnVtNdl9y1UWqkBjTyeWasOM27scTgraG0FEvi3XQyAxm0duyb/lhfroCs
	 rol8k7aB5jjO+Q3zRm3fW2We0WNcVN90mTJzw53RnKVTz0edZtnPBLd426I3otfV1c
	 xqjz5/YjbQkeQ==
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Richard Weinberger <richard@nod.at>,
	Juergen Gross <jgross@suse.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Vlastimil Babka <vbabka@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v9 2/4] kallsyms: extend lineinfo to loadable modules
Date: Thu, 17 Sep 2026 09:37:23 -0400
Message-ID: <20260917133727.428546-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917133727.428546-1-sashal@kernel.org>
References: <20260917133727.428546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add CONFIG_KALLSYMS_LINEINFO_MODULES, which extends the
CONFIG_KALLSYMS_LINEINFO feature to loadable kernel modules.

At build time, each .ko is post-processed by scripts/gen-mod-lineinfo.sh
(modeled on gen-btf.sh) which runs scripts/gen_lineinfo --module on the
.ko, generates per-section .mod_lineinfo and .init.mod_lineinfo
sections containing compact binary tables of section-relative offsets,
file IDs, line numbers, and filenames, and embeds them back into the
.ko via a partial link (ld -r).

At runtime, module_lookup_lineinfo() walks the section descriptors in
each blob, finds the one whose runtime range contains the queried
address, and binary-searches that section's table.  The lookup is
NMI/panic-safe (no locks, no allocations) — the data lives in
read-only module memory and is freed automatically when the module
(or its init memory) is unloaded.

The gen_lineinfo tool gains --module mode which:
 - Walks an allowlist of text-like sections (.text, .exit.text,
   .init.text), gating each on its presence in the .ko.
 - Uses an ELF relocation against each covered section's symbol as the
   runtime "anchor", resolved by the module loader's standard
   apply_relocations() pass — no implicit base derivation from
   mod->mem[].base, no special-cased loader logic.
 - Applies the relocations libdw does not: in an ET_REL .ko a compile
   unit's DW_AT_abbrev_offset and DW_AT_stmt_list, its DW_FORM_strp
   names and the DW_LNE_set_address PCs are all relocations, and libdw
   reads zero for every one of them.  Only the first compile unit --
   whose offsets genuinely are zero -- would otherwise decode, leaving
   a module built from several objects with line info for just one of
   them.  apply_debug_relocations() patches .debug_line, .debug_info,
   .debug_str_offsets, .debug_addr, .debug_rnglists and .debug_loclists
   in the mutable ELF copy before dwarf_begin_elf() sees it.
 - Disambiguates DWARF addresses across sections that all share
   sh_addr == 0 in ET_REL files via per-section synthetic biases
   applied to .debug_line relocations (handles both abs32 and abs64
   width relocs).
 - Expands SHF_COMPRESSED debug sections before patching them.  With
   CONFIG_DEBUG_INFO_COMPRESSED_* the section data is compressed while
   relocation offsets address the uncompressed contents, so patching
   without expanding first corrupts the stream.
 - Applies the arithmetic relocation pairs RISC-V and LoongArch use for
   label differences (R_RISCV_ADD16/SUB16 and friends), which clang
   emits for line-program address advances even with -mno-relax.  Any
   relocation left unapplied in a patched debug section aborts the
   object instead of shipping line numbers shifted by the gap.
 - Handles libdw's ET_REL path-doubling quirk in make_relative().
 - Declares empty section stanzas in its output assembly so the
   resulting lineinfo.o has LOCAL SECTION symbols rather than GLOBAL
   UND ones; otherwise ld -r would not bind the relocation to the
   .ko's existing section symbol of the same name and depmod would
   warn.

The table describes the module's own section layout, so modfinal builds
it from a partial link and merges it in the link that produces the .ko
rather than post-processing a finished module:

  ${LD} -r ${KBUILD_LDFLAGS} ${layout_flags} -T module.lds \
      -o ${KO}.lineinfo_pre $(filter %.o, $^)
  gen-mod-lineinfo.sh ${KO}.lineinfo_pre ${KO}.lineinfo.o
  ${LD} -r ${KBUILD_LDFLAGS} ${last_flags} -T module.lds -o ${KO} \
      ${KO}.lineinfo.o ${KO}.lineinfo_pre

Only --be8 and --build-id are held back for the second link: the first
converts the object to a form the linker will not read again, and the
second has to cover the module that ships.  Everything else runs in the
first link, where the table is measured, since text linked ahead of the
module would move the code the table describes away from its anchor.

KBUILD_LDFLAGS carries the target linker emulation, without which an
ARCH=i386 build on a biarch host links the 32-bit objects with the
host's default 64-bit emulation and fails, and -z noexecstack, which
the generated object has no note of its own for.

Order matters: lineinfo.o must come first so its zero-byte text
contributions stay at offset 0 of the merged sections.

The init blob lives in MOD_INIT_RODATA and is revoked via WRITE_ONCE
in do_init_module() before do_free_init() releases the memory; the
module_init_lineinfo_data() reader uses READ_ONCE so concurrent
lookups either see the old pointer (still valid until do_free_init's
synchronize_rcu) or NULL.

The struct module fields are guarded by
#ifdef CONFIG_KALLSYMS_LINEINFO_MODULES and accessed through inline
reader accessors so callers don't duplicate the guard.

Per-module overhead is approximately 10 bytes per DWARF line entry
plus a small fixed cost per covered section descriptor.  The next
patch in this series delta-compresses the per-section streams to ~3-4
bytes per entry.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../admin-guide/kallsyms-lineinfo.rst         |   43 +-
 MAINTAINERS                                   |    3 +
 include/linux/mod_lineinfo.h                  |  130 ++
 include/linux/module.h                        |   40 +
 init/Kconfig                                  |   13 +
 kernel/kallsyms.c                             |   19 +-
 kernel/module/kallsyms.c                      |  213 +++
 kernel/module/main.c                          |   26 +
 scripts/Makefile.modfinal                     |   41 +-
 scripts/gen-mod-lineinfo.sh                   |   45 +
 scripts/gen_lineinfo.c                        | 1462 +++++++++++++++--
 11 files changed, 1883 insertions(+), 152 deletions(-)
 create mode 100644 include/linux/mod_lineinfo.h
 create mode 100755 scripts/gen-mod-lineinfo.sh

diff --git a/Documentation/admin-guide/kallsyms-lineinfo.rst b/Documentation/admin-guide/kallsyms-lineinfo.rst
index 549432cc4ea80..227ed9413be6c 100644
--- a/Documentation/admin-guide/kallsyms-lineinfo.rst
+++ b/Documentation/admin-guide/kallsyms-lineinfo.rst
@@ -51,22 +51,49 @@ With ``CONFIG_KALLSYMS_LINEINFO``::
 Note that assembly routines (such as ``entry_SYSCALL_64_after_hwframe``) are
 not annotated because they lack DWARF debug information.
 
+Module Support
+==============
+
+``CONFIG_KALLSYMS_LINEINFO_MODULES`` extends the feature to loadable kernel
+modules.  When enabled, each ``.ko`` is post-processed at build time to embed
+a ``.mod_lineinfo`` section containing the same kind of address-to-source
+mapping.
+
+Enable in addition to the base options::
+
+    CONFIG_MODULES=y
+    CONFIG_KALLSYMS_LINEINFO_MODULES=y
+
+Stack traces from module code will then include annotations::
+
+    my_driver_func+0x30/0x100 [my_driver] (drivers/foo/bar.c:123)
+
+The ``.mod_lineinfo`` section is loaded into read-only module memory alongside
+the module text.  No additional runtime memory allocation is required; the data
+is freed when the module is unloaded.
+
 Memory Overhead
 ===============
 
-The lineinfo tables are stored in ``.rodata``.  On an x86_64 ``defconfig``
-with ``CONFIG_DEBUG_INFO`` they hold 1.66 million entries and grow the
-stripped image by 16 MiB, about 10 bytes per entry after deduplication.
+The vmlinux lineinfo tables are stored in ``.rodata``.  On an x86_64
+``defconfig`` with ``CONFIG_DEBUG_INFO`` they hold 1.66 million entries and
+grow the stripped image by 16 MiB, about 10 bytes per entry after
+deduplication.
+
+Per-module lineinfo adds about 10 bytes per entry to each ``.ko`` file, plus
+a small fixed cost per covered section.
 
 Known Limitations
 =================
 
-- **vmlinux only**: Only symbols in the core kernel image are annotated.
-  Module symbols are not covered.
-- **4 GiB offset limit**: Address offsets from ``_text`` are stored as 32-bit
-  values.  Entries beyond 4 GiB from ``_text`` are skipped at build time with
-  a warning.
+- **4 GiB offset limit**: Address offsets from ``_text`` (vmlinux) or
+  ``.text`` base (modules) are stored as 32-bit values.  Entries beyond
+  4 GiB are skipped at build time with a warning.
 - **65535 file limit**: Source file IDs are stored as 16-bit values.  Builds
   with more than 65535 unique source files will fail with an error.
 - **No assembly annotations**: Functions implemented in assembly that lack
   DWARF ``.debug_line`` data are not annotated.
+- **Module init text**: A module's ``.init.text`` is annotated from a separate
+  ``.init.mod_lineinfo`` section, which is released along with the module's
+  init memory.  Traces taken after the module has finished initializing carry
+  no annotation for those addresses.
diff --git a/MAINTAINERS b/MAINTAINERS
index 7768ef11e8a73..9d42fd97effe0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14027,6 +14027,9 @@ KALLSYMS LINEINFO
 M:	Sasha Levin <sashal@kernel.org>
 S:	Maintained
 F:	Documentation/admin-guide/kallsyms-lineinfo.rst
+F:	include/linux/mod_lineinfo.h
+F:	lib/tests/lineinfo_kunit.c
+F:	scripts/gen-mod-lineinfo.sh
 F:	scripts/gen_lineinfo.c
 
 KANDOU KB9002 PCIE RETIMER HWMON DRIVER
diff --git a/include/linux/mod_lineinfo.h b/include/linux/mod_lineinfo.h
new file mode 100644
index 0000000000000..cb0c7af7b3171
--- /dev/null
+++ b/include/linux/mod_lineinfo.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mod_lineinfo.h - Binary format for per-module source line information
+ *
+ * This header defines the layout of the .mod_lineinfo and
+ * .init.mod_lineinfo sections embedded in loadable kernel modules.  It
+ * is dual-use: included from both the kernel and the userspace
+ * gen_lineinfo tool.
+ *
+ * Top-level layout (all values in target-native endianness):
+ *
+ *   struct mod_lineinfo_root
+ *   struct mod_lineinfo_section sections[hdr.num_sections]
+ *   ... per-section sub-tables, each pointed at by sections[i].table_offset
+ *
+ * Each mod_lineinfo_section descriptor identifies one ELF text section
+ * covered by the lineinfo blob.  Its .anchor field is an ELF relocation
+ * resolved at module-load time to the runtime base of the named section,
+ * eliminating the need to derive the base from mod->mem[].base segments.
+ * If the relocation fails to resolve (e.g. unknown reloc type), .anchor
+ * stays zero and lookups silently degrade to "no annotation".
+ *
+ * Each per-section sub-table is laid out as a stand-alone
+ * mod_lineinfo_header followed by parallel arrays:
+ *
+ *   struct mod_lineinfo_header     (16 bytes)
+ *   u32 addrs[num_entries]         -- offsets from this section's base, sorted
+ *   u16 file_ids[num_entries]      -- parallel to addrs
+ *   <2-byte pad if num_entries is odd>
+ *   u32 lines[num_entries]         -- parallel to addrs
+ *   u32 file_offsets[num_files]    -- byte offset into filenames[]
+ *   char filenames[filenames_size] -- concatenated NUL-terminated strings
+ */
+#ifndef _LINUX_MOD_LINEINFO_H
+#define _LINUX_MOD_LINEINFO_H
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#include <linux/build_bug.h>
+#include <linux/stddef.h>
+#else
+#include <assert.h>
+#include <stddef.h>
+#include <stdint.h>
+typedef uint32_t u32;
+typedef uint16_t u16;
+typedef uint64_t u64;
+#ifndef __aligned
+#define __aligned(x)	__attribute__((__aligned__(x)))
+#endif
+#ifndef static_assert
+#define static_assert(e, ...)	_Static_assert(e, #e)
+#endif
+#endif
+
+/*
+ * Per-section descriptor.  One entry per ELF text section covered by the
+ * blob (.text, .exit.text, .init.text, ...).
+ */
+struct mod_lineinfo_section {
+	u64 anchor;		/* RELOC: runtime base of covered section, or 0 */
+	u32 size;		/* covered section size in bytes */
+	u32 table_offset;	/* byte offset from blob start to this section's
+				 * mod_lineinfo_header */
+} __aligned(8);
+
+/*
+ * Top-level header.  Sits at offset 0 of every .mod_lineinfo /
+ * .init.mod_lineinfo section.  The generated assembly pads to an 8-byte
+ * boundary after num_sections, so sections[0] must start at offset 8.
+ * The __aligned(8) on struct mod_lineinfo_section guarantees that even on
+ * 32-bit targets where the natural alignment of u64 is smaller (4 on i386,
+ * 2 on m68k) and the compiler would otherwise place sections[] at offset 4.
+ */
+struct mod_lineinfo_root {
+	u32 num_sections;
+	struct mod_lineinfo_section sections[];
+};
+
+static_assert(offsetof(struct mod_lineinfo_root, sections) == 8,
+	      "blob layout: sections[] must sit at offset 8 to match the generated assembly");
+static_assert(sizeof(struct mod_lineinfo_section) == 16,
+	      "blob layout: section descriptors are 16 bytes in the generated assembly");
+
+struct mod_lineinfo_header {
+	u32 num_entries;
+	u32 num_files;
+	u32 filenames_size;	/* total bytes of concatenated filenames */
+};
+
+/* Offset helpers: compute byte offset from the per-section header to each array. */
+
+static inline u32 mod_lineinfo_addrs_off(void)
+{
+	return sizeof(struct mod_lineinfo_header);
+}
+
+/*
+ * The counts come from an on-disk blob and are only validated against the
+ * blob size once the full layout has been summed, so every step widens to
+ * u64: at 10 bytes per entry the u32 sums wrap for counts a caller can
+ * name, which would let a malformed blob pass a bounds check computed from
+ * the wrapped value.
+ */
+static inline u64 mod_lineinfo_file_ids_off(u32 num_entries)
+{
+	return mod_lineinfo_addrs_off() + (u64)num_entries * sizeof(u32);
+}
+
+static inline u64 mod_lineinfo_lines_off(u32 num_entries)
+{
+	/* u16 file_ids[] may need 2-byte padding to align lines[] to 4 bytes */
+	u64 off = mod_lineinfo_file_ids_off(num_entries) +
+		  (u64)num_entries * sizeof(u16);
+	return (off + 3) & ~3ULL;
+}
+
+static inline u64 mod_lineinfo_file_offsets_off(u32 num_entries)
+{
+	return mod_lineinfo_lines_off(num_entries) +
+	       (u64)num_entries * sizeof(u32);
+}
+
+static inline u64 mod_lineinfo_filenames_off(u32 num_entries, u32 num_files)
+{
+	return mod_lineinfo_file_offsets_off(num_entries) +
+	       (u64)num_files * sizeof(u32);
+}
+
+#endif /* _LINUX_MOD_LINEINFO_H */
diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea5..6a446a99032ae 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -503,6 +503,12 @@ struct module {
 	void *btf_data;
 	void *btf_base_data;
 #endif
+#ifdef CONFIG_KALLSYMS_LINEINFO_MODULES
+	void *lineinfo_data;		/* .mod_lineinfo section in MOD_RODATA */
+	unsigned int lineinfo_data_size;
+	void *init_lineinfo_data;	/* .init.mod_lineinfo, NULL after init runs */
+	unsigned int init_lineinfo_data_size;
+#endif
 #ifdef CONFIG_JUMP_LABEL
 	struct jump_entry *jump_entries;
 	unsigned int num_jump_entries;
@@ -1016,6 +1022,40 @@ static inline unsigned long find_kallsyms_symbol_value(struct module *mod,
 
 #endif  /* CONFIG_MODULES && CONFIG_KALLSYMS */
 
+bool module_lookup_lineinfo(struct module *mod, unsigned long addr,
+			    unsigned long sym_start,
+			    const char **file, unsigned int *line);
+
+/*
+ * Reader accessors so callers don't need to duplicate the
+ * CONFIG_KALLSYMS_LINEINFO_MODULES guard around mod->lineinfo_data /
+ * mod->init_lineinfo_data field access.  Setters/clearers in the loader
+ * use the field directly under a matching #ifdef.
+ */
+static inline void *module_lineinfo_data(const struct module *mod,
+					 unsigned int *size)
+{
+#ifdef CONFIG_KALLSYMS_LINEINFO_MODULES
+	*size = mod->lineinfo_data_size;
+	return mod->lineinfo_data;
+#else
+	*size = 0;
+	return NULL;
+#endif
+}
+
+static inline void *module_init_lineinfo_data(const struct module *mod,
+					      unsigned int *size)
+{
+#ifdef CONFIG_KALLSYMS_LINEINFO_MODULES
+	*size = READ_ONCE(mod->init_lineinfo_data_size);
+	return READ_ONCE(mod->init_lineinfo_data);
+#else
+	*size = 0;
+	return NULL;
+#endif
+}
+
 /* Define __free(module_put) macro for struct module *. */
 DEFINE_FREE(module_put, struct module *, if (_T) module_put(_T))
 
diff --git a/init/Kconfig b/init/Kconfig
index fbf838d001490..debf9c6f9e813 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2152,6 +2152,19 @@ config KALLSYMS_LINEINFO
 
 	  If unsure, say N.
 
+config KALLSYMS_LINEINFO_MODULES
+	bool "Embed source file:line information in module stack traces"
+	depends on KALLSYMS_LINEINFO && MODULES
+	help
+	  Extends KALLSYMS_LINEINFO to loadable kernel modules.  Each .ko
+	  gets a lineinfo table generated from its DWARF data at build time,
+	  so stack traces from module code include (file.c:123) annotations.
+
+	  This requires libelf and libdw (from elfutils) on the build host.
+	  Costs 10 bytes per DWARF line entry in each .ko.
+
+	  If unsure, say N.
+
 # end of the "standard kernel features (expert users)" menu
 
 config ARCH_HAS_MEMBARRIER_CALLBACKS
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 111df61749f2e..77543ac216a92 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -586,12 +586,25 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 	 * onto that to denote a call ("foo() replaced with bar()"), which
 	 * "foo (file:line)()" would render unreadable.
 	 */
-	if (add_lineinfo && IS_ENABLED(CONFIG_KALLSYMS_LINEINFO) && !modname) {
+	if (add_lineinfo && IS_ENABLED(CONFIG_KALLSYMS_LINEINFO)) {
 		const char *li_file;
 		unsigned int li_line;
+		bool found = false;
+
+		if (!modname) {
+			found = kallsyms_lookup_lineinfo(address, sym_start,
+							 &li_file, &li_line);
+		} else if (IS_ENABLED(CONFIG_KALLSYMS_LINEINFO_MODULES)) {
+			struct module *mod = __module_address(address);
+
+			if (mod)
+				found = module_lookup_lineinfo(mod, address,
+							       sym_start,
+							       &li_file,
+							       &li_line);
+		}
 
-		if (kallsyms_lookup_lineinfo(address, sym_start,
-					     &li_file, &li_line))
+		if (found)
 			len += scnprintf(buffer + len, KSYM_SYMBOL_LEN - len,
 					 " (%s:%u)", li_file, li_line);
 	}
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index f23126d804b25..511cfa58a3e44 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -502,3 +502,216 @@ int module_kallsyms_on_each_symbol(const char *modname,
 	mutex_unlock(&module_mutex);
 	return ret;
 }
+
+#include <linux/mod_lineinfo.h>
+
+/*
+ * Search one per-section sub-table for @section_offset using flat parallel
+ * arrays.  @hdr is the per-section header at byte offset @hdr_offset within
+ * @blob.  Returns true on hit and populates @file / @line.
+ */
+static bool module_lookup_lineinfo_section(const void *blob, u32 blob_size,
+					   u32 hdr_offset,
+					   unsigned int section_offset,
+					   unsigned int min_offset,
+					   const char **file,
+					   unsigned int *line)
+{
+	const struct mod_lineinfo_header *hdr;
+	const u8 *base;
+	const u32 *addrs, *lines, *file_offsets;
+	const u16 *file_ids;
+	const char *filenames;
+	u32 num_entries, num_files, filenames_size;
+	unsigned int low, high, mid;
+	u16 file_id;
+
+	if (hdr_offset > blob_size ||
+	    blob_size - hdr_offset < sizeof(*hdr))
+		return false;
+
+	/*
+	 * The header and every array it points at are u32-aligned by
+	 * construction.  Refuse anything else rather than take an alignment
+	 * fault here -- this runs from NMI and panic context, where a
+	 * recursive fault would lose the backtrace entirely.
+	 */
+	if (!IS_ALIGNED(hdr_offset, sizeof(u32)))
+		return false;
+
+	base = (const u8 *)blob + hdr_offset;
+	hdr = (const struct mod_lineinfo_header *)base;
+	num_entries = hdr->num_entries;
+	num_files = hdr->num_files;
+	filenames_size = hdr->filenames_size;
+
+	if (num_entries == 0)
+		return false;
+
+	/*
+	 * Check the whole layout against the blob in one go.  The offset
+	 * helpers sum in u64 precisely because a malformed blob can name
+	 * counts whose u32 sum wraps: at 10 bytes per entry across addrs[],
+	 * file_ids[] and lines[], num_entries = 0x33333334 wraps to a small
+	 * value that any bounds check would happily accept.
+	 */
+	{
+		u32 avail = blob_size - hdr_offset;
+		u64 needed = mod_lineinfo_filenames_off(num_entries, num_files);
+
+		if (needed > avail || filenames_size > avail - needed)
+			return false;
+	}
+
+	/*
+	 * Filenames are read as NUL-terminated C strings.  Require the blob
+	 * to end in NUL so a malformed file_offsets entry can never lead the
+	 * later "%s" consumer past the end of the section.
+	 */
+	if (filenames_size == 0 ||
+	    base[mod_lineinfo_filenames_off(num_entries, num_files) +
+		 filenames_size - 1] != 0)
+		return false;
+
+	addrs = (const u32 *)(base + mod_lineinfo_addrs_off());
+	file_ids = (const u16 *)(base + mod_lineinfo_file_ids_off(num_entries));
+	lines = (const u32 *)(base + mod_lineinfo_lines_off(num_entries));
+	file_offsets = (const u32 *)(base + mod_lineinfo_file_offsets_off(num_entries));
+	filenames = (const char *)(base + mod_lineinfo_filenames_off(num_entries, num_files));
+
+	/* Binary search for largest entry <= section_offset. */
+	low = 0;
+	high = num_entries;
+	while (low < high) {
+		mid = low + (high - low) / 2;
+		if (addrs[mid] <= section_offset)
+			low = mid + 1;
+		else
+			high = mid;
+	}
+
+	if (low == 0)
+		return false;
+	low--;
+
+	/*
+	 * Reject entries below the resolved symbol's start so a symbol
+	 * without line entries of its own does not inherit the preceding
+	 * symbol's annotation.
+	 */
+	if (addrs[low] < min_offset)
+		return false;
+
+	/*
+	 * A zero line is the generator's "no source location applies here"
+	 * marker, taken straight from a DWARF line-0 row.
+	 */
+	if (!lines[low])
+		return false;
+
+	file_id = file_ids[low];
+	if (file_id >= num_files)
+		return false;
+	if (file_offsets[file_id] >= filenames_size)
+		return false;
+
+	*file = &filenames[file_offsets[file_id]];
+	*line = lines[low];
+	return true;
+}
+
+/*
+ * Walk a single .mod_lineinfo / .init.mod_lineinfo blob, find the section
+ * descriptor whose [anchor, anchor+size) range contains @addr, then search
+ * that section's sub-table.
+ */
+static bool module_lookup_lineinfo_blob(const void *blob, u32 blob_size,
+					unsigned long addr,
+					unsigned long sym_start,
+					const char **file, unsigned int *line)
+{
+	const struct mod_lineinfo_root *root;
+	u32 i, sections_end;
+
+	if (!blob || blob_size < sizeof(*root))
+		return false;
+
+	/* The section is emitted with .balign 8; see the note above. */
+	if (!IS_ALIGNED((unsigned long)blob, __alignof__(struct mod_lineinfo_section)))
+		return false;
+
+	root = blob;
+	if (root->num_sections == 0)
+		return false;
+
+	if (root->num_sections > U32_MAX / sizeof(struct mod_lineinfo_section))
+		return false;
+	sections_end = sizeof(*root) +
+		       root->num_sections * sizeof(struct mod_lineinfo_section);
+	if (sections_end > blob_size)
+		return false;
+
+	for (i = 0; i < root->num_sections; i++) {
+		const struct mod_lineinfo_section *s = &root->sections[i];
+		unsigned long base = (unsigned long)s->anchor;
+		unsigned long offset, min_offset = 0;
+
+		if (!base)
+			continue;	/* relocation didn't resolve */
+		if (addr < base)
+			continue;
+		offset = addr - base;
+		/* s->size is u32, so this also bounds offset to u32. */
+		if (offset >= s->size)
+			continue;
+
+		if (sym_start > base && sym_start - base <= offset)
+			min_offset = sym_start - base;
+
+		return module_lookup_lineinfo_section(blob, blob_size,
+						      s->table_offset,
+						      offset, min_offset,
+						      file, line);
+	}
+
+	return false;
+}
+
+/*
+ * Look up source file:line for an address within a loaded module.
+ *
+ * Safe in NMI/panic context: no locks, no allocations.
+ * Caller must hold RCU read lock (or be in a context where the module
+ * cannot be unloaded).
+ */
+bool module_lookup_lineinfo(struct module *mod, unsigned long addr,
+			    unsigned long sym_start,
+			    const char **file, unsigned int *line)
+{
+	const void *blob;
+	unsigned int size;
+
+	if (!IS_ENABLED(CONFIG_KALLSYMS_LINEINFO_MODULES))
+		return false;
+
+	blob = module_lineinfo_data(mod, &size);
+	if (blob && module_lookup_lineinfo_blob(blob, size, addr, sym_start,
+						file, line))
+		return true;
+
+	/*
+	 * The init blob lives in MOD_INIT_RODATA and is revoked by
+	 * do_init_module() before do_free_init() releases the memory.  The
+	 * READ_ONCE inside module_init_lineinfo_data() pairs with the
+	 * WRITE_ONCE in do_init_module so we never see a partial
+	 * pointer/size pair, and an RCU grace period in do_free_init()
+	 * guarantees the memory still exists for the duration of any lookup
+	 * that captured the pointer before the revocation.
+	 */
+	blob = module_init_lineinfo_data(mod, &size);
+	if (blob && module_lookup_lineinfo_blob(blob, size, addr, sym_start,
+						file, line))
+		return true;
+
+	return false;
+}
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad06..782a6aab1102c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2723,6 +2723,19 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->btf_base_data = any_section_objs(info, ".BTF.base", 1,
 					      &mod->btf_base_data_size);
 #endif
+#ifdef CONFIG_KALLSYMS_LINEINFO_MODULES
+	/*
+	 * Use section_objs() (not any_section_objs) — both blobs carry an
+	 * ELF anchor relocation that the module loader resolves via its
+	 * standard apply_relocations() pass, which only walks SHF_ALLOC
+	 * sections.  Picking up a non-ALLOC section here would also leave
+	 * the pointer dangling into the temporary load image once freed.
+	 */
+	mod->lineinfo_data = section_objs(info, ".mod_lineinfo", 1,
+					  &mod->lineinfo_data_size);
+	mod->init_lineinfo_data = section_objs(info, ".init.mod_lineinfo", 1,
+					       &mod->init_lineinfo_data_size);
+#endif
 #ifdef CONFIG_JUMP_LABEL
 	mod->jump_entries = section_objs(info, "__jump_table",
 					sizeof(*mod->jump_entries),
@@ -3176,6 +3189,19 @@ static noinline int do_init_module(struct module *mod)
 	/* .BTF is not SHF_ALLOC and will get removed, so sanitize pointers */
 	mod->btf_data = NULL;
 	mod->btf_base_data = NULL;
+#endif
+#ifdef CONFIG_KALLSYMS_LINEINFO_MODULES
+	/*
+	 * .init.mod_lineinfo lives in MOD_INIT_RODATA which do_free_init() is
+	 * about to release.  Clear the pointer so concurrent stack-trace
+	 * lookups stop dereferencing it; do_free_init()'s synchronize_rcu()
+	 * then waits out any reader that already captured the old pointer.
+	 * WRITE_ONCE pairs with the READ_ONCE inside module_init_lineinfo_data()
+	 * so the compiler can't tear or reorder the revocation across the
+	 * llist_add() that follows.
+	 */
+	WRITE_ONCE(mod->init_lineinfo_data, NULL);
+	WRITE_ONCE(mod->init_lineinfo_data_size, 0);
 #endif
 	/*
 	 * We want to free module_init, but be aware that kallsyms may be
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 01a37ec872b90..2f19dc184ffe7 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -46,8 +46,47 @@ quiet_cmd_btf_ko = BTF [M] $@
 		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
 	fi;
 
+# Fold the table generation into the link command rather than running it as a
+# separate $(newer-prereqs) step: if_changed also relinks when only the command
+# line changes, e.g. when LDFLAGS_MODULE gains a different --build-id, and a
+# relinked module whose lineinfo step was skipped silently loses its table.
+#
+# The table describes the module's own section layout, so it is built from a
+# partial link that already has that layout and merged in the link that
+# produces the module.  Two things are held back for that second link: --be8,
+# because it converts the object to a form the linker will not read again, and
+# --build-id, because the note has to cover the module that is shipped and LLD
+# drops one it merely read.  Everything else belongs in the first link, where
+# the table is measured: KBUILD_LDFLAGS_MODULE names an object of its own on
+# PowerPC, arch/powerpc/lib/crtsavres.o, and text linked ahead of the module
+# would move the code the table describes away from the section anchor.  The
+# table object goes first in the second link so that its empty .text
+# contributes no bytes and the anchor still resolves to the start of that
+# code.  It is deleted up front because a table left behind by an interrupted
+# build describes a layout this one need not have.
+ifdef CONFIG_KALLSYMS_LINEINFO_MODULES
+lineinfo_ldflags_all = $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)
+lineinfo_ldflags_last = $(filter --be8 --build-id --build-id=%,		\
+			       $(lineinfo_ldflags_all))
+
+      cmd_ld_ko_o =							\
+	rm -f $@.lineinfo_pre $@.lineinfo.o;				\
+	$(LD) -r $(KBUILD_LDFLAGS)					\
+		$(filter-out $(lineinfo_ldflags_last),			\
+			     $(lineinfo_ldflags_all))			\
+		-T $(objtree)/scripts/module.lds			\
+		-o $@.lineinfo_pre $(filter %.o, $^);			\
+	$(CONFIG_SHELL) $(srctree)/scripts/gen-mod-lineinfo.sh		\
+		$@.lineinfo_pre $@.lineinfo.o;				\
+	$(LD) -r $(KBUILD_LDFLAGS) $(lineinfo_ldflags_last)		\
+		-T $(objtree)/scripts/module.lds -o $@			\
+		$$(test -f $@.lineinfo.o && echo $@.lineinfo.o)		\
+		$@.lineinfo_pre;					\
+	rm -f $@.lineinfo_pre $@.lineinfo.o
+endif
+
 # Re-generate module BTFs if either module's .ko or vmlinux changed
-%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
+%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) $(and $(CONFIG_KALLSYMS_LINEINFO_MODULES),$(objtree)/scripts/gen_lineinfo $(srctree)/scripts/gen-mod-lineinfo.sh) FORCE
 	+$(call if_changed,ld_ko_o)
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
diff --git a/scripts/gen-mod-lineinfo.sh b/scripts/gen-mod-lineinfo.sh
new file mode 100755
index 0000000000000..4a4070b265f83
--- /dev/null
+++ b/scripts/gen-mod-lineinfo.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# gen-mod-lineinfo.sh - Build a kernel module's source line info object
+#
+# Reads DWARF from a module's partially linked image and emits an object
+# holding the module's .mod_lineinfo section.  The section carries an ELF
+# relocation against the module's .text section symbol, so the caller has to
+# link this object into the module for the relocation to ride along to the
+# module loader.  Modeled on scripts/gen-btf.sh.
+
+set -e
+
+if [ $# -ne 2 ]; then
+	echo "Usage: $0 <module-prelink.o> <output.o>" >&2
+	exit 1
+fi
+
+IN="$1"
+OUT="$2"
+
+cleanup() {
+	rm -f "${OUT}.S"
+}
+trap cleanup EXIT
+
+case "${KBUILD_VERBOSE}" in
+*1*)
+	set -x
+	;;
+esac
+
+# Generate assembly from DWARF -- if it fails (no DWARF), silently skip.
+# Leaving no output behind is how the caller is told there is no table.
+if ! ${objtree}/scripts/gen_lineinfo --module "${IN}" > "${OUT}.S"; then
+	exit 0
+fi
+
+# KBUILD_AFLAGS carries the target flags the generated .S has to agree with,
+# e.g. -m32 on a biarch host.
+${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
+	${KBUILD_AFLAGS} ${KBUILD_AFLAGS_MODULE} \
+	-c -o "${OUT}" "${OUT}.S"
+
+exit 0
diff --git a/scripts/gen_lineinfo.c b/scripts/gen_lineinfo.c
index be0b265bacc2d..3f889e0c2281c 100644
--- a/scripts/gen_lineinfo.c
+++ b/scripts/gen_lineinfo.c
@@ -49,16 +49,79 @@ static bool verbose;
 		exit(1);						\
 	} while (0)
 
+#include "../include/linux/mod_lineinfo.h"
+
+static int module_mode;
+
 static unsigned int skipped_overflow;
 
+/* Target ELF traits, captured once in main() and reused at emit time. */
+static bool target_64bit;
+static bool target_le;
+
 /*
- * vmlinux mode: end of the invariant .text region.  Zero means "no cap"
- * (graceful fallback when _etext is absent on some build).
+ * Vmlinux mode only: address range of the *invariant* .text region.
+ * See find_text_end_addr() for why we cap on _etext.  text_end_addr == 0
+ * means "no cap available; capture everything above text_addr" (v3
+ * behavior, used as graceful fallback if _etext is absent).
  */
 static unsigned long long text_end_addr;
 
+/*
+ * In module mode we cover several text-like sections, split across two
+ * output blobs by lifecycle:
+ *
+ *   .mod_lineinfo      -- persistent code (.text, .exit.text); MOD_RODATA
+ *   .init.mod_lineinfo -- init code (.init.text); freed with init memory
+ *
+ * In ET_REL .ko files .text/.init.text/.exit.text all have sh_addr == 0,
+ * so DWARF line addresses (which become sh_addr + addend after relocation)
+ * collide across sections.  We disambiguate by giving each *present*
+ * covered section a unique synthetic "bias" — a u32 base address — and
+ * adding that bias to relocated values inside apply_debug_relocations().
+ * libdw then yields biased addresses that classify_address() can map back
+ * to a single section unambiguously.  The bias is internal to gen_lineinfo
+ * and never leaks into the emitted blob.
+ */
+enum mod_lineinfo_blob {
+	BLOB_PERSISTENT,
+	BLOB_INIT,
+	NUM_BLOBS,
+};
+
+struct covered_section {
+	const char *name;	/* ELF section name (e.g. ".text") */
+	enum mod_lineinfo_blob blob;
+	unsigned long long bias;/* synthetic base address (set in resolve_*) */
+	unsigned long long size;
+	bool present;		/* found in this .ko */
+	unsigned int sec_index;	/* ELF section header index, for reloc matching */
+	unsigned int n_entries;	/* DWARF line entries collected for this section */
+};
+
+static struct covered_section all_sections[] = {
+	{ .name = ".text",         .blob = BLOB_PERSISTENT },
+	{ .name = ".exit.text",    .blob = BLOB_PERSISTENT },
+	{ .name = ".init.text",    .blob = BLOB_INIT },
+	{ .name = ".noinstr.text", .blob = BLOB_PERSISTENT },
+};
+#define ALL_SECTIONS	ARRAY_SIZE(all_sections)
+
+/*
+ * Executable sections present in the .ko but not covered by the blob
+ * (e.g. .static_call.text, .altinstr_replacement, or the per-function
+ * .text.* subsections parisc32 modules keep).  They get synthetic biases
+ * from the same cursor as the covered sections so their DWARF sequences
+ * classify unambiguously and can be dropped, instead of aliasing into
+ * .text's [0, size) range.
+ */
+static struct covered_section *extra_sections;
+static unsigned int num_extra_sections;
+static unsigned long long skipped_uncovered;
+
 struct line_entry {
-	unsigned int offset;	/* offset from _text */
+	unsigned int offset;	/* offset from covered section's start */
+	unsigned int section_id;/* index into covered_sections[] (module mode only) */
 	unsigned int file_id;
 	unsigned int line;
 	unsigned int seq;	/* line-program row order, breaks offset ties */
@@ -88,14 +151,15 @@ static HASHTABLE_DEFINE(file_hashtable, 1U << 13);
 /* Monotonic row counter; see the seq tie-break in compare_entries(). */
 static unsigned int next_seq;
 
-static void add_entry(unsigned int offset, unsigned int file_id,
-		      unsigned int line)
+static void add_entry(unsigned int offset, unsigned int section_id,
+		      unsigned int file_id, unsigned int line)
 {
 	if (num_entries >= entries_capacity) {
 		entries_capacity = entries_capacity ? entries_capacity * 2 : 65536;
 		entries = xrealloc(entries, entries_capacity * sizeof(*entries));
 	}
 	entries[num_entries].offset = offset;
+	entries[num_entries].section_id = section_id;
 	entries[num_entries].file_id = file_id;
 	entries[num_entries].line = line;
 	entries[num_entries].seq = next_seq++;
@@ -308,6 +372,20 @@ static const char *make_relative(const char *path, const char *comp_dir)
 	static char buf[PATH_MAX];
 	const char *p;
 
+	if (path[0] != '/') {
+		/*
+		 * libdw doubles relative paths on ET_REL input
+		 * (e.g. "a/b.c/a/b.c" -> "a/b.c").  Undo that before the
+		 * path is joined to comp_dir, or the halves stop matching.
+		 */
+		size_t len = strlen(path);
+		size_t mid = len / 2;
+
+		if (len > 1 && path[mid] == '/' &&
+		    !memcmp(path, path + mid + 1, mid))
+			path += mid + 1;
+	}
+
 	if (path[0] == '/') {
 		if (snprintf(buf, sizeof(buf), "%s", path) >= (int)sizeof(buf))
 			return path;
@@ -357,6 +435,9 @@ static int compare_entries(const void *a, const void *b)
 	const struct line_entry *ea = a;
 	const struct line_entry *eb = b;
 
+	/* Group by section first so each per-section table is contiguous. */
+	if (ea->section_id != eb->section_id)
+		return ea->section_id < eb->section_id ? -1 : 1;
 	if (ea->offset != eb->offset)
 		return ea->offset < eb->offset ? -1 : 1;
 	/*
@@ -373,7 +454,8 @@ static int compare_entries(const void *a, const void *b)
 
 /*
  * Look up a vmlinux symbol by exact name and return its st_value, or
- * @fallback if absent.  Aborts when @required and the symbol is missing.
+ * @fallback if the symbol is absent (lets callers gracefully skip
+ * optional bounds like _etext).
  */
 static unsigned long long find_vmlinux_sym(Elf *elf, const char *name,
 					   unsigned long long fallback,
@@ -419,33 +501,43 @@ static unsigned long long find_text_addr(Elf *elf)
 }
 
 /*
- * vmlinux is linked in multiple passes: gen_lineinfo runs against
- * .tmp_vmlinux1 (which carries an empty lineinfo stub), then real tables
- * are linked in for the final image.  Sections placed AFTER .rodata
- * (.init.text, .exit.text, ...) shift forward as .rodata grows to hold
- * the real lineinfo blob, so DWARF addresses we'd capture for them in
- * pass 1 would be stale in the final kernel.  Cap captured addresses at
- * _etext, the symbol that marks the end of .text — placed before .rodata
- * in every architecture's vmlinux.lds.S, so its addresses are invariant
- * across the relink.  Returns 0 if _etext is absent (no cap; v3 behavior).
+ * Vmlinux is linked in multiple passes: gen_lineinfo runs against
+ * .tmp_vmlinux1 (which carries the empty lineinfo stub), and the resulting
+ * tables are then linked into the final vmlinux.  Sections placed AFTER
+ * .rodata (.init.text, .exit.text, ...) shift forward as the real lineinfo
+ * tables replace the empty stub, so DWARF addresses we'd capture for them
+ * here are stale by the time the kernel runs.
+ *
+ * Cap the captured range at _etext, the symbol that marks the end of the
+ * .text section.  .text is placed BEFORE .rodata in every architecture's
+ * vmlinux.lds.S, so its addresses are invariant across the relink.
+ * Returns 0 on architectures or builds that don't expose _etext, in which
+ * case the cap is disabled (preserving the v3 behavior — addresses past
+ * .text remain captured but may be off in stack traces).
  */
 static unsigned long long find_text_end_addr(Elf *elf)
 {
 	return find_vmlinux_sym(elf, "_etext", 0, false);
 }
 
-static int compare_uints(const void *a, const void *b)
+/*
+ * Ordering shared by entries[], sym_starts[] and seq_ends[]: section first,
+ * then offset.  In module mode every offset is section-relative, so the two
+ * together are what identifies a location.
+ */
+static int compare_sec_off(unsigned int sa, unsigned int oa,
+			   unsigned int sb, unsigned int ob)
 {
-	unsigned int ua = *(const unsigned int *)a;
-	unsigned int ub = *(const unsigned int *)b;
-
-	if (ua != ub)
-		return ua < ub ? -1 : 1;
+	if (sa != sb)
+		return sa < sb ? -1 : 1;
+	if (oa != ob)
+		return oa < ob ? -1 : 1;
 	return 0;
 }
 
 /* Sorted, duplicate-free extents of every function symbol. */
 struct sym_start {
+	unsigned int section_id;
 	unsigned int offset;
 	unsigned int size;
 };
@@ -465,73 +557,52 @@ static struct sym_start *text_starts;
 static unsigned int num_text_starts;
 static unsigned int text_starts_capacity;
 
-/* Sorted offsets one past the end of each DWARF line-program sequence. */
-static unsigned int *seq_ends;
+/* Sorted locations one past the end of each DWARF line-program sequence. */
+struct seq_end {
+	unsigned int section_id;
+	unsigned int offset;
+};
+
+static struct seq_end *seq_ends;
 static unsigned int num_seq_ends;
 static unsigned int seq_ends_capacity;
 
-static void append_offset(unsigned int **arr, unsigned int *count,
-			  unsigned int *capacity, unsigned int value)
+static int compare_seq_ends(const void *a, const void *b)
 {
-	if (*count >= *capacity) {
-		*capacity = *capacity ? *capacity * 2 : 16384;
-		*arr = xrealloc(*arr, *capacity * sizeof(**arr));
-	}
-	(*arr)[(*count)++] = value;
-}
+	const struct seq_end *ea = a, *eb = b;
 
-static void sort_unique(unsigned int *arr, unsigned int *count)
-{
-	unsigned int j = 0;
-
-	if (*count < 2)
-		return;
-
-	qsort(arr, *count, sizeof(*arr), compare_uints);
-	for (unsigned int i = 1; i < *count; i++) {
-		if (arr[i] == arr[j])
-			continue;
-		if (++j != i)
-			arr[j] = arr[i];
-	}
-	*count = j + 1;
+	return compare_sec_off(ea->section_id, ea->offset,
+			       eb->section_id, eb->offset);
 }
 
-/*
- * Record the end of a line-program sequence.  @addr is one past the last
- * covered byte, so the sequence's own coverage is tested using addr - 1.
- */
-static void record_seq_end(unsigned long long addr,
-			   unsigned long long text_addr)
+static void record_seq_end(unsigned int section_id, unsigned int offset)
 {
-	unsigned long long raw;
-
-	if (addr <= text_addr)
-		return;
-	if (text_end_addr && addr - 1 >= text_end_addr)
-		return;
-
-	raw = addr - text_addr;
-	if (raw > UINT_MAX)
-		return;
-
-	append_offset(&seq_ends, &num_seq_ends, &seq_ends_capacity,
-		      (unsigned int)raw);
+	if (num_seq_ends >= seq_ends_capacity) {
+		seq_ends_capacity = seq_ends_capacity ?
+				    seq_ends_capacity * 2 : 16384;
+		seq_ends = xrealloc(seq_ends,
+				    seq_ends_capacity * sizeof(*seq_ends));
+	}
+	seq_ends[num_seq_ends].section_id = section_id;
+	seq_ends[num_seq_ends].offset = offset;
+	num_seq_ends++;
 }
 
 static int compare_sym_starts(const void *a, const void *b)
 {
 	const struct sym_start *sa = a, *sb = b;
+	int ret = compare_sec_off(sa->section_id, sa->offset,
+				  sb->section_id, sb->offset);
 
-	if (sa->offset != sb->offset)
-		return sa->offset < sb->offset ? -1 : 1;
+	if (ret)
+		return ret;
 	/* Larger extent first, so the dedup below keeps it. */
 	if (sa->size != sb->size)
 		return sa->size > sb->size ? -1 : 1;
 	return 0;
 }
 
-/* Sort by offset, keeping only the widest symbol at each. */
+/* Sort by (section, offset), keeping only the widest symbol at each. */
 static void sort_starts(struct sym_start *a, unsigned int *count)
 {
 	unsigned int n = *count, j = 0;
@@ -541,7 +612,8 @@ static void sort_starts(struct sym_start *a, unsigned int *count)
 
 	qsort(a, n, sizeof(*a), compare_sym_starts);
 	for (unsigned int i = 1; i < n; i++) {
-		if (a[i].offset == a[j].offset)
+		if (!compare_sec_off(a[i].section_id, a[i].offset,
+				     a[j].section_id, a[j].offset))
 			continue;
 		if (++j != i)
 			a[j] = a[i];
@@ -555,7 +627,9 @@ static void sort_starts(struct sym_start *a, unsigned int *count)
  * the kernel's symbol-boundary check rejects the preceding function's entry
  * and the frame goes unannotated.
  */
-static void collect_symbol_starts(Elf *elf, unsigned long long text_addr)
+static void collect_symbol_starts(Elf *elf, unsigned long long text_addr,
+				  struct covered_section *sections,
+				  unsigned int num_sections)
 {
 	Elf_Scn *scn = NULL;
 	GElf_Shdr shdr;
@@ -575,8 +649,9 @@ static void collect_symbol_starts(Elf *elf, unsigned long long text_addr)
 
 		nsyms = shdr.sh_size / shdr.sh_entsize;
 		for (size_t i = 0; i < nsyms; i++) {
-			GElf_Sym sym;
+			unsigned int sec_id = 0;
 			unsigned long long raw;
+			GElf_Sym sym;
 
 			if (!gelf_getsym(data, i, &sym))
 				continue;
@@ -587,12 +662,32 @@ static void collect_symbol_starts(Elf *elf, unsigned long long text_addr)
 			default:
 				continue;
 			}
-			if (sym.st_value < text_addr)
-				continue;
-			if (text_end_addr && sym.st_value >= text_end_addr)
-				continue;
 
-			raw = sym.st_value - text_addr;
+			if (module_mode) {
+				/*
+				 * ET_REL: st_value is already relative to the
+				 * symbol's own section, so only sections the
+				 * blob covers are of interest.
+				 */
+				for (sec_id = 0; sec_id < num_sections; sec_id++)
+					if (sections[sec_id].present &&
+					    sections[sec_id].sec_index ==
+					    sym.st_shndx)
+						break;
+				if (sec_id == num_sections)
+					continue;
+				if (sym.st_value >= sections[sec_id].size)
+					continue;
+				raw = sym.st_value;
+			} else {
+				if (sym.st_value < text_addr)
+					continue;
+				if (text_end_addr &&
+				    sym.st_value >= text_end_addr)
+					continue;
+				raw = sym.st_value - text_addr;
+			}
+
 			if (raw > UINT_MAX)
 				continue;
 
@@ -610,6 +705,7 @@ static void collect_symbol_starts(Elf *elf, unsigned long long text_addr)
 						       text_starts_capacity *
 						       sizeof(*text_starts));
 			}
+			text_starts[num_text_starts].section_id = sec_id;
 			text_starts[num_text_starts].offset = (unsigned int)raw;
 			text_starts[num_text_starts].size =
 				sym.st_size > UINT_MAX ? UINT_MAX :
@@ -619,6 +715,7 @@ static void collect_symbol_starts(Elf *elf, unsigned long long text_addr)
 			if (GELF_ST_TYPE(sym.st_info) != STT_FUNC)
 				continue;
 
+			sym_starts[num_sym_starts].section_id = sec_id;
 			sym_starts[num_sym_starts].offset = (unsigned int)raw;
 			sym_starts[num_sym_starts].size =
 				sym.st_size > UINT_MAX ? UINT_MAX :
@@ -635,12 +732,727 @@ static void collect_symbol_starts(Elf *elf, unsigned long long text_addr)
 	 * there cannot run past it.
 	 */
 	for (unsigned int i = 1; i < num_text_starts; i++) {
+		if (text_starts[i].section_id != text_starts[i - 1].section_id)
+			continue;
 		if (!text_starts[i - 1].size)
 			text_starts[i - 1].size = text_starts[i].offset -
 						  text_starts[i - 1].offset;
 	}
 }
 
+/*
+ * Populate @sections[].present/sec_index/size/bias.  Sections that don't
+ * exist stay marked absent.  Biases are assigned in array order: each
+ * present section gets a base equal to the running total of preceding
+ * present sections' sizes, rounded up to 16 to keep ranges sparse.  This
+ * guarantees [bias, bias+size) ranges are pairwise disjoint and fit in
+ * u32 as long as the sum of all covered text sizes is below 4 GiB.
+ */
+static void resolve_covered_sections(Elf *elf,
+				     struct covered_section *sections,
+				     unsigned int num_sections)
+{
+	Elf_Scn *scn = NULL;
+	GElf_Shdr shdr;
+	size_t shstrndx;
+	unsigned long long cursor = 0;
+
+	if (elf_getshdrstrndx(elf, &shstrndx) != 0)
+		return;
+
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		const char *name;
+
+		if (!gelf_getshdr(scn, &shdr))
+			continue;
+		name = elf_strptr(elf, shstrndx, shdr.sh_name);
+		if (!name)
+			continue;
+		bool covered = false;
+
+		for (unsigned int i = 0; i < num_sections; i++) {
+			if (sections[i].present)
+				continue;
+			if (strcmp(name, sections[i].name))
+				continue;
+			if (shdr.sh_size > UINT_MAX) {
+				warn("section %s exceeds 4 GiB (size=%llu); skipping",
+				     name, (unsigned long long)shdr.sh_size);
+				break;
+			}
+			sections[i].sec_index = elf_ndxscn(scn);
+			sections[i].size = shdr.sh_size;
+			sections[i].present = true;
+			covered = true;
+			break;
+		}
+
+		/*
+		 * Track every other executable section too, so its DWARF
+		 * sequences can be biased into their own range and dropped
+		 * instead of polluting a covered section's table.
+		 */
+		if (!covered &&
+		    (shdr.sh_flags & SHF_EXECINSTR) && (shdr.sh_flags & SHF_ALLOC) &&
+		    shdr.sh_size && shdr.sh_size <= UINT_MAX) {
+			struct covered_section *es;
+
+			extra_sections = xrealloc(extra_sections,
+						  (num_extra_sections + 1) *
+						  sizeof(*extra_sections));
+			es = &extra_sections[num_extra_sections++];
+			memset(es, 0, sizeof(*es));
+			es->name = name;
+			es->sec_index = elf_ndxscn(scn);
+			es->size = shdr.sh_size;
+			es->present = true;
+		}
+	}
+
+	/* Pack present sections into non-overlapping bias ranges. */
+	for (unsigned int i = 0; i < num_sections; i++) {
+		if (!sections[i].present)
+			continue;
+		sections[i].bias = cursor;
+		cursor += sections[i].size;
+		cursor = (cursor + 15) & ~15ULL;	/* pad for separation */
+	}
+	for (unsigned int i = 0; i < num_extra_sections; i++) {
+		extra_sections[i].bias = cursor;
+		cursor += extra_sections[i].size;
+		cursor = (cursor + 15) & ~15ULL;
+	}
+}
+
+/* Look up a covered_section by ELF section header index. */
+static struct covered_section *section_by_index(struct covered_section *sections,
+						unsigned int num_sections,
+						unsigned int sec_index)
+{
+	for (unsigned int i = 0; i < num_sections; i++) {
+		if (sections[i].present && sections[i].sec_index == sec_index)
+			return &sections[i];
+	}
+	return NULL;
+}
+
+/*
+ * Apply .rela.debug_line relocations to a mutable copy of .debug_line data.
+ *
+ * elfutils libdw (through at least 0.194) does NOT apply relocations for
+ * ET_REL files when using dwarf_begin_elf().  The internal libdwfl layer
+ * does this via __libdwfl_relocate(), but that API is not public.
+ *
+ * For DWARF5, the .debug_line file name table uses DW_FORM_line_strp
+ * references into .debug_line_str.  Without relocation, all these offsets
+ * resolve to 0 (or garbage), causing dwarf_linesrc()/dwarf_filesrc() to
+ * return wrong filenames (typically the comp_dir for every file).
+ *
+ * This function applies the relocations manually so that the patched
+ * .debug_line data can be fed to dwarf_begin_elf() and produce correct
+ * results.
+ *
+ * See elfutils bug https://sourceware.org/bugzilla/show_bug.cgi?id=31447
+ * A fix (dwelf_elf_apply_relocs) was proposed but not yet merged as of
+ * elfutils 0.194: https://sourceware.org/pipermail/elfutils-devel/2024q3/007388.html
+ */
+/*
+ * Determine the relocation type for a 32-bit absolute reference
+ * on the given architecture.  Returns 0 if unknown.
+ */
+/*
+ * Constants for the newer architectures are missing from older host ELF
+ * headers -- glibc only gained the LoongArch definitions in 2.36 -- and
+ * gen_lineinfo is built whenever CONFIG_KALLSYMS_LINEINFO is set, on every
+ * architecture.  Same guarded-definition pattern as scripts/mod/modpost.c.
+ */
+#ifndef EM_RISCV
+#define EM_RISCV		243
+#endif
+#ifndef R_RISCV_32
+#define R_RISCV_32		1
+#endif
+#ifndef R_RISCV_64
+#define R_RISCV_64		2
+#endif
+#ifndef R_RISCV_ADD8
+#define R_RISCV_ADD8		33
+#endif
+#ifndef R_RISCV_ADD16
+#define R_RISCV_ADD16		34
+#endif
+#ifndef R_RISCV_ADD32
+#define R_RISCV_ADD32		35
+#endif
+#ifndef R_RISCV_ADD64
+#define R_RISCV_ADD64		36
+#endif
+#ifndef R_RISCV_SUB8
+#define R_RISCV_SUB8		37
+#endif
+#ifndef R_RISCV_SUB16
+#define R_RISCV_SUB16		38
+#endif
+#ifndef R_RISCV_SUB32
+#define R_RISCV_SUB32		39
+#endif
+#ifndef R_RISCV_SUB64
+#define R_RISCV_SUB64		40
+#endif
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH		258
+#endif
+#ifndef R_LARCH_32
+#define R_LARCH_32		1
+#endif
+#ifndef R_LARCH_64
+#define R_LARCH_64		2
+#endif
+#ifndef R_LARCH_ADD8
+#define R_LARCH_ADD8		47
+#endif
+#ifndef R_LARCH_ADD16
+#define R_LARCH_ADD16		48
+#endif
+#ifndef R_LARCH_ADD32
+#define R_LARCH_ADD32		50
+#endif
+#ifndef R_LARCH_ADD64
+#define R_LARCH_ADD64		51
+#endif
+#ifndef R_LARCH_SUB8
+#define R_LARCH_SUB8		52
+#endif
+#ifndef R_LARCH_SUB16
+#define R_LARCH_SUB16		53
+#endif
+#ifndef R_LARCH_SUB32
+#define R_LARCH_SUB32		55
+#endif
+#ifndef R_LARCH_SUB64
+#define R_LARCH_SUB64		56
+#endif
+
+/*
+ * MIPS n64 stores r_info as a symbol index followed by three extra
+ * relocation bytes rather than one integer, so the generic GELF_R_*
+ * macros decode it as nonsense: a type-2 relocation against symbol 9
+ * reads back as type 9 against symbol 33554432.  Mirrors
+ * get_rel_type_and_sym() in scripts/mod/modpost.c.
+ */
+static void decode_r_info(const GElf_Ehdr *ehdr, GElf_Xword r_info,
+			  unsigned int *r_type, size_t *r_sym)
+{
+	const unsigned int endian_probe = 1;
+	bool host_le = *(const unsigned char *)&endian_probe;
+	bool target_le = ehdr->e_ident[EI_DATA] == ELFDATA2LSB;
+	unsigned char raw[sizeof(r_info)];
+
+	if (ehdr->e_machine != EM_MIPS ||
+	    ehdr->e_ident[EI_CLASS] != ELFCLASS64) {
+		*r_type = GELF_R_TYPE(r_info);
+		*r_sym = GELF_R_SYM(r_info);
+		return;
+	}
+
+	/*
+	 * libelf byte-swaps r_info as one 64-bit quantity when the object's
+	 * endianness differs from ours; undo that to get the field layout
+	 * back before picking it apart.
+	 */
+	memcpy(raw, &r_info, sizeof(raw));
+	if (target_le != host_le) {
+		unsigned char tmp;
+
+		for (size_t i = 0; i < sizeof(raw) / 2; i++) {
+			tmp = raw[i];
+			raw[i] = raw[sizeof(raw) - 1 - i];
+			raw[sizeof(raw) - 1 - i] = tmp;
+		}
+	}
+
+	*r_type = raw[7];
+	if (target_le)
+		*r_sym = (size_t)raw[0] | (size_t)raw[1] << 8 |
+			 (size_t)raw[2] << 16 | (size_t)raw[3] << 24;
+	else
+		*r_sym = (size_t)raw[3] | (size_t)raw[2] << 8 |
+			 (size_t)raw[1] << 16 | (size_t)raw[0] << 24;
+}
+
+/*
+ * Some ABIs express a label difference, such as a line program's address
+ * advance, as a pair of arithmetic relocations rather than one absolute
+ * value: RISC-V and LoongArch both do, and clang emits them for
+ * .debug_line even with -mno-relax.  Each applies S + A to the value
+ * already stored at the target.  Returns the width in bytes, or 0 if
+ * @r_type is not an arithmetic relocation; *@is_sub says which direction.
+ */
+static size_t arith_reloc_width(unsigned int e_machine, unsigned int r_type,
+				bool *is_sub)
+{
+	static const struct {
+		unsigned int machine;
+		unsigned int add;
+		unsigned int sub;
+		size_t width;
+	} tbl[] = {
+		{ EM_RISCV,	R_RISCV_ADD8,	R_RISCV_SUB8,	1 },
+		{ EM_RISCV,	R_RISCV_ADD16,	R_RISCV_SUB16,	2 },
+		{ EM_RISCV,	R_RISCV_ADD32,	R_RISCV_SUB32,	4 },
+		{ EM_RISCV,	R_RISCV_ADD64,	R_RISCV_SUB64,	8 },
+		{ EM_LOONGARCH,	R_LARCH_ADD8,	R_LARCH_SUB8,	1 },
+		{ EM_LOONGARCH,	R_LARCH_ADD16,	R_LARCH_SUB16,	2 },
+		{ EM_LOONGARCH,	R_LARCH_ADD32,	R_LARCH_SUB32,	4 },
+		{ EM_LOONGARCH,	R_LARCH_ADD64,	R_LARCH_SUB64,	8 },
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(tbl); i++) {
+		if (tbl[i].machine != e_machine)
+			continue;
+		if (r_type == tbl[i].add) {
+			*is_sub = false;
+			return tbl[i].width;
+		}
+		if (r_type == tbl[i].sub) {
+			*is_sub = true;
+			return tbl[i].width;
+		}
+	}
+	return 0;
+}
+
+/* Relocations we could not apply; the caller refuses to emit a table. */
+static unsigned int unhandled_relocs;
+
+static unsigned int r_type_abs32(unsigned int e_machine)
+{
+	switch (e_machine) {
+	case EM_X86_64:		return R_X86_64_32;
+	case EM_386:		return R_386_32;
+	case EM_AARCH64:	return R_AARCH64_ABS32;
+	case EM_ARM:		return R_ARM_ABS32;
+	case EM_RISCV:		return R_RISCV_32;
+	case EM_S390:		return R_390_32;
+	case EM_MIPS:		return R_MIPS_32;
+	case EM_PPC64:		return R_PPC64_ADDR32;
+	case EM_PPC:		return R_PPC_ADDR32;
+	case EM_LOONGARCH:	return R_LARCH_32;
+	case EM_PARISC:		return R_PARISC_DIR32;
+	default:		return 0;
+	}
+}
+
+/*
+ * Determine the relocation type for a 64-bit absolute reference
+ * on the given architecture.  Returns 0 on 32-bit-only architectures
+ * (where DW_LNE_set_address fits in 32 bits and r_type_abs32 covers it).
+ */
+static unsigned int r_type_abs64(unsigned int e_machine)
+{
+	switch (e_machine) {
+	case EM_X86_64:		return R_X86_64_64;
+	case EM_AARCH64:	return R_AARCH64_ABS64;
+	case EM_RISCV:		return R_RISCV_64;
+	case EM_S390:		return R_390_64;
+	case EM_MIPS:		return R_MIPS_64;
+	case EM_PPC64:		return R_PPC64_ADDR64;
+	case EM_LOONGARCH:	return R_LARCH_64;
+	case EM_PARISC:		return R_PARISC_DIR64;
+	default:		return 0;
+	}
+}
+
+/*
+ * Write a 4- or 8-byte unsigned integer in target byte order.
+ * Cross-builds (e.g. x86_64 host -> s390 module) need the patched
+ * .debug_line bytes laid out per the .ko's e_ident[EI_DATA], not the host's.
+ */
+static void elf_write_uint(unsigned char *dst, uint64_t value, size_t size,
+			   bool little_endian)
+{
+	if (little_endian) {
+		for (size_t i = 0; i < size; i++)
+			dst[i] = (value >> (i * 8)) & 0xff;
+	} else {
+		for (size_t i = 0; i < size; i++)
+			dst[i] = (value >> ((size - 1 - i) * 8)) & 0xff;
+	}
+}
+
+/* Counterpart to elf_write_uint: read the implicit addend of an SHT_REL
+ * relocation, stored in the relocated field itself in target byte order.
+ */
+static uint64_t elf_read_uint(const unsigned char *src, size_t size,
+			      bool little_endian)
+{
+	uint64_t value = 0;
+
+	if (little_endian) {
+		for (size_t i = 0; i < size; i++)
+			value |= (uint64_t)src[i] << (i * 8);
+	} else {
+		for (size_t i = 0; i < size; i++)
+			value |= (uint64_t)src[i] << ((size - 1 - i) * 8);
+	}
+	return value;
+}
+
+/*
+ * Apply one relocation to a debug section.  Two reloc widths matter:
+ *   abs32 - section-offset refs: DW_FORM_line_strp file-table entries into
+ *           .debug_line_str, and DW_AT_stmt_list, DW_AT_abbrev_offset and
+ *           DW_FORM_strp refs out of .debug_info
+ *   abs64 - DW_LNE_set_address arguments (sequence start PCs)
+ * Without both, libdw sees zeros: it reports wrong filenames, collapses
+ * every sequence to address 0 (collision after dedup), or decodes every
+ * compile unit against the first one's abbrev table and line program.
+ *
+ * @has_addend distinguishes RELA records (explicit @addend) from REL
+ * records, whose addend is read from the relocated field itself.
+ * @bias folds in the covered section's synthetic bias for text-directed
+ * relocations; only .debug_line addresses reach classify_address().
+ */
+static void apply_one_debug_reloc(Elf_Data *dl_data, Elf_Data *sym_data,
+				  bool target_le, const GElf_Ehdr *ehdr,
+				  unsigned int abs32_type,
+				  unsigned int abs64_type, GElf_Xword r_info,
+				  GElf_Addr r_offset, GElf_Sxword addend,
+				  bool has_addend, bool bias)
+{
+	GElf_Sym sym;
+	unsigned int r_type;
+	size_t r_sym;
+	bool is_abs64 = false;
+	bool is_sub = false;
+	size_t arith_width;
+	size_t width;
+	uint64_t value;
+
+	decode_r_info(ehdr, r_info, &r_type, &r_sym);
+	arith_width = arith_reloc_width(ehdr->e_machine, r_type, &is_sub);
+
+	if (abs32_type && r_type == abs32_type)
+		is_abs64 = false;
+	else if (abs64_type && r_type == abs64_type)
+		is_abs64 = true;
+	else if (arith_width && has_addend)
+		;	/* handled below */
+	else if (r_type)	/* type 0 is R_*_NONE everywhere we support */
+		unhandled_relocs++;
+
+	if (!(abs32_type && r_type == abs32_type) &&
+	    !(abs64_type && r_type == abs64_type) &&
+	    !(arith_width && has_addend))
+		return;
+
+	if (!gelf_getsym(sym_data, r_sym, &sym))
+		return;
+
+	if (arith_width) {
+		uint64_t cur;
+
+		if (r_offset + arith_width > dl_data->d_size)
+			return;
+		/*
+		 * A delta, not an address: the section bias would appear in
+		 * the ADD and cancel in the matching SUB, so leave it out.
+		 */
+		cur = elf_read_uint((unsigned char *)dl_data->d_buf + r_offset,
+				    arith_width, target_le);
+		value = (uint64_t)(sym.st_value + addend);
+		cur = is_sub ? cur - value : cur + value;
+		elf_write_uint((unsigned char *)dl_data->d_buf + r_offset,
+			       cur, arith_width, target_le);
+		return;
+	}
+
+	width = is_abs64 ? 8 : 4;
+
+	if (r_offset + width > dl_data->d_size)
+		return;
+
+	if (!has_addend)
+		addend = (GElf_Sxword)elf_read_uint(
+				(unsigned char *)dl_data->d_buf + r_offset,
+				width, target_le);
+
+	value = (uint64_t)(sym.st_value + addend);
+
+	/*
+	 * If the relocation targets one of the tracked text sections, fold
+	 * in that section's synthetic bias so the patched DWARF address
+	 * lands in a unique numeric range.  String-ref relocs
+	 * (DW_FORM_line_strp into .debug_line_str) target a different
+	 * section, so the symbol-based check correctly excludes them from
+	 * biasing — for both abs64 (64-bit ELF) and abs32 (32-bit ELF,
+	 * where DW_LNE_set_address is also 4 bytes wide).
+	 */
+	if (module_mode && bias) {
+		struct covered_section *cs;
+
+		cs = section_by_index(all_sections, ALL_SECTIONS,
+				      sym.st_shndx);
+		if (!cs)
+			cs = section_by_index(extra_sections,
+					      num_extra_sections,
+					      sym.st_shndx);
+		if (cs)
+			value += cs->bias;
+	}
+
+	if (!is_abs64)
+		value &= 0xffffffffULL;
+
+	elf_write_uint((unsigned char *)dl_data->d_buf + r_offset,
+		       value, width, target_le);
+}
+
+/* Walk one .rela.<debug section> / .rel.<debug section> table, if present. */
+static void apply_debug_reloc_table(Elf_Scn *scn, bool is_rela,
+				    Elf_Data *dl_data, Elf_Data *sym_data,
+				    bool target_le, const GElf_Ehdr *ehdr,
+				    unsigned int abs32_type,
+				    unsigned int abs64_type, bool bias)
+{
+	GElf_Shdr shdr;
+	Elf_Data *data;
+	size_t nrels, i;
+
+	if (!scn)
+		return;
+
+	data = elf_getdata(scn, NULL);
+	if (!data || !gelf_getshdr(scn, &shdr) || !shdr.sh_entsize)
+		return;
+
+	nrels = shdr.sh_size / shdr.sh_entsize;
+
+	for (i = 0; i < nrels; i++) {
+		if (is_rela) {
+			GElf_Rela rela;
+
+			if (!gelf_getrela(data, i, &rela))
+				continue;
+			apply_one_debug_reloc(dl_data, sym_data, target_le,
+					      ehdr, abs32_type, abs64_type,
+					      rela.r_info, rela.r_offset,
+					      rela.r_addend, true, bias);
+		} else {
+			GElf_Rel rel;
+
+			if (!gelf_getrel(data, i, &rel))
+				continue;
+			apply_one_debug_reloc(dl_data, sym_data, target_le,
+					      ehdr, abs32_type, abs64_type,
+					      rel.r_info, rel.r_offset,
+					      0, false, bias);
+		}
+	}
+}
+
+/*
+ * Debug sections libdw reads while decoding compile units and their line
+ * programs.  In an ET_REL .ko every reference out of these sections is a
+ * relocation: a CU's DW_AT_abbrev_offset and DW_AT_stmt_list, DW_FORM_strp
+ * names, DW_FORM_line_strp file-table entries and DW_LNE_set_address PCs.
+ * libdw applies none of them, so without this pass every CU but the first
+ * -- whose offsets genuinely are zero -- decodes against the first CU's
+ * abbrev table and line program, and a module built from several objects
+ * gets line info for only the first one.
+ */
+static const struct {
+	const char *name;
+	bool bias;
+} debug_reloc_sections[] = {
+	{ ".debug_line",		true },
+	{ ".debug_info",		false },
+	{ ".debug_str_offsets",		false },
+	{ ".debug_addr",		false },
+	{ ".debug_rnglists",		false },
+	{ ".debug_loclists",		false },
+};
+
+static Elf_Scn *find_scn_by_name(Elf *elf, size_t shstrndx, const char *want)
+{
+	Elf_Scn *scn = NULL;
+	GElf_Shdr shdr;
+
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		const char *name;
+
+		if (!gelf_getshdr(scn, &shdr))
+			continue;
+		name = elf_strptr(elf, shstrndx, shdr.sh_name);
+		if (name && !strcmp(name, want))
+			return scn;
+	}
+	return NULL;
+}
+
+static Elf_Scn *find_symtab_scn(Elf *elf)
+{
+	Elf_Scn *scn = NULL;
+	GElf_Shdr shdr;
+
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		if (gelf_getshdr(scn, &shdr) && shdr.sh_type == SHT_SYMTAB)
+			return scn;
+	}
+	return NULL;
+}
+
+static void apply_debug_relocations(Elf *elf)
+{
+	Elf_Scn *symtab_scn;
+	GElf_Ehdr ehdr;
+	GElf_Shdr shdr;
+	unsigned int abs32_type, abs64_type;
+	bool target_le;
+	size_t shstrndx;
+	Elf_Data *sym_data;
+
+	if (gelf_getehdr(elf, &ehdr) == NULL)
+		return;
+
+	abs32_type = r_type_abs32(ehdr.e_machine);
+	abs64_type = r_type_abs64(ehdr.e_machine);
+	if (!abs32_type && !abs64_type)
+		error("no known absolute relocation type for ELF machine %u; refusing to emit line info from unrelocated DWARF",
+		      ehdr.e_machine);
+	target_le = (ehdr.e_ident[EI_DATA] == ELFDATA2LSB);
+
+	if (elf_getshdrstrndx(elf, &shstrndx) != 0)
+		return;
+
+	symtab_scn = find_symtab_scn(elf);
+	if (!symtab_scn)
+		return;
+	sym_data = elf_getdata(symtab_scn, NULL);
+	if (!sym_data)
+		return;
+
+	for (size_t i = 0; i < ARRAY_SIZE(debug_reloc_sections); i++) {
+		const char *name = debug_reloc_sections[i].name;
+		bool bias = debug_reloc_sections[i].bias;
+		char relname[64];
+		Elf_Scn *dbg_scn, *rela_scn, *rel_scn;
+		Elf_Data *dbg_data;
+
+		dbg_scn = find_scn_by_name(elf, shstrndx, name);
+		if (!dbg_scn)
+			continue;
+
+		/*
+		 * CONFIG_DEBUG_INFO_COMPRESSED_* hands us SHF_COMPRESSED
+		 * sections.  elf_getdata() would return the compressed bytes
+		 * while every relocation offset addresses the uncompressed
+		 * contents, so patching without expanding first corrupts the
+		 * stream and libdw then reads nothing.  Expand in place;
+		 * libdw sees the same expanded data afterwards.
+		 */
+		if (gelf_getshdr(dbg_scn, &shdr) &&
+		    (shdr.sh_flags & SHF_COMPRESSED) &&
+		    elf_compress(dbg_scn, 0, 0) < 0)
+			error("cannot decompress %s: %s", name,
+			      elf_errmsg(elf_errno()));
+
+		dbg_data = elf_getdata(dbg_scn, NULL);
+		if (!dbg_data)
+			continue;
+
+		snprintf(relname, sizeof(relname), ".rela%s", name);
+		rela_scn = find_scn_by_name(elf, shstrndx, relname);
+		snprintf(relname, sizeof(relname), ".rel%s", name);
+		rel_scn = find_scn_by_name(elf, shstrndx, relname);
+
+		/*
+		 * RELA (64-bit ELF and most 32-bit targets) carries explicit
+		 * addends; REL (i386, arm32, ...) stores the addend in the
+		 * relocated field itself.
+		 */
+		apply_debug_reloc_table(rela_scn, true, dbg_data, sym_data,
+					target_le, &ehdr, abs32_type,
+					abs64_type, bias);
+		apply_debug_reloc_table(rel_scn, false, dbg_data, sym_data,
+					target_le, &ehdr, abs32_type,
+					abs64_type, bias);
+
+		/*
+		 * Anything left unapplied would shift every mapping after it.
+		 * Refuse the object rather than emit line numbers that point
+		 * at the wrong source lines.
+		 */
+		if (unhandled_relocs)
+			error("%s: %u unsupported relocation(s); refusing to emit line info",
+			      name, unhandled_relocs);
+	}
+}
+
+/*
+ * Decide which covered_section a (biased) DWARF address belongs to.
+ * apply_debug_relocations() has already added the section's bias to
+ * each line-program PC, so [bias, bias+size) ranges are pairwise disjoint
+ * and a simple linear scan picks the right bucket.  Returns the index
+ * within @sections, or @num_sections if @addr falls outside every
+ * present range (caller skips the entry).
+ */
+static unsigned int classify_address(struct covered_section *sections,
+				     unsigned int num_sections,
+				     unsigned long long addr,
+				     unsigned long long *out_offset)
+{
+	for (unsigned int i = 0; i < num_sections; i++) {
+		if (!sections[i].present)
+			continue;
+		if (addr < sections[i].bias)
+			continue;
+		if (addr >= sections[i].bias + sections[i].size)
+			continue;
+		*out_offset = addr - sections[i].bias;
+		return i;
+	}
+	return num_sections;
+}
+
+/*
+ * Classify the end of a line-program sequence.  @addr is one past the last
+ * covered byte, so the section it belongs to is resolved from addr - 1.
+ */
+static void classify_seq_end(unsigned long long addr,
+			     unsigned long long text_addr,
+			     struct covered_section *sections,
+			     unsigned int num_sections)
+{
+	unsigned long long raw;
+
+	if (!addr)
+		return;
+
+	if (module_mode) {
+		unsigned long long sec_off;
+		unsigned int sec_id;
+
+		sec_id = classify_address(sections, num_sections, addr - 1,
+					  &sec_off);
+		if (sec_id == num_sections || sec_off + 1 > UINT_MAX)
+			return;
+		record_seq_end(sec_id, (unsigned int)sec_off + 1);
+		return;
+	}
+
+	if (addr <= text_addr)
+		return;
+	if (text_end_addr && addr - 1 >= text_end_addr)
+		return;
+
+	raw = addr - text_addr;
+	if (raw > UINT_MAX)
+		return;
+
+	record_seq_end(0, (unsigned int)raw);
+}
+
 /*
  * One flag per row read from the compile unit being processed: whether the
  * row closed a line-program sequence.  libdw returns rows sorted by address,
@@ -658,17 +1470,20 @@ static void cu_rows_reserve(size_t rows)
 	cu_row_seq_end_cap = rows;
 }
 
-/* Size of the symbol starting exactly at @offset, 0 if none. */
-static unsigned int symbol_extent_at(unsigned int offset)
+/* Size of the symbol starting exactly at (@section, @offset), 0 if none. */
+static unsigned int symbol_extent_at(unsigned int section, unsigned int offset)
 {
 	unsigned int low = 0, high = num_text_starts;
 
 	while (low < high) {
 		unsigned int mid = low + (high - low) / 2;
+		int cmp = compare_sec_off(text_starts[mid].section_id,
+					  text_starts[mid].offset,
+					  section, offset);
 
-		if (text_starts[mid].offset < offset)
+		if (cmp < 0)
 			low = mid + 1;
-		else if (text_starts[mid].offset > offset)
+		else if (cmp > 0)
 			high = mid;
 		else
 			return text_starts[mid].size;
@@ -694,13 +1509,16 @@ static bool starts_new_sequence(unsigned int group, unsigned int next,
 	unsigned long long end;
 	unsigned int size;
 
-	size = symbol_extent_at(entries[group].offset);
+	size = symbol_extent_at(entries[group].section_id,
+				entries[group].offset);
 	if (!size)
 		return false;
 
 	end = (unsigned long long)entries[group].offset + size;
 
 	for (unsigned int t = next; t < num_entries; t++) {
+		if (entries[t].section_id != entries[group].section_id)
+			break;
 		if (entries[t].offset > end)
 			break;
 		if (entries[t].offset < end || cu_row_seq_end[t - start])
@@ -734,6 +1552,7 @@ static void resolve_cu_row_groups(unsigned int start)
 		bool have_normal = false, have_seq_end = false;
 
 		while (k < num_entries &&
+		       entries[k].section_id == entries[i].section_id &&
 		       entries[k].offset == entries[i].offset) {
 			if (cu_row_seq_end[k - start]) {
 				seq_end = k;
@@ -770,6 +1589,7 @@ static void resolve_cu_row_groups(unsigned int start)
  * which is why synthesize_symbol_starts() asks for this.
  */
 struct asm_span {
+	unsigned int section_id;
 	unsigned int lo;
 	unsigned int hi;
 };
@@ -782,26 +1602,26 @@ static int compare_asm_spans(const void *a, const void *b)
 {
 	const struct asm_span *sa = a, *sb = b;
 
-	if (sa->lo != sb->lo)
-		return sa->lo < sb->lo ? -1 : 1;
-	return 0;
+	return compare_sec_off(sa->section_id, sa->lo, sb->section_id, sb->lo);
 }
 
-/* True if an assembler unit describes @offset. */
-static bool in_asm_span(unsigned int offset)
+/* True if an assembler unit describes (@section, @offset). */
+static bool in_asm_span(unsigned int section, unsigned int offset)
 {
 	unsigned int low = 0, high = num_asm_spans;
 
 	while (low < high) {
 		unsigned int mid = low + (high - low) / 2;
 
-		if (asm_spans[mid].lo <= offset)
+		if (compare_sec_off(asm_spans[mid].section_id,
+				    asm_spans[mid].lo, section, offset) <= 0)
 			low = mid + 1;
 		else
 			high = mid;
 	}
 
-	return low && offset <= asm_spans[low - 1].hi;
+	return low && asm_spans[low - 1].section_id == section &&
+	       offset <= asm_spans[low - 1].hi;
 }
 
 /*
@@ -816,19 +1636,22 @@ static void record_cu_asm_spans(unsigned int start, unsigned int first_seq_end)
 	unsigned int i = start;
 
 	while (i < num_entries) {
-		unsigned int j = i, hi;
+		unsigned int sec = entries[i].section_id, j = i, hi;
 
-		while (!cu_row_seq_end[j - start] && j + 1 < num_entries)
+		while (!cu_row_seq_end[j - start] && j + 1 < num_entries &&
+		       entries[j + 1].section_id == sec)
 			j++;
 
 		hi = entries[j].offset;
 		if (!cu_row_seq_end[j - start]) {
 			for (unsigned int t = first_seq_end; t < num_seq_ends;
 			     t++) {
-				if (seq_ends[t] <= hi)
+				if (seq_ends[t].section_id != sec ||
+				    seq_ends[t].offset <= hi)
 					continue;
-				if (hi == entries[j].offset || seq_ends[t] < hi)
-					hi = seq_ends[t];
+				if (hi == entries[j].offset ||
+				    seq_ends[t].offset < hi)
+					hi = seq_ends[t].offset;
 			}
 		}
 
@@ -838,6 +1661,7 @@ static void record_cu_asm_spans(unsigned int start, unsigned int first_seq_end)
 			asm_spans = xrealloc(asm_spans, asm_spans_capacity *
 						       sizeof(*asm_spans));
 		}
+		asm_spans[num_asm_spans].section_id = sec;
 		asm_spans[num_asm_spans].lo = entries[i].offset;
 		asm_spans[num_asm_spans].hi = hi;
 		num_asm_spans++;
@@ -845,7 +1669,9 @@ static void record_cu_asm_spans(unsigned int start, unsigned int first_seq_end)
 	}
 }
 
-static void process_dwarf(Dwarf *dwarf, unsigned long long text_addr)
+static void process_dwarf(Dwarf *dwarf, unsigned long long text_addr,
+			  struct covered_section *sections,
+			  unsigned int num_sections)
 {
 	Dwarf_Off off = 0, next_off;
 	size_t hdr_size;
@@ -877,7 +1703,8 @@ static void process_dwarf(Dwarf *dwarf, unsigned long long text_addr)
 			Dwarf_Addr addr;
 			const char *src;
 			const char *rel;
-			unsigned int file_id, loffset;
+			unsigned int file_id, loffset, sec_id;
+			unsigned long long sec_off;
 			bool endseq = false;
 			int lineno;
 
@@ -900,7 +1727,8 @@ static void process_dwarf(Dwarf *dwarf, unsigned long long text_addr)
 			 * above it.
 			 */
 			if (dwarf_lineendsequence(line, &endseq) == 0 && endseq) {
-				record_seq_end(addr, text_addr);
+				classify_seq_end(addr, text_addr, sections,
+						 num_sections);
 				lineno = 0;
 			} else if (dwarf_lineno(line, &lineno) != 0) {
 				continue;
@@ -920,26 +1748,55 @@ static void process_dwarf(Dwarf *dwarf, unsigned long long text_addr)
 			if (!src && lineno)
 				continue;
 
-			if (addr < text_addr)
-				continue;
-			/*
-			 * Skip addresses past _etext.  Sections after .rodata
-			 * shift when the real lineinfo replaces the empty stub
-			 * during the multi-pass vmlinux link, so any address
-			 * we'd capture there would be stale by the time the
-			 * final kernel runs.
-			 */
-			if (text_end_addr && addr >= text_end_addr)
-				continue;
-
-			{
-				unsigned long long raw_offset = addr - text_addr;
+			if (module_mode) {
+				/*
+				 * In ET_REL .ko files .text/.init.text/.exit.text
+				 * all share sh_addr == 0; classify_address picks
+				 * the right bucket from the explicit ranges we
+				 * captured.  An end_sequence row addresses the
+				 * byte after the sequence, which for a sequence
+				 * reaching the end of its section is the first
+				 * byte of whichever section got the next bias.
+				 * Resolve those from the last byte they cover.
+				 */
+				if (endseq && !addr)
+					continue;
+				sec_id = classify_address(sections, num_sections,
+							  endseq ? addr - 1 : addr,
+							  &sec_off);
+				if (sec_id == num_sections) {
+					skipped_uncovered++;
+					continue;
+				}
+				if (endseq)
+					sec_off++;
+				if (sec_off > UINT_MAX) {
+					skipped_overflow++;
+					continue;
+				}
+				loffset = (unsigned int)sec_off;
+				sections[sec_id].n_entries++;
+			} else {
+				unsigned long long raw_offset;
 
+				if (addr < text_addr)
+					continue;
+				/*
+				 * Skip addresses past _etext.  Sections after
+				 * .rodata shift when the real lineinfo replaces
+				 * the empty stub during the multi-pass vmlinux
+				 * link, so any address we'd capture there would
+				 * be stale by the time the final kernel runs.
+				 */
+				if (text_end_addr && addr >= text_end_addr)
+					continue;
+				raw_offset = addr - text_addr;
 				if (raw_offset > UINT_MAX) {
 					skipped_overflow++;
 					continue;
 				}
 				loffset = (unsigned int)raw_offset;
+				sec_id = 0;
 			}
 
 			if (src) {
@@ -949,7 +1806,7 @@ static void process_dwarf(Dwarf *dwarf, unsigned long long text_addr)
 				file_id = 0;
 			}
 
-			add_entry(loffset, file_id, (unsigned int)lineno);
+			add_entry(loffset, sec_id, file_id, (unsigned int)lineno);
 			cu_row_seq_end[num_entries - 1 - cu_first_entry] = endseq;
 		}
 
@@ -967,22 +1824,25 @@ static void process_dwarf(Dwarf *dwarf, unsigned long long text_addr)
 	}
 }
 
-/* True if some line-program sequence ends in (@lo, @hi]. */
-static bool seq_end_between(unsigned int lo, unsigned int hi)
+/* True if some sequence in @section ends in (@lo, @hi]. */
+static bool seq_end_between(unsigned int section, unsigned int lo,
+			    unsigned int hi)
 {
 	unsigned int low = 0, high = num_seq_ends;
 
-	/* First index whose value exceeds @lo. */
+	/* First index past (@section, @lo). */
 	while (low < high) {
 		unsigned int mid = low + (high - low) / 2;
 
-		if (seq_ends[mid] <= lo)
+		if (compare_sec_off(seq_ends[mid].section_id,
+				    seq_ends[mid].offset, section, lo) <= 0)
 			low = mid + 1;
 		else
 			high = mid;
 	}
 
-	return low < num_seq_ends && seq_ends[low] <= hi;
+	return low < num_seq_ends && seq_ends[low].section_id == section &&
+	       seq_ends[low].offset <= hi;
 }
 
 /*
@@ -1017,22 +1877,31 @@ static void synthesize_symbol_starts(void)
 	if (!base_entries || !num_sym_starts)
 		return;
 
-	sort_unique(seq_ends, &num_seq_ends);
+	qsort(seq_ends, num_seq_ends, sizeof(*seq_ends), compare_seq_ends);
 	qsort(asm_spans, num_asm_spans, sizeof(*asm_spans), compare_asm_spans);
 
 	for (unsigned int i = 0; i < num_sym_starts; i++) {
+		unsigned int sec = sym_starts[i].section_id;
 		unsigned int start = sym_starts[i].offset;
 		unsigned int end = start + sym_starts[i].size;
 
+		/*
+		 * Both arrays are sorted by (section_id, offset), so one
+		 * forward cursor tracks the last entry at or below the symbol.
+		 */
 		while (cursor + 1 < base_entries &&
-		       entries[cursor + 1].offset <= start)
+		       compare_sec_off(entries[cursor + 1].section_id,
+				       entries[cursor + 1].offset,
+				       sec, start) <= 0)
 			cursor++;
 
+		if (entries[cursor].section_id != sec)
+			continue;	/* no entries in this section yet */
 		if (entries[cursor].offset > start)
 			continue;	/* nothing covers this symbol */
 		if (entries[cursor].offset == start)
 			continue;	/* already has its own entry */
-		if (seq_end_between(entries[cursor].offset, start))
+		if (seq_end_between(sec, entries[cursor].offset, start))
 			continue;	/* coverage stopped before here */
 
 		if (end <= start)
@@ -1044,16 +1913,19 @@ static void synthesize_symbol_starts(void)
 		 * it came from.  In assembly it is one macro expanding to a
 		 * function per invocation, which the row does describe.
 		 */
-		if (!in_asm_span(start) &&
+		if (!in_asm_span(sec, start) &&
 		    (cursor + 1 >= base_entries ||
+		     entries[cursor + 1].section_id != sec ||
 		     entries[cursor + 1].offset >= end))
 			continue;
 
-		add_entry(start, entries[cursor].file_id, entries[cursor].line);
+		add_entry(start, sec, entries[cursor].file_id,
+			  entries[cursor].line);
 	}
 }
 
-static void deduplicate(void)
+static void deduplicate(struct covered_section *sections,
+			unsigned int num_sections)
 {
 	unsigned int sym_cursor = 0;
 	unsigned int i, j;
@@ -1061,14 +1933,25 @@ static void deduplicate(void)
 	if (num_entries < 2)
 		return;
 
-	/* Sort by offset, then file_id, then line for stability */
+	/*
+	 * Sort by section_id, then offset, then file_id, line.  This groups
+	 * each section's entries contiguously so the per-section emit can
+	 * iterate a simple range, and ensures the binary search invariant
+	 * (offsets ascending) holds within each section.
+	 */
 	qsort(entries, num_entries, sizeof(*entries), compare_entries);
 
 	synthesize_symbol_starts();
 	qsort(entries, num_entries, sizeof(*entries), compare_entries);
 
 	/*
-	 * Remove duplicate entries:
+	 * Remove duplicates.  Reset on a section_id boundary: the same offset
+	 * can legitimately appear in two different sections (they all start
+	 * at sh_addr 0 in ET_REL), and the "same as previous kept entry"
+	 * collapse is only meaningful inside one section's binary-search
+	 * domain.
+	 *
+	 * Within a section:
 	 * - Same offset: keep last.  Earlier rows at that address cover no
 	 *   bytes, so the final one is what describes the instruction, and
 	 *   it is what addr2line reports.  For an inlined call that is the
@@ -1084,6 +1967,12 @@ static void deduplicate(void)
 	for (i = 1; i < num_entries; i++) {
 		bool at_symbol_start;
 
+		if (entries[i].section_id != entries[j].section_id) {
+			j++;
+			if (j != i)
+				entries[j] = entries[i];
+			continue;
+		}
 		if (entries[i].offset == entries[j].offset) {
 			/*
 			 * Rows from different compile units can share an
@@ -1098,10 +1987,16 @@ static void deduplicate(void)
 		}
 
 		while (sym_cursor < num_sym_starts &&
-		       sym_starts[sym_cursor].offset < entries[i].offset)
+		       compare_sec_off(sym_starts[sym_cursor].section_id,
+				       sym_starts[sym_cursor].offset,
+				       entries[i].section_id,
+				       entries[i].offset) < 0)
 			sym_cursor++;
 		at_symbol_start = sym_cursor < num_sym_starts &&
-				  sym_starts[sym_cursor].offset == entries[i].offset;
+				  !compare_sec_off(sym_starts[sym_cursor].section_id,
+						   sym_starts[sym_cursor].offset,
+						   entries[i].section_id,
+						   entries[i].offset);
 
 		if (!at_symbol_start &&
 		    entries[i].file_id == entries[j].file_id &&
@@ -1113,6 +2008,14 @@ static void deduplicate(void)
 			entries[j] = entries[i];
 	}
 	num_entries = j + 1;
+
+	/* Recompute per-section n_entries from the deduped array. */
+	if (sections) {
+		for (unsigned int k = 0; k < num_sections; k++)
+			sections[k].n_entries = 0;
+		for (i = 0; i < num_entries; i++)
+			sections[entries[i].section_id].n_entries++;
+	}
 }
 
 static void compute_file_offsets(void)
@@ -1210,6 +2113,206 @@ static void output_assembly(void)
 	printf("\n");
 }
 
+/*
+ * Emit one per-section table in the simple flat-array layout:
+ *
+ *   mod_lineinfo_header
+ *   addrs[count]    (u32, sorted)
+ *   file_ids[count] (u16) + 2-byte pad if count is odd
+ *   lines[count]    (u32)
+ *   file_offsets[]  (u32)
+ *   filenames[]
+ *
+ * @suffix uniquifies labels so multiple tables can coexist in one blob.
+ * Caller has sorted entries[] so this section's entries occupy [first,
+ * first + count).
+ */
+static void emit_section_table(unsigned int first, unsigned int count,
+			       const char *suffix)
+{
+	/*
+	 * Align before defining the label, not after: the descriptor stores
+	 * table_offset as .Lhdr - .Lroot, and every field offset inside the
+	 * header is measured from .Lhdr too.  Emitting the label first binds
+	 * it to the pre-padding address, so the kernel would read the header
+	 * out of the padding bytes.
+	 */
+	printf("\t.balign 4\n");
+	printf(".Lhdr%s:\n", suffix);
+	printf("\t.long %u\t\t/* num_entries */\n", count);
+	printf("\t.long %u\t\t/* num_files */\n", num_files);
+	printf("\t.long .Lfilenames_end%s - .Lfilenames%s\n\n", suffix, suffix);
+
+	/* addrs[] */
+	for (unsigned int i = 0; i < count; i++)
+		printf("\t.long 0x%x\n", entries[first + i].offset);
+
+	/* file_ids[] */
+	for (unsigned int i = 0; i < count; i++)
+		printf("\t.short %u\n", entries[first + i].file_id);
+	if (count & 1)
+		printf("\t.short 0\t\t/* pad to align lines[] */\n");
+
+	/* lines[] */
+	for (unsigned int i = 0; i < count; i++)
+		printf("\t.long %u\n", entries[first + i].line);
+
+	/* file_offsets[] */
+	printf("\t.balign 4\n");
+	for (unsigned int i = 0; i < num_files; i++)
+		printf("\t.long %u\n", files[i]->str_offset);
+
+	/* filenames[] */
+	printf(".Lfilenames%s:\n", suffix);
+	for (unsigned int i = 0; i < num_files; i++)
+		print_escaped_asciz(files[i]->name);
+	printf(".Lfilenames_end%s:\n", suffix);
+}
+
+/*
+ * Emit one mod_lineinfo_section descriptor.  The "anchor" field is a
+ * relocation against the named ELF section symbol; the module loader
+ * resolves it on load to the runtime base of that section.
+ *
+ * On 64-bit ELF: 8-byte slot via .quad <name> (R_*_64 reloc).
+ * On 32-bit ELF: 4-byte reloc via .long <name>, plus 4 bytes of zero
+ * padding.  The two halves are ordered to match target endianness so a
+ * naive u64 read on the kernel side recovers the relocated value.
+ */
+static void emit_section_descriptor(const char *section_name,
+				    unsigned long long size,
+				    const char *table_label,
+				    const char *root_label)
+{
+	if (target_64bit) {
+		printf("\t.quad %s\t/* sections[].anchor (RELOC) */\n",
+		       section_name);
+	} else if (target_le) {
+		printf("\t.long %s\t/* sections[].anchor low (RELOC) */\n",
+		       section_name);
+		printf("\t.long 0\t\t/* sections[].anchor high pad */\n");
+	} else {
+		printf("\t.long 0\t\t/* sections[].anchor high pad */\n");
+		printf("\t.long %s\t/* sections[].anchor low (RELOC) */\n",
+		       section_name);
+	}
+	printf("\t.long %llu\t/* sections[].size */\n", size);
+	printf("\t.long %s - %s\t/* sections[].table_offset */\n",
+	       table_label, root_label);
+}
+
+/*
+ * Emit one .mod_lineinfo / .init.mod_lineinfo blob.  Walks all_sections[]
+ * picking only entries that (a) belong to the requested blob and (b)
+ * actually produced at least one DWARF line entry — sections present in
+ * the .ko but without DWARF (e.g. compiler-generated stub thunks) are
+ * silently skipped.  The caller-supplied entries[] is already sorted by
+ * section_id, so each section's entries are contiguous; we walk the
+ * master array in order to compute per-section starting indices.
+ */
+static void emit_blob(const char *output_section,
+		      const char *blob_tag,
+		      enum mod_lineinfo_blob blob)
+{
+	unsigned int active = 0;
+	unsigned int section_starts[ALL_SECTIONS];
+	unsigned int cursor = 0;
+
+	for (unsigned int i = 0; i < ALL_SECTIONS; i++) {
+		section_starts[i] = cursor;
+		cursor += all_sections[i].n_entries;
+		if (all_sections[i].blob == blob && all_sections[i].n_entries)
+			active++;
+	}
+
+	if (!active)
+		return;
+
+	printf("\t.section %s, \"a\"\n\n", output_section);
+
+	printf("\t.balign 8\n");
+	printf(".Lroot_%s:\n", blob_tag);
+	printf("\t.long %u\t\t/* num_sections */\n", active);
+	/* Pad to align the u64 anchor in sections[0] to 8 bytes. */
+	printf("\t.balign 8\n");
+
+	{
+		unsigned int slot = 0;
+		for (unsigned int i = 0; i < ALL_SECTIONS; i++) {
+			char table_label[64];
+			char root_label[64];
+
+			if (all_sections[i].blob != blob)
+				continue;
+			if (!all_sections[i].n_entries)
+				continue;
+			snprintf(table_label, sizeof(table_label),
+				 ".Lhdr_%s_%u", blob_tag, slot);
+			snprintf(root_label, sizeof(root_label),
+				 ".Lroot_%s", blob_tag);
+			emit_section_descriptor(all_sections[i].name,
+						all_sections[i].size,
+						table_label, root_label);
+			slot++;
+		}
+	}
+	printf("\n");
+
+	{
+		unsigned int slot = 0;
+
+		for (unsigned int i = 0; i < ALL_SECTIONS; i++) {
+			char suffix[64];
+
+			if (all_sections[i].blob != blob)
+				continue;
+			if (!all_sections[i].n_entries)
+				continue;
+			snprintf(suffix, sizeof(suffix), "_%s_%u",
+				 blob_tag, slot);
+			emit_section_table(section_starts[i],
+					   all_sections[i].n_entries,
+					   suffix);
+			slot++;
+		}
+	}
+	printf("\n");
+}
+
+/*
+ * Declare each text-like section we plan to reference as an empty
+ * SHF_EXECINSTR section in this object.  Without these stanzas the
+ * assembler treats `.quad .exit.text` as an undefined external symbol;
+ * after ld -r the resulting GLOBAL UND `.exit.text` doesn't bind to the
+ * .ko's LOCAL SECTION symbol of the same name, leaving depmod with an
+ * unresolved-symbol warning and the loader unable to relocate the anchor.
+ *
+ * Declaring the section here gives lineinfo.o its own local SECTION
+ * symbol; ld -r merges sections by name so the local symbol simply
+ * relocates to offset 0 of the merged section (lineinfo.o is linked
+ * FIRST so its zero-byte contribution stays at the start).
+ */
+static void declare_empty_text_sections(void)
+{
+	for (unsigned int i = 0; i < ALL_SECTIONS; i++) {
+		if (!all_sections[i].present)
+			continue;
+		printf("\t.section %s, \"ax\"\n", all_sections[i].name);
+	}
+	printf("\n");
+}
+
+static void output_module_assembly(void)
+{
+	printf("/* SPDX-License-Identifier: GPL-2.0 */\n");
+	printf("/*\n");
+	printf(" * Automatically generated by scripts/gen_lineinfo --module\n");
+	printf(" * Do not edit.\n");
+	printf(" */\n\n");
+
+	declare_empty_text_sections();
+}
+
 int main(int argc, char *argv[])
 {
 	const char *kbuild_verbose = getenv("KBUILD_VERBOSE");
@@ -1228,8 +2331,15 @@ int main(int argc, char *argv[])
 		argc--;
 	}
 
+	if (argc >= 2 && !strcmp(argv[1], "--module")) {
+		module_mode = 1;
+		argv++;
+		argc--;
+	}
+
 	if (argc != 2) {
-		fprintf(stderr, "Usage: %s [-v] <vmlinux>\n", argv[0]);
+		fprintf(stderr, "Usage: %s [-v] [--module] <ELF file>\n",
+			argv[0]);
 		return 1;
 	}
 
@@ -1240,13 +2350,42 @@ int main(int argc, char *argv[])
 		error("cannot open %s: %s", argv[1], strerror(errno));
 
 	elf_version(EV_CURRENT);
-	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
+	/*
+	 * Module mode patches line-program addresses in the in-memory ELF
+	 * data and must never write them back.  A private copy-on-write
+	 * mapping gives exactly that, so the .ko can stay open read-only.
+	 */
+	elf = elf_begin(fd, module_mode ? ELF_C_READ_MMAP_PRIVATE :
+					  ELF_C_READ_MMAP, NULL);
 	if (!elf)
 		error("elf_begin failed: %s", elf_errmsg(elf_errno()));
 
-	text_addr = find_text_addr(elf);
-	text_end_addr = find_text_end_addr(elf);
-	collect_symbol_starts(elf, text_addr);
+	{
+		GElf_Ehdr ehdr;
+
+		if (gelf_getehdr(elf, &ehdr) == NULL)
+			error("gelf_getehdr failed");
+		target_64bit = (ehdr.e_ident[EI_CLASS] == ELFCLASS64);
+		target_le = (ehdr.e_ident[EI_DATA] == ELFDATA2LSB);
+	}
+
+	if (module_mode) {
+		/*
+		 * .ko files are ET_REL after ld -r.  Resolve covered text
+		 * sections FIRST so apply_debug_relocations() can use the
+		 * assigned biases when patching line-program addresses;
+		 * libdw does NOT apply relocations for ET_REL files, so we
+		 * patch every debug section it reads.
+		 */
+		resolve_covered_sections(elf, all_sections, ALL_SECTIONS);
+		apply_debug_relocations(elf);
+		text_addr = 0;	/* unused in module mode */
+	} else {
+		text_addr = find_text_addr(elf);
+		text_end_addr = find_text_end_addr(elf);
+	}
+
+	collect_symbol_starts(elf, text_addr, all_sections, ALL_SECTIONS);
 
 	dwarf = dwarf_begin_elf(elf, DWARF_C_READ, NULL);
 	if (!dwarf)
@@ -1254,18 +2393,59 @@ int main(int argc, char *argv[])
 		      LINEINFO_PREFIX "error: is %s built with CONFIG_DEBUG_INFO?",
 		      dwarf_errmsg(dwarf_errno()), argv[1]);
 
-	process_dwarf(dwarf, text_addr);
+	if (module_mode) {
+		unsigned int persistent_total, init_total;
 
-	if (skipped_overflow)
-		warn("%u entries skipped (offset > 4 GiB from _text)",
-		     skipped_overflow);
+		output_module_assembly();	/* file header only */
 
-	deduplicate();
-	compute_file_offsets();
+		/*
+		 * Single DWARF pass classifies every line entry into its
+		 * covering section (or skips it).  Each entry is tagged with
+		 * the master-array section_id so per-blob emit can filter.
+		 */
+		process_dwarf(dwarf, 0, all_sections, ALL_SECTIONS);
+		deduplicate(all_sections, ALL_SECTIONS);
+		compute_file_offsets();
+
+		emit_blob(".mod_lineinfo", "p", BLOB_PERSISTENT);
+		emit_blob(".init.mod_lineinfo", "i", BLOB_INIT);
+
+		persistent_total = 0;
+		init_total = 0;
+		for (unsigned int i = 0; i < ALL_SECTIONS; i++) {
+			if (all_sections[i].blob == BLOB_PERSISTENT)
+				persistent_total += all_sections[i].n_entries;
+			else if (all_sections[i].blob == BLOB_INIT)
+				init_total += all_sections[i].n_entries;
+		}
+		verbose_msg("persistent %u entries, init %u entries, %u files",
+			    persistent_total, init_total, num_files);
+
+		/*
+		 * Expected for every module: .static_call.text and friends
+		 * are deliberately not covered.
+		 */
+		if (skipped_uncovered)
+			verbose_msg("%llu entries dropped (outside covered text sections)",
+				    skipped_uncovered);
+
+		if (skipped_overflow)
+			warn("%u entries skipped (offset > 4 GiB)",
+			     skipped_overflow);
+	} else {
+		process_dwarf(dwarf, text_addr, NULL, 0);
+
+		if (skipped_overflow)
+			warn("%u entries skipped (offset > 4 GiB from _text)",
+			     skipped_overflow);
+
+		deduplicate(NULL, 0);
+		compute_file_offsets();
 
-	verbose_msg("%u entries, %u files", num_entries, num_files);
+		verbose_msg("%u entries, %u files", num_entries, num_files);
 
-	output_assembly();
+		output_assembly();
+	}
 
 	dwarf_end(dwarf);
 	elf_end(elf);
@@ -1275,9 +2455,11 @@ int main(int argc, char *argv[])
 	free(entries);
 	free(sym_starts);
 	free(seq_ends);
+	free(extra_sections);
 	for (unsigned int i = 0; i < num_files; i++)
 		free(files[i]);
 	free(files);
-
+	for (unsigned int i = 0; i < num_path_roots; i++)
+		free(path_roots[i].path);
 	return 0;
 }
-- 
2.53.0

