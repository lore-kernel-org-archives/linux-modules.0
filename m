Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF71C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 22 Feb 2022 14:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiBVONf (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiBVONe (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Feb 2022 09:13:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDCC6B1513
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 06:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645539188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lO8XBozw0uXAeD4oDYbspjbQu7Kq7/HL8LvVdp6G95o=;
        b=a1Ld3ZajUKuLPGC4QvYx0op8f6pTKcT+tqd0JeC9E6o/ha2kyavT0VAhMLBEO8lrTKv35x
        KE5amZDxaw9pn62OcvKaXfeNvBM+jryE07FB15O4nQUlfXeqcPjhfWdN5LFioqjDkW2Bbu
        /Ecng3JYWq9nONP0yXpKVsFQmPQysMs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-FweZO12cO0S_T_UUi2y8uA-1; Tue, 22 Feb 2022 09:13:06 -0500
X-MC-Unique: FweZO12cO0S_T_UUi2y8uA-1
Received: by mail-wm1-f69.google.com with SMTP id v130-20020a1cac88000000b0037e3d70e7e1so911879wme.1
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 06:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lO8XBozw0uXAeD4oDYbspjbQu7Kq7/HL8LvVdp6G95o=;
        b=AZg7Rx0E+1UMs1C3Bj+koJqAfhvKkZXFZqnXpmhQ3EM25d8EScDzBhWvf9PP18U8uF
         PzftjcdUJgvoMp+gb9MDXpP6CZ4PgGIEZBP8Qpgpoj2M/34UK+61lGm0loU+PehbRn1c
         CzzWtXpUApEW1gPOIyhqS9vBUg36xjbK+WpDrz20W7AZG0+rvClH5VjsZw5hPGbf2U1V
         JGrkacegQlPerlwuEwG5lyuePa1Hq3IFvxsgy9Rsw4JKwgmP0kmmm2J0fzX0LGUZYIiy
         /Ekt0vKwnX8I9xJn3KmQdON3R+gPoQ7k/3faheyY9FBi/VNsmF5/N2NuIRHvKVyOjyRf
         rrrQ==
X-Gm-Message-State: AOAM532U5mk6dwjfkmnIrCyL9INkouue3ULyLFTtFN+Byj/2IHlE0p6S
        E9ttgCuZO7lpVz46DwtJAKb6ee0VwK/09KFaYFeBqFWkm2WY0YYqQlDBRk0U5uJjBr5U3B4O1Vw
        PcziEfgMyan5PL3QFliD6w8B3
X-Received: by 2002:adf:c44d:0:b0:1ea:99b6:2c2a with SMTP id a13-20020adfc44d000000b001ea99b62c2amr2070982wrg.716.1645539185692;
        Tue, 22 Feb 2022 06:13:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyC/IeWpl/mxmrKwJDHcUeEGuFgZy0a3VJORGEkadSk0wisXSOvLsE0+dgZfRd7+gAcaywmw==
X-Received: by 2002:adf:c44d:0:b0:1ea:99b6:2c2a with SMTP id a13-20020adfc44d000000b001ea99b62c2amr2070961wrg.716.1645539185518;
        Tue, 22 Feb 2022 06:13:05 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c7417000000b0037bf902737esm2940605wmc.9.2022.02.22.06.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:13:04 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v8 01/13] module: Move all into module/
Date:   Tue, 22 Feb 2022 14:12:51 +0000
Message-Id: <20220222141303.1392190-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222141303.1392190-1-atomlin@redhat.com>
References: <20220222141303.1392190-1-atomlin@redhat.com>
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
 MAINTAINERS                                         |  2 +-
 kernel/Makefile                                     |  5 +----
 kernel/module/Makefile                              | 12 ++++++++++++
 kernel/{module_decompress.c => module/decompress.c} |  2 +-
 kernel/{module-internal.h => module/internal.h}     |  0
 kernel/{module.c => module/main.c}                  |  2 +-
 kernel/{module_signing.c => module/signing.c}       |  2 +-
 7 files changed, 17 insertions(+), 8 deletions(-)
 create mode 100644 kernel/module/Makefile
 rename kernel/{module_decompress.c => module/decompress.c} (99%)
 rename kernel/{module-internal.h => module/internal.h} (100%)
 rename kernel/{module.c => module/main.c} (99%)
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
index 56f4ee97f328..717075b65deb 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -29,7 +29,6 @@ KCOV_INSTRUMENT_softirq.o := n
 KCSAN_SANITIZE_softirq.o = n
 # These are called from save_stack_trace() on slub debug path,
 # and produce insane amounts of uninteresting coverage.
-KCOV_INSTRUMENT_module.o := n
 KCOV_INSTRUMENT_extable.o := n
 KCOV_INSTRUMENT_stacktrace.o := n
 # Don't self-instrument.
@@ -53,6 +52,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
+obj-$(CONFIG_MODULES) += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
@@ -66,9 +66,6 @@ ifneq ($(CONFIG_SMP),y)
 obj-y += up.o
 endif
 obj-$(CONFIG_UID16) += uid16.o
-obj-$(CONFIG_MODULES) += module.o
-obj-$(CONFIG_MODULE_DECOMPRESS) += module_decompress.o
-obj-$(CONFIG_MODULE_SIG) += module_signing.o
 obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
new file mode 100644
index 000000000000..cdd5c61b8c7f
--- /dev/null
+++ b/kernel/module/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for linux kernel module support
+#
+
+# These are called from save_stack_trace() on slub debug path,
+# and produce insane amounts of uninteresting coverage.
+KCOV_INSTRUMENT_module.o := n
+
+obj-y += main.o
+obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
+obj-$(CONFIG_MODULE_SIG) += signing.o
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

