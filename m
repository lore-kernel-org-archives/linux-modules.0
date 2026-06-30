Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19318450909
	for <linux-modules@vger.kernel.org>; Tue, 30 Jun 2026 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844687; cv=none; b=gEmZUy4H/tzFYSNBYThGz9Z9rHhNt0QRTcg3Gi6iaZsXe/OjYrgnRZBDQ1Fd9/ME0GGPxVEFWaxqQ1V5vdeL4Mb1sB1Vi6IoGtUSJjKLQkTMOAqHURoyl31tfF/nuBxsdWV//dE5iBa1ArfBG3yOLUCKmU2iT0GKbGjDqaGorj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844687; c=relaxed/simple;
	bh=buEQYiy3FfRdvywViuIQ3kK60NK0G759qwP9X/W6QJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGKiOl5nRk/Ldv/3VkiRjPFKUP7lmY28yXuk7VIAKbuCEWfiAfo9moeVgtJuCEi/uI2sJHqGHkFTyGAcq1TNmStObmPH95fD/ec0jDu/nO0yLxPmqI7A+z/QvFgxbFvgW1ZU9U1+mGl9cLkgQv8/Wu3mJ1upTCGDX9V1r9hOVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Glv9ZGOz; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Glv9ZGOz"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso1387271a34.3
        for <linux-modules@vger.kernel.org>; Tue, 30 Jun 2026 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844685; x=1783449485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VTpw1MHbZqx+9x/VIp9v+n9O2ytbSsjdwvwXuUK9qs=;
        b=Glv9ZGOzhTWOhpzeq5Uu7jEzWhdzGxnkgpPclzzp3Z2+uAzLIyudx2cBbVKqX57yos
         xUXlNxJYclAxWqame1UPUzgqAbFe4lLoJJ5St8/pSdqUV9nCkW1kPuxUsX3Cl8YVZ3GM
         iNvz1buf7LdxP7D7D9kggr9IzCCsSVR2wqiqEIDe9H0KbtSbLLLwPzbs+l+/fOrggtMS
         OL025I+9tM7KnqrGyvkz6Ti/ITjOyWzdNW2/gMgtmbQx0gZU+av5FcX/eKO+O97Ipuh4
         NLkp9O4ojfjRbS6YFJVNbs5mgUMa2C6ftjjxUpT8F7s5aaIYYKF4Snnew/pxxq3Xo+aN
         y+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844685; x=1783449485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1VTpw1MHbZqx+9x/VIp9v+n9O2ytbSsjdwvwXuUK9qs=;
        b=NVt0pa1uJYvZvjknL5eqnLf7nrXaFt66GcM2yV64nBX6XjazyKg8ptoceUdkiRmRaL
         pCzrOwukjFu6u/otvYBe6LJdHUL3bo1+Py/A6SKiJRLWOqHUPFwKoXx/TZ/e3a+XSU34
         Pl4ZLoNceWcTGxHrATU+LW+5FTdbssszng0OR9VUYubcZjwOogi8lQa1QSSjs+ZHzob1
         SVJV4Fo7MCGDLE5T6+U+YllaxV74G5B8SOPt2qzcYPztiM5YEgLcWwrU1G2s5OPecum8
         ZjErVKAQMYJgL6HfdThuDB1UHXiD/sgtfOf2e9eK5RBRo2RKvWg5/9eYmj3zB5fBREzI
         bLlw==
X-Forwarded-Encrypted: i=1; AFNElJ/SvncOywV44ZTxT1ozaSu2jtXxMhImXmnX+dVtFy25B5BKvxR4y/VaMytVnNvRNwQqhhyz2W8z39LQmql1@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyH2dmLEbaSqAsvOS35AZZF0ywqfeguMiMRzp8/R17FCs3lxE
	mvwblckWQ3uguD+1i2LtdvYfXZ6vQVg5lqyGlV6SMSkFZeyworp5vOBy
X-Gm-Gg: AfdE7cne2PunCjuaOeEbnrSfGK/Lqkdiy8xTgvo/w75xfYc5KFIYhe9gbYHvW1nxr3W
	ko7ziYf04rYNQ3/ZEZATBdJeBgobaVhNyE84nPLpW4xEhaMb/aM5m+JxxQ2o42+daYIpuTTxUYz
	M0Xey6rkhJgRRhpjyCcw8jm6+5u3Ww89CKdjMSkS654kR2MZ/rR8DOPF6JL+yVDBCI3A6VaRypq
	ixV5jUURYKixIgtIWjeZkTCeLNZKGxYP15/KwFva2tkBPXss379sWgwQj/3EPrSq1m4gWGNQEVr
	fFJ7U1Ew+UN9EBNveo3CRz7Hz3fgJNce2vSzMVb2mg8xjZ8RPmL5Z8luXJOLuPaMhOkivnuJuXC
	hWIy5VZeKw4TV3Lr4r+HIYlbv536WuezT7KSXA0kYD8HpvPIvr0uxEG66BMp68rWbs0LVwlzINV
	tzIEEjWRuJq0OrkLqiVJs0p6Xde+66LGQ8CmTtSSozcSgUN3Fr+VrnZtzntnYvzw==
X-Received: by 2002:a05:6830:82e8:b0:7d9:d2b6:1568 with SMTP id 46e09a7af769-7e9fbfb81d2mr1053138a34.17.1782844685127;
        Tue, 30 Jun 2026 11:38:05 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7e9ebfd6ccfsm2940025a34.11.2026.06.30.11.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:38:04 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 30 Jun 2026 12:37:53 -0600
Subject: [PATCH v4 4/5] vmlinux.lds.h: remove redundant ALIGN(8) directives
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-align-v4-4-42e6ec883342@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782844678; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=buEQYiy3FfRdvywViuIQ3kK60NK0G759qwP9X/W6QJQ=;
 b=9lH2yyPFfZDfAcg1bmSPmq38x4a7wAEUCGyL5iUdvLsBBgGw3wat6NBu8uy3UlJ4J6smTFOjI
 K7ba/pRrPNzA0aRmo9d1CWwTmpUnRB+J10tKwsgFTo7IYxo2B7a1jje
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
index f29fc079e37e..3758a79d0430 100644
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

