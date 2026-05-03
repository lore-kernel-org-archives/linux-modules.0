Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C762940DFCE
	for <linux-modules@vger.kernel.org>; Sun,  3 May 2026 00:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777766747; cv=none; b=SedMHbAXpoRK+VAyea/INqlRNNHWIMu7xtkoDxzBh6HF5RbxtoHuoAjcC5LR+AHbuu5HFJcoqyqPFWxsCeggRE1lQqmtaRaOxA0QKFTE3gwhFND+vhGNM7gWNOvMdZ+Ol1eajiDlXfdecewfT/Bbfi85UigcF3xHZ4ZnE8XNkDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777766747; c=relaxed/simple;
	bh=T4HdIJRhua32rXeeRFVONMGDwwZnoLvUq4UsJgWkg+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cgfOm4tCiwl4xupq4AbwD5QWFZjSXa86f8+bUtvvye7lKcmxmGo9IxxDs3u1+1sfdGZ3RDO3ArY+EcUZNt+XVKbpiPgkPtOWKSlDU56EW/pHA5CX8FH90jHDNUKZz/InODXZddQ9t8xyicPHbtNJu8tJVRRD8klIQuESi4TvVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtRcwoo9; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtRcwoo9"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d55b97f358so2254399a34.3
        for <linux-modules@vger.kernel.org>; Sat, 02 May 2026 17:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777766744; x=1778371544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+orEjBju94Wn5kqJa2iOEDSFRgssMF6O2tAVSchijk=;
        b=rtRcwoo9l9S/nrqJS1OjbtWNBiEQNgiph1Rw01lWHtY57Tk3uo0lyFcFM+RWAj7mJO
         IgCoKVxmndOl3fU5NePyxKYh9/PwXtONg9mquSdx/Ae3jipddZ5zd738kD/EJP8dSsYK
         qEtdeMcXL/FV1nskZka+Ov5FFR3hVZ60guX8PGwzPYs6jHrrSB4C9q7AMtE583vD4Mly
         Ba7eegMw8KYtKMAV+y17RZGfkVPSJ0WXt/mQ3vhyDpO0WLgT6HB9yVVew6xiG+ijL7JK
         qKMimgxNnlUBvsyH8kpQa5r4Iil/Qj4Qn/eNHHdLSJhNGCq6HZSg4WYL91Ej05ygkIwK
         SwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777766744; x=1778371544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e+orEjBju94Wn5kqJa2iOEDSFRgssMF6O2tAVSchijk=;
        b=QSbRv+7E3cksA69eHNMRrguyc4zLxvae0llim089gYaBRTxdRYuEhLWHJgDk2ep1hf
         5Gp2U5wZ/n+ixolE2Jh4wqQhAiQyn9TR6AEkH6p9nXPf5yF2WB/+oMJ1b4S9a5LfjyWc
         e2xu7KQTVjWwPn4cswWgU0FbZsncbfKC4iR1CCI7kD+L6g3JrfCiWHq057ofa41gDkfd
         jfEqaSiorRK9pMmR/HvyX5U6V7KegpSwRPvF5IPDGmGswhBPK+fn+3TsVohkxzXmfKBp
         ME7j9VEHazWC80bdsMSVN3fzWGeDk3ztvpDGU5qS6GETrClSHto2RLNPFYdp2G5+QI2i
         dJPw==
X-Forwarded-Encrypted: i=1; AFNElJ888kYETbMeuV+ItRuCGgD+eoDXb39Su+GsHaWJf8bbP4n75zqn+Z+4uEpo2vf4c90vGYcyYEQySC3gqxw7@vger.kernel.org
X-Gm-Message-State: AOJu0YzhBkBKS5S2DmPjq6+Sfm3N4e85Lv2IyWNrKfqZrr4Z7UYZDq0v
	FnIi3uo8q/9x/Y0y8QIJU1qJFcK1mUR0GzvfPZIz+msBCNGDvrLi5Yay
X-Gm-Gg: AeBDievj+TFyHOJcJbgQr+gtLwdbwNgqD3OCEFsAuAGPF8voFSJ3GZ3tybsdhOxGXRk
	Hj8jhGdKUz9Beurm9h4geVtyKXvHNaFqwlJpG82cVgx8njemhRTGt1pcZwQhkWwAng3LBPQn8OC
	LBYumgoJUw9LAslYdXy9ApLO6DVoXN/XSemXSRh/A0Oq5I7SiG+R294FtRqIYtviiOLuLvaCTY8
	wG6LtN4GmfZ+jvUPfiHwEj3q40e7z0g8oMYfcfJLMCx5gVDEa6YzaTsLulnkdEmZXyHp6Q0xEN4
	72eFOrLbMKYbhLh1MCMhKVYaaHNgUGwsvf+VdVjjpOKQ59mGvESBLq6tFe+aK159wKwdBDRXTPQ
	Q5XRmAMlRRQiUkXAeRYUMrnIrTkwy+pzTfXiYK0Xv16tPAJkZ3nGe95JQKcjEtUHYzDrYU+aJzt
	nfJxiMh+vdZzKWsOwrPiUIW2c+SJDcGPHasnUOLu7IbsAAF+ts2Aa3DxQiueVVYZDbGO+gf6pB
X-Received: by 2002:a05:6830:7306:b0:7dc:2f4f:17b4 with SMTP id 46e09a7af769-7dee13eb7ffmr2973910a34.21.1777766743703;
        Sat, 02 May 2026 17:05:43 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7decae2b090sm5379676a34.24.2026.05.02.17.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 17:05:43 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 02 May 2026 18:05:32 -0600
Subject: [PATCH 1/5] vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into
 bounded_sections.lds.h
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-asm-generic-1-v1-1-1103ee0152df@gmail.com>
References: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
In-Reply-To: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777766741; l=3696;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=T4HdIJRhua32rXeeRFVONMGDwwZnoLvUq4UsJgWkg+Y=;
 b=atZx++KLjfkDNp37NiY8N611XjrKSTFbGie9Mj6Jk+d75vNFomY1fZg96TsGq1flERLmjq410
 9KaoS6EEk2PD9rD86N56RBhUJ5HsrEKvzQaf6hkz9YmjiSI2qr7lLWf
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Move BOUNDED_SECTION_* macros to a new helper file:
include/asm-generic/bounded_sections.lds.h and include it back into
vmlinux.lds.h.  This allows its reuse later to fix a failure to keep
dyndbg sections in some circumstances.

NB: this ignores a checkpatch warning, because new file is covered by
GENERIC INCLUDE/ASM HEADER FILES

CC: Arnd Bergmann <arnd@arndb.de>
CC: linux-arch@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 36 ++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h          | 30 +------------------------
 2 files changed, 37 insertions(+), 29 deletions(-)

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
index 60c8c22fd3e4..f78300aea8f6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -211,35 +211,7 @@
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
+#include <asm-generic/bounded_sections.lds.h>
 
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
 #define LIKELY_PROFILE()						\

-- 
2.54.0

