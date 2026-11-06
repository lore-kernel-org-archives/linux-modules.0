Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971477;
	b=OLYBtmQ5EUmVVNe5rxDXcmjDR0A0+37Io9Ncgk+aW5jb27UyFOoXuun6VBRHIorU5QAK
	 rngfTx/VlZNHO2JRj4Dw5ziJjXMAgp1wqSunZnC+kUI7h25CydMK6BO0JA99JYEvy5vAH
	 vzUaEn79G0lRWihO3WItHmq5p6Fq4IVes5xyVfellaeIrMbv4aS9kME6NHWMu9mMZc4E0
	 74I4UuLgwmmgH9EfORBo4hGrMDSSwlgTE0AefJz9aFbtP8mbl4QgbNt4VLRM35Aez6ctk
	 jjrTpSRXD1UluKyWNrs1qVTbO+czEXTXMADZJYFXPyGFXBmh9u83X0UVx994vRZjUxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971477;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=e43YrtecMjPm4fM2M1xYU97C1oeC1q0OIEyNhmRIcx8=;
	b=shtIK9Kh4W0hlMhssh2MZA7ZG2w2BV/WF/pCZTQUzj3XjtLS5Ni9xeI+NpAP9jzS+1W7
	 FB2o6njCDh8aWpFyg7Eu+ve2t+MqoaMUR9DKOeas7lJGsTLI7zqci0iDkaL6sLI4seEOw
	 c221hI3C2A8BYD1C25/Dl1akLxz9EVVexFTgOwO2OmtzrU4n4zvGQnzGWpu9G/DnJ1aBo
	 1UU6l1VUYw9V0QFc8OJXp6JmtTLN2HXEMv4+33yWuFTtU98xQpUxdXg8H0XNsOH5UcIfL
	 gYfde3Ga24O/BTSrmWmlwyPo5RuZr5dRfJZVyVg6rhGTEZoe8f/vOOFZb4W4xdWZY3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsC3wqL0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA50606A326;
	Fri,  6 Nov 2026 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsC3wqL0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7A81F0089F;
	Fri,  6 Nov 2026 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971477;
	bh=e43YrtecMjPm4fM2M1xYU97C1oeC1q0OIEyNhmRIcx8=;
	h=From:To:Cc:Subject:Date;
	b=VsC3wqL0xYA9YTVg8Bo0t8wTvf1JPszSs40UrkkMO2q69xxWxVpt/BoSVCDKwSmxu
	 csrhNJezmjjeSvquJMvW9NV6RX0nx1Y5R2sv3P4uS6VeAeSa4F5NVBn6xVicRg7gad
	 B9GnHfUJ+2UBJGNZ3mg4hZLxm7WT0trVZj12x7f3j2UtQCYfbsy/ToIXEooDulflps
	 WeBCWLLXhAWT9dmWb+nckPssPwXXrtzfmDIg+e2cOpkveijyZBmqMdwJLKSGXt5x6P
	 N7WPLQZ/Tb00Nm2tRxGu3etec0iaO4EgCKjomeV6fOzwSSgoCpO+IMfwib7wF9dSDn
	 6oZOhl0vh6W3A==
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
Subject: [PATCH v11 0/4] kallsyms: embed source file:line info in kernel stack traces
Date: Fri,  6 Nov 2026 08:24:28 -0500
Message-ID: <20261106132432.248387-1-sashal@kernel.org>
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

Changes since v10
=================

All from the sashiko.dev review of v10:

- Run the second partial link of a module without module.lds, which the
  first link has already applied.  Applying it twice left
  __start_alloc_tags/__stop_alloc_tags around an empty range, so with
  CONFIG_MEM_ALLOC_PROFILING loading sit.ko oopsed on a NULL counter,
  and it emitted the BYTE(0) stub sections of arm and arm64 twice, so no
  arm64 module loaded at all.
- gen_lineinfo: merge entries that share an address before adding
  symbol-start entries and collapsing repeated lines.  Doing both in one
  pass let a compile unit's line-0 marker displace or cut short another
  unit's row.  Stop copying a line-0 entry to a symbol start, and drop
  seq_end_between(), which could never return true.
- gen_lineinfo --module: start the section bias ranges at 1 GiB and
  leave a gap after each one.  lkdtm.ko keeps code in .rodata, which gets
  no bias, so its rows read as offsets into .text; and in ppc64's
  xt_SECMARK.ko the zero-length last row of .text, sitting on its end
  address, read as offset 0 of .exit.text.  Also recount each section's
  entries on every path through deduplicate().
- KUnit: test_cross_file_inline() failed on arm64, where the inlined
  header helper compiled to no instruction of its own; the helper now
  calls into the second object.  test_many_lines_mid_function() asserts
  that it finds an annotated address instead of passing when it finds
  none, and both function walks compare against the printed symbol name,
  which has a leading dot on PowerPC ELFv1.  Drop test_static_function(),
  a duplicate, and test_assembly_no_lineinfo(), which could not fail.
  Fix two stale comments.

Also, the Kconfig help in 1/4 now gives the same uncompressed size as
the commit message, 16MB instead of 18MB.

v10: https://lore.kernel.org/all/20261102111455.919102-1-sashal@kernel.org/

Tool use
========

LLM coding assistants were used throughout this series: for parts of the
implementation, for review passes over each version, and to build the
DWARF fixtures and checking scripts behind the testing below.

Testing
=======

v11 on v7.4-rc1:

- KUnit under QEMU, x86_64 defconfig + CONFIG_DEBUG_INFO (KVM), arm64
  defconfig and arm multi_v7_defconfig + CONFIG_THUMB2_KERNEL (TCG):
    x86_64 =y                                       31 passed, 1 skipped
    x86_64 =m                                       31 passed, 1 skipped
    x86_64 =m, CONFIG_KALLSYMS_LINEINFO_MODULES=n    8 passed, 24 skipped
    x86_64 =m, LLVM=1                               31 passed, 1 skipped
    arm64 =y                                        31 passed, 1 skipped
    arm64 =m                                        31 passed, 1 skipped
    arm =y                                          31 passed, 1 skipped
  No failures.  The skips are the module-only test in =y builds and,
  without module lineinfo, every test that needs it.
- arm64: the KUnit module, fuse, cuse, netfs, overlay and the two
  aes-neon modules load, and SysRq-l frames are annotated, module frames
  included.
- x86_64 with CONFIG_MEM_ALLOC_PROFILING: sit.ko and kvm.ko load and
  their tags show up in /proc/allocinfo.
- Every module of x86_64 (GCC and Clang), i386, arm64, arm
  (multi_v7_defconfig with ARM_MODULE_PLTS), riscv64, ppc64 and ppc32
  builds, 3,621 in all, has the sections, sizes, flags and
  __start_/__stop_ symbols that v7.4-rc1's single module.lds link gives
  it, except where it cannot matter: with GNU ld on x86 .note.GNU-stack
  comes out as SHT_NOTE, and on arm .ARM.attributes is merged with the
  table object's and each unwind index gains an EXIDX_CANTUNWIND entry
  for the address just past its last function.
- For every build, the table generated from the final vmlinux is the one
  linked into it, including ppc64, which takes the regeneration pass.
- Run on the vmlinux and every module of those builds, gen_lineinfo emits
  the same tables as v10's except for the fixes above: on ppc64,
  xt_SECMARK.ko and lkdtm.ko lose the misplaced rows, and the line-0
  entries v10 copied onto symbol starts are gone (3 on x86_64, 9 on
  i386, 1 with Clang, 681 on ppc64), which changes no lookup.  The v9
  results below therefore still apply to the generator.
- Each of the four patches builds standalone with no warnings.  A rebuild
  with nothing changed relinks nothing, and touching
  scripts/gen_lineinfo.c relinks vmlinux and every module.
- x86_64 defconfig built with -ffunction-sections, where sequences of one
  compile unit sit back to back: KUnit =y 31 passed, 1 skipped, and the
  vmlinux table is v10's less one line-0 entry.

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
 lib/tests/lineinfo_kunit.c                    | 1087 +++++++
 lib/tests/lineinfo_kunit.h                    |   22 +
 lib/tests/lineinfo_kunit_second.c             |   21 +
 scripts/.gitignore                            |    1 +
 scripts/Makefile                              |    3 +
 scripts/Makefile.modfinal                     |   44 +-
 scripts/Makefile.vmlinux                      |    4 +
 scripts/empty_lineinfo.S                      |   38 +
 scripts/gen-mod-lineinfo.sh                   |   45 +
 scripts/gen_lineinfo.c                        | 2532 +++++++++++++++++
 scripts/kallsyms.c                            |   11 +
 scripts/link-vmlinux.sh                       |   91 +-
 25 files changed, 4772 insertions(+), 12 deletions(-)
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

