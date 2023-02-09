Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CB5C61DA4
	for <linux-modules@archiver.kernel.org>; Thu,  9 Feb 2023 17:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBIR5P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 9 Feb 2023 12:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBIR5N (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 9 Feb 2023 12:57:13 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E84A272D
        for <linux-modules@vger.kernel.org>; Thu,  9 Feb 2023 09:57:07 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319HqNWY019599
        for <linux-modules@vger.kernel.org>; Thu, 9 Feb 2023 09:57:06 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nn1bxjbhx-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-modules@vger.kernel.org>; Thu, 09 Feb 2023 09:57:06 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Feb 2023 09:57:05 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 4F06D1595E9D7; Thu,  9 Feb 2023 09:56:53 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hch@lst.de>, <kernel-team@meta.com>, Song Liu <song@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] module: clean-up for module_memory
Date:   Thu, 9 Feb 2023 09:56:53 -0800
Message-ID: <20230209175653.2275559-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 00oB0HrvP_RyeG94keClKtCVLAOhoaG5
X-Proofpoint-GUID: 00oB0HrvP_RyeG94keClKtCVLAOhoaG5
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_13,2023-02-09_03,2023-02-09_01
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Three changes here:

1. Shorter variable names in arch/arc/kernel/unwind.c:unwind_add_table, to
   make it easier to read.
2. Rewrite free_mod_mem() so it is more obvious that MOD_DATA need to be
   freed last.
3. Clean up the use of CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Song Liu <song@kernel.org>

---

This is the follow up patch on top of [1]. I would recommend fold this
into [1].

[1] https://lore.kernel.org/linux-modules/20230207002802.2514802-1-song@kernel.org/T/#u
---
 arch/arc/kernel/unwind.c | 15 ++++------
 kernel/module/main.c     | 61 +++++++++++-----------------------------
 2 files changed, 22 insertions(+), 54 deletions(-)

diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 933451f4494f..9270d0a713c3 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -369,8 +369,8 @@ void *unwind_add_table(struct module *module, const void *table_start,
 		       unsigned long table_size)
 {
 	struct unwind_table *table;
-	struct module_memory *mod_mem_core_text;
-	struct module_memory *mod_mem_init_text;
+	struct module_memory *core_text;
+	struct module_memory *init_text;
 
 	if (table_size <= 0)
 		return NULL;
@@ -379,14 +379,11 @@ void *unwind_add_table(struct module *module, const void *table_start,
 	if (!table)
 		return NULL;
 
-	mod_mem_core_text = &module->mem[MOD_TEXT];
-	mod_mem_init_text = &module->mem[MOD_INIT_TEXT];
+	core_text = &module->mem[MOD_TEXT];
+	init_text = &module->mem[MOD_INIT_TEXT];
 
-	init_unwind_table(table, module->name,
-			  mod_mem_core_text->base, mod_mem_core_text->size,
-			  mod_mem_init_text->base, mod_mem_init_text->size,
-			  table_start, table_size,
-			  NULL, 0);
+	init_unwind_table(table, module->name, core_text->base, core_text->size,
+			  init_text->base, init_text->size, table_start, table_size, NULL, 0);
 
 	init_unwind_hdr(table, unw_hdr_alloc);
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c598f11e7016..2724bc1b9a90 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -927,26 +927,17 @@ static ssize_t store_uevent(struct module_attribute *mattr,
 struct module_attribute module_uevent =
 	__ATTR(uevent, 0200, NULL, store_uevent);
 
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-
-static ssize_t show_coresize(struct module_attribute *mattr,
-			     struct module_kobject *mk, char *buffer)
-{
-	return sprintf(buffer, "%u\n", mk->mod->mem[MOD_TEXT].size);
-}
-
-#else
-
 static ssize_t show_coresize(struct module_attribute *mattr,
 			     struct module_kobject *mk, char *buffer)
 {
-	unsigned int size = 0;
+	unsigned int size = mk->mod->mem[MOD_TEXT].size;
 
-	for_class_mod_mem_type(type, core)
-		size += mk->mod->mem[type].size;
+	if (!IS_ENABLED(CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC)) {
+		for_class_mod_mem_type(type, core_data)
+			size += mk->mod->mem[type].size;
+	}
 	return sprintf(buffer, "%u\n", size);
 }
-#endif
 
 static struct module_attribute modinfo_coresize =
 	__ATTR(coresize, 0444, show_coresize, NULL);
@@ -1170,17 +1161,11 @@ void __weak module_arch_freeing_init(struct module *mod)
 {
 }
 
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
 static bool mod_mem_use_vmalloc(enum mod_mem_type type)
 {
-	return mod_mem_type_is_core_data(type);
-}
-#else
-static bool mod_mem_use_vmalloc(enum mod_mem_type type)
-{
-	return false;
+	return IS_ENABLED(CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC) &&
+		mod_mem_type_is_core_data(type);
 }
-#endif
 
 static void *module_memory_alloc(unsigned int size, enum mod_mem_type type)
 {
@@ -1199,34 +1184,21 @@ static void module_memory_free(void *ptr, enum mod_mem_type type)
 
 static void free_mod_mem(struct module *mod)
 {
-	/* free the memory in the right order to avoid use-after-free */
-	static enum mod_mem_type mod_mem_free_order[MOD_MEM_NUM_TYPES] = {
-		/* first free init sections */
-		MOD_INIT_TEXT,
-		MOD_INIT_DATA,
-		MOD_INIT_RODATA,
-
-		/* then core sections, except rw data */
-		MOD_TEXT,
-		MOD_RODATA,
-		MOD_RO_AFTER_INIT,
-
-		/* rw data need to be freed last, as it hosts mod */
-		MOD_DATA,
-	};
-	int i;
-
-	BUILD_BUG_ON(ARRAY_SIZE(mod_mem_free_order) != MOD_MEM_NUM_TYPES);
-
-	for (i = 0; i < MOD_MEM_NUM_TYPES; i++) {
-		enum mod_mem_type type = mod_mem_free_order[i];
+	for_each_mod_mem_type(type) {
 		struct module_memory *mod_mem = &mod->mem[type];
 
+		if (type == MOD_DATA)
+			continue;
+
 		/* Free lock-classes; relies on the preceding sync_rcu(). */
 		lockdep_free_key_range(mod_mem->base, mod_mem->size);
 		if (mod_mem->size)
 			module_memory_free(mod_mem->base, type);
 	}
+
+	/* MOD_DATA hosts mod, so free it at last */
+	lockdep_free_key_range(mod->mem[MOD_DATA].base, mod->mem[MOD_DATA].size);
+	module_memory_free(mod->mem[MOD_DATA].base, MOD_DATA);
 }
 
 /* Free a module, remove from lists, etc. */
@@ -2211,8 +2183,7 @@ static int move_module(struct module *mod, struct load_info *info)
 		if (!(shdr->sh_flags & SHF_ALLOC))
 			continue;
 
-		dest = mod->mem[type].base +
-			(shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK);
+		dest = mod->mem[type].base + (shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK);
 
 		if (shdr->sh_type != SHT_NOBITS)
 			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
-- 
2.30.2

