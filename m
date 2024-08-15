Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F83E1AC8A7
	for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743555; cv=none; b=FUFDbFNg7i8Yl0GtUVNNYmpvIAJlF6h8Vd2f89lrer9SI1YFOBvnE8iB5RY9lIInlxlwbeh+8L+raMX4kWfqQpm/OQ6kHqz2Y7Gpd83RP/i92Xw8zpRIW6dThHFrudWHQFr8Wc9N2JNWpdQQqkYY35BmX+6u4Q3YvdNWpWFhRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743555; c=relaxed/simple;
	bh=/QxSa3ECPYBoJRTg0EGbC8+fquDkIseWUM62eZtMWXA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qNAWYDwSIPmwkdTW2KQav7+6JBv48lkrvaMv4VSCZ+fWFqOSlOdnbxdgFeiI7SNvqqTrva34UTSVlSfNG26hrcuAAa3qvN2YLZh//nhdpVglDoVvGkCM4/f+/0TDiqUDIHDiYSpXpONNH/s+6bjdNUMYoIFm7Jytc+F9TsWx2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3rHDqE4l; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3rHDqE4l"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ad660add0fso15092357b3.0
        for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723743553; x=1724348353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FI5SwdhvqVZuIi7hVeuwkmGg+eXkS16ccuAJOthoTGw=;
        b=3rHDqE4lbd7SflJ1E+pWIVy4g08Jb3wIA079GD9JEPm7n/hNziBH9ObJ27iQp1oi+J
         j8Nt/kiISgut3iM+Ll/j0hfVbTHP8n4CpBE7OvPOPqjrefgx2zJan0ete/NteyvGnk6a
         vVGyq4+i0fN8DzLzMHfU7uGzYbXNDBKUXiSAn/ekqRzcyvXOCNkgsLmfp8aCOYMQ4EeB
         9hxXX3O3/kSvm+pYC7aWLeT70GFJVfyXdggfhO/17vpeaL8fn/NOp8QNVqZrJ7IQH32h
         BGTZHP0nQf0kn7iSxpFQ3FOPoOMG/ueAeMdemvA++XnikPdT1Zd2SqlQUTEZhQLR97sg
         kk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743553; x=1724348353;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FI5SwdhvqVZuIi7hVeuwkmGg+eXkS16ccuAJOthoTGw=;
        b=doSke0SHZO66Brd4hc991BAbpczOFJbztzHWtc+SP42WqiCJ4oICm3vdGAuVcZkOef
         wO7BBaVA5gRgZqE1zlL7dsvmRgNRbNnvOXpNdkNuu0jWNVkQCDUCOaBusGnPrPFhZSKo
         dMHWO2iJAtbeyPRpwD5ZkU1neHtEcT7a4z9NvhEaNrhx3Qfe1A/yMgcVOR6XDqCHlw6k
         d+TQLfEykNEtoRQ83MamCFh67/lLpqHCBxwF+gZX8E1jV07u6xydvC+xFcuXdtTsGo23
         a25ZOKYE/el9LCFtj20HZvAONTNEm2FPHPp0+l6fLgpgoM3CSfkG8UdltxKt3GhURzoe
         haAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO89+cVRHTH8tWuSaTVCcj4lklyMRaayHDVlKvxy0t/Fx3DDoQfu+4bFhF3bVhTx9nNsa43n4ekZuglG5mBZMfQFzWcWKG4JZ/84804Q==
X-Gm-Message-State: AOJu0YyBftKSV/DxS5wcpxT95Dj2QmWDfDXCwl8nBASUp65txFgzyphF
	H2yvR4lRX2t5ZcUIIyi8pCns/brGxIFFI1YTpqQUn9Euv/tlwhatL7QC2sUjJEt2KixtVQijnRn
	VXWE3lJCzli+qg/CBYIiW+tDHmw==
X-Google-Smtp-Source: AGHT+IHG9k10F+Xr0bHXhKpq1URNC0sUw6joWMjh3WP84iRPDa1q7xobX3VdQ7KeATVRbDrTvrcbseIf5bS0+Ur2UGk=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:690c:3405:b0:691:a38c:a61d with
 SMTP id 00721157ae682-6b1d7ef3527mr5337b3.3.1723743553088; Thu, 15 Aug 2024
 10:39:13 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:39:04 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7301; i=samitolvanen@google.com;
 h=from:subject; bh=/QxSa3ECPYBoJRTg0EGbC8+fquDkIseWUM62eZtMWXA=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmvj03GZGfdKGX6xZKDzgMxpatJGv4ZX3wPL7Ee
 4oD3ORL1F6JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZr49NwAKCRBMtfaEi7xW
 7rTZDACeDXgkVekPtKMcZUCTLqkKP8C87jVW7eAaTDcFg5E2jq4kcKcWndlb6h8f0WSh/7XKr6a
 Mk8yEYovqNadFCx2EARM6j+QpAHkMdITBiutyyNt4b2GM82wo7gtFHcvye0PML04wd4Jap7vmAg
 N+CNdtd+IF5hhw4W4U1TZKl3s9FxQtdpDvWOLXfrGAYibKSVTUT9Tachp7Ubzx6zQQpSJAKPE99
 bEEIE49Xuixq4XHcd8WgXccyDkHGhQevmctAcKoQApWvfMHPg11BJFfkAYsL8gpaP0BxgEbgwN+
 /sUE3MjrU2M0F4y9JIes+DI3BQskBmPR4KFEYv8ZaVpsrOwoTjrpO7uM2/sdlxDBSSS8swaqE1B
 LTTOAbFQG0R1jxzaIPRr8/h0Lvyq+VsBKfUkLuzMmDrj+nStcYCT9RHeRDCanjCmF1Xnvl2Yudi IuqN5+lO4ZH8gh/0Dc0yTr//BjPtTuEDbed3kA3CH8uwyENcvmCnV2I7dvCygPMNcnkIk=
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240815173903.4172139-21-samitolvanen@google.com>
Subject: [PATCH v2 00/19] Implement DWARF modversions
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Here's v2 of the DWARF modversions series [1]. The main motivation
remains modversions support for Rust, which is important for
distributions like Android that are eager to ship Rust kernel
modules. However, per Luis' request [2], v2 drops all Rust specific
bits from the series and instead adds the feature as an option
for the entire kernel. Matt is addressing Rust modversion_info
compatibility issues in a separate series [3], and we'll follow up
with a patch to actually allow CONFIG_MODVERSIONS with Rust once
these have been sorted out.

A short background recap: Unlike C, Rust source code doesn't have
sufficient information about the final ABI, as the compiler has
considerable freedom in adjusting structure layout for improved
performance [4], for example, which makes using a source code
parser like genksyms a non-starter. Based on Matt's suggestion and
previous feedback from maintainers, this series uses DWARF debugging
information for computing versions. DWARF is an established and
a relatively stable format, which includes all the necessary ABI
details, and adding a CONFIG_DEBUG_INFO dependency for Rust symbol
versioning seems like a reasonable trade-off.

The first 16 patches of this series add a small tool for computing
symbol versions from DWARF, called gendwarfksyms. When passed a
list of exported symbols and an object file, the tool generates
an expanded type string for each symbol, and computes symbol CRCs
similarly to genksyms. gendwarfksyms is written in C and uses libdw
to process DWARF, mainly because of the existing support for C host
tools that use elfutils (e.g., objtool). The next two patches ensure
that debugging information is present where we need it and fix a
compilation issue with x86 asm-prototypes.h. The last patch adds
gendwarfksyms as an alternative to genksyms.

A quick note about performance: On my development system, building
x86_64 defconfig with MODVERSIONS takes about 59.4s with gcc 13
(avg. of ten runs). Adding DEBUG_INFO_DWARF5 increases the build
time by ~23% to 73.3s. Switching from GENKSYMS to GENDWARFKSYMS
reduces the build time by 6% to 68.9s, which is still ~16% slower
than genksyms without debugging information. Therefore, if you
already build kernels with debugging information, gendwarfksyms
should be slightly faster. YMMV, of course.

Things would change with LTO, because we won't have full DWARF
until we have an ELF binary, which means we'd have to process
vmlinux.o. This version of gendwarfksyms is still single-threaded
as it seems we can't rely on libdw to be thread-safe. Processing
a ThinLTO x86_64 defconfig vmlinux.o on my system takes ~2m16s,
and would have to happen even on incremental builds, just like
LTO linking itself. As cross-language LTO presumably isn't wildly
popular yet, gendwarfksyms intentionally depends in !LTO in this
version.

Looking forward to hearing your thoughts!

Sami

[1] https://lore.kernel.org/lkml/20240617175818.58219-17-samitolvanen@google.com/
[2] https://lore.kernel.org/lkml/ZnIZEtkkQWEIGf9n@bombadil.infradead.org/
[3] https://lore.kernel.org/lkml/20240806212106.617164-1-mmaurer@google.com/
[4] https://lore.kernel.org/rust-for-linux/CAGSQo005hRiUZdeppCifDqG9zFDJRwahpBLE4x7-MyfJscn7tQ@mail.gmail.com/

---

Changes in v2:
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

---

Sami Tolvanen (19):
  tools: Add gendwarfksyms
  gendwarfksyms: Add symbol list handling
  gendwarfksyms: Add address matching
  gendwarfksyms: Add support for type pointers
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
  gendwarfksyms: Add support for declaration-only data structures
  gendwarfksyms: Add support for reserved structure fields
  export: Add __gendwarfksyms_ptr_ references to exported symbols
  x86/asm-prototypes: Include <asm/ptrace.h>
  kbuild: Add gendwarfksyms as an alternative to genksyms

 arch/x86/include/asm/asm-prototypes.h     |   1 +
 include/linux/export.h                    |  15 +
 kernel/module/Kconfig                     |  31 +
 scripts/Makefile                          |   3 +-
 scripts/Makefile.build                    |  34 +-
 scripts/gendwarfksyms/.gitignore          |   2 +
 scripts/gendwarfksyms/Makefile            |  12 +
 scripts/gendwarfksyms/cache.c             |  51 ++
 scripts/gendwarfksyms/crc32.c             |  69 ++
 scripts/gendwarfksyms/crc32.h             |  34 +
 scripts/gendwarfksyms/die.c               | 196 +++++
 scripts/gendwarfksyms/dwarf.c             | 973 ++++++++++++++++++++++
 scripts/gendwarfksyms/examples/declonly.c |  31 +
 scripts/gendwarfksyms/examples/reserved.c |  66 ++
 scripts/gendwarfksyms/gendwarfksyms.c     | 201 +++++
 scripts/gendwarfksyms/gendwarfksyms.h     | 275 ++++++
 scripts/gendwarfksyms/symbols.c           | 392 +++++++++
 scripts/gendwarfksyms/types.c             | 557 +++++++++++++
 18 files changed, 2936 insertions(+), 7 deletions(-)
 create mode 100644 scripts/gendwarfksyms/.gitignore
 create mode 100644 scripts/gendwarfksyms/Makefile
 create mode 100644 scripts/gendwarfksyms/cache.c
 create mode 100644 scripts/gendwarfksyms/crc32.c
 create mode 100644 scripts/gendwarfksyms/crc32.h
 create mode 100644 scripts/gendwarfksyms/die.c
 create mode 100644 scripts/gendwarfksyms/dwarf.c
 create mode 100644 scripts/gendwarfksyms/examples/declonly.c
 create mode 100644 scripts/gendwarfksyms/examples/reserved.c
 create mode 100644 scripts/gendwarfksyms/gendwarfksyms.c
 create mode 100644 scripts/gendwarfksyms/gendwarfksyms.h
 create mode 100644 scripts/gendwarfksyms/symbols.c
 create mode 100644 scripts/gendwarfksyms/types.c


base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
-- 
2.46.0.184.g6999bdac58-goog

