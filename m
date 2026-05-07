Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9C321445
	for <linux-modules@vger.kernel.org>; Thu,  7 May 2026 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186417; cv=none; b=T3V/UXtd9IxYVns2amO497P+DDSet0gAF75SOt+XPjndtDYw3xN6eLDeJwACayMdAJin0sFZA5N9i6G63e6+X7NlMb00QCw509MNIPa82iVPqCwGnzkHMyYkjaHA+4rK/9X/1im5uadqWDPaWOQNFenPO9EZof+yMoTt46ispHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186417; c=relaxed/simple;
	bh=w53HDEgESySdIPfpqzKI102G+UmjiRVHYgmkoAG2z1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sxHg7ymXpXilyavlB0m6VafUhsuJDpR+Llyt0s1bDyFl8oSgm781ls+anKDTsPhtrJD4LxlcZKrsuQJvUCIV+t9fPczSSWMBJ1DirYBKJcR+v0ec5KcXknRO0k+YlYlKMlApP3pONslOv4LRkqm8u3qYaqWtzLiv1vGiBAg533M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O34ACNih; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O34ACNih"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d146705b4so15882545e9.3
        for <linux-modules@vger.kernel.org>; Thu, 07 May 2026 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778186414; x=1778791214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+93DjYsz56GAfnPLw0kj51QsdMy66v3jRgOgDGePzc=;
        b=O34ACNihMz4IPYrdx/3RXaUHiMmdzuIxzd7Lg01A67rbir5IPcmZyXbEGQkZ2ZhJRH
         tWSeUiyA2vV0WP1TpnWo6pbfy/RTyToKGO0yhUwZ0oXU4P2F2IMNUFbd4YlEFzYV5vW3
         +HheiR0DEiZcMql/JHWzoaAB+qxxmGSnzg0PaFiz/Bm2nQUiY8EDyDYSz42c57hn3nQX
         AReueSlt2ZdyeoaCCPdtZ5l69h+1siWQdhN2d8AOrF7dRI28JpO0K2demYpbHvNJ2xCF
         wWJihp1Z8EpHpOrkYueOLiuGhi4lmnVVLAQxHgJ/lgOypOKdcV2shVWBQmS1OKvbwTRj
         sr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778186414; x=1778791214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k+93DjYsz56GAfnPLw0kj51QsdMy66v3jRgOgDGePzc=;
        b=jugICLkBnIix8ikxBtlrpQgV3vVqlYXbwOmZ4zKWJyj6N4BIf9wS9xGw6eAe/5S+Td
         O2oiDxn+xW1apE1Dh1NdkY3POyFKuiz2NS0Fj2iHhIJT5abNQ9Xh/++nM+aHMCJ4wahy
         pLxIvD0c8nHqQjX3HcRH0vgabpmrFilaD8cxa6b+SlTziHBLc+u7AO4LlPzaBpLpHOAf
         dkHUbFctwGC2hgtUwaQv291YevDxb0C6BUmeLEpCYdoCCDe5QgFtBY6PpgiC8r1tqFzl
         ThTF8/jWGdGjLU1JtGeuoDoUxtsCP9fvwe0lnw0Gl3ihxByFmW38EdzLQbpPGuJhl3TQ
         9hlg==
X-Forwarded-Encrypted: i=1; AFNElJ+ouZv3L8ASoyIbqP/lUTCO0/44QGnM0T3cpTOMjomzFwx2TiJKzgTTY6SswQKSGx5CXanP2ZaWAh2tzaZg@vger.kernel.org
X-Gm-Message-State: AOJu0YzalrQ+RuslP+SBQlaFT0rZC1D4lAaNojQ/MfnDhuf3U2d6RpOY
	80MCeFM130mWopTZ7BAqhM/LX+XuEwD+scmX/IoWOimYz/+0gvCsENV1
X-Gm-Gg: AeBDietOYb6mkj+ShoqEXkrqxW58f4ToSkNEkFalMOjpo1utK7AjKbg1m9P6k1GRN9p
	gzucDIWa0H1G4VYFniRJftRpUxoOn9inCl2Ak9kxycBDeRkoCV47CQnzk32WNRg6VGjqUuq29nW
	E8rtdJ8aEFrR4GO7/EtoJdAAFom/dUHxOuoyN0ya11LSXHIK4RYYa2oDbAAwzMIflHMDFE5j+cF
	EmkXtOzA+30BKEaSiza7diSsFyfXa4+J2ubT/Kn6pXB7ot94N6ZZNIlZbYvhC6W6jvEVfwPB8td
	UzDlrOu8om4KagjVspVPNRUgzxUsuF9iFp0wzF8wPrXxU3a4zQancvTYRwkh2bszLzmA/tWiVcI
	57L3RYQ962ZDqGjvhvPMiQ3dt+mgdVkgLhBXqSqYcXrUgwaBQB8RjXusDLzsliVi2ZUs6eMf/UM
	L6nXxIfBawwW+8kTqKsKtVQMjxyNRwBcXSBZeBPxs=
X-Received: by 2002:a05:600c:4f0c:b0:488:9fb7:376d with SMTP id 5b1f17b1804b1-48e51f59fc5mr151007445e9.28.1778186413571;
        Thu, 07 May 2026 13:40:13 -0700 (PDT)
Received: from [100.82.231.29] ([185.57.101.106])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48e5382a327sm264367515e9.0.2026.05.07.13.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:40:13 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 07 May 2026 14:40:07 -0600
Subject: [PATCH v2 3/5] vmlinux.lds.h: Fix ALIGN(8) omission causing NULL
 ptr on i386
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-asm-generic-1-v2-3-47c52759d268@gmail.com>
References: <20260507-asm-generic-1-v2-0-47c52759d268@gmail.com>
In-Reply-To: <20260507-asm-generic-1-v2-0-47c52759d268@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778186409; l=4451;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=w53HDEgESySdIPfpqzKI102G+UmjiRVHYgmkoAG2z1o=;
 b=jRSS5ScKlTQ6pRNXBqypd33porVG3AuxID0KwFrnH3r9J2naU/yIALxUR2JxeNxc14Cj6nUXq
 aq9uhMfSd49CorBjCjgpKa4xTh1uBh7TMAxgiXLjWK84zRJwb4eLti7
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Almost all uses of the BOUNDED_SECTION macros are ALIGN(8), either
explicitly, or by being below an aligned section containing x*8 byte
objects.  The noteworthy exception is BOUNDED_SECTION(__dyndbg), which
immediately follows BOUNDED_SECTION(__dyndbg_classes).

On i386, struct _ddebug_classmap is 28 bytes, so without an explicit
ALIGN(8) in the macro, the following __dyndbg section gets misaligned,
causing a NULL ptr deref in dynamic_debug_init().

So fix this with an explicit ALIGN(8) in the existing BOUNDED_SECTION
macros, and introduce _ALIGNED variants to handle the cases with an
explicit . = ALIGN(x)

Explicit alignments: EXCEPTION_TABLE, ORC_UNWIND_TABLE

update BOUNDED_SECTION uses inside . = ALIGN(x) to use _ALIGNED
variants, but keep the outer ALIGNs so the symbols between them are
not "re-aligned".

In particular, scripts/sorttable.c does not tolerate sloppy padding.

At the top of ORC_UNWIND_TABLE, add . = ALIGN(4) to match the struct
orc_header __align() call in the code:

commit b9f174c811e3 ("x86/unwind/orc: Add ELF section with ORC version identifier")

Suggested-by: Louis Chauvet <louis.chauvet@bootlin.com>  # _ALIGNED variants.
Link: https://lore.kernel.org/lkml/177402491426.6181.12855763650074831089.b4-review@b4/
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 17 ++++++++++++++---
 include/asm-generic/vmlinux.lds.h          |  9 +++++----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 268cdc34389b..8ff3e3420f60 100644
--- a/include/asm-generic/bounded_sections.lds.h
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -3,19 +3,30 @@
 #ifndef _ASM_GENERIC_BOUNDED_SECTIONS_H
 #define _ASM_GENERIC_BOUNDED_SECTIONS_H
 
-#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+#define BOUNDED_SECTION_PRE_LABEL_ALIGNED(_sec_, _label_, _BEGIN_, _END_, _ALIGNED_) \
+	. = ALIGN(_ALIGNED_);						\
 	_BEGIN_##_label_ = .;						\
 	KEEP(*(_sec_))							\
 	_END_##_label_ = .;
 
-#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	BOUNDED_SECTION_PRE_LABEL_ALIGNED(_sec_, _label_, _BEGIN_, _END_, 8)
+
+#define BOUNDED_SECTION_POST_LABEL_ALIGNED(_sec_, _label_, _BEGIN_, _END_, _ALIGNED_) \
+	. = ALIGN(_ALIGNED_);						\
 	_label_##_BEGIN_ = .;						\
 	KEEP(*(_sec_))							\
 	_label_##_END_ = .;
 
+#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	BOUNDED_SECTION_POST_LABEL_ALIGNED(_sec_, _label_, _BEGIN_, _END_, 8)
+
 #define BOUNDED_SECTION_BY(_sec_, _label_)				\
 	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
 
-#define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
+#define BOUNDED_SECTION_BY_ALIGNED(_sec_, _label_, _ALIGNED_)		\
+	BOUNDED_SECTION_PRE_LABEL_ALIGNED(_sec_, _label_, __start, __stop, _ALIGNED_)
+
+#define BOUNDED_SECTION(_sec)   BOUNDED_SECTION_BY(_sec, _sec)
 
 #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f78300aea8f6..d3f20b411e16 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -641,7 +641,7 @@
 #define EXCEPTION_TABLE(align)						\
 	. = ALIGN(align);						\
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(__ex_table, ___ex_table)		\
+		BOUNDED_SECTION_BY_ALIGNED(__ex_table, ___ex_table, align) \
 	}
 
 /*
@@ -833,16 +833,17 @@
 
 #ifdef CONFIG_UNWINDER_ORC
 #define ORC_UNWIND_TABLE						\
+	. = ALIGN(4);							\
 	.orc_header : AT(ADDR(.orc_header) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_header, _orc_header)		\
+		BOUNDED_SECTION_BY_ALIGNED(.orc_header, _orc_header, 4)	\
 	}								\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
-		BOUNDED_SECTION_BY(.orc_unwind_ip, _orc_unwind_ip)	\
+		BOUNDED_SECTION_BY_ALIGNED(.orc_unwind_ip, _orc_unwind_ip, 4)\
 	}								\
 	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_unwind, _orc_unwind)		\
+		BOUNDED_SECTION_BY_ALIGNED(.orc_unwind, _orc_unwind, 2)	\
 	}								\
 	text_size = _etext - _stext;					\
 	. = ALIGN(4);							\

-- 
2.54.0

