Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DC11A3A80
	for <linux-modules@vger.kernel.org>; Thu, 19 Dec 2024 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734642475; cv=none; b=CutLCBGM5o+2bsmw4g9q1/DxZwx8lKAWPVgsvknaIvEc4MUGQjh1hh2nZfnxjNOBoW2QWEqRAVW7aCYzBBFBXu1fEBZ0VdgjI/VDc4BP3el8Puu1NvU0e2s6j+UCUwfcgIeLSK+1G+BmIJ3eAc+bxrIXZXxYMHbuMDGNGT0tyvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734642475; c=relaxed/simple;
	bh=FqWzTIGkyWP8VHIn+p3vfHgrJ2ZAKoWZrosnliAcLUk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RGphUlsUjyruWDuBWA01tm4edhvbW8XtJ9cu01UV2hpucJFI97qXmNxyNkAYe615HlSvC7YsrkipJLuPdRtHu31JxxpB947Jp03XgUNufmwKelLd9A8jElT0/b8DuOIQ3Hcxs6WVMxJZ30ysiuYMOZagmedlqcXgno3iKFs7mOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2GA+PdbU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2GA+PdbU"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-726047a4bd1so1775812b3a.3
        for <linux-modules@vger.kernel.org>; Thu, 19 Dec 2024 13:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734642471; x=1735247271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GbAq7eEKgVbeFshRXlQ85xGd2gB6jTTlmwHUZgVi5kM=;
        b=2GA+PdbUneqRNHqKD6Pnq0iwwgoKjFOMDyvQ5rVygixKay5lP01ASPW/X4V9V+2nxr
         iDwZ4pKEotWtlOHzHtnRdJuWXVES4S4NsrLC5FJhCagA4wfUlW0D8OtF0bEXC27G2Wy3
         PScPLcoPC2Aa+sg9o59fDvMhxKEmZa+09DZSxoKdoYnpYVRzibCNAQjyCj5YOZoURi9q
         lNdiffVBRK+QzyZ6cf0GeBM6pIBxCEEXlhRpljk1XlASEAAhKDTABA9XHwpZUEqc9x2g
         wyGB1P5G4XUzyYerECAYl+hU1xeoGiI/QHthA7CkG+ASwni4i8mUT+FD0z96R5gPp/xk
         fLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734642471; x=1735247271;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbAq7eEKgVbeFshRXlQ85xGd2gB6jTTlmwHUZgVi5kM=;
        b=LMumIXQ03vi/cJHWliF2XZxaENmogKzv80t8TQdtIy8mSjTw5MALUrkcsRBDbyny3v
         y0gpVC06vpK328F1EiYUSM0xC+0Ct/fdJt1zAkMBzK0r2iOsfrU3wT9BAv/HqTR1+8PK
         O4adZ7RdBL6+DO58njhmI2nBm5BzjiIiBWEAvXEwM5g7xfXv0L0okIrksm9YX261nOjG
         pXxQcifxIJTSGo0o9uSpXeVQtJSUvR2LiVMHopMgwkmLQzWvflzebttmPgN4PU+Fvs2d
         EjyLT/GVuYNlprU4/yNIgZhon/vY+RBha112crC6U3C3NJdpMo+eznGuJFFqsJsetZ1V
         AdKA==
X-Forwarded-Encrypted: i=1; AJvYcCUyusUN1kKDEaTJqWMEvFNFkWOrSPe7+cxSVVZcM2N+CbX07d5rXBXt/27HqA54PmQ8W0D+z481amOi8jbX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Z/yIDKLFi6KXa00zIJf4gLXw/Xm14kPs6NBWtb89GNiB4TUZ
	wVe2EWeqST8KanQX7ZXeFYzThmp77/rG9d03rcLZ35cKVPQ77C/VG2ojLehmIMFsctmsvp02Z3q
	cS6NjAvLdyfCE+c9m9KHOtdVsgw==
X-Google-Smtp-Source: AGHT+IGNlj96u5yACTdWOruDB2pQNG0ucvVfuW5d6S4/le6qPQRMsQKW4pfVbAr6BFqKz+18ZRAw90EZS8mN9RFKnxE=
X-Received: from pfar2.prod.google.com ([2002:a05:6a00:a902:b0:726:d6e6:a38])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1596:b0:1db:e0d7:675c with SMTP id adf61e73a8af0-1e5e045a0b9mr857903637.13.1734642471304;
 Thu, 19 Dec 2024 13:07:51 -0800 (PST)
Date: Thu, 19 Dec 2024 21:07:37 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=11447; i=samitolvanen@google.com;
 h=from:subject; bh=FqWzTIGkyWP8VHIn+p3vfHgrJ2ZAKoWZrosnliAcLUk=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOkp3RKrRPg+dgtu7M3JCUl8sFlpU93JSsX8j/mpDzo5P
 Zd0q9Z3lLIwiHEwyIopsrR8Xb1193en1FefiyRg5rAygQxh4OIUgIlE/WZkeM8WeTn4513f/QHr
 T3TVbvknKskbJ9riynYlKHKz9vtrJowMh0wDnkUxaba6zYm16tZf+rber8k4c3aPdv/UK656rD6 sAA==
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241219210736.2990838-20-samitolvanen@google.com>
Subject: [PATCH v7 00/18] Implement DWARF modversions
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Here's v7 of the DWARF modversions series. The main motivation is
modversions support for Rust, which is important for distributions
like Android that are about to ship Rust kernel modules. Per Luis'
request [1], v2 dropped the Rust specific bits from the series and
instead added the feature as an option for the entire kernel to
make it easier to evaluate the benefits of this approach, and to
get better test coverage. Matt is addressing Rust modversion_info
compatibility issues in a separate patch set [2] that depends on
this series, and actually allows modversions to be enabled with
Rust.

Short background: Unlike C, Rust source code doesn't have sufficient
information about the final ABI, as the compiler has considerable
freedom in adjusting structure layout, for example, which makes
using a source code parser like genksyms a non-starter. Based on
earlier feedback, this series uses DWARF debugging information for
computing versions. DWARF is an established and a relatively stable
format, which includes all the necessary ABI details, and adding a
CONFIG_DEBUG_INFO dependency for Rust symbol versioning seems like a
reasonable trade-off as most distributions already enable it.

The first 15 patches add gendwarfksyms, a tool for computing symbol
versions from DWARF. When passed a list of exported symbols and
object files, the tool generates an expanded type string for each
symbol and computes symbol versions. gendwarfksyms is written in C,
uses libdw to process DWARF, and zlib for CRC32. Patch 16 ensures
that debugging information is present where we need it, patch 17
adds gendwarfksyms as an alternative to genksyms, and the last patch
adds documentation.

v7 is based on 6.13-rc3, and for your convenience, the series is
also available here:

https://github.com/samitolvanen/linux/commits/gendwarfksyms-v7

If you also want to test the series with actual Rust modules, this
branch adds Matt's latest modversion_info series:

https://github.com/samitolvanen/linux/commits/rustmodversions-v7

Sami


[1] https://lore.kernel.org/lkml/ZnIZEtkkQWEIGf9n@bombadil.infradead.org/
[2] https://lore.kernel.org/linux-modules/20241123-extended-modversions-v10-0-0fa754ffdee3@google.com/

---

v7:
- Added a Kconfig description to actually allow build testing each
  patch. (Patch 1)

- Added a MAINTAINERS entry for gendwarfksyms. (Patch 1)

- Cleaned up includes and fixed a build issue with asprintf not
  always being present without _GNU_SOURCE. (Patches 1, 11, and 13)

- Adjusted hash table sizes for lower overhead as we're not right
  now concerned with processing vmlinux.o, and thus need to deal
  with a smaller number of symbols. (Patches 1, 4, 9, 11, and 13)

- Added error handling for gelf_getsymshndx failures. (Patch 2)

- Renamed the is_declaration function to is_kabi_definition for
  clarity and reversed the logic per Petr's suggestion. (Patch 9)

- Dropped the redundant default Kconfig tag. (Patch 17)

- Fixed a documentation typo. (Patch 18)

v6: https://lore.kernel.org/lkml/20241121204220.2378181-20-samitolvanen@google.com/
- Dropped pointer expansion limits as this affects version
  stability when exported symbols are removed. (Patch 9)

- Changed local type definitions (in .c files) that are opaque
  to external users to be treated as declarations even if a
  definition is available. (Patch 9)

- Switched to zlib's CRC32 implementation per Masahiro's
  suggestion. (Patch 12)

- Renamed struct_declonly kABI rule to simply declonly, as it
  applies also to unions and enums, added a new rule for
  overriding enumerator values, and refactored the examples.
  (Patch 13)

- Added --stable support for renamed structure members and
  also added examples. (Patch 14)

- Rebased on linux-kbuild/for-next for Masahiro's symtypes
  build rule clean-ups. (Patch 17)

- Updated the documentation reflect --stable changes. (Patch 18)

v5: https://lore.kernel.org/lkml/20241030170106.1501763-21-samitolvanen@google.com/
- Rebased on v6.12-rc5.

- Fixed an issue with limiting structure expansion, and applied
  Petr's clean-up. (Patch 10)

- Dropped an unnecessary return statement in error path. (Patch
  12)

- Addressed several other smaller issues Petr brought up. (Patches
  13, 14, and 15)

- Added a KBUILD_GENDWARFKSYMS_STABLE flag to enable --stable for
  the entire kernel build. (Patch 18)

- Updated documentation to include KBUILD flags. (Patch 19)

- Picked up Reviewed-by tags from v4.

v4: https://lore.kernel.org/lkml/20241008183823.36676-21-samitolvanen@google.com/
- Rebased on v6.12-rc2, which now includes all the prerequisites.

- Dropped unnecessary name_only parameter for symbols.c::for_each
  and cleaned up error handling. (Patch 3)

- Fixed anonymous scope handling to ensure unnamed DIEs don't get
  names. (Patch 4)

- Added non-variant children to variant_type output, and included
  DW_AT_discr_value attributes for variants. (Patch 9)

- Added another symbol pointer test case. (Patch 16)

- Picked up (Acked|Reviewed)-by tags from v3.

v3: https://lore.kernel.org/lkml/20240923181846.549877-22-samitolvanen@google.com/
- Updated SPX license headers.

- Squashed the first two patches in v2 and tried to reduce churn as
  much as reasonable.

- Dropped patch 18 from v2 ("x86/asm-prototypes: Include
  <asm/ptrace.h>") as it's addressed by a separate patch.

- Changed the error handling code to immediately terminate instead
  of propagating the errors back to main, which cleaned up the code
  quite a bit.

- Switched to the list and hashtable implementations in scripts and
  dropped the remaining tools/include dependencies. Added a couple
  missing list macros. (patch 1)

- Moved the genksyms CRC32 implementation to scripts/include and
  dropped the duplicate code. (patches 2 and 14)

- Switched from ad-hoc command line parsing to getopt_long (patch 3).

- Added structure member and function parameter names to the DIE
  output to match genksyms behavior, and tweaked the symtypes format
  to be more parser-friendly in general based on Petr's suggestions.

- Replaced the declaration-only struct annotations with more generic
  kABI stability rules that allow source code annotations to be used
  where #ifndef __GENKSYMS__ was previously used.  Added support for
  rules that can be used to exclude enumerators from versioning.
  (patch 16)

- Per Miroslav's suggestion, added an option to hide structure
  members from versioning when they're added to existing alignment
  holes, for example. (patch 16)

- Per Greg's request, added documentation and example macros for the
  --stable features, and a couple of test cases. (patches 15, 16, and
  20)

- Fixed making symtypes files, which need to depend on .o files with
  gendwarfksyms. (patch 19)

- Addressed several other smaller issues that Petr and Masahiro
  kindly pointed out during the v2 review.

v2: https://lore.kernel.org/lkml/20240815173903.4172139-21-samitolvanen@google.com/
- Per Luis' request, dropped Rust-specific patches and added
  gendwarfksyms as an alternative to genksyms for the entire
  kernel.

- Added support for missing DWARF features needed to handle
  also non-Rust code.

- Changed symbol address matching to use the symbol table
  information instead of relying on addresses in DWARF.

- Added __gendwarfksyms_ptr patches to ensure the compiler emits
  the necessary type information in DWARF even for symbols that
  are defined in other TUs.

- Refactored debugging output and moved the more verbose output
  behind --dump* flags.

- Added a --symtypes flag for generating a genksyms-style
  symtypes output based on Petr's feedback, and refactored
  symbol version calculations to be based on symtypes instead
  of raw --dump-dies output.

- Based on feedback from Greg and Petr, added --stable flag and
  support for reserved data structure fields and declaration-onl
  structures. Also added examples for using these features.

- Added a GENDWARFKSYMS option and hooked up kbuild support
  for both C and assembly code. Note that with gendwarfksyms,
  we have to actually build a temporary .o file for calculating
  assembly modversions.

v1: https://lore.kernel.org/lkml/20240617175818.58219-17-samitolvanen@google.com/

---

Sami Tolvanen (18):
  tools: Add gendwarfksyms
  gendwarfksyms: Add address matching
  gendwarfksyms: Expand base_type
  gendwarfksyms: Add a cache for processed DIEs
  gendwarfksyms: Expand type modifiers and typedefs
  gendwarfksyms: Expand subroutine_type
  gendwarfksyms: Expand array_type
  gendwarfksyms: Expand structure types
  gendwarfksyms: Limit structure expansion
  gendwarfksyms: Add die_map debugging
  gendwarfksyms: Add symtypes output
  gendwarfksyms: Add symbol versioning
  gendwarfksyms: Add support for kABI rules
  gendwarfksyms: Add support for reserved and ignored fields
  gendwarfksyms: Add support for symbol type pointers
  export: Add __gendwarfksyms_ptr_ references to exported symbols
  kbuild: Add gendwarfksyms as an alternative to genksyms
  Documentation/kbuild: Add DWARF module versioning

 Documentation/kbuild/gendwarfksyms.rst     |  308 ++++++
 Documentation/kbuild/index.rst             |    1 +
 MAINTAINERS                                |    7 +
 include/linux/export.h                     |   15 +
 kernel/module/Kconfig                      |   30 +
 scripts/Makefile                           |    3 +-
 scripts/Makefile.build                     |   35 +-
 scripts/gendwarfksyms/.gitignore           |    2 +
 scripts/gendwarfksyms/Makefile             |   12 +
 scripts/gendwarfksyms/cache.c              |   51 +
 scripts/gendwarfksyms/die.c                |  166 +++
 scripts/gendwarfksyms/dwarf.c              | 1159 ++++++++++++++++++++
 scripts/gendwarfksyms/examples/kabi.h      |  157 +++
 scripts/gendwarfksyms/examples/kabi_ex.c   |   30 +
 scripts/gendwarfksyms/examples/kabi_ex.h   |  263 +++++
 scripts/gendwarfksyms/examples/symbolptr.c |   33 +
 scripts/gendwarfksyms/gendwarfksyms.c      |  185 ++++
 scripts/gendwarfksyms/gendwarfksyms.h      |  296 +++++
 scripts/gendwarfksyms/kabi.c               |  336 ++++++
 scripts/gendwarfksyms/symbols.c            |  341 ++++++
 scripts/gendwarfksyms/types.c              |  481 ++++++++
 21 files changed, 3904 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/kbuild/gendwarfksyms.rst
 create mode 100644 scripts/gendwarfksyms/.gitignore
 create mode 100644 scripts/gendwarfksyms/Makefile
 create mode 100644 scripts/gendwarfksyms/cache.c
 create mode 100644 scripts/gendwarfksyms/die.c
 create mode 100644 scripts/gendwarfksyms/dwarf.c
 create mode 100644 scripts/gendwarfksyms/examples/kabi.h
 create mode 100644 scripts/gendwarfksyms/examples/kabi_ex.c
 create mode 100644 scripts/gendwarfksyms/examples/kabi_ex.h
 create mode 100644 scripts/gendwarfksyms/examples/symbolptr.c
 create mode 100644 scripts/gendwarfksyms/gendwarfksyms.c
 create mode 100644 scripts/gendwarfksyms/gendwarfksyms.h
 create mode 100644 scripts/gendwarfksyms/kabi.c
 create mode 100644 scripts/gendwarfksyms/symbols.c
 create mode 100644 scripts/gendwarfksyms/types.c


base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
-- 
2.47.1.613.gc27f4b7a9f-goog

