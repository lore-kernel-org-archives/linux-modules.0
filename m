Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E83CAA52
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440505; cv=none; b=lV85bnXzCxysVMhchyL6D5XyrAul3jGvglqBsA41uWwqNiUFzVr+KkQBKkpon8aokd2r2AwhqoTH+RJ5nzM46ghFZD8VecppaT2rSkrFL9E+R6ZUzv8Kzb3InNCAvPRJs4rRzSHpKUMA/0Ba3/snISHX1b7AtbKDJn8gAG5ApQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440505; c=relaxed/simple;
	bh=pg9cpl0bo1AtFElQETrwEKQ1mUnu0drU6Mzj79jx4XY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o67rGKb4rmeKb8MyBD4uzorDqaYt26NOQa2iqUPxgsz16+YqJLeYQLEEvoqAtIROvcTYoeFsUWG5KPDDb3tnzRfqZS0Y7o9yku2tqmhGSBIaD+ySLgR9HBVLzp8hzgsKcdI1Eat5T/ECHKVnImb/hCsywyhxJHsJ7CefvNWy0tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBFMYl0c; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBFMYl0c"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49041e84237so450075e9.1
        for <linux-modules@vger.kernel.org>; Tue, 02 Jun 2026 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440499; x=1781045299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgjU2Qt2uFal6066puOiKcG/bH5c3F/sQ7Yrgz0f2yo=;
        b=JBFMYl0csfWsyVAWBMvOQ+IbPkuhDsGXQrfztSt9iJF2REyqZr4T1EiPEL34fqbH51
         ONthIVFW5w44iED8xABZaOBMvANhB++pZFqX4/jsLGIu9FNJ9TdqsEKNWJ7uTng35aBY
         w9ZhbpOe3bS6VAbDFgJELS4aCexEHd+oKHEkHDf6hxIQo0PAsmb/qWUd4q7IBT98E/PD
         5ujv4TAnZa8U9RQosp40dseGaN3Wwgz3z1IXRXIcD3sF7Z+qgOk7TXXCD4hkAK4vV5TN
         qNvN4fdPaDbbcVbPVC40oaIVK8iBkpA87JYiN5rIgShFtgtTVLT8f4fyCu+ofll8QHiI
         Ad7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440499; x=1781045299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AgjU2Qt2uFal6066puOiKcG/bH5c3F/sQ7Yrgz0f2yo=;
        b=tUMiyfiuEcykkdd5SqimIjsT/5dfUW63qB4fQCEJMjlQBx2j3z2NVzCEFk/UIqOFoo
         oJGsq1vW483r9L6BeP55LfmAq0mG71cIfS7sNSwrgABxcgZg9AtvMUXLuKsm6EuLwKab
         bt7kozMq9QEw/ch8jn0HIX0C3Bcol2qWO3DAiC6xTNOJsULa/oWflZF9Z8j11pX+eVNF
         SiZb9gaTMcV3wWrQbD/rVK8aTX2FFt8/CVwevkS0WPEmux8vZu5SmjNxjORZU9/AZiR4
         aOyk4vj9DrWYgZLiF8CCLs8HAieGrv9PPuyd3b9E9tdtRlBGDUBBQsXUlMwzxfwcB+81
         fXXA==
X-Forwarded-Encrypted: i=1; AFNElJ+QAOMCHZvq+oGeIhLS7Tp5PHbrp2mDzi6feYrn8fUaMD+VmP8jQ9Eboz+dnZyG+DPn7rWRoLqOvYddU+i7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3B4dX4eckpPw7lr/hr0ySkoUQDqxM+JSGrWq2+6ipBP4BWlp3
	8PUDbRwhVqkkozZTL67wQW5O/V4s8Rrn/A21RiaFXky+Ld6f6sY1ntseOuWzFw==
X-Gm-Gg: Acq92OG52QX5CaEh70pZrHp23cy3VJ1o+r3+fN2QLwtg5FQCbYT8xUR4YM+y9p+53/F
	k14FPBo49JdRMms+BWrYlc0iRIESLOre0msgnmXNDqZxKmSGeHLIrIzI+J/SZGFqsNGKeaGvdxb
	UmQF/EQiCG+9sASBG5w/QTV9jcBlKCNzyu3Bk7iw+Y/Q5fjPTb2dSfLhFEiYjS9/EDUT9aHpguK
	fnD9i4ojXLIjFTP9HsrZ9OI2SC0Lxo7f1cT2y5nx3nAiCyMsUC/Q+Y/JolbHIAo/bNg/DnE8AF7
	BZWW8jFXRr2MTZFlFIxFAfxbGcAPiIFSgEF9XYR1e0n7tS+BW3AHOFO4/nJx9WLc1pGwk2MiV8Y
	+9E1Yd5y4wAS/Rj6H6+B3YJpW0RHnkygZsuQMhthQRduIpgJu/Zaj7c4GIcO6ebip4zzNjhanKQ
	9tBKPrt8f0hAHdSqMLayQm1zhD759ljugyahvckRd9aw==
X-Received: by 2002:a05:600c:3586:b0:490:b080:4835 with SMTP id 5b1f17b1804b1-490b5ed385fmr9521615e9.0.1780440499499;
        Tue, 02 Jun 2026 15:48:19 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:19 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:00 +0000
Subject: [PATCH v4 03/25] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
 into bounded_sections.lds.h
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-3-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=4249;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=pg9cpl0bo1AtFElQETrwEKQ1mUnu0drU6Mzj79jx4XY=;
 b=PCbuEwQZdW6szL958qPtN2q+zMt4zTLcoGfE6vSsy9ddJg9N8GB0rMqs9omnhc5qIM1axWwgb
 JWqDFwcoyPoBGXBOz9hnvLRwlK/S2RSIVu0TO650z7JAaGNP0niqcfU
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
index 60c8c22fd3e4..9c61dd083f26 100644
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

