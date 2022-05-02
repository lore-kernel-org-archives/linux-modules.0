Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D7BC433EF
	for <linux-modules@archiver.kernel.org>; Mon,  2 May 2022 20:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387537AbiEBU4j (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 2 May 2022 16:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387558AbiEBU4f (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 2 May 2022 16:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34D27E0A1
        for <linux-modules@vger.kernel.org>; Mon,  2 May 2022 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651524781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGglu3dvrLHqMUiIqOc49nbqCKUgmOSaGECzqLEx8mk=;
        b=SNknfSGBJexqkcXqGrdMuobS4XnVBPXZUFsa/Lf7sELw28KJJh7O5cmhXr3cTMRlY6Dukv
        aqFuP+aunOGh5UP0bE2EoxT7YWK1SeDA+J9/cn0padK/U8iMsr4EpcfmOOHRVr8Wd2V4Dn
        3mHmW2z8u6e02F7LqG0HerLM/Hjaulc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-m6b_jMn9OlGgc6Vg7ZMIXg-1; Mon, 02 May 2022 16:53:00 -0400
X-MC-Unique: m6b_jMn9OlGgc6Vg7ZMIXg-1
Received: by mail-wm1-f72.google.com with SMTP id d13-20020a05600c3acd00b0038ff865c043so229631wms.3
        for <linux-modules@vger.kernel.org>; Mon, 02 May 2022 13:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGglu3dvrLHqMUiIqOc49nbqCKUgmOSaGECzqLEx8mk=;
        b=cg6R5Wxn4jRBsfHU5DyL8cY7/Tq6qz/CRJawlzuCl464r69Yt2mDecganpo/Ty1/w2
         6LWyLjpgzFlQ2kliYJgTk9TwFJpu9uT3zwoOV0WAqFWionc2olZ7oZgVrthLWSb0N4YH
         tvTcW+8Bm0s19nME7/W4/PPdOqNEsd4vNPF3Z31OqzjWiyUZcHlgHkuEJ6dO+AO9VcU/
         IS+LZ8frAo4wuoIKl9UxoUb6b5Ced8jBV0tkrp/oUiuRFWFj74aU83085m4alJ3MH1hw
         iv97QHayc/64i6+/GRQ2uu9IaiXzUSu6XIjM4UkkB6mULTn67m7akLmWLgaE4kAi+c/6
         HEdg==
X-Gm-Message-State: AOAM5304z5YbLmtAKCUFq/Xy66dC+Ejm10f42NruQwVBj/i25Kv7WGwu
        wYno5hOcFTKrMx4kF3eFnGgSwzIXZRsd4WKaGRzKjFWD/EW4w1kkQt6B6aDBr+P01WMzQ9vPqq7
        kEU1OmRES2QM9a1TDSEmtp5ZF
X-Received: by 2002:adf:e7c1:0:b0:20a:b724:cedd with SMTP id e1-20020adfe7c1000000b0020ab724ceddmr10626711wrn.409.1651524773902;
        Mon, 02 May 2022 13:52:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvuJf+abT6YgA0yP5v5smYS9QrTBUKnxy+RoVT5ra6EC1CCqPgthzK3N3gMQIkac8lXN5VJA==
X-Received: by 2002:adf:e7c1:0:b0:20a:b724:cedd with SMTP id e1-20020adfe7c1000000b0020ab724ceddmr10626696wrn.409.1651524773701;
        Mon, 02 May 2022 13:52:53 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id e7-20020adfa447000000b0020c5253d8fasm7677512wra.70.2022.05.02.13.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:52:52 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: [PATCH v5 3/3] module: Introduce module unload taint tracking
Date:   Mon,  2 May 2022 21:52:52 +0100
Message-Id: <20220502205252.921173-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220502205105.919523-1-atomlin@redhat.com>
References: <20220502205105.919523-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Currently, only the initial module that tainted the kernel is
recorded e.g. when an out-of-tree module is loaded.

The purpose of this patch is to allow the kernel to maintain a record of
each unloaded module that taints the kernel. So, in addition to
displaying a list of linked modules (see print_modules()) e.g. in the
event of a detected bad page, unloaded modules that carried a taint/or
taints are displayed too. A tainted module unload count is maintained.

The number of tracked modules is not fixed. This feature is disabled by
default.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 init/Kconfig             | 11 ++++++++
 kernel/module/Makefile   |  1 +
 kernel/module/internal.h | 21 ++++++++++++++
 kernel/module/main.c     |  5 ++++
 kernel/module/tracking.c | 61 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 99 insertions(+)
 create mode 100644 kernel/module/tracking.c

diff --git a/init/Kconfig b/init/Kconfig
index ddcbefe535e9..6b30210f787d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2118,6 +2118,17 @@ config MODULE_FORCE_UNLOAD
 	  rmmod).  This is mainly for kernel developers and desperate users.
 	  If unsure, say N.
 
+config MODULE_UNLOAD_TAINT_TRACKING
+	bool "Tainted module unload tracking"
+	depends on MODULE_UNLOAD
+	default n
+	help
+	  This option allows you to maintain a record of each unloaded
+	  module that tainted the kernel. In addition to displaying a
+	  list of linked (or loaded) modules e.g. on detection of a bad
+	  page (see bad_page()), the aforementioned details are also
+	  shown. If unsure, say N.
+
 config MODVERSIONS
 	bool "Module versioning support"
 	help
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index d1ca799c12e2..948efea81e85 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_PROC_FS) += procfs.o
 obj-$(CONFIG_SYSFS) += sysfs.o
 obj-$(CONFIG_KGDB_KDB) += kdb.o
 obj-$(CONFIG_MODVERSIONS) += version.o
+obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 0bdf64c9dfb5..bc5507ab8450 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -145,6 +145,27 @@ static inline bool set_livepatch_module(struct module *mod)
 #endif
 }
 
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+struct mod_unload_taint {
+	struct list_head list;
+	char name[MODULE_NAME_LEN];
+	unsigned long taints;
+	u64 count;
+};
+
+int try_add_tainted_module(struct module *mod);
+void print_unloaded_tainted_modules(void);
+#else /* !CONFIG_MODULE_UNLOAD_TAINT_TRACKING */
+static inline int try_add_tainted_module(struct module *mod)
+{
+	return 0;
+}
+
+static inline void print_unloaded_tainted_modules(void)
+{
+}
+#endif /* CONFIG_MODULE_UNLOAD_TAINT_TRACKING */
+
 #ifdef CONFIG_MODULE_DECOMPRESS
 int module_decompress(struct load_info *info, const void *buf, size_t size);
 void module_decompress_cleanup(struct load_info *info);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 7a0484900320..6c3b4a846645 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1190,6 +1190,9 @@ static void free_module(struct module *mod)
 	module_bug_cleanup(mod);
 	/* Wait for RCU-sched synchronizing before releasing mod->list and buglist. */
 	synchronize_rcu();
+	if (try_add_tainted_module(mod))
+		pr_err("%s: adding tainted module to the unloaded tainted modules list failed.\n",
+		       mod->name);
 	mutex_unlock(&module_mutex);
 
 	/* Clean up CFI for the module. */
@@ -3125,6 +3128,8 @@ void print_modules(void)
 			continue;
 		pr_cont(" %s%s", mod->name, module_flags(mod, buf));
 	}
+
+	print_unloaded_tainted_modules();
 	preempt_enable();
 	if (last_unloaded_module[0])
 		pr_cont(" [last unloaded: %s]", last_unloaded_module);
diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
new file mode 100644
index 000000000000..7f8133044d09
--- /dev/null
+++ b/kernel/module/tracking.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module taint unload tracking support
+ *
+ * Copyright (C) 2022 Aaron Tomlin
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include "internal.h"
+
+static LIST_HEAD(unloaded_tainted_modules);
+
+int try_add_tainted_module(struct module *mod)
+{
+	struct mod_unload_taint *mod_taint;
+
+	module_assert_mutex_or_preempt();
+
+	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
+				lockdep_is_held(&module_mutex)) {
+		if (!strcmp(mod_taint->name, mod->name) &&
+		    mod_taint->taints & mod->taints) {
+			mod_taint->count++;
+			goto out;
+		}
+	}
+
+	mod_taint = kmalloc(sizeof(*mod_taint), GFP_KERNEL);
+	if (unlikely(!mod_taint))
+		return -ENOMEM;
+	strscpy(mod_taint->name, mod->name, MODULE_NAME_LEN);
+	mod_taint->taints = mod->taints;
+	list_add_rcu(&mod_taint->list, &unloaded_tainted_modules);
+	mod_taint->count = 1;
+out:
+	return 0;
+}
+
+void print_unloaded_tainted_modules(void)
+{
+	struct mod_unload_taint *mod_taint;
+	char buf[MODULE_FLAGS_BUF_SIZE];
+
+	if (!list_empty(&unloaded_tainted_modules)) {
+		printk(KERN_DEFAULT "Unloaded tainted modules:");
+		list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules,
+					list) {
+			size_t l;
+
+			l = module_flags_taint(mod_taint->taints, buf);
+			buf[l++] = '\0';
+			pr_cont(" %s(%s):%llu", mod_taint->name, buf,
+				mod_taint->count);
+		}
+	}
+}
-- 
2.34.1

