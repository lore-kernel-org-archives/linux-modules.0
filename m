Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E4C382379
	for <linux-modules@vger.kernel.org>; Tue, 30 Jun 2026 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844692; cv=none; b=W4YOkC2dXqJrw/pYN2q9abNQDqGjoH7iOmRwU7V753no/lsCrGsB3/ir5v1LzOriPbtagRMTMqzEbz3w0t1z07ZGWElTeFMRRWmnlomSFCK0UJpx+CNfda6PZxhB/0Jx6FBmR2KAb12BWYma2pM7Sa6fYnKYJpH9FsUFUw38AiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844692; c=relaxed/simple;
	bh=hoC09ruaTFT69doGplUgeUIsoPbyQFsimJQmBj3k34c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AequGUie+KfH2DUcqqhrzhYs9edJ+stjh50cRAyxGbXVXXCoiHihflMhlcOq53/COqj8DnD9F0bD2K9k/FZX8uFhlJCLQdf2AJBuFb+rIiCc0mcEWFJN46UyakoIb8KTQopECmTvXykVa11w8zWVghglPBqFfH3RiJFEA9tw6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzu50aqz; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzu50aqz"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9bb2d0417so2118438a34.0
        for <linux-modules@vger.kernel.org>; Tue, 30 Jun 2026 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844686; x=1783449486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b65anD9BuvaOJmgxeV/E8/NGlo1JDwrV2r97bE3ThlM=;
        b=dzu50aqzEfLU+c+tFooIZzoOCR7p2LS3UZktfURRIee1gIfIoXorjPB7WenSNkVcU5
         ocCZXRseTXELT900UJt1fmFp2Yp3JxQbaCUPvWlRzHFe2RLRN32Tf7/nT2XAv73zVNM8
         87M6GC5C6AN38NEHDDaecXg9JccQ7Xtxe7OrHbpaeVtyfijWpSeVQPfiLoKInBw0z7+o
         wFogbVKqBYROYNFBcP0p3rAqHRtVQu+JXToP2uVIYwKofLZ+cYr5De+uiKn+8zgSKtne
         SIUMZxSv1uEkaG9mNLXFzeQoVTHBTmi0ytMLdeCrgAeTAkKV1cIrQM6gHSksCEPl8hyh
         IbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844686; x=1783449486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b65anD9BuvaOJmgxeV/E8/NGlo1JDwrV2r97bE3ThlM=;
        b=TSVUbLrJUPP9rQQ5cMUq2Gg4meX8510D1w/CpsP/xF0kXSDgBSx4VhG73iPg0Z1uhB
         Xuvz4Sy3kqs/v12A7VDoOF11jElBYXBgfMK0I8Qeu4qZudS1U9PdBUCupUeUgLbj2TMD
         Vqk9qFA8/k1wjGhQOwDKOv/cwa/+ucBh29ecERqiGzewPiFYQvNo90JzNoWMLoR9KJxo
         Sngwp8+QFwEGTfeGhfBzKM6zNrjzFZYK94DDZ+VgPSe9ZHSMCo2zHdRf9tNiPmTVNJP6
         cL4At4Jn4o4RIK/oVUNnBI5lzh6HoZ5ATec1vphVjIxjKUfID+Hld8SSJH9tZwMNe0aC
         tnrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+sRGSZ/ZFzosbjqH3G3D61kITLkZee16GsfelfP88y9GzBdOjFC6kWm+WWKrZIW4ROviFMBWdKOEKbRKkL@vger.kernel.org
X-Gm-Message-State: AOJu0YwfStPc2kVy14G36OQYDXMc1vJelBs/0/RAD3CAfA5+1WNvDtuf
	jj+VODjGzGGSj1e0xeL7Y3y5HsssxIwdU4LqAbvF+sw3SrENK+NvF9iRVQS+2K5X
X-Gm-Gg: AfdE7cnrT62DI0WModouhMzuVdk1QNNwhJrBz2eU3f6b14yAvIYnJIsj0q7PxA6kqVn
	M5bgidih0kHfA/R5U0l2LWFfpJijBc2t8DEFDC+mAI6kOT3CLVxnsX9xi+R2nIEu8T1rHgOgqoW
	Cc0Nxd3X9Uy7SjdfuEDn3TKmuwr2wQOJAk1oh3TbbpCR1gGAORSAd0fRreKsNV7915//H+unwAJ
	CyxBOQCPRw2ygoCOxMXHQTMGxe6EpJLcC9S0ID6CrRSGR+JpvI4HqkPSQSmrkQcThglinwPznhE
	aHlZiiX6JgSTG/OQfKUuELi3tl0/98PRmEbDTWtmJPBogM+MnVenZpJxxR23E/U+2ikgkvTobZX
	NIuXcGSdobFfmYWiszWlDQ705ObnFT0BCVy7l4hIIzQFfK6n6I8ndOrQG9DKRlrFArDAe6pRf3W
	glgi1AqhAD5pwYUDBJHL9fc9f8OEF+UAnWmSp0DuFkexw/+1mEso0=
X-Received: by 2002:a05:6830:61c5:b0:7dc:d2ad:fb17 with SMTP id 46e09a7af769-7e9ec71820fmr4379028a34.20.1782844686104;
        Tue, 30 Jun 2026 11:38:06 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7e9ebfd6ccfsm2940025a34.11.2026.06.30.11.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:38:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 30 Jun 2026 12:37:54 -0600
Subject: [PATCH v4 5/5] dyndbg.lds.S: fix lost dyndbg sections in modules
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-align-v4-5-42e6ec883342@gmail.com>
References: <20260630-fix-align-v4-0-42e6ec883342@gmail.com>
In-Reply-To: <20260630-fix-align-v4-0-42e6ec883342@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782844678; l=5103;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=hoC09ruaTFT69doGplUgeUIsoPbyQFsimJQmBj3k34c=;
 b=JqM++F8Z5lD89pPJJlwRxqb15MODc0Eml/zw43zB31ivt3aYcSusufSMz8JwZ8ZNgQBTXu7UJ
 f3hbthilk8rDMSnPQsasbcBPxv+d0HqlTxywE1nV0dvdNg1RZo+WcSo
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

With CONFIG_DRM_USE_DYNAMIC_DEBUG=y, several build configs had
problems with __dyndbg* sections getting lost in drm drivers.  Fix
this by following the model demonstrated in codetag.lds.h.

Introduce include/asm-generic/dyndbg.lds.h, to bundle dynamic-debug's
multiple sections together, into 2 macros:

vmlinux.lds.h DATA_DATA: move the 2 BOUNDED_SECTION_BY(__dyndbg*)
calls into dyndbg.lds.h DYNDBG_SECTIONS(). vmlinux.lds.h now includes
the new file and calls the new macro.

MOD_DYNDBG_SECTIONS keeps the 2 sections by name, aligns them and sets
the output address to 0 when the sections are empty.

dyndbg.lds.h includes (reuses) bounded-section.lds.h

scripts/module.lds.S: now calls MOD_DYNDBG_SECTIONS right before the
CODETAG macro (consistent with their placements in vmlinux.lds.h), and
also includes dyndbg.lds.h

This isolates vmlinux.lds.h from further __dyndbg section additions.

CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
v3: move #includes to top, drop extra ALIGN(8) in DYNDBG_SECTIONS, add RvBy

v2: Address linker script review feedback for relocatable modules.

MOD_DYNDBG_SECTIONS() used the BOUNDED_SECTION_BY() macro, which
proved problematic for kernel modules for two reasons:

1. Unwanted Empty Sections:
   BOUNDED_SECTION_BY() automatically generates `__start` and `__stop`
   symbols. When applied to `MOD_DYNDBG_SECTIONS()`, the linker assumes
   the sections are populated due to the symbol definitions, forcing an
   empty `__dyndbg` and `__dyndbg_classes` output section in every
   compiled module, even those without dynamic debug configuration.
   Since the module loader uses `section_objs()` to locate data via
   ELF headers instead of relying on `__start`/`__stop` symbols, these
   assignments are completely unnecessary.

2. Non-zero Output Addresses:
   During relocatable linking (e.g., `ld.bfd -r`), omitting an explicit
   base address causes the section to inherit the current location
   counter. This results in non-zero sh_addr values in `.ko` files,
   which is confusing, degrades compressibility, and can cause issues
   with external tools parsing the ELF.

Fix both issues by dropping `BOUNDED_SECTION_BY()` in favor of a simple
`KEEP(*(...))` constraint and explicitly defining the sections with a `0`
base address: `__dyndbg 0 : ALIGN(8) { ... }`.

fixup-inc-vml
---
 MAINTAINERS                       |  1 +
 include/asm-generic/dyndbg.lds.h  | 18 ++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  6 ++----
 scripts/module.lds.S              |  2 ++
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..cfc2695d9bbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9178,6 +9178,7 @@ DYNAMIC DEBUG
 M:	Jason Baron <jbaron@akamai.com>
 M:	Jim Cromie <jim.cromie@gmail.com>
 S:	Maintained
+F:	include/asm-generic/dyndbg.lds.h
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
new file mode 100644
index 000000000000..9d8951bef688
--- /dev/null
+++ b/include/asm-generic/dyndbg.lds.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_GENERIC_DYNDBG_LDS_H
+#define __ASM_GENERIC_DYNDBG_LDS_H
+
+#include <asm-generic/bounded_sections.lds.h>
+#define DYNDBG_SECTIONS()					\
+	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
+	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)
+
+#define MOD_DYNDBG_SECTIONS()						\
+	__dyndbg 0 : ALIGN(8) {						\
+		KEEP(*(__dyndbg))					\
+	}								\
+	__dyndbg_classes 0 : ALIGN(8) {					\
+		KEEP(*(__dyndbg_classes))				\
+	}
+
+#endif /* __ASM_GENERIC_DYNDBG_LDS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3758a79d0430..bd60f278f762 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -52,6 +52,7 @@
 
 #include <asm-generic/bounded_sections.lds.h>
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/dyndbg.lds.h>
 
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
@@ -344,10 +345,7 @@
 	*(.data..do_once)						\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
-	/* implement dynamic printk debug */				\
-	. = ALIGN(8);							\
-	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
-	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
+	DYNDBG_SECTIONS()						\
 	CODETAG_SECTIONS()						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index b62683061d79..2e62dc5bd5d4 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -10,6 +10,7 @@
 #endif
 
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/dyndbg.lds.h>
 
 SECTIONS {
 	/DISCARD/ : {
@@ -61,6 +62,7 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
+	MOD_DYNDBG_SECTIONS()
 	MOD_SEPARATE_CODETAG_SECTIONS()
 }
 

-- 
2.54.0

