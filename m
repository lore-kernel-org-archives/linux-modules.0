Received: from mail-oa2-f13.google.com (mail-oa2-f13.google.com [74.125.231.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467857EDB0
	for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202893; cv=none; b=q0c+liOt//AV/3MZJqr5nW98k9dz4CeB4ohAgMcsvSRCrlBJYRDizRWyrOZWfgQ1W4D4knLWx4JfDkosCbivvldDc+55MtRHko1WjcqObBSfXPNHM+05iMkx346ymFbI6rYeW11OXSwxlyg2uNJwpdiFLue/Cwl6Y3tD83vcAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202893; c=relaxed/simple;
	bh=l6AIJhiAS8uI/E6oLBlS30Zn+N17+e5SUNO7rKZi0c8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxdBNTR/nINfscUgAsD+MnJA5OtvXTFbpeQmBqWRM0xn/DxTJvxrETgGkPDhkD3UlCFgrl9swWyrc7sK7/Xwer9BPDHO/BuPE2bfITOP8ZLOuR+uBLVOJorYTt5OLWp0qTVEKSl3AZr2IesSZa86OI0U4IEhaT1OrPeLEXFr/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liRiGJee; arc=none smtp.client-ip=74.125.231.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liRiGJee"
Received: by mail-oa2-f13.google.com with SMTP id 586e51a60fabf-466ccdd7695so552643fac.1
        for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 15:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202889; x=1790807689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4UQi/f5isfar5Z7OcMk/Q60vYo883RzozBQH2ZM7wKQ=;
        b=liRiGJeeymu6LQ94ccH27ToOI7SfFa9Baw0PeBXc4zGzHgtaFT/nT0du/0I3ifKmh5
         H6pyRFUlTDoLplHK3Hp7jImDXSUyQqvfTPy2pThkeX43e1lExEklU84zQCjixWnkIDTp
         I9J7t5+OtBhuWpXFVyOVilJhdWdNgMo6kxhDLx4rcF9TcoJIKHyw2kVPLARyGHbOPDvz
         H82NWXuqSdXV7ESpcc257EgFO2XW8DIBammHylESQ+pAP5j1qUsT6Q46//cRBavWFkG2
         uCf+d8r+WBVmp7j9kbfAJKfj037rNZ3mjYro9Cbc9LX6d/+PeTf4EZ5Y0Cb8htGCNa4v
         M5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202889; x=1790807689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UQi/f5isfar5Z7OcMk/Q60vYo883RzozBQH2ZM7wKQ=;
        b=ncSVHVnC1B+KJ4xc8k0MILb9RwUGvf9R95puWnT9/NGMLFhILGsmbEEq2yiTEV6qoi
         mZsonLkOHXuLJfDKKqof+VSE1jqpeEADR9aNPCuybnB/rj1aPVnxvEs8y6r2+hIbgmj+
         7/0tHdpzfItm4ZlAKEpCwXgdLun81cZEAwh0FdjkTW/da4++1eKqTZw89iQiVVv0GrZq
         f6f5Ls6G5nAPY1/HfgFp2iCnD++feRYrTCbND/LloPFygGF/Xu2O0PLuNJJljofM92rG
         adIZp3H6sf9ElJjJufVs5g+S/ioCx4RytynZB+g7MaD7q5XEE9bb4fct0+A6Xq7kyb/m
         Qkhw==
X-Forwarded-Encrypted: i=1; AKwUvBxxhQvZEBOydUgOgyfkGjUNwM5JQFPTxw0/8jIaYYrL24vLIl+CmmX1hvqnMKITKVghlsQiNoG5l8TgAmRo@vger.kernel.org
X-Gm-Message-State: AFuF++njC5xm4alx5rDIO4VZj84NHxTWkoJoAssgBQz9wsCK78B2mZXn
	8Yy+j/7EeFsjZ4sx+P8lCQvvBKiVnYNAlbj/wKi7anN008fpBHkVuQIf
X-Gm-Gg: AYBFou07NcsjySie6xfgXhS2E9er9UcYCwUby6Te3O4YPV3jCN70iC26tFksatYUi8P
	CG9hQEJN5sKErIpI/E7EHXqTjG3RkNYxQ7okHYtbA2BdeqE+wnUGq3M+fEXLPLcLAO7DzjlKTPf
	O9geVM8ZueN/P8jXTRILgAouYkNyv0DV+a8Q0IIUIwj9y/1jjQak0LgyWlKXSLuUxBJLXhIVXle
	Wm3bXXSVxkx35LoxAgSbMrR8ovT6uG8y1JsFvPpbiZFvAxRlVeRShgPxb6Q5YVgoakJqEs0mfd4
	DsRs393FxSIfmUeRwuO8rK0hHwdafMpmDhPqbLHQQBd1XYMpYOUa/6jsf2HZO87AJYyLyAVMFAN
	2sMISFqLm9CK96l9lFTQhGK5NQxqVRsn0TOZDxWY9bbUiLJG8+VVorUP2UcW8SSMdJL1oTcLndi
	QzKCXrwwqsji5jjaVVDalrTC3zVr0VGEAO4F5H2QS9uIeSguM3pmIFd4E5OvTlq1oPyJ+4SMopz
	/nbR4XquDfqRMSxgxQBL5dOFMmoBco/77ate/HPWGqrt+deesTsTnwSEVN0vZVaOYnnBbtxmKTd
	e7LGFkmVb/0ZA5APk9hWXo7dLhmGYg==
X-Received: by 2002:a05:6870:1770:b0:456:772f:682d with SMTP id 586e51a60fabf-491e58d53f1mr696582fac.19.1790202889087;
        Wed, 23 Sep 2026 15:34:49 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:34:48 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:29 -0600
Subject: [PATCH v11 05/38] vmlinux.lds.h: remove redundant ALIGN(8)
 directives
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-5-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=l6AIJhiAS8uI/E6oLBlS30Zn+N17+e5SUNO7rKZi0c8=;
 b=YvrpsXALXEyyh89YApvvIyaONwvvC8tJK7qCvqPONwFXKFIpE7UguIUXaXdduT3IiPh4wp+G2
 2rwNPSg8wCPAThMFQSWJ6MndAatSRiatgw+NcFoElJDWHm8/i+yH05f
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
index b77a1bec38fc..47586c6e9839 100644
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
@@ -960,12 +949,10 @@
 
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

