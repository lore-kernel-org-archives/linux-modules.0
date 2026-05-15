Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A180426EBC
	for <linux-modules@vger.kernel.org>; Fri, 15 May 2026 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835508; cv=none; b=HIa+1YhpdQ4mjCoC60cBv0dARBH4AzvzjSHKhyEOhd2l/YFo7bFpNQW60ldIg3WggdH9PL356JUQf5PPMQLFLV5nfstS9NfH8AW2A/7kGQypqWH0hER64/fXoARlsM8CiM485B7HWCSIfQHlVR4ISw3UH44q/No4cKeDCkaWwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835508; c=relaxed/simple;
	bh=pg9cpl0bo1AtFElQETrwEKQ1mUnu0drU6Mzj79jx4XY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OUdKQ/yBfhThgo0Buh+ZWnxjzuYnWNlVaftkeIBLuix89kfIAHKeeXB7HJvuiLZsSb56bvriCSWLLRbMTV6Z4ePccyJ+0zLjh6770sgmVkS8VTmF47YpfqLSnoQT+PVS6gkzA/H4VASzUS5V1WwetIdY5xc0vH8lpwAztG+Ahn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6tKe9od; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6tKe9od"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44b052142e1so4981789f8f.1
        for <linux-modules@vger.kernel.org>; Fri, 15 May 2026 01:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835506; x=1779440306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgjU2Qt2uFal6066puOiKcG/bH5c3F/sQ7Yrgz0f2yo=;
        b=L6tKe9odUYOe12UFe5Z3atpqr+ybXcHgoHcMBRF1L/sD38/3KOzhCu/8P2WMyieZEo
         UTfGMQzPgWwmybeuxP8WWJY930PQZtEeyuyfr3lfGxY98WEw7qKeQOV4YA7lCIkEZmgn
         djWNCDJwYLU9gp5/v/dVzq4GuPw6UZI6W/brmYCle8jYcPBKri/jml0iV5N4yTE3osQA
         KgcdTHXnE4QY3lB1AtEdm4AzVh1Q6qIAxCnXL5tjGZbkNZ1JVvxsymA8F3ieO0YXiJQK
         4Fk46XibwP72XsE4u5/R7sHCl0Nx1F6rAAmgG6OIHj0KDQJeEJQxmi77fW+dolZJZ0Es
         n80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835506; x=1779440306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AgjU2Qt2uFal6066puOiKcG/bH5c3F/sQ7Yrgz0f2yo=;
        b=qFCdzuHEpFeM6++MjKYHN9HCtJyxs5WGHakUdzKx4vV6bf/ZYcbq0kkIPhfuHu9Ipa
         6NeGobPK+jhQqt/fQa1qVcp5qKvMum3ymQ5HqpjiP4R74Xldx/L1g7WLj27Oh6zHdTUj
         ADWGEIMZ4o5vQ5nAZitnGTrYOm4GPWYbq6FAe4xgG+lR3rDn7JKCXKtG5olHzR7bG0kG
         uq289jzlTY6l9pRObcDreQjwUkeOh8g7Z2Ij6na5fgCVHo39I7Vo42XPxwYrASkj7Y0o
         lVQf24TR/xrdtftNi7z6+uoWBJlX5lravaev/9+psYEnIGMHNs5rx4F+LDpcTL/+wMSK
         z3DA==
X-Forwarded-Encrypted: i=1; AFNElJ/KVdE3Lxsk1mUjxNb+wvqoyzXycCpv/57EPrroAslrOP2VHKHPX5DrA4ms3iVAzPxTn4Kr2ikSx8TIjGgM@vger.kernel.org
X-Gm-Message-State: AOJu0YwNm8siMd8+6FKFcTG9D0cyJLaZjsRip23Hrhsb5nsOiJ0N8hTZ
	9scdQkQIPmle1dWXIc044zqjm6QWNBQuZSNyCrVb4HLoLAhbcaT95S6L
X-Gm-Gg: Acq92OFwsvR2pY2mjkzdwzsDPL/CzvNKfikvJyJIK2GYZo4bnFl2KUP5l9vdpRJ5yWc
	WgIXA5rTNVKBsywS0CpWfpwjKvU0It8gycWD3YdKQwx+7n2aAFp8p8Bf94OPNKWnU2z061vsI7M
	qJeWjhfp8g5+ktqqhtqme4wVMuAdIBOkjIJoTnBAr3INK39++d/XyMj/GY4FnmWM7F5SSdM6DT+
	/CPrxPVsw/rsu3HV228cj+fdLk1s18RqECkCQhK9UCVEyZGfy5+DBt4HKV7Iy12nfWZeXT2K2hA
	LMOK2m6zxODV6p5W7vS7jhfd2/Bc7+FkEZNXPHXVIqoA/uoE5Z78g70aSWX49kyZ6lxm/Ya/5W6
	4zbmSzDxpkJScdHPm2KC6mLWKQ4jgp9y1GjbeaFcEgaE2f3rdcBlEfjvdkO25tr81+N7SD7ZRVB
	PTe6M6vevh834BOrP64R8F1mFF7MJR/V3j
X-Received: by 2002:a5d:5889:0:b0:45e:5b92:1e45 with SMTP id ffacd0b85a97d-45e5c60d55dmr3656820f8f.40.1778835505710;
        Fri, 15 May 2026 01:58:25 -0700 (PDT)
Received: from [192.168.1.210] ([2a00:23c8:33b9:3b01:f7b1:b7a0:6254:c325])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm13142610f8f.8.2026.05.15.01.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:58:24 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Fri, 15 May 2026 02:58:10 -0600
Subject: [PATCH v3 1/5] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros
 into bounded_sections.lds.h
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-asm-generic-1-v3-1-680b273666d4@gmail.com>
References: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
In-Reply-To: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778835503; l=4249;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=pg9cpl0bo1AtFElQETrwEKQ1mUnu0drU6Mzj79jx4XY=;
 b=UDcB0IA+uJ7wRttA1XdEmqAlGqtAr/TYTORh8uXa/ljuE9kcGbu/8l+g4/1/jRM3kY4vjLwSw
 c7LctSEq/n2DMZO9tKi+XB61IRdc9hFqaSOqyA4G5H31nLX6al8Rt29
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

