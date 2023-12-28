Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2081279C8
	for <linux-modules@vger.kernel.org>; Thu, 28 Dec 2023 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T185805Mhz67cTF;
	Thu, 28 Dec 2023 21:10:36 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id D47711408F9;
	Thu, 28 Dec 2023 21:12:52 +0800 (CST)
Received: from mscphis00060.huawei.com (10.123.65.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:12:50 +0000
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
Subject: [PATCH RFC 07/12] x86: enable per-NUMA node kernel text and rodata replication
Date: Thu, 28 Dec 2023 21:10:51 +0800
Message-ID: <20231228131056.602411-8-artem.kuzin@huawei.com>
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
 arch/x86/kernel/smpboot.c     |  2 +
 arch/x86/mm/dump_pagetables.c |  9 +++++
 arch/x86/mm/fault.c           |  4 +-
 arch/x86/mm/pgtable.c         | 76 ++++++++++++++++++++++++-----------
 arch/x86/mm/tlb.c             | 30 +++++++++++---
 init/main.c                   |  5 +++
 6 files changed, 97 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 747b83a373a2..d2a852ba1bcf 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -60,6 +60,7 @@
 #include <linux/stackprotector.h>
 #include <linux/cpuhotplug.h>
 #include <linux/mc146818rtc.h>
+#include <linux/numa_replication.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -244,6 +245,7 @@ static void notrace start_secondary(void *unused)
 	 * limit the things done here to the most necessary things.
 	 */
 	cr4_init();
+	numa_setup_pgd();
 
 	/*
 	 * 32-bit specific. 64-bit reaches this code with the correct page
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e1b599ecbbc2..5a2e36c9468a 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -17,6 +17,7 @@
 #include <linux/highmem.h>
 #include <linux/pci.h>
 #include <linux/ptdump.h>
+#include <linux/numa_replication.h>
 
 #include <asm/e820/types.h>
 
@@ -433,7 +434,15 @@ void ptdump_walk_user_pgd_level_checkwx(void)
 
 void ptdump_walk_pgd_level_checkwx(void)
 {
+#ifdef CONFIG_KERNEL_REPLICATION
+	int node;
+
+	for_each_replica(node)
+		ptdump_walk_pgd_level_core(NULL, &init_mm,
+				per_numa_pgd(&init_mm, node), true, false);
+#else
 	ptdump_walk_pgd_level_core(NULL, &init_mm, INIT_PGD, true, false);
+#endif
 }
 
 static int __init pt_dump_init(void)
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e8711b2cafaf..d76e072dd028 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -20,6 +20,7 @@
 #include <linux/efi.h>			/* efi_crash_gracefully_on_page_fault()*/
 #include <linux/mm_types.h>
 #include <linux/mm.h>			/* find_and_lock_vma() */
+#include <linux/numa_replication.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1031,7 +1032,8 @@ spurious_kernel_fault(unsigned long error_code, unsigned long address)
 	    error_code != (X86_PF_INSTR | X86_PF_PROT))
 		return 0;
 
-	pgd = init_mm.pgd + pgd_index(address);
+	pgd = per_numa_pgd(&init_mm, numa_node_id());
+
 	if (!pgd_present(*pgd))
 		return 0;
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 15a8009a4480..4c905fe0b84f 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -2,6 +2,7 @@
 #include <linux/mm.h>
 #include <linux/gfp.h>
 #include <linux/hugetlb.h>
+#include <linux/numa_replication.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/fixmap.h>
@@ -120,23 +121,25 @@ struct mm_struct *pgd_page_get_mm(struct page *page)
 	return page->pt_mm;
 }
 
-static void pgd_ctor(struct mm_struct *mm, pgd_t *pgd)
+static void pgd_ctor(struct mm_struct *mm, int nid)
 {
+	pgd_t *dst_pgd = per_numa_pgd(mm, nid);
+	pgd_t *src_pgd = per_numa_pgd(&init_mm, nid);
 	/* If the pgd points to a shared pagetable level (either the
 	   ptes in non-PAE, or shared PMD in PAE), then just copy the
 	   references from swapper_pg_dir. */
 	if (CONFIG_PGTABLE_LEVELS == 2 ||
 	    (CONFIG_PGTABLE_LEVELS == 3 && SHARED_KERNEL_PMD) ||
 	    CONFIG_PGTABLE_LEVELS >= 4) {
-		clone_pgd_range(pgd + KERNEL_PGD_BOUNDARY,
-				swapper_pg_dir + KERNEL_PGD_BOUNDARY,
+		clone_pgd_range(dst_pgd + KERNEL_PGD_BOUNDARY,
+				src_pgd + KERNEL_PGD_BOUNDARY,
 				KERNEL_PGD_PTRS);
 	}
 
 	/* list required to sync kernel mapping updates */
 	if (!SHARED_KERNEL_PMD) {
-		pgd_set_mm(pgd, mm);
-		pgd_list_add(pgd);
+		pgd_set_mm(dst_pgd, mm);
+		pgd_list_add(dst_pgd);
 	}
 }
 
@@ -416,20 +419,33 @@ static inline void _pgd_free(pgd_t *pgd)
 {
 	free_pages((unsigned long)pgd, PGD_ALLOCATION_ORDER);
 }
+
+#ifdef CONFIG_KERNEL_REPLICATION
+static inline pgd_t *_pgd_alloc_node(int nid)
+{
+	struct page *pages;
+
+	pages = __alloc_pages_node(nid, GFP_PGTABLE_USER,
+				   PGD_ALLOCATION_ORDER);
+	return (pgd_t *)page_address(pages);
+}
+
+#else
+#define _pgd_alloc_node(nid) _pgd_alloc()
+#endif /* CONFIG_KERNEL_REPLICATION */
 #endif /* CONFIG_X86_PAE */
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *pgd;
+	int nid;
 	pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
 	pmd_t *pmds[MAX_PREALLOCATED_PMDS];
 
-	pgd = _pgd_alloc();
-
-	if (pgd == NULL)
-		goto out;
-
-	mm->pgd = pgd;
+	for_each_replica(nid) {
+		per_numa_pgd(mm, nid) = _pgd_alloc_node(nid);
+		if (per_numa_pgd(mm, nid) == NULL)
+			goto out_free_pgd;
+	}
 
 	if (sizeof(pmds) != 0 &&
 			preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
@@ -449,16 +465,22 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	 */
 	spin_lock(&pgd_lock);
 
-	pgd_ctor(mm, pgd);
-	if (sizeof(pmds) != 0)
-		pgd_prepopulate_pmd(mm, pgd, pmds);
+	for_each_replica(nid) {
+		pgd_ctor(mm, nid);
+		if (sizeof(pmds) != 0)
+			pgd_prepopulate_pmd(mm, per_numa_pgd(mm, nid), pmds);
 
-	if (sizeof(u_pmds) != 0)
-		pgd_prepopulate_user_pmd(mm, pgd, u_pmds);
+		if (sizeof(u_pmds) != 0)
+			pgd_prepopulate_user_pmd(mm, per_numa_pgd(mm, nid), u_pmds);
+	}
+
+	for_each_online_node(nid) {
+		per_numa_pgd(mm, nid) = per_numa_pgd(mm, numa_closest_memory_node(nid));
+	}
 
 	spin_unlock(&pgd_lock);
 
-	return pgd;
+	return mm->pgd;
 
 out_free_user_pmds:
 	if (sizeof(u_pmds) != 0)
@@ -467,17 +489,25 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	if (sizeof(pmds) != 0)
 		free_pmds(mm, pmds, PREALLOCATED_PMDS);
 out_free_pgd:
-	_pgd_free(pgd);
-out:
+	for_each_replica(nid) {
+		if (per_numa_pgd(mm, nid) != NULL)
+			_pgd_free(per_numa_pgd(mm, nid));
+	}
 	return NULL;
 }
 
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
+	int nid;
+
 	pgd_mop_up_pmds(mm, pgd);
-	pgd_dtor(pgd);
-	paravirt_pgd_free(mm, pgd);
-	_pgd_free(pgd);
+	for_each_replica(nid) {
+		pgd_t *pgd_numa = per_numa_pgd(mm, nid);
+
+		pgd_dtor(pgd_numa);
+		paravirt_pgd_free(mm, pgd_numa);
+		_pgd_free(pgd_numa);
+	}
 }
 
 /*
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 267acf27480a..de0e57827f98 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -10,6 +10,7 @@
 #include <linux/debugfs.h>
 #include <linux/sched/smt.h>
 #include <linux/task_work.h>
+#include <linux/numa_replication.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -491,6 +492,22 @@ void cr4_update_pce(void *ignored)
 static inline void cr4_update_pce_mm(struct mm_struct *mm) { }
 #endif
 
+#ifdef CONFIG_KERNEL_REPLICATION
+extern struct mm_struct *poking_mm;
+static pgd_t *get_next_pgd(struct mm_struct *next)
+{
+	if (next == poking_mm)
+		return next->pgd;
+	else
+		return next->pgd_numa[numa_node_id()];
+}
+#else
+static pgd_t *get_next_pgd(struct mm_struct *next)
+{
+	return next->pgd;
+}
+#endif /*CONFIG_KERNEL_REPLICATION*/
+
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
@@ -502,6 +519,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	u64 next_tlb_gen;
 	bool need_flush;
 	u16 new_asid;
+	pgd_t *next_pgd;
 
 	/*
 	 * NB: The scheduler will call us with prev == next when switching
@@ -636,15 +654,17 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	}
 
 	set_tlbstate_lam_mode(next);
+
+	next_pgd = get_next_pgd(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
-		load_new_mm_cr3(next->pgd, new_asid, new_lam, true);
+		load_new_mm_cr3(next_pgd, new_asid, new_lam, true);
 
 		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
 	} else {
 		/* The new ASID is already up to date. */
-		load_new_mm_cr3(next->pgd, new_asid, new_lam, false);
+		load_new_mm_cr3(next_pgd, new_asid, new_lam, false);
 
 		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
@@ -703,7 +723,7 @@ void initialize_tlbstate_and_flush(void)
 	unsigned long cr3 = __read_cr3();
 
 	/* Assert that CR3 already references the right mm. */
-	WARN_ON((cr3 & CR3_ADDR_MASK) != __pa(mm->pgd));
+	WARN_ON((cr3 & CR3_ADDR_MASK) != __pa(per_numa_pgd(mm, numa_node_id())));
 
 	/* LAM expected to be disabled */
 	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
@@ -718,7 +738,7 @@ void initialize_tlbstate_and_flush(void)
 		!(cr4_read_shadow() & X86_CR4_PCIDE));
 
 	/* Disable LAM, force ASID 0 and force a TLB flush. */
-	write_cr3(build_cr3(mm->pgd, 0, 0));
+	write_cr3(build_cr3(per_numa_pgd(mm, numa_node_id()), 0, 0));
 
 	/* Reinitialize tlbstate. */
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_INIT);
@@ -1091,7 +1111,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 unsigned long __get_current_cr3_fast(void)
 {
 	unsigned long cr3 =
-		build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
+		build_cr3(per_numa_pgd(this_cpu_read(cpu_tlbstate.loaded_mm), numa_node_id()),
 			  this_cpu_read(cpu_tlbstate.loaded_mm_asid),
 			  tlbstate_lam_cr3_mask());
 
diff --git a/init/main.c b/init/main.c
index ad920fac325c..98c4a908ac13 100644
--- a/init/main.c
+++ b/init/main.c
@@ -99,6 +99,7 @@
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
+#include <linux/numa_replication.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -921,11 +922,13 @@ void start_kernel(void)
 	 * These use large bootmem allocations and must precede
 	 * initalization of page allocator
 	 */
+	numa_reserve_memory();
 	setup_log_buf(0);
 	vfs_caches_init_early();
 	sort_main_extable();
 	trap_init();
 	mm_core_init();
+	numa_replicate_kernel();
 	poking_init();
 	ftrace_init();
 
@@ -1446,6 +1449,8 @@ static int __ref kernel_init(void *unused)
 	free_initmem();
 	mark_readonly();
 
+	numa_replicate_kernel_rodata();
+	numa_clear_linear_addresses();
 	/*
 	 * Kernel mappings are now finalized - update the userspace page-table
 	 * to finalize PTI.
-- 
2.34.1

