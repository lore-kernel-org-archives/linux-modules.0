Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED978464
	for <linux-modules@vger.kernel.org>; Thu, 28 Dec 2023 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T186K0xDXz67K2K;
	Thu, 28 Dec 2023 21:11:37 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E2DD1400D2;
	Thu, 28 Dec 2023 21:12:44 +0800 (CST)
Received: from mscphis00060.huawei.com (10.123.65.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:12:42 +0000
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
Subject: [PATCH RFC 02/12] mm: add config option and per-NUMA node VMS support
Date: Thu, 28 Dec 2023 21:10:46 +0800
Message-ID: <20231228131056.602411-3-artem.kuzin@huawei.com>
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
 include/linux/mm_types.h | 11 ++++++++++-
 mm/Kconfig               | 10 ++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7d30dc4ff0ff..1fafb8425994 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -22,6 +22,8 @@
 
 #include <asm/mmu.h>
 
+#include <linux/numa.h>
+
 #ifndef AT_VECTOR_SIZE_ARCH
 #define AT_VECTOR_SIZE_ARCH 0
 #endif
@@ -626,7 +628,14 @@ struct mm_struct {
 		unsigned long mmap_compat_legacy_base;
 #endif
 		unsigned long task_size;	/* size of task vm space */
-		pgd_t * pgd;
+#ifndef CONFIG_KERNEL_REPLICATION
+		pgd_t *pgd;
+#else
+		union {
+			pgd_t *pgd;
+			pgd_t *pgd_numa[MAX_NUMNODES];
+		};
+#endif
 
 #ifdef CONFIG_MEMBARRIER
 		/**
diff --git a/mm/Kconfig b/mm/Kconfig
index 09130434e30d..5fe5b3ba7f99 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1236,6 +1236,16 @@ config LOCK_MM_AND_FIND_VMA
 	bool
 	depends on !STACK_GROWSUP
 
+config KERNEL_REPLICATION
+	bool "Enable kernel text and ro-data replication between NUMA nodes"
+	default n
+	depends on (X86_64 && !(KASAN && X86_5LEVEL)) && MMU && NUMA && !MAXSMP
+
+	help
+	  Creates per-NUMA node replicas of kernel text and rodata sections.
+	  Page tables are replicated partially, according to replicated kernel memory range.
+	  If unsure, say "n".
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.34.1

