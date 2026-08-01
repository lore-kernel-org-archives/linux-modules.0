Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDE638237D;
	Sat,  1 Aug 2026 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785594751; cv=none; b=UZYJ5zmlSY33eVZkYQdlXUae4CXZ9EuX4+vRItjrdAFjSarEtsBIqFtUw9Wonp5DMTStvMWnnjKQfIDKwZmFS+V8+nyqUhGexbi4G9P3mxJcJVvFawBr34mKYFZykdbaVYraboXnG1eFZhP12s23mRM0gshzfCHJx8mc2suzjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785594751; c=relaxed/simple;
	bh=FYAjL3I1sQm/CHklEwBfvh8EkoLfJDbmSyaumlIiihE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcrSxurQlzet6odbYGUrNr++ae+JgcQ3/gzw/zp6H1sUvXriXcEXJAPzG+6FVpM9Yp+nlguMiygclt+ylWlDxlEnWxk10BHOgf17u5M3yg/Gmn5QGLmDpd/m3xm7pVhA7kvCJtJm3Ppr743ls2tHl3ShZ6b6RqV2fsA5aSgTu1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fV0d72rT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fV0d72rT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058981F00ACA;
	Sat,  1 Aug 2026 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785594748;
	bh=gq4nKXXB8KALDCEhMnvkbKjRwzEnx9ZFNew+p6wlK/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fV0d72rTNP4WUeBMMD6hFFLO/ZzvyV0+FWp9kQflFtCmHs43VNNbB0dc57KLCrzK0
	 GjWcXrwcbkiDUJXH6KCVKB367sFsOODc4iT4wyt3T8xkUXhXFB+aYwQrRHD+9+/V9j
	 m9QbfhW9Qn6puNHVCWmMKax/Fn1O5n6EWrfK7aWRaJifDuiilLvBOPR/eduP6Vi6wn
	 jV9qsBI9pVN5IiYCgiOgogyCjpqidRjugJvm/m8rW6xCLYFWtD0mxO2DepkA/IPgTM
	 tZwH4sppELgb+UBh7fWyO38TkNPshKPCcJnc+JBhTYWBFFgvvyunoQpYWGjymdEvbe
	 SHwYr5gRT2xlA==
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
Subject: [PATCH v8 1/4] kallsyms: embed source file:line info in kernel stack traces
Date: Sat,  1 Aug 2026 10:32:15 -0400
Message-ID: <20260801143219.3975824-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801143219.3975824-1-sashal@kernel.org>
References: <20260801143219.3975824-1-sashal@kernel.org>
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

The feature requires CONFIG_DEBUG_INFO (for DWARF data) and libelf
and libdw (from elfutils) on the build host.

Memory footprint, measured with:

  make ARCH=x86_64 O=$B defconfig
  ./scripts/config --file $B/.config -e DEBUG_INFO \
                                     -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
  make ARCH=x86_64 O=$B olddefconfig && make ARCH=x86_64 O=$B -j$(nproc)
  strip -g $B/vmlinux -o vmlinux.nodbg && stat -c %s vmlinux.nodbg

  Table: 1,794,950 entries from 4,232 source files
    lineinfo_addrs[]     1,794,950 x u32  =  6.8 MiB
    lineinfo_file_ids[]  1,794,950 x u16  =  3.4 MiB
    lineinfo_lines[]     1,794,950 x u32  =  6.8 MiB
    file_offsets + filenames              =  0.1 MiB
    Total .rodata increase:               = 17.2 MiB

  vmlinux (stripped):  51.1 MiB -> 69.1 MiB  (+18.0 MiB / +35.3%)

That is the cost of the uncompressed format introduced here; the delta
compression added later in this series brings it down to +8.0 MiB
(+15.7%) on the same config.

Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/index.rst           |   1 +
 .../admin-guide/kallsyms-lineinfo.rst         |  72 ++
 MAINTAINERS                                   |   6 +
 include/linux/kallsyms.h                      |  18 +-
 init/Kconfig                                  |  20 +
 kernel/kallsyms.c                             | 101 +-
 kernel/kallsyms_internal.h                    |   9 +
 scripts/.gitignore                            |   1 +
 scripts/Makefile                              |   3 +
 scripts/empty_lineinfo.S                      |  30 +
 scripts/gen_lineinfo.c                        | 969 ++++++++++++++++++
 scripts/kallsyms.c                            |  11 +
 scripts/link-vmlinux.sh                       |  43 +-
 13 files changed, 1273 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/admin-guide/kallsyms-lineinfo.rst
 create mode 100644 scripts/empty_lineinfo.S
 create mode 100644 scripts/gen_lineinfo.c

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index cd28dfe91b06..37456e08fe43 100644
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
index 000000000000..4c5de44e68fc
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
+The lineinfo tables are stored in ``.rodata`` and typically add approximately
+44 MiB to the kernel image for a standard configuration (~4.6 million DWARF
+line entries, ~10 bytes per entry after deduplication).
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
index 4a8b0fd665ce..b98d57b1ee1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13931,6 +13931,12 @@ S:	Maintained
 F:	Documentation/hwmon/k8temp.rst
 F:	drivers/hwmon/k8temp.c
 
+KALLSYMS LINEINFO
+M:	Sasha Levin <sashal@kernel.org>
+S:	Maintained
+F:	Documentation/admin-guide/kallsyms-lineinfo.rst
+F:	scripts/gen_lineinfo.c
+
 KASAN
 M:	Andrey Ryabinin <ryabinin.a.a@gmail.com>
 R:	Alexander Potapenko <glider@google.com>
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index d5dd54c53ace..53cc25a6e85d 100644
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
index 5230d4879b1c..635305ec0594 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2087,6 +2087,26 @@ config KALLSYMS_ALL
 
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
index aec2f06858af..baf52e81118b 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -467,13 +467,82 @@ static int append_buildid(char *buffer,   const char *modname,
 
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
@@ -485,6 +554,7 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 	if (!len)
 		return sprintf(buffer, "0x%lx", address - symbol_offset);
 
+	sym_start = address - offset;
 	offset -= symbol_offset;
 
 	if (add_offset)
@@ -497,6 +567,23 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 		len += sprintf(buffer + len, "]");
 	}
 
+	/*
+	 * Append "(file:line)" only for stack-backtrace consumers.  Plain
+	 * sprint_symbol() backs %ps, and many existing format strings tack
+	 * literal "()" after %ps to indicate a function call ("foo()
+	 * replaced with bar()"); appending lineinfo there would produce a
+	 * confusing "foo (file:line)()".
+	 */
+	if (add_lineinfo && IS_ENABLED(CONFIG_KALLSYMS_LINEINFO) && !modname) {
+		const char *li_file;
+		unsigned int li_line;
+
+		if (kallsyms_lookup_lineinfo(address, sym_start,
+					     &li_file, &li_line))
+			len += snprintf(buffer + len, KSYM_SYMBOL_LEN - len,
+					" (%s:%u)", li_file, li_line);
+	}
+
 	return len;
 }
 
@@ -513,7 +600,7 @@ static int __sprint_symbol(char *buffer, unsigned long address,
  */
 int sprint_symbol(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 1, 0);
+	return __sprint_symbol(buffer, address, 0, 1, 0, 0);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol);
 
@@ -530,7 +617,7 @@ EXPORT_SYMBOL_GPL(sprint_symbol);
  */
 int sprint_symbol_build_id(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 1, 1);
+	return __sprint_symbol(buffer, address, 0, 1, 1, 0);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol_build_id);
 
@@ -547,7 +634,7 @@ EXPORT_SYMBOL_GPL(sprint_symbol_build_id);
  */
 int sprint_symbol_no_offset(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 0, 0);
+	return __sprint_symbol(buffer, address, 0, 0, 0, 0);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol_no_offset);
 
@@ -567,7 +654,7 @@ EXPORT_SYMBOL_GPL(sprint_symbol_no_offset);
  */
 int sprint_backtrace(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, -1, 1, 0);
+	return __sprint_symbol(buffer, address, -1, 1, 0, 1);
 }
 
 /**
@@ -587,7 +674,7 @@ int sprint_backtrace(char *buffer, unsigned long address)
  */
 int sprint_backtrace_build_id(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, -1, 1, 1);
+	return __sprint_symbol(buffer, address, -1, 1, 1, 1);
 }
 
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 81a867dbe57d..d7374ce444d8 100644
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
index 4215c2208f7e..e175714c18b6 100644
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
index 3434a82a119f..976c607c8d96 100644
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
index 000000000000..e058c4113712
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
index 000000000000..a3ee54eaad05
--- /dev/null
+++ b/scripts/gen_lineinfo.c
@@ -0,0 +1,969 @@
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
+	if (ea->file_id != eb->file_id)
+		return ea->file_id < eb->file_id ? -1 : 1;
+	if (ea->line != eb->line)
+		return ea->line < eb->line ? -1 : 1;
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
+			if (GELF_ST_TYPE(sym.st_info) != STT_FUNC)
+				continue;
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
+			sym_starts[num_sym_starts].offset = (unsigned int)raw;
+			sym_starts[num_sym_starts].size =
+				sym.st_size > UINT_MAX ? UINT_MAX :
+				(unsigned int)sym.st_size;
+			num_sym_starts++;
+		}
+	}
+
+	if (num_sym_starts > 1) {
+		unsigned int j = 0;
+
+		qsort(sym_starts, num_sym_starts, sizeof(*sym_starts),
+		      compare_sym_starts);
+		for (unsigned int i = 1; i < num_sym_starts; i++) {
+			if (sym_starts[i].offset == sym_starts[j].offset)
+				continue;
+			if (++j != i)
+				sym_starts[j] = sym_starts[i];
+		}
+		num_sym_starts = j + 1;
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
+			 * Record the boundary instead -- deduplicate() needs
+			 * it to tell "this row still covers the next symbol"
+			 * from "coverage stopped here".
+			 */
+			if (dwarf_lineendsequence(line, &endseq) == 0 && endseq) {
+				record_seq_end(addr, text_addr);
+				continue;
+			}
+
+			if (dwarf_lineno(line, &lineno) != 0)
+				continue;
+			if (lineno == 0)
+				continue;
+
+			src = dwarf_linesrc(line, NULL, NULL);
+			if (!src)
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
+			rel = make_relative(src, comp_dir);
+			file_id = find_or_add_file(rel);
+
+			add_entry(loffset, file_id, (unsigned int)lineno);
+		}
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
+		/* Overflow, or no row inside [start, end): not our code. */
+		if (end <= start)
+			continue;
+		if (cursor + 1 >= base_entries ||
+		    entries[cursor + 1].offset >= end)
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
+	 * - Same offset: keep first (deterministic from stable sort keys)
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
+		if (entries[i].offset == entries[j].offset)
+			continue;
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
index 37d5c095ad22..e11f101b743b 100644
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
index f99e196abeea..39ca44fbb259 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -103,7 +103,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
+		${kallsymso} ${lineinfo_o} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
 }
 
 # Create ${2}.o file with all symbols from the ${1} object file
@@ -129,6 +129,26 @@ kallsyms()
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
+}
+
 # Perform kallsyms for the given temporary vmlinux.
 sysmap_and_kallsyms()
 {
@@ -155,6 +175,7 @@ sorttable()
 cleanup()
 {
 	rm -f .btf.*
+	rm -f .tmp_lineinfo.*
 	rm -f .tmp_vmlinux.nm-sort
 	rm -f System.map
 	rm -f vmlinux
@@ -183,6 +204,7 @@ fi
 btf_vmlinux_bin_o=
 btfids_vmlinux=
 kallsymso=
+lineinfo_o=
 strip_debug=
 generate_map=
 
@@ -198,10 +220,21 @@ if is_enabled CONFIG_KALLSYMS; then
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
 
@@ -219,6 +252,10 @@ if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	btfids_vmlinux=.tmp_vmlinux1.BTF_ids
 fi
 
+if is_enabled CONFIG_KALLSYMS_LINEINFO; then
+	gen_lineinfo .tmp_vmlinux1
+fi
+
 if is_enabled CONFIG_KALLSYMS; then
 
 	# kallsyms support
-- 
2.53.0

