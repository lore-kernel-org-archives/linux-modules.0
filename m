Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CEC53B5F5;
	Thu, 17 Sep 2026 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652275; cv=none; b=A16CqzKgODDOeM8Ux2r7brHq+onHJNz33rywph+evXrN6C/terhGN+W+/Obm6fSYir2MoZq34IZ5Q2wCg30D9peRi3+eNFK8fRvFtq5Zp3K8/VXipNuS0WGVvdZX0h6yTYjz0hV7io2kaXbNWTxGbvNSi7KiwxVdeAffZam5frM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652275; c=relaxed/simple;
	bh=TjX/3fCIjzgA8dDyE/OowK6GV6sunxNesSUzDqmNu0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PX4Zj04GiOV7Y2Se1F08ucSajrscjzHI+m618/9kNcGKHW8oNM+pBkRYmmUDE7jdF7zTIFh76DcwBoEhSNXT06zy25hD1pasfYJqVBOJgrvoR8CGZtZA9NXSTgZVRpv5hSkT+UpPcFI4EsPDtW/btE9hTZV1Q1mwrbKQGdgHJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB9DfA5m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB9DfA5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1961F0089A;
	Thu, 17 Sep 2026 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789652261;
	bh=n+hJ92HYvPAdxegz7J2UsqaYcnSv0kobIWZdAB6PjyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SB9DfA5mvjW5GyQESiQ5y25+y17CdoD1nYssbU/sSFvw3I+WA3keAfuIMH5iVMHEn
	 IAOM1OC+gUf94isse3aTg8pkIViX0c8kCUfGuAQB2s7zRgN33y3xqFBWD0pgZUrZDT
	 jO5zLmZcDrpPv6/nKRiZimrLRu/+x9ZgvJL4hw2/74uoMh0ZjzEiw1kxhyE+sQCfWz
	 j2/TWmPRs0PtFf/kYzMOvF5DWafpsa+eloTfhN5fy3SnLxlIsNqRLszlK5BV5/FjX5
	 iwMBEzElPEZdAzzkUM0+Fuo6Nb1EntNntSbGF9Zq4gJhF7Z3bx64U9BPLpE7niyg4D
	 K6prD5mM7jkdA==
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
Subject: [PATCH v9 3/4] kallsyms: delta-compress lineinfo tables for ~2.7x size reduction
Date: Thu, 17 Sep 2026 09:37:24 -0400
Message-ID: <20260917133727.428546-4-sashal@kernel.org>
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

Replace the flat uncompressed parallel arrays (lineinfo_addrs[],
lineinfo_file_ids[], lineinfo_lines[]) with a block-indexed,
delta-encoded, ULEB128 varint compressed format.

The sorted address array has small deltas between consecutive entries
(typically 1-50 bytes), file IDs have high locality (delta often 0,
same file), and line numbers change slowly.  Delta-encoding followed
by ULEB128 varint compression shrinks most values from 4 bytes to 1.

Entries are grouped into blocks of 64.  A small uncompressed block
index (first addr + byte offset per block) enables O(log(N/64)) binary
search, followed by sequential decode of at most 64 entries within the
matching block.  All decode state lives on the stack -- zero
allocations, still safe for NMI/panic context.

Measured on x86_64_defconfig + CONFIG_DEBUG_INFO (same recipe as patch
1/4; 1,657,997 entries, 4,235 source files, 25,907 blocks):

  Before (flat arrays):
    lineinfo_addrs[]     6,631,988 bytes (u32 x 1.66M)
    lineinfo_file_ids[]  3,315,994 bytes (u16 x 1.66M)
    lineinfo_lines[]     6,631,988 bytes (u32 x 1.66M)
    Total:              16,579,970 bytes (15.8 MiB, 10.00 bytes/entry)

  After (block-indexed delta + ULEB128):
    lineinfo_block_addrs[]    103,628 bytes (101 KiB)
    lineinfo_block_offsets[]  103,628 bytes (101 KiB)
    lineinfo_data[]         6,070,158 bytes (5.8 MiB)
    Total:                  6,277,414 bytes (6.0 MiB, 3.79 bytes/entry)

  Savings: 9.8 MiB (2.64x reduction)

file_offsets[] and filenames[] are unchanged by this patch and are
excluded from both totals above.

Whole-image effect, measured the same way as patch 1/4:

  vmlinux (stripped), no lineinfo:      52.2 MiB
  vmlinux (stripped), before this fix:  68.2 MiB  (+16.0 MiB / +30.6%)
  vmlinux (stripped), after this fix:   60.2 MiB  ( +8.0 MiB / +15.3%)

Booted in QEMU and verified with SysRq-l that annotations still work:

  default_idle+0x9/0x10 (arch/x86/kernel/process.c:768)
  default_idle_call+0x6e/0xb0 (kernel/sched/idle.c:122)
  do_idle+0x38f/0x660 (kernel/sched/idle.c:199)
  cpu_startup_entry+0x4e/0x60 (kernel/sched/idle.c:453)
  rest_init+0x277/0x280 (init/main.c:732)

Suggested-by: Juergen Gross <jgross@suse.com>
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../admin-guide/kallsyms-lineinfo.rst         |   6 +-
 include/linux/mod_lineinfo.h                  | 263 +++++++++++++++---
 init/Kconfig                                  |   8 +-
 kernel/kallsyms.c                             |  60 ++--
 kernel/kallsyms_internal.h                    |   8 +-
 kernel/module/kallsyms.c                      | 127 ++++-----
 scripts/empty_lineinfo.S                      |  20 +-
 scripts/gen_lineinfo.c                        | 185 ++++++++----
 8 files changed, 457 insertions(+), 220 deletions(-)

diff --git a/Documentation/admin-guide/kallsyms-lineinfo.rst b/Documentation/admin-guide/kallsyms-lineinfo.rst
index 227ed9413be6c..a659f8564b5ed 100644
--- a/Documentation/admin-guide/kallsyms-lineinfo.rst
+++ b/Documentation/admin-guide/kallsyms-lineinfo.rst
@@ -77,10 +77,10 @@ Memory Overhead
 
 The vmlinux lineinfo tables are stored in ``.rodata``.  On an x86_64
 ``defconfig`` with ``CONFIG_DEBUG_INFO`` they hold 1.66 million entries and
-grow the stripped image by 16 MiB, about 10 bytes per entry after
-deduplication.
+grow the stripped image by 8 MiB, about 3.8 bytes per entry after delta
+compression.
 
-Per-module lineinfo adds about 10 bytes per entry to each ``.ko`` file, plus
+Per-module lineinfo adds about 4 bytes per entry to each ``.ko`` file, plus
 a small fixed cost per covered section.
 
 Known Limitations
diff --git a/include/linux/mod_lineinfo.h b/include/linux/mod_lineinfo.h
index cb0c7af7b3171..98208b5c04acf 100644
--- a/include/linux/mod_lineinfo.h
+++ b/include/linux/mod_lineinfo.h
@@ -3,9 +3,9 @@
  * mod_lineinfo.h - Binary format for per-module source line information
  *
  * This header defines the layout of the .mod_lineinfo and
- * .init.mod_lineinfo sections embedded in loadable kernel modules.  It
- * is dual-use: included from both the kernel and the userspace
- * gen_lineinfo tool.
+ * .init.mod_lineinfo sections embedded in loadable kernel modules.  It is
+ * dual-use: included from both the kernel and the userspace gen_lineinfo
+ * tool.
  *
  * Top-level layout (all values in target-native endianness):
  *
@@ -20,16 +20,27 @@
  * If the relocation fails to resolve (e.g. unknown reloc type), .anchor
  * stays zero and lookups silently degrade to "no annotation".
  *
- * Each per-section sub-table is laid out as a stand-alone
- * mod_lineinfo_header followed by parallel arrays:
+ * Each per-section sub-table is laid out exactly as a stand-alone
+ * mod_lineinfo_header followed by its arrays:
  *
- *   struct mod_lineinfo_header     (16 bytes)
- *   u32 addrs[num_entries]         -- offsets from this section's base, sorted
- *   u16 file_ids[num_entries]      -- parallel to addrs
- *   <2-byte pad if num_entries is odd>
- *   u32 lines[num_entries]         -- parallel to addrs
+ *   struct mod_lineinfo_header
+ *   u32 block_addrs[num_blocks]    -- first addr per block, for binary search
+ *   u32 block_offsets[num_blocks]  -- byte offset into compressed data stream
+ *   u8  data[data_size]            -- LEB128 delta-compressed entries
  *   u32 file_offsets[num_files]    -- byte offset into filenames[]
  *   char filenames[filenames_size] -- concatenated NUL-terminated strings
+ *
+ * Each sub-array is located by an explicit (offset, size) pair in the
+ * header, similar to a flattened devicetree.  All offsets in the per-section
+ * header are relative to that header itself, so a sub-table is fully
+ * self-describing.
+ *
+ * Compressed stream format (per block of LINEINFO_BLOCK_ENTRIES entries):
+ *   Entry 0: file_id (ULEB128), line (ULEB128)
+ *            addr is in block_addrs[]
+ *   Entry 1..N: addr_delta (ULEB128),
+ *               file_id_delta (SLEB128),
+ *               line_delta (SLEB128)
  */
 #ifndef _LINUX_MOD_LINEINFO_H
 #define _LINUX_MOD_LINEINFO_H
@@ -44,6 +55,7 @@
 #include <stdint.h>
 typedef uint32_t u32;
 typedef uint16_t u16;
+typedef uint8_t  u8;
 typedef uint64_t u64;
 #ifndef __aligned
 #define __aligned(x)	__attribute__((__aligned__(x)))
@@ -53,6 +65,8 @@ typedef uint64_t u64;
 #endif
 #endif
 
+#define LINEINFO_BLOCK_ENTRIES 64
+
 /*
  * Per-section descriptor.  One entry per ELF text section covered by the
  * blob (.text, .exit.text, .init.text, ...).
@@ -84,47 +98,222 @@ static_assert(sizeof(struct mod_lineinfo_section) == 16,
 
 struct mod_lineinfo_header {
 	u32 num_entries;
+	u32 num_blocks;
 	u32 num_files;
-	u32 filenames_size;	/* total bytes of concatenated filenames */
+	u32 blocks_offset;	/* offset to block_addrs[] from this header */
+	u32 blocks_size;	/* bytes: num_blocks * 2 * sizeof(u32) */
+	u32 data_offset;	/* offset to compressed stream */
+	u32 data_size;		/* bytes of compressed data */
+	u32 files_offset;	/* offset to file_offsets[] */
+	u32 files_size;		/* bytes: num_files * sizeof(u32) */
+	u32 filenames_offset;
+	u32 filenames_size;
 };
 
-/* Offset helpers: compute byte offset from the per-section header to each array. */
-
-static inline u32 mod_lineinfo_addrs_off(void)
-{
-	return sizeof(struct mod_lineinfo_header);
-}
+/*
+ * Descriptor for a lineinfo table, used by the shared lookup function.
+ * Callers populate this from either linker globals (vmlinux) or a
+ * validated mod_lineinfo_header (modules).
+ */
+struct lineinfo_table {
+	const u32 *blk_addrs;
+	const u32 *blk_offsets;
+	const u8  *data;
+	u32 data_size;
+	const u32 *file_offsets;
+	const char *filenames;
+	u32 num_entries;
+	u32 num_blocks;
+	u32 num_files;
+	u32 filenames_size;
+};
 
 /*
- * The counts come from an on-disk blob and are only validated against the
- * blob size once the full layout has been summed, so every step widens to
- * u64: at 10 bytes per entry the u32 sums wrap for counts a caller can
- * name, which would let a malformed blob pass a bounds check computed from
- * the wrapped value.
+ * Read a ULEB128 varint from a byte stream.
+ * Returns the decoded value and advances *pos past the encoded bytes.
+ * If *pos would exceed 'end', returns 0 and sets *pos = end (safe for
+ * NMI/panic context: no crash, just a missed annotation).
  */
-static inline u64 mod_lineinfo_file_ids_off(u32 num_entries)
+static inline u32 lineinfo_read_uleb128(const u8 *data, u32 *pos, u32 end)
 {
-	return mod_lineinfo_addrs_off() + (u64)num_entries * sizeof(u32);
-}
+	u32 result = 0;
+	unsigned int shift = 0;
 
-static inline u64 mod_lineinfo_lines_off(u32 num_entries)
-{
-	/* u16 file_ids[] may need 2-byte padding to align lines[] to 4 bytes */
-	u64 off = mod_lineinfo_file_ids_off(num_entries) +
-		  (u64)num_entries * sizeof(u16);
-	return (off + 3) & ~3ULL;
+	while (*pos < end) {
+		u8 byte = data[*pos];
+		(*pos)++;
+		result |= (u32)(byte & 0x7f) << shift;
+		if (!(byte & 0x80))
+			return result;
+		shift += 7;
+		if (shift >= 32) {
+			/* Malformed: skip remaining continuation bytes */
+			while (*pos < end && (data[*pos] & 0x80))
+				(*pos)++;
+			if (*pos < end)
+				(*pos)++;
+			return result;
+		}
+	}
+	return result;
 }
 
-static inline u64 mod_lineinfo_file_offsets_off(u32 num_entries)
+/* Read an SLEB128 varint. Same safety guarantees as above. */
+static inline int32_t lineinfo_read_sleb128(const u8 *data, u32 *pos, u32 end)
 {
-	return mod_lineinfo_lines_off(num_entries) +
-	       (u64)num_entries * sizeof(u32);
+	int32_t result = 0;
+	unsigned int shift = 0;
+	u8 byte = 0;
+
+	while (*pos < end) {
+		byte = data[*pos];
+		(*pos)++;
+		result |= (int32_t)((u32)(byte & 0x7f) << shift);
+		shift += 7;
+		if (!(byte & 0x80))
+			break;
+		if (shift >= 32) {
+			while (*pos < end && (data[*pos] & 0x80))
+				(*pos)++;
+			if (*pos < end)
+				(*pos)++;
+			return result;
+		}
+	}
+
+	/* Sign-extend if the high bit of the last byte was set */
+	if (shift < 32 && (byte & 0x40))
+		result |= -(1 << shift);
+
+	return result;
 }
 
-static inline u64 mod_lineinfo_filenames_off(u32 num_entries, u32 num_files)
+/*
+ * Search a lineinfo table for the source file and line corresponding to a
+ * given offset (from _text for vmlinux, from the covered section's base for
+ * modules).  @min_offset is the containing symbol's start in the same offset
+ * space: entries below it belong to a preceding symbol and are rejected.
+ *
+ * Safe for NMI and panic context: no locks, no allocations, all state on stack.
+ * Returns true and sets @file and @line on success; false on any failure.
+ */
+static inline bool lineinfo_search(const struct lineinfo_table *tbl,
+				   unsigned int offset,
+				   unsigned int min_offset,
+				   const char **file, unsigned int *line)
 {
-	return mod_lineinfo_file_offsets_off(num_entries) +
-	       (u64)num_files * sizeof(u32);
+	unsigned int low, high, mid, block;
+	unsigned int cur_addr, cur_file_id, cur_line;
+	unsigned int best_addr = 0, best_file_id = 0, best_line = 0;
+	unsigned int block_entries, data_end;
+	bool found = false;
+	u32 pos;
+
+	if (!tbl->num_entries || !tbl->num_blocks)
+		return false;
+
+	/* Binary search on blk_addrs[] to find the right block */
+	low = 0;
+	high = tbl->num_blocks;
+	while (low < high) {
+		mid = low + (high - low) / 2;
+		if (tbl->blk_addrs[mid] <= offset)
+			low = mid + 1;
+		else
+			high = mid;
+	}
+
+	if (low == 0)
+		return false;
+	block = low - 1;
+
+	/* How many entries in this block? */
+	block_entries = LINEINFO_BLOCK_ENTRIES;
+	if (block == tbl->num_blocks - 1) {
+		unsigned int remaining = tbl->num_entries -
+					block * LINEINFO_BLOCK_ENTRIES;
+
+		if (remaining < block_entries)
+			block_entries = remaining;
+	}
+
+	/* Determine end of this block's data in the compressed stream */
+	if (block + 1 < tbl->num_blocks)
+		data_end = tbl->blk_offsets[block + 1];
+	else
+		data_end = tbl->data_size;
+
+	/* Clamp data_end to actual data size */
+	if (data_end > tbl->data_size)
+		data_end = tbl->data_size;
+
+	/* Decode entry 0: addr from blk_addrs, file_id and line from stream */
+	pos = tbl->blk_offsets[block];
+	if (pos >= data_end)
+		return false;
+
+	cur_addr = tbl->blk_addrs[block];
+	cur_file_id = lineinfo_read_uleb128(tbl->data, &pos, data_end);
+	cur_line = lineinfo_read_uleb128(tbl->data, &pos, data_end);
+
+	/* Check entry 0 */
+	if (cur_addr <= offset) {
+		best_addr = cur_addr;
+		best_file_id = cur_file_id;
+		best_line = cur_line;
+		found = true;
+	}
+
+	/* Decode entries 1..N */
+	for (unsigned int i = 1; i < block_entries; i++) {
+		unsigned int addr_delta;
+		int32_t file_delta, line_delta;
+
+		addr_delta = lineinfo_read_uleb128(tbl->data, &pos, data_end);
+		file_delta = lineinfo_read_sleb128(tbl->data, &pos, data_end);
+		line_delta = lineinfo_read_sleb128(tbl->data, &pos, data_end);
+
+		cur_addr += addr_delta;
+		cur_file_id = (unsigned int)((int32_t)cur_file_id + file_delta);
+		cur_line = (unsigned int)((int32_t)cur_line + line_delta);
+
+		if (cur_addr > offset)
+			break;
+
+		best_addr = cur_addr;
+		best_file_id = cur_file_id;
+		best_line = cur_line;
+		found = true;
+	}
+
+	if (!found)
+		return false;
+
+	/*
+	 * The best entry is the closest one at or below @offset; reject it
+	 * if it lies below the resolved symbol's start, so a symbol without
+	 * line entries of its own does not inherit the preceding symbol's
+	 * annotation.
+	 */
+	if (best_addr < min_offset)
+		return false;
+
+	/*
+	 * A zero line is the generator's "no source location applies here"
+	 * marker, taken straight from a DWARF line-0 row.
+	 */
+	if (!best_line)
+		return false;
+
+	if (best_file_id >= tbl->num_files)
+		return false;
+
+	if (tbl->file_offsets[best_file_id] >= tbl->filenames_size)
+		return false;
+
+	*file = &tbl->filenames[tbl->file_offsets[best_file_id]];
+	*line = best_line;
+	return true;
 }
 
 #endif /* _LINUX_MOD_LINEINFO_H */
diff --git a/init/Kconfig b/init/Kconfig
index debf9c6f9e813..1cba9401d4452 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2147,8 +2147,9 @@ config KALLSYMS_LINEINFO
 	    anon_vma_clone+0x2ed/0xcf0 (mm/rmap.c:412)
 
 	  This requires libelf and libdw (from elfutils) on the build host.
-	  Costs 10 bytes per DWARF line-table entry; for x86_64_defconfig
-	  with CONFIG_DEBUG_INFO that is about 18MB.
+	  Costs about 3.8 bytes per DWARF line-table entry after delta
+	  compression; for x86_64_defconfig with CONFIG_DEBUG_INFO that is
+	  about 8MB.
 
 	  If unsure, say N.
 
@@ -2161,7 +2162,8 @@ config KALLSYMS_LINEINFO_MODULES
 	  so stack traces from module code include (file.c:123) annotations.
 
 	  This requires libelf and libdw (from elfutils) on the build host.
-	  Costs 10 bytes per DWARF line entry in each .ko.
+	  Costs about 3.8 bytes per DWARF line entry in each .ko after
+	  delta compression.
 
 	  If unsure, say N.
 
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 77543ac216a92..395297e27af53 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -467,13 +467,17 @@ static int append_buildid(char *buffer,   const char *modname,
 
 #endif /* CONFIG_STACKTRACE_BUILD_ID */
 
+#include <linux/mod_lineinfo.h>
+
 bool kallsyms_lookup_lineinfo(unsigned long addr, unsigned long sym_start,
 			      const char **file, unsigned int *line)
 {
 	unsigned long raw_offset, raw_min;
-	unsigned int offset, min_offset = 0, low, high, mid, file_id;
+	unsigned int offset, min_offset = 0;
+	struct lineinfo_table tbl;
 
-	if (!IS_ENABLED(CONFIG_KALLSYMS_LINEINFO) || !lineinfo_num_entries)
+	if (!IS_ENABLED(CONFIG_KALLSYMS_LINEINFO) ||
+	    !lineinfo_num_entries || !lineinfo_num_blocks)
 		return false;
 
 	/* Compute offset from _text */
@@ -491,8 +495,8 @@ bool kallsyms_lookup_lineinfo(unsigned long addr, unsigned long sym_start,
 		return false;
 
 	/*
-	 * The search below returns the closest entry at or below @offset, so
-	 * a symbol without line entries of its own (assembly without debug
+	 * The search returns the closest entry at or below the offset, so a
+	 * symbol without line entries of its own (assembly without debug
 	 * info, or anything past the _etext cap like .init.text) would
 	 * inherit the last entry of whatever precedes it.  Bound the result
 	 * to entries at or above the resolved symbol's start.
@@ -504,42 +508,18 @@ bool kallsyms_lookup_lineinfo(unsigned long addr, unsigned long sym_start,
 			min_offset = raw_min;
 	}
 
-	/* Binary search for largest entry <= offset */
-	low = 0;
-	high = lineinfo_num_entries;
-	while (low < high) {
-		mid = low + (high - low) / 2;
-		if (lineinfo_addrs[mid] <= offset)
-			low = mid + 1;
-		else
-			high = mid;
-	}
-
-	if (low == 0)
-		return false;
-	low--;
-
-	if (lineinfo_addrs[low] < min_offset)
-		return false;
-
-	/*
-	 * A zero line is the generator's "no source location applies here"
-	 * marker, taken straight from a DWARF line-0 row.
-	 */
-	if (!lineinfo_lines[low])
-		return false;
-
-	file_id = lineinfo_file_ids[low];
-	*line = lineinfo_lines[low];
-
-	if (file_id >= lineinfo_num_files)
-		return false;
-
-	if (lineinfo_file_offsets[file_id] >= lineinfo_filenames_size)
-		return false;
-
-	*file = &lineinfo_filenames[lineinfo_file_offsets[file_id]];
-	return true;
+	tbl.blk_addrs	= lineinfo_block_addrs;
+	tbl.blk_offsets	= lineinfo_block_offsets;
+	tbl.data	= lineinfo_data;
+	tbl.data_size	= lineinfo_data_size;
+	tbl.file_offsets = lineinfo_file_offsets;
+	tbl.filenames	= lineinfo_filenames;
+	tbl.num_entries	= lineinfo_num_entries;
+	tbl.num_blocks	= lineinfo_num_blocks;
+	tbl.num_files	= lineinfo_num_files;
+	tbl.filenames_size = lineinfo_filenames_size;
+
+	return lineinfo_search(&tbl, offset, min_offset, file, line);
 }
 
 /* Look up a kernel symbol and return it in a text buffer. */
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index d7374ce444d81..ffe4c658067ec 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -16,10 +16,12 @@ extern const unsigned int kallsyms_markers[];
 extern const u8 kallsyms_seqs_of_names[];
 
 extern const u32 lineinfo_num_entries;
-extern const u32 lineinfo_addrs[];
-extern const u16 lineinfo_file_ids[];
-extern const u32 lineinfo_lines[];
 extern const u32 lineinfo_num_files;
+extern const u32 lineinfo_num_blocks;
+extern const u32 lineinfo_block_addrs[];
+extern const u32 lineinfo_block_offsets[];
+extern const u32 lineinfo_data_size;
+extern const u8  lineinfo_data[];
 extern const u32 lineinfo_file_offsets[];
 extern const u32 lineinfo_filenames_size;
 extern const char lineinfo_filenames[];
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 511cfa58a3e44..1c9491b3617c1 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -506,9 +506,9 @@ int module_kallsyms_on_each_symbol(const char *modname,
 #include <linux/mod_lineinfo.h>
 
 /*
- * Search one per-section sub-table for @section_offset using flat parallel
- * arrays.  @hdr is the per-section header at byte offset @hdr_offset within
- * @blob.  Returns true on hit and populates @file / @line.
+ * Search one per-section sub-table for @section_offset.
+ * @hdr is the per-section header at byte offset @hdr_offset within @blob.
+ * Returns true on hit and populates @file / @line.
  */
 static bool module_lookup_lineinfo_section(const void *blob, u32 blob_size,
 					   u32 hdr_offset,
@@ -518,13 +518,8 @@ static bool module_lookup_lineinfo_section(const void *blob, u32 blob_size,
 					   unsigned int *line)
 {
 	const struct mod_lineinfo_header *hdr;
-	const u8 *base;
-	const u32 *addrs, *lines, *file_offsets;
-	const u16 *file_ids;
-	const char *filenames;
-	u32 num_entries, num_files, filenames_size;
-	unsigned int low, high, mid;
-	u16 file_id;
+	struct lineinfo_table tbl;
+	const void *base;
 
 	if (hdr_offset > blob_size ||
 	    blob_size - hdr_offset < sizeof(*hdr))
@@ -540,84 +535,72 @@ static bool module_lookup_lineinfo_section(const void *blob, u32 blob_size,
 		return false;
 
 	base = (const u8 *)blob + hdr_offset;
-	hdr = (const struct mod_lineinfo_header *)base;
-	num_entries = hdr->num_entries;
-	num_files = hdr->num_files;
-	filenames_size = hdr->filenames_size;
+	hdr = base;
 
-	if (num_entries == 0)
+	if (hdr->num_entries == 0 || hdr->num_blocks == 0)
 		return false;
 
-	/*
-	 * Check the whole layout against the blob in one go.  The offset
-	 * helpers sum in u64 precisely because a malformed blob can name
-	 * counts whose u32 sum wraps: at 10 bytes per entry across addrs[],
-	 * file_ids[] and lines[], num_entries = 0x33333334 wraps to a small
-	 * value that any bounds check would happily accept.
-	 */
+	/* Validate each sub-array fits within the remaining blob bytes */
 	{
 		u32 avail = blob_size - hdr_offset;
-		u64 needed = mod_lineinfo_filenames_off(num_entries, num_files);
 
-		if (needed > avail || filenames_size > avail - needed)
+		if (hdr->blocks_offset > avail ||
+		    hdr->blocks_size > avail - hdr->blocks_offset)
+			return false;
+		if (hdr->data_offset > avail ||
+		    hdr->data_size > avail - hdr->data_offset)
+			return false;
+		if (hdr->files_offset > avail ||
+		    hdr->files_size > avail - hdr->files_offset)
 			return false;
-	}
-
-	/*
-	 * Filenames are read as NUL-terminated C strings.  Require the blob
-	 * to end in NUL so a malformed file_offsets entry can never lead the
-	 * later "%s" consumer past the end of the section.
-	 */
-	if (filenames_size == 0 ||
-	    base[mod_lineinfo_filenames_off(num_entries, num_files) +
-		 filenames_size - 1] != 0)
-		return false;
 
-	addrs = (const u32 *)(base + mod_lineinfo_addrs_off());
-	file_ids = (const u16 *)(base + mod_lineinfo_file_ids_off(num_entries));
-	lines = (const u32 *)(base + mod_lineinfo_lines_off(num_entries));
-	file_offsets = (const u32 *)(base + mod_lineinfo_file_offsets_off(num_entries));
-	filenames = (const char *)(base + mod_lineinfo_filenames_off(num_entries, num_files));
-
-	/* Binary search for largest entry <= section_offset. */
-	low = 0;
-	high = num_entries;
-	while (low < high) {
-		mid = low + (high - low) / 2;
-		if (addrs[mid] <= section_offset)
-			low = mid + 1;
-		else
-			high = mid;
+		/*
+		 * block_addrs[], block_offsets[] and file_offsets[] are read
+		 * as u32 arrays, so their offsets need the same alignment
+		 * guarantee hdr_offset got above.
+		 */
+		if (!IS_ALIGNED(hdr->blocks_offset, sizeof(u32)) ||
+		    !IS_ALIGNED(hdr->files_offset, sizeof(u32)))
+			return false;
+		if (hdr->filenames_offset > avail ||
+		    hdr->filenames_size > avail - hdr->filenames_offset)
+			return false;
 	}
 
-	if (low == 0)
-		return false;
-	low--;
-
 	/*
-	 * Reject entries below the resolved symbol's start so a symbol
-	 * without line entries of its own does not inherit the preceding
-	 * symbol's annotation.
+	 * Validate counts before multiplying by element size — multiplication
+	 * could otherwise overflow on 32-bit builds with a malformed blob.
+	 * num_blocks contributes (addr,offset) u32 pairs; num_files contributes
+	 * one u32 each.
 	 */
-	if (addrs[low] < min_offset)
+	if (hdr->num_blocks > hdr->blocks_size / (2 * sizeof(u32)))
+		return false;
+	if (hdr->num_files > hdr->files_size / sizeof(u32))
 		return false;
 
 	/*
-	 * A zero line is the generator's "no source location applies here"
-	 * marker, taken straight from a DWARF line-0 row.
+	 * Filenames are read as NUL-terminated C strings.  Require the blob
+	 * to end in NUL so a malformed file_offsets entry can never lead the
+	 * later "%s" consumer past the end of the section.
 	 */
-	if (!lines[low])
-		return false;
-
-	file_id = file_ids[low];
-	if (file_id >= num_files)
-		return false;
-	if (file_offsets[file_id] >= filenames_size)
+	if (hdr->filenames_size == 0 ||
+	    ((const u8 *)base)[hdr->filenames_offset +
+			       hdr->filenames_size - 1] != 0)
 		return false;
 
-	*file = &filenames[file_offsets[file_id]];
-	*line = lines[low];
-	return true;
+	tbl.blk_addrs	= base + hdr->blocks_offset;
+	tbl.blk_offsets	= base + hdr->blocks_offset +
+			  hdr->num_blocks * sizeof(u32);
+	tbl.data	= base + hdr->data_offset;
+	tbl.data_size	= hdr->data_size;
+	tbl.file_offsets = base + hdr->files_offset;
+	tbl.filenames	= base + hdr->filenames_offset;
+	tbl.num_entries	= hdr->num_entries;
+	tbl.num_blocks	= hdr->num_blocks;
+	tbl.num_files	= hdr->num_files;
+	tbl.filenames_size = hdr->filenames_size;
+
+	return lineinfo_search(&tbl, section_offset, min_offset, file, line);
 }
 
 /*
@@ -644,6 +627,7 @@ static bool module_lookup_lineinfo_blob(const void *blob, u32 blob_size,
 	if (root->num_sections == 0)
 		return false;
 
+	/* Validate sections[] array fits within the blob */
 	if (root->num_sections > U32_MAX / sizeof(struct mod_lineinfo_section))
 		return false;
 	sections_end = sizeof(*root) +
@@ -679,6 +663,9 @@ static bool module_lookup_lineinfo_blob(const void *blob, u32 blob_size,
 
 /*
  * Look up source file:line for an address within a loaded module.
+ * Uses the .mod_lineinfo / .init.mod_lineinfo sections embedded in the .ko
+ * at build time.  Each section contains one or more per-section sub-tables
+ * keyed by an ELF-relocation-resolved anchor.
  *
  * Safe in NMI/panic context: no locks, no allocations.
  * Caller must hold RCU read lock (or be in a context where the module
diff --git a/scripts/empty_lineinfo.S b/scripts/empty_lineinfo.S
index e058c41137123..edd5b1092f050 100644
--- a/scripts/empty_lineinfo.S
+++ b/scripts/empty_lineinfo.S
@@ -14,12 +14,20 @@ lineinfo_num_entries:
 	.balign 4
 lineinfo_num_files:
 	.long 0
-	.globl lineinfo_addrs
-lineinfo_addrs:
-	.globl lineinfo_file_ids
-lineinfo_file_ids:
-	.globl lineinfo_lines
-lineinfo_lines:
+	.globl lineinfo_num_blocks
+	.balign 4
+lineinfo_num_blocks:
+	.long 0
+	.globl lineinfo_block_addrs
+lineinfo_block_addrs:
+	.globl lineinfo_block_offsets
+lineinfo_block_offsets:
+	.globl lineinfo_data_size
+	.balign 4
+lineinfo_data_size:
+	.long 0
+	.globl lineinfo_data
+lineinfo_data:
 	.globl lineinfo_file_offsets
 lineinfo_file_offsets:
 	.globl lineinfo_filenames_size
diff --git a/scripts/gen_lineinfo.c b/scripts/gen_lineinfo.c
index 3f889e0c2281c..428e49c291fd8 100644
--- a/scripts/gen_lineinfo.c
+++ b/scripts/gen_lineinfo.c
@@ -2018,6 +2018,45 @@ static void deduplicate(struct covered_section *sections,
 	}
 }
 
+/*
+ * Emit the LEB128 delta-compressed data stream for one block.
+ * @base is the absolute index of the first entry, @count is the number of
+ * entries in this block (<= LINEINFO_BLOCK_ENTRIES).  Used by both vmlinux
+ * mode (one section, full entries[]) and module mode (per-section ranges).
+ */
+static void emit_block_data_range(unsigned int base, unsigned int count)
+{
+	if (!count)
+		return;
+
+	/* Entry 0: file_id, line (both unsigned) */
+	printf("\t.uleb128 %u\n", entries[base].file_id);
+	printf("\t.uleb128 %u\n", entries[base].line);
+
+	/* Entries 1..N: addr_delta (unsigned), file/line deltas (signed) */
+	for (unsigned int i = 1; i < count; i++) {
+		unsigned int idx = base + i;
+
+		printf("\t.uleb128 %u\n",
+		       entries[idx].offset - entries[idx - 1].offset);
+		printf("\t.sleb128 %d\n",
+		       (int)entries[idx].file_id - (int)entries[idx - 1].file_id);
+		printf("\t.sleb128 %d\n",
+		       (int)entries[idx].line - (int)entries[idx - 1].line);
+	}
+}
+
+/* Vmlinux-mode wrapper: pick block index out of the global entries[]. */
+static void emit_block_data(unsigned int block)
+{
+	unsigned int base = block * LINEINFO_BLOCK_ENTRIES;
+	unsigned int count = num_entries - base;
+
+	if (count > LINEINFO_BLOCK_ENTRIES)
+		count = LINEINFO_BLOCK_ENTRIES;
+	emit_block_data_range(base, count);
+}
+
 static void compute_file_offsets(void)
 {
 	unsigned int offset = 0;
@@ -2041,6 +2080,11 @@ static void print_escaped_asciz(const char *s)
 
 static void output_assembly(void)
 {
+	unsigned int num_blocks;
+
+	num_blocks = num_entries ?
+		(num_entries + LINEINFO_BLOCK_ENTRIES - 1) / LINEINFO_BLOCK_ENTRIES : 0;
+
 	printf("/* SPDX-License-Identifier: GPL-2.0 */\n");
 	printf("/*\n");
 	printf(" * Automatically generated by scripts/gen_lineinfo\n");
@@ -2061,29 +2105,40 @@ static void output_assembly(void)
 	printf("lineinfo_num_files:\n");
 	printf("\t.long %u\n\n", num_files);
 
-	/* Sorted address offsets from _text */
-	printf("\t.globl lineinfo_addrs\n");
+	/* Number of blocks */
+	printf("\t.globl lineinfo_num_blocks\n");
 	printf("\t.balign 4\n");
-	printf("lineinfo_addrs:\n");
-	for (unsigned int i = 0; i < num_entries; i++)
-		printf("\t.long 0x%x\n", entries[i].offset);
-	printf("\n");
+	printf("lineinfo_num_blocks:\n");
+	printf("\t.long %u\n\n", num_blocks);
 
-	/* File IDs, parallel to addrs (u16 -- supports up to 65535 files) */
-	printf("\t.globl lineinfo_file_ids\n");
-	printf("\t.balign 2\n");
-	printf("lineinfo_file_ids:\n");
-	for (unsigned int i = 0; i < num_entries; i++)
-		printf("\t.short %u\n", entries[i].file_id);
-	printf("\n");
+	/* Block first-addresses for binary search */
+	printf("\t.globl lineinfo_block_addrs\n");
+	printf("\t.balign 4\n");
+	printf("lineinfo_block_addrs:\n");
+	for (unsigned int i = 0; i < num_blocks; i++)
+		printf("\t.long 0x%x\n", entries[i * LINEINFO_BLOCK_ENTRIES].offset);
 
-	/* Line numbers, parallel to addrs */
-	printf("\t.globl lineinfo_lines\n");
+	/* Block byte offsets into compressed stream */
+	printf("\t.globl lineinfo_block_offsets\n");
 	printf("\t.balign 4\n");
-	printf("lineinfo_lines:\n");
-	for (unsigned int i = 0; i < num_entries; i++)
-		printf("\t.long %u\n", entries[i].line);
-	printf("\n");
+	printf("lineinfo_block_offsets:\n");
+	for (unsigned int i = 0; i < num_blocks; i++)
+		printf("\t.long .Lblock_%u - lineinfo_data\n", i);
+
+	/* Compressed data size */
+	printf("\t.globl lineinfo_data_size\n");
+	printf("\t.balign 4\n");
+	printf("lineinfo_data_size:\n");
+	printf("\t.long .Ldata_end - lineinfo_data\n\n");
+
+	/* Compressed data stream */
+	printf("\t.globl lineinfo_data\n");
+	printf("lineinfo_data:\n");
+	for (unsigned int i = 0; i < num_blocks; i++) {
+		printf(".Lblock_%u:\n", i);
+		emit_block_data(i);
+	}
+	printf(".Ldata_end:\n\n");
 
 	/* File string offset table */
 	printf("\t.globl lineinfo_file_offsets\n");
@@ -2091,45 +2146,39 @@ static void output_assembly(void)
 	printf("lineinfo_file_offsets:\n");
 	for (unsigned int i = 0; i < num_files; i++)
 		printf("\t.long %u\n", files[i]->str_offset);
-	printf("\n");
 
 	/* Filenames size */
-	{
-		unsigned int fsize = 0;
-
-		for (unsigned int i = 0; i < num_files; i++)
-			fsize += strlen(files[i]->name) + 1;
-		printf("\t.globl lineinfo_filenames_size\n");
-		printf("\t.balign 4\n");
-		printf("lineinfo_filenames_size:\n");
-		printf("\t.long %u\n\n", fsize);
-	}
+	printf("\t.globl lineinfo_filenames_size\n");
+	printf("\t.balign 4\n");
+	printf("lineinfo_filenames_size:\n");
+	printf("\t.long .Lfilenames_end - lineinfo_filenames\n\n");
 
 	/* Concatenated NUL-terminated filenames */
 	printf("\t.globl lineinfo_filenames\n");
 	printf("lineinfo_filenames:\n");
 	for (unsigned int i = 0; i < num_files; i++)
 		print_escaped_asciz(files[i]->name);
-	printf("\n");
+	printf(".Lfilenames_end:\n");
 }
 
 /*
- * Emit one per-section table in the simple flat-array layout:
+ * Emit one per-section table.  @suffix uniquifies the local labels so
+ * multiple tables can coexist in a single output blob; @blob_root_label
+ * is the symbol for the start of the enclosing blob (used for
+ * table_offset = .Lhdr - .Lroot).
  *
- *   mod_lineinfo_header
- *   addrs[count]    (u32, sorted)
- *   file_ids[count] (u16) + 2-byte pad if count is odd
- *   lines[count]    (u32)
- *   file_offsets[]  (u32)
- *   filenames[]
- *
- * @suffix uniquifies labels so multiple tables can coexist in one blob.
- * Caller has sorted entries[] so this section's entries occupy [first,
- * first + count).
+ * Caller has already sorted entries[] so this section's entries occupy
+ * the contiguous range [first, first + count).  This function emits
+ * block-relative addresses computed from entries[first + N].offset.
  */
 static void emit_section_table(unsigned int first, unsigned int count,
 			       const char *suffix)
 {
+	unsigned int num_blocks;
+
+	num_blocks = count ?
+		(count + LINEINFO_BLOCK_ENTRIES - 1) / LINEINFO_BLOCK_ENTRIES : 0;
+
 	/*
 	 * Align before defining the label, not after: the descriptor stores
 	 * table_offset as .Lhdr - .Lroot, and every field offset inside the
@@ -2140,29 +2189,45 @@ static void emit_section_table(unsigned int first, unsigned int count,
 	printf("\t.balign 4\n");
 	printf(".Lhdr%s:\n", suffix);
 	printf("\t.long %u\t\t/* num_entries */\n", count);
+	printf("\t.long %u\t\t/* num_blocks */\n", num_blocks);
 	printf("\t.long %u\t\t/* num_files */\n", num_files);
+	printf("\t.long .Lblk_addrs%s - .Lhdr%s\n", suffix, suffix);
+	printf("\t.long .Lblk_offsets_end%s - .Lblk_addrs%s\n", suffix, suffix);
+	printf("\t.long .Ldata%s - .Lhdr%s\n", suffix, suffix);
+	printf("\t.long .Ldata_end%s - .Ldata%s\n", suffix, suffix);
+	printf("\t.long .Lfile_offsets%s - .Lhdr%s\n", suffix, suffix);
+	printf("\t.long .Lfile_offsets_end%s - .Lfile_offsets%s\n", suffix, suffix);
+	printf("\t.long .Lfilenames%s - .Lhdr%s\n", suffix, suffix);
 	printf("\t.long .Lfilenames_end%s - .Lfilenames%s\n\n", suffix, suffix);
 
-	/* addrs[] */
-	for (unsigned int i = 0; i < count; i++)
-		printf("\t.long 0x%x\n", entries[first + i].offset);
-
-	/* file_ids[] */
-	for (unsigned int i = 0; i < count; i++)
-		printf("\t.short %u\n", entries[first + i].file_id);
-	if (count & 1)
-		printf("\t.short 0\t\t/* pad to align lines[] */\n");
-
-	/* lines[] */
-	for (unsigned int i = 0; i < count; i++)
-		printf("\t.long %u\n", entries[first + i].line);
+	printf(".Lblk_addrs%s:\n", suffix);
+	for (unsigned int i = 0; i < num_blocks; i++)
+		printf("\t.long 0x%x\n",
+		       entries[first + i * LINEINFO_BLOCK_ENTRIES].offset);
+
+	printf(".Lblk_offsets%s:\n", suffix);
+	for (unsigned int i = 0; i < num_blocks; i++)
+		printf("\t.long .Lblock%s_%u - .Ldata%s\n", suffix, i, suffix);
+	printf(".Lblk_offsets_end%s:\n\n", suffix);
+
+	printf(".Ldata%s:\n", suffix);
+	for (unsigned int i = 0; i < num_blocks; i++) {
+		unsigned int base = first + i * LINEINFO_BLOCK_ENTRIES;
+		unsigned int n = count - i * LINEINFO_BLOCK_ENTRIES;
+
+		if (n > LINEINFO_BLOCK_ENTRIES)
+			n = LINEINFO_BLOCK_ENTRIES;
+		printf(".Lblock%s_%u:\n", suffix, i);
+		emit_block_data_range(base, n);
+	}
+	printf(".Ldata_end%s:\n", suffix);
 
-	/* file_offsets[] */
 	printf("\t.balign 4\n");
+	printf(".Lfile_offsets%s:\n", suffix);
 	for (unsigned int i = 0; i < num_files; i++)
 		printf("\t.long %u\n", files[i]->str_offset);
+	printf(".Lfile_offsets_end%s:\n\n", suffix);
 
-	/* filenames[] */
 	printf(".Lfilenames%s:\n", suffix);
 	for (unsigned int i = 0; i < num_files; i++)
 		print_escaped_asciz(files[i]->name);
@@ -2442,7 +2507,11 @@ int main(int argc, char *argv[])
 		deduplicate(NULL, 0);
 		compute_file_offsets();
 
-		verbose_msg("%u entries, %u files", num_entries, num_files);
+		verbose_msg("%u entries, %u files, %u blocks",
+			    num_entries, num_files,
+			    num_entries ?
+			    (num_entries + LINEINFO_BLOCK_ENTRIES - 1) /
+			    LINEINFO_BLOCK_ENTRIES : 0);
 
 		output_assembly();
 	}
-- 
2.53.0

