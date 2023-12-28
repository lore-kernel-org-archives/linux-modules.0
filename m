Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142B58479
	for <linux-modules@vger.kernel.org>; Thu, 28 Dec 2023 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T185h4Fgwz6J9yq;
	Thu, 28 Dec 2023 21:11:04 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id AA1D2140DD5;
	Thu, 28 Dec 2023 21:12:47 +0800 (CST)
Received: from mscphis00060.huawei.com (10.123.65.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:12:45 +0000
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
Subject: [PATCH RFC 04/12] x86: add support of memory protection for NUMA replicas
Date: Thu, 28 Dec 2023 21:10:48 +0800
Message-ID: <20231228131056.602411-5-artem.kuzin@huawei.com>
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
 arch/x86/include/asm/set_memory.h |  14 +++
 arch/x86/mm/pat/set_memory.c      | 150 +++++++++++++++++++++++++++++-
 include/asm-generic/set_memory.h  |  12 +++
 include/linux/set_memory.h        |  10 ++
 4 files changed, 185 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index a5e89641bd2d..1efa15a08ef0 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -7,7 +7,9 @@
 #include <asm-generic/set_memory.h>
 
 #define set_memory_rox set_memory_rox
+#define numa_set_memory_rox numa_set_memory_rox
 int set_memory_rox(unsigned long addr, int numpages);
+int numa_set_memory_rox(unsigned long addr, int numpages);
 
 /*
  * The set_memory_* API can be used to change various attributes of a virtual
@@ -58,6 +60,18 @@ int set_pages_array_uc(struct page **pages, int addrinarray);
 int set_pages_array_wc(struct page **pages, int addrinarray);
 int set_pages_array_wb(struct page **pages, int addrinarray);
 
+#ifdef CONFIG_KERNEL_REPLICATION
+int numa_set_memory_np(unsigned long addr, int numpages);
+int numa_set_memory_np_noalias(unsigned long addr, int numpages);
+int numa_set_memory_global(unsigned long addr, int numpages);
+int numa_set_memory_nonglobal(unsigned long addr, int numpages);
+#else
+#define numa_set_memory_np set_memory_np
+#define numa_set_memory_np_noalias set_memory_np_noalias
+#define numa_set_memory_global set_memory_global
+#define numa_set_memory_nonglobal set_memory_nonglobal
+#endif /* CONFIG_KERNEL_REPLICATION */
+
 /*
  * For legacy compatibility with the old APIs, a few functions
  * are provided that work on a "struct page".
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index df4182b6449f..ceba209ee653 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -22,6 +22,7 @@
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
 #include <linux/memregion.h>
+#include <linux/numa_replication.h>
 
 #include <asm/e820/api.h>
 #include <asm/processor.h>
@@ -1790,7 +1791,7 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
 	return ret;
 }
 
-static int change_page_attr_set_clr(unsigned long *addr, int numpages,
+static int change_page_attr_set_clr_pgd(pgd_t *pgd, unsigned long *addr, int numpages,
 				    pgprot_t mask_set, pgprot_t mask_clr,
 				    int force_split, int in_flag,
 				    struct page **pages)
@@ -1845,6 +1846,7 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 	cpa.flags = in_flag;
 	cpa.curpage = 0;
 	cpa.force_split = force_split;
+	cpa.pgd = pgd;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -1873,6 +1875,15 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 	return ret;
 }
 
+static int change_page_attr_set_clr(unsigned long *addr, int numpages,
+				    pgprot_t mask_set, pgprot_t mask_clr,
+				    int force_split, int in_flag,
+				    struct page **pages)
+{
+	return change_page_attr_set_clr_pgd(NULL, addr, numpages, mask_set,
+					    mask_clr, force_split, in_flag, pages);
+}
+
 static inline int change_page_attr_set(unsigned long *addr, int numpages,
 				       pgprot_t mask, int array)
 {
@@ -1880,6 +1891,13 @@ static inline int change_page_attr_set(unsigned long *addr, int numpages,
 		(array ? CPA_ARRAY : 0), NULL);
 }
 
+static inline int change_page_attr_set_pgd(pgd_t *pgd, unsigned long *addr, int numpages,
+				       pgprot_t mask, int array)
+{
+	return change_page_attr_set_clr_pgd(pgd, addr, numpages, mask, __pgprot(0), 0,
+		(array ? CPA_ARRAY : 0), NULL);
+}
+
 static inline int change_page_attr_clear(unsigned long *addr, int numpages,
 					 pgprot_t mask, int array)
 {
@@ -1887,6 +1905,13 @@ static inline int change_page_attr_clear(unsigned long *addr, int numpages,
 		(array ? CPA_ARRAY : 0), NULL);
 }
 
+static inline int change_page_attr_clear_pgd(pgd_t *pgd, unsigned long *addr, int numpages,
+					 pgprot_t mask, int array)
+{
+	return change_page_attr_set_clr_pgd(pgd, addr, numpages, __pgprot(0), mask, 0,
+		(array ? CPA_ARRAY : 0), NULL);
+}
+
 static inline int cpa_set_pages_array(struct page **pages, int numpages,
 				       pgprot_t mask)
 {
@@ -2122,6 +2147,129 @@ int set_memory_global(unsigned long addr, int numpages)
 				    __pgprot(_PAGE_GLOBAL), 0);
 }
 
+#ifdef CONFIG_KERNEL_REPLICATION
+int numa_set_memory_x(unsigned long addr, int numpages)
+{
+	int ret = 0;
+	int nid;
+
+	if (!(__supported_pte_mask & _PAGE_NX))
+		return 0;
+	for_each_replica(nid)
+		ret |= change_page_attr_clear_pgd(init_mm.pgd_numa[nid], &addr, numpages,
+						 __pgprot(_PAGE_NX), 0);
+
+	return ret;
+}
+
+int numa_set_memory_nx(unsigned long addr, int numpages)
+{
+	int ret = 0;
+	int nid;
+
+	if (!(__supported_pte_mask & _PAGE_NX))
+		return 0;
+	for_each_replica(nid)
+		ret |= change_page_attr_set_pgd(init_mm.pgd_numa[nid], &addr, numpages,
+						__pgprot(_PAGE_NX), 0);
+
+	return ret;
+}
+
+int numa_set_memory_ro(unsigned long addr, int numpages)
+{
+	int ret = 0;
+	int nid;
+
+	for_each_replica(nid)
+		ret |= change_page_attr_clear_pgd(init_mm.pgd_numa[nid], &addr, numpages,
+						  __pgprot(_PAGE_RW), 0);
+
+	return ret;
+}
+
+int numa_set_memory_rox(unsigned long addr, int numpages)
+{
+	int nid;
+
+	int ret = 0;
+	pgprot_t clr = __pgprot(_PAGE_RW);
+
+	if (__supported_pte_mask & _PAGE_NX)
+		clr.pgprot |= _PAGE_NX;
+
+	for_each_online_node(nid) {
+		ret |= change_page_attr_clear_pgd(init_mm.pgd_numa[nid], &addr, numpages, clr, 0);
+		if (!is_text_replicated())
+			break;
+	}
+	return ret;
+}
+
+int numa_set_memory_rw(unsigned long addr, int numpages)
+{
+	int ret = 0;
+	int nid;
+
+	for_each_replica(nid)
+		ret |= change_page_attr_set_pgd(init_mm.pgd_numa[nid], &addr, numpages,
+						__pgprot(_PAGE_RW), 0);
+
+	return ret;
+}
+
+int numa_set_memory_np(unsigned long addr, int numpages)
+{
+	int ret = 0;
+	int nid;
+
+	for_each_replica(nid)
+		ret |= change_page_attr_clear_pgd(init_mm.pgd_numa[nid], &addr, numpages,
+						  __pgprot(_PAGE_PRESENT), 0);
+
+	return ret;
+}
+
+int numa_set_memory_np_noalias(unsigned long addr, int numpages)
+{
+	int ret = 0;
+	int nid;
+	int cpa_flags = CPA_NO_CHECK_ALIAS;
+
+	for_each_replica(nid)
+		ret |= change_page_attr_set_clr_pgd(init_mm.pgd_numa[nid], &addr, numpages,
+						    __pgprot(0),
+						    __pgprot(_PAGE_PRESENT), 0,
+						    cpa_flags, NULL);
+
+	return ret;
+}
+
+int numa_set_memory_global(unsigned long addr, int numpages)
+{
+	int ret = 0;
+	int nid;
+
+	for_each_replica(nid)
+		ret |= change_page_attr_set_pgd(init_mm.pgd_numa[nid], &addr, numpages,
+						__pgprot(_PAGE_GLOBAL), 0);
+
+	return ret;
+}
+
+int numa_set_memory_nonglobal(unsigned long addr, int numpages)
+{
+	int ret = 0;
+	int nid;
+
+	for_each_replica(nid)
+		ret |= change_page_attr_clear_pgd(init_mm.pgd_numa[nid], &addr, numpages,
+						  __pgprot(_PAGE_GLOBAL), 0);
+
+	return ret;
+}
+#endif
+
 /*
  * __set_memory_enc_pgtable() is used for the hypervisors that get
  * informed about "encryption" status via page tables.
diff --git a/include/asm-generic/set_memory.h b/include/asm-generic/set_memory.h
index c86abf6bc7ba..886639600e64 100644
--- a/include/asm-generic/set_memory.h
+++ b/include/asm-generic/set_memory.h
@@ -10,4 +10,16 @@ int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
 
+#ifdef CONFIG_KERNEL_REPLICATION
+int numa_set_memory_ro(unsigned long addr, int numpages);
+int numa_set_memory_rw(unsigned long addr, int numpages);
+int numa_set_memory_x(unsigned long addr, int numpages);
+int numa_set_memory_nx(unsigned long addr, int numpages);
+#else
+#define numa_set_memory_ro set_memory_ro
+#define numa_set_memory_rw set_memory_rw
+#define numa_set_memory_x  set_memory_x
+#define numa_set_memory_nx set_memory_nx
+#endif /* CONFIG_KERNEL_REPLICATION */
+
 #endif
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 95ac8398ee72..3213bfd335dd 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -24,6 +24,16 @@ static inline int set_memory_rox(unsigned long addr, int numpages)
 }
 #endif
 
+#ifndef numa_set_memory_rox
+static inline int numa_set_memory_rox(unsigned long addr, int numpages)
+{
+	int ret = numa_set_memory_ro(addr, numpages);
+	if (ret)
+		return ret;
+	return numa_set_memory_x(addr, numpages);
+}
+#endif
+
 #ifndef CONFIG_ARCH_HAS_SET_DIRECT_MAP
 static inline int set_direct_map_invalid_noflush(struct page *page)
 {
-- 
2.34.1

