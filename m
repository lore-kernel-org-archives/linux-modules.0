Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FE0C43217
	for <linux-modules@archiver.kernel.org>; Tue, 22 Feb 2022 13:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiBVNKJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiBVNKE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Feb 2022 08:10:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCCCA153387
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 05:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645535364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IHoBSEkvx0miUCN6KHvcVICryMcU0Thpx8n4XKiXi0A=;
        b=D7ZgV9qkwA9x+Kq+9UceK5yfJsE4gc1SEpx2ffgDvQ35Jpvn1IkO7F1qCXfD6ymnX389D9
        ED0h2A40/7IJLmiqDawZcuD9ATUr6X6wtzE+CAwhMLDY4J+sIQzGAYgRQbg5k2MoeRWq54
        ftN9QAS+OD7Nzb9hauLWS0I3g+CJxCM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-pG5mdVODP_SxiCffgoanHg-1; Tue, 22 Feb 2022 08:09:23 -0500
X-MC-Unique: pG5mdVODP_SxiCffgoanHg-1
Received: by mail-wm1-f69.google.com with SMTP id h82-20020a1c2155000000b003552c13626cso844201wmh.3
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 05:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHoBSEkvx0miUCN6KHvcVICryMcU0Thpx8n4XKiXi0A=;
        b=Yu2fUv3FZa3aLsLHhL7rQjFdt+95lPaf93xDS5A0DmGnI18yciEQeFaqabnz7rvRTX
         kFIwz8JiTGqyIWWh8fIWMB/zZ1IrMeF5Urh9msvxBfKVMI/ce1qDJ3ZHLM2uS7MlZOto
         6w3foSWbyXveWbpcln5IyiRRVC9wCr8qJYWLy8GE6aBgaS5jhBHxNV8OpbP7HzIN0pyn
         CZkc8duXnAebKg0GdPo0cRS8JKyxvOSWD2VGc90hWKjIdzZ74OrZjGZf4ZKiW2iM88AY
         55cc1jWT2m1ZD8tcy8CgqG7fzK0Eq23+hJoLAOk/03Jlz3ayXq0MapSOUdXabnxtfGTx
         wBVw==
X-Gm-Message-State: AOAM5300rvhdZ8D+gccUf7Y02Trpmk3yzqs3NciLPkDIKtwp0XwIEdry
        0+0q5pdZbuE4QE50Dcsz1U7zXrnz9KY9Bo3AQ2VJtxoUIkBzZCRV/Ie4ARthih1/drQPV1bIVRZ
        AhMAGRDV/+pUldAyvd6Lq/5hX
X-Received: by 2002:a05:6000:1081:b0:1e3:16d0:1c47 with SMTP id y1-20020a056000108100b001e316d01c47mr19857835wrw.19.1645535362344;
        Tue, 22 Feb 2022 05:09:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEjgCBFQudqfk9RaCogOgeL2sDvUqcS1W0pBsldQZkLC6OiDZWG4gu1Zw0gs5tDILqLOR7Pw==
X-Received: by 2002:a05:6000:1081:b0:1e3:16d0:1c47 with SMTP id y1-20020a056000108100b001e316d01c47mr19857813wrw.19.1645535362144;
        Tue, 22 Feb 2022 05:09:22 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p7sm29694562wrr.95.2022.02.22.05.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:09:21 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v7 08/13] module: Move kmemleak support to a separate file
Date:   Tue, 22 Feb 2022 13:09:06 +0000
Message-Id: <20220222130911.1348513-9-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222130911.1348513-1-atomlin@redhat.com>
References: <20220222130911.1348513-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch migrates kmemleak code out of core module
code into kernel/module/debug_kmemleak.c

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile         |  1 +
 kernel/module/debug_kmemleak.c | 30 ++++++++++++++++++++++++++++++
 kernel/module/internal.h       |  7 +++++++
 kernel/module/main.c           | 27 ---------------------------
 4 files changed, 38 insertions(+), 27 deletions(-)
 create mode 100644 kernel/module/debug_kmemleak.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 8ff5c92daf52..840d321971a7 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -14,4 +14,5 @@ obj-$(CONFIG_LIVEPATCH) += livepatch.o
 ifdef CONFIG_MODULES
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
 obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
+obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
 endif
diff --git a/kernel/module/debug_kmemleak.c b/kernel/module/debug_kmemleak.c
new file mode 100644
index 000000000000..12a569d361e8
--- /dev/null
+++ b/kernel/module/debug_kmemleak.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module kmemleak support
+ *
+ * Copyright (C) 2009 Catalin Marinas
+ */
+
+#include <linux/module.h>
+#include <linux/kmemleak.h>
+#include "internal.h"
+
+void kmemleak_load_module(const struct module *mod,
+			  const struct load_info *info)
+{
+	unsigned int i;
+
+	/* only scan the sections containing data */
+	kmemleak_scan_area(mod, sizeof(struct module), GFP_KERNEL);
+
+	for (i = 1; i < info->hdr->e_shnum; i++) {
+		/* Scan all writable sections that's not executable */
+		if (!(info->sechdrs[i].sh_flags & SHF_ALLOC) ||
+		    !(info->sechdrs[i].sh_flags & SHF_WRITE) ||
+		    (info->sechdrs[i].sh_flags & SHF_EXECINSTR))
+			continue;
+
+		kmemleak_scan_area((void *)info->sechdrs[i].sh_addr,
+				   info->sechdrs[i].sh_size, GFP_KERNEL);
+	}
+}
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index d6f646a5da41..b0c360839f63 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -167,3 +167,10 @@ static inline int module_sig_check(struct load_info *info, int flags)
 	return 0;
 }
 #endif /* !CONFIG_MODULE_SIG */
+
+#ifdef CONFIG_DEBUG_KMEMLEAK
+void kmemleak_load_module(const struct module *mod, const struct load_info *info);
+#else /* !CONFIG_DEBUG_KMEMLEAK */
+static inline void kmemleak_load_module(const struct module *mod,
+					const struct load_info *info) { }
+#endif /* CONFIG_DEBUG_KMEMLEAK */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c63e10c61694..7dd283959c5c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2519,33 +2519,6 @@ bool __weak module_exit_section(const char *name)
 	return strstarts(name, ".exit");
 }
 
-#ifdef CONFIG_DEBUG_KMEMLEAK
-static void kmemleak_load_module(const struct module *mod,
-				 const struct load_info *info)
-{
-	unsigned int i;
-
-	/* only scan the sections containing data */
-	kmemleak_scan_area(mod, sizeof(struct module), GFP_KERNEL);
-
-	for (i = 1; i < info->hdr->e_shnum; i++) {
-		/* Scan all writable sections that's not executable */
-		if (!(info->sechdrs[i].sh_flags & SHF_ALLOC) ||
-		    !(info->sechdrs[i].sh_flags & SHF_WRITE) ||
-		    (info->sechdrs[i].sh_flags & SHF_EXECINSTR))
-			continue;
-
-		kmemleak_scan_area((void *)info->sechdrs[i].sh_addr,
-				   info->sechdrs[i].sh_size, GFP_KERNEL);
-	}
-}
-#else
-static inline void kmemleak_load_module(const struct module *mod,
-					const struct load_info *info)
-{
-}
-#endif
-
 static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
 {
 #if defined(CONFIG_64BIT)
-- 
2.34.1

