Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A02BCF5
	for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650698; cv=none; b=Q3BWFjtdxY3s/CetUaMjBT+5dBuB94AfY3WRbi/5sMftcd5FNSXVmFyUdzk63pwSKfLzDyGRhuxZvtJ5d+Gg4I/pv4fKQmzRR8eOfq7DU9D9maLjBtLQoQtFDNvyHfs8Cjui0oOt7Ey3nHx78Vp+E4QCqsOCuA+pEKq08SWkezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650698; c=relaxed/simple;
	bh=82JUIse9zQBqpwX/zUyPYEXM2XB5I0eN+zss0PkTEyk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AflRnlFutGhsKV3aALPcZkfGh+1yNimIsei46LkbIP4L4PMVAGgRQ95ZCHOgEYMunmTUpVcrFuomNXXMG7U+eImFJyzgjuWajlhcfOCrOPsn/VDpaWRIyBCm+g3lajwU5Itwr0SrGD1tqv2GqmzhfgK72KsFn3TltroFfCP+SDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=14vc8O6t; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="14vc8O6t"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e59dc7df64so6647717b3.1
        for <linux-modules@vger.kernel.org>; Tue, 22 Oct 2024 19:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729650696; x=1730255496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8QB3sn2ph0wk8gmlLC2XAoiq11zlmhm3bAIs0FN+PSM=;
        b=14vc8O6tblgfoW3yuwfAHcAOVIGr2DjXC6zU8uZsnMmI49f7wTM8f0GnyK5JoEdXVm
         QGvN5cAF+PPvYhWeSMH8t+iGibJUWVl8mMQPqm0QzfLfiTz8wxvgSSZAfWt0hrOpzj4z
         BYDn2sXUajoAbGCl09AadTI5KKIizpO43FE+Txq+urx9m57xFZ0UfIOTPmbIZG51TOCZ
         mT1uYXibJyHytK284Q2/ZN1Le5QeXeJVIyIJBc2NxD6jefYac7Yktxddz/PdTCHFwwiO
         lzuhNggOePwiFa63NKfL4L/uImrkHvRUo1fnkQIAh5vrFQ53T+DW/9dm6SIOINhOmg2r
         qqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729650696; x=1730255496;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8QB3sn2ph0wk8gmlLC2XAoiq11zlmhm3bAIs0FN+PSM=;
        b=qMQL/6kB/+0t5p1yjOA6/+rHulBuoO8WQcb0kt5DHB5IarZE+i5qRIbplZppdkLuCE
         nAbx2hAEe3H3OOpIpaYlmSSs3a/eF9eScoBED7kLFsIr5ueSxlnBske5/7dXMDDqiNn/
         nuUnseS/p1E13mY9dpfpzUuuVsQjVWeeeRqApEAg5di/sxcclr0muM8/n4TEIoKTyCnn
         8d58pPSnflv4/YCu2I8ScCkAGVmE6RT75b4lequcP/gvT3deU6/9psAx1ba1t49AzhcP
         kWp2+Z6uiPP3VIKsijwjMGVI/hQLBSrW+saQwEGEH9HBM8ZknNYH5NVPhlr9xWTxixaW
         J8hw==
X-Forwarded-Encrypted: i=1; AJvYcCWn6Dl9TLXkJ6A6BhlXU1msBYVOYn6daqJzKR2bbYgVj+5O0bUpd9b1o8kmpaY/vjyc+5RleMWegx09Pe2y@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8NM2gR4nHrsRpb4kjjS4IrE5ezWe9fVRaWvIr4QD8sIXjH7VR
	xFWneKGT4mQZwLHDdR/HtKDsJtQClU3GR6CLywenh5Rv6VQJUN4+VCCInZWK7TWg7DOnS056MDP
	U1EH2MA==
X-Google-Smtp-Source: AGHT+IF/4mjC7yKeMojF9mB/xXv4SyIdn4tSxc9sKi5SPQKKOv+sYXrbmS0bQkAu32wAP1awWMPzSOWeYsKl
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:6303:b0:6e2:a355:7b5c with SMTP
 id 00721157ae682-6e7d4a29390mr1604517b3.5.1729650695589; Tue, 22 Oct 2024
 19:31:35 -0700 (PDT)
Date: Wed, 23 Oct 2024 02:31:27 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP9fGGcC/03O0YrDIBAF0F8JPq9BR01sWEr/Y+nDJI6pUGNX0
 1Ao/fe17T6Uebpw53DvrFAOVNjQ3FmmLZSQlhr6r4ZNJ1xm4sHVzECAlgKA022lxZHjMbmN8rN
 fOPaj1s6P3nvJ6uslkw+3F/tzrNnnFPl6yoQfmDSg5A5Mq6zRoASXPEa8ZsqHOaX5TO2U4r+W6
 fdat61vkkUqBV/bhub7rQkrrbKgWtV1fcdB8oIxrOm84ULLh7h/kiMW4jXUxtAA7MzkbU/OYOd Qm04LpUl7S+M0kcB6IMmx4+PxB5SVWlkxAQAA
X-Change-Id: 20241022-extended-modversions-a7b44dfbfff1
X-Mailer: b4 0.15-dev
Message-ID: <20241023-extended-modversions-v7-0-339787b43373@google.com>
Subject: [PATCH v7 0/3] Extended MODVERSIONS Support
From: Matthew Maurer <mmaurer@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

This patch series is intended for use alongside the Implement DWARF
modversions series [1] to enable RUST and MODVERSIONS at the same
time.

Elsewhere, we've seen a desire for long symbol name support for LTO
symbol names [2], and the previous series came up [3] as a possible
solution rather than hashing, which some have objected [4] to.

This series adds a MODVERSIONS format which uses a section per column.
This avoids userspace tools breaking if we need to make a similar change
to the format in the future - we would do so by adding a new section,
rather than editing the struct definition. In the new format, the name
section is formatted as a concatenated sequence of NUL-terminated
strings, which allows for arbitrary length names.

Emitting the extended format is guarded by CONFIG_EXTENDED_MODVERSIONS,
but the kernel always knows how to validate both the original and
extended formats.

Selecting RUST and MODVERSIONS is now possible if GENDWARFKSYMS is
selected, and will implicitly select EXTENDED_MODVERSIONS.

This series depends upon the module verification refactor patches [5]
that were split off of v5, and DWARF-based versions [1].

linuxppc-dev is requested to look at the ppc-specific munging,
as Luis would like some eyes on there [6].

[1] https://lore.kernel.org/lkml/20241008183823.36676-21-samitolvanen@google.com/
[2] https://lore.kernel.org/lkml/20240605032120.3179157-1-song@kernel.org/
[3] https://lore.kernel.org/lkml/ZoxbEEsK40ASi1cY@bombadil.infradead.org/
[4] https://lore.kernel.org/lkml/0b2697fd-7ab4-469f-83a6-ec9ebc701ba0@suse.com/
[5] https://lore.kernel.org/linux-modules/20241015231651.3851138-1-mmaurer@google.com/T/#t
[6] https://lore.kernel.org/lkml/ZxahDv5ZKdM__0sZ@bombadil.infradead.org/

Changes in v7:
- Fix modpost to detect EXTENDED_MODVERSIONS based on a flag
- Drop patches to fix export_report.pl
- Switch from conditional compilation in .mod.c to conditional emission
  in modpost
- Factored extended modversion emission into its own function
- Allow RUST + MODVERSIONS if GENDWARFKSYMS is enabled by selecting
  EXTENDED_MODVERSIONS

v6: https://lore.kernel.org/lkml/20241015231925.3854230-1-mmaurer@google.com/
- Splits verification refactor Luis requested out to a separate change
- Clarifies commits around export_report.pl repairs
- Add CONFIG_EXTENDED_MODVERSIONS to control whether extended
  information is included in the module, per Luis's request.

v5: https://lore.kernel.org/all/20240925233854.90072-1-mmaurer@google.com/
- Addresses Sami's comments from v3 that I missed in v4 (missing early
  return, extra parens)

v4: https://lore.kernel.org/asahi/20240924212024.540574-1-mmaurer@google.com/
- Fix incorrect dot munging in PPC

v3: https://lore.kernel.org/lkml/87le0w2hop.fsf@mail.lhotse/T/
- Split up the module verification refactor into smaller patches, per
  Greg K-H's suggestion.

v2: https://lore.kernel.org/all/20231118025748.2778044-1-mmaurer@google.com/
- Add loading/verification refactor before modifying, per Luis's request

v1: https://lore.kernel.org/rust-for-linux/20231115185858.2110875-1-mmaurer@google.com/

Matthew Maurer (5):
  export_report: Rehabilitate script
  modules: Support extended MODVERSIONS info
  export_report: Tolerate additional `.mod.c` content
  modpost: Produce extended MODVERSIONS information
  export_report: Use new version info format

 arch/powerpc/kernel/module_64.c | 23 ++++++++-
 kernel/module/Kconfig           |  8 +++
 kernel/module/internal.h        | 11 ++++
 kernel/module/main.c            | 92 ++++++++++++++++++++++++++++++---
 kernel/module/version.c         | 45 ++++++++++++++++
 scripts/export_report.pl        | 17 +++---
 scripts/mod/modpost.c           | 41 +++++++++++++++
 7 files changed, 220 insertions(+), 17 deletions(-)

--
2.47.0.rc1.288.g06298d1525-goog

---
Matthew Maurer (2):
      modules: Support extended MODVERSIONS info
      modpost: Produce extended MODVERSIONS information

Sami Tolvanen (1):
      rust: Use gendwarfksyms + extended modversions for CONFIG_MODVERSIONS

 arch/powerpc/kernel/module_64.c | 24 ++++++++++-
 init/Kconfig                    |  3 +-
 kernel/module/Kconfig           | 10 +++++
 kernel/module/internal.h        | 11 +++++
 kernel/module/main.c            | 92 +++++++++++++++++++++++++++++++++++++----
 kernel/module/version.c         | 45 ++++++++++++++++++++
 rust/Makefile                   | 32 +++++++++++++-
 scripts/Makefile.modpost        |  1 +
 scripts/mod/modpost.c           | 65 +++++++++++++++++++++++++++--
 9 files changed, 266 insertions(+), 17 deletions(-)
---
base-commit: 2295cf87ed5a6da4564034e4f8ebcce0a0a021ed
change-id: 20241022-extended-modversions-a7b44dfbfff1
prerequisite-message-id: <20241008183823.36676-21-samitolvanen@google.com>
prerequisite-patch-id: 08b46e0d1e37c262c08da6db4a87728d7b3047cc
prerequisite-patch-id: 97f307e05ec4b7a653f1ec68f825e8d5bd622b05
prerequisite-patch-id: a4519fb5eef33d692b918529ae094845f822b718
prerequisite-patch-id: e192e2a692c40d96cba919e3baae68c441ab25e4
prerequisite-patch-id: 58359b851618c2b6582e02e11ac54d7cd0375853
prerequisite-patch-id: 4d6a826429c519b581d01215e1d9c7373fdfd8c6
prerequisite-patch-id: 0dcd84187b222adf52696dbcab303d683d087dd2
prerequisite-patch-id: 0abe8634eb844a85e8dc51c1cd3970cf96cc494a
prerequisite-patch-id: c9b1a36f177f5bd25cc5a9236f4839e972c12333
prerequisite-patch-id: b7b61991d74f0a0a0b8f50f7eeb3c306261ee512
prerequisite-patch-id: f6c97ecaaa62cee387d7bb83e3dd6d5fda44cafd
prerequisite-patch-id: 6182973041c913f727b289228e7e3e19de09c999
prerequisite-patch-id: d688fb99eb5d6152fece6068c1b3a434c5750109
prerequisite-patch-id: f09e5d7c8bbba276b0e3a244a89b6bb18f692fa1
prerequisite-patch-id: 66ffe1d8df889b254a0f29992d9c0356676ed489
prerequisite-patch-id: a372f88626c3dda51eab6c6af132a76141ff20cc
prerequisite-patch-id: 57d2fe708769154a6494fb1fece56911dea00687
prerequisite-patch-id: 18ddc778b1a3b263db34e906eb74e9d15602ce68
prerequisite-patch-id: 8297655807a95e5a5522edaa0c082888c8a0286f

Best regards,
-- 
Matthew Maurer <mmaurer@google.com>

