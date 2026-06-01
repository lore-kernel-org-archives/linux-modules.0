Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB93793DF
	for <linux-modules@vger.kernel.org>; Mon,  1 Jun 2026 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315520; cv=none; b=MCKucwi8kncRRRrmVAnyE4qPBo6ChDLUjD9MGGaqrKLHvDg538PZlfej+gY0M9d+hEKaxepZ3NiEWwYTareTnHo2l15UDomRfeSoBjp1WGhV0CoD6BJPvPRRwoAirbnEtIBT0pVQT4OAv8Qf7+wfwek9Z+yzrRLV5yCP/vBFrO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315520; c=relaxed/simple;
	bh=dHDLAmmZkSEwCrVjFAbC9GSDOGfjrhwtK5sTHYbJuoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZLk/C2a8mOCjTWrUo6pTToAC4r3cdHNbsVSUPGJK7WRCth7LAMmtVnwVAMZFTLALg21SwfgqnIVJht/enBTUNKc2ZwF/NWS2EO6MUogzbNnGdx6gwt1rymCQlv7oLkWypERpQ2MTvp7qJProX+NI7M/WyxiktV28N3xWsmcYh2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaEdvlZa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaEdvlZa"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso6753345e9.3
        for <linux-modules@vger.kernel.org>; Mon, 01 Jun 2026 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315517; x=1780920317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ks10Mou4dS+uM/gF5zD1xC7hoNz/3aUwUMnLMPkjLt0=;
        b=TaEdvlZaacjxn6igmxhyxUmq8lChVmItQcL2OA+lfuZjhA7KH+nDcTbdqgKGBvLu0I
         3bNQZtu8xLTBENoTWNL+wl7lcsiKSh5XehyMyLo4QEzTrBDIXijDF6Jp0ZFWL2rH/rb4
         7pPge7xcs2JRnKwhgRKw+/CiVIq2IC2mG+2Fvc/Zrw3n5odTSUd5EaAnqt9w4XdNersh
         xu8lJN3SaZQbhX+nYdlxBB4AyxavMF70TIr8OYFGGLCvMjwXyfykfwDzna8Rxogun2AL
         S/d+DL6Na8/PpSB0cv5YJb7rWFE8uU0/7yJy2Z2OSeYb1w7lLYD9qNBElJ9A4GERUQdv
         f6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315517; x=1780920317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ks10Mou4dS+uM/gF5zD1xC7hoNz/3aUwUMnLMPkjLt0=;
        b=o7HKxdcJcuK5pkIOatMk6ROq6avue8bNv1Eiqm4Vn8ybAWERxwjy4oD+UUlYj7KTMi
         2aAKTQhhaH47UO/puEBBZpiiSDna24hfgCkIyJQaWZNwH/5eVizVjq5MozomZG1mFJl5
         s3mAxxiUTQFBrN3k6UF6GHB2yMfa4e/NRAdmCY8fEtIjdsALGbPOg392F++0iCPVDRO2
         6YYbvltwT29pwMpoi/GKk9E8Ophh+S1BPly23POzRw15gm+LQrCPNnSbvpT6+QrMhw2F
         yY86Y6df/s0uYb+Db5utw62bkcCXmE0kUguI0F2bjlQ8VNiFeSXd4HyMnpPaeYsmb8du
         56dg==
X-Forwarded-Encrypted: i=1; AFNElJ8L5HKX3u5hqSKXqeDmHN/jsN30BzfpeLRfw+82XMxCmqqCiwEQUe2OYng7Etg/8JNZqaA/QyqNGAZZoSEO@vger.kernel.org
X-Gm-Message-State: AOJu0YxpnkSW8rsiftGBbgZDLL0TkUl7x+KrE3hB7nlNWlbr6qW6Shpl
	RgSkd1pBjRIoaBX4tzys23uV6fh+KFsNAjMYUlFxbtrsz8E7IoSru4I8
X-Gm-Gg: Acq92OFQkScLq1PSLE9Kew9vTASdX9burDTGy6/YFcnHnYWqaZh61yFCMJFNnQtPeUM
	BHaZODychjc6Z9QwCaCqV9ouyqArvYWffnroBSeGSDKNj+fwCBI1vAHSTKttzEhJCK2Pmap3vGT
	RZJLWbMie+C8lig67bHPu72zjiQwr07SbSx453dTCMirXqD/aX89aUwTkroHp0sGQA2hyEsrBtj
	Q/Skbn87/w0eH9PDZOmvXBfp93c7Gsh4bSs/tFLpc16kOzNxyyZjNb9HysKK+4uhW31bWeN8SA9
	kfLXro/4E+wK7Ap7zuYrwQCyHHkFSo01LyU4rVbxms3mDi1OcX9dTp+eiGxK1KXhiLyZi2SIPaK
	VZaMAEh8UA1JNBN95e3VZ+SGALXyP1j4kAnR7pMcZJ5n7CtfDsdH8uQ8Blh/2xESlZEDnIrwJxV
	4VhHXcPdkGjCf+0XFh8zCQH+hyGJK2segi28cCi689jw==
X-Received: by 2002:a05:600c:c04b:20b0:490:3fdd:d353 with SMTP id 5b1f17b1804b1-490a29152demr143162745e9.8.1780315516822;
        Mon, 01 Jun 2026 05:05:16 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:05:16 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:53 +0000
Subject: [PATCH v3 07/24] dyndbg.lds.S: fix lost dyndbg sections in modules
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-7-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=5103;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=dHDLAmmZkSEwCrVjFAbC9GSDOGfjrhwtK5sTHYbJuoQ=;
 b=PQG/mC/MYN8ybEsRt1jpLWzZe9n+cpYR5hlwKDJxDHfZeAenGyn9KBu5ronOwgq41sw9dE2I3
 sLG903nGuaVAHed+XjjBRzw1VXV8ccy6jMlqvG3zOfNGFRVad4AcGXP
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

