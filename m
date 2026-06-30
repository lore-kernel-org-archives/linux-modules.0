Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AC63E121A
	for <linux-modules@vger.kernel.org>; Tue, 30 Jun 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844684; cv=none; b=bXPFmex3hdDfLYK7G7sCZwH6N8aeFV6q+QrfQOlJEM4CLkpdXgGSptlzNXSPmJJWxPslA3RrM/vUWBFmioAlaXDGhZ1dDbf55XdTVVpqL0Yq9C/Hpi+JWTB9xwbUnFNYL12rDkLrodzHHsAXt1UJ+vqPsfj290mYMfM09BYIdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844684; c=relaxed/simple;
	bh=J+LsI8DAEpZU9ehYoJJiXmgZm0z02Q3FL0KHGdCUJp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ONCPkYhQRpew7d/WdsXepBf7d2iJ+p6pO4XRKczRtqiF2VnIUt5AOrTvjYci+wpH5fT8JUljStRXeofGHmg6qrrmNTtl1ZgDUIFjn8MzYBjdauKvkFWNqUeiJ4CNaSnzDkKJb83WWUnJd7p1qG4wbDiqbmK98ckYyjYb/r+x5Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv9hVnCS; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv9hVnCS"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9c7174e98so1363515a34.2
        for <linux-modules@vger.kernel.org>; Tue, 30 Jun 2026 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844681; x=1783449481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPwJg7/lHUDKrSM0fQ7J8rzHIXbUDq/PrHEAbbXxd6Q=;
        b=Dv9hVnCS0nY21zcwMWKT4Vu775JpMpthBdWbHwga0l6ZTig1hw812YhUK7syCXJYg1
         LR7Gq8Q4Y1bT+EuqUytXUornPBDhvUA1mCfniHABdMyijK2mV0F7PDVkRL9tsx5FUuvc
         GFgtrzu6LpTaeZ6UpHyjJR9vymXo167Ics9+94HQiKn/IshK7VMDF7/8dp4iIKL8Iu6Z
         1tlX7zqplluzjjr+06ab0Yiy9iTAnQymQr2uGR0YdByDNuolOdkxLOf5U/s1bhO5sKw5
         VzmBIZz7lRg+Ucp7o4fLmmseLvlsQUOyL1TKfdD6ABiLR/Cu5bze1Sp+8YW91vVkPEZa
         6OHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844681; x=1783449481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HPwJg7/lHUDKrSM0fQ7J8rzHIXbUDq/PrHEAbbXxd6Q=;
        b=HCKZasGMNglAuIywTFIauMThlg/+yyb/SEstDoBSCHUAgFsFJpTsyorC7KfHDIcX9c
         ED44DMCT8gcAwXrMzf072YjONCFW4cZ8IY5M/qFKHgHPnqn0pcTq+VZ0SwJPoNBqshC9
         ZlWRreoAwi4jvnTU1wPuOlPHGELbv6n18pPCvpWHjOtZSkiDOdA7ijWVRPyKq2amUOb/
         Dlz5ZFyxWrguLCEt3DiBE9z+wi1B1V3fW3V3RHrjx2g/aHkAIcDkBxYb0M1GFLN9HaQR
         w13CMBrMjrfXj098YXvLge3ZOrVM5XcG4+RUClIJvELyFM7pATzqoH6w00fg81ueQ+gQ
         xnEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uFBfV1iLc5/mLNZuJ0+i72MzSIHb5RlOQXpi5vDIb2fjn+mOJQVfr22MLIey3Mv6t97AOucjIKz1rndMS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7TKRN2Rv7hV9Llmq7hH+9V1b2EWwSndRzWsfTiavkEQEnj7d
	anFjPs5SoAtRoMzyyH9VrDnyi7wjJvz8gYRage2bJ8nEiJSyjcaxIGsLwMfUIvIu
X-Gm-Gg: AfdE7cle7du9Zaq/tUMXoFMg55pUNWKIHEN7x+Cq6/E8QQSpS3kgjGqvVDZq+rHXKbR
	VKjApuxnPHf1xHvgCuYIRnH1bW1/2TwlOy+qHgoOZsrCTBJIj8zVm/dehQzpsxEnFkU4BEaWTp1
	nWoWERs9Un778LZTxEYuKmBMpuZnrdx9NOEc6CNsab13pGbVRXgAZdzK5Zl+S9qnNWbaZ4/r5I8
	zARpDyeQXnwG82vU7paSBOYJX47Z4gtlpAgcSCvulExMuodIRbHNtLc/w6mv1lulKc20tU/DPt/
	G8p4QBQRIV3bGcf9PCKtWxgz+ZSuu6TBwqT1UUpEIn7t6xYcNlQBXrjOeZ4NO6EfpSA/eUzwvyl
	ZLYOJ/J9pXONdxPhvYFqkjYoaTw0qq3uJ7R8TRGHMoPPwRSJ1gA1+Lj0Y1pefu1C4Z8ghCVQo6i
	vOJ8dS2FhSMD+T6EsPMxPnBmD23nhK24TbryTUyJn+1d6XvsYDfJI=
X-Received: by 2002:a05:6830:7108:b0:7e9:b772:9aae with SMTP id 46e09a7af769-7e9fc164c1bmr1185351a34.23.1782844680909;
        Tue, 30 Jun 2026 11:38:00 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7e9ebfd6ccfsm2940025a34.11.2026.06.30.11.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:38:00 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 30 Jun 2026 12:37:50 -0600
Subject: [PATCH v4 1/5] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
 into bounded_sections.lds.h
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-align-v4-1-42e6ec883342@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782844678; l=4249;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=J+LsI8DAEpZU9ehYoJJiXmgZm0z02Q3FL0KHGdCUJp4=;
 b=QzeDQ0OqpqHaxEllqd4Taybev9xBLo9bV1ZbP9LEzQzrGnWp9PG+fW4SBiwSQVBvBGn8JFM9l
 QpA+XH3ptYsBzNyy30sl/ALLeNDP7j46VrgZ4DE+OUIThJB7hyTO5sx
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Move BOUNDED_SECTION_* macros to a new helper file:
include/asm-generic/bounded_sections.lds.h and include it back into
vmlinux.lds.h.  This allows its reuse later to fix a failure to keep
dyndbg sections in some circumstances.

NOTES:

These macros are only for use in vmlinux.lds.h, where the _start &
_end symbols are needed.  Modules keep sections separate in ELF
sections, with their boundaries known, so the _start and _end are not
useful, and may confuse tools not expecting them.

This patch ignores a checkpatch warning, because new file is covered
by "GENERIC INCLUDE/ASM HEADER FILES" in MAINTAINERS

CC: Arnd Bergmann <arnd@arndb.de>
CC: linux-arch@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v3: move include to top
---
 include/asm-generic/bounded_sections.lds.h | 36 ++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h          | 31 +------------------------
 2 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
new file mode 100644
index 000000000000..8c29293ca7fb
--- /dev/null
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ASM_GENERIC_BOUNDED_SECTIONS_H
+#define _ASM_GENERIC_BOUNDED_SECTIONS_H
+
+#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	_BEGIN_##_label_ = .;						\
+	KEEP(*(_sec_))							\
+	_END_##_label_ = .;
+
+#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	_label_##_BEGIN_ = .;						\
+	KEEP(*(_sec_))							\
+	_label_##_END_ = .;
+
+#define BOUNDED_SECTION_BY(_sec_, _label_)				\
+	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+
+#define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
+
+#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_HDR_##_label_	= .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
+	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
+
+#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_label_##_HDR_ = .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
+	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
+
+#define HEADERED_SECTION_BY(_sec_, _label_)				\
+	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+
+#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
+
+#endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5659f4b5a125..f5ddf31b7f26 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -50,6 +50,7 @@
  *               [__nosave_begin, __nosave_end] for the nosave data
  */
 
+#include <asm-generic/bounded_sections.lds.h>
 #include <asm-generic/codetag.lds.h>
 
 #ifndef LOAD_OFFSET
@@ -211,36 +212,6 @@
 # endif
 #endif
 
-#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
-	_BEGIN_##_label_ = .;						\
-	KEEP(*(_sec_))							\
-	_END_##_label_ = .;
-
-#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
-	_label_##_BEGIN_ = .;						\
-	KEEP(*(_sec_))							\
-	_label_##_END_ = .;
-
-#define BOUNDED_SECTION_BY(_sec_, _label_)				\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
-
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
 #define LIKELY_PROFILE()						\
 	BOUNDED_SECTION_BY(_ftrace_annotated_branch, _annotated_branch_profile)

-- 
2.54.0

