Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264B1C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 28 Dec 2021 21:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbhL1Va5 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:30:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237514AbhL1Vay (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdvMqON2+g29uF5MGNt8FJ0hyaTFBqbggeNzWwGO7Ms=;
        b=dSm21+tKky9mOYGvtpfPGJi8DPAhdfu35vl7gHza1ETgFHXY+6ylTeQsUhcWjUuC2OyyOA
        Ly03HmZn5E4e8tVo9E4Ou/7lxjagH/LzWZuZVB64GQUF6v9RvsWnZfB4lXpnd65AJjaYjR
        6Ut2LGJ8k06HbCdaJeCNJMD+1TXzTSA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-njD2kQcCPNuH6oSxPGkYXg-1; Tue, 28 Dec 2021 16:30:51 -0500
X-MC-Unique: njD2kQcCPNuH6oSxPGkYXg-1
Received: by mail-wm1-f71.google.com with SMTP id l20-20020a05600c1d1400b003458e02cea0so11661074wms.7
        for <linux-modules@vger.kernel.org>; Tue, 28 Dec 2021 13:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdvMqON2+g29uF5MGNt8FJ0hyaTFBqbggeNzWwGO7Ms=;
        b=7bLQ2JOKLMf1QF/JE6feEbHuX2RTWiwRf70C9TtN7ftRmylMU/OUb45PGMqjcIeb4o
         2nDZEUKIy91axP3Lrq0s2leGqacNiEpP6dbGC4zgtFSeDGxEPplz6kAcDInH8g0ltgVa
         P0EHNocx5++fscHxxNGtPPqpS3a9C0Tt0fdOsj22+9ohob10M0kNM/8fTZO9YDMqLFjJ
         oRhp7BkJh7F7MdsBjwB346vanzEjcqxRTnIWGZcFMjW9jtAyJoG3YSjCyT5KM6faPKgW
         jUVfJCoZ54+gpXNBfwAqloescSNOgk+G876GuVHaayH6KivOOlmlm0p5QWQrxe5Gxsna
         jvZw==
X-Gm-Message-State: AOAM533Tl91RN/QDCk1j8o0CnnWfXHmo1isBbMplPfVCOCOuksPjf6hX
        j9vAnAQ3qkwFBOk2WfXJ8KEk/TBBAQ+ahCzvuU/Fox0I6OpEz7QL20o+kw2cjPGZiRw6yqWmlBE
        1HWcab9GFXSYUjYGiUDduwS3a
X-Received: by 2002:adf:d1a6:: with SMTP id w6mr17330564wrc.274.1640727050411;
        Tue, 28 Dec 2021 13:30:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwa/mdwd5RP9WlrJlprOyPdltkjlK5AWEEYB/GP6aDuIFA61L/iYsiVp0nPYfPfNVYFImXi+Q==
X-Received: by 2002:adf:d1a6:: with SMTP id w6mr17330554wrc.274.1640727050268;
        Tue, 28 Dec 2021 13:30:50 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id r7sm18530335wrt.77.2021.12.28.13.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:50 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH 08/12] module: Move kmemleak support to a separate file
Date:   Tue, 28 Dec 2021 21:30:37 +0000
Message-Id: <20211228213041.1356334-9-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228213041.1356334-1-atomlin@redhat.com>
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <20211228213041.1356334-1-atomlin@redhat.com>
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

