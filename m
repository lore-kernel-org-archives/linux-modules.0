Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C28465
	for <linux-modules@vger.kernel.org>; Thu, 28 Dec 2023 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T184x2vMbz6K8j1;
	Thu, 28 Dec 2023 21:10:25 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A851140DD5;
	Thu, 28 Dec 2023 21:12:42 +0800 (CST)
Received: from mscphis00060.huawei.com (10.123.65.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:12:39 +0000
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
Subject: [PATCH RFC 01/12] mm: allow per-NUMA node local PUD/PMD allocation
Date: Thu, 28 Dec 2023 21:10:45 +0800
Message-ID: <20231228131056.602411-2-artem.kuzin@huawei.com>
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
 include/asm-generic/pgalloc.h | 34 ++++++++++++++++++++++++++++++++++
 include/linux/gfp.h           |  2 ++
 mm/page_alloc.c               | 18 ++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index a7cf825befae..6364375388bf 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -132,6 +132,24 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 	}
 	return (pmd_t *)page_address(page);
 }
+
+static inline pmd_t *pmd_alloc_one_node(unsigned int nid,
+					struct mm_struct *mm, unsigned long addr)
+{
+	struct page *page;
+	gfp_t gfp = GFP_PGTABLE_USER;
+
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	page = alloc_pages_node(nid, gfp, 0);
+	if (!page)
+		return NULL;
+	if (!pgtable_pmd_page_ctor(page)) {
+		__free_pages(page, 0);
+		return NULL;
+	}
+	return (pmd_t *)page_address(page);
+}
 #endif
 
 #ifndef __HAVE_ARCH_PMD_FREE
@@ -156,6 +174,16 @@ static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 	return (pud_t *)get_zeroed_page(gfp);
 }
 
+static inline pud_t *__pud_alloc_one_node(unsigned int nid,
+					  struct mm_struct *mm, unsigned long addr)
+{
+	gfp_t gfp = GFP_PGTABLE_USER;
+
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	return (pud_t *)get_zeroed_page_node(nid, gfp);
+}
+
 #ifndef __HAVE_ARCH_PUD_ALLOC_ONE
 /**
  * pud_alloc_one - allocate a page for PUD-level page table
@@ -170,6 +198,12 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	return __pud_alloc_one(mm, addr);
 }
+
+static inline pud_t *pud_alloc_one_node(unsigned int nid,
+					struct mm_struct *mm, unsigned long addr)
+{
+	return __pud_alloc_one_node(nid, mm, addr);
+}
 #endif
 
 static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 665f06675c83..6ee0004b9774 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -288,6 +288,8 @@ static inline struct page *alloc_page_vma(gfp_t gfp,
 
 extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
 extern unsigned long get_zeroed_page(gfp_t gfp_mask);
+extern unsigned long __get_free_pages_node(unsigned int nid, gfp_t gfp_mask, unsigned int order);
+extern unsigned long get_zeroed_page_node(unsigned int nid, gfp_t gfp_mask);
 
 void *alloc_pages_exact(size_t size, gfp_t gfp_mask) __alloc_size(1);
 void free_pages_exact(void *virt, size_t size);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7d3460c7a480..dc8f4a57d8b1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4537,6 +4537,24 @@ unsigned long get_zeroed_page(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(get_zeroed_page);
 
+unsigned long __get_free_pages_node(unsigned int nid, gfp_t gfp_mask,
+		unsigned int order)
+{
+	struct page *page;
+
+	page = alloc_pages_node(nid, gfp_mask & ~__GFP_HIGHMEM, order);
+	if (!page)
+		return 0;
+	return (unsigned long) page_address(page);
+}
+EXPORT_SYMBOL(__get_free_pages_node);
+
+unsigned long get_zeroed_page_node(unsigned int nid, gfp_t gfp_mask)
+{
+	return __get_free_pages_node(nid, gfp_mask | __GFP_ZERO, 0);
+}
+EXPORT_SYMBOL(get_zeroed_page_node);
+
 /**
  * __free_pages - Free pages allocated with alloc_pages().
  * @page: The page pointer returned from alloc_pages().
-- 
2.34.1

