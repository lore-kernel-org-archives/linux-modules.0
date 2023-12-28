Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A0679C8
	for <linux-modules@vger.kernel.org>; Thu, 28 Dec 2023 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T185B2nk5z67ncD;
	Thu, 28 Dec 2023 21:10:38 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BF711400F4;
	Thu, 28 Dec 2023 21:12:55 +0800 (CST)
Received: from mscphis00060.huawei.com (10.123.65.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:12:52 +0000
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
Subject: [PATCH RFC 08/12] x86: make kernel text patching aware about replicas
Date: Thu, 28 Dec 2023 21:10:52 +0800
Message-ID: <20231228131056.602411-9-artem.kuzin@huawei.com>
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
 arch/x86/kernel/alternative.c | 116 ++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 44843a492e69..b0abd60bcafe 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -18,6 +18,7 @@
 #include <linux/mmu_context.h>
 #include <linux/bsearch.h>
 #include <linux/sync_core.h>
+#include <linux/numa_replication.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
@@ -1659,6 +1660,7 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 				      size_t len)
 {
 	unsigned long flags;
+	int nid;
 
 	if (boot_cpu_has(X86_FEATURE_NX) &&
 	    is_module_text_address((unsigned long)addr)) {
@@ -1669,8 +1671,18 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 		 */
 		memcpy(addr, opcode, len);
 	} else {
+		unsigned long iaddr = (unsigned long)addr;
+
 		local_irq_save(flags);
-		memcpy(addr, opcode, len);
+		if (is_text_replicated() && is_kernel_text(iaddr)) {
+			for_each_replica(nid) {
+				void *vaddr = numa_addr_in_replica(addr, nid);
+
+				memcpy(vaddr, opcode, len);
+			}
+		} else {
+			memcpy(addr, opcode, len);
+		}
 		local_irq_restore(flags);
 		sync_core();
 
@@ -1764,36 +1776,21 @@ typedef void text_poke_f(void *dst, const void *src, size_t len);
 
 static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t len)
 {
+	int nid;
 	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
 	struct page *pages[2] = {NULL};
 	temp_mm_state_t prev;
 	unsigned long flags;
+	int size_in_poking_mm = PAGE_SIZE;
 	pte_t pte, *ptep;
 	spinlock_t *ptl;
 	pgprot_t pgprot;
-
+	bool has_replica = numa_addr_has_replica(addr);
 	/*
 	 * While boot memory allocator is running we cannot use struct pages as
 	 * they are not yet initialized. There is no way to recover.
 	 */
 	BUG_ON(!after_bootmem);
-
-	if (!core_kernel_text((unsigned long)addr)) {
-		pages[0] = vmalloc_to_page(addr);
-		if (cross_page_boundary)
-			pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
-	} else {
-		pages[0] = virt_to_page(addr);
-		WARN_ON(!PageReserved(pages[0]));
-		if (cross_page_boundary)
-			pages[1] = virt_to_page(addr + PAGE_SIZE);
-	}
-	/*
-	 * If something went wrong, crash and burn since recovery paths are not
-	 * implemented.
-	 */
-	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
-
 	/*
 	 * Map the page without the global bit, as TLB flushing is done with
 	 * flush_tlb_mm_range(), which is intended for non-global PTEs.
@@ -1812,48 +1809,59 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 
 	local_irq_save(flags);
 
-	pte = mk_pte(pages[0], pgprot);
-	set_pte_at(poking_mm, poking_addr, ptep, pte);
+	for_each_replica(nid) {
+		prev = use_temporary_mm(poking_mm);
 
-	if (cross_page_boundary) {
-		pte = mk_pte(pages[1], pgprot);
-		set_pte_at(poking_mm, poking_addr + PAGE_SIZE, ptep + 1, pte);
-	}
+		pages[0] = walk_to_page_node(nid, addr);
+		if (cross_page_boundary)
+			pages[1] = walk_to_page_node(nid, addr + PAGE_SIZE);
 
-	/*
-	 * Loading the temporary mm behaves as a compiler barrier, which
-	 * guarantees that the PTE will be set at the time memcpy() is done.
-	 */
-	prev = use_temporary_mm(poking_mm);
+		BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
 
-	kasan_disable_current();
-	func((u8 *)poking_addr + offset_in_page(addr), src, len);
-	kasan_enable_current();
+		pte = mk_pte(pages[0], pgprot);
+		set_pte_at(poking_mm, poking_addr, ptep, pte);
 
-	/*
-	 * Ensure that the PTE is only cleared after the instructions of memcpy
-	 * were issued by using a compiler barrier.
-	 */
-	barrier();
+		if (cross_page_boundary) {
+			pte = mk_pte(pages[1], pgprot);
+			set_pte_at(poking_mm, poking_addr + PAGE_SIZE, ptep + 1, pte);
+		}
+		/*
+		 * Compiler barrier to ensure that PTE is set before func()
+		 */
+		barrier();
 
-	pte_clear(poking_mm, poking_addr, ptep);
-	if (cross_page_boundary)
-		pte_clear(poking_mm, poking_addr + PAGE_SIZE, ptep + 1);
+		kasan_disable_current();
+		func((u8 *)poking_addr + offset_in_page(addr), src, len);
+		kasan_enable_current();
 
-	/*
-	 * Loading the previous page-table hierarchy requires a serializing
-	 * instruction that already allows the core to see the updated version.
-	 * Xen-PV is assumed to serialize execution in a similar manner.
-	 */
-	unuse_temporary_mm(prev);
+		/*
+		 * Ensure that the PTE is only cleared after the instructions of memcpy
+		 * were issued by using a compiler barrier.
+		 */
+		barrier();
 
-	/*
-	 * Flushing the TLB might involve IPIs, which would require enabled
-	 * IRQs, but not if the mm is not used, as it is in this point.
-	 */
-	flush_tlb_mm_range(poking_mm, poking_addr, poking_addr +
-			   (cross_page_boundary ? 2 : 1) * PAGE_SIZE,
-			   PAGE_SHIFT, false);
+		pte_clear(poking_mm, poking_addr, ptep);
+		if (cross_page_boundary)
+			pte_clear(poking_mm, poking_addr + PAGE_SIZE, ptep + 1);
+
+		/*
+		 * Loading the previous page-table hierarchy requires a serializing
+		 * instruction that already allows the core to see the updated version.
+		 * Xen-PV is assumed to serialize execution in a similar manner.
+		 */
+		unuse_temporary_mm(prev);
+
+		/*
+		 * Flushing the TLB might involve IPIs, which would require enabled
+		 * IRQs, but not if the mm is not used, as it is in this point.
+		 */
+
+		flush_tlb_mm_range(poking_mm, poking_addr, poking_addr +
+				(cross_page_boundary ? 2 : 1) * size_in_poking_mm,
+				PAGE_SHIFT, false);
+		if (!has_replica)
+			break;
+	}
 
 	if (func == text_poke_memcpy) {
 		/*
-- 
2.34.1

