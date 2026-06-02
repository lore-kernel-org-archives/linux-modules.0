Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE13B5E07
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440523; cv=none; b=WQrGRdWb9816nxIXCfcg4fPSQhvveEjFnd2/YqSjPXJowEMag97ZDeTT+5RWWmWGHIh4HVLAI9iixzqanpkx16elI91S4dWOEedjHgSLw240h37cuUXS2khtDvG/SAYSj9TT5u66whk1C3JpTa0Z+xj/2g5jlfXsh/AyBjl7hkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440523; c=relaxed/simple;
	bh=dHDLAmmZkSEwCrVjFAbC9GSDOGfjrhwtK5sTHYbJuoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T9dvfSFRrWyM3/wlx32qPdJ3AuDdRZ/wPBT3s4XsBDTIlv7EfFMR2bvxJxLqTd/27YtCQgMa2MXpfGg85jThJqNwan1PZ05fmyuIZQulaHnbSW+ZbkvgC6pebJdaD8fG+ABSGwGwfEsuHc9HS/FGBgLeJI8w4PIXJxzkEZRlfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJtK/d5E; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJtK/d5E"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4905529b933so94551015e9.0
        for <linux-modules@vger.kernel.org>; Tue, 02 Jun 2026 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440511; x=1781045311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ks10Mou4dS+uM/gF5zD1xC7hoNz/3aUwUMnLMPkjLt0=;
        b=JJtK/d5EfKNWAwcRClNaXWtnneknh6as8UV7UfZ1nlOt9R4ByRtwrZZbnleZ8OzdvH
         7RSqDpnwe/AnKVzTg6AczAhrHIzIuZ/sag8gLLXzKVTj6Qf+Vaw1py0CWeS9rZpRsFY3
         VSIMWOQeOFynsoW3YupToJCPhnzJbnHheHV47DkIEhdARkZLANRaPy13bqiNQt1Acx59
         yPfhAC+WgYGThLwY8nRa4ixOgiERdy/B6ENABJ61/0uOabs1WqAEvTLIUggFowtW1QsG
         B5b0fPJ1l/HM6Mp8h+MYQwaeSgGubndc0XwawyUWUm+nnxXpQ7xcoi/n0R54htqcskL5
         mf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440511; x=1781045311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ks10Mou4dS+uM/gF5zD1xC7hoNz/3aUwUMnLMPkjLt0=;
        b=E40S+wszUEOQBAQtUrqNRJwPvECJpqZa1bNVFZeJqgposFsSEkCLzUp3pUFgsooA7d
         GIsfhUnXdnYiyRvZohpcZ61nIHhHNKkMrZI/Und1A5TBQ6DC/SLndV3YUAfw6peLOrq7
         LP/ejPtmKc4kljv3JCUhIaIQ59ecmyBhN+N5JCH95RHWDpoZLi1Lzk75d2e69l5Mf89o
         THfJBDApU1hj0u0Sz4VK8L/aSEX7e534jAhMyUtoHQadzqCgMeOkPIW17we1kQJtYh6e
         JxEiXmXh+pdWe3+PdhitQkLvYeR4hPA5ucYx8jZRddH/893ShZ4QluLXf6E1N+K56s1+
         uZ4g==
X-Forwarded-Encrypted: i=1; AFNElJ+BQqTfRL8yR5cIPjK7YUMP4cqmkdTMJPDg1WqaJ6YJX/esz+H6p6p7dMUxMScVLhSuy5L3UTq+X+NWZMXH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CcBp71PGUU1UXFWyo3jlTR9XrS6wBxOz72FVduaN765E+Vi4
	PYEd+/2Y7ajQGpEp0sXdmkZ//Su2TFixeHhbWRc+NtBNb018ta0IcfIO
X-Gm-Gg: Acq92OEGDxuMbej57Wfw8b19TZziF2p1y39hi75LsYgCBKTvF/6p78XfZWQZA16WZdh
	pGFjv7hkesugywSRuIokEoiMIbRQWKZeGjXL2r6SeT69oDTSri341da0yiVB4hXTQ43/ShJF44i
	zWAw7FfPn8f4k9GDTR9c0ou12HYkug0ELdXNE5i9vBtCGKaYwAZJFDPXvjlL+Ocror+1dfywCNG
	GX0mK3n1IbBLlIdfT9urzQurkbX5tJDmwWoOtbc6TYwsFmBsg/EQbxiZNhlWeTQ4EmN+ia4bpIJ
	9G+/c7OzUiGKkxeYX5qtAud9BOUy6xDb1yAlKMdHxpjH76E02vXR2gb7o9mxzlBBnkuOdHqbbPl
	0XyO+4QH1o982UakMu2wTAw0XiW+RrTtpyOtBOAW06xeO+OANNc6E41CzhjNsOsQme5KDZRe+4l
	h8wrBk8VaRlabYiCeehylyDUjFhyhNcePqzWNV475W6Q==
X-Received: by 2002:a05:600c:1c1e:b0:490:3d62:f5df with SMTP id 5b1f17b1804b1-490b5ed10b4mr12433385e9.30.1780440511256;
        Tue, 02 Jun 2026 15:48:31 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:30 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:04 +0000
Subject: [PATCH v4 07/25] dyndbg.lds.S: fix lost dyndbg sections in modules
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-7-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=5103;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=dHDLAmmZkSEwCrVjFAbC9GSDOGfjrhwtK5sTHYbJuoQ=;
 b=LgE/Ax74P2Yjlnhsm6MH1wa6Hvkqc9ItHp5m4Y2LZojY/pi9asSAVhoGDgkZOORwDx8iHvhdp
 AwQ4fgRjXD0CyFUu4vc9iMWWwynZddzKwVQI/zAzdr55WpWVsA3sA3a
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
index 9ec290e38b44..6cf80e7ac039 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9083,6 +9083,7 @@ DYNAMIC DEBUG
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
index 2b1becd809be..0a1994bb8793 100644
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

