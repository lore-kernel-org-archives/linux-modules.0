Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A871347C7
	for <linux-modules@vger.kernel.org>; Sun,  3 May 2026 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777766755; cv=none; b=DY4ttrF/Zl4uyOk/YBynNh2x/3qs57cpBCIwXviiX/MmiATSwOv2VkdXyeXMdUghbpbFWzPT+OrPFypkfA4xvN7J0MfLQQy7630GNYAyRE0npDJbFF5RwU8xeZu3Uk+EmwvbYn7DWj7HxKch6oRgSYJNs0n09MjlNR8UsZOEUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777766755; c=relaxed/simple;
	bh=WCo4IngWd7T+cDO/VH26BhNsjTRcrHFIF+C77YDtGX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b1EnD+M42/QObZnfpczYnfI4A9mjY+CmpuNu5441kqDDk1AGT/NvDIsxSe9QiK3iQTuzDsGese64C12q9g0eXC1hyj7FC/lNHcwPnHvZ4EmzM7Xd/3hG8rXPppwyOEWgntZVF0oLJnLjv5cdtvEVGWfBFovYAGV65bMMFZIutuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oilHwTjx; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oilHwTjx"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d55b97f358so2254425a34.3
        for <linux-modules@vger.kernel.org>; Sat, 02 May 2026 17:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777766749; x=1778371549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hi2XkQAfIYbnsnMWknwKW3P0EwWvqlKqATEGqIBom3w=;
        b=oilHwTjxcwEv/t+DbLpUfAvRhrGOkLlkopVDpt8F+3jmufxgyHyGAqCKjf7afdqq7i
         5/fRDtaHuumV6Z9X/zrFXN8OppvVkxiYVw1Bbu2+EiVH8gwpmns/TfqNl6aXGtrA7Y3H
         Qdiwo47LBpuzGBbOZbbqBblIkG56Ncwckfl6jigkAPK3DzvvwVlXCE8Q5bImjYJx3AlM
         nBXxFA7JG8SEsPhZDj5UPJDoGPs4GeqaF/LMCUIo4Swl5HR2rf5wTy+8aIhT3S8fLgo4
         Fnr2hUXb4PLj3U7cAmNcVQAKJVOQqTmdB4bg4HdJAEXMnS/wppHx15Sy3B9nEl813/BD
         baEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777766749; x=1778371549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hi2XkQAfIYbnsnMWknwKW3P0EwWvqlKqATEGqIBom3w=;
        b=kcvQUkyC+1EsR6k6J/qYa9ylc6Sph1XLrrm59aVRVSgfESuEh7ksZavSCBCZEKLnDy
         gExzZvrkHv3hgakeKyZxXPL5xSs8qCSi/0lpNrI9cz9ODXw5gFbdTiVBdeD9xz6ZR7KY
         +JhSnsTepTVwcJc0ji3zhgFqAkzvY7ToNPPtH0frbIssmLsmvCnOzdguGl5ZFw1aDoQD
         WK6nHgMo+st1vA4aRMjkPTPIGYyDRXkA8V1318/Ref3SQuH26Gr5KL2ensQi4I5SnOzw
         XfFdj5yrAv2LNx+TzqtPmdT+0ZhsHKLryWh44U0WtbCT14rHSc9trFvHxmJuovnmIIA8
         vyfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cj+Ur7G6LRqRDxUG4TpRoHHpnKQFKQqbtBmgNds7ydkVnPOasm/6NNYlwC/3KgQhV4CorjAMsNIMmuU0G@vger.kernel.org
X-Gm-Message-State: AOJu0YwUAtemtulnWW6S/cHVepH0YWSwaxLmp7gqLfce60KxTcXJu0hm
	YcF3W04qE67KerBcSzu0jxrWrxHa5y7M1HaO6cIiKEoqkRrJV+95kIa2
X-Gm-Gg: AeBDievPbaGCicVW0c6XIu/NioGJ1de7RCkfUNlWOVZclJtndk4zn2z3kzQjKA3NPpG
	swP88FHFThKZ5fmGPIViLpORfTL7rGOCdx0iv7HZuvL32cLYS/3+awiPIJ+OkU7jjY7+oGcJsEp
	iV8tYkJO2aU8qWA/RT0yaB0VC4SNSgFMXNJ+NtrRBJQ0sdZpftxl82xoPWRpzuCE+bKscGtuRSY
	HWeRc/a8Sh/h3FkvfWHgWBecgHCDkyP8jVv0Jqqc/BPZRLS3Cd4zMM9+kltg0xyD2HBOiW4A5Em
	9BsGjtqaF4XOcGCPA02TV6PaXKztVg9N8K6nzVzj6FyMTiSy+8iRT47YOd95OGTnKzf+G8/2q5N
	by97MrrvV0rJ2qSEIQ+IMl1QxRC2+nGzkHbkLFMU+sVZdKL3U1wyfRqAj3pvQtV31J6NpwCID7C
	RzYNVcDVoqSWC//BlZqre7su7vzSbMbY4tZbTxSjWFWNbJ+aimMNPTHoooQ+z7HsNdvDzmrLR8
X-Received: by 2002:a05:6830:6401:b0:7d7:f13a:761c with SMTP id 46e09a7af769-7dee14371b8mr2524196a34.23.1777766749001;
        Sat, 02 May 2026 17:05:49 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7decae2b090sm5379676a34.24.2026.05.02.17.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 17:05:48 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 02 May 2026 18:05:36 -0600
Subject: [PATCH 5/5] dyndbg.lds.S: fix lost dyndbg sections in modules
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-asm-generic-1-v1-5-1103ee0152df@gmail.com>
References: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
In-Reply-To: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777766741; l=3739;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=WCo4IngWd7T+cDO/VH26BhNsjTRcrHFIF+C77YDtGX0=;
 b=MsxKRcJINzBKfgiZDoIH1qONFugHmNLzQUcfOGghBMScsKxNkgzec9MtG5jAsiiLe9m+rcTUV
 5sfTrj25FmZCpkyMojb71FU6WQXFERQyTQ+FEdOpzVG0bJ2mUveh2qu
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Several build configs had problems with __dyndbg* sections getting
lost in drm drivers.  Fix this by following the model demonstrated in
codetag.lds.h.

Introduce include/asm-generic/dyndbg.lds.h, to bundle dynamic-debug's
multiple sections together, into 2 macros:

vmlinux.lds.h DATA_DATA: move the 2 BOUNDED_SECTION_BY(__dyndbg*)
calls into dyndbg.lds.h DYNDBG_SECTIONS(). vmlinux.lds.h now includes
the new file and calls the new macro.

MOD_DYNDBG_SECTIONS declares the 2 BOUNDED_SECTION_BY calls, but wraps
them with output section syntax to keep them as known and separate ELF
sections in the module.ko.  The KEEP fixes the lost section.

dyndbg.lds.h includes (reuses) bounded-section.lds.h

scripts/module.lds.S: now calls MOD_DYNDBG_SECTIONS right before the
CODETAG macro (consistent with their placements in vmlinux.lds.h), and
also includes dyndbg.lds.h

This isolates vmlinux.lds.h from further __dyndbg section additions.

CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 MAINTAINERS                       |  1 +
 include/asm-generic/dyndbg.lds.h  | 19 +++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  6 ++----
 scripts/module.lds.S              |  2 ++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..182e50b0fad9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9070,6 +9070,7 @@ DYNAMIC DEBUG
 M:	Jason Baron <jbaron@akamai.com>
 M:	Jim Cromie <jim.cromie@gmail.com>
 S:	Maintained
+F:	include/asm-generic/dyndbg.lds.h
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
new file mode 100644
index 000000000000..f95683aa16b6
--- /dev/null
+++ b/include/asm-generic/dyndbg.lds.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_GENERIC_DYNDBG_LDS_H
+#define __ASM_GENERIC_DYNDBG_LDS_H
+
+#include <asm-generic/bounded_sections.lds.h>
+#define DYNDBG_SECTIONS()					\
+	. = ALIGN(8);						\
+	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
+	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)
+
+#define MOD_DYNDBG_SECTIONS()                                           \
+	__dyndbg : {							\
+		BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
+	}								\
+	__dyndbg_classes : {						\
+		BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)	\
+	}
+
+#endif /* __ASM_GENERIC_DYNDBG_LDS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d9d2eb708355..54897d742c6c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -332,6 +332,7 @@
 /*
  * .data section
  */
+#include <asm-generic/dyndbg.lds.h>
 #define DATA_DATA							\
 	*(.xiptext)							\
 	*(DATA_MAIN)							\
@@ -345,10 +346,7 @@
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

