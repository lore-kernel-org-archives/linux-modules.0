Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E47AC433EF
	for <linux-modules@archiver.kernel.org>; Mon,  7 Mar 2022 17:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbiCGRsy (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244531AbiCGRsn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 7 Mar 2022 12:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B9611EAE4
        for <linux-modules@vger.kernel.org>; Mon,  7 Mar 2022 09:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646675265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzDd/KuuRgH8He0fXa6WBPwvyUAPEEoXAXfWyEFzqbI=;
        b=Qnuj53J1cpNOG1B/VnTjxhW23FM9JapkhvwLvm6thvZ7oPhVhTszj5GQXA0WQfDC4nXkMg
        veJLVXdcZIkn/tGP6nYlAk9rVCKxr9ftWtfer/ojcVmtpboqdRUKO1bBMGBAgty9hZ07jr
        b24MJ5J27AxjD1/e67jOdRgZzJsvuaQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-Fp_IuatrOvOziLqzeLmgvA-1; Mon, 07 Mar 2022 12:47:44 -0500
X-MC-Unique: Fp_IuatrOvOziLqzeLmgvA-1
Received: by mail-wm1-f69.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso8150958wmh.3
        for <linux-modules@vger.kernel.org>; Mon, 07 Mar 2022 09:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XzDd/KuuRgH8He0fXa6WBPwvyUAPEEoXAXfWyEFzqbI=;
        b=IMdHIRBFcHjmzRY/Ptx4yHqqtxcPhc+Y4XkWTcUTLU1u6eJFKGxO5JHUNdul0vsuzM
         RoEEIyMoBtqGXzMCT0RjhVFWokIlqTsqE/uzn0pXOCiBReBxn7Y2x/OHbLka3kUI/W6+
         kOYwglklepSyaDrh1AEh2HTponjdOGLcki3HSlbUwrgkLd4ooJVYHZuUV/Q+thkJah8w
         mBDQnFqmtQHKy+tNXOiHi/sIDHfVlVE8nV3ujn/9SNEcM0Mg6oHAgimiSF60s5uB/w0/
         7TJOp8aX0hH62Tw8IYXPMwsYjp2GIGhKNkzSxzQkD22Mt3y/SlF/85LIdHqUhhdh3+co
         1gkg==
X-Gm-Message-State: AOAM531UoONPzpWuBMbbTSxBuUvoCTfZOcglH9MbaNSMZ+ow2olNXdeG
        kTzXZsvcOjcLP1IsjIBfKzfUeP3ywEdT/kVZ92lQJrbMc6uLqV6Mt/PvLXJ05+LmhUbMH6+A52w
        5Fiie/69v2rOqvwjAP+BVt4Xp
X-Received: by 2002:a5d:68d2:0:b0:1f0:653f:108d with SMTP id p18-20020a5d68d2000000b001f0653f108dmr8978759wrw.283.1646675263229;
        Mon, 07 Mar 2022 09:47:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVk4tcMQi5mW47Ahdmqg2rUqP8i7z7pOFRgPMY0DeuLvwNEa+sw6CpAJbavkC1217W0I2MNQ==
X-Received: by 2002:a5d:68d2:0:b0:1f0:653f:108d with SMTP id p18-20020a5d68d2000000b001f0653f108dmr8978741wrw.283.1646675263015;
        Mon, 07 Mar 2022 09:47:43 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n9-20020a1c7209000000b00389a616615csm359383wmc.2.2022.03.07.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 09:47:42 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        hch@infradead.org, pmladek@suse.com
Subject: [PATCH v10 13/14] module: Move kdb module related code out of main kdb code
Date:   Mon,  7 Mar 2022 17:47:41 +0000
Message-Id: <20220307174741.2889588-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307174509.2887714-1-atomlin@redhat.com>
References: <20220307174509.2887714-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch migrates the kdb 'lsmod' command support out of main
kdb code into its own file under kernel/module. In addition to
the above, a minor style warning i.e. missing a blank line after
declarations, was resolved too. The new file was added to
MAINTAINERS.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 MAINTAINERS                 |  1 +
 include/linux/kdb.h         |  1 +
 kernel/debug/kdb/kdb_main.c | 49 ---------------------------------
 kernel/module/Makefile      |  1 +
 kernel/module/kdb.c         | 55 +++++++++++++++++++++++++++++++++++++
 kernel/module/main.c        |  4 ---
 6 files changed, 58 insertions(+), 53 deletions(-)
 create mode 100644 kernel/module/kdb.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 195cf1ac2ee8..40c717f93c1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10689,6 +10689,7 @@ F:	drivers/tty/serial/kgdboc.c
 F:	include/linux/kdb.h
 F:	include/linux/kgdb.h
 F:	kernel/debug/
+F:	kernel/module/kdb.c
 
 KHADAS MCU MFD DRIVER
 M:	Neil Armstrong <narmstrong@baylibre.com>
diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index ea0f5e580fac..07dfb6a20a1c 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -222,5 +222,6 @@ enum {
 
 extern int kdbgetintenv(const char *, int *);
 extern int kdb_set(int, const char **);
+int kdb_lsmod(int argc, const char **argv);
 
 #endif	/* !_KDB_H */
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 0852a537dad4..f3a30cd5037f 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -26,7 +26,6 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/atomic.h>
-#include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mm.h>
 #include <linux/init.h>
@@ -2004,54 +2003,6 @@ static int kdb_ef(int argc, const char **argv)
 	return 0;
 }
 
-#if defined(CONFIG_MODULES)
-/*
- * kdb_lsmod - This function implements the 'lsmod' command.  Lists
- *	currently loaded kernel modules.
- *	Mostly taken from userland lsmod.
- */
-static int kdb_lsmod(int argc, const char **argv)
-{
-	struct module *mod;
-
-	if (argc != 0)
-		return KDB_ARGCOUNT;
-
-	kdb_printf("Module                  Size  modstruct     Used by\n");
-	list_for_each_entry(mod, kdb_modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
-			continue;
-
-		kdb_printf("%-20s%8u  0x%px ", mod->name,
-			   mod->core_layout.size, (void *)mod);
-#ifdef CONFIG_MODULE_UNLOAD
-		kdb_printf("%4d ", module_refcount(mod));
-#endif
-		if (mod->state == MODULE_STATE_GOING)
-			kdb_printf(" (Unloading)");
-		else if (mod->state == MODULE_STATE_COMING)
-			kdb_printf(" (Loading)");
-		else
-			kdb_printf(" (Live)");
-		kdb_printf(" 0x%px", mod->core_layout.base);
-
-#ifdef CONFIG_MODULE_UNLOAD
-		{
-			struct module_use *use;
-			kdb_printf(" [ ");
-			list_for_each_entry(use, &mod->source_list,
-					    source_list)
-				kdb_printf("%s ", use->target->name);
-			kdb_printf("]\n");
-		}
-#endif
-	}
-
-	return 0;
-}
-
-#endif	/* CONFIG_MODULES */
-
 /*
  * kdb_env - This function implements the 'env' command.  Display the
  *	current environment variables.
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index cf8dcdc6b55f..88f5cdcdb067 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PROC_FS) += procfs.o
 obj-$(CONFIG_SYSFS) += sysfs.o
+obj-$(CONFIG_KGDB_KDB) += kdb.o
diff --git a/kernel/module/kdb.c b/kernel/module/kdb.c
new file mode 100644
index 000000000000..60baeebea3e0
--- /dev/null
+++ b/kernel/module/kdb.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module kdb support
+ *
+ * Copyright (C) 2010 Jason Wessel
+ */
+
+#include <linux/module.h>
+#include <linux/kdb.h>
+#include "internal.h"
+
+/*
+ * kdb_lsmod - This function implements the 'lsmod' command.  Lists
+ *	currently loaded kernel modules.
+ *	Mostly taken from userland lsmod.
+ */
+int kdb_lsmod(int argc, const char **argv)
+{
+	struct module *mod;
+
+	if (argc != 0)
+		return KDB_ARGCOUNT;
+
+	kdb_printf("Module                  Size  modstruct     Used by\n");
+	list_for_each_entry(mod, &modules, list) {
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+
+		kdb_printf("%-20s%8u  0x%px ", mod->name,
+			   mod->core_layout.size, (void *)mod);
+#ifdef CONFIG_MODULE_UNLOAD
+		kdb_printf("%4d ", module_refcount(mod));
+#endif
+		if (mod->state == MODULE_STATE_GOING)
+			kdb_printf(" (Unloading)");
+		else if (mod->state == MODULE_STATE_COMING)
+			kdb_printf(" (Loading)");
+		else
+			kdb_printf(" (Live)");
+		kdb_printf(" 0x%px", mod->core_layout.base);
+
+#ifdef CONFIG_MODULE_UNLOAD
+		{
+			struct module_use *use;
+			kdb_printf(" [ ");
+			list_for_each_entry(use, &mod->source_list,
+					    source_list)
+				kdb_printf("%s ", use->target->name);
+			kdb_printf("]\n");
+		}
+#endif
+	}
+
+	return 0;
+}
diff --git a/kernel/module/main.c b/kernel/module/main.c
index b8a59b5c3e3a..bcc4f7a82649 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -108,10 +108,6 @@ static void mod_update_bounds(struct module *mod)
 		__mod_update_bounds(mod->init_layout.base, mod->init_layout.size);
 }
 
-#ifdef CONFIG_KGDB_KDB
-struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
-#endif /* CONFIG_KGDB_KDB */
-
 static void module_assert_mutex_or_preempt(void)
 {
 #ifdef CONFIG_LOCKDEP
-- 
2.34.1

