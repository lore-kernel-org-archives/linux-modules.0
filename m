Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434F5C433FE
	for <linux-modules@archiver.kernel.org>; Fri, 18 Feb 2022 21:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbiBRVZg (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:25:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbiBRVZf (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 18 Feb 2022 16:25:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F058D2402C4
        for <linux-modules@vger.kernel.org>; Fri, 18 Feb 2022 13:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645219517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPUuU8/wCW1qP4n+cpgW0WPpf5qATzz9w+DjJOgqH1k=;
        b=SZOI9UyoTkqMgODuTdVF6ruOXOOt+uo4O2xeZUQt7hTjTQ98I8k0zISaFosOFfcOgD+A8y
        AkNtr5EeDH5NSI0eUkiR/B4OC6DrzhNaiZFuTyh+/JX7MSR11H6bqRb/q/TPBtX/fb34cG
        XK6xoL1aFQzxu0xWpw3dtjoFw0LI25o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-FBC2i9w0PwqSTvWW_0hn8A-1; Fri, 18 Feb 2022 16:25:15 -0500
X-MC-Unique: FBC2i9w0PwqSTvWW_0hn8A-1
Received: by mail-wr1-f71.google.com with SMTP id y8-20020adfc7c8000000b001e755c08b91so4073764wrg.15
        for <linux-modules@vger.kernel.org>; Fri, 18 Feb 2022 13:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPUuU8/wCW1qP4n+cpgW0WPpf5qATzz9w+DjJOgqH1k=;
        b=FvyBXrcldGWh+gF3hlRS7sZZImwIIqIrqu5LcNC42QukoIkPSzijWjOMn7h51G10ob
         ybZRglP18e9tImd9v05S0IKtgZ5ZPzvFuu+35uDxba8AAsOcEJcuwlZrta4ICPhKJjpk
         AwCEv5Xjvm1lgMatWLcTkP8O6+sKnN6tugrL+y+nBQlHx81M3moBqvgV53p/7K7ykn6J
         keStkqflY345jQVV5etBwma4bbbFJIEdqo5lvQERVudhX1w5LZ8WuB+XVkLew6RabEDV
         CbGvUhea8JUecef2PinXEJ2Sfe/7kUWO3kQ8UfT1TqFoGFijwDQ78z7NQxUbyf8QXOwO
         P/QA==
X-Gm-Message-State: AOAM5322CBlyRayH5uqontpVn9i9kouuN2XfwM95etbGd9QZjLcalthM
        l1ispFgutVq8ssRlJTqQVVgL8Cbpu+X+BHgU6+mJUJsEJbGgT/cLYP7QoKt2yid2NlbJMb5jh3b
        tSl3aP62zHK5JnfkR8zPwK3VC
X-Received: by 2002:adf:ecc5:0:b0:1e5:7908:966b with SMTP id s5-20020adfecc5000000b001e57908966bmr7169890wro.661.1645219514331;
        Fri, 18 Feb 2022 13:25:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1bDwGyCe3fdOy1XA3oeI4R4NKw2Ep8j5BTykIngcZyjVI2YIxemEDiVkrdxvwl8vfECY9fQ==
X-Received: by 2002:adf:ecc5:0:b0:1e5:7908:966b with SMTP id s5-20020adfecc5000000b001e57908966bmr7169873wro.661.1645219513960;
        Fri, 18 Feb 2022 13:25:13 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o4sm562796wms.9.2022.02.18.13.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:25:13 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, joe@perches.com,
        christophe.leroy@csgroup.eu, msuchanek@suse.de,
        oleksandr@natalenko.name
Subject: [PATCH v6 01/13] module: Move all into module/
Date:   Fri, 18 Feb 2022 21:24:59 +0000
Message-Id: <20220218212511.887059-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218212511.887059-1-atomlin@redhat.com>
References: <20220218212511.887059-1-atomlin@redhat.com>
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
 MAINTAINERS                                         | 2 +-
 kernel/Makefile                                     | 5 +----
 kernel/module/Makefile                              | 9 +++++++++
 kernel/{module_decompress.c => module/decompress.c} | 2 +-
 kernel/{module-internal.h => module/internal.h}     | 0
 kernel/{module.c => module/main.c}                  | 2 +-
 kernel/{module_signature.c => module/signature.c}   | 0
 kernel/{module_signing.c => module/signing.c}       | 2 +-
 8 files changed, 14 insertions(+), 8 deletions(-)
 create mode 100644 kernel/module/Makefile
 rename kernel/{module_decompress.c => module/decompress.c} (99%)
 rename kernel/{module-internal.h => module/internal.h} (100%)
 rename kernel/{module.c => module/main.c} (99%)
 rename kernel/{module_signature.c => module/signature.c} (100%)
 rename kernel/{module_signing.c => module/signing.c} (97%)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd86ed9fbc79..463bdb829db4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13012,7 +13012,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
 F:	include/linux/module.h
-F:	kernel/module.c
+F:	kernel/module/
 
 MONOLITHIC POWER SYSTEM PMIC DRIVER
 M:	Saravanan Sekar <sravanhome@gmail.com>
diff --git a/kernel/Makefile b/kernel/Makefile
index 56f4ee97f328..3a6380975c57 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -53,6 +53,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
+obj-y += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
@@ -66,10 +67,6 @@ ifneq ($(CONFIG_SMP),y)
 obj-y += up.o
 endif
 obj-$(CONFIG_UID16) += uid16.o
-obj-$(CONFIG_MODULES) += module.o
-obj-$(CONFIG_MODULE_DECOMPRESS) += module_decompress.o
-obj-$(CONFIG_MODULE_SIG) += module_signing.o
-obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_CRASH_CORE) += crash_core.o
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
new file mode 100644
index 000000000000..2902fc7d0ef1
--- /dev/null
+++ b/kernel/module/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for linux kernel module support
+#
+
+obj-$(CONFIG_MODULES) += main.o
+obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
+obj-$(CONFIG_MODULE_SIG) += signing.o
+obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
diff --git a/kernel/module_decompress.c b/kernel/module/decompress.c
similarity index 99%
rename from kernel/module_decompress.c
rename to kernel/module/decompress.c
index ffef98a20320..d14d6443225a 100644
--- a/kernel/module_decompress.c
+++ b/kernel/module/decompress.c
@@ -12,7 +12,7 @@
 #include <linux/sysfs.h>
 #include <linux/vmalloc.h>
 
-#include "module-internal.h"
+#include "internal.h"
 
 static int module_extend_max_pages(struct load_info *info, unsigned int extent)
 {
diff --git a/kernel/module-internal.h b/kernel/module/internal.h
similarity index 100%
rename from kernel/module-internal.h
rename to kernel/module/internal.h
diff --git a/kernel/module.c b/kernel/module/main.c
similarity index 99%
rename from kernel/module.c
rename to kernel/module/main.c
index 46a5c2ed1928..34a2b0cf3c3e 100644
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
2.34.1

