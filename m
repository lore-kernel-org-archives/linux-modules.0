Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633943B47D6
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477115; cv=none; b=gJGnlym7cDk47sVji7dzGBLVhBRwrYbrKcBV7wj1ig/ht/uLPo/WvTB75pOXm/KEwJdaH4r9qo6YV6Z+fEsCyGBA4KvSzhI9wZvaqvSSmJV1/oSio4oyBNUXfVz6OzssSV6EHeONW40H00BYJLCaZTltthW2Umy9UvCSTF4n9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477115; c=relaxed/simple;
	bh=QueupzyxzXlW98TDU/wAHIfrNHSSKLlUADfdJDWgXvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PYcWVotZ/b7lB4R3Qaz7GvIg1h3Ee0Idcsd9d20MbZYAxxWwx8qx0iRsoCCYadkJNaxpXsbP8uxeYuxgAo/23M2waxKpZ7Ngp55KxF+CoAL5qnSO07a3zcqXgfppzzUATwzA4L+t036SQ24oxpviJE6LkrDzXWNZZO7mwqOt/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/Lqb/nb; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/Lqb/nb"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-489f3611e0cso152793b6e.1
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 19:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477110; x=1784081910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XBRpGfG4W3fZchgQTQabu+BeyUteD2r7DyZgoEWDq0=;
        b=V/Lqb/nbtqBMzLxJQkp24+vBn17Rg+i3BGev2h5RKIt+n4TKMKT3V485a2p2NUqFo2
         GFWcGjtXHqY+/n/sfx3eetFC4CyeFH31hPvjIQgQpwFwlLt9d/aG2Bxt5ym2vlWmnK5W
         KuWO+Xbc9O5CYbmoPv+iP6KeN2HSjCus6bGx/c+eiI/jQDvGvRWNCKAXjZ8bhOmHGWXm
         B8Wsk8/aiDoACYpQmQ/+1nuaOJ1oDsZnfLAkdufo/mrRxhCVnZlMY6oLCTL2QKlu4o8r
         XO6E4syNDHXqcXgsynWylWMTkZPizRw0hfhgJy4aZta6O7KPx2PQKFggs/dcC6ULU0oe
         fkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477110; x=1784081910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0XBRpGfG4W3fZchgQTQabu+BeyUteD2r7DyZgoEWDq0=;
        b=A7SjJv06osauCS3Du56msV8/KWspyT6y4mp96oawnR75qJYK979ko+gp5kT2b/R6NV
         84Jvx362ZqXZgAKtYRt4VHvzLU1zTqpFL4/zh9Ek0FQJYkBFTa4wHcg5LrLiM0DxQG6h
         U5S5+GMVbdYpqs8qPlhc0d+x5TzZhopaQHu7zK3lOMEVdNV2+B+Cng6NrA8KFcm3PMXo
         DaPJul8A+X2oPiCKy/lXO3U9ubejQr/8KxBGDjcfNDcoq2mCFpfvax6tYqfdsf7aWNj9
         Z+43b2nmgex978zRPpxo25dK6wkiSdKxFExhNT4xH0wYEonqmGYGBjSud1Wo5uuNC7tN
         dUeA==
X-Forwarded-Encrypted: i=1; AFNElJ/+3pXkb+mAa4ge0SuBEeCsUJIIN4a7KJ3tlbIWBRL6Qwbbax0mj60DUJEDiSn1CoLFCCswZ5ZHP5rHg/sg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzns//+CEqwJgwLY1xI1qeeR5Yz12BE8xnqBr7hxDvNRNesYyB0
	nc8kxnA2hrVSZBIF3HBwowwnu5GaBq8dMzeNeSkreXnWM47uLgbOJor9
X-Gm-Gg: AfdE7ckbarkmYJaKGfSQCA4fuHNzMtV8cUECvI2Mf85zaR2w3S+M9O7ZXlNNxiscAYW
	MRo/2mOTl8JCOgW+uCsWoLz1cQYEp6HjSn2BnRMHlhgrpkjDsrNZyp4zok41fjaUQrj8cloKfvZ
	pAebQj+PpwW+b2YlYoshUDs5kTIDixns9XCzq4gnwxnPCWXjE15DglBnP7dZf7KjHbUZuoDpQwQ
	RmkNl6qXw2XajQAbeBmxoGDA6cBszW4Ps3yY7jZW+jqpQGFyp4FqKXi+oHcFnswwi7owcRATX11
	dVWmtAwD+ttpyxI9shXzggqujP5GkRtIDRhtVRTih3PDLL8vRPQW0szfMxVyxGFyTwvKI52h9fm
	PV9k22yCeaY+S85zSefQrqTm8PMmZIlOEBvEk/mVHCG5AEaNRU7uwFKSUomVOoewbTG4WHvj4F9
	tKAvFSKgweg2b6eTmXswoqbCSyhTCIiXJWmQgVcXj23n6W4dUVcpk=
X-Received: by 2002:a05:6808:30aa:b0:4a0:97bc:53a3 with SMTP id 5614622812f47-4a20670914emr451551b6e.36.1783477110287;
        Tue, 07 Jul 2026 19:18:30 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:29 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:03 -0600
Subject: [PATCH v6 03/24] vmlinux.lds.h: Fix ALIGN(8) omission causing NULL
 ptr on i386
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-3-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=6221;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=QueupzyxzXlW98TDU/wAHIfrNHSSKLlUADfdJDWgXvs=;
 b=O2SjRmv6pTiy9rk/JYhEFYvjF/zz+LkmoWc2ap19OtrhuRRTgVBrJrfTWlX/twdMFZgrvaa7d
 TQyZikVdZymBzpcpn5xXoqYZsOa4q9xSbbmv7OwgKm04QmRW/VOkAO2
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

Also add explicit alignments for: EXCEPTION_TABLE, ORC_UNWIND_TABLE,
TRACEDATA, INIT_SETUP, and NOTES.

update BOUNDED_SECTION uses inside . = ALIGN(x) stanzas to use
_ALIGNED variants, but keep the outer ALIGNs so the symbols between
them are not "re-aligned".

In particular, scripts/sorttable.c does not tolerate sloppy padding.

At the top of ORC_UNWIND_TABLE, add . = ALIGN(4) to match the struct
orc_header __align() call in the code:

commit b9f174c811e3 ("x86/unwind/orc: Add ELF section with ORC version identifier")

Suggested-by: Louis Chauvet <louis.chauvet@bootlin.com>  # _ALIGNED variants.
Link: https://lore.kernel.org/lkml/177402491426.6181.12855763650074831089.b4-review@b4/
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v3:

sashiko complained about NOTES and .BTF_ids.
gemini asserts that NOTES are natively 4-byte aligned, add comment repeating it.
.BTF_ids doesnt use BOUNDED_BY, since start/end isnt needed;
sashiko evidently got confused by immediately preceding usage.

v2:

sashiko picked up 2 cases, added to the explicit list above
https://sashiko.dev/#/patchset/20260515-asm-generic-1-v3-0-680b273666d4%40gmail.com
---
 include/asm-generic/bounded_sections.lds.h | 17 ++++++++++++++---
 include/asm-generic/vmlinux.lds.h          | 18 ++++++++++--------
 2 files changed, 24 insertions(+), 11 deletions(-)

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
index f5ddf31b7f26..f29fc079e37e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -640,7 +640,7 @@
 #define EXCEPTION_TABLE(align)						\
 	. = ALIGN(align);						\
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(__ex_table, ___ex_table)		\
+		BOUNDED_SECTION_BY_ALIGNED(__ex_table, ___ex_table, align) \
 	}
 
 /*
@@ -650,7 +650,7 @@
 #define BTF								\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
-		BOUNDED_SECTION_BY(.BTF, _BTF)				\
+		BOUNDED_SECTION_BY_ALIGNED(.BTF, _BTF, PAGE_SIZE)	\
 	}								\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
@@ -832,16 +832,17 @@
 
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
@@ -869,7 +870,7 @@
 #define TRACEDATA							\
 	. = ALIGN(4);							\
 	.tracedata : AT(ADDR(.tracedata) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_POST_LABEL(.tracedata, __tracedata, _start, _end) \
+		BOUNDED_SECTION_POST_LABEL_ALIGNED(.tracedata, __tracedata, _start, _end, 4) \
 	}
 #else
 #define TRACEDATA
@@ -898,13 +899,14 @@
 		*(.note.gnu.property)					\
 	}								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
-		BOUNDED_SECTION_BY(.note.*, _notes)			\
+		/* *(.note.*) are natively 4-byte aligned */		\
+		BOUNDED_SECTION_BY_ALIGNED(.note.*, _notes, 4)		\
 	} NOTES_HEADERS							\
 	NOTES_HEADERS_RESTORE
 
 #define INIT_SETUP(initsetup_align)					\
 		. = ALIGN(initsetup_align);				\
-		BOUNDED_SECTION_POST_LABEL(.init.setup, __setup, _start, _end)
+		BOUNDED_SECTION_POST_LABEL_ALIGNED(.init.setup, __setup, _start, _end, initsetup_align)
 
 #define INIT_CALLS_LEVEL(level)						\
 		__initcall##level##_start = .;				\

-- 
2.55.0

