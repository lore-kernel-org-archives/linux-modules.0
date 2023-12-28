Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0738480
	for <linux-modules@vger.kernel.org>; Thu, 28 Dec 2023 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T185x5mvkz6J9Zb;
	Thu, 28 Dec 2023 21:11:17 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 83DD7140B67;
	Thu, 28 Dec 2023 21:13:00 +0800 (CST)
Received: from mscphis00060.huawei.com (10.123.65.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:12:58 +0000
From: <artem.kuzin@huawei.com>
To: <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <akpm@linux-foundation.org>,
	<urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<mcgrof@kernel.org>, <rmk+kernel@armlinux.org.uk>
CC: <nikita.panov@huawei-partners.com>, <alexander.grubnikov@huawei.com>,
	<stepanov.anatoly@huawei.com>, <guohanjun@huawei.com>,
	<weiyongjun1@huawei.com>, <wangkefeng.wang@huawei.com>,
	<judy.chenhui@huawei.com>, <yusongping@huawei.com>, <kang.sun@huawei.com>,
	<linux-mm@kvack.org>, <linux-modules@vger.kernel.org>
Subject: [PATCH RFC 11/12] x86: add kernel modules text and rodata replication support
Date: Thu, 28 Dec 2023 21:10:55 +0800
Message-ID: <20231228131056.602411-12-artem.kuzin@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228131056.602411-1-artem.kuzin@huawei.com>
References: <20231228131056.602411-1-artem.kuzin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 lhrpeml500001.china.huawei.com (7.191.163.213)

From: Artem Kuzin <artem.kuzin@huawei.com>

Co-developed-by: Nikita Panov <nikita.panov@huawei-partners.com>
Signed-off-by: Nikita Panov <nikita.panov@huawei-partners.com>
Co-developed-by: Alexander Grubnikov <alexander.grubnikov@huawei.com>
Signed-off-by: Alexander Grubnikov <alexander.grubnikov@huawei.com>
Signed-off-by: Artem Kuzin <artem.kuzin@huawei.com>
---
 arch/x86/kernel/module.c     | 35 ++++++++++++++++++++++++++++++-----
 include/linux/moduleloader.h | 10 ++++++++++
 kernel/module/main.c         |  8 ++++++++
 kernel/module/strict_rwx.c   | 14 +++++++-------
 4 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 5f71a0cf4399..6d74d8c33293 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -65,28 +65,53 @@ static unsigned long int get_module_load_offset(void)
 }
 #endif
 
-void *module_alloc(unsigned long size)
+static void *__module_alloc(unsigned long size, unsigned long vm_flags, int nid)
 {
 	gfp_t gfp_mask = GFP_KERNEL;
 	void *p;
 
 	if (PAGE_ALIGN(size) > MODULES_LEN)
 		return NULL;
-
+	/*
+	 * In case replicas vmalloc should be able to unmap/reclaim them
+	 * somehow. Due to this fact it is necessary to account suck pages
+	 * separately. __vmalloc_not_replicated_per_pgd_range() function
+	 * perform this accounting using internal vmalloc buffer with size
+	 * equal to nr_pages * nr_online_nodes.
+	 */
 	p = __vmalloc_node_range(size, MODULE_ALIGN,
 				 MODULES_VADDR + get_module_load_offset(),
 				 MODULES_END, gfp_mask, PAGE_KERNEL,
-				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
-				 NUMA_NO_NODE, __builtin_return_address(0));
+				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK | vm_flags,
+				 nid, __builtin_return_address(0));
 
 	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
 		vfree(p);
 		return NULL;
 	}
-
 	return p;
 }
 
+#ifdef CONFIG_KERNEL_REPLICATION
+void *module_alloc(unsigned long size)
+{
+	return __module_alloc(size, VM_NUMA_SHARED, 0);
+}
+
+void module_replicate_numa(void *ptr)
+{
+	gfp_t gfp_mask = GFP_KERNEL;
+
+	__vmalloc_node_replicate_range(ptr, gfp_mask,
+			PAGE_KERNEL, VM_DEFER_KMEMLEAK);
+}
+#else
+void *module_alloc(unsigned long size)
+{
+	return __module_alloc(size, 0, NUMA_NO_NODE);
+}
+#endif /*CONFIG_KERNEL_REPLICATION*/
+
 #ifdef CONFIG_X86_32
 int apply_relocate(Elf32_Shdr *sechdrs,
 		   const char *strtab,
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 001b2ce83832..722016d36bda 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -29,6 +29,16 @@ unsigned int arch_mod_section_prepend(struct module *mod, unsigned int section);
    sections.  Returns NULL on failure. */
 void *module_alloc(unsigned long size);
 
+#ifndef CONFIG_KERNEL_REPLICATION
+static inline void module_replicate_numa(void *ptr)
+{
+	(void) ptr;
+}
+#else
+/* Replicate memory allocated in previous function*/
+void module_replicate_numa(void *ptr);
+#endif /* CONFIG_KERNEL_REPLICATION */
+
 /* Free memory returned from module_alloc. */
 void module_memfree(void *module_region);
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fedfdb8db5..2ece8a7743de 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2718,6 +2718,12 @@ static int add_unformed_module(struct module *mod)
 	return err;
 }
 
+static void module_replicate_rodata(struct module *mod)
+{
+	module_replicate_numa(mod->mem[MOD_TEXT].base);
+	module_replicate_numa(mod->mem[MOD_RODATA].base);
+}
+
 static int complete_formation(struct module *mod, struct load_info *info)
 {
 	int err;
@@ -2733,6 +2739,8 @@ static int complete_formation(struct module *mod, struct load_info *info)
 	module_bug_finalize(info->hdr, info->sechdrs, mod);
 	module_cfi_finalize(info->hdr, info->sechdrs, mod);
 
+	module_replicate_rodata(mod);
+
 	module_enable_ro(mod, false);
 	module_enable_nx(mod);
 	module_enable_x(mod);
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index a2b656b4e3d2..23abb3b0520b 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -29,7 +29,7 @@ static void module_set_memory(const struct module *mod, enum mod_mem_type type,
 void module_enable_x(const struct module *mod)
 {
 	for_class_mod_mem_type(type, text)
-		module_set_memory(mod, type, set_memory_x);
+		module_set_memory(mod, type, numa_set_memory_x);
 }
 
 void module_enable_ro(const struct module *mod, bool after_init)
@@ -41,13 +41,13 @@ void module_enable_ro(const struct module *mod, bool after_init)
 		return;
 #endif
 
-	module_set_memory(mod, MOD_TEXT, set_memory_ro);
-	module_set_memory(mod, MOD_INIT_TEXT, set_memory_ro);
-	module_set_memory(mod, MOD_RODATA, set_memory_ro);
-	module_set_memory(mod, MOD_INIT_RODATA, set_memory_ro);
+	module_set_memory(mod, MOD_TEXT, numa_set_memory_ro);
+	module_set_memory(mod, MOD_INIT_TEXT, numa_set_memory_ro);
+	module_set_memory(mod, MOD_RODATA, numa_set_memory_ro);
+	module_set_memory(mod, MOD_INIT_RODATA, numa_set_memory_ro);
 
 	if (after_init)
-		module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
+		module_set_memory(mod, MOD_RO_AFTER_INIT, numa_set_memory_ro);
 }
 
 void module_enable_nx(const struct module *mod)
@@ -56,7 +56,7 @@ void module_enable_nx(const struct module *mod)
 		return;
 
 	for_class_mod_mem_type(type, data)
-		module_set_memory(mod, type, set_memory_nx);
+		module_set_memory(mod, type, numa_set_memory_nx);
 }
 
 int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
-- 
2.34.1

