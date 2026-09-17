Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB5538D82;
	Thu, 17 Sep 2026 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652267; cv=none; b=ZwDjgEJcVDmg0bkwldQvu2svls3nHwd/0F/vtyMg9Xov3ln/EE/H8nDMAiV8Y3pCj1DeSxdbTS/xKKNiAw2/H1HtwwQumIZnihgzynNs41214FmJ60WP3tE9v45k4IK7297iCygrADsfh4cMFGrhnkEE1q+fkkM5KCgugUfIGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652267; c=relaxed/simple;
	bh=csxLnn1IhDiEA7YucJ3LrFlwv60uMEb770WvnTp9ipY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnnKlPVie+qLk/7IQkXRS1IqG1hpm6rnMApEblnQErTPjmcEjJZCZWH5T8hwwBEkDbex8IsOL/teJhs6fuLLi6+vAi2OmLOPEvl/H8mWd7JRupro9DeGL19uL4S7H6pdBokJdX0qUvsYvtLmdf1/QWZ0NIOsTkW06CsX8P3kyME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1XqgfB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1XqgfB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCC61F00893;
	Thu, 17 Sep 2026 13:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789652255;
	bh=F5cDm6bMYJcAaIJ0jdRTjHRHP0447s6h8g3zSCS3fxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W1XqgfB/3qu6lRw7lWtpZP0rbuj1Za1kHuFDvd04u/s9XorJ9IjgA0eYdEnILSDeu
	 8/vKdRIqxOo0yxISFY1bRYIjDdx1WvtThgB1w3+iLPPMYdwS1PJGHHQmGDiCnRUAnG
	 AmMtt4UH5BG8rk0lDqUM+Ak6fGGrhEzMil+D/f9QqgRZ2AB1G4B08Qqh1FbuGrR0EP
	 b6athMlnjWD+bJiEpvuJ1af+oIAkDNNLI+o3CrgXjA6c/kjT4/Nl3TNbeKXLf6MPMf
	 e7b6YAEUpWIHo+2DtynDk8vp8DVzvfH0WIS28kZguuqrWqcjrBiGVf06jKJ0Ljf9Vo
	 nKiRU3RaAtylA==
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
Subject: [PATCH v9 1/4] kallsyms: embed source file:line info in kernel stack traces
Date: Thu, 17 Sep 2026 09:37:22 -0400
Message-ID: <20260917133727.428546-2-sashal@kernel.org>
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

Add CONFIG_KALLSYMS_LINEINFO, which embeds a compact address-to-line
lookup table in the kernel image so stack traces directly print source
file and line number information:

  root@localhost:~# echo c > /proc/sysrq-trigger
  [   11.201987] sysrq: Trigger a crash
  [   11.202831] Kernel panic - not syncing: sysrq triggered crash
  [   11.206218] Call Trace:
  [   11.206501]  <TASK>
  [   11.206749]  dump_stack_lvl+0x5d/0x80 (lib/dump_stack.c:94)
  [   11.207403]  vpanic+0x36e/0x620 (kernel/panic.c:650)
  [   11.208565]  ? __lock_acquire+0x465/0x2240 (kernel/locking/lockdep.c:4674)
  [   11.209324]  panic+0xc9/0xd0 (kernel/panic.c:787)
  [   11.211873]  ? find_held_lock+0x2b/0x80 (kernel/locking/lockdep.c:5350)
  [   11.212597]  ? lock_release+0xd3/0x300 (kernel/locking/lockdep.c:5535)
  [   11.213312]  sysrq_handle_crash+0x1a/0x20 (drivers/tty/sysrq.c:154)
  [   11.214005]  __handle_sysrq.cold+0x66/0x256 (drivers/tty/sysrq.c:611)
  [   11.214712]  write_sysrq_trigger+0x65/0x80 (drivers/tty/sysrq.c:1221)
  [   11.215424]  proc_reg_write+0x1bd/0x3c0 (fs/proc/inode.c:330)
  [   11.216061]  vfs_write+0x1c6/0xff0 (fs/read_write.c:686)
  [   11.218848]  ksys_write+0xfa/0x200 (fs/read_write.c:740)
  [   11.222394]  do_syscall_64+0xf3/0x690 (arch/x86/entry/syscall_64.c:63)
  [   11.223942]  entry_SYSCALL_64_after_hwframe+0x77/0x7f (arch/x86/entry/entry_64.S:121)

At build time, a new host tool (scripts/gen_lineinfo) reads DWARF
.debug_line from vmlinux using libdw (elfutils), extracts all
address-to-file:line mappings, and generates an assembly file with
sorted parallel arrays (offsets from _text, file IDs, and line
numbers). These are linked into vmlinux as .rodata.

At runtime, kallsyms_lookup_lineinfo() does a binary search on the
table and __sprint_symbol() appends "(file:line)" to each stack frame.
The lookup uses offsets from _text so it works with KASLR, requires no
locks or allocations, and is safe in any context including panic.

The suffix is appended for every symbol variant that already prints an
offset, so %pS, %pSb and the %pB backtrace forms all carry it: arm64
prints frames with %pSb and the generic stack_trace_print() uses %pS.
sprint_symbol_no_offset(), which backs lowercase %ps, stays bare
because callers suffix it with a literal "()".

A line program emits several rows per address, and every row but the
last covers zero bytes, so the generator keeps the last row at each
address.  That is the row addr2line reports, and for an inlined call it
names the inlined body rather than the call site.

Rows the compiler marks with line 0 declare that no source location
applies from there on (DWARF5 6.2.2), and the end of a line program's
sequence says the same of the bytes past it.  Both are kept, as entries
whose line is zero that the lookup reads as "no annotation", so an
address the compiler deliberately left unattributed reports nothing
instead of inheriting the line above it.

The feature requires CONFIG_DEBUG_INFO (for DWARF data) and libelf
and libdw (from elfutils) on the build host.

Memory footprint, measured with:

  make ARCH=x86_64 O=$B defconfig
  ./scripts/config --file $B/.config -e DEBUG_INFO \
                                     -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
  make ARCH=x86_64 O=$B olddefconfig && make ARCH=x86_64 O=$B -j$(nproc)
  strip -g $B/vmlinux -o vmlinux.nodbg && stat -c %s vmlinux.nodbg

  Table: 1,657,663 entries from 4,234 source files
    lineinfo_addrs[]     1,657,663 x u32  =  6.3 MiB
    lineinfo_file_ids[]  1,657,663 x u16  =  3.2 MiB
    lineinfo_lines[]     1,657,663 x u32  =  6.3 MiB
    file_offsets + filenames              =  0.1 MiB
    Total .rodata increase:               = 15.9 MiB

  vmlinux (stripped):  52.2 MiB -> 68.2 MiB  (+16.0 MiB / +30.6%)

That is the cost of the uncompressed format introduced here; the delta
compression added later in this series brings it down to +8.0 MiB
(+15.3%) on the same config.

Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/index.rst           |    1 +
 .../admin-guide/kallsyms-lineinfo.rst         |   72 +
 MAINTAINERS                                   |    6 +
 include/linux/kallsyms.h                      |   18 +-
 init/Kconfig                                  |   20 +
 kernel/kallsyms.c                             |  113 +-
 kernel/kallsyms_internal.h                    |    9 +
 scripts/.gitignore                            |    1 +
 scripts/Makefile                              |    3 +
 scripts/empty_lineinfo.S                      |   30 +
 scripts/gen_lineinfo.c                        | 1283 +++++++++++++++++
 scripts/kallsyms.c                            |   11 +
 scripts/link-vmlinux.sh                       |   88 +-
 13 files changed, 1644 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/admin-guide/kallsyms-lineinfo.rst
 create mode 100644 scripts/empty_lineinfo.S
 create mode 100644 scripts/gen_lineinfo.c

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index cd28dfe91b060..37456e08fe43c 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -73,6 +73,7 @@ problems and bugs in particular.
    ramoops
    dynamic-debug-howto
    init
+   kallsyms-lineinfo
    kdump/index
    perf/index
    pstore-blk
diff --git a/Documentation/admin-guide/kallsyms-lineinfo.rst b/Documentation/admin-guide/kallsyms-lineinfo.rst
new file mode 100644
index 0000000000000..549432cc4ea80
--- /dev/null
+++ b/Documentation/admin-guide/kallsyms-lineinfo.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
+Kallsyms Source Line Info (LINEINFO)
+====================================
+
+Overview
+========
+
+``CONFIG_KALLSYMS_LINEINFO`` embeds DWARF-derived source file and line number
+mappings into the kernel image so that stack traces include
+``(file.c:123)`` annotations next to each symbol.  This makes it significantly
+easier to pinpoint the exact source location during debugging, without needing
+to manually cross-reference addresses with ``addr2line``.
+
+Enabling the Feature
+====================
+
+Enable the following kernel configuration options::
+
+    CONFIG_KALLSYMS=y
+    CONFIG_DEBUG_INFO=y
+    CONFIG_KALLSYMS_LINEINFO=y
+
+Build dependency: the host tool ``scripts/gen_lineinfo`` requires ``libelf``
+and ``libdw`` from elfutils.  Install the development packages:
+
+- Debian/Ubuntu: ``apt install libdw-dev libelf-dev``
+- Fedora/RHEL: ``dnf install elfutils-devel elfutils-libelf-devel``
+- Arch Linux: ``pacman -S libelf``
+
+Example Output
+==============
+
+Without ``CONFIG_KALLSYMS_LINEINFO``::
+
+    Call Trace:
+     <TASK>
+     dump_stack_lvl+0x5d/0x80
+     do_syscall_64+0x82/0x190
+     entry_SYSCALL_64_after_hwframe+0x76/0x7e
+
+With ``CONFIG_KALLSYMS_LINEINFO``::
+
+    Call Trace:
+     <TASK>
+     dump_stack_lvl+0x5d/0x80 (lib/dump_stack.c:123)
+     do_syscall_64+0x82/0x190 (arch/x86/entry/common.c:52)
+     entry_SYSCALL_64_after_hwframe+0x76/0x7e
+
+Note that assembly routines (such as ``entry_SYSCALL_64_after_hwframe``) are
+not annotated because they lack DWARF debug information.
+
+Memory Overhead
+===============
+
+The lineinfo tables are stored in ``.rodata``.  On an x86_64 ``defconfig``
+with ``CONFIG_DEBUG_INFO`` they hold 1.66 million entries and grow the
+stripped image by 16 MiB, about 10 bytes per entry after deduplication.
+
+Known Limitations
+=================
+
+- **vmlinux only**: Only symbols in the core kernel image are annotated.
+  Module symbols are not covered.
+- **4 GiB offset limit**: Address offsets from ``_text`` are stored as 32-bit
+  values.  Entries beyond 4 GiB from ``_text`` are skipped at build time with
+  a warning.
+- **65535 file limit**: Source file IDs are stored as 16-bit values.  Builds
+  with more than 65535 unique source files will fail with an error.
+- **No assembly annotations**: Functions implemented in assembly that lack
+  DWARF ``.debug_line`` data are not annotated.
diff --git a/MAINTAINERS b/MAINTAINERS
index c2414447892c2..7768ef11e8a73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14023,6 +14023,12 @@ S:	Maintained
 F:	Documentation/hwmon/k8temp.rst
 F:	drivers/hwmon/k8temp.c
 
+KALLSYMS LINEINFO
+M:	Sasha Levin <sashal@kernel.org>
+S:	Maintained
+F:	Documentation/admin-guide/kallsyms-lineinfo.rst
+F:	scripts/gen_lineinfo.c
+
 KANDOU KB9002 PCIE RETIMER HWMON DRIVER
 M:	Andy Chung <andy.chung@amd.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index d5dd54c53ace6..53cc25a6e85d9 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -16,10 +16,15 @@
 #include <asm/sections.h>
 
 #define KSYM_NAME_LEN 512
+
+/* Extra space for " (path/to/file.c:12345)" suffix when lineinfo is enabled */
+#define KSYM_LINEINFO_LEN (IS_ENABLED(CONFIG_KALLSYMS_LINEINFO) ? 128 : 0)
+
 #define KSYM_SYMBOL_LEN (sizeof("%s+%#lx/%#lx [%s %s]") + \
 			(KSYM_NAME_LEN - 1) + \
 			2*(BITS_PER_LONG*3/10) + (MODULE_NAME_LEN - 1) + \
-			(BUILD_ID_SIZE_MAX * 2) + 1)
+			(BUILD_ID_SIZE_MAX * 2) + 1 + \
+			KSYM_LINEINFO_LEN)
 
 struct cred;
 struct module;
@@ -96,6 +101,9 @@ extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
 
 int lookup_symbol_name(unsigned long addr, char *symname);
 
+bool kallsyms_lookup_lineinfo(unsigned long addr, unsigned long sym_start,
+			      const char **file, unsigned int *line);
+
 #else /* !CONFIG_KALLSYMS */
 
 static inline unsigned long kallsyms_lookup_name(const char *name)
@@ -164,6 +172,14 @@ static inline int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline bool kallsyms_lookup_lineinfo(unsigned long addr,
+					    unsigned long sym_start,
+					    const char **file,
+					    unsigned int *line)
+{
+	return false;
+}
 #endif /*CONFIG_KALLSYMS*/
 
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
diff --git a/init/Kconfig b/init/Kconfig
index 8583d9f06c522..fbf838d001490 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2132,6 +2132,26 @@ config KALLSYMS_ALL
 
 	  Say N unless you really need all symbols, or kernel live patching.
 
+config KALLSYMS_LINEINFO
+	bool "Embed source file:line information in stack traces"
+	depends on KALLSYMS && DEBUG_INFO
+	help
+	  Embeds an address-to-source-line mapping table in the kernel
+	  image so that stack traces directly include file:line information,
+	  similar to what scripts/decode_stacktrace.sh provides but without
+	  needing external tools or a vmlinux with debug info at runtime.
+
+	  When enabled, stack traces will look like:
+
+	    kmem_cache_alloc_noprof+0x60/0x630 (mm/slub.c:3456)
+	    anon_vma_clone+0x2ed/0xcf0 (mm/rmap.c:412)
+
+	  This requires libelf and libdw (from elfutils) on the build host.
+	  Costs 10 bytes per DWARF line-table entry; for x86_64_defconfig
+	  with CONFIG_DEBUG_INFO that is about 18MB.
+
+	  If unsure, say N.
+
 # end of the "standard kernel features (expert users)" menu
 
 config ARCH_HAS_MEMBARRIER_CALLBACKS
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index aec2f06858afd..111df61749f2e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -467,13 +467,89 @@ static int append_buildid(char *buffer,   const char *modname,
 
 #endif /* CONFIG_STACKTRACE_BUILD_ID */
 
+bool kallsyms_lookup_lineinfo(unsigned long addr, unsigned long sym_start,
+			      const char **file, unsigned int *line)
+{
+	unsigned long raw_offset, raw_min;
+	unsigned int offset, min_offset = 0, low, high, mid, file_id;
+
+	if (!IS_ENABLED(CONFIG_KALLSYMS_LINEINFO) || !lineinfo_num_entries)
+		return false;
+
+	/* Compute offset from _text */
+	if (addr < (unsigned long)_text)
+		return false;
+
+	/*
+	 * Round-trip through unsigned int rather than comparing against
+	 * UINT_MAX: unsigned long is already 32 bits on 32-bit targets, so
+	 * that comparison would be dead code there.
+	 */
+	raw_offset = addr - (unsigned long)_text;
+	offset = raw_offset;
+	if (offset != raw_offset)
+		return false;
+
+	/*
+	 * The search below returns the closest entry at or below @offset, so
+	 * a symbol without line entries of its own (assembly without debug
+	 * info, or anything past the _etext cap like .init.text) would
+	 * inherit the last entry of whatever precedes it.  Bound the result
+	 * to entries at or above the resolved symbol's start.
+	 */
+	if (sym_start > (unsigned long)_text) {
+		raw_min = sym_start - (unsigned long)_text;
+
+		if (raw_min <= raw_offset)
+			min_offset = raw_min;
+	}
+
+	/* Binary search for largest entry <= offset */
+	low = 0;
+	high = lineinfo_num_entries;
+	while (low < high) {
+		mid = low + (high - low) / 2;
+		if (lineinfo_addrs[mid] <= offset)
+			low = mid + 1;
+		else
+			high = mid;
+	}
+
+	if (low == 0)
+		return false;
+	low--;
+
+	if (lineinfo_addrs[low] < min_offset)
+		return false;
+
+	/*
+	 * A zero line is the generator's "no source location applies here"
+	 * marker, taken straight from a DWARF line-0 row.
+	 */
+	if (!lineinfo_lines[low])
+		return false;
+
+	file_id = lineinfo_file_ids[low];
+	*line = lineinfo_lines[low];
+
+	if (file_id >= lineinfo_num_files)
+		return false;
+
+	if (lineinfo_file_offsets[file_id] >= lineinfo_filenames_size)
+		return false;
+
+	*file = &lineinfo_filenames[lineinfo_file_offsets[file_id]];
+	return true;
+}
+
 /* Look up a kernel symbol and return it in a text buffer. */
 static int __sprint_symbol(char *buffer, unsigned long address,
-			   int symbol_offset, int add_offset, int add_buildid)
+			   int symbol_offset, int add_offset, int add_buildid,
+			   int add_lineinfo)
 {
 	char *modname;
 	const unsigned char *buildid;
-	unsigned long offset, size;
+	unsigned long offset, size, sym_start;
 	int len;
 
 	/* Prevent module removal until modname and modbuildid are printed */
@@ -485,6 +561,7 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 	if (!len)
 		return sprintf(buffer, "0x%lx", address - symbol_offset);
 
+	sym_start = address - offset;
 	offset -= symbol_offset;
 
 	if (add_offset)
@@ -497,6 +574,28 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 		len += sprintf(buffer + len, "]");
 	}
 
+	/*
+	 * Annotate every caller that already prints an offset, which covers
+	 * %pS and %pSb as well as the %pB backtrace forms: arm64's
+	 * dump_backtrace_entry() prints frames with %pSb and the generic
+	 * stack_trace_print() uses %pS, so restricting this to the backtrace
+	 * entry points would leave both unannotated.
+	 *
+	 * sprint_symbol_no_offset() is the one variant left bare.  It backs
+	 * lowercase %ps, and existing format strings tack a literal "()"
+	 * onto that to denote a call ("foo() replaced with bar()"), which
+	 * "foo (file:line)()" would render unreadable.
+	 */
+	if (add_lineinfo && IS_ENABLED(CONFIG_KALLSYMS_LINEINFO) && !modname) {
+		const char *li_file;
+		unsigned int li_line;
+
+		if (kallsyms_lookup_lineinfo(address, sym_start,
+					     &li_file, &li_line))
+			len += scnprintf(buffer + len, KSYM_SYMBOL_LEN - len,
+					 " (%s:%u)", li_file, li_line);
+	}
+
 	return len;
 }
 
@@ -513,7 +612,7 @@ static int __sprint_symbol(char *buffer, unsigned long address,
  */
 int sprint_symbol(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 1, 0);
+	return __sprint_symbol(buffer, address, 0, 1, 0, 1);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol);
 
@@ -530,7 +629,7 @@ EXPORT_SYMBOL_GPL(sprint_symbol);
  */
 int sprint_symbol_build_id(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 1, 1);
+	return __sprint_symbol(buffer, address, 0, 1, 1, 1);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol_build_id);
 
@@ -547,7 +646,7 @@ EXPORT_SYMBOL_GPL(sprint_symbol_build_id);
  */
 int sprint_symbol_no_offset(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 0, 0);
+	return __sprint_symbol(buffer, address, 0, 0, 0, 0);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol_no_offset);
 
@@ -567,7 +666,7 @@ EXPORT_SYMBOL_GPL(sprint_symbol_no_offset);
  */
 int sprint_backtrace(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, -1, 1, 0);
+	return __sprint_symbol(buffer, address, -1, 1, 0, 1);
 }
 
 /**
@@ -587,7 +686,7 @@ int sprint_backtrace(char *buffer, unsigned long address)
  */
 int sprint_backtrace_build_id(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, -1, 1, 1);
+	return __sprint_symbol(buffer, address, -1, 1, 1, 1);
 }
 
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 81a867dbe57d4..d7374ce444d81 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -15,4 +15,13 @@ extern const u16 kallsyms_token_index[];
 extern const unsigned int kallsyms_markers[];
 extern const u8 kallsyms_seqs_of_names[];
 
+extern const u32 lineinfo_num_entries;
+extern const u32 lineinfo_addrs[];
+extern const u16 lineinfo_file_ids[];
+extern const u32 lineinfo_lines[];
+extern const u32 lineinfo_num_files;
+extern const u32 lineinfo_file_offsets[];
+extern const u32 lineinfo_filenames_size;
+extern const char lineinfo_filenames[];
+
 #endif // LINUX_KALLSYMS_INTERNAL_H_
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 4215c2208f7e4..e175714c18b61 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /asn1_compiler
+/gen_lineinfo
 /gen_packed_field_checks
 /generate_rust_target
 /insert-sys-cert
diff --git a/scripts/Makefile b/scripts/Makefile
index 3434a82a119f0..976c607c8d968 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -4,6 +4,7 @@
 # the kernel for the build process.
 
 hostprogs-always-$(CONFIG_KALLSYMS)			+= kallsyms
+hostprogs-always-$(CONFIG_KALLSYMS_LINEINFO)		+= gen_lineinfo
 hostprogs-always-$(BUILD_C_RECORDMCOUNT)		+= recordmcount
 hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)		+= sorttable
 hostprogs-always-$(CONFIG_ASN1)				+= asn1_compiler
@@ -37,6 +38,8 @@ HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
 HOSTCFLAGS_sign-file.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
 HOSTCFLAGS_sign-file.o += -I$(srctree)/tools/include/uapi/
 HOSTLDLIBS_sign-file = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
+HOSTCFLAGS_gen_lineinfo.o = $(shell $(HOSTPKG_CONFIG) --cflags libdw 2> /dev/null)
+HOSTLDLIBS_gen_lineinfo = $(shell $(HOSTPKG_CONFIG) --libs libdw 2> /dev/null || echo -ldw -lelf)
 
 ifdef CONFIG_UNWINDER_ORC
 ifeq ($(ARCH),x86_64)
diff --git a/scripts/empty_lineinfo.S b/scripts/empty_lineinfo.S
new file mode 100644
index 0000000000000..e058c41137123
--- /dev/null
+++ b/scripts/empty_lineinfo.S
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+ *
+ * Empty lineinfo stub for the initial vmlinux link.
+ * The real lineinfo is generated from .tmp_vmlinux1 by gen_lineinfo.
+ */
+	.section .rodata, "a"
+	.globl lineinfo_num_entries
+	.balign 4
+lineinfo_num_entries:
+	.long 0
+	.globl lineinfo_num_files
+	.balign 4
+lineinfo_num_files:
+	.long 0
+	.globl lineinfo_addrs
+lineinfo_addrs:
+	.globl lineinfo_file_ids
+lineinfo_file_ids:
+	.globl lineinfo_lines
+lineinfo_lines:
+	.globl lineinfo_file_offsets
+lineinfo_file_offsets:
+	.globl lineinfo_filenames_size
+	.balign 4
+lineinfo_filenames_size:
+	.long 0
+	.globl lineinfo_filenames
+lineinfo_filenames:
diff --git a/scripts/gen_lineinfo.c b/scripts/gen_lineinfo.c
new file mode 100644
index 0000000000000..be0b265bacc2d
--- /dev/null
+++ b/scripts/gen_lineinfo.c
@@ -0,0 +1,1283 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * gen_lineinfo.c - Generate address-to-source-line lookup tables from DWARF
+ *
+ * Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+ *
+ * Reads DWARF .debug_line from a vmlinux ELF file and outputs an assembly
+ * file containing sorted lookup tables that the kernel uses to annotate
+ * stack traces with source file:line information.
+ *
+ * Requires libelf and libdw from elfutils.
+ */
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <elfutils/libdw.h>
+#include <dwarf.h>
+#include <elf.h>
+#include <gelf.h>
+#include <limits.h>
+#include <array_size.h>
+#include <hash.h>
+#include <hashtable.h>
+#include <xalloc.h>
+
+#define LINEINFO_PREFIX "gen_lineinfo: "
+
+static bool verbose;
+
+#define verbose_msg(fmt, ...)						\
+	do {								\
+		if (verbose)						\
+			fprintf(stderr, LINEINFO_PREFIX fmt "\n",	\
+				##__VA_ARGS__);				\
+	} while (0)
+
+#define warn(fmt, ...) \
+	fprintf(stderr, LINEINFO_PREFIX "warning: " fmt "\n", ##__VA_ARGS__)
+
+#define error(fmt, ...)							\
+	do {								\
+		fprintf(stderr, LINEINFO_PREFIX "error: " fmt "\n",	\
+			##__VA_ARGS__);					\
+		exit(1);						\
+	} while (0)
+
+static unsigned int skipped_overflow;
+
+/*
+ * vmlinux mode: end of the invariant .text region.  Zero means "no cap"
+ * (graceful fallback when _etext is absent on some build).
+ */
+static unsigned long long text_end_addr;
+
+struct line_entry {
+	unsigned int offset;	/* offset from _text */
+	unsigned int file_id;
+	unsigned int line;
+	unsigned int seq;	/* line-program row order, breaks offset ties */
+};
+
+/*
+ * Individually allocated so files[] can grow without invalidating the
+ * hlist_node linkage.
+ */
+struct file_entry {
+	struct hlist_node hnode;
+	unsigned int id;
+	unsigned int str_offset;
+	char name[];
+};
+
+static struct line_entry *entries;
+static unsigned int num_entries;
+static unsigned int entries_capacity;
+
+static struct file_entry **files;
+static unsigned int num_files;
+static unsigned int files_capacity;
+
+static HASHTABLE_DEFINE(file_hashtable, 1U << 13);
+
+/* Monotonic row counter; see the seq tie-break in compare_entries(). */
+static unsigned int next_seq;
+
+static void add_entry(unsigned int offset, unsigned int file_id,
+		      unsigned int line)
+{
+	if (num_entries >= entries_capacity) {
+		entries_capacity = entries_capacity ? entries_capacity * 2 : 65536;
+		entries = xrealloc(entries, entries_capacity * sizeof(*entries));
+	}
+	entries[num_entries].offset = offset;
+	entries[num_entries].file_id = file_id;
+	entries[num_entries].line = line;
+	entries[num_entries].seq = next_seq++;
+	num_entries++;
+}
+
+static unsigned int find_or_add_file(const char *name)
+{
+	unsigned int key = hash_str(name);
+	struct file_entry *f;
+	size_t len;
+
+	hash_for_each_possible(file_hashtable, f, hnode, key)
+		if (!strcmp(f->name, name))
+			return f->id;
+
+	if (num_files >= 65535)
+		error("too many source files (%u > 65535)", num_files);
+
+	if (num_files >= files_capacity) {
+		files_capacity = files_capacity ? files_capacity * 2 : 4096;
+		files = xrealloc(files, files_capacity * sizeof(*files));
+	}
+
+	len = strlen(name);
+	f = xmalloc(sizeof(*f) + len + 1);
+	memset(f, 0, sizeof(*f));
+	memcpy(f->name, name, len + 1);
+	f->id = num_files;
+
+	files[num_files] = f;
+	hash_add(file_hashtable, &f->hnode, key);
+
+	return num_files++;
+}
+
+/*
+ * Well-known top-level directories in the kernel source tree.  Only used
+ * as a last resort, when a path matches none of the build roots below --
+ * e.g. an object compiled outside any of them.
+ */
+static const char * const kernel_dirs[] = {
+	"arch/", "block/", "certs/", "crypto/", "drivers/", "fs/",
+	"include/", "init/", "io_uring/", "ipc/", "kernel/", "lib/",
+	"mm/", "net/", "rust/", "samples/", "scripts/", "security/",
+	"sound/", "tools/", "usr/", "virt/",
+};
+
+/* Absolute build and source roots, longest first. */
+struct path_root {
+	char *path;
+	size_t len;
+};
+
+static struct path_root path_roots[8];
+static unsigned int num_path_roots;
+
+/*
+ * Lexically canonicalize @path in place: collapse repeated slashes, drop
+ * "." components and resolve ".." against the preceding component.  Purely
+ * textual -- nothing is stat()ed, because DWARF can name generated files
+ * that do not exist yet when gen_lineinfo runs.
+ */
+static void normalize_path(char *path)
+{
+	bool absolute = path[0] == '/';
+	char *base, *out = path;
+	const char *in = path;
+
+	if (absolute)
+		*out++ = *in++;
+	base = out;
+
+	while (*in) {
+		const char *seg = in;
+		size_t seglen;
+
+		while (*in && *in != '/')
+			in++;
+		seglen = in - seg;
+		while (*in == '/')
+			in++;
+
+		if (!seglen || (seglen == 1 && seg[0] == '.'))
+			continue;
+
+		if (seglen == 2 && seg[0] == '.' && seg[1] == '.') {
+			if (out > base) {
+				/* Pop the previously emitted component. */
+				while (out > base && out[-1] != '/')
+					out--;
+				if (out > base)
+					out--;	/* and its separator */
+				continue;
+			}
+			/* "/.." is "/"; a leading ".." in a relative path stays. */
+			if (absolute)
+				continue;
+		}
+
+		/*
+		 * Separator first: writing it after the component would land
+		 * on the byte @in still points at whenever nothing has been
+		 * compacted yet, clobbering the terminator and running the
+		 * loop off the end of the string.
+		 */
+		if (out > base)
+			*out++ = '/';
+		memmove(out, seg, seglen);
+		out += seglen;
+	}
+
+	if (out == base && !absolute)
+		*out++ = '.';
+	*out = '\0';
+}
+
+static int compare_path_roots(const void *a, const void *b)
+{
+	const struct path_root *ra = a, *rb = b;
+
+	if (ra->len != rb->len)
+		return ra->len > rb->len ? -1 : 1;
+	return 0;
+}
+
+static void add_path_root(const char *path)
+{
+	char buf[PATH_MAX];
+
+	if (!path || !*path)
+		return;
+
+	if (path[0] == '/') {
+		if (snprintf(buf, sizeof(buf), "%s", path) >= (int)sizeof(buf))
+			return;
+	} else {
+		char cwd[PATH_MAX];
+
+		/* kbuild runs host tools with cwd == $objtree. */
+		if (!getcwd(cwd, sizeof(cwd)))
+			return;
+		if (snprintf(buf, sizeof(buf), "%s/%s", cwd, path) >= (int)sizeof(buf))
+			return;
+	}
+
+	normalize_path(buf);
+
+	/* "/" would match every absolute path. */
+	if (!strcmp(buf, "/"))
+		return;
+
+	for (unsigned int i = 0; i < num_path_roots; i++)
+		if (!strcmp(path_roots[i].path, buf))
+			return;
+
+	if (num_path_roots == ARRAY_SIZE(path_roots))
+		return;
+
+	path_roots[num_path_roots].path = xstrdup(buf);
+	path_roots[num_path_roots].len = strlen(buf);
+	num_path_roots++;
+}
+
+/*
+ * Collect the roots that DWARF paths get made relative to.  kbuild exports
+ * all three, so no Makefile plumbing is needed: $objtree and $srctree cover
+ * in-tree and O= builds, and $srcroot covers M= external modules, whose
+ * sources live under neither.
+ */
+static void init_path_roots(void)
+{
+	static const char * const vars[] = { "objtree", "srctree", "srcroot" };
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(vars); i++) {
+		const char *val = getenv(vars[i]);
+		char *real;
+
+		if (!val || !*val)
+			continue;
+
+		add_path_root(val);
+
+		/*
+		 * Register the resolved form as well, so a symlinked tree
+		 * matches whichever spelling the compiler recorded.  Only
+		 * the roots are resolved this way -- never a DWARF path.
+		 */
+		real = realpath(val, NULL);
+		if (real) {
+			add_path_root(real);
+			free(real);
+		}
+	}
+
+	qsort(path_roots, num_path_roots, sizeof(*path_roots),
+	      compare_path_roots);
+}
+
+/*
+ * Strip a DWARF filename down to a kernel-tree-relative path.
+ *
+ * Per DWARF, a relative DW_AT_name is relative to the CU's DW_AT_comp_dir,
+ * so the two are joined and canonicalized first.  The result is then made
+ * relative to the longest matching build root.  Everything after that is a
+ * fallback for objects built outside the tree.
+ */
+static const char *make_relative(const char *path, const char *comp_dir)
+{
+	static char buf[PATH_MAX];
+	const char *p;
+
+	if (path[0] == '/') {
+		if (snprintf(buf, sizeof(buf), "%s", path) >= (int)sizeof(buf))
+			return path;
+	} else if (comp_dir && comp_dir[0] == '/') {
+		if (snprintf(buf, sizeof(buf), "%s/%s", comp_dir, path) >=
+		    (int)sizeof(buf))
+			return path;
+	} else {
+		/* Nothing absolute to anchor against. */
+		return path;
+	}
+
+	normalize_path(buf);
+
+	for (unsigned int i = 0; i < num_path_roots; i++) {
+		size_t len = path_roots[i].len;
+
+		if (!strncmp(buf, path_roots[i].path, len) && buf[len] == '/')
+			return buf + len + 1;
+	}
+
+	/*
+	 * comp_dir may still be a usable prefix even when it is not one of
+	 * the roots -- but only if stripping it leaves a directory
+	 * component, otherwise the kernel_dirs scan recovers more.
+	 */
+	if (comp_dir) {
+		size_t len = strlen(comp_dir);
+
+		if (!strncmp(buf, comp_dir, len) && buf[len] == '/' &&
+		    strchr(buf + len + 1, '/'))
+			return buf + len + 1;
+	}
+
+	for (p = strchr(buf, '/'); p; p = strchr(p + 1, '/'))
+		for (unsigned int i = 0; i < ARRAY_SIZE(kernel_dirs); i++)
+			if (!strncmp(p + 1, kernel_dirs[i],
+				     strlen(kernel_dirs[i])))
+				return p + 1;
+
+	p = strrchr(buf, '/');
+	return p ? p + 1 : buf;
+}
+
+static int compare_entries(const void *a, const void *b)
+{
+	const struct line_entry *ea = a;
+	const struct line_entry *eb = b;
+
+	if (ea->offset != eb->offset)
+		return ea->offset < eb->offset ? -1 : 1;
+	/*
+	 * Several rows routinely share one address: the line program emits a
+	 * row per event, and every row but the last covers zero bytes.  Order
+	 * them as the program emitted them so deduplicate() can keep the row
+	 * that actually describes the instruction.  seq is unique, so the
+	 * sort is total and the output is reproducible.
+	 */
+	if (ea->seq != eb->seq)
+		return ea->seq < eb->seq ? -1 : 1;
+	return 0;
+}
+
+/*
+ * Look up a vmlinux symbol by exact name and return its st_value, or
+ * @fallback if absent.  Aborts when @required and the symbol is missing.
+ */
+static unsigned long long find_vmlinux_sym(Elf *elf, const char *name,
+					   unsigned long long fallback,
+					   bool required)
+{
+	size_t nsyms, i;
+	Elf_Scn *scn = NULL;
+	GElf_Shdr shdr;
+
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		Elf_Data *data;
+
+		if (!gelf_getshdr(scn, &shdr))
+			continue;
+		if (shdr.sh_type != SHT_SYMTAB)
+			continue;
+
+		data = elf_getdata(scn, NULL);
+		if (!data)
+			continue;
+
+		nsyms = shdr.sh_size / shdr.sh_entsize;
+		for (i = 0; i < nsyms; i++) {
+			GElf_Sym sym;
+			const char *sname;
+
+			if (!gelf_getsym(data, i, &sym))
+				continue;
+			sname = elf_strptr(elf, shdr.sh_link, sym.st_name);
+			if (sname && !strcmp(sname, name))
+				return sym.st_value;
+		}
+	}
+
+	if (required)
+		error("cannot find %s symbol", name);
+	return fallback;
+}
+
+static unsigned long long find_text_addr(Elf *elf)
+{
+	return find_vmlinux_sym(elf, "_text", 0, true);
+}
+
+/*
+ * vmlinux is linked in multiple passes: gen_lineinfo runs against
+ * .tmp_vmlinux1 (which carries an empty lineinfo stub), then real tables
+ * are linked in for the final image.  Sections placed AFTER .rodata
+ * (.init.text, .exit.text, ...) shift forward as .rodata grows to hold
+ * the real lineinfo blob, so DWARF addresses we'd capture for them in
+ * pass 1 would be stale in the final kernel.  Cap captured addresses at
+ * _etext, the symbol that marks the end of .text — placed before .rodata
+ * in every architecture's vmlinux.lds.S, so its addresses are invariant
+ * across the relink.  Returns 0 if _etext is absent (no cap; v3 behavior).
+ */
+static unsigned long long find_text_end_addr(Elf *elf)
+{
+	return find_vmlinux_sym(elf, "_etext", 0, false);
+}
+
+static int compare_uints(const void *a, const void *b)
+{
+	unsigned int ua = *(const unsigned int *)a;
+	unsigned int ub = *(const unsigned int *)b;
+
+	if (ua != ub)
+		return ua < ub ? -1 : 1;
+	return 0;
+}
+
+/* Sorted, duplicate-free extents of every function symbol. */
+struct sym_start {
+	unsigned int offset;
+	unsigned int size;
+};
+
+static struct sym_start *sym_starts;
+static unsigned int num_sym_starts;
+static unsigned int sym_starts_capacity;
+
+/*
+ * Every symbol beginning in covered text, whether or not it is a function.
+ * Clang's basic-block sections (CONFIG_PROPELLER_CLANG) split a function
+ * into parts that carry STT_NOTYPE labels and a line-program sequence each,
+ * so resolve_cu_row_groups() cannot ask for STT_FUNC when it needs to know
+ * whether a sequence can begin at an address.
+ */
+static struct sym_start *text_starts;
+static unsigned int num_text_starts;
+static unsigned int text_starts_capacity;
+
+/* Sorted offsets one past the end of each DWARF line-program sequence. */
+static unsigned int *seq_ends;
+static unsigned int num_seq_ends;
+static unsigned int seq_ends_capacity;
+
+static void append_offset(unsigned int **arr, unsigned int *count,
+			  unsigned int *capacity, unsigned int value)
+{
+	if (*count >= *capacity) {
+		*capacity = *capacity ? *capacity * 2 : 16384;
+		*arr = xrealloc(*arr, *capacity * sizeof(**arr));
+	}
+	(*arr)[(*count)++] = value;
+}
+
+static void sort_unique(unsigned int *arr, unsigned int *count)
+{
+	unsigned int j = 0;
+
+	if (*count < 2)
+		return;
+
+	qsort(arr, *count, sizeof(*arr), compare_uints);
+	for (unsigned int i = 1; i < *count; i++) {
+		if (arr[i] == arr[j])
+			continue;
+		if (++j != i)
+			arr[j] = arr[i];
+	}
+	*count = j + 1;
+}
+
+/*
+ * Record the end of a line-program sequence.  @addr is one past the last
+ * covered byte, so the sequence's own coverage is tested using addr - 1.
+ */
+static void record_seq_end(unsigned long long addr,
+			   unsigned long long text_addr)
+{
+	unsigned long long raw;
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
+	append_offset(&seq_ends, &num_seq_ends, &seq_ends_capacity,
+		      (unsigned int)raw);
+}
+
+static int compare_sym_starts(const void *a, const void *b)
+{
+	const struct sym_start *sa = a, *sb = b;
+
+	if (sa->offset != sb->offset)
+		return sa->offset < sb->offset ? -1 : 1;
+	/* Larger extent first, so the dedup below keeps it. */
+	if (sa->size != sb->size)
+		return sa->size > sb->size ? -1 : 1;
+	return 0;
+}
+
+/* Sort by offset, keeping only the widest symbol at each. */
+static void sort_starts(struct sym_start *a, unsigned int *count)
+{
+	unsigned int n = *count, j = 0;
+
+	if (n < 2)
+		return;
+
+	qsort(a, n, sizeof(*a), compare_sym_starts);
+	for (unsigned int i = 1; i < n; i++) {
+		if (a[i].offset == a[j].offset)
+			continue;
+		if (++j != i)
+			a[j] = a[i];
+	}
+	*count = j + 1;
+}
+
+/*
+ * Collect the extent of every function symbol.  deduplicate() uses these to
+ * make sure each function keeps an entry at its own first byte; without that
+ * the kernel's symbol-boundary check rejects the preceding function's entry
+ * and the frame goes unannotated.
+ */
+static void collect_symbol_starts(Elf *elf, unsigned long long text_addr)
+{
+	Elf_Scn *scn = NULL;
+	GElf_Shdr shdr;
+
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		Elf_Data *data;
+		size_t nsyms;
+
+		if (!gelf_getshdr(scn, &shdr))
+			continue;
+		if (shdr.sh_type != SHT_SYMTAB || !shdr.sh_entsize)
+			continue;
+
+		data = elf_getdata(scn, NULL);
+		if (!data)
+			continue;
+
+		nsyms = shdr.sh_size / shdr.sh_entsize;
+		for (size_t i = 0; i < nsyms; i++) {
+			GElf_Sym sym;
+			unsigned long long raw;
+
+			if (!gelf_getsym(data, i, &sym))
+				continue;
+			switch (GELF_ST_TYPE(sym.st_info)) {
+			case STT_FUNC:
+			case STT_NOTYPE:
+				break;
+			default:
+				continue;
+			}
+			if (sym.st_value < text_addr)
+				continue;
+			if (text_end_addr && sym.st_value >= text_end_addr)
+				continue;
+
+			raw = sym.st_value - text_addr;
+			if (raw > UINT_MAX)
+				continue;
+
+			if (num_sym_starts >= sym_starts_capacity) {
+				sym_starts_capacity = sym_starts_capacity ?
+					sym_starts_capacity * 2 : 16384;
+				sym_starts = xrealloc(sym_starts,
+						      sym_starts_capacity *
+						      sizeof(*sym_starts));
+			}
+			if (num_text_starts >= text_starts_capacity) {
+				text_starts_capacity = text_starts_capacity ?
+					text_starts_capacity * 2 : 16384;
+				text_starts = xrealloc(text_starts,
+						       text_starts_capacity *
+						       sizeof(*text_starts));
+			}
+			text_starts[num_text_starts].offset = (unsigned int)raw;
+			text_starts[num_text_starts].size =
+				sym.st_size > UINT_MAX ? UINT_MAX :
+				(unsigned int)sym.st_size;
+			num_text_starts++;
+
+			if (GELF_ST_TYPE(sym.st_info) != STT_FUNC)
+				continue;
+
+			sym_starts[num_sym_starts].offset = (unsigned int)raw;
+			sym_starts[num_sym_starts].size =
+				sym.st_size > UINT_MAX ? UINT_MAX :
+				(unsigned int)sym.st_size;
+			num_sym_starts++;
+		}
+	}
+
+	sort_starts(sym_starts, &num_sym_starts);
+	sort_starts(text_starts, &num_text_starts);
+
+	/*
+	 * An unsized label reaches the next symbol, and a sequence beginning
+	 * there cannot run past it.
+	 */
+	for (unsigned int i = 1; i < num_text_starts; i++) {
+		if (!text_starts[i - 1].size)
+			text_starts[i - 1].size = text_starts[i].offset -
+						  text_starts[i - 1].offset;
+	}
+}
+
+/*
+ * One flag per row read from the compile unit being processed: whether the
+ * row closed a line-program sequence.  libdw returns rows sorted by address,
+ * so the flag is the only thing that tells the two kinds of line-0 row apart.
+ */
+static bool *cu_row_seq_end;
+static size_t cu_row_seq_end_cap;
+
+static void cu_rows_reserve(size_t rows)
+{
+	if (rows <= cu_row_seq_end_cap)
+		return;
+	cu_row_seq_end = xrealloc(cu_row_seq_end,
+				  rows * sizeof(*cu_row_seq_end));
+	cu_row_seq_end_cap = rows;
+}
+
+/* Size of the symbol starting exactly at @offset, 0 if none. */
+static unsigned int symbol_extent_at(unsigned int offset)
+{
+	unsigned int low = 0, high = num_text_starts;
+
+	while (low < high) {
+		unsigned int mid = low + (high - low) / 2;
+
+		if (text_starts[mid].offset < offset)
+			low = mid + 1;
+		else if (text_starts[mid].offset > offset)
+			high = mid;
+		else
+			return text_starts[mid].size;
+	}
+
+	return 0;
+}
+
+/*
+ * True if the rows a unit has where one of its sequences ended open a new
+ * sequence there, rather than closing the one that ended.  libdw cannot say:
+ * both look like an end_sequence followed by a normal row at one address.
+ *
+ * A sequence can only begin at a function, and a unit that begins one goes
+ * on to describe that function -- with a row inside it, or, for a function
+ * the unit covers in a single row, with the sequence end that closes it.
+ * Neither holds for the padding between two functions, which carries a
+ * symbol of its own that no unit describes.
+ */
+static bool starts_new_sequence(unsigned int group, unsigned int next,
+				unsigned int start)
+{
+	unsigned long long end;
+	unsigned int size;
+
+	size = symbol_extent_at(entries[group].offset);
+	if (!size)
+		return false;
+
+	end = (unsigned long long)entries[group].offset + size;
+
+	for (unsigned int t = next; t < num_entries; t++) {
+		if (entries[t].offset > end)
+			break;
+		if (entries[t].offset < end || cu_row_seq_end[t - start])
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Collapse the rows one compile unit emitted at a single address, of which
+ * all but one cover zero bytes.
+ *
+ * Rows that are not sequence ends keep their line-program order here, so the
+ * last of them is the one that describes the address, line 0 included: such a
+ * row declares that no source location applies, which is what addr2line
+ * reports for it too.
+ *
+ * The row closing a sequence is harder.  libdw sorts rows by address and
+ * puts an end_sequence ahead of any normal row sharing that address, which
+ * hides the difference between a sequence whose last row lands on its own
+ * end, covering nothing, and a sequence that begins where another ended.
+ * The symbol table settles it, see starts_new_sequence().
+ */
+static void resolve_cu_row_groups(unsigned int start)
+{
+	unsigned int i = start, j = start;
+
+	while (i < num_entries) {
+		unsigned int k = i, normal = i, seq_end = i, keep;
+		bool have_normal = false, have_seq_end = false;
+
+		while (k < num_entries &&
+		       entries[k].offset == entries[i].offset) {
+			if (cu_row_seq_end[k - start]) {
+				seq_end = k;
+				have_seq_end = true;
+			} else {
+				normal = k;
+				have_normal = true;
+			}
+			k++;
+		}
+
+		if (!have_normal)
+			keep = seq_end;
+		else if (!have_seq_end)
+			keep = normal;
+		else if (starts_new_sequence(i, k, start))
+			keep = normal;
+		else
+			keep = seq_end;
+
+		cu_row_seq_end[j - start] = cu_row_seq_end[keep - start];
+		entries[j++] = entries[keep];
+		i = k;
+	}
+
+	num_entries = j;
+}
+
+/*
+ * Address spans described by an assembler compile unit.  A single .loc there
+ * covers a whole macro expansion, which can emit a function per invocation,
+ * so a row from before a symbol is the row that describes it.  In C the same
+ * shape means padding or a split-out fragment carrying a neighbour's line,
+ * which is why synthesize_symbol_starts() asks for this.
+ */
+struct asm_span {
+	unsigned int lo;
+	unsigned int hi;
+};
+
+static struct asm_span *asm_spans;
+static unsigned int num_asm_spans;
+static unsigned int asm_spans_capacity;
+
+static int compare_asm_spans(const void *a, const void *b)
+{
+	const struct asm_span *sa = a, *sb = b;
+
+	if (sa->lo != sb->lo)
+		return sa->lo < sb->lo ? -1 : 1;
+	return 0;
+}
+
+/* True if an assembler unit describes @offset. */
+static bool in_asm_span(unsigned int offset)
+{
+	unsigned int low = 0, high = num_asm_spans;
+
+	while (low < high) {
+		unsigned int mid = low + (high - low) / 2;
+
+		if (asm_spans[mid].lo <= offset)
+			low = mid + 1;
+		else
+			high = mid;
+	}
+
+	return low && offset <= asm_spans[low - 1].hi;
+}
+
+/*
+ * One span per sequence this assembler unit contributed.  A unit's code lands
+ * in scattered places once linked, so a span covering the whole unit would
+ * claim whatever sits between.  @first_seq_end is where this unit's sequence
+ * ends begin, needed because a sequence reaching the end of the covered range
+ * has its closing row dropped and leaves no marker to stop at.
+ */
+static void record_cu_asm_spans(unsigned int start, unsigned int first_seq_end)
+{
+	unsigned int i = start;
+
+	while (i < num_entries) {
+		unsigned int j = i, hi;
+
+		while (!cu_row_seq_end[j - start] && j + 1 < num_entries)
+			j++;
+
+		hi = entries[j].offset;
+		if (!cu_row_seq_end[j - start]) {
+			for (unsigned int t = first_seq_end; t < num_seq_ends;
+			     t++) {
+				if (seq_ends[t] <= hi)
+					continue;
+				if (hi == entries[j].offset || seq_ends[t] < hi)
+					hi = seq_ends[t];
+			}
+		}
+
+		if (num_asm_spans >= asm_spans_capacity) {
+			asm_spans_capacity = asm_spans_capacity ?
+				asm_spans_capacity * 2 : 256;
+			asm_spans = xrealloc(asm_spans, asm_spans_capacity *
+						       sizeof(*asm_spans));
+		}
+		asm_spans[num_asm_spans].lo = entries[i].offset;
+		asm_spans[num_asm_spans].hi = hi;
+		num_asm_spans++;
+		i = j + 1;
+	}
+}
+
+static void process_dwarf(Dwarf *dwarf, unsigned long long text_addr)
+{
+	Dwarf_Off off = 0, next_off;
+	size_t hdr_size;
+
+	while (dwarf_nextcu(dwarf, off, &next_off, &hdr_size,
+			    NULL, NULL, NULL) == 0) {
+		Dwarf_Die cudie;
+		Dwarf_Lines *lines;
+		size_t nlines;
+		Dwarf_Attribute attr;
+		const char *comp_dir = NULL;
+		unsigned int cu_first_entry, cu_first_seq_end;
+
+		if (!dwarf_offdie(dwarf, off + hdr_size, &cudie))
+			goto next;
+
+		if (dwarf_attr(&cudie, DW_AT_comp_dir, &attr))
+			comp_dir = dwarf_formstring(&attr);
+
+		if (dwarf_getsrclines(&cudie, &lines, &nlines) != 0)
+			goto next;
+
+		cu_first_entry = num_entries;
+		cu_first_seq_end = num_seq_ends;
+		cu_rows_reserve(nlines);
+
+		for (size_t i = 0; i < nlines; i++) {
+			Dwarf_Line *line = dwarf_onesrcline(lines, i);
+			Dwarf_Addr addr;
+			const char *src;
+			const char *rel;
+			unsigned int file_id, loffset;
+			bool endseq = false;
+			int lineno;
+
+			if (!line)
+				continue;
+
+			if (dwarf_lineaddr(line, &addr) != 0)
+				continue;
+
+			/*
+			 * An end_sequence row marks the first address NOT
+			 * covered by this sequence; libdw repeats the previous
+			 * line number on it, so keeping it as an entry would
+			 * extend a function's annotation past its own end.
+			 * Record the boundary, which deduplicate() needs to
+			 * tell "this row still covers the next symbol" from
+			 * "coverage stopped here", and emit a line-0 entry so
+			 * that a lookup in the gap before the next sequence
+			 * reports nothing instead of inheriting the line
+			 * above it.
+			 */
+			if (dwarf_lineendsequence(line, &endseq) == 0 && endseq) {
+				record_seq_end(addr, text_addr);
+				lineno = 0;
+			} else if (dwarf_lineno(line, &lineno) != 0) {
+				continue;
+			}
+
+			/*
+			 * Line 0 means "no source location applies from here"
+			 * (DWARF5 6.2.2).  Keep such a row rather than drop
+			 * it: without it the preceding entry covers the
+			 * interval, and an address the compiler explicitly
+			 * declined to attribute gets a confident, wrong line.
+			 * It needs no file of its own, since the lookup side
+			 * reads the zero line as "no annotation" and stops
+			 * before it looks one up.
+			 */
+			src = dwarf_linesrc(line, NULL, NULL);
+			if (!src && lineno)
+				continue;
+
+			if (addr < text_addr)
+				continue;
+			/*
+			 * Skip addresses past _etext.  Sections after .rodata
+			 * shift when the real lineinfo replaces the empty stub
+			 * during the multi-pass vmlinux link, so any address
+			 * we'd capture there would be stale by the time the
+			 * final kernel runs.
+			 */
+			if (text_end_addr && addr >= text_end_addr)
+				continue;
+
+			{
+				unsigned long long raw_offset = addr - text_addr;
+
+				if (raw_offset > UINT_MAX) {
+					skipped_overflow++;
+					continue;
+				}
+				loffset = (unsigned int)raw_offset;
+			}
+
+			if (src) {
+				rel = make_relative(src, comp_dir);
+				file_id = find_or_add_file(rel);
+			} else {
+				file_id = 0;
+			}
+
+			add_entry(loffset, file_id, (unsigned int)lineno);
+			cu_row_seq_end[num_entries - 1 - cu_first_entry] = endseq;
+		}
+
+		resolve_cu_row_groups(cu_first_entry);
+
+		/*
+		 * DW_LANG_Mips_Assembler is what gas stamps on a .S unit, and
+		 * what tells synthesize_symbol_starts() that a row reaching
+		 * over a symbol describes it rather than covering padding.
+		 */
+		if (dwarf_srclang(&cudie) == DW_LANG_Mips_Assembler)
+			record_cu_asm_spans(cu_first_entry, cu_first_seq_end);
+next:
+		off = next_off;
+	}
+}
+
+/* True if some line-program sequence ends in (@lo, @hi]. */
+static bool seq_end_between(unsigned int lo, unsigned int hi)
+{
+	unsigned int low = 0, high = num_seq_ends;
+
+	/* First index whose value exceeds @lo. */
+	while (low < high) {
+		unsigned int mid = low + (high - low) / 2;
+
+		if (seq_ends[mid] <= lo)
+			low = mid + 1;
+		else
+			high = mid;
+	}
+
+	return low < num_seq_ends && seq_ends[low] <= hi;
+}
+
+/*
+ * Give every function an entry at its own first byte.
+ *
+ * Compilers routinely emit no line row at a symbol's start: .cold
+ * fragments in particular are covered by a row belonging to the function
+ * they were split out of.  That used to resolve fine, but the kernel now
+ * refuses any entry below the resolved symbol's start, so those frames
+ * would print unannotated.  Copy the covering row down to the symbol
+ * start instead.
+ *
+ * Two things have to hold before that is honest:
+ *
+ *  - the covering row's sequence must not have ended in between, or it
+ *    describes code that stopped before this symbol.  This is what keeps
+ *    the __SCT__* static-call trampolines unannotated.
+ *
+ *  - the line program must place at least one row inside the symbol, so
+ *    we know it describes this symbol's code at all.  This is what keeps
+ *    the __pfx_* padding stubs unannotated: they are pure alignment
+ *    padding, and no compiler ever emits a row inside one.
+ *
+ * Symbols failing either test keep no annotation, which is the correct
+ * answer for hand-written assembly.
+ */
+static void synthesize_symbol_starts(void)
+{
+	unsigned int base_entries = num_entries;
+	unsigned int cursor = 0;
+
+	if (!base_entries || !num_sym_starts)
+		return;
+
+	sort_unique(seq_ends, &num_seq_ends);
+	qsort(asm_spans, num_asm_spans, sizeof(*asm_spans), compare_asm_spans);
+
+	for (unsigned int i = 0; i < num_sym_starts; i++) {
+		unsigned int start = sym_starts[i].offset;
+		unsigned int end = start + sym_starts[i].size;
+
+		while (cursor + 1 < base_entries &&
+		       entries[cursor + 1].offset <= start)
+			cursor++;
+
+		if (entries[cursor].offset > start)
+			continue;	/* nothing covers this symbol */
+		if (entries[cursor].offset == start)
+			continue;	/* already has its own entry */
+		if (seq_end_between(entries[cursor].offset, start))
+			continue;	/* coverage stopped before here */
+
+		if (end <= start)
+			continue;	/* size overflowed */
+
+		/*
+		 * A row reaching over a symbol with none inside it is padding
+		 * or a split-out fragment in C, carrying the line of whatever
+		 * it came from.  In assembly it is one macro expanding to a
+		 * function per invocation, which the row does describe.
+		 */
+		if (!in_asm_span(start) &&
+		    (cursor + 1 >= base_entries ||
+		     entries[cursor + 1].offset >= end))
+			continue;
+
+		add_entry(start, entries[cursor].file_id, entries[cursor].line);
+	}
+}
+
+static void deduplicate(void)
+{
+	unsigned int sym_cursor = 0;
+	unsigned int i, j;
+
+	if (num_entries < 2)
+		return;
+
+	/* Sort by offset, then file_id, then line for stability */
+	qsort(entries, num_entries, sizeof(*entries), compare_entries);
+
+	synthesize_symbol_starts();
+	qsort(entries, num_entries, sizeof(*entries), compare_entries);
+
+	/*
+	 * Remove duplicate entries:
+	 * - Same offset: keep last.  Earlier rows at that address cover no
+	 *   bytes, so the final one is what describes the instruction, and
+	 *   it is what addr2line reports.  For an inlined call that is the
+	 *   inlined body rather than the call site.
+	 * - Same file:line as previous kept entry: redundant for binary
+	 *   search -- any address between them resolves to the earlier one
+	 *
+	 * Entries sitting on a symbol start are exempt from the second rule:
+	 * they are the only thing standing between that symbol and the
+	 * kernel's boundary check.
+	 */
+	j = 0;
+	for (i = 1; i < num_entries; i++) {
+		bool at_symbol_start;
+
+		if (entries[i].offset == entries[j].offset) {
+			/*
+			 * Rows from different compile units can share an
+			 * address, and coverage is their union: a real
+			 * location beats another unit's no-coverage marker.
+			 * Within one unit resolve_cu_row_groups() has already
+			 * picked the row that describes the address.
+			 */
+			if (entries[i].line || !entries[j].line)
+				entries[j] = entries[i];
+			continue;
+		}
+
+		while (sym_cursor < num_sym_starts &&
+		       sym_starts[sym_cursor].offset < entries[i].offset)
+			sym_cursor++;
+		at_symbol_start = sym_cursor < num_sym_starts &&
+				  sym_starts[sym_cursor].offset == entries[i].offset;
+
+		if (!at_symbol_start &&
+		    entries[i].file_id == entries[j].file_id &&
+		    entries[i].line == entries[j].line)
+			continue;
+
+		j++;
+		if (j != i)
+			entries[j] = entries[i];
+	}
+	num_entries = j + 1;
+}
+
+static void compute_file_offsets(void)
+{
+	unsigned int offset = 0;
+
+	for (unsigned int i = 0; i < num_files; i++) {
+		files[i]->str_offset = offset;
+		offset += strlen(files[i]->name) + 1;
+	}
+}
+
+static void print_escaped_asciz(const char *s)
+{
+	printf("\t.asciz \"");
+	for (; *s; s++) {
+		if (*s == '"' || *s == '\\')
+			putchar('\\');
+		putchar(*s);
+	}
+	printf("\"\n");
+}
+
+static void output_assembly(void)
+{
+	printf("/* SPDX-License-Identifier: GPL-2.0 */\n");
+	printf("/*\n");
+	printf(" * Automatically generated by scripts/gen_lineinfo\n");
+	printf(" * Do not edit.\n");
+	printf(" */\n\n");
+
+	printf("\t.section .rodata, \"a\"\n\n");
+
+	/* Number of entries */
+	printf("\t.globl lineinfo_num_entries\n");
+	printf("\t.balign 4\n");
+	printf("lineinfo_num_entries:\n");
+	printf("\t.long %u\n\n", num_entries);
+
+	/* Number of files */
+	printf("\t.globl lineinfo_num_files\n");
+	printf("\t.balign 4\n");
+	printf("lineinfo_num_files:\n");
+	printf("\t.long %u\n\n", num_files);
+
+	/* Sorted address offsets from _text */
+	printf("\t.globl lineinfo_addrs\n");
+	printf("\t.balign 4\n");
+	printf("lineinfo_addrs:\n");
+	for (unsigned int i = 0; i < num_entries; i++)
+		printf("\t.long 0x%x\n", entries[i].offset);
+	printf("\n");
+
+	/* File IDs, parallel to addrs (u16 -- supports up to 65535 files) */
+	printf("\t.globl lineinfo_file_ids\n");
+	printf("\t.balign 2\n");
+	printf("lineinfo_file_ids:\n");
+	for (unsigned int i = 0; i < num_entries; i++)
+		printf("\t.short %u\n", entries[i].file_id);
+	printf("\n");
+
+	/* Line numbers, parallel to addrs */
+	printf("\t.globl lineinfo_lines\n");
+	printf("\t.balign 4\n");
+	printf("lineinfo_lines:\n");
+	for (unsigned int i = 0; i < num_entries; i++)
+		printf("\t.long %u\n", entries[i].line);
+	printf("\n");
+
+	/* File string offset table */
+	printf("\t.globl lineinfo_file_offsets\n");
+	printf("\t.balign 4\n");
+	printf("lineinfo_file_offsets:\n");
+	for (unsigned int i = 0; i < num_files; i++)
+		printf("\t.long %u\n", files[i]->str_offset);
+	printf("\n");
+
+	/* Filenames size */
+	{
+		unsigned int fsize = 0;
+
+		for (unsigned int i = 0; i < num_files; i++)
+			fsize += strlen(files[i]->name) + 1;
+		printf("\t.globl lineinfo_filenames_size\n");
+		printf("\t.balign 4\n");
+		printf("lineinfo_filenames_size:\n");
+		printf("\t.long %u\n\n", fsize);
+	}
+
+	/* Concatenated NUL-terminated filenames */
+	printf("\t.globl lineinfo_filenames\n");
+	printf("lineinfo_filenames:\n");
+	for (unsigned int i = 0; i < num_files; i++)
+		print_escaped_asciz(files[i]->name);
+	printf("\n");
+}
+
+int main(int argc, char *argv[])
+{
+	const char *kbuild_verbose = getenv("KBUILD_VERBOSE");
+	unsigned long long text_addr;
+	Dwarf *dwarf;
+	Elf *elf;
+	int fd;
+
+	if (kbuild_verbose && strchr(kbuild_verbose, '1'))
+		verbose = true;
+
+	while (argc > 2 && (!strcmp(argv[1], "-v") ||
+			    !strcmp(argv[1], "--verbose"))) {
+		verbose = true;
+		memmove(&argv[1], &argv[2], (argc - 2) * sizeof(char *));
+		argc--;
+	}
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s [-v] <vmlinux>\n", argv[0]);
+		return 1;
+	}
+
+	init_path_roots();
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0)
+		error("cannot open %s: %s", argv[1], strerror(errno));
+
+	elf_version(EV_CURRENT);
+	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
+	if (!elf)
+		error("elf_begin failed: %s", elf_errmsg(elf_errno()));
+
+	text_addr = find_text_addr(elf);
+	text_end_addr = find_text_end_addr(elf);
+	collect_symbol_starts(elf, text_addr);
+
+	dwarf = dwarf_begin_elf(elf, DWARF_C_READ, NULL);
+	if (!dwarf)
+		error("dwarf_begin_elf failed: %s\n"
+		      LINEINFO_PREFIX "error: is %s built with CONFIG_DEBUG_INFO?",
+		      dwarf_errmsg(dwarf_errno()), argv[1]);
+
+	process_dwarf(dwarf, text_addr);
+
+	if (skipped_overflow)
+		warn("%u entries skipped (offset > 4 GiB from _text)",
+		     skipped_overflow);
+
+	deduplicate();
+	compute_file_offsets();
+
+	verbose_msg("%u entries, %u files", num_entries, num_files);
+
+	output_assembly();
+
+	dwarf_end(dwarf);
+	elf_end(elf);
+	close(fd);
+
+	/* Cleanup */
+	free(entries);
+	free(sym_starts);
+	free(seq_ends);
+	for (unsigned int i = 0; i < num_files; i++)
+		free(files[i]);
+	free(files);
+
+	return 0;
+}
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 494852ade6d87..30f821c7f3e7a 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -90,6 +90,17 @@ static bool is_ignored_symbol(const char *name, char type)
 			return true;
 	}
 
+	/*
+	 * The generated lineinfo tables (scripts/gen_lineinfo, stubbed by
+	 * scripts/empty_lineinfo.S) are read-only data whose size and
+	 * addresses change between kallsyms passes.  Match them by prefix so
+	 * the set cannot drift as the table layout evolves.  Text symbols are
+	 * exempt, so lib/tests/lineinfo_kunit.c's lineinfo_target_*() stay
+	 * resolvable -- the test looks them up by name.
+	 */
+	if (toupper(type) != 'T' && !strncmp(name, "lineinfo_", 9))
+		return true;
+
 	return false;
 }
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index ab0b8125c8cbc..1de4c9e7cccd7 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -103,7 +103,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
+		${kallsymso} ${lineinfo_o} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
 }
 
 # Check if kallsymso_prev and kallsymso differ
@@ -142,6 +142,40 @@ kallsyms()
 	kallsymso=${2}.o
 }
 
+# Generate lineinfo tables from DWARF debug info in a temporary vmlinux.
+# ${1} - temporary vmlinux with debug info
+# Output: sets lineinfo_o to the generated .o file
+gen_lineinfo()
+{
+	info LINEINFO .tmp_lineinfo.S
+	if ! scripts/gen_lineinfo "${1}" > .tmp_lineinfo.S; then
+		echo >&2 "Failed to generate lineinfo from ${1}"
+		echo >&2 "Try to disable CONFIG_KALLSYMS_LINEINFO"
+		exit 1
+	fi
+
+	info AS .tmp_lineinfo.o
+	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
+	      ${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL} \
+	      -c -o .tmp_lineinfo.o .tmp_lineinfo.S
+
+	lineinfo_o=.tmp_lineinfo.o
+	lineinfo_src=${1}
+}
+
+# Compare the text layout of two linked images.
+# Lineinfo offsets are relative to _text, so anything that moves text after
+# the table was generated invalidates every one of them.  Replacing the
+# stub with the real table grows the image by megabytes, and that is exactly
+# what makes the linker insert branch stubs (see the kallsyms comment
+# below), so this has to be checked rather than assumed.
+text_layout_changed()
+{
+	${NM} -n "${1}" | awk '$2 ~ /^[tT]$/ { print $1, $3 }' > "${1}.text_layout"
+	${NM} -n "${2}" | awk '$2 ~ /^[tT]$/ { print $1, $3 }' > "${2}.text_layout"
+	! cmp -s "${1}.text_layout" "${2}.text_layout"
+}
+
 # Perform kallsyms for the given temporary vmlinux.
 sysmap_and_kallsyms()
 {
@@ -168,6 +202,9 @@ sorttable()
 cleanup()
 {
 	rm -f .btf.*
+	rm -f .tmp_lineinfo.*
+	rm -f .tmp_vmlinux_lineinfo*
+	rm -f .tmp_vmlinux*.text_layout
 	rm -f .tmp_vmlinux.nm-sort
 	rm -f System.map
 	rm -f vmlinux
@@ -196,6 +233,8 @@ fi
 btf_vmlinux_bin_o=
 btfids_vmlinux=
 kallsymso=
+lineinfo_o=
+lineinfo_src=
 strip_debug=
 generate_map=
 
@@ -211,10 +250,21 @@ if is_enabled CONFIG_KALLSYMS; then
 	kallsyms .tmp_vmlinux0.syms .tmp_vmlinux0.kallsyms
 fi
 
+if is_enabled CONFIG_KALLSYMS_LINEINFO; then
+	# Assemble an empty lineinfo stub for the initial link.
+	# The real lineinfo is generated from .tmp_vmlinux1 by gen_lineinfo.
+	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
+	      ${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL} \
+	      -c -o .tmp_lineinfo.o "${srctree}/scripts/empty_lineinfo.S"
+	lineinfo_o=.tmp_lineinfo.o
+fi
+
 if is_enabled CONFIG_KALLSYMS || is_enabled CONFIG_DEBUG_INFO_BTF; then
 
-	# The kallsyms linking does not need debug symbols, but the BTF does.
-	if ! is_enabled CONFIG_DEBUG_INFO_BTF; then
+	# The kallsyms linking does not need debug symbols, but BTF and
+	# lineinfo generation do.
+	if ! is_enabled CONFIG_DEBUG_INFO_BTF &&
+	   ! is_enabled CONFIG_KALLSYMS_LINEINFO; then
 		strip_debug=1
 	fi
 
@@ -232,6 +282,10 @@ if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	btfids_vmlinux=.tmp_vmlinux1.BTF_ids
 fi
 
+if is_enabled CONFIG_KALLSYMS_LINEINFO; then
+	gen_lineinfo .tmp_vmlinux1
+fi
+
 if is_enabled CONFIG_KALLSYMS; then
 
 	# kallsyms support
@@ -279,6 +333,34 @@ if is_enabled CONFIG_KALLSYMS; then
 	fi
 fi
 
+if is_enabled CONFIG_KALLSYMS_LINEINFO; then
+	# ${lineinfo_src} was linked against the stub, so its text can sit at
+	# different addresses than the image we are about to ship.  When that
+	# happens, regenerate from an image that already carries a real-sized
+	# table and link once more; a second shift would mean the layout is
+	# not settling, which is worth failing over rather than shipping line
+	# numbers that point at the wrong source.
+	lineinfo_last=${kallsyms_sysmap%.syms}
+	lineinfo_last=${lineinfo_last:-.tmp_vmlinux1}
+
+	if text_layout_changed "${lineinfo_src}" "${lineinfo_last}"; then
+		info LINEINFO "text moved, regenerating"
+		strip_debug=
+		vmlinux_link .tmp_vmlinux_lineinfo
+		gen_lineinfo .tmp_vmlinux_lineinfo
+		strip_debug=1
+		vmlinux_link .tmp_vmlinux_lineinfo2
+		if is_enabled CONFIG_KALLSYMS; then
+			sysmap_and_kallsyms .tmp_vmlinux_lineinfo2
+		fi
+		if text_layout_changed "${lineinfo_src}" .tmp_vmlinux_lineinfo2; then
+			echo >&2 "Failed to settle text layout for lineinfo"
+			echo >&2 "Try to disable CONFIG_KALLSYMS_LINEINFO"
+			exit 1
+		fi
+	fi
+fi
+
 strip_debug=
 
 if is_enabled CONFIG_VMLINUX_MAP; then
-- 
2.53.0

