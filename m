Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B143F8A1
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667448; cv=none; b=riR//QeZZMzCSoBr1gMERNtEDAAu7UdZScOklbN5VA7+4Ia8852TCQjQsjbtwDNiNemllBSavm4K0x9RY0/IAIGjpMF15awA/MKzJAVUyvM74asieTgreujm4Ul8bHcon3G9UoFvAflOz48UHOEJ2kpp7zs4lNaQGjl9dd0fpGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667448; c=relaxed/simple;
	bh=r7cPyNH2Cq6jQDJAyzg6SZjrmdAYuNsGswuzcZ7IE5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AI1Pa+s9VvrmeqBgv+Qalq6ta7tFzeTu8PDydoMfDhimgFjnu0ejAnXx621BIGuNENA3H37FhbMdN1Ki+l7AQfQD+K7T6OcV+MNFNogQmxuXII8NQ0b1Pfkgb7os8CXD52Qpr22sPDIpO8lo9rTdw8dWrRUuVYvzxN5KiRISAl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVTLOEFl; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVTLOEFl"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6128bd9b3so5903170a34.1
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667444; x=1785272244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8WUTP1SeYu0XxIoItMj1x7HW2i1GXPO5OoDtdjBdMko=;
        b=lVTLOEFljiM2GNO/jxm2MxmUn3VBMqpZB/U56M3Jfa9JsoT+IYy1zPpPCJOSXa+pNP
         XWHjx+Sx81E3QHesoTjcc20F1vw2L399PAWaa3HBfGfDPAjo7xHkYgbA0HYpezqH0KlB
         xT6BL8QHNEMSpLSnGoqtKz7bLg1ACKa0u5iEb6cLyjWN9qVuhzTjGuV4MFur1+L891Kk
         YNbyF4g70dQTHNLC4XutEciO+nvPjHKPLY+G8P1u/zxDX/EZJRcW3rQpv41wKCy2TlBW
         lY5kYqgwKVJHs4fTBDq8+yPSDHhxcB+bD0p6dxWuDsEIIrOLGlHqSDpLHla/j9K8r7zq
         sJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667444; x=1785272244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8WUTP1SeYu0XxIoItMj1x7HW2i1GXPO5OoDtdjBdMko=;
        b=R4nzfRjJzSPJKl4FOPT2/zVsQfVikRKO59LRwzF1Xyfy2gnB8Jtj1+3VMFVZiIHUVX
         esFE8EdjE5xnEs8fgh+zLX/IYg6HbM9vgjwq1OAnzbX4/HbND3j8NOtnbMBmznNUHdow
         UEAk8l5Nm2RWt3ySQl+AJ8OH/iffPPd+2OdDLb4/uwqgsEf8jWnF2I2NLFoHlOcwgHfE
         CqgIjwakROLuFNWAqWxuuR4H6+x5F7Q1LqrMu0/E3gmQmw/kItB6FKzXyPUFAAMaO/vF
         VbL0zmN5xl1wG1cSNi/x1kQboNNbPSjNCV+QNMW7mTofLPpPtQW8TN2vL6f6jQhqqyf+
         /TVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLrqv2evY19wuQTFD92j41b8MXKK5ui+vtwn5RDthfHtFI0dI4ZKL1UcI9+pGL0WMgrz36UXE6yugWKPp/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgzc6Z37cINzXsKfz1PR5fByipL8uxNuj7BOlXHnbUDYHOCLwg
	u1j61MM8y/KaHaWMnRAIoNXIhI9mO44hww3hoRj1bViP6sW9Y8d/pEAAJO4brA==
X-Gm-Gg: AfdE7cmqJaQNycQJWC0twr5z7gFFRKpq5gax+40sZ24n/m5+uoW8UG7pqhnXZc82x37
	VZpPTruCcAS7Oq4MYR14bWA+8UPO6DN+TPh6DY3m5Rku/4lzy898MS9elstC60So/BZ5/Smt/YN
	4aekKy31sslDhaU0slszKXeS+2oVTOd74h5kitFDlqFjIcT5S+lFE4j/DmoZzqbQ3dwENNQFA66
	NMYBp2QeiJV0jbxD+T+YlJvvXfEjJKONVxAAhof99EEOsJcqINZH71qxbl//ZkgMygKC0S21ult
	N5eE1zXw+EGJ6MfyHsu9IYIrfQ9PvtzOqOZLuiecfwIjZ+dJbT4d6BNt0x6M4GA9g6/EVU9cDLR
	0IWkH0i0CTNlAEZAyb4QuRRuSPJ8A6hfjg/Wx04E35a/6/SSowpaJ7vLTkED5zM3BVw1ZhVsLDi
	AziMWk7TKsRrIYWQWeiCqbPyN/uaNE8zJL4lCEOQzLeKrVTpA7+FesLUNPNaXKRtHp4c861KffV
	mZCk/WtgssuMqsCJd19zadYwg==
X-Received: by 2002:a05:6830:6406:b0:7dc:df37:844b with SMTP id 46e09a7af769-7ed9aa450bfmr10317408a34.4.1784667443681;
        Tue, 21 Jul 2026 13:57:23 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:23 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:59 -0600
Subject: [PATCH v7 10/29] dyndbg.lds.S: fix lost dyndbg sections in modules
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-10-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=5103;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=r7cPyNH2Cq6jQDJAyzg6SZjrmdAYuNsGswuzcZ7IE5Q=;
 b=HHJhPc6cyqr0abrHwJzpK82ggYBPl5p+GL7B/HFk72Yl6DLblSLMXMT5Q0lJgAJArXRzsB0Gi
 SgK5hr4om+kB0pCbEM3Ahc4fvz8NjsyITghiAkTjVDc+RglpXjrXJ6J
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
index dd6e351d2a98..ac050552923e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9179,6 +9179,7 @@ DYNAMIC DEBUG
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
2.55.0

