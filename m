Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A21A267
	for <linux-modules@vger.kernel.org>; Sun,  3 May 2026 00:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777766750; cv=none; b=tZ8EHWx1Tq59nEmUCnSZ1JNYzgzFvGfNtTF2E+P9ehHGGqqSzKbOrSlwRuRzFqWR7G0Kb1wROfC5wF1QV1hUgajem0nYH5zRJk6iFi4TT22kotXdFb81s4oqO3VTzCEh8/pVbQ48X+IihYMiL8YGm4DqHDTwdx4Hu+mBKfopDDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777766750; c=relaxed/simple;
	bh=jx+bBZ4Ea0N4OhMqfVeFfhxzER8rbH2ykIENWAaRjuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F90H2vf7ZdyCCjiu/0hzT/GOoQOo4Dmv7s/JZ2YDTPAkE0powKidyCz0ncdOm2DT+wve7Yh/zjQd545q/WxJEkNbbpAbernnxV76LhtIC3i0ysLpppGICQMls/pOHNrYhM6OVxYbHp/8Ost+Wi1A1XG4B5dleGTEDMLzsdqcePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNJ5UQWW; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNJ5UQWW"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dcdd1b492eso3181852a34.1
        for <linux-modules@vger.kernel.org>; Sat, 02 May 2026 17:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777766748; x=1778371548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsRoTlD3yayg24jIZYOgg3Ot8INI+rN2puwSkcqrIrc=;
        b=kNJ5UQWWkabQ30/abdU8LFnkhg0M22ISP9IqVnDmMvAimXOjbszMkKuRp+HxawozR1
         zudoMB3waKOeeZTx79MBvSAOxj/QUj9iO5btumQIF3D4I3YcpJAJZ3q9JqTfyhABqWV9
         LXsgC8BzbEhPBEGn/+Ipk+CBxdbkMRSXjYcOQiDs0UJFV7kclgYdX35op4uq14jocXyp
         MAMbRJHBbtVCWOJRAXHqp5MYL2tR53ZTTqoQRj8jS/4YBShROdUcxz/MLFTk7p8J9GHu
         PCYqCoWAiQvpNBKYC87BZc+kTQQh8mHeaN1wGWSfh+FoK4wad5uFBzx7hpb9X84RFbj2
         q/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777766748; x=1778371548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zsRoTlD3yayg24jIZYOgg3Ot8INI+rN2puwSkcqrIrc=;
        b=mGQfZRMDZdcJ2zz580Mwk5rabV3buyF766UN69dq8A9TGUhnoKnU+imzvwQ0eX/Owj
         Ooe7zccTkMTz5q1o8iQgsGrV+i83F0bKqCjRzGdF13NmLViYeCdtuzHmwuQGaXa/G8RZ
         dW6Ou3BdJQRjAXoADbgKRML0NpP+Ktzwgm2bCNxzmzFbsGFVagoOXAZ3HMAoOPJWTYyq
         WOIVR7CK8YcZvO4lNbbe4LNCzU7C9QNiLYJ0q9h+6PKW3CLX/9poHHyXqpJDClvgU+sQ
         HHr05B426QU4opA14pJSDNc6EAWMvb9cZ8kdIkgCl4mwU8Yu8JSHSrUoD+h+4Hw2oQBi
         THYA==
X-Forwarded-Encrypted: i=1; AFNElJ+DML8zJXxG+TArNtjMsBBziwcx3cFWvlukh9IFcrKUoAMXtEsRTpXjSwhmFRPufMVnDxMcYfr4m1cZoZGc@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7xJunZ3Q8WX4jyTqWZtaCYu/pX1WIVVw+y/qSBwqCbp4yOSK
	0IqUHqmEfekKVVS5OA9JrcwRudKlGbrCO2gH1Z7WflPldxauXNwxJb3u
X-Gm-Gg: AeBDieuWkaiKeZYz5fBkC8XRPOUelMHfk+ZbUClQ3OkHxgp8OXjSNMZ/oRRRgOn5xRz
	zpTk2xDHIXhJq3oMDHn1MebONY1mkOBoEh4TY3Xu2DpM1W7/JdqTwqId7cB4DOWI1EyoOXs4CE0
	9Kipj5H3qn2J79QCicnZH+W5fq3mQYKEtiWbI5yU/6wq0YI58kv6lOP55144vScNUhSs15wenzS
	vvJ1rL+BkMza9uixLX6RNzLAV750X8lrpDzyCaONypqooCN3DE9pF50eldaWarfdXkEV0agqqZW
	AAOMrUqiv0ShhvbDXvgiqxhx6uEi16fmej/hc1pMGLVKy/n1JbPoJjfN0Axvio5AtDO8vXWGQEu
	UzKCbos1eI5ThgzRRNn1bQ5cQgnX9KMt3T1Jw2+vDp+aeshLDh8KmH0UEXR6bXt9EJOxpi2npOu
	8V/orREuYQpGWb+9UHBi0xUjzlxzyHPUTML21iHaGVibAfbjiKUuQO8rtS03xbDZRmJHGSMKQE
X-Received: by 2002:a05:6830:6edb:b0:7db:a297:9e62 with SMTP id 46e09a7af769-7debe311362mr4677748a34.8.1777766747728;
        Sat, 02 May 2026 17:05:47 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7decae2b090sm5379676a34.24.2026.05.02.17.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 17:05:46 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 02 May 2026 18:05:35 -0600
Subject: [PATCH 4/5] vmlinux.lds.h: remove redundant ALIGN(8) directives
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-asm-generic-1-v1-4-1103ee0152df@gmail.com>
References: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
In-Reply-To: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777766741; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=jx+bBZ4Ea0N4OhMqfVeFfhxzER8rbH2ykIENWAaRjuk=;
 b=SIcEjVBNyPi945YnFwtLqpMRiycq9NN0/ZNFFBbSslazq3QklTZ6cVnzFU0RU4ofAdzG2s0Ah
 fSjCMvxtqRZA7Jg0RyDeGcFk5s8i0Mx7JE+r9sVRf9Tt0DP6VAAhjua
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

