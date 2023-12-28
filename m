Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4547379FE
	for <linux-modules@vger.kernel.org>; Thu, 28 Dec 2023 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T186b6pLdz6K5sM;
	Thu, 28 Dec 2023 21:11:51 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 0531A141928;
	Thu, 28 Dec 2023 21:12:59 +0800 (CST)
Received: from mscphis00060.huawei.com (10.123.65.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:12:57 +0000
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
Subject: [PATCH RFC 10/12] mm: add replicas allocation support for vmalloc
Date: Thu, 28 Dec 2023 21:10:54 +0800
Message-ID: <20231228131056.602411-11-artem.kuzin@huawei.com>
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
 include/linux/vmalloc.h |  24 ++
 mm/vmalloc.c            | 469 +++++++++++++++++++++++++++++++---------
 2 files changed, 396 insertions(+), 97 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..61496ac316e0 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -9,6 +9,7 @@
 #include <asm/page.h>		/* pgprot_t */
 #include <linux/rbtree.h>
 #include <linux/overflow.h>
+#include <linux/numa.h>
 
 #include <asm/vmalloc.h>
 
@@ -29,6 +30,10 @@ struct iov_iter;		/* in uio.h */
 #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
 #define VM_ALLOW_HUGE_VMAP	0x00000400      /* Allow for huge pages on archs with HAVE_ARCH_HUGE_VMALLOC */
 
+#ifdef CONFIG_KERNEL_REPLICATION
+#define VM_NUMA_SHARED		0x00000800	/* Pages shared between per-NUMA node TT*/
+#endif
+
 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
 	!defined(CONFIG_KASAN_VMALLOC)
 #define VM_DEFER_KMEMLEAK	0x00000800	/* defer kmemleak object creation */
@@ -54,6 +59,10 @@ struct vm_struct {
 	struct page		**pages;
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
 	unsigned int		page_order;
+#endif
+#ifdef CONFIG_KERNEL_REPLICATION
+	int			node;
+	bool			replicated;
 #endif
 	unsigned int		nr_pages;
 	phys_addr_t		phys_addr;
@@ -149,6 +158,16 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller) __alloc_size(1);
+
+#ifdef CONFIG_KERNEL_REPLICATION
+ /*
+ * DO NOT USE this function if you don't understand what it is doing
+ * Use only in pair with __vmalloc_numa_shared_replicated_start()
+ */
+int __vmalloc_node_replicate_range(const void *addr, gfp_t gfp_mask,
+		pgprot_t prot, unsigned long vm_flags);
+#endif
+
 void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
 		int node, const void *caller) __alloc_size(1);
 void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
@@ -233,6 +252,11 @@ static inline bool is_vm_area_hugepages(const void *addr)
 
 #ifdef CONFIG_MMU
 void vunmap_range(unsigned long addr, unsigned long end);
+#ifdef CONFIG_KERNEL_REPLICATION
+void numa_vunmap_range(unsigned long addr, unsigned long end);
+#else
+#define numa_vunmap_range vunmap_range
+#endif
 static inline void set_vm_flush_reset_perms(void *addr)
 {
 	struct vm_struct *vm = find_vm_area(addr);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ef8599d394fd..3f57137c4173 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -10,6 +10,7 @@
 
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
+#include <linux/numa_replication.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/sched/signal.h>
@@ -439,6 +440,29 @@ void vunmap_range_noflush(unsigned long start, unsigned long end)
 	__vunmap_range_noflush(start, end);
 }
 
+void vunmap_range_noflush_pgd(unsigned long start, unsigned long end,
+		pgd_t *pagetable)
+{
+	unsigned long next;
+	pgd_t *pgd;
+	unsigned long addr = start;
+	pgtbl_mod_mask mask = 0;
+
+	BUG_ON(addr >= end);
+	pgd = pgd_offset_pgd(pagetable, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_bad(*pgd))
+			mask |= PGTBL_PGD_MODIFIED;
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		vunmap_p4d_range(pgd, addr, next, &mask);
+	} while (pgd++, addr = next, addr != end);
+
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+		arch_sync_kernel_mappings(start, end);
+}
+
 /**
  * vunmap_range - unmap kernel virtual addresses
  * @addr: start of the VM area to unmap
@@ -455,6 +479,18 @@ void vunmap_range(unsigned long addr, unsigned long end)
 	flush_tlb_kernel_range(addr, end);
 }
 
+#ifdef CONFIG_KERNEL_REPLICATION
+void numa_vunmap_range(unsigned long addr, unsigned long end)
+{
+	int node;
+
+	flush_cache_vunmap(addr, end);
+	for_each_replica(node)
+		vunmap_range_noflush_pgd(addr, end, init_mm.pgd_numa[node]);
+	flush_tlb_kernel_range(addr, end);
+}
+#endif /*CONFIG_KERNEL_REPLICATION*/
+
 static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
@@ -540,7 +576,8 @@ static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
 	return 0;
 }
 
-static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
+static int vmap_small_pages_range_noflush_pgd(pgd_t *pagetable,
+		unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages)
 {
 	unsigned long start = addr;
@@ -551,7 +588,7 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 	pgtbl_mod_mask mask = 0;
 
 	BUG_ON(addr >= end);
-	pgd = pgd_offset_k(addr);
+	pgd = pgd_offset_pgd(pagetable, addr);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_bad(*pgd))
@@ -567,17 +604,40 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 	return 0;
 }
 
-/*
- * vmap_pages_range_noflush is similar to vmap_pages_range, but does not
- * flush caches.
- *
- * The caller is responsible for calling flush_cache_vmap() after this
- * function returns successfully and before the addresses are accessed.
- *
- * This is an internal function only. Do not use outside mm/.
- */
-int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-		pgprot_t prot, struct page **pages, unsigned int page_shift)
+static int vmap_range_noflush_pgd(pgd_t *pagetable,
+		unsigned long addr, unsigned long end,
+		phys_addr_t phys_addr, pgprot_t prot,
+		unsigned int max_page_shift)
+{
+	pgd_t *pgd;
+	unsigned long start;
+	unsigned long next;
+	int err;
+	pgtbl_mod_mask mask = 0;
+
+	might_sleep();
+	BUG_ON(addr >= end);
+
+	start = addr;
+	pgd = pgd_offset_pgd(pagetable, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot,
+					max_page_shift, &mask);
+		if (err)
+			break;
+	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
+
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+		arch_sync_kernel_mappings(start, end);
+
+	return err;
+}
+
+static int vmap_pages_range_noflush_pgd(pgd_t *pagetable,
+		unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages,
+		unsigned int page_shift)
 {
 	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
 
@@ -585,12 +645,13 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 
 	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
 			page_shift == PAGE_SHIFT)
-		return vmap_small_pages_range_noflush(addr, end, prot, pages);
+		return vmap_small_pages_range_noflush_pgd(pagetable, addr, end,
+				prot, pages);
 
 	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
 		int err;
 
-		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
+		err = vmap_range_noflush_pgd(pagetable, addr, addr + (1UL << page_shift),
 					page_to_phys(pages[i]), prot,
 					page_shift);
 		if (err)
@@ -610,7 +671,7 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 
 	if (ret)
 		return ret;
-	return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
+	return vmap_pages_range_noflush_pgd(init_mm.pgd, addr, end, prot, pages, page_shift);
 }
 
 /**
@@ -658,57 +719,12 @@ EXPORT_SYMBOL_GPL(is_vmalloc_or_module_addr);
  */
 struct page *vmalloc_to_page(const void *vmalloc_addr)
 {
-	unsigned long addr = (unsigned long) vmalloc_addr;
-	struct page *page = NULL;
-	pgd_t *pgd = pgd_offset_k(addr);
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-
 	/*
 	 * XXX we might need to change this if we add VIRTUAL_BUG_ON for
 	 * architectures that do not vmalloc module space
 	 */
 	VIRTUAL_BUG_ON(!is_vmalloc_or_module_addr(vmalloc_addr));
-
-	if (pgd_none(*pgd))
-		return NULL;
-	if (WARN_ON_ONCE(pgd_leaf(*pgd)))
-		return NULL; /* XXX: no allowance for huge pgd */
-	if (WARN_ON_ONCE(pgd_bad(*pgd)))
-		return NULL;
-
-	p4d = p4d_offset(pgd, addr);
-	if (p4d_none(*p4d))
-		return NULL;
-	if (p4d_leaf(*p4d))
-		return p4d_page(*p4d) + ((addr & ~P4D_MASK) >> PAGE_SHIFT);
-	if (WARN_ON_ONCE(p4d_bad(*p4d)))
-		return NULL;
-
-	pud = pud_offset(p4d, addr);
-	if (pud_none(*pud))
-		return NULL;
-	if (pud_leaf(*pud))
-		return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (WARN_ON_ONCE(pud_bad(*pud)))
-		return NULL;
-
-	pmd = pmd_offset(pud, addr);
-	if (pmd_none(*pmd))
-		return NULL;
-	if (pmd_leaf(*pmd))
-		return pmd_page(*pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (WARN_ON_ONCE(pmd_bad(*pmd)))
-		return NULL;
-
-	ptep = pte_offset_kernel(pmd, addr);
-	pte = ptep_get(ptep);
-	if (pte_present(pte))
-		page = pte_page(pte);
-
-	return page;
+	return walk_to_page_node(0, vmalloc_addr);
 }
 EXPORT_SYMBOL(vmalloc_to_page);
 
@@ -1841,6 +1857,30 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 		schedule_work(&drain_vmap_work);
 }
 
+/*
+ * Free and unmap a vmap area for every NUMA node
+ */
+#ifdef CONFIG_KERNEL_REPLICATION
+static void free_unmap_vmap_area_per_pgd(struct vmap_area *va)
+{
+	int node;
+
+	flush_cache_vunmap(va->va_start, va->va_end);
+	/**
+	 *  In some scenarios we might clear
+	 *  empty entries here, which is totally fine
+	 */
+	for_each_replica(node)
+		vunmap_range_noflush_pgd(va->va_start, va->va_end,
+				init_mm.pgd_numa[node]);
+
+	if (debug_pagealloc_enabled_static())
+		flush_tlb_kernel_range(va->va_start, va->va_end);
+
+	free_vmap_area_noflush(va);
+}
+#endif /*CONFIG_KERNEL_REPLICATION*/
+
 /*
  * Free and unmap a vmap area
  */
@@ -2700,9 +2740,19 @@ struct vm_struct *remove_vm_area(const void *addr)
 	debug_check_no_locks_freed(vm->addr, get_vm_area_size(vm));
 	debug_check_no_obj_freed(vm->addr, get_vm_area_size(vm));
 	kasan_free_module_shadow(vm);
+#ifdef CONFIG_KERNEL_REPLICATION
+		if (numa_addr_has_replica(addr)) {
+			/* TODO kasan_poison_vmalloc_numa */
+			free_unmap_vmap_area_per_pgd(va);
+		} else {
+			kasan_poison_vmalloc(vm->addr, get_vm_area_size(vm));
+			free_unmap_vmap_area(va);
+		}
+#else
 	kasan_poison_vmalloc(vm->addr, get_vm_area_size(vm));
 
 	free_unmap_vmap_area(va);
+#endif
 	return vm;
 }
 
@@ -2712,9 +2762,20 @@ static inline void set_area_direct_map(const struct vm_struct *area,
 	int i;
 
 	/* HUGE_VMALLOC passes small pages to set_direct_map */
-	for (i = 0; i < area->nr_pages; i++)
+	for (i = 0; i < area->nr_pages; i++) {
 		if (page_address(area->pages[i]))
 			set_direct_map(area->pages[i]);
+#ifdef CONFIG_KERNEL_REPLICATION
+		if (area->replicated) {
+			struct page *page;
+
+			list_for_each_entry(page, &area->pages[i]->lru, lru) {
+				if (page_address(page))
+					set_direct_map(page);
+			}
+		}
+#endif
+	}
 }
 
 /*
@@ -2742,8 +2803,24 @@ static void vm_reset_perms(struct vm_struct *area)
 			end = max(addr + page_size, end);
 			flush_dmap = 1;
 		}
+#ifdef CONFIG_KERNEL_REPLICATION
+		if (area->replicated) {
+			struct page *page;
+
+			list_for_each_entry(page, &area->pages[i]->lru, lru) {
+				unsigned long addr = (unsigned long)page_address(area->pages[i]);
+				if (addr) {
+					unsigned long page_size;
+
+					page_size = PAGE_SIZE << page_order;
+					start = min(addr, start);
+					end = max(addr + page_size, end);
+					flush_dmap = 1;
+				}
+			}
+		}
+#endif
 	}
-
 	/*
 	 * Set direct map to something invalid so that it won't be cached if
 	 * there are any accesses after the TLB flush, then flush the TLB and
@@ -2832,8 +2909,36 @@ void vfree(const void *addr)
 		vm_reset_perms(vm);
 	for (i = 0; i < vm->nr_pages; i++) {
 		struct page *page = vm->pages[i];
+#ifdef CONFIG_KERNEL_REPLICATION
+			if (vm->replicated) {
+				struct page *cursor, *tmp;
+
+				BUG_ON(!page);
+				list_for_each_entry_safe(cursor, tmp, &vm->pages[i]->lru, lru) {
+					BUG_ON(!cursor);
+
+					list_del(&cursor->lru);
+					mod_memcg_page_state(cursor, MEMCG_VMALLOC, -1);
+					/*
+					 * High-order allocs for huge vmallocs are split, so
+					 * can be freed as an array of order-0 allocations
+					 */
+					__free_pages(cursor, 0);
+					cond_resched();
+				}
+			}
+#endif
+			BUG_ON(!page);
+
+			/*
+			 * Cleanup lru entries used for replicas. During page allocation
+			 * clear_page_pfmemalloc() is called, but just to be sure let's
+			 * clear page->lru here.
+			 */
+			page->lru.next = LIST_POISON1;
+			page->lru.prev = LIST_POISON2;
+
 
-		BUG_ON(!page);
 		mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
 		/*
 		 * High-order allocs for huge vmallocs are split, so
@@ -3098,26 +3203,90 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	return nr_allocated;
 }
 
+static int vmalloc_map_area_pages_node(unsigned long addr,
+		struct page **pages, unsigned long size,
+		gfp_t gfp_mask, pgprot_t prot,
+		unsigned int page_shift, int node)
+{
+	int ret = 0;
+	unsigned int flags;
+	bool nofail = gfp_mask & __GFP_NOFAIL;
+
+	/*
+	 * page tables allocations ignore external gfp mask, enforce it
+	 * by the scope API
+	 */
+	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
+		flags = memalloc_nofs_save();
+	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
+		flags = memalloc_noio_save();
+
+	do {
+		pgd_t *pgd = per_numa_pgd(&init_mm, node);
+		ret = vmap_pages_range_noflush_pgd(pgd, addr, addr + size,
+				prot, pages, page_shift);
+		if (nofail && (ret < 0))
+			schedule_timeout_uninterruptible(1);
+	} while (nofail && (ret < 0));
+
+	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
+		memalloc_nofs_restore(flags);
+	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
+		memalloc_noio_restore(flags);
+
+	if (ret < 0) {
+		warn_alloc(gfp_mask, NULL,
+			"vmalloc error: size %lu, failed to map pages",
+			size);
+	}
+
+	return ret;
+}
+
+static int vmalloc_map_area_pages(unsigned long addr, unsigned long size,
+				  struct vm_struct *area,
+				  gfp_t gfp_mask, pgprot_t prot,
+				  unsigned int page_shift)
+{
+	int ret;
+	int node = 0;
+
+#ifdef CONFIG_KERNEL_REPLICATION
+	if (area->flags & VM_NUMA_SHARED) {
+		for_each_replica(node) {
+			ret = vmalloc_map_area_pages_node(addr, area->pages, size,
+					gfp_mask, prot, page_shift, node);
+			if (ret)
+				return ret;
+		}
+	} else {
+		ret = vmalloc_map_area_pages_node(addr, area->pages, size,
+				gfp_mask, prot, page_shift, node);
+	}
+#else
+	ret = vmalloc_map_area_pages_node(addr, area->pages, size,
+			gfp_mask, prot, page_shift, node);
+#endif
+	return ret;
+}
+
 static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 				 pgprot_t prot, unsigned int page_shift,
 				 int node)
 {
 	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
-	bool nofail = gfp_mask & __GFP_NOFAIL;
 	unsigned long addr = (unsigned long)area->addr;
 	unsigned long size = get_vm_area_size(area);
 	unsigned long array_size;
 	unsigned int nr_small_pages = size >> PAGE_SHIFT;
 	unsigned int page_order;
-	unsigned int flags;
-	int ret;
+	int ret = 0;
 
 	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
 
 	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
 		gfp_mask |= __GFP_HIGHMEM;
 
-	/* Please note that the recursion is strictly bounded. */
 	if (array_size > PAGE_SIZE) {
 		area->pages = __vmalloc_node(array_size, 1, nested_gfp, node,
 					area->caller);
@@ -3129,8 +3298,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to allocated page array size %lu",
 			nr_small_pages * PAGE_SIZE, array_size);
-		free_vm_area(area);
-		return NULL;
+		goto fail;
 	}
 
 	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
@@ -3169,38 +3337,17 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		goto fail;
 	}
 
-	/*
-	 * page tables allocations ignore external gfp mask, enforce it
-	 * by the scope API
-	 */
-	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
-		flags = memalloc_nofs_save();
-	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
-		flags = memalloc_noio_save();
-
-	do {
-		ret = vmap_pages_range(addr, addr + size, prot, area->pages,
-			page_shift);
-		if (nofail && (ret < 0))
-			schedule_timeout_uninterruptible(1);
-	} while (nofail && (ret < 0));
-
-	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
-		memalloc_nofs_restore(flags);
-	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
-		memalloc_noio_restore(flags);
-
-	if (ret < 0) {
-		warn_alloc(gfp_mask, NULL,
-			"vmalloc error: size %lu, failed to map pages",
-			area->nr_pages * PAGE_SIZE);
+	ret = vmalloc_map_area_pages(addr, size, area, gfp_mask, prot, page_shift);
+	if (ret)
 		goto fail;
-	}
+
+	flush_cache_vmap(addr, addr + size);
 
 	return area->addr;
 
 fail:
 	vfree(area->addr);
+
 	return NULL;
 }
 
@@ -3292,6 +3439,11 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		goto fail;
 	}
 
+#ifdef CONFIG_KERNEL_REPLICATION
+	if (numa_addr_has_replica(area->addr))
+		vm_flags |= VM_NUMA_SHARED;
+	area->node = node;
+#endif
 	/*
 	 * Prepare arguments for __vmalloc_area_node() and
 	 * kasan_unpoison_vmalloc().
@@ -3385,6 +3537,129 @@ void *__vmalloc_node(unsigned long size, unsigned long align,
 	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
 				gfp_mask, PAGE_KERNEL, 0, node, caller);
 }
+
+#ifdef CONFIG_KERNEL_REPLICATION
+static void numa_replicated_page_range(struct page **src, struct page **dst, int nr_pages)
+{
+	int i;
+	void *from, *to;
+
+	for (i = 0; i < nr_pages; i++) {
+		from = kmap(src[i]);
+		to = kmap(dst[i]);
+
+		copy_page(to, from);
+
+		kunmap(src[i]);
+		kunmap(dst[i]);
+	}
+}
+
+int __vmalloc_node_replicate_range(const void *addr, gfp_t gfp_mask,
+		pgprot_t prot, unsigned long vm_flags)
+{
+	int i, ret, node = 0;
+	struct vm_struct *area;
+	unsigned int page_order;
+	unsigned int nr_allocated;
+	struct page **pages;
+	unsigned long area_start, area_end;
+	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
+	unsigned long array_size;
+
+	gfp_mask |= __GFP_NOWARN;
+	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
+		gfp_mask |= __GFP_HIGHMEM;
+
+	if (unlikely(!numa_addr_has_replica(addr)))
+		return -EINVAL;
+
+	area = find_vm_area(addr);
+	if (unlikely(!area))
+		return -ENOENT;
+
+	if (area->node == NUMA_NO_NODE)
+		return -EINVAL;
+
+	array_size = sizeof(struct page *) * area->nr_pages;
+	if (array_size > PAGE_SIZE)
+		pages = __vmalloc(array_size, nested_gfp);
+	else
+		pages = kmalloc(array_size, nested_gfp);
+
+	if (!pages)
+		return -ENOMEM;
+
+	page_order = vm_area_page_order(area);
+	for (i = 0; i < area->nr_pages; i++)
+		INIT_LIST_HEAD(&area->pages[i]->lru);
+
+	area_start = (unsigned long)area->addr;
+	area_end = (unsigned long)(area->addr + area->nr_pages * PAGE_SIZE);
+
+	for_each_replica(node) {
+		if (area->node == node)
+			continue;
+
+		nr_allocated = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
+			node, page_order, area->nr_pages, pages);
+		if (nr_allocated != area->nr_pages)
+			goto fail_alloc_pages;
+
+		for (i = 0; i < area->nr_pages; i++)
+			list_add(&pages[i]->lru, &area->pages[i]->lru);
+
+		vunmap_range_noflush_pgd(area_start, area_end,
+					 init_mm.pgd_numa[node]);
+
+		/*
+		 * We can't fail here (hopefully)
+		 * Possible errors: not enough memory for tables and not empty entries.
+		 * Both unrealistic because we just cleared entries in existed tables.
+		 */
+		ret = vmalloc_map_area_pages_node(area_start, pages,
+					nr_allocated * PAGE_SIZE,
+					gfp_mask, prot, PAGE_SHIFT,
+					node);
+		if (ret != 0)
+			goto fail_map_pages;
+
+		atomic_long_add(nr_allocated, &nr_vmalloc_pages);
+		if (gfp_mask & __GFP_ACCOUNT) {
+			for (i = 0; i < nr_allocated; i++)
+				mod_memcg_page_state(pages[i], MEMCG_VMALLOC, 1);
+		}
+		numa_replicated_page_range(area->pages, pages, area->nr_pages);
+
+		for (i = 0; i < area->nr_pages; i++)
+			pages[i] = NULL;
+	}
+	kvfree(pages);
+
+	flush_tlb_kernel_range(area_start, area_end);
+	area->replicated = true;
+
+	return 0;
+fail_alloc_pages:
+	for (i = 0; i < nr_allocated; i++)
+		__free_pages(pages[i], 0);
+
+fail_map_pages:
+	kfree(pages);
+	for (i = 0; i < area->nr_pages; i++) {
+		struct page *page, *tmp;
+
+		list_for_each_entry_safe(page, tmp, &area->pages[i]->lru, lru) {
+			list_del(&page->lru);
+			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
+			__free_pages(page, 0);
+		}
+	}
+
+	return ret;
+}
+#endif /*CONFIG_KERNEL_REPLICATION*/
+
 /*
  * This is only for performance analysis of vmalloc and stress purpose.
  * It is required by vmalloc test module, therefore do not use it other
-- 
2.34.1

