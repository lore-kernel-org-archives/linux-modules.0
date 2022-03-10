Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCCEC433EF
	for <linux-modules@archiver.kernel.org>; Thu, 10 Mar 2022 10:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiCJK2G (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 10 Mar 2022 05:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237904AbiCJK1i (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 10 Mar 2022 05:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0E9413DE3C
        for <linux-modules@vger.kernel.org>; Thu, 10 Mar 2022 02:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646907995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SiYMP4DA9TozF4xuyhOCEQgRS/pjqscFIVWb9t8F7R4=;
        b=Nz/j69XdzGRzuOboaHcr6VYZ573JYht+81VvNLMUvs8BcHignIdFidnKdQngmzcXuzB0D1
        qpAd1LyPDBxpvrH1FtWpKguXdX8QLmSgvqvge/NQHf8Q/3Dpruw16ahPg+jPlCO0g4EJOU
        +6/1Gu80XwoRkbsBm9jRNw7R7ebxIQY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-pnrIY9ocOPiGi_sGLfVGiQ-1; Thu, 10 Mar 2022 05:26:34 -0500
X-MC-Unique: pnrIY9ocOPiGi_sGLfVGiQ-1
Received: by mail-wm1-f71.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so2110519wmj.5
        for <linux-modules@vger.kernel.org>; Thu, 10 Mar 2022 02:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SiYMP4DA9TozF4xuyhOCEQgRS/pjqscFIVWb9t8F7R4=;
        b=ERIZKqOulFIiEl6I75xpw9mhk4XLl420Hm1lVRnGgvgC6JOKznZK+PSnB9FYkO39zp
         7zbEBBYXhzXxJ2cCPJm5lVO+sHtn3Kei2yK7tMzXCxGq4VXnDepb+73hW69/6mqgDLLY
         3oYd+Iejf2gPlMoaT1ZOBNT54+QxkZzQpNlynA5HIncRq7bpMkIjB9tvNIASSRxhej/y
         BIH3ONET5jSzGjvDHyuqjeijQLZbvFb4XwLSmQOBXkIxtc6ZiIkNo8FCctiJcr1Npbzb
         GPLtr9i4aLNdOP/5tsQ+rTeV7Cri3RM3C8vucSKZiByli6ML3YtU1XeRrzz5TR+wHIty
         HPTg==
X-Gm-Message-State: AOAM530Ohf+zSsBe7a+XhkuTXbVt3fACxRN5WCNVUfPwfDD9lAzQyE2+
        2EJIAXu/AF9yz8NdY9Ldp6kmYkITQlCCbSntWCBTmpeUuwlK8yMQfmVLGIMc27OBsMAp5QfosGq
        mayPPTdIdONaDq2ABRgUzBxE4
X-Received: by 2002:a05:6000:1449:b0:1fc:a870:4b85 with SMTP id v9-20020a056000144900b001fca8704b85mr2921185wrx.639.1646907992542;
        Thu, 10 Mar 2022 02:26:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8AyaX1c3nqNbd1JC/xs70TfJRRJmJwKa6/Gw6WGEaralc3eMV0ipJ3kU7lYRUpiamxwzjgQ==
X-Received: by 2002:a05:6000:1449:b0:1fc:a870:4b85 with SMTP id v9-20020a056000144900b001fca8704b85mr2921172wrx.639.1646907992275;
        Thu, 10 Mar 2022 02:26:32 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6707000000b001f067c7b47fsm6110460wru.27.2022.03.10.02.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 02:26:31 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: [PATCH v11 14/14] module: Move version support into a separate file
Date:   Thu, 10 Mar 2022 10:26:25 +0000
Message-Id: <20220310102625.3441888-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220310102625.3441888-1-atomlin@redhat.com>
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102625.3441888-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch migrates module version support out of core code into
kernel/module/version.c. In addition simple code refactoring to
make this possible.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile   |   1 +
 kernel/module/internal.h |  48 ++++++++++++
 kernel/module/main.c     | 156 ++-------------------------------------
 kernel/module/version.c  | 109 +++++++++++++++++++++++++++
 4 files changed, 166 insertions(+), 148 deletions(-)
 create mode 100644 kernel/module/version.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 88f5cdcdb067..e2eff9853a28 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PROC_FS) += procfs.o
 obj-$(CONFIG_SYSFS) += sysfs.o
 obj-$(CONFIG_KGDB_KDB) += kdb.o
+obj-$(CONFIG_MODVERSIONS) += version.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 62d749ef695e..3fc139d5074b 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -70,7 +70,27 @@ struct load_info {
 	} index;
 };
 
+enum mod_license {
+	NOT_GPL_ONLY,
+	GPL_ONLY,
+};
+
+struct find_symbol_arg {
+	/* Input */
+	const char *name;
+	bool gplok;
+	bool warn;
+
+	/* Output */
+	struct module *owner;
+	const s32 *crc;
+	const struct kernel_symbol *sym;
+	enum mod_license license;
+};
+
 int mod_verify_sig(const void *mod, struct load_info *info);
+int try_to_force_load(struct module *mod, const char *reason);
+bool find_symbol(struct find_symbol_arg *fsa);
 struct module *find_module_all(const char *name, size_t len, bool even_unformed);
 int cmp_name(const void *name, const void *sym);
 long module_get_offset(struct module *mod, unsigned int *size, Elf_Shdr *sechdr,
@@ -225,3 +245,31 @@ static inline int mod_sysfs_setup(struct module *mod,
 static inline void mod_sysfs_teardown(struct module *mod) { }
 static inline void init_param_lock(struct module *mod) { }
 #endif /* CONFIG_SYSFS */
+
+#ifdef CONFIG_MODVERSIONS
+int check_version(const struct load_info *info,
+		  const char *symname, struct module *mod, const s32 *crc);
+void module_layout(struct module *mod, struct modversion_info *ver, struct kernel_param *kp,
+		   struct kernel_symbol *ks, struct tracepoint * const *tp);
+int check_modstruct_version(const struct load_info *info, struct module *mod);
+int same_magic(const char *amagic, const char *bmagic, bool has_crcs);
+#else /* !CONFIG_MODVERSIONS */
+static inline int check_version(const struct load_info *info,
+				const char *symname,
+				struct module *mod,
+				const s32 *crc)
+{
+	return 1;
+}
+
+static inline int check_modstruct_version(const struct load_info *info,
+					  struct module *mod)
+{
+	return 1;
+}
+
+static inline int same_magic(const char *amagic, const char *bmagic, bool has_crcs)
+{
+	return strcmp(amagic, bmagic) == 0;
+}
+#endif /* CONFIG_MODVERSIONS */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index bcc4f7a82649..0749afdc34b5 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -86,6 +86,12 @@ struct mod_tree_root mod_tree __cacheline_aligned = {
 static unsigned long module_addr_min = -1UL, module_addr_max;
 #endif /* CONFIG_MODULES_TREE_LOOKUP */
 
+struct symsearch {
+	const struct kernel_symbol *start, *stop;
+	const s32 *crcs;
+	enum mod_license license;
+};
+
 /*
  * Bounds of module text, for speeding up __module_address.
  * Protected by module_mutex.
@@ -244,28 +250,6 @@ static __maybe_unused void *any_section_objs(const struct load_info *info,
 #define symversion(base, idx) ((base != NULL) ? ((base) + (idx)) : NULL)
 #endif
 
-struct symsearch {
-	const struct kernel_symbol *start, *stop;
-	const s32 *crcs;
-	enum mod_license {
-		NOT_GPL_ONLY,
-		GPL_ONLY,
-	} license;
-};
-
-struct find_symbol_arg {
-	/* Input */
-	const char *name;
-	bool gplok;
-	bool warn;
-
-	/* Output */
-	struct module *owner;
-	const s32 *crc;
-	const struct kernel_symbol *sym;
-	enum mod_license license;
-};
-
 static bool check_exported_symbol(const struct symsearch *syms,
 				  struct module *owner,
 				  unsigned int symnum, void *data)
@@ -327,7 +311,7 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
  * Find an exported symbol and return it, along with, (optional) crc and
  * (optional) module which owns it.  Needs preempt disabled or module_mutex.
  */
-static bool find_symbol(struct find_symbol_arg *fsa)
+bool find_symbol(struct find_symbol_arg *fsa)
 {
 	static const struct symsearch arr[] = {
 		{ __start___ksymtab, __stop___ksymtab, __start___kcrctab,
@@ -1001,7 +985,7 @@ size_t modinfo_attrs_count = ARRAY_SIZE(modinfo_attrs);
 
 static const char vermagic[] = VERMAGIC_STRING;
 
-static int try_to_force_load(struct module *mod, const char *reason)
+int try_to_force_load(struct module *mod, const char *reason)
 {
 #ifdef CONFIG_MODULE_FORCE_LOAD
 	if (!test_taint(TAINT_FORCED_MODULE))
@@ -1013,115 +997,6 @@ static int try_to_force_load(struct module *mod, const char *reason)
 #endif
 }
 
-#ifdef CONFIG_MODVERSIONS
-
-static u32 resolve_rel_crc(const s32 *crc)
-{
-	return *(u32 *)((void *)crc + *crc);
-}
-
-static int check_version(const struct load_info *info,
-			 const char *symname,
-			 struct module *mod,
-			 const s32 *crc)
-{
-	Elf_Shdr *sechdrs = info->sechdrs;
-	unsigned int versindex = info->index.vers;
-	unsigned int i, num_versions;
-	struct modversion_info *versions;
-
-	/* Exporting module didn't supply crcs?  OK, we're already tainted. */
-	if (!crc)
-		return 1;
-
-	/* No versions at all?  modprobe --force does this. */
-	if (versindex == 0)
-		return try_to_force_load(mod, symname) == 0;
-
-	versions = (void *) sechdrs[versindex].sh_addr;
-	num_versions = sechdrs[versindex].sh_size
-		/ sizeof(struct modversion_info);
-
-	for (i = 0; i < num_versions; i++) {
-		u32 crcval;
-
-		if (strcmp(versions[i].name, symname) != 0)
-			continue;
-
-		if (IS_ENABLED(CONFIG_MODULE_REL_CRCS))
-			crcval = resolve_rel_crc(crc);
-		else
-			crcval = *crc;
-		if (versions[i].crc == crcval)
-			return 1;
-		pr_debug("Found checksum %X vs module %lX\n",
-			 crcval, versions[i].crc);
-		goto bad_version;
-	}
-
-	/* Broken toolchain. Warn once, then let it go.. */
-	pr_warn_once("%s: no symbol version for %s\n", info->name, symname);
-	return 1;
-
-bad_version:
-	pr_warn("%s: disagrees about version of symbol %s\n",
-	       info->name, symname);
-	return 0;
-}
-
-static inline int check_modstruct_version(const struct load_info *info,
-					  struct module *mod)
-{
-	struct find_symbol_arg fsa = {
-		.name	= "module_layout",
-		.gplok	= true,
-	};
-
-	/*
-	 * Since this should be found in kernel (which can't be removed), no
-	 * locking is necessary -- use preempt_disable() to placate lockdep.
-	 */
-	preempt_disable();
-	if (!find_symbol(&fsa)) {
-		preempt_enable();
-		BUG();
-	}
-	preempt_enable();
-	return check_version(info, "module_layout", mod, fsa.crc);
-}
-
-/* First part is kernel version, which we ignore if module has crcs. */
-static inline int same_magic(const char *amagic, const char *bmagic,
-			     bool has_crcs)
-{
-	if (has_crcs) {
-		amagic += strcspn(amagic, " ");
-		bmagic += strcspn(bmagic, " ");
-	}
-	return strcmp(amagic, bmagic) == 0;
-}
-#else
-static inline int check_version(const struct load_info *info,
-				const char *symname,
-				struct module *mod,
-				const s32 *crc)
-{
-	return 1;
-}
-
-static inline int check_modstruct_version(const struct load_info *info,
-					  struct module *mod)
-{
-	return 1;
-}
-
-static inline int same_magic(const char *amagic, const char *bmagic,
-			     bool has_crcs)
-{
-	return strcmp(amagic, bmagic) == 0;
-}
-#endif /* CONFIG_MODVERSIONS */
-
 static char *get_modinfo(const struct load_info *info, const char *tag);
 static char *get_next_modinfo(const struct load_info *info, const char *tag,
 			      char *prev);
@@ -3247,18 +3122,3 @@ void print_modules(void)
 		pr_cont(" [last unloaded: %s]", last_unloaded_module);
 	pr_cont("\n");
 }
-
-#ifdef CONFIG_MODVERSIONS
-/*
- * Generate the signature for all relevant module structures here.
- * If these change, we don't want to try to parse the module.
- */
-void module_layout(struct module *mod,
-		   struct modversion_info *ver,
-		   struct kernel_param *kp,
-		   struct kernel_symbol *ks,
-		   struct tracepoint * const *tp)
-{
-}
-EXPORT_SYMBOL(module_layout);
-#endif
diff --git a/kernel/module/version.c b/kernel/module/version.c
new file mode 100644
index 000000000000..adaedce1dc97
--- /dev/null
+++ b/kernel/module/version.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module version support
+ *
+ * Copyright (C) 2008 Rusty Russell
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/printk.h>
+#include "internal.h"
+
+static u32 resolve_rel_crc(const s32 *crc)
+{
+	return *(u32 *)((void *)crc + *crc);
+}
+
+int check_version(const struct load_info *info,
+		  const char *symname,
+			 struct module *mod,
+			 const s32 *crc)
+{
+	Elf_Shdr *sechdrs = info->sechdrs;
+	unsigned int versindex = info->index.vers;
+	unsigned int i, num_versions;
+	struct modversion_info *versions;
+
+	/* Exporting module didn't supply crcs?  OK, we're already tainted. */
+	if (!crc)
+		return 1;
+
+	/* No versions at all?  modprobe --force does this. */
+	if (versindex == 0)
+		return try_to_force_load(mod, symname) == 0;
+
+	versions = (void *)sechdrs[versindex].sh_addr;
+	num_versions = sechdrs[versindex].sh_size
+		/ sizeof(struct modversion_info);
+
+	for (i = 0; i < num_versions; i++) {
+		u32 crcval;
+
+		if (strcmp(versions[i].name, symname) != 0)
+			continue;
+
+		if (IS_ENABLED(CONFIG_MODULE_REL_CRCS))
+			crcval = resolve_rel_crc(crc);
+		else
+			crcval = *crc;
+		if (versions[i].crc == crcval)
+			return 1;
+		pr_debug("Found checksum %X vs module %lX\n",
+			 crcval, versions[i].crc);
+		goto bad_version;
+	}
+
+	/* Broken toolchain. Warn once, then let it go.. */
+	pr_warn_once("%s: no symbol version for %s\n", info->name, symname);
+	return 1;
+
+bad_version:
+	pr_warn("%s: disagrees about version of symbol %s\n", info->name, symname);
+	return 0;
+}
+
+int check_modstruct_version(const struct load_info *info,
+			    struct module *mod)
+{
+	struct find_symbol_arg fsa = {
+		.name	= "module_layout",
+		.gplok	= true,
+	};
+
+	/*
+	 * Since this should be found in kernel (which can't be removed), no
+	 * locking is necessary -- use preempt_disable() to placate lockdep.
+	 */
+	preempt_disable();
+	if (!find_symbol(&fsa)) {
+		preempt_enable();
+		BUG();
+	}
+	preempt_enable();
+	return check_version(info, "module_layout", mod, fsa.crc);
+}
+
+/* First part is kernel version, which we ignore if module has crcs. */
+int same_magic(const char *amagic, const char *bmagic,
+	       bool has_crcs)
+{
+	if (has_crcs) {
+		amagic += strcspn(amagic, " ");
+		bmagic += strcspn(bmagic, " ");
+	}
+	return strcmp(amagic, bmagic) == 0;
+}
+
+/*
+ * Generate the signature for all relevant module structures here.
+ * If these change, we don't want to try to parse the module.
+ */
+void module_layout(struct module *mod,
+		   struct modversion_info *ver,
+		   struct kernel_param *kp,
+		   struct kernel_symbol *ks,
+		   struct tracepoint * const *tp)
+{
+}
+EXPORT_SYMBOL(module_layout);
-- 
2.34.1

