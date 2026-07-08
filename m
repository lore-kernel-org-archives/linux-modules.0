Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A7631326B
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477117; cv=none; b=kLhQWHq8UCQRiwlWQ/kcKa7MfeZ7H9VsMypexsbf0JLBixJDkmSvhJqwr3OELiZLHVNklwc5z+xqMB0O5R9jhg8dkmlkGw+xAn+j2Q6pw+DSE1zaF88ZQ38ghqjx8c0laKKAdaf4ow3xX/OVelpCvJJhdemTwfeEblgWhvY1F2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477117; c=relaxed/simple;
	bh=GB3dU5ZMSM1npKfwdvenqJkQ+9VdtadPzRaTWIRvhi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3u7Scuo0Rwqxq1kKZ4YHrpyccI6keKMufd+/XhmMxLQcb+NFSSsLbtIweX/7b71ewbuLBKw2aQW7bW/lTp7t7wfCnD+6PVYv/fpxMcHFl42aWRWKRQ9NOPT9i6v6WcdS0Y2S2nm6Fn3GWlUz8dBiUNjdFk5xRDDHWCHJSSBAOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8xoEgxo; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8xoEgxo"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9dd333d37so79860a34.0
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 19:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477112; x=1784081912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIr7EDzYU51k5dwRJ4xyktkhZnjgQlPT6aQVBoqHtP0=;
        b=L8xoEgxo1OKznqSJgx5DhPBsVf3rN/hu+Wdflz9ehOsgoLL5lwL05RkEZadPRnY3E7
         frDRpR/79s5GNmDgmZJZrz1Ci3CBVJzIw5fEnZZ56j5xvsg4EQi9LKX+IzVGljHNyYJ6
         2yrSWSRjkbolyI2HiQ8/vZI6dsIgeDKpk1R3yObs6NqkM0PjN9JzTQ1TC2nWvDJ5kSNR
         zemNkRSMXipglaCnA6U5Q+MA3j6T2wPIwC0HsCeQcM7D2F4wPzuav2D23WTlkor6GYL4
         xskuzHlhI8na7N1oWjhDJ1XhIBs8QuB04IaCZyF9WiOhLNumuRx6APub/8kd2cku//Un
         B0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477112; x=1784081912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mIr7EDzYU51k5dwRJ4xyktkhZnjgQlPT6aQVBoqHtP0=;
        b=C7lo1C146YJ0sEKmIZrhe39Lc90URF43+KuygODm9f3+bQyBmMRru+zxxABfj7myFV
         U+MNCDe0Hlo5yo0guyXz4iN/K1V+eDlmCf42DHuhGr9bwt+kljrGAR+h2HH3vkQXMila
         eP1mwpvdKuVu0PfbR/lYJoD+ZqRlgtGuxA8aR8WoKXDRE8bVj7ddWwtBBJH629n5aDLZ
         3IWNLIUEvf8g1BUN6HlZxI6HccBgx/lUnWhMFcaYE7EkJL0B5Q9EGECGtPYmgxZP40W3
         ZovxvHAMoXqyi7QDPPZfPbRG2wSo7sC1Q5WR1F8SNG6A0XFzFhOS0upTchK06366h//2
         eFFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PTugIUYqxOdSThg2OtN/nfPAY0GNfwwYFdDHEjUub9Wi9M1v8MSZPj68IzaoQssUagmIiB4JIDUS8vgjM@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkiT5D0PrHpvewbueo8pXzpcrzMPuhp4CQF+azkkNap7AtF5w
	h1EicsyfCnJRnJA4rugpFBYgbtYyL3Muaorb2BcIT57EqZ3yW51yZwVX
X-Gm-Gg: AfdE7cmqgVvMADV43r0ytKPsq+b2mS3/DGK+HHp8bIhFeHNBeA7Hhy5FQVZMWSgVacN
	BklErcLIbInzLea51Q7U93N31FAQrFx3UjIhkY8bo6rc6hzoAMVwDf4kAVQjACuPuhL2CWV4/U3
	0wRrXzIb+wWkkWbVbnzVWmk7kRVEGebKRzHosSFUqfcAQPeQoPTXc5rCohV4opioRE7PAhg8IMG
	WbZGASZrT0Xw1qEkvS1aqS5y0wLp+p+su97eH32TdbFU4sxir0YZtEWM+iZszXuizlIfxxGeaYa
	+k3ZJ5x1gmbDldrtzjXjvpZYCrVGTRC42BIclDRaYdrYLi2PBSnnQw4EoZSHWzF0ATIMEi6T50n
	BoWPdmjtXTEWO3TePflwhXWjnbjN4hJHB6egBAhrbaw7kDson7Q/NWNZTYugEJpo4oRRnRkzqmX
	c3expw2Ae7Ev8zPk3QCLh/RDMES2gvKFYcL4z4iCHYsxnopJ5S+QA=
X-Received: by 2002:a05:6808:120e:b0:489:352c:5153 with SMTP id 5614622812f47-4a203cc09c6mr359812b6e.21.1783477112483;
        Tue, 07 Jul 2026 19:18:32 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:31 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:04 -0600
Subject: [PATCH v6 04/24] vmlinux.lds.h: remove redundant ALIGN(8)
 directives
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-4-381f3edb0045@gmail.com>
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
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=3579;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=GB3dU5ZMSM1npKfwdvenqJkQ+9VdtadPzRaTWIRvhi4=;
 b=ZtFvxz7HqE55HCnzDg0W6lx2AVLgDN3LiYJVZtPVeOyRYsPldS6CnPusTvdPeSPRFhpZoslbN
 cUk0y7dwxMrAwhJcP9d5Lqssiar/M7+1d8rtdXoSo3DdUKqMZLnM6Cs
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

