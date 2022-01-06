Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A27C433F5
	for <linux-modules@archiver.kernel.org>; Thu,  6 Jan 2022 23:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245682AbiAFXn2 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Jan 2022 18:43:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245672AbiAFXn0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSjRwfWfC6TRwI79+5Cdb0GwAHoA8kDMFqEtGap/jfs=;
        b=STnbsB1XsbVW8bN5zX3BZYgJ9VScJRBeAhjxWEgxw/YDQV8kBamWvnv0LIQre1dDL4JE8v
        O5Bidn2uc8bz5nbiVTS3JWpPg8P4YZ+4fZszsBSehNLYZ0z/TZcOLIMLhGJKGO1mGN3+8k
        ISsrJBRMSPSg/nPMkhNmjZoP0Ipj4X8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-gWgT_9fgONKP_pGo-eS8cg-1; Thu, 06 Jan 2022 18:43:25 -0500
X-MC-Unique: gWgT_9fgONKP_pGo-eS8cg-1
Received: by mail-wm1-f70.google.com with SMTP id d4-20020a05600c34c400b00345d5d47d54so624945wmq.6
        for <linux-modules@vger.kernel.org>; Thu, 06 Jan 2022 15:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSjRwfWfC6TRwI79+5Cdb0GwAHoA8kDMFqEtGap/jfs=;
        b=HcCqBWF9R6zvo9UOT6BJ3M2lWNJuuiaZbF9uaHCxCN8S/vf3r+J60DjOCVPb7CLugy
         08Rmya8bVBvMQ0vHuc5UfI3a3LBOEakScGZYmfPmD7T7Ht3y1h3h7q3EhakqJDBi2ldr
         ba7e1Y+vaGPzJJiT6mg/duiFzSvl5qHRbPWfrfpEKblbbPtqfo3Ul6z+K7GdbiPBFw2/
         h3tKe7oCgHI9NqR4jw3IBqhHSkEcmJjdAFr4t+ms0UJ9mI1DLMCzzlM2iLZieZg9oFXu
         UiszpqqctnxHS5PuIBtkF0yeNgLQ3au1sT/JU3NVzDRMLBh8kU5RP1jIrlSZedeZS/qT
         JhHw==
X-Gm-Message-State: AOAM530tzPvYUqAYoAy13m9oPP0GTnkSxLWhGFRStb47oUdHN9NuKZNa
        0+PPSLCPcqgtKdtaQWTWG1/T66itpVYLe3S3yUQVaxb+ziG5zd7Qxt6eCH0/3RdT5cA4PGA1v4G
        mH1j28h9nTIhzH5pkmiFrIaG4
X-Received: by 2002:adf:e4ce:: with SMTP id v14mr51258394wrm.370.1641512603887;
        Thu, 06 Jan 2022 15:43:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjKEHT9DdOF4blh8PX20pBtvIe2bBsbcaRVH0d0cfv/hvFPF5GSeN6YgK1PmmnqFEMCS9o/Q==
X-Received: by 2002:adf:e4ce:: with SMTP id v14mr51258380wrm.370.1641512603674;
        Thu, 06 Jan 2022 15:43:23 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id h2sm1892114wrr.96.2022.01.06.15.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:23 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 03/13] module: Move livepatch support to a separate file
Date:   Thu,  6 Jan 2022 23:43:09 +0000
Message-Id: <20220106234319.2067842-4-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106234319.2067842-1-atomlin@redhat.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch migrates livepatch support (i.e. used during module
add/or load and remove/or deletion) from core module code into
kernel/module/livepatch.c. At the moment it contains code to
persist Elf information about a given livepatch module, only.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile    |  1 +
 kernel/module/internal.h  | 12 ++++++
 kernel/module/livepatch.c | 75 +++++++++++++++++++++++++++++++++
 kernel/module/main.c      | 89 +--------------------------------------
 4 files changed, 89 insertions(+), 88 deletions(-)
 create mode 100644 kernel/module/livepatch.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index a9cf6e822075..47d70bb18da3 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -6,3 +6,4 @@
 obj-$(CONFIG_MODULES) += main.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
+obj-$(CONFIG_LIVEPATCH) += livepatch.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index ffc50df010a7..91ef152aeffb 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -51,3 +51,15 @@ struct load_info {
 };
 
 extern int mod_verify_sig(const void *mod, struct load_info *info);
+
+#ifdef CONFIG_LIVEPATCH
+extern int copy_module_elf(struct module *mod, struct load_info *info);
+extern void free_module_elf(struct module *mod);
+extern int check_modinfo_livepatch(struct module *mod, struct load_info *info);
+#else /* !CONFIG_LIVEPATCH */
+static inline int copy_module_elf(struct module *mod, struct load_info *info)
+{
+	return 0;
+}
+static inline void free_module_elf(struct module *mod) { }
+#endif /* CONFIG_LIVEPATCH */
diff --git a/kernel/module/livepatch.c b/kernel/module/livepatch.c
new file mode 100644
index 000000000000..e147f5418327
--- /dev/null
+++ b/kernel/module/livepatch.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * kernel/module/livepatch.c - module livepatch support
+ *
+ * Copyright (C) 2016 Jessica Yu <jeyu@redhat.com>
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+/*
+ * Persist Elf information about a module. Copy the Elf header,
+ * section header table, section string table, and symtab section
+ * index from info to mod->klp_info.
+ */
+int copy_module_elf(struct module *mod, struct load_info *info)
+{
+	unsigned int size, symndx;
+	int ret;
+
+	size = sizeof(*mod->klp_info);
+	mod->klp_info = kmalloc(size, GFP_KERNEL);
+	if (mod->klp_info == NULL)
+		return -ENOMEM;
+
+	/* Elf header */
+	size = sizeof(mod->klp_info->hdr);
+	memcpy(&mod->klp_info->hdr, info->hdr, size);
+
+	/* Elf section header table */
+	size = sizeof(*info->sechdrs) * info->hdr->e_shnum;
+	mod->klp_info->sechdrs = kmemdup(info->sechdrs, size, GFP_KERNEL);
+	if (mod->klp_info->sechdrs == NULL) {
+		ret = -ENOMEM;
+		goto free_info;
+	}
+
+	/* Elf section name string table */
+	size = info->sechdrs[info->hdr->e_shstrndx].sh_size;
+	mod->klp_info->secstrings = kmemdup(info->secstrings, size, GFP_KERNEL);
+	if (mod->klp_info->secstrings == NULL) {
+		ret = -ENOMEM;
+		goto free_sechdrs;
+	}
+
+	/* Elf symbol section index */
+	symndx = info->index.sym;
+	mod->klp_info->symndx = symndx;
+
+	/*
+	 * For livepatch modules, core_kallsyms.symtab is a complete
+	 * copy of the original symbol table. Adjust sh_addr to point
+	 * to core_kallsyms.symtab since the copy of the symtab in module
+	 * init memory is freed at the end of do_init_module().
+	 */
+	mod->klp_info->sechdrs[symndx].sh_addr = \
+		(unsigned long) mod->core_kallsyms.symtab;
+
+	return 0;
+
+free_sechdrs:
+	kfree(mod->klp_info->sechdrs);
+free_info:
+	kfree(mod->klp_info);
+	return ret;
+}
+
+void free_module_elf(struct module *mod)
+{
+	kfree(mod->klp_info->sechdrs);
+	kfree(mod->klp_info->secstrings);
+	kfree(mod->klp_info);
+}
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 2a6b859716c0..9bcaf251e109 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2043,81 +2043,6 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 }
 #endif /*  CONFIG_STRICT_MODULE_RWX */
 
-#ifdef CONFIG_LIVEPATCH
-/*
- * Persist Elf information about a module. Copy the Elf header,
- * section header table, section string table, and symtab section
- * index from info to mod->klp_info.
- */
-static int copy_module_elf(struct module *mod, struct load_info *info)
-{
-	unsigned int size, symndx;
-	int ret;
-
-	size = sizeof(*mod->klp_info);
-	mod->klp_info = kmalloc(size, GFP_KERNEL);
-	if (mod->klp_info == NULL)
-		return -ENOMEM;
-
-	/* Elf header */
-	size = sizeof(mod->klp_info->hdr);
-	memcpy(&mod->klp_info->hdr, info->hdr, size);
-
-	/* Elf section header table */
-	size = sizeof(*info->sechdrs) * info->hdr->e_shnum;
-	mod->klp_info->sechdrs = kmemdup(info->sechdrs, size, GFP_KERNEL);
-	if (mod->klp_info->sechdrs == NULL) {
-		ret = -ENOMEM;
-		goto free_info;
-	}
-
-	/* Elf section name string table */
-	size = info->sechdrs[info->hdr->e_shstrndx].sh_size;
-	mod->klp_info->secstrings = kmemdup(info->secstrings, size, GFP_KERNEL);
-	if (mod->klp_info->secstrings == NULL) {
-		ret = -ENOMEM;
-		goto free_sechdrs;
-	}
-
-	/* Elf symbol section index */
-	symndx = info->index.sym;
-	mod->klp_info->symndx = symndx;
-
-	/*
-	 * For livepatch modules, core_kallsyms.symtab is a complete
-	 * copy of the original symbol table. Adjust sh_addr to point
-	 * to core_kallsyms.symtab since the copy of the symtab in module
-	 * init memory is freed at the end of do_init_module().
-	 */
-	mod->klp_info->sechdrs[symndx].sh_addr = \
-		(unsigned long) mod->core_kallsyms.symtab;
-
-	return 0;
-
-free_sechdrs:
-	kfree(mod->klp_info->sechdrs);
-free_info:
-	kfree(mod->klp_info);
-	return ret;
-}
-
-static void free_module_elf(struct module *mod)
-{
-	kfree(mod->klp_info->sechdrs);
-	kfree(mod->klp_info->secstrings);
-	kfree(mod->klp_info);
-}
-#else /* !CONFIG_LIVEPATCH */
-static int copy_module_elf(struct module *mod, struct load_info *info)
-{
-	return 0;
-}
-
-static void free_module_elf(struct module *mod)
-{
-}
-#endif /* CONFIG_LIVEPATCH */
-
 void __weak module_memfree(void *module_region)
 {
 	/*
@@ -3052,19 +2977,7 @@ static int copy_chunked_from_user(void *dst, const void __user *usrc, unsigned l
 	return 0;
 }
 
-#ifdef CONFIG_LIVEPATCH
-static int check_modinfo_livepatch(struct module *mod, struct load_info *info)
-{
-	if (get_modinfo(info, "livepatch")) {
-		mod->klp = true;
-		add_taint_module(mod, TAINT_LIVEPATCH, LOCKDEP_STILL_OK);
-		pr_notice_once("%s: tainting kernel with TAINT_LIVEPATCH\n",
-			       mod->name);
-	}
-
-	return 0;
-}
-#else /* !CONFIG_LIVEPATCH */
+#ifndef CONFIG_LIVEPATCH
 static int check_modinfo_livepatch(struct module *mod, struct load_info *info)
 {
 	if (get_modinfo(info, "livepatch")) {
-- 
2.31.1

