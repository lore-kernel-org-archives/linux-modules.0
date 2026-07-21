Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0F043F4AD
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667447; cv=none; b=LbeVrqp1vbMOH4LHRLW5HRhOBg4xr0TL2tWmFMnT6PrIGSWxmEXAjuPl8FRlWej6Oxa4sYKcazyWo9CFFjKyYmoKGXoWPR+FY88aYIq4o/B1PRAZ1LZ5QyuO/6XInEDaqOzx/uWoejDsdUUI36iUXRi7h06dCnySWbdYGHrc5eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667447; c=relaxed/simple;
	bh=GB3dU5ZMSM1npKfwdvenqJkQ+9VdtadPzRaTWIRvhi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bx9Cc6gwBTHHjaGI4TfyxQWk34lPYQcPzoFJ8rsdhVbvOytod5LAA09A1nFSPDGdo/I9fmZcY1uC/b8q5q1g4oL7ojUVHSCoEOpNh0IH1G+IvYX+Uqee59OLUO8Ymob+0JlmzHFMaYcOPmjqM1jbJCbzqfm7CdOiVSnM5hjsZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUSZYT+c; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUSZYT+c"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb6573bd52so6353577a34.3
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667442; x=1785272242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mIr7EDzYU51k5dwRJ4xyktkhZnjgQlPT6aQVBoqHtP0=;
        b=mUSZYT+cIXtHaDfpVNzH8Q3D3leOSmwfWrHnF+NsblGbu4ERMwFAf7P6FWkPl2sCXY
         7oAZk9Ed0jPIma29eVs0H0Nv3rqxcHlSu3oAVXnWV8oXivihu1wA3alZ4B9ju7VH8TDw
         h4wZwxYRX6+3cDHf04ImTrh7VQwFchy5TpjVbgWE5SIo/RHQaZz8XKKrQmwxCnw3QMKQ
         9iSMRCW9U2v1VSczLBlzEWeqdQ/dBRYbbBG6Py1kIrcXEUrb4aJ3Ov81QEh2NgMiwIFM
         0VxZXB6NlJED0gdQ0EavDg7SM5fgYZskTQF63IMQdhicOGHalwQDUF1p+cQbrh3Ex+tX
         aR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667442; x=1785272242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mIr7EDzYU51k5dwRJ4xyktkhZnjgQlPT6aQVBoqHtP0=;
        b=fC8YVboDpLJRf6Oq57B6e9AvSPzlTiNwfhfiiaTi03VKe+5XarX4A88cb/QTII5DQs
         KJwSS3zaBZ4Bxi6x0kbhU3gssCcJAKJcA8HLsISj0E13ZD8OTZFG1S0T8uMTNFJ1pC6t
         b2e8BE6O7gzH5pNVOghC5VO2yclq5nSxbVS3WeqVIXrsB4824YBNUm/w76O8vHWnPg+5
         TanoXMTCMAzBrHhVPIpJu/dwEuF5Zz2xbuWjvDI3CqKN+vwuygXAqlb8zBnajniVB6qo
         gBdchu6xfcH+DJJCdYCxDBBlJN0FSEdW3V0qfahcwVSZXWDwqkquTtsgsoj7ZP+VKdlp
         VpuQ==
X-Forwarded-Encrypted: i=1; AHgh+RrStns46UtiVi4kBwWz2tbJqd/9CiqyeNm5tzCQg51TA4SCT+kTH8GY6OHTbqN8jAHgryWUsa0vv1+fu8Vs@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhsvek+GYBInFAKHcHpZMH6dY5ckGs7XqCZK1Qe4Kxyu4NztzA
	kLdbm+Dy9PsI0at4RGDJIGh8utyHPfMZJa0+Q3jpiz+9mz7wacggAWmbPOq/Nw==
X-Gm-Gg: AfdE7ckpLluRXyH0T5WqmCGfNwTdM2ztuQNTB0Zj9l0CEHx10OGuC0q4VydFl0daeEA
	6yhk9twlCsKSOGABVQTLx3Z/thH+8w698XJsQ0wObK0ckpYodYxn+AxmvC98gKnYeERmYh+fdaz
	FiNOGcXYFuIpGK9tW+iGOTTAQfphgM2n3oG6p3JFNX+f1M8jF1nBVm4jksyjKc0AZTukejjpx0l
	LBMdjC9ugzQuGCoCZSHGpeGTQx0o1P4aYH13pogOWpyKRtqYagPNHg/EhgLh8IeWBYIy6HrEQch
	i4VfuN+Xa+Jm+iJf3Tq7XKAY5VtEJPdGlWKhflyMDOTCgT7WqFGfMKvZ34THG8nKhENLM153Qyl
	o68Mk0aZfsWiMtqFKyx0b+JT4oBYDqVIsucYCdqu/KPg/ijSuSzCFWi+htvmS7P9uZGav+taOdV
	f4w4jjuSUCxNybPUL/RwZuTKyiEGoW3bwV0hFi3OUGv48drLvSKHu/qDhV2I6Vluj52lxT4sWuw
	7aYfCS5Ty3LC+dRp7Yhj8V09A==
X-Received: by 2002:a05:6830:6adb:b0:7e9:e8a6:6389 with SMTP id 46e09a7af769-7ed9aa576e2mr10590818a34.4.1784667442474;
        Tue, 21 Jul 2026 13:57:22 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:21 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:58 -0600
Subject: [PATCH v7 09/29] vmlinux.lds.h: remove redundant ALIGN(8)
 directives
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-9-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=GB3dU5ZMSM1npKfwdvenqJkQ+9VdtadPzRaTWIRvhi4=;
 b=ZV0Hf5SQFYitl5dRK/Vjppu+sY3dn2KwpohorWYYcZjLdYd7AVfUYjBQZqiIJ29O3A8qWH07J
 J0XSkBAYlYPB/oHwwSJMwH8bU9EVzr39K8fIs87eSjMO5ekJ5NM9czP
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
2.55.0

