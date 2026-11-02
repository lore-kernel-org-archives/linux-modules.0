Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618100;
	b=r9csyAvSiYRYlAcyACNmYYPMtQcJ16/Has9GNJrmgnarLS7y65LZB3IChD64U0X57SmH
	 NXNj0ezI57yYe/F/XELVFVAC2uxgLJgx91TuQgf0R1jpFY0oF57Pw8o+PDFtE02a5X4IF
	 Glz0DraZN3HsmdvG0SpVFZE25uDjAgHEMEBM1bQCQl8tZBLWNSrf0yFVu9kytnHe6cKIC
	 GNb8wr0P9+FMDofwFFoZKRWBoqeob4UQKrPaMrGe9pzfGUmTApAvJ/VDfO/SEFjy9CU7v
	 bDw6RmSuLWcKRlcx9uxLzjnrru/dSr+qK2frLbyu+G08vAQRim89DaWUpQyB/r9DFCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618100;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mlVozMDZ+JvdjBi9ct13qmWLZ1hUgDjIlNFUtUQHfg4=;
	b=1BYgX0Gcp+SqGJSWziwTW/+cKyLu0Vbp+QY+ifhF1RzeKVsVMIl8vJIlwPqev7s3WSeO
	 CEDRbYla24lYXBztAhvLh2d4TbLBwR0PQ6w+w+r6z+zn1Kv2KwZdJQ2EzfWvh5CrZeOZJ
	 p9LKjvitTTckmuwA2Df6XdKxDkPr06OmAJ9LBy5zx2a1Hn4rJLm3xcRYyK1HY/e5DjuV3
	 cXzMaVtU5DXCTTVBxYjJenbe84yDDemCI7h5m4D87wNwfpNuHt4oVOQFaTQ2gkf+QYe7S
	 9YVdcWFsOERuNtUUNr3bFe2dBKuZ/gzwyXgaJ5CNYawKspClVZ4ADoCPd0d2D+Pk/qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdjywX2v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843B606A32C;
	Mon,  2 Nov 2026 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdjywX2v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482C91F00A16;
	Mon,  2 Nov 2026 11:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793618099;
	bh=mlVozMDZ+JvdjBi9ct13qmWLZ1hUgDjIlNFUtUQHfg4=;
	h=From:To:Cc:Subject:Date;
	b=CdjywX2v1x1IhoOFWV1BN6aQIdFLlyuDRcHs+LAHCRGV1A73OU4LPNQfVBXXoDYGJ
	 s6Gqth0cou2w/mfUpJbJfYw4/RO7nasnOgP7mSjUNocWsaDk5DHjTIHCyMiuEo8Wj7
	 mawbJhMvuQmKDzALmA+5IB68qBxqu0+6y2Ww3MQYTIz0G2UXZcPdM5raTR3Qu2/8qW
	 uW03JyHHaJQ8vBZlX49McFPcUH/A8n59PP47uMdzPaX1mJIAfR5iSbbFVGhxQa+n6e
	 umJshjc4YV7YMCAojvoF6BmF4SH+JVsYQHSqhNAY7FnBO6FMjLYL1KytIKnxsPtE2Z
	 cX2FlojBQjScQ==
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
	Aaron Tomlin <atomlin@atomlin.com>,
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
Subject: [PATCH v10 0/4] kallsyms: embed source file:line info in kernel stack traces
Date: Mon,  2 Nov 2026 06:14:50 -0500
Message-ID: <20261102111455.919102-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CONFIG_KALLSYMS_LINEINFO embeds a compact address-to-line lookup table in
the kernel image so stack traces print source locations directly, without
decode_stacktrace.sh or a vmlinux with debug info at runtime:

  default_idle+0x9/0x10 (arch/x86/kernel/process.c:768)
  default_idle_call+0x6e/0xb0 (kernel/sched/idle.c:122)
  do_idle+0x38f/0x660 (kernel/sched/idle.c:199)
  cpu_startup_entry+0x4e/0x60 (kernel/sched/idle.c:453)
  rest_init+0x277/0x280 (init/main.c:732)
  common_startup_64+0x13e/0x158 (arch/x86/kernel/head_64.S:418)

Patch 2 extends this to loadable modules, patch 3 delta-compresses the
tables, patch 4 adds KUnit coverage.

Why this is useful
==================

A stack trace in a bug report is usually all you get.  The reporter has
already rebooted, the machine belongs to a customer, or the failure came
out of an automated run that tore its environment down an hour ago.  What
lands in the report is a list of symbol+offset frames:

  ext4_do_update_inode+0x2a1/0x4c0
  ext4_mark_iloc_dirty+0x5f/0x210
  __ext4_mark_inode_dirty+0x9c/0x330

Turning that into source locations requires the exact vmlinux that
produced it, with debug info, fed to decode_stacktrace.sh or addr2line.
In practice that artifact is the thing that is missing:

- Distributions strip the shipped kernel and put debug info in a separate
  package of a few hundred megabytes that is not installed by default.
  Fetching it after the fact only helps if it still matches the build that
  crashed, and on a machine that has been updated since, it does not.

- A reporter who rebuilds "the same" kernel to decode the trace does not
  get the same offsets.  A different compiler version, one changed config
  option, or a different link order moves symbols around.  The decode then
  yields plausible but wrong line numbers, which is worse than yielding
  none, because nothing flags it as wrong.

- Panics captured through pstore/ramoops, a serial console, a photograph
  of a screen, or a customer's ticket system arrive as text.  There is no
  binary left to go back to.

The usual answer, "please rebuild with CONFIG_DEBUG_INFO and reproduce",
quietly ends a good share of investigations: the reproducer is rare, the
machine is in production, or the reporter has moved on.  With the table
embedded, the trace above decodes itself at the point it is printed, on
the machine that crashed, with no second artifact to find.

Two cases go beyond convenience, because symbol+offset cannot express
them at all:

- Inlining.  A frame names the outermost function that survived inlining,
  so an oops inside a static helper or a header inline reports the caller.
  The offset is the only clue about which inlined body faulted, and it is
  not a clue anyone can follow without the binary.  A file:line points
  into the header the code actually came from.

- Assembly.  Frames in .S files have no useful decode in a plain trace;
  here they resolve like any other, for instance
  arch/x86/entry/entry_64.S:121.

Module frames are the worst case today, since decoding them needs the
matching .ko, built with debug info and kept from the build that ran.
Patch 2 makes them self-annotating, which matters most for out-of-tree and
vendor modules, where the person reading the trace rarely has that.

For anyone triaging at scale, syzbot-style pipelines, distribution crash
aggregation, kdump fleets, traces that carry file:line can be clustered by
source location instead of by symbol+offset, which changes from build to
build.  The same trace text stays comparable across kernel versions for
far longer.

The feature is opt-in and bounded.  On x86_64 defconfig + CONFIG_DEBUG_INFO
the stripped image grows 8.0 MiB (52.2 -> 60.2 MiB, +15.3%) with the
compression in 3/4.  There is no cost on any hot path: the tables are
read-only data, consulted when formatting offset-bearing symbols, with no
locks and no allocations, so the lookup is safe from NMI and panic
context.  Lookups use offsets from _text, so KASLR does not disturb them,
and nothing is needed at runtime: no debuginfod, no symbol server, no
network.

The information all of this rests on already exists at build time.  Today
it is discarded at the end of the build and asked for again, months later,
from whoever hit the bug.  This series keeps 8 MiB of it instead.

Changes since v9
================

- Rebase on v7.4-rc1.
- Regenerate the vmlinux table only when text below _etext moves.  The
  table stops at _etext, but the check also compared .init.text, which
  follows .rodata and moves whenever the real table replaces the stub, so
  every x86 build took the extra link and generation pass.
- Export sprint_backtrace() and sprint_backtrace_build_id() with
  EXPORT_SYMBOL_IF_KUNIT() instead of EXPORT_SYMBOL_GPL().
- From the sashiko.dev review of v9: wrap-safe bounds checks on
  relocation offsets, an sh_entsize check in find_vmlinux_sym(), and
  freeing the remaining arrays at exit.
- Relink vmlinux when scripts/gen_lineinfo changes, as modules already
  did.
- Keep the end row of a sequence that ends exactly at _etext, without
  which the last function below _etext could lose its annotation.
- Skip a module debug section with no data (SHT_NOBITS) rather than
  writing through a null buffer.
- Documentation: assembly frames are annotated, which the example output
  and the limitations list said they were not.
- Drop the Assisted-by tags.  Tool use is described below instead.

v9: https://lore.kernel.org/all/20260917133727.428546-1-sashal@kernel.org/

Tool use
========

LLM coding assistants were used throughout this series: for parts of the
implementation, for review passes over each version, and to build the
DWARF fixtures and checking scripts behind the testing below.

Testing
=======

v10 on v7.4-rc1, x86_64 defconfig + CONFIG_DEBUG_INFO, booted under
QEMU/KVM:

- KUnit, CONFIG_LINEINFO_KUNIT_TEST=y builtin:
  33 passed, 0 failed, 1 skipped
- KUnit, =m with CONFIG_KALLSYMS_LINEINFO_MODULES=y:
  32 passed, 0 failed, 2 skipped
- KUnit, =m with CONFIG_KALLSYMS_LINEINFO_MODULES=n:
  8 passed, 0 failed, 26 skipped (skips rather than fails, as intended)
- SysRq-l backtraces annotated
- Run on the same vmlinux and on each of the 16 modules in the build,
  gen_lineinfo emits the same tables as v9's, so the v9 results below
  still apply to the generator
- Each of the four patches builds standalone with no warnings; arm64
  defconfig and ARCH=i386 defconfig build clean

From v9, on v7.3-rc3 with a distribution-style config:

- Every entry of four built modules diffed against addr2line: 100,725
  entries agree.  16,098 addresses probed across them in the other two
  directions: none annotated where DWARF has no location, none left
  unannotated where it has one
- The vmlinux table checked the same three ways: 4,000 sampled entries
  agree with addr2line, and of 4,001 probed addresses none is wrong in
  either direction.  Repeated on a build with -ffunction-sections, where
  one compile unit's sequences do end up adjacent, which is the case the
  row-selection rule for shared addresses turns on
- SysRq-l backtraces annotated, including .S frames and header inlines
- Every .ko sub-table header 4-byte aligned, 14 modules with a blob, 9 of
  them with two or more section descriptors
- Multi-object coverage checked by dumping the blobs: kvm.ko now names
  all 30 of its source files, where before it named one
- Compressed debug info: -gz=zlib and -gz=zstd objects give tables
  identical to an uncompressed build
- Relinking a module with only LDFLAGS_MODULE changed keeps its table
- A module relinked with a stale table object planted in the build tree
  ignores it and emits the same section, byte for byte
- MIPS64, SPARC64 and Hexagon objects checked directly: MIPS64 matches
  llvm-addr2line, the other two are refused rather than mis-generated
- arm64 defconfig, ARCH=arm multi_v7_defconfig (943 modules), ARCH=i386
  defconfig, and x86_64 with LLVM=1: all clean, no warnings

Sasha Levin (4):
  kallsyms: embed source file:line info in kernel stack traces
  kallsyms: extend lineinfo to loadable modules
  kallsyms: delta-compress lineinfo tables for ~2.7x size reduction
  kallsyms: add KUnit tests for lineinfo feature

 Documentation/admin-guide/index.rst           |    1 +
 .../admin-guide/kallsyms-lineinfo.rst         |  100 +
 MAINTAINERS                                   |    9 +
 include/linux/kallsyms.h                      |   18 +-
 include/linux/mod_lineinfo.h                  |  321 +++
 include/linux/module.h                        |   40 +
 init/Kconfig                                  |   35 +
 kernel/kallsyms.c                             |  110 +-
 kernel/kallsyms_internal.h                    |   11 +
 kernel/module/kallsyms.c                      |  200 ++
 kernel/module/main.c                          |   26 +
 lib/Kconfig.debug                             |   10 +
 lib/tests/Makefile                            |    4 +
 lib/tests/lineinfo_kunit.c                    | 1110 +++++++
 lib/tests/lineinfo_kunit.h                    |   21 +
 lib/tests/lineinfo_kunit_second.c             |   21 +
 scripts/.gitignore                            |    1 +
 scripts/Makefile                              |    3 +
 scripts/Makefile.modfinal                     |   41 +-
 scripts/Makefile.vmlinux                      |    4 +
 scripts/empty_lineinfo.S                      |   38 +
 scripts/gen-mod-lineinfo.sh                   |   45 +
 scripts/gen_lineinfo.c                        | 2543 +++++++++++++++++
 scripts/kallsyms.c                            |   11 +
 scripts/link-vmlinux.sh                       |   91 +-
 25 files changed, 4802 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/admin-guide/kallsyms-lineinfo.rst
 create mode 100644 include/linux/mod_lineinfo.h
 create mode 100644 lib/tests/lineinfo_kunit.c
 create mode 100644 lib/tests/lineinfo_kunit.h
 create mode 100644 lib/tests/lineinfo_kunit_second.c
 create mode 100644 scripts/empty_lineinfo.S
 create mode 100755 scripts/gen-mod-lineinfo.sh
 create mode 100644 scripts/gen_lineinfo.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

