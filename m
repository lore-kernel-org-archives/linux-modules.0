Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A4309F06
	for <linux-modules@vger.kernel.org>; Wed, 22 Oct 2025 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121834; cv=none; b=gcrgi/bm7wqnxr2COWKEN9h8zQ0yU63fAg2/MhKl6pccIOn9chP6fjk2qAA8M+/IoIYmw5JDUmVJ6Sg6S5gk44ANoa1KVRv2T4tS14SVPXjtVyC7HjHiyTpsPjSRceHSqFGsaDferh9ZfcfqG5KoNXL7nfCuXsqhZm6DMN8xjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121834; c=relaxed/simple;
	bh=W4dnQ6OiL+B7d18Li0iqL0CW7ojtCaZYRhjm3iMI5R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzjWdNKITxD6oXf4/13s3E8vhG5Ps8/woU81UJsSa3PP/0w6c2yTc/IFk5Pfi0mGMWOy936v2QEA/VPJT8zLdjmrx438SVR55Keagoca8toC/zZ+89L2cqAXgALNl7OYs5Uwdvm4dNC3YDAtoTPockc2BKA4L/zYPNvzlTO8nIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BUiKQY7G; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BUiKQY7G"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47495477241so15481295e9.3
        for <linux-modules@vger.kernel.org>; Wed, 22 Oct 2025 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761121830; x=1761726630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2I0pFy6f8OhKSW5/tXVB2hF1U9O55Rf8oI8wZFnUIk=;
        b=BUiKQY7GzUcZralMKKwXrVPZZngWNzCX+8fS4Wh04r0LYuqzs8ga+rveYnHZXfem5X
         35zRACBzxrJjUeo9VG35MpsOQ35D7p5PwJR1zzVKddPdio90aTltY7XOtVUoF0zGT/cO
         44R4KMWt6h7ivfw1t5OYF1SdXAjkbIqlgLBnbxbLZrARWa/rdvK9XOqZzp5P8AGl1tRP
         0KmRQtrnWVEkeELZgA9oY7VjootnMaxPm8UKBhiYdCewmLBsa/P0tTyMYsd1qYhGJczp
         94y8i3+jtsReW9b2uLVOnGGS55Sz6r5o3bCcoJPUWWd3dQN2Gbv4kIR9Hp5WQCFPy8wm
         1Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761121830; x=1761726630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2I0pFy6f8OhKSW5/tXVB2hF1U9O55Rf8oI8wZFnUIk=;
        b=lUMwMM2FL0dBqaLV776kWbvAPI/afr4GUwqtwGYfdyyo+uXZ15rtT2Bu1EtmaWc4bS
         d5gVGKUL7VMppVCQnP5C3DMj9poX34s98TzlsMtih1nwY72ZgvlvxBgLPaqhz8V2hyEM
         q7mgWnRHdvvnrE4hnVAax4rRT8eEbPEXCsubSpEkaILzZBrF55DLcjD99yx01kBSeldL
         b09PxzfRqUiS2sRcvTXdCBD4J6DX65JET6SURjb0ZOIdsgNo+lKW2JgsW/JdBANffj7t
         UQR9s3BlfZTpRdlKTahpmj/FXcAmYp0RCqHqf84zxdlG//0aHTlTMpJvOxq3wd9K1IwE
         QgMA==
X-Forwarded-Encrypted: i=1; AJvYcCUHX37JZsHtNv+pZmq4pTW1hWkED4OclTc1sR/snE+k+gGuAURGSJ9WutT9WpoPb0NZFtXU4dR+ZoJ24fxO@vger.kernel.org
X-Gm-Message-State: AOJu0YyhMhYX0PEZNpmVdL43kjD6EJOf7TafZfHZIa2JxOlrmd4oIUW9
	iIkxJXEMIBca/QEYuMCqR/0oMkRB8iHNV76B7dUJ75C6+Nff2+4N9eF81g9tziGiYPY=
X-Gm-Gg: ASbGncvqGdpzeai6hSIhwGqIldNNdMARqRveRJNJ04nQytr4fwc4ZXx29XvdwnkZ02f
	t1AVNbGWyTB7wd4z+G1klJjGo/OhMwbrPwK9Q6sK1CN2KeDsl1zx2AalExB/ITmhRgJfIRkJhT0
	AQQeLyqo6ckOnrO1xZYfSaMHA+JExiLALl0LmwHIuxBv5TNikRKgDdNaImqtdqpwFPZ8DAy4u74
	VmP/kTjF9Y29lev1174B5RVZHWCSU5o945LoPI0A2miTKrKgln+T1tIDynU2i6gYYqfeTR7Mn13
	nq3CXCVTo2JVgG58RJ8fQ5gJx2iLh9uJZdUOobx3Y9Tq7+OLmnnTs4gvlP3xC5Q5hDqO5kX9JSy
	z5FFejAo9299rfUW8djRnlvsqybBTw6+VIuS6eUpmsXnEiv6YWFjEEJ18U/5bhXg03DFZ/ci2Tp
	2Ui3m5zGEMIbCnr+jcOQ==
X-Google-Smtp-Source: AGHT+IEAsQvi1+jZRATkQNhN/Dc0L4u5Au+wsSC1TmJ90uNJgCNCcyTviA0okluf38Tbj562kD00bQ==
X-Received: by 2002:a05:600c:3b03:b0:46d:d949:daba with SMTP id 5b1f17b1804b1-47117874326mr141739475e9.4.1761121829730;
        Wed, 22 Oct 2025 01:30:29 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428f709sm33712955e9.8.2025.10.22.01.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:30:29 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] taint/module: Remove unnecessary taint_flag.module field
Date: Wed, 22 Oct 2025 10:28:04 +0200
Message-ID: <20251022082938.26670-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TAINT_RANDSTRUCT and TAINT_FWCTL flags are mistakenly set in the
taint_flags table as per-module flags. While this can be trivially
corrected, the issue can be avoided altogether by removing the
taint_flag.module field.

This is possible because, since commit 7fd8329ba502 ("taint/module: Clean
up global and module taint flags handling") in 2016, the handling of module
taint flags has been fully generic. Specifically, module_flags_taint() can
print all flags, and the required output buffer size is properly defined in
terms of TAINT_FLAGS_COUNT. The actual per-module flags are always those
added to module.taints by calls to add_taint_module().

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
The patch is based on linux-next (20251021) because I wanted to avoid
a conflict with "taint: add reminder about updating docs and scripts" [1],
which is currently queued in mm-nonmm-unstable.

[1] https://lore.kernel.org/all/20251015221626.1126156-1-rdunlap@infradead.org/

---
 include/linux/panic.h |  1 -
 kernel/module/main.c  |  2 +-
 kernel/panic.c        | 46 ++++++++++++++++++++-----------------------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 6f972a66c13e..a00bc0937698 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -86,7 +86,6 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 struct taint_flag {
 	char c_true;		/* character printed when tainted */
 	char c_false;		/* character printed when not tainted */
-	bool module;		/* also show as a per-module taint flag */
 	const char *desc;	/* verbose description of the set taint flag */
 };
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..6f219751df7e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -954,7 +954,7 @@ size_t module_flags_taint(unsigned long taints, char *buf)
 	int i;
 
 	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
-		if (taint_flags[i].module && test_bit(i, &taints))
+		if (test_bit(i, &taints))
 			buf[l++] = taint_flags[i].c_true;
 	}
 
diff --git a/kernel/panic.c b/kernel/panic.c
index 81b7911fb5ca..341c66948dcb 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -628,17 +628,13 @@ void panic(const char *fmt, ...)
 }
 EXPORT_SYMBOL(panic);
 
-#define TAINT_FLAG(taint, _c_true, _c_false, _module)			\
+#define TAINT_FLAG(taint, _c_true, _c_false)				\
 	[ TAINT_##taint ] = {						\
 		.c_true = _c_true, .c_false = _c_false,			\
-		.module = _module,					\
 		.desc = #taint,						\
 	}
 
 /*
- * TAINT_FORCED_RMMOD could be a per-module flag but the module
- * is being removed anyway.
- *
  * NOTE: if you modify the taint_flags or TAINT_FLAGS_COUNT,
  * please also modify tools/debugging/kernel-chktaint and
  * Documentation/admin-guide/tainted-kernels.rst, including its
@@ -646,26 +642,26 @@ EXPORT_SYMBOL(panic);
  * /proc/sys/kernel/tainted.
  */
 const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
-	TAINT_FLAG(PROPRIETARY_MODULE,		'P', 'G', true),
-	TAINT_FLAG(FORCED_MODULE,		'F', ' ', true),
-	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' ', false),
-	TAINT_FLAG(FORCED_RMMOD,		'R', ' ', false),
-	TAINT_FLAG(MACHINE_CHECK,		'M', ' ', false),
-	TAINT_FLAG(BAD_PAGE,			'B', ' ', false),
-	TAINT_FLAG(USER,			'U', ' ', false),
-	TAINT_FLAG(DIE,				'D', ' ', false),
-	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' ', false),
-	TAINT_FLAG(WARN,			'W', ' ', false),
-	TAINT_FLAG(CRAP,			'C', ' ', true),
-	TAINT_FLAG(FIRMWARE_WORKAROUND,		'I', ' ', false),
-	TAINT_FLAG(OOT_MODULE,			'O', ' ', true),
-	TAINT_FLAG(UNSIGNED_MODULE,		'E', ' ', true),
-	TAINT_FLAG(SOFTLOCKUP,			'L', ' ', false),
-	TAINT_FLAG(LIVEPATCH,			'K', ' ', true),
-	TAINT_FLAG(AUX,				'X', ' ', true),
-	TAINT_FLAG(RANDSTRUCT,			'T', ' ', true),
-	TAINT_FLAG(TEST,			'N', ' ', true),
-	TAINT_FLAG(FWCTL,			'J', ' ', true),
+	TAINT_FLAG(PROPRIETARY_MODULE,		'P', 'G'),
+	TAINT_FLAG(FORCED_MODULE,		'F', ' '),
+	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' '),
+	TAINT_FLAG(FORCED_RMMOD,		'R', ' '),
+	TAINT_FLAG(MACHINE_CHECK,		'M', ' '),
+	TAINT_FLAG(BAD_PAGE,			'B', ' '),
+	TAINT_FLAG(USER,			'U', ' '),
+	TAINT_FLAG(DIE,				'D', ' '),
+	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' '),
+	TAINT_FLAG(WARN,			'W', ' '),
+	TAINT_FLAG(CRAP,			'C', ' '),
+	TAINT_FLAG(FIRMWARE_WORKAROUND,		'I', ' '),
+	TAINT_FLAG(OOT_MODULE,			'O', ' '),
+	TAINT_FLAG(UNSIGNED_MODULE,		'E', ' '),
+	TAINT_FLAG(SOFTLOCKUP,			'L', ' '),
+	TAINT_FLAG(LIVEPATCH,			'K', ' '),
+	TAINT_FLAG(AUX,				'X', ' '),
+	TAINT_FLAG(RANDSTRUCT,			'T', ' '),
+	TAINT_FLAG(TEST,			'N', ' '),
+	TAINT_FLAG(FWCTL,			'J', ' '),
 };
 
 #undef TAINT_FLAG

base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
-- 
2.51.1

