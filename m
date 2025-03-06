Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD220AF86
	for <linux-modules@vger.kernel.org>; Thu,  6 Mar 2025 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257487; cv=none; b=d+vNIRtwXgkyn52/f5D5QSNnEEN6KIFoFQzreuRE7FVoH4T9Qtm3Pq07w6tgk5eAOtrRF7xRdW9qD7KZqhfSkQ71mzDhiuZmTQO5Wakh4ePbSv8gqkRGPM3g2w+xCCB1xpuMf6fAQCM86ckHkrQRfnURsQ1VtRAvR0smGU4Fjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257487; c=relaxed/simple;
	bh=h1cH28RnxJqZ0laSafVMaBR35QK3+q622jKde/EWIGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMBu132vUmMECPt29yPWihZEkKDL2zF13a5P4/sRBTwLkfNyjkHZ6BjGFQE7po4ktV+eL1kYTWHB9qeo/wppIvRKwyLng5v+XAEpv6i0iP3yJPohKY5CK9Uygc5yLJUn4DAzETMy3xqcCYizaYk01SOojHSZNM8IW5FjhHmsPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=axeY+C2P; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="axeY+C2P"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bcfa6c57fso2743435e9.0
        for <linux-modules@vger.kernel.org>; Thu, 06 Mar 2025 02:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741257482; x=1741862282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYXCLPdOGTSqqbn+ENL6UC3+xBy0sRKQUeVNbBWV4jM=;
        b=axeY+C2PCh6xMn9FCz+pkTRlNa3gY8Dnrn+8x0/vlYL0KNAz7MnWBsARoSfknJlxz4
         umcOIUOiVN38F66CfbEuNCOf8uSitZ2eFWwZpRavEQ6oqoA+eL+xP12Cm4q46yU9QNgl
         VacHOpqZSm6YrMLCTQAvoxqTIn/e/v9BaYr0I60RifYHDoWVQ/9qbvfyXyetQQLM3RA6
         Z1NYbonCD/AVfyMCqPechs/msG/0z+1gS5R8vz5yCMokod8WevWNYhgGmxBS0BbRk+z1
         NOzdS7cRmJLzL9TbRPDQGrRTwt4p2TBKp4SbudGdmFn1FpUGPEYCgPSpHHGZOlmhS8ze
         dzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257482; x=1741862282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYXCLPdOGTSqqbn+ENL6UC3+xBy0sRKQUeVNbBWV4jM=;
        b=e83oKEwo4wvIzuWUJEEaIht/viTNA4REpWZa/wA317fAbnM+tHv2rBdvDqPEbfHLn3
         SelcZ8YaWEasb5AEuhObODJCPK74MiRKIf0ewhdRhDzC+zGd4YaC7cFa9x8j/a3lWFxq
         x+TbE5RFv0FYM7IHn2LCiK2uTjm/la2dyeN41KDOo57x+umPSlEBgh2QHCBVz0lH7yY4
         2dUeowxWXUpHh5W/GhSMwoPy6PgE/ZucAmAUV65WToSz3St+D9dzISy7/LEzq2yf+0Oz
         CvEidDqmCRw2SSsB4VZxGo5VLRQDR0F4lrhNmn/fwdHttWjeOx4FxkpkNsemyaA5KlLj
         yJiw==
X-Forwarded-Encrypted: i=1; AJvYcCXemytgw3zSUqI6lyVvgvJnPkqRa9nOi3EHn8pKapse92STO4yMsLjedbj2babjIAc0MzETisc/1olMvLqz@vger.kernel.org
X-Gm-Message-State: AOJu0YzmTT7AsubwYPmf9h68+v25pdNzVKnRlcVrERN9OvyexqaX8A8c
	QW0uE53Dv6cFVSoIsxYCHX95WqqsCWRt26ripJg/KWIdtCi+bVotSXNT6CWyzu8=
X-Gm-Gg: ASbGncsfDGG/eNipXTkP5rO4ClQQwxlB+sWus4gXVU7jX5UM98neO+Nlp5Zyzl6ruPI
	R4zsl5AMIGLHFL8a3INScZ4WbVRxdKlj0pnfpUTV6vbwcWyzVWaaumhYaUuMGLTujvvBIgWkATP
	q9NbL1kUagEIG10NtndBLp8o/M8E9O38oU+H+0+skVl53w1vsL1AuyNK4ofwWaOccnVsHdHqHoq
	UIMu/qihuUicejQIflfmw6yyhn7oeaH/c+FhKDV+sXtDzAgqoqQbi4ScTZYaDEF6aqg/LLZoRgK
	fEWxkL8U/BZaMba19OVRIurTnpCC768l9F4T74IxDpDGM0On
X-Google-Smtp-Source: AGHT+IF4Yk8mL/PWY9vwvySrg1rq2xp0zWk7mLV73I7qJzzkk6N/FGrhmeYnuVM7QebMZOIhoeRMzw==
X-Received: by 2002:a05:600c:3b2a:b0:439:8346:505f with SMTP id 5b1f17b1804b1-43bd29b4d11mr47266935e9.20.1741257482533;
        Thu, 06 Mar 2025 02:38:02 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd93ca9fsm15566305e9.28.2025.03.06.02.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:38:02 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Kees Cook <kees@kernel.org>,
	Petr Mladek <pmladek@suse.com>
Cc: Jani Nikula <jani.nikula@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Taint the kernel when write-protecting ro_after_init fails
Date: Thu,  6 Mar 2025 11:36:55 +0100
Message-ID: <20250306103712.29549-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the unlikely case that setting ro_after_init data to read-only fails, it
is too late to cancel loading of the module. The loader then issues only
a warning about the situation. Given that this reduces the kernel's
protection, it was suggested to make the failure more visible by tainting
the kernel.

Allow TAINT_BAD_PAGE to be set per-module and use it in this case. The flag
is set in similar situations and has the following description in
Documentation/admin-guide/tainted-kernels.rst: "bad page referenced or some
unexpected page flags".

Adjust the warning that reports the failure to avoid references to internal
functions and to add information about the kernel being tainted, both to
match the style of other messages in the file. Additionally, merge the
message on a single line because checkpatch.pl recommends that for the
ability to grep for the string.

Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
I opted to use TAINT_BAD_PAGE for now because it seemed unnecessary to me
to introduce a new flag only for this specific case. However, if we end up
similarly checking set_memory_*() in the boot context, a separate flag
would be probably better.
---
 kernel/module/main.c | 7 ++++---
 kernel/panic.c       | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1fb9ad289a6f..8f424a107b92 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3030,10 +3030,11 @@ static noinline int do_init_module(struct module *mod)
 	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
 #endif
 	ret = module_enable_rodata_ro_after_init(mod);
-	if (ret)
-		pr_warn("%s: module_enable_rodata_ro_after_init() returned %d, "
-			"ro_after_init data might still be writable\n",
+	if (ret) {
+		pr_warn("%s: write-protecting ro_after_init data failed with %d, the data might still be writable - tainting kernel\n",
 			mod->name, ret);
+		add_taint_module(mod, TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
+	}
 
 	mod_tree_remove_init(mod);
 	module_arch_freeing_init(mod);
diff --git a/kernel/panic.c b/kernel/panic.c
index d8635d5cecb2..794c443bfb5c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -497,7 +497,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' ', false),
 	TAINT_FLAG(FORCED_RMMOD,		'R', ' ', false),
 	TAINT_FLAG(MACHINE_CHECK,		'M', ' ', false),
-	TAINT_FLAG(BAD_PAGE,			'B', ' ', false),
+	TAINT_FLAG(BAD_PAGE,			'B', ' ', true),
 	TAINT_FLAG(USER,			'U', ' ', false),
 	TAINT_FLAG(DIE,				'D', ' ', false),
 	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' ', false),

base-commit: 48a5eed9ad584315c30ed35204510536235ce402
-- 
2.43.0

