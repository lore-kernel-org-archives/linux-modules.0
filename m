Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559AF429815
	for <linux-modules@vger.kernel.org>; Fri, 15 May 2026 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835513; cv=none; b=owm+V93Hwt4B6rfp45JnzPnVsk7EJX2pnmMtfyJxx60CwVQfQHFVlPHtdpGzH9EX9m3fX88pUdwfFsG7ZyibY4QvQVG11+ttKnHfn6xVq/ofTRXBqL1/evgMOJizvkxn1SpEjpTpsdhJVCV8/C3NeYaXFXhhmTpwhI09g4WD3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835513; c=relaxed/simple;
	bh=NSY+wy4a9um1N1lW6bfsaEQo0J9IZ0qw+K4qR7XW5p0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZWAEohP7gRZjVnHbQZiGjV7nLE0oGCS8f+ip5Adj7Sj61rlzgVR0zH0TxOonCzMomFr6VPY+cBX+1QsFOWKlcRO+fOMKfpnm31uupRfCBoavK/CafUB8Y38/8iNa4jF9uz47myXFDqDkaG/LNTFgqwmXIFZ2N9b87mE0UB9l95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGxeZVJO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGxeZVJO"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b0046078so72145305e9.1
        for <linux-modules@vger.kernel.org>; Fri, 15 May 2026 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835510; x=1779440310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeHLaAh47MPke7rCXxz6cz21C0/tHZ4OetnIzHSea3A=;
        b=BGxeZVJOst0uJxl7qzwFEi8QmH/rGDuPCV0Kq/WCENjY+DKZaqT6eN1DqQfgICSLbw
         zqXPj1d8PkGDHt7BATKn3y9uCMc9NUcaGdfApF7cQx0Dn90DhmhhnD+GfAbKigbBYS0c
         38+XfDWPwEOuVuKH42Iu0AlHzsjvdSOwQccq2sfEIqKxz3VNm2eNYBN8V1iqlbtGSQpE
         BTvEznOVjL6cebOl8rAnjFlZbCAMNWMHhDl1X0Kv9X473EzJ6qNa7Vh+tPeD0+m/pEQe
         GIgv1DCToN1L2feVvvT1O+e0s7zfBG+59A13Bgt/5gY7H+047c4mhhWBUCVD90itVGBe
         WcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835510; x=1779440310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zeHLaAh47MPke7rCXxz6cz21C0/tHZ4OetnIzHSea3A=;
        b=IpaRxmTgpVGk0infRqNT5S3mmkHSGnsEgscUMbRbYwZTFMV7YOizbOhlP1bQ1jTuDY
         eCamOU4OsgJCUDzuoCCDfbszVuHexlgoS1Z5TXNWjYuGHKRn9vraUIB9EpeE0TWwfSD8
         HZq3140a4Xo5gANjmGRwGhLZQ3S7K6KK3hvvs7D3tkyG6Cbzfi9lw6q9Lg48Ww1K0WCn
         2mgCoBYzNiu7rS3Wi8VRZArvh0T02k8bu1sL1+UvR75tstkgYom6jJ18kosnNeey1jg1
         /Da9L3RJa4AMnBCIU/rj1yJY1ZpdphmHx4Fnp3jfdDdZboMF29xcvhwsPJaE7oMMGaUX
         3M6w==
X-Forwarded-Encrypted: i=1; AFNElJ8Tp1JsQpBlil4DUAN3OU7Qh3LTL4s47go1mAGL0xEjoc4spfXSox+jMPZ9FUZA0KuTGaN7ecHBlhoZ2Uzy@vger.kernel.org
X-Gm-Message-State: AOJu0YzjHjv8Fd3c6wS62Oc/gV3JEd8kqKrehmwO+CFM6GFwE5rzRajw
	44z7e5mkkDj049Y1VTOjzz30CLUBrb7fTlnSqeaTogeCP6W0LWZymCZJ
X-Gm-Gg: Acq92OGi3aL0zdqxEhpvVamiLCYT/SVB/fwNHZP03nHY2u9zbt4Ksurj/uwaDB87npq
	5NIjq4bXTWBTK6TD6w7Gg02+q+cCnPdVmh/Lol3vTpnDIROOfVgnDwi7YOdV3Lf5L3h+8FFgyyv
	2qK8M3z/lR5yvxfvGNcc7LNWVjwAHCx6uSoNGd/lbQfl4CrzG93/2vrOhylg8EgnKyuBV252aXL
	dMyDy4jIJ1CWZw1H3wJy1JRkvaVNW0NIU+nTlthfsD3+IeBfMd5JGjIUpqoPH0d5R0eMwXRoG33
	pNTK8UckEM96oIUwVmg/ThWXJcgZekMngM7cVrmb1SHdfGgZUDGir+9Y3C0CJTuh51dZKcEkq5j
	+Gy6XzhC0dUqbcU6EUQX1U0sSxOHx4kmRCM05IRBEYzT9oQsBLPrNIkf8N6P7eBG4Qr1dggtQif
	aEucbPjH5aYVQ+MTU8rHcbipqmEal455cS
X-Received: by 2002:a05:600c:c10b:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-48fe5fcdedemr32339345e9.5.1778835509725;
        Fri, 15 May 2026 01:58:29 -0700 (PDT)
Received: from [192.168.1.210] ([2a00:23c8:33b9:3b01:f7b1:b7a0:6254:c325])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm13142610f8f.8.2026.05.15.01.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:58:28 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Fri, 15 May 2026 02:58:13 -0600
Subject: [PATCH v3 4/5] vmlinux.lds.h: remove redundant ALIGN(8) directives
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-asm-generic-1-v3-4-680b273666d4@gmail.com>
References: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
In-Reply-To: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778835503; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=NSY+wy4a9um1N1lW6bfsaEQo0J9IZ0qw+K4qR7XW5p0=;
 b=T5nINbZ1a7L72QdYwZrsP6UKr71Z+kVDeZOQlclBvGfVo2BEfioYXOO1wowxHm0J00KlJeTCO
 s4nXq6z3FrEBomuKcdWxLSPamCzWMamz+PX2PlbmxwS0deHZAyYWUQv
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

The BOUNDED_SECTION_PRE_LABEL and BOUNDED_SECTION_POST_LABEL macros
were recently updated to inherently enforce an 8-byte alignment. This
makes the explicit '. = ALIGN(8);' statements preceding 'naked' macro
calls in vmlinux.lds.h redundant.

Remove these redundant alignment directives to clean up the file and
clarify that the macros handle their own alignment padding.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 6892cbec0554..9fa11baf27d3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -228,7 +228,6 @@
 
 #ifdef CONFIG_KPROBES
 #define KPROBE_BLACKLIST()				\
-	. = ALIGN(8);					\
 	BOUNDED_SECTION(_kprobe_blacklist)
 #else
 #define KPROBE_BLACKLIST()
@@ -244,7 +243,6 @@
 
 #ifdef CONFIG_EVENT_TRACING
 #define FTRACE_EVENTS()							\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION(_ftrace_events)					\
 	BOUNDED_SECTION_BY(_ftrace_eval_map, _ftrace_eval_maps)
 #else
@@ -261,7 +259,6 @@
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #define TRACE_SYSCALLS()			\
-	. = ALIGN(8);				\
 	BOUNDED_SECTION_BY(__syscalls_metadata, _syscalls_metadata)
 #else
 #define TRACE_SYSCALLS()
@@ -276,7 +273,6 @@
 
 #ifdef CONFIG_SERIAL_EARLYCON
 #define EARLYCON_TABLE()						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__earlycon_table, __earlycon_table, , _end)
 #else
 #define EARLYCON_TABLE()
@@ -284,11 +280,9 @@
 
 #ifdef CONFIG_SECURITY
 #define LSM_TABLE()					\
-	. = ALIGN(8);					\
 	BOUNDED_SECTION_PRE_LABEL(.lsm_info.init, _lsm_info, __start, __end)
 
 #define EARLY_LSM_TABLE()						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_PRE_LABEL(.early_lsm_info.init, _early_lsm_info, __start, __end)
 #else
 #define LSM_TABLE()
@@ -314,7 +308,6 @@
 
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__##name##_acpi_probe_table,		\
 				   __##name##_acpi_probe_table,, _end)
 #else
@@ -323,7 +316,6 @@
 
 #ifdef CONFIG_THERMAL
 #define THERMAL_TABLE(name)						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__##name##_thermal_table,		\
 				   __##name##_thermal_table,, _end)
 #else
@@ -403,12 +395,10 @@
 	__end_init_stack = .;
 
 #define JUMP_TABLE_DATA							\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_BY(__jump_table, ___jump_table)
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 #define STATIC_CALL_DATA						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_BY(.static_call_sites, _static_call_sites)	\
 	BOUNDED_SECTION_BY(.static_call_tramp_key, _static_call_tramp_key)
 #else
@@ -453,7 +443,6 @@
 		*(.rodata) *(.rodata.*) *(.data.rel.ro*)		\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
-		. = ALIGN(8);						\
 		BOUNDED_SECTION_BY(__tracepoints_ptrs, ___tracepoints_ptrs) \
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
 	}								\
@@ -946,12 +935,10 @@
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
-		. = ALIGN(8);						\
 		BOUNDED_SECTION_POST_LABEL(.kunit_test_suites, __kunit_suites, _start, _end)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_INIT_TABLE()						\
-		. = ALIGN(8);						\
 		BOUNDED_SECTION_POST_LABEL(.kunit_init_test_suites, \
 				__kunit_init_suites, _start, _end)
 

-- 
2.54.0

