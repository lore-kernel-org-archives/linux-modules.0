Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845C9C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 22 Mar 2022 14:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiCVOGC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Mar 2022 10:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiCVOFm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Mar 2022 10:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F3EC33370
        for <linux-modules@vger.kernel.org>; Tue, 22 Mar 2022 07:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647957853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwM5m/UKCLcQUodhjTTwfqA0OAG1WbMnIR0FKcI9qsQ=;
        b=W0RZyoEujTs2qNcI2CE6AA5Y9WgK3aPIlVibzaIwjnMsXBLG0Xi54UcfYjP8IdEqYoDueK
        d8aFM7NksjeM3X4Wc+6GeCRwQ60OUud+/IyBrYkQcoadA1ccszhpdiVLDmRJSSCpsoz+D/
        3l3vVvQMSCcvdLkeaVjJF2LtLIU7epw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-22iS3O-UNnOb-2zJ5TqYFw-1; Tue, 22 Mar 2022 10:04:11 -0400
X-MC-Unique: 22iS3O-UNnOb-2zJ5TqYFw-1
Received: by mail-wm1-f70.google.com with SMTP id 4-20020a05600c274400b0038c8ab2e835so979612wmw.1
        for <linux-modules@vger.kernel.org>; Tue, 22 Mar 2022 07:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EwM5m/UKCLcQUodhjTTwfqA0OAG1WbMnIR0FKcI9qsQ=;
        b=NjsqxDMHOli6hh/ZIny5tJ44hLtKKQ/OYEGYQK4lwXjcNxmVtVGLixTdv86ijo/875
         hhOtuxD7fhkGgW/hwP2au0q38WeFacHXLPwyXZzaqvqXlQIzXJIFq4P8Pkwy9r3Neb4g
         FYZOhY69W89MX4am5lIISMpb/P4NckCpjFWAppcdW7HJqo0qXFoMsG/RspTs3MmHSFFT
         fWC3xMPrlA0KlBQxe0TWRl+27wkBRg5zXA5LZtA0IlkcVVUFe4xEdhcEUvsUkEazNjuK
         YZ1NFjQVV4sHSHqowgtq7gLAcujYxc55QFdqplvTJdLHUhG3V6/RPm5H5BZ8GECTipu5
         ftxA==
X-Gm-Message-State: AOAM532d1DUKKGPi8jSOJhqmBCGpPFzqDxEW/L7TlcEtOnQ1lvUiznLn
        VT+MMNKYztPe8sVwfOk1EfcyK2synxjdQwTZ4cAvRv+UlyIEvQXwQ/7K5nY7MKIZ2rpq+5vtFY/
        LPm4Xjo/vWSwpiUpm6OzDvqU0
X-Received: by 2002:a05:600c:3506:b0:389:d567:e9fa with SMTP id h6-20020a05600c350600b00389d567e9famr4014155wmq.74.1647957849983;
        Tue, 22 Mar 2022 07:04:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0tnWKy2G25oNMJ+3TJkLwqhsFGWWHqhlpiR7y3DJBx7m3MSTVmyIl3QnGikm4RRLzj4jzFg==
X-Received: by 2002:a05:600c:3506:b0:389:d567:e9fa with SMTP id h6-20020a05600c350600b00389d567e9famr4014131wmq.74.1647957849742;
        Tue, 22 Mar 2022 07:04:09 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b15-20020adfc74f000000b001e888b871a0sm15988550wrh.87.2022.03.22.07.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:04:08 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: [PATCH v12 08/14] module: Move kmemleak support to a separate file
Date:   Tue, 22 Mar 2022 14:03:38 +0000
Message-Id: <20220322140344.556474-9-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220322140344.556474-1-atomlin@redhat.com>
References: <20220322140344.556474-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch migrates kmemleak code out of core module
code into kernel/module/debug_kmemleak.c

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
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

