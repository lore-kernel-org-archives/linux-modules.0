Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B169AC433F5
	for <linux-modules@archiver.kernel.org>; Thu,  6 Jan 2022 23:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343638AbiAFXnj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Jan 2022 18:43:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245743AbiAFXnc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdvMqON2+g29uF5MGNt8FJ0hyaTFBqbggeNzWwGO7Ms=;
        b=RNOWvo0EHlbc+H3D7hVrRBk4DWv7blcct6FA2FHI3HEvXifT+h/b3ztW39R3rIecjn8L3T
        81mwsJ/5m9GLfJusEbb7PCgySiYBn8callSYH6+6SRDK0TGIpZ90VGmOVXsUGM8RmNzOB5
        HiGRah21vRlWgSvmBvZ9YI4SFM5wnpQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311--gW4ky_EPfCM7_0cDjRU3A-1; Thu, 06 Jan 2022 18:43:30 -0500
X-MC-Unique: -gW4ky_EPfCM7_0cDjRU3A-1
Received: by mail-wr1-f71.google.com with SMTP id g6-20020adfbc86000000b001a2d62be244so1664238wrh.23
        for <linux-modules@vger.kernel.org>; Thu, 06 Jan 2022 15:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdvMqON2+g29uF5MGNt8FJ0hyaTFBqbggeNzWwGO7Ms=;
        b=6CLZx8d6384iD+b3d00uQ3TeVxUvc2pNjd628GYbULr9ANGBiH8tFnEHtdICwWajD8
         Y186nwAScAxrfnwviQH0SENX5W6mlZi4SRH0vZO90RnGDFtx7IsOclFDwMA+bmfVEB8s
         wcRWY1n/ZAsU6hve3YmegoPcHinXM+4WBXHB1FxRVrDZ1M/672UuIBEzj0cS94nOI7va
         CN8Y1ZURm2ZoNYY3lKhGxz8cMFhwGBmhJ6dXmFqCSlTyqwK82ziKZCPDeLDoG5XpGlWl
         QT/60Gco4jqdaiP/jTJbT0CAoGxLsGEKw2MVCd0tCILciqZgA8yS+IrzaTxuMFWyN5z7
         RBgQ==
X-Gm-Message-State: AOAM531D+UAaHfZ4XCzjRr/3gEL4uF9lfzGp4+Df83gYXRBUt5ndR69/
        3MTtUxhuMgsFJ7iGNFqqwNa01CRwhz9AoMF46YW5uyZuApzBpRA/2rwluLqzKxMjFH5nFisNe9Q
        fJSuKWTeOxU143exieeKn3C2l
X-Received: by 2002:a05:600c:4153:: with SMTP id h19mr8801765wmm.142.1641512609373;
        Thu, 06 Jan 2022 15:43:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsXZbtksqnMNsSPJxgAvN6J3zPMa/zM75Gbcl25OQMut1RiMWixzC87qfP2uPXPjwX6yiv+Q==
X-Received: by 2002:a05:600c:4153:: with SMTP id h19mr8801755wmm.142.1641512609226;
        Thu, 06 Jan 2022 15:43:29 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id u3sm3980972wrs.0.2022.01.06.15.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:28 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 08/13] module: Move kmemleak support to a separate file
Date:   Thu,  6 Jan 2022 23:43:14 +0000
Message-Id: <20220106234319.2067842-9-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106234319.2067842-1-atomlin@redhat.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
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
index 795fe10ac530..2e03da799833 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
 obj-$(CONFIG_ARCH_HAS_STRICT_MODULE_RWX) += arch_strict_rwx.o
 obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
+obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
diff --git a/kernel/module/debug_kmemleak.c b/kernel/module/debug_kmemleak.c
new file mode 100644
index 000000000000..818c9d168aed
--- /dev/null
+++ b/kernel/module/debug_kmemleak.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * kernel/module/debug_kmemleak.c - module kmemleak support
+ *
+ * Copyright (C) 2009 Catalin Marinas
+ */
+
+#include <linux/module.h>
+#include <linux/kmemleak.h>
+#include "internal.h"
+
+void kmemleak_load_module(const struct module *mod,
+				 const struct load_info *info)
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
index b4db57bafcd3..31d767416f0c 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -6,6 +6,7 @@
  */
 
 #include <linux/elf.h>
+#include <linux/compiler.h>
 #include <asm/module.h>
 #include <linux/mutex.h>
 
@@ -72,3 +73,9 @@ static int module_sig_check(struct load_info *info, int flags)
 	return 0;
 }
 #endif /* !CONFIG_MODULE_SIG */
+
+#ifdef CONFIG_DEBUG_KMEMLEAK
+extern void kmemleak_load_module(const struct module *mod, const struct load_info *info);
+#else /* !CONFIG_DEBUG_KMEMLEAK */
+static inline void __maybe_unused kmemleak_load_module(const struct module *mod, const struct load_info *info) { }
+#endif /* CONFIG_DEBUG_KMEMLEAK */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 8f8a904d5ba7..672a977b1320 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2467,33 +2467,6 @@ bool __weak module_exit_section(const char *name)
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
 	unsigned long secend;
-- 
2.31.1

