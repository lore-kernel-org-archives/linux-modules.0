Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27197379EE8
	for <linux-modules@vger.kernel.org>; Mon,  1 Jun 2026 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315518; cv=none; b=YvxvSRHyhAK01wrkMcjPg0pDF8HFIX7CzHvGeLMplcNZ6G9/Ax8hVBJIvbgHYDlwjbV7BAmnxSYSTBFP4SSGvFYTei2kcef9G2AEnjk8dFwVhkpZAIcnFfb6Q9ucV/+GQYQfygKr8FRii3StoiP+lFEMI9oi91OheqS/zOXWBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315518; c=relaxed/simple;
	bh=+UeoPcUgk4vgSL6bIOBGSbmEMWJGj+kcMG3jKhNS13E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P+Apu0HhDfsFSmzYgUH9ZKN0QUY6aoxWzP2MwNx9Fs1Hff7XVSRo5YRm2woeg4mKtluAYNshRNJVVflt1LzrfDq/k0NndbVA7y2915qsi5wPJidfcnzGJDcMqb88zYeIQWcJV2tdKQcdM8Hed3FTnWMgVTCb7quF4vE7roX+/to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG7UxpN+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG7UxpN+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4600ddc4017so1026496f8f.0
        for <linux-modules@vger.kernel.org>; Mon, 01 Jun 2026 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315514; x=1780920314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9btmEwYy4mA0lJ0Eq1DfE2LNHPtUWEmA56rbSRa3u8=;
        b=gG7UxpN+wDuhR/no4N8s1p0sBObFvjMoumWIyBvx375W7QutFRMT+uGXAPptCQn4+Q
         rucni6MqDr6mwm0/liG3zQwC0EekgpkQWiSEA26FFnmuk0R8mjnDw/DzubIIDa5UArsm
         jpcQumHrSuQjtr1/a8uQfbqBlL7Bf5DVmYuwPmlNKesTvk8qQnE2CcVgI+C8waLmWImM
         0c5vECF83xpLwQWgTTYtx4ZDNVKYAnM3O2iQfo88OS51HZcG2f9g6sAMG1HeoqzN0X4e
         /7mJI5NxHMMED8z3rlb2o7w/j8naZ4dJXxcLQeujM7Z0wdL7RHLkC4GIN+Gm0snxKkIp
         aj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315514; x=1780920314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n9btmEwYy4mA0lJ0Eq1DfE2LNHPtUWEmA56rbSRa3u8=;
        b=CksgZqFKFnu8f0viMobUpNiFJ4NZRzx4x9Dku+85OzJRZl/ASMEYFlUHuDYlW3ee9L
         nIM9rHice/zPrZGtBO/LHG8RPm7RYxQnkfOQohu8rsguWo0BoU87WJr9WVn709wuOoRY
         zx5/wEmYitSCREK86yRLsNwEZqF62ShWL4/CLpi+KQZFNrtLYDgNcr4FqQJaAB3Pphot
         6qUm+dsb3XD7Yn8g8SBuCQTEEuYgh3CMWv48idyYhYKiKrOryr2/skzLeDlAcSZwRoua
         qPDdE9ZQHuJsSGdUpULfFm5B+JX2vxH5ffo1j/KgrjDJ3GVqsgqwlE/eMzz4E2QzTIOv
         Ls4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+OZ32r5tThZuDBDzpGwhemhmAir+KTkH6jG8+mD2YwzyUaAuegKeF4iQymif+ZvDQSBIgSTNbQq6t3Gcyd@vger.kernel.org
X-Gm-Message-State: AOJu0YywX9JzpwdJuKVFawfHdcdtPrAuBjB7mNZshOPTaxezxcvdeEGy
	/vUynLFrp8yrcHjrlj1NtmA/ByWw6OrjgESnecP7nb8KDRYZF/pLV5SM
X-Gm-Gg: Acq92OHFhwe7Q5/djsOV7i2+/6xJAghwKgr124jgIdoFEpwXNldmpxrWUpb8Z8AOSQy
	3YvvVUCoWB6GUZCh1dX7Y5/fnFrWfMOX0qQZsYUqBJMCKc4Ts1bTwk3RBVCxG7moGwgMqw0bJTz
	HzYlBqJJ6oBcWIfeDLJy9dLcBTdukt3c02D0hszcDnqSr3FyroHwH7gABhVgOIGgl/vUeIaVqgw
	8uwVEu6LaMs8yajcn4F8+v/WpfEgUIUNs/zIoQTIWG4IHM4wkN0n4lmPanIonDSPqnT9ZVGQPgs
	+pqiWYMwkS75f99pgCQnMB6ntTcSoQbkMrs8+P4+Fnf4crn9LdFehSu7iTyOBAsuty+2ue29Us1
	tvic7oo/jPOMY6sFDKK6JTgc88kWCCciCX+dm96Gq3E2HfY07T7iftqxlEI3P8+tHJYt++2fJwG
	rtH1bnTy8m8Qo6RgOT1tb/t7v1Mi6c3DXgGJ+PJffLPw==
X-Received: by 2002:a05:600c:1546:b0:490:50e4:7224 with SMTP id 5b1f17b1804b1-490a290bdf1mr200439195e9.3.1780315514334;
        Mon, 01 Jun 2026 05:05:14 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:05:13 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:52 +0000
Subject: [PATCH v3 06/24] vmlinux.lds.h: remove redundant ALIGN(8)
 directives
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-6-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=+UeoPcUgk4vgSL6bIOBGSbmEMWJGj+kcMG3jKhNS13E=;
 b=aehCj0PKMwAsGeX1yoA8ZPfivKihRi7JRV3fcSw/dL7t3mWFKMgDCcR0BXQduggaMx72SGO+e
 QFpbl8RtwUmAVWhr759+EI9HvVVPhBIXRwjiL5byPJQq8K/i+TNdP3k
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
index 145beb14b94b..2b1becd809be 100644
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

