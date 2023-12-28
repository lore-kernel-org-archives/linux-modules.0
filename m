Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4E79C1
	for <linux-modules@vger.kernel.org>; Thu, 28 Dec 2023 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T186Q1JlJz6K5yJ;
	Thu, 28 Dec 2023 21:11:42 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B6ED1408FF;
	Thu, 28 Dec 2023 21:12:49 +0800 (CST)
Received: from mscphis00060.huawei.com (10.123.65.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:12:47 +0000
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
Subject: [PATCH RFC 05/12] x86: enable memory protection for replicated memory
Date: Thu, 28 Dec 2023 21:10:49 +0800
Message-ID: <20231228131056.602411-6-artem.kuzin@huawei.com>
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
 arch/x86/kernel/kprobes/core.c | 2 +-
 arch/x86/mm/init.c             | 8 ++++----
 arch/x86/mm/init_64.c          | 4 ++--
 arch/x86/mm/pti.c              | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index f7f6042eb7e6..0fb29a4855fe 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -422,7 +422,7 @@ void *alloc_insn_page(void)
 	 * TODO: Once additional kernel code protection mechanisms are set, ensure
 	 * that the page was not maliciously altered and it is still zeroed.
 	 */
-	set_memory_rox((unsigned long)page, 1);
+	numa_set_memory_rox((unsigned long)page, 1);
 
 	return page;
 }
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 8192452d1d2d..f797e194bfb0 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -927,15 +927,15 @@ void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 		 * corresponding pages will be unmapped.
 		 */
 		kmemleak_free_part((void *)begin, end - begin);
-		set_memory_np(begin, (end - begin) >> PAGE_SHIFT);
+		numa_set_memory_np(begin, (end - begin) >> PAGE_SHIFT);
 	} else {
 		/*
 		 * We just marked the kernel text read only above, now that
 		 * we are going to free part of that, we need to make that
 		 * writeable and non-executable first.
 		 */
-		set_memory_nx(begin, (end - begin) >> PAGE_SHIFT);
-		set_memory_rw(begin, (end - begin) >> PAGE_SHIFT);
+		numa_set_memory_nx(begin, (end - begin) >> PAGE_SHIFT);
+		numa_set_memory_rw(begin, (end - begin) >> PAGE_SHIFT);
 
 		free_reserved_area((void *)begin, (void *)end,
 				   POISON_FREE_INITMEM, what);
@@ -971,7 +971,7 @@ void free_kernel_image_pages(const char *what, void *begin, void *end)
 	 * which can't be treated in this way for obvious reasons.
 	 */
 	if (IS_ENABLED(CONFIG_X86_64) && cpu_feature_enabled(X86_FEATURE_PTI))
-		set_memory_np_noalias(begin_ul, len_pages);
+		numa_set_memory_np_noalias(begin_ul, len_pages);
 }
 
 void __ref free_initmem(void)
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a190aae8ceaf..98cb7f5f2863 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1379,7 +1379,7 @@ void mark_rodata_ro(void)
 
 	printk(KERN_INFO "Write protecting the kernel read-only data: %luk\n",
 	       (end - start) >> 10);
-	set_memory_ro(start, (end - start) >> PAGE_SHIFT);
+	numa_set_memory_ro(start, (end - start) >> PAGE_SHIFT);
 
 	kernel_set_to_readonly = 1;
 
@@ -1396,7 +1396,7 @@ void mark_rodata_ro(void)
 	 * has been zapped already via cleanup_highmem().
 	 */
 	all_end = roundup((unsigned long)_brk_end, PMD_SIZE);
-	set_memory_nx(text_end, (all_end - text_end) >> PAGE_SHIFT);
+	numa_set_memory_nx(text_end, (all_end - text_end) >> PAGE_SHIFT);
 
 	set_ftrace_ops_ro();
 
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 78414c6d1b5e..23f30edf71b3 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -580,7 +580,7 @@ static void pti_clone_kernel_text(void)
 	 */
 
 	/* Set the global bit for normal non-__init kernel text: */
-	set_memory_global(start, (end_global - start) >> PAGE_SHIFT);
+	numa_set_memory_global(start, (end_global - start) >> PAGE_SHIFT);
 }
 
 static void pti_set_kernel_image_nonglobal(void)
-- 
2.34.1

