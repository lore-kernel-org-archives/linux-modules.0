Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F643D75BE;
	Tue,  3 Mar 2026 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562123; cv=none; b=s9GzZpmzAAo7mW6x4tCgFyAahxNgTpMCZ7hKccrZgt4iUV1CGAs3rPe3BXpIkZeyXURR01ARvirWao9gGKIw9obYi15RlhEJ5lvEe2bnD8UA83zR/DGL9hpI20ftdKBc1OIOfPffi1KjW4G4IdSnhIJCtQ4b0o0Q74yHmM1HjEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562123; c=relaxed/simple;
	bh=m2g1b7Kqu4qgBeIl+f/3P41HKyfuooaUlcGY0gUu5PU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hfe+sRcifw+D66+fvelBBOWnfVOtwLqAYIHAHbtNbrqrO8IVGboj6sZ5wWGFRYfUrCRYolXgxFJzUw7JVv3sdIDSuBpw3OL5c9sLR52KULoPLNPvPha49xejqVFbFZXHBC259jiggo9+DbYuIpBEsJgUuqdcksaHjvSTZTLjg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcaDwdiM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcaDwdiM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A6CC19425;
	Tue,  3 Mar 2026 18:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772562122;
	bh=m2g1b7Kqu4qgBeIl+f/3P41HKyfuooaUlcGY0gUu5PU=;
	h=From:To:Cc:Subject:Date:From;
	b=fcaDwdiMilHf44gBfZU7XbyVjTGCKeGbPoWWwJ7aQrHzoKnt2/FUZJdoRRSM1kunJ
	 lOiQVo1j+2d5fM42i9/QVbh1HkiXNLH1f9A12DxjSrWhKrKl2HtQ7vj+V1Z7RetN/+
	 C1DtEhE9OzArsQe5K5uvOUVcVnd+whoPmjIBG0MKw/GfY5fv9vn0N9tDNmTXOxmoRJ
	 t1muSL125rKQrNraK/QYZtqJMvx5UVaVrPiShm+QEPg1f093rnIFYDJchIRttdkILL
	 y9d+JB4HDUePHJlO6JBx4JZcV1pc++sPFzoWg7etcYWgOPT+xHUvgD/SWpphlVMO9u
	 F7DlgERb8StlA==
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Richard Weinberger <richard@nod.at>,
	Juergen Gross <jgross@suse.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
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
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 0/3] kallsyms: embed source file:line info in kernel stack traces
Date: Tue,  3 Mar 2026 13:21:00 -0500
Message-ID: <20260303182103.3523438-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds CONFIG_KALLSYMS_LINEINFO, which embeds source file:line
information directly in the kernel image so that stack traces annotate
every frame with the originating source location - no external tools, no
debug symbols at runtime, and safe to use in NMI/panic context.

Motivation
==========

The recent "slowly decommission bugzilla?" thread [1] surfaced a recurring
problem: when users encounter kernel crashes they see stack traces like
`func+0x1ec/0x240` but have no way to identify which subsystem or
maintainer to contact.  Richard Weinberger proposed building a database
mapping symbols to source files using nm/DWARF.  Linus pointed to
scripts/decode_stacktrace.sh as the existing solution.  But as the
discussion progressed, it became clear that decode_stacktrace.sh has
significant practical barriers that prevent it from being useful in the
common case.

Problems with scripts/decode_stacktrace.sh
==========================================

- Requires debug symbols: the script needs vmlinux with DWARF debug info.
  Many distros don't retain debug symbols for older or security kernels,
  and even when available, asking users to obtain matching debuginfo
  packages is a significant hurdle.

- Requires toolchain: users need addr2line and nm installed.

- Version-matching requirement: debug symbols must exactly match the
  running kernel binary.

What this series does
=====================

Patch 1: CONFIG_KALLSYMS_LINEINFO

  At build time, a host tool (scripts/gen_lineinfo) reads DWARF
  .debug_line from vmlinux, extracts address-to-file:line mappings,
  and embeds them as sorted lookup tables in .rodata.  At runtime,
  kallsyms_lookup_lineinfo() binary-searches the table and
  __sprint_symbol() appends "(file:line)" to each stack frame.
  NMI/panic-safe (no locks, no allocations), KASLR-compatible.

Patch 2: CONFIG_KALLSYMS_LINEINFO_MODULES

  Extends lineinfo to loadable modules.  Each .ko gets a .mod_lineinfo
  section embedded at build time.  The module loader picks it up at load
  time.  Same zero-allocation, NMI-safe lookup.

Patch 3: delta compression

  Block-indexed delta-encoding with ULEB128 varints, implementing
  the approach suggested by Juergen Gross in the RFC review.  Reduces
  overhead from ~44 MiB to ~11 MiB (~3.7 bytes/entry), addressing the
  primary size concern from the RFC.

Example output
==============

  [   11.206749]  dump_stack_lvl+0x5d/0x80 (lib/dump_stack.c:94)
  [   11.207403]  vpanic+0x36e/0x620 (kernel/panic.c:650)
  [   11.209324]  panic+0xc9/0xd0 (kernel/panic.c:787)
  [   11.213312]  sysrq_handle_crash+0x1a/0x20 (drivers/tty/sysrq.c:154)
  [   11.214005]  __handle_sysrq.cold+0x66/0x256 (drivers/tty/sysrq.c:611)
  [   11.214712]  write_sysrq_trigger+0x65/0x80 (drivers/tty/sysrq.c:1221)
  [   11.215424]  proc_reg_write+0x1bd/0x3c0 (fs/proc/inode.c:330)
  [   11.216061]  vfs_write+0x1c6/0xff0 (fs/read_write.c:686)
  [   11.218848]  ksys_write+0xfa/0x200 (fs/read_write.c:740)
  [   11.222394]  do_syscall_64+0xf3/0x690 (arch/x86/entry/syscall_64.c:63)

Size impact
===========

With delta compression, a defconfig+debug x86_64 build adds ~11 MiB
to the kernel image (~3.7 bytes per DWARF line entry).  This is a
fraction of the cost of shipping full DWARF debug info (hundreds of
MiB), which distros must store and serve for every kernel version.

For distros, maintaining debug symbol repositories is expensive:
storage, mirrors, and CDN bandwidth for hundreds of MiB per kernel
build add up quickly.  An ~11 MiB increase in the kernel image itself
is a modest cost that eliminates the need for users to find, download,
and version-match debuginfo packages just to make a crash report
useful.

For developers, the file:line annotations appear immediately in crash
traces - no post-processing with decode_stacktrace.sh needed.

Changes since RFC
=================

- Added module support (patch 2)
- Added delta compression (patch 3), reducing size from ~44 MiB to
  ~11 MiB, addressing the primary concern from RFC review
- Added documentation (Documentation/admin-guide/kallsyms-lineinfo.rst)
- Added MAINTAINERS entry

Link: https://lore.kernel.org/all/1786920159.1633.1772291851870.JavaMail.zimbra@nod.at/ [1]

Sasha Levin (3):
  kallsyms: embed source file:line info in kernel stack traces
  kallsyms: extend lineinfo to loadable modules
  kallsyms: delta-compress lineinfo tables for ~2.7x size reduction

 Documentation/admin-guide/index.rst           |   1 +
 .../admin-guide/kallsyms-lineinfo.rst         |  97 +++
 MAINTAINERS                                   |   8 +
 include/linux/kallsyms.h                      |  32 +-
 include/linux/mod_lineinfo.h                  | 137 ++++
 include/linux/module.h                        |  19 +
 init/Kconfig                                  |  35 +
 kernel/kallsyms.c                             | 132 ++++
 kernel/kallsyms_internal.h                    |  11 +
 kernel/module/kallsyms.c                      | 156 ++++
 kernel/module/main.c                          |   4 +
 scripts/.gitignore                            |   1 +
 scripts/Makefile                              |   4 +
 scripts/Makefile.modfinal                     |   6 +
 scripts/gen-mod-lineinfo.sh                   |  48 ++
 scripts/gen_lineinfo.c                        | 702 ++++++++++++++++++
 scripts/kallsyms.c                            |  17 +
 scripts/link-vmlinux.sh                       |  70 +-
 18 files changed, 1476 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/kallsyms-lineinfo.rst
 create mode 100644 include/linux/mod_lineinfo.h
 create mode 100755 scripts/gen-mod-lineinfo.sh
 create mode 100644 scripts/gen_lineinfo.c

-- 
2.51.0

