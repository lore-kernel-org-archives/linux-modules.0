Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC08465
	for <linux-modules@vger.kernel.org>; Thu, 28 Dec 2023 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T186L6mJxz6K5xf;
	Thu, 28 Dec 2023 21:11:38 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id F0A241408F9;
	Thu, 28 Dec 2023 21:12:45 +0800 (CST)
Received: from mscphis00060.huawei.com (10.123.65.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:12:44 +0000
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
Subject: [PATCH RFC 03/12] mm: per-NUMA node replication core infrastructure
Date: Thu, 28 Dec 2023 21:10:47 +0800
Message-ID: <20231228131056.602411-4-artem.kuzin@huawei.com>
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
 arch/x86/include/asm/numa_replication.h |  42 ++
 arch/x86/include/asm/pgalloc.h          |  10 +
 include/linux/mm.h                      |  79 +++-
 include/linux/numa_replication.h        |  85 ++++
 mm/Makefile                             |   1 +
 mm/memory.c                             | 251 ++++++++++-
 mm/numa_replication.c                   | 564 ++++++++++++++++++++++++
 7 files changed, 1021 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/include/asm/numa_replication.h
 create mode 100644 include/linux/numa_replication.h
 create mode 100644 mm/numa_replication.c

diff --git a/arch/x86/include/asm/numa_replication.h b/arch/x86/include/asm/numa_replication.h
new file mode 100644
index 000000000000..ba1b5bc7f6f1
--- /dev/null
+++ b/arch/x86/include/asm/numa_replication.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_X86_NUMA_REPLICATION_H
+#define _ASM_X86_NUMA_REPLICATION_H
+
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+#include <asm/pgtable_64_types.h>
+
+/* Replicated region of kernel space */
+#define PAGE_TABLE_REPLICATION_LEFT  (0xffffffffffffffff - (SZ_2G - 1))
+#define PAGE_TABLE_REPLICATION_RIGHT (0xffffffffffffffff)
+
+static inline pgd_t *numa_replicate_pgt_pgd(int nid)
+{
+	pgd_t *new_pgd;
+
+	struct page *pgd_page;
+
+	pgd_page = alloc_pages_node(nid, GFP_PGTABLE_KERNEL, PGD_ALLOCATION_ORDER);
+	BUG_ON(pgd_page == NULL);
+
+	new_pgd = (pgd_t *)page_address(pgd_page);
+	clone_pgd_range(new_pgd + KERNEL_PGD_BOUNDARY,
+			swapper_pg_dir + KERNEL_PGD_BOUNDARY,
+			KERNEL_PGD_PTRS);
+
+	return new_pgd;
+}
+
+static inline void load_replicated_pgd(pgd_t *pgd)
+{
+	load_cr3(pgd);
+	flush_tlb_local();
+}
+
+static inline ssize_t str_cpu_dump(char *buf)
+{
+	return sprintf(buf, "NODE: #%02d, CPU: #%04d, cr3: 0x%p\n", numa_node_id(),
+			smp_processor_id(), (void *)__native_read_cr3());
+}
+
+#endif /* _ASM_X86_NUMA_REPLICATION_H */
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index c7ec5bb88334..d9f921b6d65a 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -156,6 +156,16 @@ static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 	return (p4d_t *)get_zeroed_page(gfp);
 }
 
+static inline p4d_t *p4d_alloc_one_node(unsigned int nid,
+					struct mm_struct *mm, unsigned long addr)
+{
+	gfp_t gfp = GFP_KERNEL_ACCOUNT;
+
+	if (mm == &init_mm)
+		gfp &= ~__GFP_ACCOUNT;
+	return (p4d_t *)get_zeroed_page_node(nid, gfp);
+}
+
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
 	if (!pgtable_l5_enabled())
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 34f9dba17c1a..c61852c8f6a0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1066,6 +1066,8 @@ int region_intersects(resource_size_t offset, size_t size, unsigned long flags,
 struct page *vmalloc_to_page(const void *addr);
 unsigned long vmalloc_to_pfn(const void *addr);
 
+struct page *walk_to_page_node(int nid, const void *addr);
+
 /*
  * Determine if an address is within the vmalloc range
  *
@@ -2645,25 +2647,46 @@ static inline pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
 
 #ifdef __PAGETABLE_P4D_FOLDED
 static inline int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
-						unsigned long address)
+			      unsigned long address)
+{
+	return 0;
+}
+
+static inline int __p4d_alloc_node(unsigned int nid,
+				   struct mm_struct *mm,
+				   pgd_t *pgd, unsigned long address)
 {
 	return 0;
 }
 #else
 int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address);
+int __p4d_alloc_node(unsigned int nid, struct mm_struct *mm,
+		     pgd_t *pgd, unsigned long address);
 #endif
 
 #if defined(__PAGETABLE_PUD_FOLDED) || !defined(CONFIG_MMU)
-static inline int __pud_alloc(struct mm_struct *mm, p4d_t *p4d,
-						unsigned long address)
+static inline int __pud_alloc(struct mm_struct *mm,
+			      p4d_t *p4d, unsigned long address)
 {
 	return 0;
 }
+
+static inline int __pud_alloc_node(unsigned int nid,
+				   struct mm_struct *mm,
+				   p4d_t *p4d, unsigned long address)
+{
+	return 0;
+}
+
 static inline void mm_inc_nr_puds(struct mm_struct *mm) {}
 static inline void mm_dec_nr_puds(struct mm_struct *mm) {}
 
 #else
-int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address);
+int __pud_alloc(struct mm_struct *mm,
+		p4d_t *p4d, unsigned long address);
+int __pud_alloc_node(unsigned int nid,
+		     struct mm_struct *mm,
+		     p4d_t *p4d, unsigned long address);
 
 static inline void mm_inc_nr_puds(struct mm_struct *mm)
 {
@@ -2681,8 +2704,15 @@ static inline void mm_dec_nr_puds(struct mm_struct *mm)
 #endif
 
 #if defined(__PAGETABLE_PMD_FOLDED) || !defined(CONFIG_MMU)
-static inline int __pmd_alloc(struct mm_struct *mm, pud_t *pud,
-						unsigned long address)
+static inline int __pmd_alloc(struct mm_struct *mm,
+			      pud_t *pud, unsigned long address)
+{
+	return 0;
+}
+
+static inline int __pmd_alloc_node(unsigned int nid,
+				   struct mm_struct *mm,
+				   pud_t *pud, unsigned long address)
 {
 	return 0;
 }
@@ -2692,6 +2722,9 @@ static inline void mm_dec_nr_pmds(struct mm_struct *mm) {}
 
 #else
 int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address);
+int __pmd_alloc_node(unsigned int nid,
+		     struct mm_struct *mm,
+		     pud_t *pud, unsigned long address);
 
 static inline void mm_inc_nr_pmds(struct mm_struct *mm)
 {
@@ -2744,7 +2777,6 @@ int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
 int __pte_alloc_kernel(pmd_t *pmd);
 
 #if defined(CONFIG_MMU)
-
 static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
 		unsigned long address)
 {
@@ -2759,11 +2791,36 @@ static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
 		NULL : pud_offset(p4d, address);
 }
 
-static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
+static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud,
+		unsigned long address)
 {
 	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
 		NULL: pmd_offset(pud, address);
 }
+
+static inline p4d_t *p4d_alloc_node(unsigned int nid,
+		struct mm_struct *mm,
+		pgd_t *pgd, unsigned long address)
+{
+	return (unlikely(pgd_none(*pgd)) && __p4d_alloc_node(nid, mm, pgd, address)) ?
+		NULL : p4d_offset(pgd, address);
+}
+
+static inline pud_t *pud_alloc_node(unsigned int nid,
+		struct mm_struct *mm,
+		p4d_t *p4d, unsigned long address)
+{
+	return (unlikely(p4d_none(*p4d)) && __pud_alloc_node(nid, mm, p4d, address)) ?
+		NULL : pud_offset(p4d, address);
+}
+
+static inline pmd_t *pmd_alloc_node(unsigned int nid,
+		struct mm_struct *mm,
+		pud_t *pud, unsigned long address)
+{
+	return (unlikely(pud_none(*pud)) && __pmd_alloc_node(nid, mm, pud, address)) ?
+		NULL : pmd_offset(pud, address);
+}
 #endif /* CONFIG_MMU */
 
 #if USE_SPLIT_PTE_PTLOCKS
@@ -3444,6 +3501,12 @@ static inline bool gup_can_follow_protnone(struct vm_area_struct *vma,
 typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
 extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
 			       unsigned long size, pte_fn_t fn, void *data);
+#ifdef CONFIG_KERNEL_REPLICATION
+extern int numa_apply_to_page_range(struct mm_struct *mm, unsigned long address,
+			       unsigned long size, pte_fn_t fn, void *data);
+#else
+#define numa_apply_to_page_range apply_to_page_range
+#endif
 extern int apply_to_existing_page_range(struct mm_struct *mm,
 				   unsigned long address, unsigned long size,
 				   pte_fn_t fn, void *data);
diff --git a/include/linux/numa_replication.h b/include/linux/numa_replication.h
new file mode 100644
index 000000000000..f53c35c28d35
--- /dev/null
+++ b/include/linux/numa_replication.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_NUMA_REPLICATION_H
+#define _LINUX_NUMA_REPLICATION_H
+
+#include <linux/mm_types.h>
+#include <linux/nodemask.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+
+#ifdef CONFIG_KERNEL_REPLICATION
+
+#include <asm/numa_replication.h>
+
+extern int closest_memory_node[MAX_NUMNODES];
+
+#define per_numa_pgd(mm, nid) ((mm)->pgd_numa[nid])
+#define for_each_replica(nid) for_each_node_state(nid, N_MEMORY)
+
+static inline bool numa_addr_has_replica(const void *addr)
+{
+	return ((unsigned long)addr >= PAGE_TABLE_REPLICATION_LEFT) &&
+		((unsigned long)addr <= PAGE_TABLE_REPLICATION_RIGHT);
+}
+
+bool is_text_replicated(void);
+void numa_replicate_kernel_rodata(void);
+void numa_setup_pgd(void);
+void numa_clear_linear_addresses(void);
+void __init numa_reserve_memory(void);
+void __init numa_replicate_kernel(void);
+void __init_or_module *numa_addr_in_replica(void *vaddr, int nid);
+void numa_dump_mm_tables(struct mm_struct *mm, unsigned long start, unsigned long end);
+static inline int numa_closest_memory_node(int nid)
+{
+	return closest_memory_node[nid];
+}
+
+#else
+
+#define per_numa_pgd(mm, nid) ((mm)->pgd)
+#define for_each_replica(nid) for (nid = 0; nid < 1; nid++)
+
+static inline bool numa_addr_has_replica(const void *addr)
+{
+	return false;
+}
+
+static inline bool is_text_replicated(void)
+{
+	return false;
+}
+
+static inline void numa_replicate_kernel_rodata(void)
+{
+}
+
+static inline void numa_setup_pgd(void)
+{
+}
+
+static inline void numa_clear_linear_addresses(void)
+{
+}
+
+static inline void __init numa_reserve_memory(void)
+{
+}
+
+static inline void __init numa_replicate_kernel(void)
+{
+}
+
+static inline void __init_or_module *numa_addr_in_replica(void *vaddr, int nid)
+{
+	return lm_alias(vaddr);
+}
+
+static inline void numa_dump_mm_tables(struct mm_struct *mm, unsigned long start, unsigned long end)
+{
+}
+
+
+#endif /*CONFIG_KERNEL_REPLICATION*/
+#endif /*_LINUX_NUMA_REPLICATION_H*/
diff --git a/mm/Makefile b/mm/Makefile
index 678530a07326..3ea7e3c144fd 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -139,3 +139,4 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
+obj-$(CONFIG_KERNEL_REPLICATION) += numa_replication.o
diff --git a/mm/memory.c b/mm/memory.c
index cdc4d4c1c858..22630bcdb0b9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -41,6 +41,7 @@
 
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
+#include <linux/numa_replication.h>
 #include <linux/mm_inline.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/coredump.h>
@@ -236,7 +237,10 @@ static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 	pud_t *pud;
 	unsigned long next;
 	unsigned long start;
-
+#ifdef CONFIG_KERNEL_REPLICATION
+	int nid;
+	int offset;
+#endif
 	start = addr;
 	pud = pud_offset(p4d, addr);
 	do {
@@ -258,7 +262,18 @@ static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 		return;
 
 	pud = pud_offset(p4d, start);
+#ifdef CONFIG_KERNEL_REPLICATION
+	if (mm_p4d_folded(tlb->mm)) {
+		offset = p4d - (p4d_t *)tlb->mm->pgd;
+		for_each_replica(nid) {
+			p4d_clear((p4d_t *)tlb->mm->pgd_numa[nid] + offset);
+		}
+	} else {
+		p4d_clear(p4d);
+	}
+#else
 	p4d_clear(p4d);
+#endif
 	pud_free_tlb(tlb, pud, start);
 	mm_dec_nr_puds(tlb->mm);
 }
@@ -270,7 +285,10 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 	p4d_t *p4d;
 	unsigned long next;
 	unsigned long start;
-
+#ifdef CONFIG_KERNEL_REPLICATION
+	int nid;
+	int offset;
+#endif
 	start = addr;
 	p4d = p4d_offset(pgd, addr);
 	do {
@@ -292,7 +310,16 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 		return;
 
 	p4d = p4d_offset(pgd, start);
+#ifdef CONFIG_KERNEL_REPLICATION
+	if (!mm_p4d_folded(tlb->mm)) {
+		offset = pgd - (pgd_t *)tlb->mm->pgd;
+		for_each_replica(nid) {
+			pgd_clear(tlb->mm->pgd_numa[nid] + offset);
+		}
+	}
+#else
 	pgd_clear(pgd);
+#endif
 	p4d_free_tlb(tlb, p4d, start);
 }
 
@@ -2766,6 +2793,60 @@ int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(apply_to_page_range);
 
+#ifdef CONFIG_KERNEL_REPLICATION
+static int numa_apply_to_page_range_pgd(struct mm_struct *mm,
+					pgd_t *pgtable, unsigned long addr,
+					unsigned long size, pte_fn_t fn,
+					void *data, bool create)
+{
+	pgd_t *pgd;
+	unsigned long start = addr, next;
+	unsigned long end = addr + size;
+	pgtbl_mod_mask mask = 0;
+	int err = 0;
+
+	if (WARN_ON(addr >= end))
+		return -EINVAL;
+
+	pgd = pgd_offset_pgd(pgtable, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(*pgd) && !create)
+			continue;
+		if (WARN_ON_ONCE(pgd_leaf(*pgd)))
+			return -EINVAL;
+		if (!pgd_none(*pgd) && WARN_ON_ONCE(pgd_bad(*pgd))) {
+			if (!create)
+				continue;
+			pgd_clear_bad(pgd);
+		}
+		err = apply_to_p4d_range(mm, pgd, addr, next,
+					 fn, data, create, &mask);
+		if (err)
+			break;
+	} while (pgd++, addr = next, addr != end);
+
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+		arch_sync_kernel_mappings(start, start + size);
+
+	return err;
+}
+
+int numa_apply_to_page_range(struct mm_struct *mm, unsigned long addr,
+			     unsigned long size, pte_fn_t fn, void *data)
+{
+	int nid;
+	int ret = 0;
+
+	for_each_replica(nid)
+		ret |= numa_apply_to_page_range_pgd(mm, per_numa_pgd(mm, nid),
+						    addr, size, fn, data, true);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(numa_apply_to_page_range);
+#endif
+
 /*
  * Scan a region of virtual memory, calling a provided function on
  * each leaf page table where it exists.
@@ -5440,6 +5521,10 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
  */
 int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
+#ifdef CONFIG_KERNEL_REPLICATION
+	int nid;
+	pgd_t *target;
+#endif
 	p4d_t *new = p4d_alloc_one(mm, address);
 	if (!new)
 		return -ENOMEM;
@@ -5447,6 +5532,42 @@ int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 	spin_lock(&mm->page_table_lock);
 	if (pgd_present(*pgd)) {	/* Another has populated it */
 		p4d_free(mm, new);
+		spin_unlock(&mm->page_table_lock);
+		return 0;
+	}
+	smp_wmb(); /* See comment in pmd_install() */
+	pgd_populate(mm, pgd, new);
+
+#ifdef CONFIG_KERNEL_REPLICATION
+	if (mm_p4d_folded(mm) || !is_text_replicated()) {
+		spin_unlock(&mm->page_table_lock);
+		return 0;
+	}
+	for_each_replica(nid) {
+		target = pgd_offset_pgd(mm->pgd_numa[nid], address);
+		if (pgd_present(*target))
+			continue;
+		pgd_populate(mm, target, new);
+	}
+#endif
+	spin_unlock(&mm->page_table_lock);
+
+	return 0;
+}
+
+int __p4d_alloc_node(unsigned int nid,
+		struct mm_struct *mm,
+		pgd_t *pgd, unsigned long address)
+{
+	p4d_t *new = p4d_alloc_one_node(nid, mm, address);
+	if (!new)
+		return -ENOMEM;
+
+	spin_lock(&mm->page_table_lock);
+	if (pgd_present(*pgd)) {	/* Another has populated it */
+		p4d_free(mm, new);
+		spin_unlock(&mm->page_table_lock);
+		return 0;
 	} else {
 		smp_wmb(); /* See comment in pmd_install() */
 		pgd_populate(mm, pgd, new);
@@ -5463,6 +5584,10 @@ int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
  */
 int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address)
 {
+#ifdef CONFIG_KERNEL_REPLICATION
+	int nid;
+	p4d_t *target;
+#endif
 	pud_t *new = pud_alloc_one(mm, address);
 	if (!new)
 		return -ENOMEM;
@@ -5472,9 +5597,48 @@ int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address)
 		mm_inc_nr_puds(mm);
 		smp_wmb(); /* See comment in pmd_install() */
 		p4d_populate(mm, p4d, new);
-	} else	/* Another has populated it */
+	} else	{/* Another has populated it */
 		pud_free(mm, new);
+		spin_unlock(&mm->page_table_lock);
+		return 0;
+	}
+#ifdef CONFIG_KERNEL_REPLICATION
+	if (!mm_p4d_folded(mm) || !is_text_replicated()) {
+		spin_unlock(&mm->page_table_lock);
+		return 0;
+	}
+	for_each_online_node(nid) {
+		target = (p4d_t *)pgd_offset_pgd(mm->pgd_numa[nid], address);
+		if (p4d_present(*target))
+			continue;
+		p4d_populate(mm, target, new);
+	}
+#endif
 	spin_unlock(&mm->page_table_lock);
+
+	return 0;
+}
+
+int __pud_alloc_node(unsigned int nid,
+		struct mm_struct *mm,
+		p4d_t *p4d, unsigned long address)
+{
+	pud_t *new = pud_alloc_one_node(nid, mm, address);
+	if (!new)
+		return -ENOMEM;
+
+	spin_lock(&mm->page_table_lock);
+	if (!p4d_present(*p4d)) {
+		mm_inc_nr_puds(mm);
+		smp_wmb(); /* See comment in pmd_install() */
+		p4d_populate(mm, p4d, new);
+	} else	{/* Another has populated it */
+		pud_free(mm, new);
+		spin_unlock(&mm->page_table_lock);
+		return 0;
+	}
+	spin_unlock(&mm->page_table_lock);
+
 	return 0;
 }
 #endif /* __PAGETABLE_PUD_FOLDED */
@@ -5502,6 +5666,28 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 	spin_unlock(ptl);
 	return 0;
 }
+
+int __pmd_alloc_node(unsigned int nid,
+		struct mm_struct *mm,
+		pud_t *pud, unsigned long address)
+{
+	spinlock_t *ptl;
+	pmd_t *new = pmd_alloc_one_node(nid, mm, address);
+	if (!new)
+		return -ENOMEM;
+
+	ptl = pud_lock(mm, pud);
+	if (!pud_present(*pud)) {
+		mm_inc_nr_pmds(mm);
+		smp_wmb(); /* See comment in pmd_install() */
+		pud_populate(mm, pud, new);
+	} else {	/* Another has populated it */
+		pmd_free(mm, new);
+	}
+	spin_unlock(ptl);
+	return 0;
+}
+
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 /**
@@ -6075,3 +6261,62 @@ void ptlock_free(struct page *page)
 	kmem_cache_free(page_ptl_cachep, page->ptl);
 }
 #endif
+
+/**
+ * Walk in replicated tranlation table specified by nid.
+ * If kernel replication is disabled or text is not replicated yet,
+ * value of nid is not used
+ */
+struct page *walk_to_page_node(int nid, const void *vmalloc_addr)
+{
+	unsigned long addr = (unsigned long)vmalloc_addr;
+	struct page *page = NULL;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *ptep, pte;
+
+	if (!is_text_replicated())
+		nid = 0;
+
+	pgd = pgd_offset_pgd(per_numa_pgd(&init_mm, nid), addr);
+	if (pgd_none(*pgd))
+		return NULL;
+	if (WARN_ON_ONCE(pgd_leaf(*pgd)))
+		return NULL; /* XXX: no allowance for huge pgd */
+	if (WARN_ON_ONCE(pgd_bad(*pgd)))
+		return NULL;
+
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		return NULL;
+	if (p4d_leaf(*p4d))
+		return p4d_page(*p4d) + ((addr & ~P4D_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(p4d_bad(*p4d)))
+		return NULL;
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud))
+		return NULL;
+	if (pud_leaf(*pud))
+		return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(pud_bad(*pud)))
+		return NULL;
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return NULL;
+	if (pmd_leaf(*pmd))
+		return pmd_page(*pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(pmd_bad(*pmd)))
+		return NULL;
+
+	ptep = pte_offset_map(pmd, addr);
+	pte = *ptep;
+	if (pte_present(pte))
+		page = pte_page(pte);
+	pte_unmap(ptep);
+
+	return page;
+}
diff --git a/mm/numa_replication.c b/mm/numa_replication.c
new file mode 100644
index 000000000000..8042a9ef9781
--- /dev/null
+++ b/mm/numa_replication.c
@@ -0,0 +1,564 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kernel.h>
+#include <linux/pagewalk.h>
+#include <linux/numa_replication.h>
+#include <linux/memblock.h>
+#include <linux/pgtable.h>
+#include <linux/hugetlb.h>
+#include <linux/kobject.h>
+
+#include <asm/sections.h>
+#include <asm/tlbflush.h>
+
+#define KERNEL_TEXT_START	((unsigned long)&_stext)
+#define KERNEL_TEXT_END		((unsigned long)&_etext)
+
+#define KERNEL_RODATA_START ((unsigned long)&__start_rodata)
+#define KERNEL_RODATA_END ((unsigned long)&__end_rodata)
+
+#define PMD_ALLOC_ORDER		(PMD_SHIFT-PAGE_SHIFT)
+#define PAGES_PER_PMD		(1 << PMD_ALLOC_ORDER)
+
+struct numa_node_pgt {
+	pgd_t *pgd;
+	void *text_vaddr;
+	void *rodata_vaddr;
+};
+
+static struct numa_node_pgt __initdata_or_module numa_pgt[MAX_NUMNODES];
+
+unsigned int master_node = -1;
+
+int closest_memory_node[MAX_NUMNODES];
+
+struct tt_dump_config {
+	int pgd_extra_info:1;
+	int p4d_extra_info:1;
+	int pud_extra_info:1;
+	int pmd_extra_info:1;
+	int pte_extra_info:1;
+};
+
+static bool text_replicated;
+
+bool is_text_replicated(void)
+{
+	return text_replicated;
+}
+
+static void binary_dump(unsigned long value)
+{
+	int i;
+
+	for (i = BITS_PER_LONG - 1; i >= 0; i--) {
+		if ((BITS_PER_LONG - 1 - i) % BITS_PER_BYTE == 0)
+			pr_info("%-9d", i);
+	}
+	pr_info("%d\n", 0);
+
+	for (i = BITS_PER_LONG - 1; i >= 0; i--) {
+		if ((BITS_PER_LONG - 1 - i) % BITS_PER_BYTE == 0)
+			pr_info("|");
+
+		pr_info("%d", (1UL << i) & value ? 1 : 0);
+	}
+	pr_info("|");
+}
+
+static int pgd_callback(pgd_t *pgd,
+			unsigned long addr, unsigned long next,
+			struct mm_walk *walk)
+{
+	unsigned long val = pgd_val(*pgd);
+	struct tt_dump_config *c = (struct tt_dump_config *)walk->private;
+
+	if (!val)
+		return 0;
+
+	addr = addr & PGDIR_MASK;
+	next = (addr & PGDIR_MASK) - 1 + PGDIR_SIZE;
+
+	pr_info("PGD ADDR: 0x%p PGD VAL: 0x%016lx [%p --- %p]\n",
+		pgd, val, (void *)addr, (void *)next);
+
+	if (c->pgd_extra_info)
+		binary_dump(val);
+
+	return 0;
+}
+
+static int p4d_callback(p4d_t *p4d,
+			unsigned long addr, unsigned long next,
+			struct mm_walk *walk)
+{
+	unsigned long val = p4d_val(*p4d);
+	struct tt_dump_config *c = (struct tt_dump_config *)walk->private;
+
+	if (!val)
+		return 0;
+
+	addr = addr & P4D_MASK;
+	next = (addr & P4D_MASK) - 1 + P4D_SIZE;
+
+	pr_info("P4D ADDR: 0x%p P4D VAL: 0x%016lx [%p --- %p]\n",
+		p4d, val, (void *)addr, (void *)next);
+
+	if (c->p4d_extra_info)
+		binary_dump(val);
+
+	return 0;
+}
+
+static int pud_callback(pud_t *pud,
+			unsigned long addr, unsigned long next,
+			struct mm_walk *walk)
+{
+	unsigned long val = pud_val(*pud);
+	struct tt_dump_config *c = (struct tt_dump_config *)walk->private;
+
+	if (!val)
+		return 0;
+
+	addr = addr & PUD_MASK;
+	next = (addr & PUD_MASK) - 1 + PUD_SIZE;
+
+	pr_info("PUD ADDR: 0x%p PUD VAL: 0x%016lx huge(%d) [%p --- %p]\n",
+		pud, val, pud_huge(*pud), (void *)addr, (void *)next);
+
+	if (c->pud_extra_info)
+		binary_dump(val);
+
+	return 0;
+}
+
+static int pmd_callback(pmd_t *pmd,
+			unsigned long addr, unsigned long next,
+			struct mm_walk *walk)
+{
+	unsigned long val = pmd_val(*pmd);
+	unsigned long paddr = pmd_pfn(*pmd) << PAGE_SHIFT;
+	struct tt_dump_config *c = (struct tt_dump_config *)walk->private;
+
+	if (!val)
+		return 0;
+
+	addr = addr & PMD_MASK;
+	next = (addr & PMD_MASK) - 1 + PMD_SIZE;
+
+	pr_info("PMD ADDR: 0x%p PMD VAL: 0x%016lx huge(%d) [%p --- %p] to %p\n",
+		pmd, val, pmd_huge(*pmd), (void *)addr, (void *)next, (void *)paddr);
+
+	if (c->pmd_extra_info)
+		binary_dump(val);
+
+	return 0;
+}
+
+static int pte_callback(pte_t *pte,
+			unsigned long addr, unsigned long next,
+			struct mm_walk *walk)
+{
+	unsigned long val = pte_val(*pte);
+	unsigned long paddr = pte_pfn(*pte) << PAGE_SHIFT;
+	struct tt_dump_config *c = (struct tt_dump_config *)walk->private;
+
+	if (!val)
+		return 0;
+
+	addr = addr & PAGE_MASK;
+	next = (addr & PAGE_MASK) - 1 + PAGE_SIZE;
+
+	pr_info("PTE ADDR: 0x%p PTE VAL: 0x%016lx [%p --- %p] to %p\n",
+		pte, val, (void *)addr, (void *)next, (void *)paddr);
+
+	if (c->pte_extra_info)
+		binary_dump(val);
+
+	return 0;
+}
+
+static int pte_hole_callback(unsigned long addr, unsigned long next,
+			     int depth, struct mm_walk *walk)
+{
+	pr_info("%*chole\n", depth * 2, ' ');
+
+	return 0;
+}
+
+void numa_dump_mm_tables(struct mm_struct *mm, unsigned long start, unsigned long end)
+{
+	int nid = 0;
+	struct tt_dump_config conf = {
+		.pgd_extra_info = 0,
+		.p4d_extra_info = 0,
+		.pud_extra_info = 0,
+		.pmd_extra_info = 0,
+		.pte_extra_info = 0,
+	};
+
+	const struct mm_walk_ops ops = {
+		.pgd_entry = pgd_callback,
+		.p4d_entry = p4d_callback,
+		.pud_entry = pud_callback,
+		.pmd_entry = pmd_callback,
+		.pte_entry = pte_callback,
+		.pte_hole  = pte_hole_callback
+	};
+
+	start = start & PAGE_MASK;
+	end = (end & PAGE_MASK) - 1 + PAGE_SIZE;
+
+	pr_info("----------PER-NUMA NODE KERNEL REPLICATION ENABLED----------\n");
+	mmap_read_lock(mm);
+	for_each_replica(nid) {
+		pr_info("NUMA node id #%d\n", nid);
+		pr_info("PGD: %p  PGD phys: %p\n",
+			mm->pgd_numa[nid], (void *)virt_to_phys(mm->pgd_numa[nid]));
+		walk_page_range_novma(mm, start, end, &ops, mm->pgd_numa[nid], &conf);
+	}
+	mmap_read_unlock(mm);
+	pr_info("----------PER-NUMA NODE KERNEL REPLICATION ENABLED----------\n");
+}
+
+static void numa_dump_tt(unsigned long start, unsigned long end)
+{
+	numa_dump_mm_tables(&init_mm, start, end);
+}
+
+DEFINE_SPINLOCK(numa_sysfs_lock);
+struct dump_data {
+	char *buf;
+	ssize_t offset;
+};
+
+static void cpu_dump(void *info)
+{
+	struct dump_data *data = (struct dump_data *) info;
+	ssize_t offset;
+
+	spin_lock(&numa_sysfs_lock);
+
+	offset = READ_ONCE(data->offset);
+
+	offset += str_cpu_dump(data->buf + offset);
+
+	WRITE_ONCE(data->offset, offset);
+
+	spin_unlock(&numa_sysfs_lock);
+}
+
+static ssize_t sysfs_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	struct dump_data data = {
+		.buf = buf,
+		.offset = 0
+	};
+	numa_dump_tt(KERNEL_TEXT_START, KERNEL_RODATA_END - 1);
+	on_each_cpu(cpu_dump, &data, 1);
+
+	return data.offset;
+}
+
+static struct kobj_attribute etx_attr = __ATTR(numa_replication_dump, 0440, sysfs_show, NULL);
+
+static void numa_replication_sysfs_init(void)
+{
+	if (sysfs_create_file(mm_kobj, &etx_attr.attr))
+		pr_info("Unable to create sysfs entry for numa replication\n");
+}
+
+
+static void copy_pages_and_flush(struct page *to, struct page *from, size_t nr_pages)
+{
+	while (nr_pages--) {
+		copy_page(page_address(to), page_address(from));
+		flush_dcache_page(to);
+		to++;
+		from++;
+	}
+}
+
+static void replicate_pages(struct page *pages, int nid,
+		unsigned long start, unsigned long end,
+		unsigned long nr_pages)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pgprot_t prot;
+	unsigned int nr_pmd = 0;
+
+	copy_pages_and_flush(pages, virt_to_page(lm_alias(start)), nr_pages);
+
+	for (unsigned long vaddr = start; vaddr < end; vaddr += PMD_SIZE, nr_pmd++) {
+
+		pgd = pgd_offset_pgd(numa_pgt[nid].pgd, vaddr);
+		p4d = p4d_offset(pgd, vaddr);
+		pud = pud_offset(p4d, vaddr);
+		pmd = pmd_offset(pud, vaddr);
+
+		prot = pmd_pgprot(*pmd);
+
+		set_pmd(pmd, pfn_pmd(page_to_pfn(pages) + nr_pmd * PAGES_PER_PMD, prot));
+	}
+}
+
+static void __init replicate_kernel_text(int nid)
+{
+	unsigned long nr_pages = (KERNEL_TEXT_END - KERNEL_TEXT_START) / PAGE_SIZE;
+
+	replicate_pages(virt_to_page(numa_pgt[nid].text_vaddr), nid,
+			KERNEL_TEXT_START, KERNEL_TEXT_END, nr_pages);
+}
+
+static void replicate_kernel_rodata(int nid)
+{
+	unsigned long nr_pages = (KERNEL_RODATA_END - KERNEL_RODATA_START) / PAGE_SIZE;
+
+	replicate_pages(virt_to_page(numa_pgt[nid].rodata_vaddr), nid,
+			KERNEL_RODATA_START, KERNEL_RODATA_END, nr_pages);
+}
+
+//'-1' in next functions have only one purpose - prevent unsgined long overflow
+static void replicate_pgt_pmd(p4d_t *dst, p4d_t *src,
+			      unsigned long start, unsigned long end,
+			      unsigned int nid)
+{
+	unsigned long left = start & PUD_MASK;
+	unsigned long right = (end & PUD_MASK) - 1 + PUD_SIZE;
+
+	pud_t *clone_pud = pud_offset(dst, left);
+	pud_t *orig_pud = pud_offset(src, left);
+
+	for (unsigned long addr = left; (addr >= left && addr < right); addr += PUD_SIZE) {
+		pmd_t *new_pmd;
+
+		if (pud_none(*orig_pud) || pud_huge(*orig_pud)) {
+			clone_pud++;
+			orig_pud++;
+			continue;
+		}
+
+		pud_clear(clone_pud);
+		new_pmd = pmd_alloc_node(nid, &init_mm, clone_pud, addr);
+		BUG_ON(new_pmd == NULL);
+
+		copy_page(pud_pgtable(*clone_pud), pud_pgtable(*orig_pud));
+
+		clone_pud++;
+		orig_pud++;
+	}
+}
+
+static void replicate_pgt_pud(pgd_t *dst, pgd_t *src,
+			      unsigned long start, unsigned long end,
+			      unsigned int nid)
+{
+	unsigned long left = start & P4D_MASK;
+	unsigned long right = (end & P4D_MASK) - 1 + P4D_SIZE;
+
+	p4d_t *clone_p4d = p4d_offset(dst, left);
+	p4d_t *orig_p4d = p4d_offset(src, left);
+
+	for (unsigned long addr = left; (addr >= left && addr < right); addr += P4D_SIZE) {
+		pud_t *new_pud;
+
+		if (p4d_none(*orig_p4d) || p4d_huge(*orig_p4d)) {
+			clone_p4d++;
+			orig_p4d++;
+			continue;
+		}
+
+		p4d_clear(clone_p4d);
+		new_pud = pud_alloc_node(nid, &init_mm, clone_p4d, addr);
+		BUG_ON(new_pud == NULL);
+
+		copy_page(p4d_pgtable(*clone_p4d), p4d_pgtable(*orig_p4d));
+		/* start and end passed to the next function must be in range of p4ds,
+		 * so min and max are used here
+		 */
+		replicate_pgt_pmd(clone_p4d, orig_p4d, max(addr, start),
+				  min(addr - 1 + P4D_SIZE, end), nid);
+
+		clone_p4d++;
+		orig_p4d++;
+	}
+}
+
+static void replicate_pgt_p4d(pgd_t *dst, pgd_t *src,
+			      unsigned long start, unsigned long end,
+			      unsigned int nid)
+{
+	unsigned long left = start & PGDIR_MASK;
+	unsigned long right = (end & PGDIR_MASK) - 1 + PGDIR_SIZE;
+
+	pgd_t *clone_pgd = pgd_offset_pgd(dst, left);
+	pgd_t *orig_pgd = pgd_offset_pgd(src, left);
+
+	for (unsigned long addr = left; (addr >= left && addr < right); addr += PGDIR_SIZE) {
+		p4d_t *new_p4d;
+
+		/* TODO: remove last condition and do something better
+		 * In the case of a folded P4D level, pgd_none and pgd_huge
+		 * always return 0, so we might start to replicate empty entries.
+		 * We obviously want to avoid this, so the last check is performed here.
+		 */
+		if (pgd_none(*orig_pgd) || pgd_huge(*orig_pgd) ||
+				(unsigned long)(orig_pgd->pgd) == 0) {
+			clone_pgd++;
+			orig_pgd++;
+			continue;
+		}
+
+		pgd_clear(clone_pgd);
+		new_p4d = p4d_alloc_node(nid, &init_mm, clone_pgd, addr);
+		BUG_ON(new_p4d == NULL);
+
+		copy_page((void *)pgd_page_vaddr(*clone_pgd), (void *)pgd_page_vaddr(*orig_pgd));
+		replicate_pgt_pud(clone_pgd, orig_pgd, max(addr, start),
+				  min(addr - 1 + PGDIR_SIZE, end), nid);
+
+		clone_pgd++;
+		orig_pgd++;
+	}
+}
+
+static void replicate_pgt(int nid, unsigned long start, unsigned long end)
+{
+	replicate_pgt_p4d(numa_pgt[nid].pgd, init_mm.pgd, start, end, nid);
+}
+
+static void replicate_pagetables(void)
+{
+	int nid;
+
+	for_each_replica(nid) {
+		numa_pgt[nid].pgd = numa_replicate_pgt_pgd(nid);
+
+		replicate_pgt(nid, PAGE_TABLE_REPLICATION_LEFT,
+				   PAGE_TABLE_REPLICATION_RIGHT);
+
+	}
+
+	for_each_online_node(nid) {
+		init_mm.pgd_numa[nid] = numa_pgt[closest_memory_node[nid]].pgd;
+	}
+}
+
+void __init numa_replicate_kernel(void)
+{
+	int nid;
+
+	replicate_pagetables();
+
+	for_each_replica(nid) {
+		if (nid == master_node)
+			continue;
+		replicate_kernel_text(nid);
+	}
+
+	text_replicated = true;
+	numa_setup_pgd();
+}
+
+void numa_replicate_kernel_rodata(void)
+{
+	int nid;
+
+	for_each_replica(nid) {
+		if (nid == master_node)
+			continue;
+		replicate_kernel_rodata(nid);
+	}
+
+	flush_tlb_all();
+	pr_info("Replicated page table : [%p --- %p]\n", (void *)PAGE_TABLE_REPLICATION_LEFT,
+							 (void *)PAGE_TABLE_REPLICATION_RIGHT);
+
+	numa_replication_sysfs_init();
+	numa_dump_tt(KERNEL_TEXT_START, KERNEL_RODATA_END - 1);
+}
+
+void numa_setup_pgd(void)
+{
+	/* switch away from the initial page table */
+	load_replicated_pgd(init_mm.pgd_numa[numa_node_id()]);
+}
+
+void __init_or_module *numa_addr_in_replica(void *vaddr, int nid)
+{
+	unsigned long addr = (unsigned long)vaddr;
+	unsigned long offset = addr - KERNEL_TEXT_START;
+
+	BUG_ON(addr < KERNEL_TEXT_START || addr >= KERNEL_TEXT_END);
+	BUG_ON(numa_pgt[nid].text_vaddr == NULL);
+	BUG_ON(closest_memory_node[nid] != nid);
+
+	return numa_pgt[nid].text_vaddr + offset;
+}
+
+void numa_clear_linear_addresses(void)
+{
+	int nid;
+
+	for_each_replica(nid) {
+		numa_pgt[nid].text_vaddr = NULL;
+		numa_pgt[nid].rodata_vaddr = NULL;
+	}
+}
+
+static void numa_find_closest_memory_nodes(void)
+{
+	int nid;
+
+	for_each_online_node(nid) {
+		int new_node;
+		int min_dist = INT_MAX;
+		int found_node = nid;
+
+		for_each_node_state(new_node, N_MEMORY) {
+			int new_dist = node_distance(nid, new_node);
+
+			if (new_dist < min_dist) {
+				found_node = new_node;
+				min_dist = new_dist;
+			}
+		}
+		closest_memory_node[nid] = found_node;
+
+		pr_info("For node %d  closest - %d\n", nid, found_node);
+	}
+}
+
+void __init numa_reserve_memory(void)
+{
+	int nid;
+
+	for_each_replica(nid)
+		pr_info("Memory node: %d\n", nid);
+
+	numa_find_closest_memory_nodes();
+	master_node = page_to_nid(virt_to_page(lm_alias((void *)KERNEL_TEXT_START)));
+
+	pr_info("Master Node: #%d\n", master_node);
+	for_each_replica(nid) {
+		if (nid == master_node) {
+			numa_pgt[nid].text_vaddr = lm_alias((void *)KERNEL_TEXT_START);
+			numa_pgt[nid].rodata_vaddr = lm_alias((void *)KERNEL_RODATA_START);
+		} else {
+			numa_pgt[nid].text_vaddr = memblock_alloc_try_nid(
+						   (KERNEL_TEXT_END - KERNEL_TEXT_START),
+						   HPAGE_SIZE, 0, MEMBLOCK_ALLOC_ANYWHERE, nid);
+
+			numa_pgt[nid].rodata_vaddr = memblock_alloc_try_nid(
+						   (KERNEL_RODATA_END - KERNEL_RODATA_START),
+						   HPAGE_SIZE, 0, MEMBLOCK_ALLOC_ANYWHERE, nid);
+		}
+
+		BUG_ON(numa_pgt[nid].text_vaddr == NULL);
+		BUG_ON(numa_pgt[nid].rodata_vaddr == NULL);
+	}
+}
+
-- 
2.34.1

