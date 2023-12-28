Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC879EE
	for <linux-modules@vger.kernel.org>; Thu, 28 Dec 2023 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T185z3ybJz6J9xD;
	Thu, 28 Dec 2023 21:11:19 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 4259E1400D2;
	Thu, 28 Dec 2023 21:13:02 +0800 (CST)
Received: from mscphis00060.huawei.com (10.123.65.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:13:00 +0000
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
Subject: [PATCH RFC 12/12] mm: set memory permissions for BPF handlers replicas
Date: Thu, 28 Dec 2023 21:10:56 +0800
Message-ID: <20231228131056.602411-13-artem.kuzin@huawei.com>
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
 kernel/bpf/bpf_struct_ops.c    | 8 ++++----
 kernel/bpf/core.c              | 4 ++--
 kernel/bpf/trampoline.c        | 6 +++---
 net/bpf/bpf_dummy_struct_ops.c | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 116a0ce378ec..9fb1dc5fbd5c 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -512,7 +512,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		err = st_ops->validate(kdata);
 		if (err)
 			goto reset_unlock;
-		set_memory_rox((long)st_map->image, 1);
+		numa_set_memory_rox((long)st_map->image, 1);
 		/* Let bpf_link handle registration & unregistration.
 		 *
 		 * Pair with smp_load_acquire() during lookup_elem().
@@ -521,7 +521,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		goto unlock;
 	}
 
-	set_memory_rox((long)st_map->image, 1);
+	numa_set_memory_rox((long)st_map->image, 1);
 	err = st_ops->reg(kdata);
 	if (likely(!err)) {
 		/* This refcnt increment on the map here after
@@ -544,8 +544,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	 * there was a race in registering the struct_ops (under the same name) to
 	 * a sub-system through different struct_ops's maps.
 	 */
-	set_memory_nx((long)st_map->image, 1);
-	set_memory_rw((long)st_map->image, 1);
+	numa_set_memory_nx((long)st_map->image, 1);
+	numa_set_memory_rw((long)st_map->image, 1);
 
 reset_unlock:
 	bpf_struct_ops_map_put_progs(st_map);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e3e45b651cd4..73ebda57c0f5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -870,7 +870,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	list_add_tail(&pack->list, &pack_list);
 
 	set_vm_flush_reset_perms(pack->ptr);
-	set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	numa_set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
 	return pack;
 }
 
@@ -888,7 +888,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 		if (ptr) {
 			bpf_fill_ill_insns(ptr, size);
 			set_vm_flush_reset_perms(ptr);
-			set_memory_rox((unsigned long)ptr, size / PAGE_SIZE);
+			numa_set_memory_rox((unsigned long)ptr, size / PAGE_SIZE);
 		}
 		goto out;
 	}
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 53ff50cac61e..964ae6128ef7 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -444,7 +444,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (err < 0)
 		goto out_free;
 
-	set_memory_rox((long)im->image, 1);
+	numa_set_memory_rox((long)im->image, 1);
 
 	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
@@ -465,8 +465,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		tr->fops->trampoline = 0;
 
 		/* reset im->image memory attr for arch_prepare_bpf_trampoline */
-		set_memory_nx((long)im->image, 1);
-		set_memory_rw((long)im->image, 1);
+		numa_set_memory_nx((long)im->image, 1);
+		numa_set_memory_rw((long)im->image, 1);
 		goto again;
 	}
 #endif
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 5918d1b32e19..45a5dbd379ac 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -124,7 +124,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (err < 0)
 		goto out;
 
-	set_memory_rox((long)image, 1);
+	numa_set_memory_rox((long)image, 1);
 	prog_ret = dummy_ops_call_op(image, args);
 
 	err = dummy_ops_copy_args(args);
-- 
2.34.1

