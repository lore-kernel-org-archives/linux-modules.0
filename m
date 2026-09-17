Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C352B1C2;
	Thu, 17 Sep 2026 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652263; cv=none; b=Xd4wO+8fxuvaczEOutEEm85/oi3aE+X87npda03hIrDU2OB74q4AI9m1s4mNk9OS1WAq+EzZqJA0vq4Lhx6MCGkpojfq5eFxOo5eUaFVdZrzBE1KVT0QQU49+8mma1GXgvWjX3GEqsZUpkQledlG+lFw6rXgaH8u0isQeZM9brg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652263; c=relaxed/simple;
	bh=i2e28DSY9OJFMn+Yei5UTwRLlFG6pUChC039RIqj300=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DTQbp34nZDubp2DMe6R5ar8P8OZrcFNdvQnVNRvsoOWYbGGJt8L4UxyOJEmJFU4pT+o5eTi2tUNmOsoDPsreHH61aVOKrkhXxJwbAqKV7EgrfxkZSq2GFWQeB6DyqSNA070+hr6Oi1Zv0OoF+Hhl8RXM3CKYf8BDYYj3PXvR2zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkdauEtU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkdauEtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446B01F000FF;
	Thu, 17 Sep 2026 13:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789652252;
	bh=lg/US5lY1LsQarxH6D624+fOci1ZXIwXzP/RrKKTJiE=;
	h=From:To:Cc:Subject:Date;
	b=CkdauEtUcuQfeCy7WW0kbl27qF96vhyPoFdaDVAo+mxfulMmOjH1zvV0/0GFY2iWI
	 7e7gjqXqmSJr2Is6n/mAGW8EqmDWVkDtgn4Tl8bDgYF8hTpv04QRuHI9dDMLxvG3Kx
	 qqCDYU3k3KIq64l6r+aeYJ8pU3Q2RNbwiF1BrmB0aYCGfeS9FvDsPyTM4PiLX5QL+Z
	 B+mKCu/ILHdSa7TOXOADcfx7u3/clEXcAqxgwFgbkDzR/N78O7Uaqy2g44DA8JL8Ri
	 mgvgoxBZML1nc6y8s4qbFKDdQWOoX0bWiytfudnh1cFE+mZHJne7pMCbm0Rw5vQdb1
	 8jco0V6N8T4KA==
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
Subject: [PATCH v9 0/4] kallsyms: embed source file:line info in kernel stack traces
Date: Thu, 17 Sep 2026 09:37:21 -0400
Message-ID: <20260917133727.428546-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
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

Changes since v8
================

- Rebase on v7.3-rc3; size and entry-count figures re-measured.
- Keep the last line-program row at an address rather than the first, so an
  inlined call resolves to the inlined body and not to the call site.
- Annotate %pS and %pSb as well, not only the sprint_backtrace*() forms.
- Expand SHF_COMPRESSED debug sections before applying relocations to them.
- Apply RISC-V and LoongArch ADD/SUB relocation pairs, and refuse an object
  that leaves any relocation in a patched debug section unapplied.
- Emit line-0 and end_sequence rows as "no annotation" markers instead of
  dropping them, so an address DWARF leaves unattributed reports nothing.
- Resolve rows sharing an address: a line-0 row wins where the line program
  puts it last, a sequence end yields to a sequence beginning there, and
  across compile units coverage is the union.
- Give a function an entry at its own first byte where one row covers
  several, which is an assembly macro; in C such a row is padding or a
  split-out fragment, so the unit's language decides.
- CONFIG_CPU_ENDIAN_BE8: build the table from an unconverted partial link and
  hold back only --be8 and --build-id for the link that produces the module.
- Guard EM_LOONGARCH and R_LARCH_*, which glibc gained only in 2.36.
- Regenerate lineinfo when the final vmlinux link moves text.
- Decode MIPS n64 r_info by its own layout rather than with GELF_R_*.
- Refuse architectures with no known absolute relocation type, instead of
  generating a table from unrelocated DWARF.
- Fold module table generation into the link command, so a relink caused by a
  command-line change alone cannot drop the table.
- Relocate every debug section libdw reads: a module built from several
  objects carried line info for the first one only.
- Pass KBUILD_LDFLAGS to the module ld -r, without which ARCH=i386 fails at
  its first module and 32-bit ARM warns on every one.
- Check the actual bounds in the init-text KUnit case, which UML fails.
- 4/4 builds the KUnit module from two objects and covers the inline-site and
  second-object paths, neither of which a single-object module can reach.
- From the sashiko.dev review of v8: scnprintf() in __sprint_symbol(), u64
  sums in the blob offset helpers, and an alignment check on blocks_offset
  and files_offset.

v8: https://lore.kernel.org/all/20260801143219.3975824-1-sashal@kernel.org/

Testing
=======

A distribution-style config with CONFIG_DEBUG_INFO, booted under
QEMU/KVM:

- KUnit, CONFIG_LINEINFO_KUNIT_TEST=y builtin:
  33 passed, 0 failed, 1 skipped
- KUnit, =m with CONFIG_KALLSYMS_LINEINFO_MODULES=y:
  32 passed, 0 failed, 2 skipped
- KUnit, =m with CONFIG_KALLSYMS_LINEINFO_MODULES=n:
  8 passed, 0 failed, 26 skipped (skips rather than fails, as intended)
- Every entry of four built modules diffed against addr2line: 100,725
  entries agree.  16,098 addresses probed across them in the other two
  directions: none annotated where DWARF has no location, none left
  unannotated where it has one
- The vmlinux table checked the same three ways: 4,000 sampled entries
  agree with addr2line, and of 4,001 probed addresses none is wrong in
  either direction.  Repeated on a build with -ffunction-sections, where
  one compile unit's sequences do end up adjacent, which is the case the
  rule above turns on
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

Builds:

- Each of the four patches builds standalone on x86_64 defconfig +
  CONFIG_DEBUG_INFO, 0 objtool warnings at every point
- arm64 defconfig, ARCH=arm multi_v7_defconfig (943 modules), ARCH=i386
  defconfig, and x86_64 with LLVM=1: all clean, no warnings

Sasha Levin (4):
  kallsyms: embed source file:line info in kernel stack traces
  kallsyms: extend lineinfo to loadable modules
  kallsyms: delta-compress lineinfo tables for ~2.7x size reduction
  kallsyms: add KUnit tests for lineinfo feature

 Documentation/admin-guide/index.rst           |    1 +
 .../admin-guide/kallsyms-lineinfo.rst         |   99 +
 MAINTAINERS                                   |    9 +
 include/linux/kallsyms.h                      |   18 +-
 include/linux/mod_lineinfo.h                  |  319 +++
 include/linux/module.h                        |   40 +
 init/Kconfig                                  |   35 +
 kernel/kallsyms.c                             |  108 +-
 kernel/kallsyms_internal.h                    |   11 +
 kernel/module/kallsyms.c                      |  200 ++
 kernel/module/main.c                          |   26 +
 lib/Kconfig.debug                             |   10 +
 lib/tests/Makefile                            |    4 +
 lib/tests/lineinfo_kunit.c                    | 1109 ++++++++
 lib/tests/lineinfo_kunit.h                    |   21 +
 lib/tests/lineinfo_kunit_second.c             |   21 +
 scripts/.gitignore                            |    1 +
 scripts/Makefile                              |    3 +
 scripts/Makefile.modfinal                     |   41 +-
 scripts/empty_lineinfo.S                      |   38 +
 scripts/gen-mod-lineinfo.sh                   |   45 +
 scripts/gen_lineinfo.c                        | 2534 +++++++++++++++++
 scripts/kallsyms.c                            |   11 +
 scripts/link-vmlinux.sh                       |   88 +-
 24 files changed, 4780 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/admin-guide/kallsyms-lineinfo.rst
 create mode 100644 include/linux/mod_lineinfo.h
 create mode 100644 lib/tests/lineinfo_kunit.c
 create mode 100644 lib/tests/lineinfo_kunit.h
 create mode 100644 lib/tests/lineinfo_kunit_second.c
 create mode 100644 scripts/empty_lineinfo.S
 create mode 100755 scripts/gen-mod-lineinfo.sh
 create mode 100644 scripts/gen_lineinfo.c

-- 
2.53.0

