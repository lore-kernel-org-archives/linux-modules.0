Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299EDC433F5
	for <linux-modules@archiver.kernel.org>; Tue, 28 Dec 2021 21:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbhL1Var (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:30:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237446AbhL1Vaq (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oyE/rafatlrcvSG+3VXfXdUjnRRYymu/M4FMEAKWVLk=;
        b=O1dlcc3++/rp553RyHIRWE39RYIylHb35sQNr2x1Q+sbaeL3Wnx1V2VQyZg9O+i1xWDRR7
        G5NkwmGbWzcrIgKx3Z7y9O3VvcafefTVgM2tb7ehHRFJiOsCIuwrr0A6QXyqg1zSPKUDD1
        +fqrFdm2Bn106xQe1Zn2yoHkI86jyEg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-oA7qvTvUOLCTF1u2DfndaA-1; Tue, 28 Dec 2021 16:30:44 -0500
X-MC-Unique: oA7qvTvUOLCTF1u2DfndaA-1
Received: by mail-wm1-f70.google.com with SMTP id v62-20020a1cac41000000b0033719a1a714so6554442wme.6
        for <linux-modules@vger.kernel.org>; Tue, 28 Dec 2021 13:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oyE/rafatlrcvSG+3VXfXdUjnRRYymu/M4FMEAKWVLk=;
        b=czhgQFcECwF7FrRZY6v4ri4TMMUlOIoF/kGVvFr5/W/tiSQkt2Kqbz3+emU0qaoUvo
         8brWuS8wn1+JfW7uS0JSRP6h05TM1iBUrzerC2SEJIxI08p8vea4zGx4KfYMpkZVy5rv
         0O7YRFlQoskrUNFavkrsSx2mN7x0V8eL3Rm2kU32g5BQCR2QieiO25Mls+3oq6J2q2EL
         4PR8X7bkg3SZ+XKKvKahXu5aFx3fu92jKXrM27iPha2qVc8Rcnk3g0vXxNvBunjhit8C
         ftabGEAjxMea3EAD6DD4f+u8g67kiIjnRkhCW14ocFHOzimWSliCLV5jXUhau7z6p/Dm
         N5qw==
X-Gm-Message-State: AOAM531o0RC8g4fUHmV+gazDqCW/UkDT+zPVdFLf7zVhMvpAu/WCEWW5
        fEQwJNEDmCgL5Wv5LrLliVPI//IAB2x7ZQtTRuMzD6fhgDIZvx296KlmSXIhZsX70/B9RMT+yDc
        CvDGxs9P5+oI1t9bkGxogJCus
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr19105564wme.55.1640727043360;
        Tue, 28 Dec 2021 13:30:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZHfJMfcZLPD5yQXbfVt8K3bzE/CJ+msCts6gqaz5PrvaaUDNxWD20Dv2Qb6qrcJDLH2vLww==
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr19105557wme.55.1640727043182;
        Tue, 28 Dec 2021 13:30:43 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l13sm21118900wrs.73.2021.12.28.13.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:42 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH 01/12] module: Move all into module/
Date:   Tue, 28 Dec 2021 21:30:30 +0000
Message-Id: <20211228213041.1356334-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228213041.1356334-1-atomlin@redhat.com>
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <20211228213041.1356334-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional changes.

This patch moves all module related code into a separate directory,
modifies each file name and creates a new Makefile. Note: this effort
is in preparation to refactor core module code.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/Makefile                                   | 4 +---
 kernel/module/Makefile                            | 8 ++++++++
 kernel/{module-internal.h => module/internal.h}   | 0
 kernel/{module.c => module/main.c}                | 2 +-
 kernel/{module_signature.c => module/signature.c} | 0
 kernel/{module_signing.c => module/signing.c}     | 2 +-
 6 files changed, 11 insertions(+), 5 deletions(-)
 create mode 100644 kernel/module/Makefile
 rename kernel/{module-internal.h => module/internal.h} (100%)
 rename kernel/{module.c => module/main.c} (99%)
 rename kernel/{module_signature.c => module/signature.c} (100%)
 rename kernel/{module_signing.c => module/signing.c} (97%)

diff --git a/kernel/Makefile b/kernel/Makefile
index 4df609be42d0..466477d4dafe 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -53,6 +53,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
+obj-y += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
@@ -66,9 +67,6 @@ ifneq ($(CONFIG_SMP),y)
 obj-y += up.o
 endif
 obj-$(CONFIG_UID16) += uid16.o
-obj-$(CONFIG_MODULES) += module.o
-obj-$(CONFIG_MODULE_SIG) += module_signing.o
-obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_CRASH_CORE) += crash_core.o
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
new file mode 100644
index 000000000000..a9cf6e822075
--- /dev/null
+++ b/kernel/module/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for linux kernel module support
+#
+
+obj-$(CONFIG_MODULES) += main.o
+obj-$(CONFIG_MODULE_SIG) += signing.o
+obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
diff --git a/kernel/module-internal.h b/kernel/module/internal.h
similarity index 100%
rename from kernel/module-internal.h
rename to kernel/module/internal.h
diff --git a/kernel/module.c b/kernel/module/main.c
similarity index 99%
rename from kernel/module.c
rename to kernel/module/main.c
index ed13917ea5f3..bc997c3e2c95 100644
--- a/kernel/module.c
+++ b/kernel/module/main.c
@@ -58,7 +58,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
 #include <uapi/linux/module.h>
-#include "module-internal.h"
+#include "internal.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
diff --git a/kernel/module_signature.c b/kernel/module/signature.c
similarity index 100%
rename from kernel/module_signature.c
rename to kernel/module/signature.c
diff --git a/kernel/module_signing.c b/kernel/module/signing.c
similarity index 97%
rename from kernel/module_signing.c
rename to kernel/module/signing.c
index 8723ae70ea1f..8aeb6d2ee94b 100644
--- a/kernel/module_signing.c
+++ b/kernel/module/signing.c
@@ -12,7 +12,7 @@
 #include <linux/string.h>
 #include <linux/verification.h>
 #include <crypto/public_key.h>
-#include "module-internal.h"
+#include "internal.h"
 
 /*
  * Verify the signature on a module.
-- 
2.31.1

