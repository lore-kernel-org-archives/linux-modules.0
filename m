Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68C8C433EF
	for <linux-modules@archiver.kernel.org>; Thu,  6 Jan 2022 23:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343545AbiAFXne (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Jan 2022 18:43:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245707AbiAFXna (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOXz+O07LBQHEUssdkx6GwmEYZ1hrM8RRSVfzn//wI8=;
        b=S5UI3YLP6yghfkseFX3egFdDyCtO8jo2jkuuU4JUXe6sqWSGOXzaFyiUa8E3bsrWsjY5ku
        nCKJDuJ+hq23DrtIlz+7R2EqmpG0VI8YRyqixAvDvBM/QvLa76J7iH4QTBEvKfpadZzHF0
        F8QdxslK2hoHJz3RhKY7ooOQZSnH01s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-ciDIL6oBM8qNHVtho8OjtQ-1; Thu, 06 Jan 2022 18:43:28 -0500
X-MC-Unique: ciDIL6oBM8qNHVtho8OjtQ-1
Received: by mail-wm1-f71.google.com with SMTP id j8-20020a05600c1c0800b00346504f5743so3711280wms.6
        for <linux-modules@vger.kernel.org>; Thu, 06 Jan 2022 15:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOXz+O07LBQHEUssdkx6GwmEYZ1hrM8RRSVfzn//wI8=;
        b=qjY3Ry+CJ6P3jqsKAz34FMTqfBJfVMMSMs8Jt9ognMu8w3zDUufVKfn+VctSSYsC+C
         PS1f0J7gsPvc1LiA8vI0Rf6pJOufcaHEV6f2UEpNbcO7IifcXO6+OKO+9XG/YQPKQokK
         9pwG0b4xVlGuZxtburlweAbkUoWSPQ4GfYoSmLB+EUgUZBs8UzCuTHG3zRulzfYBHKhA
         7KIUegYeoq9spsvuNsBmhWfre6zZq5wZ8kxe8yL0MIfAIAbwte7XgVc4xOTEyqkItEqm
         84c5u4nqlnLqSNBVjQWtfhH7JsWwvY7mIXgubBGod0cw+wIhqsarXlXXZUKs7gbvA/8G
         Ki1A==
X-Gm-Message-State: AOAM530KlbDkrljMTsJdwkA4Nc08j1EnazxYfGeuqy2QusLsf5CN6I8l
        Vh9575BLl1EGg/RAAYdV/r9EBYwHdVhqtRw8oXkAhTkor/nMp3m4POXe7J3T79vJp2EfxZmdRLk
        3Edn1OCg2DU4xHbkK8xnlur2v
X-Received: by 2002:a5d:4b04:: with SMTP id v4mr21482914wrq.395.1641512606116;
        Thu, 06 Jan 2022 15:43:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTunh53zdyeBDW2OBtSLyxPWqI9UmK0537fHJkeYZSSTtUESE9eC/OLZd4xwzynJQBP9bmfQ==
X-Received: by 2002:a5d:4b04:: with SMTP id v4mr21482901wrq.395.1641512605903;
        Thu, 06 Jan 2022 15:43:25 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l6sm4313592wry.18.2022.01.06.15.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:25 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 05/13] module: Move arch strict rwx support to a separate file
Date:   Thu,  6 Jan 2022 23:43:11 +0000
Message-Id: <20220106234319.2067842-6-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106234319.2067842-1-atomlin@redhat.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch migrates applicable architecture code
that support strict module rwx from core module code
into kernel/module/arch_strict_rwx.c

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/module.h          | 16 +++++++++++
 kernel/module/Makefile          |  1 +
 kernel/module/arch_strict_rwx.c | 44 ++++++++++++++++++++++++++++
 kernel/module/main.c            | 51 ---------------------------------
 4 files changed, 61 insertions(+), 51 deletions(-)
 create mode 100644 kernel/module/arch_strict_rwx.c

diff --git a/include/linux/module.h b/include/linux/module.h
index 8b4d254a84c0..caa7212cf754 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -338,6 +338,22 @@ struct module_layout {
 #endif
 };
 
+/*
+ * Modules' sections will be aligned on page boundaries
+ * to ensure complete separation of code and data, but
+ * only when CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
+ */
+#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
+# define debug_align(X) ALIGN(X, PAGE_SIZE)
+
+extern void frob_text(const struct module_layout *layout, int (*set_memory)(unsigned long start, int num_pages));
+extern void module_enable_x(const struct module *mod);
+#else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
+# define debug_align(X) (X)
+
+static void module_enable_x(const struct module *mod) { }
+#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
+
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 struct mod_tree_root {
 	struct latch_tree_root root;
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 9d593362156d..95fad95a0549 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
+obj-$(CONFIG_ARCH_HAS_STRICT_MODULE_RWX) += arch_strict_rwx.o
diff --git a/kernel/module/arch_strict_rwx.c b/kernel/module/arch_strict_rwx.c
new file mode 100644
index 000000000000..68e970671ec5
--- /dev/null
+++ b/kernel/module/arch_strict_rwx.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * kernel/module/arch_strict_rwx.c - module arch strict rwx
+ *
+ * Copyright (C) 2015 Rusty Russell
+ */
+
+#include <linux/module.h>
+#include <linux/set_memory.h>
+
+/*
+ * LKM RO/NX protection: protect module's text/ro-data
+ * from modification and any data from execution.
+ *
+ * General layout of module is:
+ *          [text] [read-only-data] [ro-after-init] [writable data]
+ * text_size -----^                ^               ^               ^
+ * ro_size ------------------------|               |               |
+ * ro_after_init_size -----------------------------|               |
+ * size -----------------------------------------------------------|
+ *
+ * These values are always page-aligned (as is base)
+ */
+
+/*
+ * Since some arches are moving towards PAGE_KERNEL module allocations instead
+ * of PAGE_KERNEL_EXEC, keep frob_text() and module_enable_x() outside of the
+ * CONFIG_STRICT_MODULE_RWX block below because they are needed regardless of
+ * whether we are strict.
+ */
+void frob_text(const struct module_layout *layout,
+		      int (*set_memory)(unsigned long start, int num_pages))
+{
+	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
+	BUG_ON((unsigned long)layout->text_size & (PAGE_SIZE-1));
+	set_memory((unsigned long)layout->base,
+		   layout->text_size >> PAGE_SHIFT);
+}
+
+void module_enable_x(const struct module *mod)
+{
+	frob_text(&mod->core_layout, set_memory_x);
+	frob_text(&mod->init_layout, set_memory_x);
+}
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 692cc520420d..a0619256b343 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -13,7 +13,6 @@
 #include <linux/trace_events.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
-#include <linux/buildid.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/sysfs.h>
@@ -63,17 +62,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
 
-/*
- * Modules' sections will be aligned on page boundaries
- * to ensure complete separation of code and data, but
- * only when CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
- */
-#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
-# define debug_align(X) ALIGN(X, PAGE_SIZE)
-#else
-# define debug_align(X) (X)
-#endif
-
 /*
  * Mutex protects:
  * 1) List of modules (also safely readable with preempt_disable),
@@ -1786,45 +1774,6 @@ static void mod_sysfs_teardown(struct module *mod)
 	mod_sysfs_fini(mod);
 }
 
-/*
- * LKM RO/NX protection: protect module's text/ro-data
- * from modification and any data from execution.
- *
- * General layout of module is:
- *          [text] [read-only-data] [ro-after-init] [writable data]
- * text_size -----^                ^               ^               ^
- * ro_size ------------------------|               |               |
- * ro_after_init_size -----------------------------|               |
- * size -----------------------------------------------------------|
- *
- * These values are always page-aligned (as is base)
- */
-
-/*
- * Since some arches are moving towards PAGE_KERNEL module allocations instead
- * of PAGE_KERNEL_EXEC, keep frob_text() and module_enable_x() outside of the
- * CONFIG_STRICT_MODULE_RWX block below because they are needed regardless of
- * whether we are strict.
- */
-#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
-static void frob_text(const struct module_layout *layout,
-		      int (*set_memory)(unsigned long start, int num_pages))
-{
-	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->text_size & (PAGE_SIZE-1));
-	set_memory((unsigned long)layout->base,
-		   layout->text_size >> PAGE_SHIFT);
-}
-
-static void module_enable_x(const struct module *mod)
-{
-	frob_text(&mod->core_layout, set_memory_x);
-	frob_text(&mod->init_layout, set_memory_x);
-}
-#else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
-static void module_enable_x(const struct module *mod) { }
-#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
-
 #ifdef CONFIG_STRICT_MODULE_RWX
 static void frob_rodata(const struct module_layout *layout,
 			int (*set_memory)(unsigned long start, int num_pages))
-- 
2.31.1

