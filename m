Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114C9C433F5
	for <linux-modules@archiver.kernel.org>; Wed,  9 Feb 2022 17:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiBIREE (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 9 Feb 2022 12:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbiBIRED (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 9 Feb 2022 12:04:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAAF1C05CB86
        for <linux-modules@vger.kernel.org>; Wed,  9 Feb 2022 09:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644426243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3C0jjhIuJA6A86S+Ca5VNBmbogr8Vlxem3yITYF03E=;
        b=XfjyqdxPyX3ZwK4zDBROk+RQArmiexxUzJc/ItLj2g4mGqfwUsoNpf9JsNpWf0yR7WrurV
        g6XUpg7gKY/7/kTmd9O6AuhOYZk54JCPC/f7rA8FH4be04C5PZ2A2Ey0mVBi3mlp0NtQCd
        4IYnvYNM2wMnq2mXiJ0FyqSm/IhUJos=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-I_6mFbY9OGGIvvdUDdiyCg-1; Wed, 09 Feb 2022 12:04:02 -0500
X-MC-Unique: I_6mFbY9OGGIvvdUDdiyCg-1
Received: by mail-wm1-f72.google.com with SMTP id h82-20020a1c2155000000b003552c13626cso2951673wmh.3
        for <linux-modules@vger.kernel.org>; Wed, 09 Feb 2022 09:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3C0jjhIuJA6A86S+Ca5VNBmbogr8Vlxem3yITYF03E=;
        b=yz6ytCF7Yzkvq/uOGO7PQCElcJDjlPI5/WrLumageqxTYvBhtTtIlpp8BkZejYBLas
         SJOTtMk5OkyX+CpYUYDRGg/njB2lrG/L9YHD7BOglishLX6h2UWs3RI3bV8SMckTAffJ
         6mq8f1J//tCCKS1KuHuHoAs8r8uyO8MRxygY9skbIAACWfcpVJHNUDb0FwiqSoWfR0xc
         YiHnKGR62kz3YXiJv6gdwHxXDayjFaw3WWU1KpoQHfK2Gf/3dzYqBg84bworM2s6ruOS
         WcKjBcHZCxl9WpXK867m6sQ7HkGHuRiHrD67QBz7Fv4Chz3bTUWgZ3jYQ21AjQ8R8ZHs
         AYXg==
X-Gm-Message-State: AOAM5332AiFcyglgChigHpZWHGggjQL3LflJZw0+LVtykE6zBJkFZiLJ
        pmA68JZhYrJ9+uM0KrTK5ngEJM0srk/EQTGbweC3FcCgD3rrq6aq3CzjQCtrU4gxOBqUH9zvNGN
        ylNIj4bqhx0MRRoKqylFSmzq5
X-Received: by 2002:a05:600c:379a:: with SMTP id o26mr1955662wmr.137.1644426241133;
        Wed, 09 Feb 2022 09:04:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6Yl6qmx7EiBaGDMfxd8ACnhUWWTBo2ZK3mHY5AQCHcuGQuv/dP64JlNBxnlyMA/T2uJRX9g==
X-Received: by 2002:a05:600c:379a:: with SMTP id o26mr1955641wmr.137.1644426240956;
        Wed, 09 Feb 2022 09:04:00 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p2sm10366028wrt.101.2022.02.09.09.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 09:04:00 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, void@manifault.com,
        joe@perches.com, christophe.leroy@csgroup.eu, msuchanek@suse.de,
        oleksandr@natalenko.name
Subject: [PATCH v5 01/13] module: Move all into module/
Date:   Wed,  9 Feb 2022 17:03:46 +0000
Message-Id: <20220209170358.3266629-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209170358.3266629-1-atomlin@redhat.com>
References: <20220209170358.3266629-1-atomlin@redhat.com>
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
 kernel/{module-internal.h => module/internal.h}     | 1 +
 kernel/{module.c => module/main.c}                  | 2 +-
 kernel/{module_signature.c => module/signature.c}   | 0
 kernel/{module_signing.c => module/signing.c}       | 2 +-
 8 files changed, 15 insertions(+), 8 deletions(-)
 create mode 100644 kernel/module/Makefile
 rename kernel/{module_decompress.c => module/decompress.c} (99%)
 rename kernel/{module-internal.h => module/internal.h} (99%)
 rename kernel/{module.c => module/main.c} (99%)
 rename kernel/{module_signature.c => module/signature.c} (100%)
 rename kernel/{module_signing.c => module/signing.c} (97%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e461db9cd91..7e6232bd15f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13001,7 +13001,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
 F:	include/linux/module.h
-F:	kernel/module.c
+F:	kernel/module/main.c
 
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
index b01c69c2ff99..c153fd8a4444 100644
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
similarity index 99%
rename from kernel/module-internal.h
rename to kernel/module/internal.h
index 8c381c99062f..c49896368f7f 100644
--- a/kernel/module-internal.h
+++ b/kernel/module/internal.h
@@ -44,6 +44,7 @@ static inline int module_decompress(struct load_info *info,
 {
 	return -EOPNOTSUPP;
 }
+
 static inline void module_decompress_cleanup(struct load_info *info)
 {
 }
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

