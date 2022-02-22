Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D934C4332F
	for <linux-modules@archiver.kernel.org>; Tue, 22 Feb 2022 14:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiBVONr (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiBVONn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Feb 2022 09:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3146CB930
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 06:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645539196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cGhl6nHTPV8hs9/Da1/aRnlyvdgWqihboGstnvGLgA=;
        b=DfGqaj8NB5ZGSKKiIznv7BlRUHHev+BNbBl93flJs4zDchmTsHI4vsmmBS92BDk1OhrC+M
        8bqxWR3q2CRafQ4uDj1am11KrMWlIHCZtA3XppL2m38SxPDx9PzIcpJeZ1zo9pAM0Jh7Sy
        cUMJL2cTvNnMZxBaCAFGs3SLouI6SsA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-CFMir3EsMueIHvCbM_iLYQ-1; Tue, 22 Feb 2022 09:13:14 -0500
X-MC-Unique: CFMir3EsMueIHvCbM_iLYQ-1
Received: by mail-wm1-f71.google.com with SMTP id ay41-20020a05600c1e2900b0037c5168b3c4so901358wmb.7
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 06:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2cGhl6nHTPV8hs9/Da1/aRnlyvdgWqihboGstnvGLgA=;
        b=qJR522S8DEb81Z8+lXkyhSQ8bLSN8WSIr34V3iPe25lKGiQXo/HBI1zrm73px0CJC8
         6VnSK2g/fz3Tv0vxAX3tD2FGemOMrh9rBeOGuaBX3nFV18vM0VSSBMyeo6Gk8kkkNzYD
         g+eK4lxLDhrZiaS7I9+1RzUl8lVWQn8LQYMWEs3HwUK1MwYhwhk4NWfMp59A4zqI1P/u
         ZVnvrn9YPdUrL9gdRDloW51Nzu1VKp16UhEE3+XMcBy4wTTRknu6g/uw+OpNPVQ0TTZ8
         yS8AycK5uXk1TPFariDm+OikLCeWQRLfzqWwQxssBpWK633gps6tqdpj2LttB/i5YvXz
         /zIQ==
X-Gm-Message-State: AOAM532O4gxznXHacdZ5wz5ueOMTWW901IyHwkeGv4zrhUHJxRn+AXRX
        Rp15HTyEyS7NouYGCL3ITfsvFT2dAZRKIBKTNLEPgbMKKUr5nwrjf021GgHKhNiwoiZP2gBxQ1r
        hKowGKYetjyHLvvOW/2Q3OAl1
X-Received: by 2002:a5d:5902:0:b0:1ea:9aa1:6ad9 with SMTP id v2-20020a5d5902000000b001ea9aa16ad9mr1796037wrd.465.1645539193573;
        Tue, 22 Feb 2022 06:13:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2BohY/gOv3fFwa+dKYMHi6Y6pPHAFj7n60L1VBjpT1/4K/yK8ZWfOwkYYQx3owW4Ajn69Gg==
X-Received: by 2002:a5d:5902:0:b0:1ea:9aa1:6ad9 with SMTP id v2-20020a5d5902000000b001ea9aa16ad9mr1796024wrd.465.1645539193364;
        Tue, 22 Feb 2022 06:13:13 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o8sm2416515wmc.46.2022.02.22.06.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:13:13 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v8 08/13] module: Move kmemleak support to a separate file
Date:   Tue, 22 Feb 2022 14:12:58 +0000
Message-Id: <20220222141303.1392190-9-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222141303.1392190-1-atomlin@redhat.com>
References: <20220222141303.1392190-1-atomlin@redhat.com>
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
index d313c8472cb3..12388627725c 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
 obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
+obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
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

