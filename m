Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0414328B7B
	for <linux-modules@vger.kernel.org>; Thu,  7 May 2026 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186418; cv=none; b=idrD+1VA19BEkuvyQkotGXqXCx9Mfy04snR/kRTy5VFh3vMXLx0x5qhmiMF0WlYgI+vmLnXhbJ5LgEiW2vFVeWXSMxShLesQPjJ7YSyv52mZR9529oSa3aub3sQ9M1DizOmwOCq51Bsw9MzB59rGxLu4jUpVbbfJo5aUNmwUEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186418; c=relaxed/simple;
	bh=jx+bBZ4Ea0N4OhMqfVeFfhxzER8rbH2ykIENWAaRjuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1LcUKMQ/DybpnLNXq2LXFPbkDbKlUAtKRFL4TsTX7NPJBmT37qJlxH5WJspD8zMCqzREMBXEmMrGW9j0yEZi0g96xn0ZPhJ6i1lf7SAOsOUaM+Ecqd1OAEZ0rQmbu52eUUKasTRhxFtx35C5/AsEm7XhW9c/wuxJJNhqn+1rvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6uCvydi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6uCvydi"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so19222575e9.2
        for <linux-modules@vger.kernel.org>; Thu, 07 May 2026 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778186415; x=1778791215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsRoTlD3yayg24jIZYOgg3Ot8INI+rN2puwSkcqrIrc=;
        b=k6uCvydirmjonvmr7TkiDi1P90rCzfeVSd88Ac9V6ZibbP8+Ew0VQYDR57BQNTiDBZ
         JwVj+xV16PfYOTOxqNfnuXP2wcflzIg4pfxh0PjVuzavjUQAuI6Lw/6jBnqGV/VbOmjs
         PaMeJ6S525xuuBqBZY8vTTfC0Ed/p+ZyISG9PINzuetba31b4+oU/aQ1wvDKRjvYmrRm
         VhhspDnfdT4MZkoKyE/HW0EA66PHjgib1P7X37rwNsa1hMIv1gdfp6U/iRarYZhTF8z3
         2L0F/9iy9VjgtGeCUoOPPI+laCSA0hP3KEKDPMdK/k+KIRkPj9rrg8u7PJQCYLIG/ZFF
         sU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778186415; x=1778791215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zsRoTlD3yayg24jIZYOgg3Ot8INI+rN2puwSkcqrIrc=;
        b=GMsVVDTfFyU/iC88KdbPmyqRk9zdXxZOw3H2NYRbsvQsshbHcUrdNXqQgjnoJ5yvtR
         mZ+K79X/XtMAZTUGDSqKMeBoMz46cRuP75Vbe3jva6VtAqx/iWFSCZzeky9/eDaDMkWo
         ihBQ35MHqN7lx24tgAkbqZ9ESDPHKK98naD2o+cVZmrMu41qxb14ugOH1iS65Qy5Wke0
         EWERbLwZ26+I/gWaW2t7hs5+3XSYRsPTDpxvz+wDRDz8H8Yy/Qu87kxZCgEYWlZ4XpWM
         TDuoOL9ARWDoLfvrNxjV3A3JfYsyqEMEfrjUctH9RRFvTe2kNMnMMIXVjbBYwRdaa+mV
         d97Q==
X-Forwarded-Encrypted: i=1; AFNElJ8VzrF8H249FxHobaHCpCdWq2mCOfCJKCusxkSUccWyesdWqoCGsqFasgIq4HURCRxnxRAlB8qa9iNZRbwL@vger.kernel.org
X-Gm-Message-State: AOJu0YwijkWssezBt7nElkOKQJirm8qmEcW//SUJ1QEnBoUQNJvvAFBG
	T8pXsfTcm8WpAPL5Bu4WcHhB2jZ/3afxiMJ55CEWIwVEHPSKFoZTIYra
X-Gm-Gg: AeBDievjnenXUIqU+cAlmxBwiNfJl58s29rZkF+92dr17QueJ9GJhRZKqzoGwo4veM/
	B97gRwP+yioA5YqEN8gJKAj1lMLOwRRoQ9MqVjxnS2AvYBucuybt0XDyjCBuSQxF1lJVQgcq4YD
	dMDcCuAMx53hnU08WftAq8sX7xU65U1TqbL2ZpQO+EafpuALsudPBuaShnSMigtLAbDfuN+gEwY
	8qZ+4u8uxKhWsapzhl7lrmnE32Kz8Ac+CYaKjtS4pGKXvydWRbGCoUzhCDgipW0yjz9Ec/eLMA8
	Fm9wGQZb7d9qXP86UkBullX4kMSME1+WqmUoFwXqvMKC1aaDRzQOUokmatRyoQNg1ZsbJzOesu1
	4wJsdE8Y55ibH/1q7cE9hCJaqkcnL1wWd5i/aBJrByWgsUZV2Xn/WEJER1VHLBNqjRs19tW3VbL
	QqqnCuf0NGVRSRzOMx6cAGT41vlslv
X-Received: by 2002:a05:600c:4e0c:b0:48d:46a:6e5b with SMTP id 5b1f17b1804b1-48e51e19110mr166556955e9.7.1778186414552;
        Thu, 07 May 2026 13:40:14 -0700 (PDT)
Received: from [100.82.231.29] ([185.57.101.106])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48e5382a327sm264367515e9.0.2026.05.07.13.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:40:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 07 May 2026 14:40:08 -0600
Subject: [PATCH v2 4/5] vmlinux.lds.h: remove redundant ALIGN(8) directives
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-asm-generic-1-v2-4-47c52759d268@gmail.com>
References: <20260507-asm-generic-1-v2-0-47c52759d268@gmail.com>
In-Reply-To: <20260507-asm-generic-1-v2-0-47c52759d268@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778186409; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=jx+bBZ4Ea0N4OhMqfVeFfhxzER8rbH2ykIENWAaRjuk=;
 b=pR7CtcOVsz/BJFf7aRw2kJ2a7zTCHIBCb87JxHU2fPGeQjwnzIChkHSJ21YsYHax4e8ojTmtH
 J00exAM2qTUBTv19Axgq3IS2C8OhHFMt91rHN2t7VrhexpwvfiJFXdg
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
index d3f20b411e16..d9d2eb708355 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -229,7 +229,6 @@
 
 #ifdef CONFIG_KPROBES
 #define KPROBE_BLACKLIST()				\
-	. = ALIGN(8);					\
 	BOUNDED_SECTION(_kprobe_blacklist)
 #else
 #define KPROBE_BLACKLIST()
@@ -245,7 +244,6 @@
 
 #ifdef CONFIG_EVENT_TRACING
 #define FTRACE_EVENTS()							\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION(_ftrace_events)					\
 	BOUNDED_SECTION_BY(_ftrace_eval_map, _ftrace_eval_maps)
 #else
@@ -262,7 +260,6 @@
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #define TRACE_SYSCALLS()			\
-	. = ALIGN(8);				\
 	BOUNDED_SECTION_BY(__syscalls_metadata, _syscalls_metadata)
 #else
 #define TRACE_SYSCALLS()
@@ -277,7 +274,6 @@
 
 #ifdef CONFIG_SERIAL_EARLYCON
 #define EARLYCON_TABLE()						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__earlycon_table, __earlycon_table, , _end)
 #else
 #define EARLYCON_TABLE()
@@ -285,11 +281,9 @@
 
 #ifdef CONFIG_SECURITY
 #define LSM_TABLE()					\
-	. = ALIGN(8);					\
 	BOUNDED_SECTION_PRE_LABEL(.lsm_info.init, _lsm_info, __start, __end)
 
 #define EARLY_LSM_TABLE()						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_PRE_LABEL(.early_lsm_info.init, _early_lsm_info, __start, __end)
 #else
 #define LSM_TABLE()
@@ -315,7 +309,6 @@
 
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__##name##_acpi_probe_table,		\
 				   __##name##_acpi_probe_table,, _end)
 #else
@@ -324,7 +317,6 @@
 
 #ifdef CONFIG_THERMAL
 #define THERMAL_TABLE(name)						\
-	. = ALIGN(8);							\
 	BOUNDED_SECTION_POST_LABEL(__##name##_thermal_table,		\
 				   __##name##_thermal_table,, _end)
 #else
@@ -404,12 +396,10 @@
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
@@ -454,7 +444,6 @@
 		*(.rodata) *(.rodata.*) *(.data.rel.ro*)		\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
-		. = ALIGN(8);						\
 		BOUNDED_SECTION_BY(__tracepoints_ptrs, ___tracepoints_ptrs) \
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
 	}								\
@@ -947,12 +936,10 @@
 
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

