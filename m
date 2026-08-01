Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AAC3806CA;
	Sat,  1 Aug 2026 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785594747; cv=none; b=L7xpuE8JkPUN7mNhWrcyr7IC75waY7faonLpwmyTvI1/u5vdOUxtTY05mcie/k0vIrhSNqP8KTrnYOu6fTqDh6iR9BCgqvd36n7430IToZds1oC0kThtRdHKdtDCLL5JxnigFlEC8UwzYnVNk3gcsWLXQ6rOTIny6YslZmXLFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785594747; c=relaxed/simple;
	bh=rfM03tKDOmetMwB2FOQ2Q+Q7TSXNdbScL3TGgGVzrlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YkDC6Gaw90EmUb5d+QeOIEs2qXPH8gNIIK5qI4VlrL9SdDMNxppBXA8p+qi/pW9pUPODk0rLe4NRb1YmbGU2QB2UgqELZlIWEb/8WS8mB74dFqoBZmmlP0pxRtMm3RCpKQy6SDIgC8Yyfl2gnY+JQQEALMJPZMvUOcA8C7kszNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtaMvwnS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtaMvwnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50BD1F00AC4;
	Sat,  1 Aug 2026 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785594744;
	bh=En1PpSnljWrHrVUmcev/In3WM1VOJthrcFWC6cndCKE=;
	h=From:To:Cc:Subject:Date;
	b=FtaMvwnSCsNhDG/4S2wE9CWdqzDuVDyDgrSegnj/kJIZxkVA3pMEMwb+PfKfC0QB/
	 5vuYDlaZ5wXAzQvtKzogY2RnImYFNnkDUmFlopDuMlu04Nxb8/uCP2zexcyjYAKlHV
	 bHQowFLhvXmeEh6FAgKnXMfoREAb455/Fxorbwb+laqr9u00/Fx7B+33W7C++B1lGl
	 QblBkLoZfTKDCzBH2BW5Ir64wYyoyU2PNChgVSkakLKt+XBzw9AkNnBmFCvcc7ul1Q
	 eEBMT1A1NqjUWvYLenwC9CyfF7yVpiv9P0qtpdnbTdq80OT/g//ZYzK9D9jUeM19vU
	 UH1MQhRTL9Cxw==
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
Subject: [PATCH v8 0/4] kallsyms: embed source file:line info in kernel stack traces
Date: Sat,  1 Aug 2026 10:32:14 -0400
Message-ID: <20260801143219.3975824-1-sashal@kernel.org>
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
  default_idle_call+0x2e/0x100 (kernel/sched/idle.c:122)
  do_idle+0x20b/0x2b0 (kernel/sched/idle.c:199)
  cpu_startup_entry+0x24/0x30 (kernel/sched/idle.c:453)
  rest_init+0xbc/0xc0 (init/main.c:717)
  common_startup_64+0x13e/0x158 (arch/x86/kernel/head_64.S:418)

Patch 2 extends this to loadable modules, patch 3 delta-compresses the
tables, patch 4 adds KUnit coverage.

Changes since v7
================

Two bugs turned up while working through Petr's review:

- Module lineinfo blobs were malformed.  emit_section_table() emitted the
  .Lhdr label before its .balign 4, so the kernel read each sub-table
  header 1-3 bytes early.  5 of the 7 modules with two covered text
  sections were affected here, kvm-intel.ko among them, which silently
  lost .exit.text annotation.  Fixed in 2/4, with IS_ALIGNED() rejects on
  the kernel side so a bad blob degrades instead of faulting in NMI
  context.

- v7's symbol-boundary check over-corrected, dropping annotation for 5017
  functions -- 1542 .cold fragments, all __probestub_*, the __ia32_sys_*
  compat wrappers -- which v6 printed correctly.  gen_lineinfo now keeps
  an entry at every symbol start and synthesizes one where the compiler
  emitted none, gated so that __pfx_* padding stubs and __SCT__*
  trampolines stay unannotated.  Costs +0.12% entries.

From Petr Pavlu's review of 1/4:

- Size figures were measured on an unstripped vmlinux.  Redone with
  x86_64_defconfig + CONFIG_DEBUG_INFO, recipe stated inline:
  51.1 -> 69.1 MiB before the compression in 3/4, 51.1 -> 59.1 MiB with it.
- Paths are made relative to $objtree/$srctree/$srcroot (read with
  getenv(), so no Makefile change) rather than by scanning for well-known
  top-level directory names; kernel_dirs[] stays as a fallback.
- Private hash map replaced with scripts/include/hashtable.h.
- xalloc.h for every allocation; the unchecked strdup() is gone.
- ELF_C_READ_MMAP, and ELF_C_READ_MMAP_PRIVATE for modules, which lets
  module mode drop O_RDWR.
- Error handling unified on warn()/error(); main() no longer unwinds.
- Statistics output moved behind -v / KBUILD_VERBOSE.
- libelf named alongside libdw everywhere; Arch package corrected.
- raw_offset/raw_min narrowed to unsigned long.
- Dropped the unused -lz from HOSTLDLIBS_gen_lineinfo.
- ARRAY_SIZE() instead of open-coded sizeof/sizeof.

Also:

- 2/4 no longer documents the delta compression that 3/4 introduces.
- scripts/kallsyms.c matches the lineinfo symbols by prefix; two of them
  had been leaking into /proc/kallsyms.
- alloc_sym_buf() asserts on allocation failure, and a new KUnit case
  pins the symbol-boundary contract the generator relies on.

Testing
=======

x86_64_defconfig + CONFIG_DEBUG_INFO, booted under QEMU/KVM:

- KUnit, CONFIG_LINEINFO_KUNIT_TEST=y builtin:
  31 passed, 0 failed, 1 skipped
- KUnit, =m with CONFIG_KALLSYMS_LINEINFO_MODULES=y:
  30 passed, 0 failed, 2 skipped
- KUnit, =m with CONFIG_KALLSYMS_LINEINFO_MODULES=n:
  12 passed, 0 failed, 20 skipped (skips rather than fails, as intended)
- SysRq-l backtraces annotated, including .S frames and header inlines
- Module frames annotated, e.g.:
    test_dump_stack_no_crash+0xd/0xe80 [lineinfo_kunit]
      (lib/tests/lineinfo_kunit.c:681)
- Every .ko sub-table header 4-byte aligned (8 modules with 2 descriptors);
  was 5 of 7 misaligned before
- Coverage cross-checked against addr2line
- Each of the four patches builds standalone (vmlinux + modules), and 1/4
  alone boots with working annotations
- ARCH=i386 W=2 build of kernel/kallsyms.o and kernel/module/kallsyms.o is
  clean, covering the 32-bit paths touched here

Sasha Levin (4):
  kallsyms: embed source file:line info in kernel stack traces
  kallsyms: extend lineinfo to loadable modules
  kallsyms: delta-compress lineinfo tables for ~2.7x size reduction
  kallsyms: add KUnit tests for lineinfo feature

 Documentation/admin-guide/index.rst           |    1 +
 .../admin-guide/kallsyms-lineinfo.rst         |   97 +
 MAINTAINERS                                   |    9 +
 include/linux/kallsyms.h                      |   18 +-
 include/linux/mod_lineinfo.h                  |  312 +++
 include/linux/module.h                        |   40 +
 init/Kconfig                                  |   35 +
 kernel/kallsyms.c                             |  103 +-
 kernel/kallsyms_internal.h                    |   11 +
 kernel/module/kallsyms.c                      |  191 ++
 kernel/module/main.c                          |   26 +
 lib/Kconfig.debug                             |   10 +
 lib/tests/Makefile                            |    3 +
 lib/tests/lineinfo_kunit.c                    | 1040 +++++++++
 scripts/.gitignore                            |    1 +
 scripts/Makefile                              |    3 +
 scripts/Makefile.modfinal                     |    6 +
 scripts/empty_lineinfo.S                      |   38 +
 scripts/gen-mod-lineinfo.sh                   |   50 +
 scripts/gen_lineinfo.c                        | 1930 +++++++++++++++++
 scripts/kallsyms.c                            |   11 +
 scripts/link-vmlinux.sh                       |   43 +-
 22 files changed, 3967 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/admin-guide/kallsyms-lineinfo.rst
 create mode 100644 include/linux/mod_lineinfo.h
 create mode 100644 lib/tests/lineinfo_kunit.c
 create mode 100644 scripts/empty_lineinfo.S
 create mode 100644 scripts/gen-mod-lineinfo.sh
 create mode 100644 scripts/gen_lineinfo.c

-- 
2.53.0

