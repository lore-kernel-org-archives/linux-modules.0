Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1428C8475
	for <linux-modules@vger.kernel.org>; Thu, 28 Dec 2023 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T185Y1ThKz6J9q9;
	Thu, 28 Dec 2023 21:10:57 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id E04FE140DD5;
	Thu, 28 Dec 2023 21:12:39 +0800 (CST)
Received: from mscphis00060.huawei.com (10.123.65.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:12:37 +0000
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
Subject: [PATCH RFC 00/12] x86 NUMA-aware kernel replication
Date: Thu, 28 Dec 2023 21:10:44 +0800
Message-ID: <20231228131056.602411-1-artem.kuzin@huawei.com>
X-Mailer: git-send-email 2.34.1
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

This patchset implements initial support of kernel
text and rodata replication for x86_64 platform.
Linux kernel 6.5.5 is used as a baseline.

There was a work previously published for ARM64 platform
by Russell King (arm64 kernel text replication).
We hope that it will be possible to push this technology forward together.

Current implementation supports next functionality:
1. Replicated kernel text and rodata per-NUMA node
2. Vmalloc is able to work with replicated areas, so
   kernel modules text and rodata also replicated during
   modules loading stage.
3. BPF handlers are not replicated by default,
   but this can be easily done by using existent APIs.
3. KASAN is working except 5-lvl translation table case.
4. KPROBES, KGDB and all functionality that depends on
   kernel text patching work without any limitation.
5. KPTI and KASLR fully supported.
6. Replicates parts of translation table related to
   replicated text and rodata.

Translation tables synchronization is necessary only in several special cases:
1. Kernel boot
2. Modules deployment
3. Any allocation in user space that require new PUD/P4D

In current design mutable kernel data modifications don't require
synchronization between translation tables due to on 64-bit platforms
all physical memory already mapped in kernel space and this mapping
is persistent.
In user space the translation tables synchronizations are quite rare
due to the only case is new PUD/P4D allocation. Nowadays the only PGD
layer is replicated for user space. Please refer the next pics.

TT overview:
                   NODE 0                   NODE 1
              USER      KERNEL         USER      KERNEL
           ---------------------    ---------------------
     PGD   | | | | |   | | | |*|    | | | | |   | | | |*|
           ---------------------    ---------------------
                              |                        |
            -------------------      ------------------- 
            |                        |
           ---------------------    ---------------------
     PUD   | | | | |   | | |*|*|    | | | | |   | | |*|*|
           ---------------------    ---------------------
                              |                        |
            -------------------      -------------------
            |                        |
           ---------------------    ---------------------
     PMD   |READ-ONLY|MUTABLE  |    |READ-ONLY|MUTABLE  |
           ---------------------    --------------------- 
                  |       |                  |     |
                  |       --------------------------
                  |               |          |
                --------       -------      --------
   PHYS         |      |       |     |      |      |
    MEM         --------       -------      --------
                <------>                    <------>
                 NODE 0        Shared        NODE 1
                               between
                               nodes
* - entries unique in each table

TT synchronization:
               NODE 0                    NODE 1
          USER      KERNEL          USER      KERNEL
       ---------------------     ---------------------
 PGD   | | |0| |   | | | | |     | | |0| |   | | | | |
       ---------------------     ---------------------
                              |
                              |
                              |
                              |
                              |  PUD_ALLOC / P4D_ALLOC
                              |
                              |      IN USERSPACE
                              |
                              \/
       ---------------------     ---------------------
 PGD   | | |p| |   | | | | |     | | |p| |   | | | | |
       ---------------------     ---------------------
            |                         |
            |                         |
            ---------------------------
                     |
                    ---------------------
 PUD/P4D            | | | | |   | | | | |
                    ---------------------

Known problems:
1. KASAN is not working in case of 5-lvl translation table.
2. Replication support in vmalloc, possibly, can be optimized in future.
3. Module APIs currently have lack of memory policies support.
   This part will be fixed in future.

Preliminary performance evaluation results:
Processor Intel(R) Xeon(R) CPU E5-2690
2 nodes with 12 CPU cores for each one

fork/1 - Time measurements include only one time of invoking this system call.
         Measurements are made between entering and exiting the system call.

fork/1024 - The system call is invoked in  a loop 1024 times.
            The time between entering a loop and exiting it was measured.

mmap/munmap - A set of 1024 pages (if PAGE_SIZE is not defined it is equal to 4096)
              was mapped using mmap syscall and unmapped using munmap one.
              Every page is mapped/unmapped per a loop iteration.

mmap/lock - The same as above, but in this case flag MAP_LOCKED was added.

open/close - The /dev/null pseudo-file was opened and closed in a loop 1024 times.
             It was opened and closed once per iteration.

mount - The pseudo-filesystem procFS was mounted to a temporary directory inside /tmp only one time.
        The time between entering and exiting the system call was measured.

kill - A signal handler for SIGUSR1 was setup. Signal was sent to a child process,
       which was created using fork glibc's wrapper. Time between sending and receiving
       SIGUSR1 signal was measured.

Hot caches:

fork-1          2.3%
fork-1024       10.8%
mmap/munmap     0.4%
mmap/lock       4.2%
open/close      3.2%
kill            4%
mount           8.7%

Cold caches:

fork-1          42.7%
fork-1024       17.1%
mmap/munmap     0.4%
mmap/lock       1.5%
open/close      0.4%
kill            26.1%
mount           4.1%

Artem Kuzin (12):
  mm: allow per-NUMA node local PUD/PMD allocation
  mm: add config option and per-NUMA node VMS support
  mm: per-NUMA node replication core infrastructure
  x86: add support of memory protection for NUMA replicas
  x86: enable memory protection for replicated memory
  x86: align kernel text and rodata using HUGE_PAGE boundary
  x86: enable per-NUMA node kernel text and rodata replication
  x86: make kernel text patching aware about replicas
  x86: add support of NUMA replication for efi page tables
  mm: add replicas allocation support for vmalloc
  x86: add kernel modules text and rodata replication support
  mm: set memory permissions for BPF handlers replicas

 arch/x86/include/asm/numa_replication.h |  42 ++
 arch/x86/include/asm/pgalloc.h          |  10 +
 arch/x86/include/asm/set_memory.h       |  14 +
 arch/x86/kernel/alternative.c           | 116 ++---
 arch/x86/kernel/kprobes/core.c          |   2 +-
 arch/x86/kernel/module.c                |  35 +-
 arch/x86/kernel/smpboot.c               |   2 +
 arch/x86/kernel/vmlinux.lds.S           |   4 +-
 arch/x86/mm/dump_pagetables.c           |   9 +
 arch/x86/mm/fault.c                     |   4 +-
 arch/x86/mm/init.c                      |   8 +-
 arch/x86/mm/init_64.c                   |   4 +-
 arch/x86/mm/pat/set_memory.c            | 150 ++++++-
 arch/x86/mm/pgtable.c                   |  76 +++-
 arch/x86/mm/pti.c                       |   2 +-
 arch/x86/mm/tlb.c                       |  30 +-
 arch/x86/platform/efi/efi_64.c          |   9 +
 include/asm-generic/pgalloc.h           |  34 ++
 include/asm-generic/set_memory.h        |  12 +
 include/linux/gfp.h                     |   2 +
 include/linux/mm.h                      |  79 +++-
 include/linux/mm_types.h                |  11 +-
 include/linux/moduleloader.h            |  10 +
 include/linux/numa_replication.h        |  85 ++++
 include/linux/set_memory.h              |  10 +
 include/linux/vmalloc.h                 |  24 +
 init/main.c                             |   5 +
 kernel/bpf/bpf_struct_ops.c             |   8 +-
 kernel/bpf/core.c                       |   4 +-
 kernel/bpf/trampoline.c                 |   6 +-
 kernel/module/main.c                    |   8 +
 kernel/module/strict_rwx.c              |  14 +-
 mm/Kconfig                              |  10 +
 mm/Makefile                             |   1 +
 mm/memory.c                             | 251 ++++++++++-
 mm/numa_replication.c                   | 564 ++++++++++++++++++++++++
 mm/page_alloc.c                         |  18 +
 mm/vmalloc.c                            | 469 ++++++++++++++++----
 net/bpf/bpf_dummy_struct_ops.c          |   2 +-
 39 files changed, 1919 insertions(+), 225 deletions(-)
 create mode 100644 arch/x86/include/asm/numa_replication.h
 create mode 100644 include/linux/numa_replication.h
 create mode 100644 mm/numa_replication.c

-- 
2.34.1

