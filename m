Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2479C8
	for <linux-modules@vger.kernel.org>; Thu, 28 Dec 2023 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T185D2r4Pz67kr9;
	Thu, 28 Dec 2023 21:10:40 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 39BB2140DD5;
	Thu, 28 Dec 2023 21:12:57 +0800 (CST)
Received: from mscphis00060.huawei.com (10.123.65.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:12:55 +0000
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
Subject: [PATCH RFC 09/12] x86: add support of NUMA replication for efi page tables
Date: Thu, 28 Dec 2023 21:10:53 +0800
Message-ID: <20231228131056.602411-10-artem.kuzin@huawei.com>
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
 arch/x86/platform/efi/efi_64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 77f7ac3668cb..986d2dddef7a 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -35,6 +35,7 @@
 #include <linux/ucs2_string.h>
 #include <linux/cc_platform.h>
 #include <linux/sched/task.h>
+#include <linux/numa_replication.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
@@ -71,6 +72,9 @@ int __init efi_alloc_page_tables(void)
 	p4d_t *p4d;
 	pud_t *pud;
 	gfp_t gfp_mask;
+#ifdef CONFIG_KERNEL_REPLICATION
+	int nid;
+#endif
 
 	gfp_mask = GFP_KERNEL | __GFP_ZERO;
 	efi_pgd = (pgd_t *)__get_free_pages(gfp_mask, PGD_ALLOCATION_ORDER);
@@ -86,7 +90,12 @@ int __init efi_alloc_page_tables(void)
 	if (!pud)
 		goto free_p4d;
 
+#ifdef CONFIG_KERNEL_REPLICATION
+	for_each_online_node(nid)
+		per_numa_pgd(&efi_mm, nid) = efi_pgd;
+#else
 	efi_mm.pgd = efi_pgd;
+#endif
 	mm_init_cpumask(&efi_mm);
 	init_new_context(NULL, &efi_mm);
 
-- 
2.34.1

