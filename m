Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A81189F43
	for <linux-modules@vger.kernel.org>; Mon, 13 Apr 2026 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776039984; cv=none; b=HKeaFqcTrOFE6LFq+FGtG5nj71eNhfQpER6TZhxLtFVk1QNXBsdIXTBLb5Y8q1bsoS12xzWDqOTt5RhoZG3D/gDKOLejngZvrP6E7XKMBcZpA63oM3FpIO/IrzH0t9uscfTfQevgxOl7G0z7ianfLgekfwOEDcBzuB/r8ojxFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776039984; c=relaxed/simple;
	bh=k9d24ToKobMZOIWV0r+8hy/vwTj8HsOxM0dlbWE+vkw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SRy6R2iQ2F27xWlLVBil3ns9YvvkjGiD+ixq3MLMVlnwTctPkQpxVyhVu7IAbZmOK4MSJSusxLbKXNNzbyzlYT9GFPeUTAQTWr1EH771TLUEYpVJaefV6x7ICyMB807QBH1UK54I8kCXLzZ3civvOeUNTH+EnbxK5z9E3+JOMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GPvp8ieJ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GPvp8ieJ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2cc75e79b97so13912693eec.1
        for <linux-modules@vger.kernel.org>; Sun, 12 Apr 2026 17:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776039982; x=1776644782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/2Lw9bF2AZkxXpAtUTVqKPN5XOvvuNBdPxMzGEHGN1A=;
        b=GPvp8ieJ6cMiPfn1XCMLaMyGNYnf/PKLUxUafmXeBtw2rr2edFn9S9QCiAz2afhzNc
         L+RwDhYXHAOWGzBm8myIaM70ef8oGDhMBhYTVMnCWNFF1A9krjzR/4wZ+xCX/xK2haPM
         gdU7Tk+YjafycHhyioF1aLzB6AT5NVRyQ9EDnMgdRN9s//DH4GIzBfBeWeRHuWwoPU38
         8mz+uO2zyeHk6CORW/fVRIAI5NAsJ/YtZMiAWA/dKS3CNVYnEQcIgKQK5QFvkvuUVyrO
         0zmk5DMX8cn+ZW2V/HbO3M3TGpZfFBhWUCuAHPzCg911UwdvdfIrZ7oC1ffBZ7Jhp5gt
         UxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776039982; x=1776644782;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2Lw9bF2AZkxXpAtUTVqKPN5XOvvuNBdPxMzGEHGN1A=;
        b=O1AkpcfEsr4Xa9Sz/cDpsUnLuVeu3yPvcN23WCHBw6NZIN+nOjIATETixIazStfSZ8
         bqyogHTP2OUUdlqkw03sOU7y0KvquFVhY90auw75qx2zScdlXtk8t7yhXJpeUXCCaoS4
         6J3jYRCXIBtCL2WANKLnBCITC64V79CTGMKiJQmOLgPupuuy/A/SC9xN6mzyt4f654xA
         1wQH5lYrB/EzhUZttjLZEi44wsQZn4p8bJJWp+iG1PPVgow3yTEP5Ne9pGdAuIh1gssJ
         G3cqYprRVpNS0D+NaC6rOFHSME1m4pZmtbnGLPERH/dP60nvB95B9QgLXRbtZryp0nR6
         mzFQ==
X-Forwarded-Encrypted: i=1; AFNElJ93raHNmiYMUQrM3JvShxZ1WZzi+cJRhTpCUC2BiUlWzdQAsCfFRnD2opa7KmhBFSsqR85eOknLA/lcqPvW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5r6idaw4lD1inPo+OWoJ0aRy9CqqX/af05+J63GTiKa5zD3uS
	QxVK0SrGb8KmBWN/sLlXSp/fOP8jVfL8x1RamuqJSjXnYSUZHZ4TkuLAThspUcHDzYAX+QoP1Ov
	BrBot+wKjLTKfYj7IAV6SW76Vgqwe3w==
X-Received: from dybmf1.prod.google.com ([2002:a05:7301:901:b0:2d8:f479:9a89])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:6da8:b0:2c4:a862:2368 with SMTP id 5a478bee46e88-2d5871bcb93mr6571691eec.2.1776039981707;
 Sun, 12 Apr 2026 17:26:21 -0700 (PDT)
Date: Mon, 13 Apr 2026 00:26:14 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=6197; i=samitolvanen@google.com;
 h=from:subject; bh=WhYanGR9fAnlhlIE8K9Z5IagX94zwZJLZzYcFRGWLZI=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJl3LDR4X38M2nlGb47dlamzvksuVXk887qAzf7zFo5HF
 B7mOKTv6yhlYRDjYpAVU2Rp+bp66+7vTqmvPhdJwMxhZQIZwsDFKQATie1l+Cv6+nSbQsFXh88Z
 t5fPWOERbvxx13ImrbamvdNzy9wNXroyMrw94RvI2n/cpdihkr+L+4OqhKzzv7/1WeeusGUuOXN 4FRcA
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413002616.1966468-2-samitolvanen@google.com>
Subject: [GIT PULL] Modules changes for v7.1-rc1
From: Sami Tolvanen <samitolvanen@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	Lucas De Marchi <demarchi@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Nicholas Sielicki <linux@opensource.nslick.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Siddharth Nayyar <sidnayyar@google.com>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c=
:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modu=
les-7.1-rc1

for you to fetch changes up to 663385f9155f27892a97a5824006f806a32eb8dc:

  module: Simplify warning on positive returns from module_init() (2026-04-=
04 00:04:48 +0000)

----------------------------------------------------------------
Modules changes for v7.1-rc1

Kernel symbol flags:

  - Replace the separate *_gpl symbol sections (__ksymtab_gpl and
    __kcrctab_gpl) with a unified symbol table and a new
    __kflagstab section. This section stores symbol flags, such as
    the GPL-only flag, as an 8-bit bitset for each exported symbol.
    This is a cleanup that simplifies symbol lookup in the module
    loader by avoiding table fragmentation and will allow a cleaner
    way to add more flags later if needed.

Module signature UAPI:

  - Move struct module_signature to the UAPI headers to allow reuse
    by tools outside the kernel proper, such as kmod and
    scripts/sign-file. This also renames a few constants for clarity
    and drops unused signature types as preparation for hash-based
    module integrity checking work that's in progress.

Sysfs:

  - Add a /sys/module/<module>/import_ns sysfs attribute to show
    the symbol namespaces imported by loaded modules. This makes it
    easier to verify driver API access at runtime on systems that
    care about such things (e.g. Android).

Cleanups and fixes:

  - Force sh_addr to 0 for all sections in module.lds. This prevents
    non-zero section addresses when linking modules with ld.bfd -r,
    which confused elfutils.

  - Fix a memory leak of charp module parameters on module unload
    when the kernel is configured with CONFIG_SYSFS=3Dn.

  - Override the -EEXIST error code returned by module_init() to
    userspace. This prevents confusion with the errno reserved by
    the module loader to indicate that a module is already loaded.

  - Simplify the warning message and drop the stack dump on positive
    returns from module_init().

  - Drop unnecessary extern keywords from function declarations and
    synchronize parse_args() arguments with their implementation.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

----------------------------------------------------------------
Conflicts:

There is a small merge conflict in scripts/module.lds.S between the
parisc tree, where the commit

  eab5a8054a5cf ("module.lds.S: Fix modules on 32-bit parisc architecture")

conflicts with

  4afc71bba8b7 ("module.lds,codetag: force 0 sh_addr for sections")

----------------------------------------------------------------
Joe Lawrence (1):
      module.lds,codetag: force 0 sh_addr for sections

Lucas De Marchi (2):
      module: Override -EEXIST module return
      module: Simplify warning on positive returns from module_init()

Nicholas Sielicki (2):
      module: expose imported namespaces via sysfs
      docs: symbol-namespaces: mention sysfs attribute

Petr Pavlu (3):
      module: Fix freeing of charp module parameters when CONFIG_SYSFS=3Dn
      module: Clean up parse_args() arguments
      module: Remove extern keyword from param prototypes

Siddharth Nayyar (7):
      module: define ksym_flags enumeration to represent kernel symbol flag=
s
      module: add kflagstab section to vmlinux and modules
      module: populate kflagstab in modpost
      module: use kflagstab instead of *_gpl sections
      module: deprecate usage of *_gpl sections in module loader
      module: remove *_gpl sections from vmlinux and modules
      documentation: remove references to *_gpl sections

Thomas Wei=C3=9Fschuh (8):
      extract-cert: drop unused definition of PKEY_ID_PKCS7
      module: Drop unused signature types
      module: Give 'enum pkey_id_type' a more specific name
      module: Give MODULE_SIG_STRING a more descriptive name
      module: Move 'struct module_signature' to UAPI
      tools uapi headers: add linux/module_signature.h
      sign-file: use 'struct module_signature' from the UAPI headers
      selftests/bpf: verify_pkcs7_sig: Use 'struct module_signature' from t=
he UAPI headers

 Documentation/ABI/testing/sysfs-module             |   9 +
 Documentation/core-api/symbol-namespaces.rst       |   5 +
 Documentation/kbuild/modules.rst                   |  11 +-
 arch/s390/kernel/machine_kexec_file.c              |   6 +-
 certs/extract-cert.c                               |   2 -
 include/asm-generic/codetag.lds.h                  |   2 +-
 include/asm-generic/vmlinux.lds.h                  |  21 +--
 include/linux/export-internal.h                    |  28 +--
 include/linux/module.h                             |   5 +-
 include/linux/module_signature.h                   |  30 +---
 include/linux/module_symbol.h                      |   5 +
 include/linux/moduleparam.h                        | 100 +++++------
 include/uapi/linux/module_signature.h              |  41 +++++
 kernel/module/internal.h                           |   4 +-
 kernel/module/main.c                               | 192 ++++++++++++++---=
----
 kernel/module/signing.c                            |   4 +-
 kernel/module_signature.c                          |   2 +-
 kernel/params.c                                    |  29 ++--
 scripts/Makefile                                   |   1 +
 scripts/mod/modpost.c                              |  16 +-
 scripts/module.lds.S                               |  15 +-
 scripts/sign-file.c                                |  19 +-
 security/integrity/ima/ima_modsig.c                |   6 +-
 tools/include/uapi/linux/module_signature.h        |  41 +++++
 tools/testing/selftests/bpf/Makefile               |   1 +
 .../selftests/bpf/prog_tests/verify_pkcs7_sig.c    |  28 +--
 26 files changed, 368 insertions(+), 255 deletions(-)
 create mode 100644 include/uapi/linux/module_signature.h
 create mode 100644 tools/include/uapi/linux/module_signature.h
