Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E03A8DC
	for <linux-modules@vger.kernel.org>; Tue,  9 Jan 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8b510y91z6J6Fc;
	Tue,  9 Jan 2024 23:51:17 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id CA1D1140A08;
	Tue,  9 Jan 2024 23:53:03 +0800 (CST)
Received: from [10.123.123.147] (10.123.123.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 15:53:01 +0000
Message-ID: <dd35192c-a3d3-4c6a-9914-d4739376ffb1@huawei.com>
Date: Tue, 9 Jan 2024 18:53:00 +0300
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "a00561249@china.huawei.com" <artem.kuzin@huawei.com>
Subject: Re: [PATCH RFC 04/12] x86: add support of memory protection for NUMA
 replicas
To: "Garg, Shivank" <shivankg@amd.com>, <x86@kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <luto@kernel.org>,
	<peterz@infradead.org>, <akpm@linux-foundation.org>, <urezki@gmail.com>,
	<hch@infradead.org>, <lstoakes@gmail.com>, <mcgrof@kernel.org>,
	<rmk+kernel@armlinux.org.uk>
CC: <nikita.panov@huawei-partners.com>, <alexander.grubnikov@huawei.com>,
	<stepanov.anatoly@huawei.com>, <guohanjun@huawei.com>,
	<weiyongjun1@huawei.com>, <wangkefeng.wang@huawei.com>,
	<judy.chenhui@huawei.com>, <yusongping@huawei.com>, <kang.sun@huawei.com>,
	<linux-mm@kvack.org>, <linux-modules@vger.kernel.org>, <bharata@amd.com>,
	<raghavendra.kt@amd.com>
References: <20231228131056.602411-1-artem.kuzin@huawei.com>
 <20231228131056.602411-5-artem.kuzin@huawei.com>
 <083a2549-f4ed-478e-a4ff-938a3eb15ab0@amd.com>
Content-Language: en-US
In-Reply-To: <083a2549-f4ed-478e-a4ff-938a3eb15ab0@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 lhrpeml500001.china.huawei.com (7.191.163.213)

Hi Shivank,
thanks a lot for the comments and findings, I've fixed build and plan to update the patch set soon.

On 1/9/2024 9:46 AM, Garg, Shivank wrote:
> Hi Artem,
>
> I hope this message finds you well.
> I've encountered a compilation issue when KERNEL_REPLICATION is disabled in the config.
>
> ld: vmlinux.o: in function `alloc_insn_page':
> /home/amd/linux_mainline/arch/x86/kernel/kprobes/core.c:425: undefined reference to `numa_set_memory_rox'
> ld: vmlinux.o: in function `alloc_new_pack':
> /home/amd/linux_mainline/kernel/bpf/core.c:873: undefined reference to `numa_set_memory_rox'
> ld: vmlinux.o: in function `bpf_prog_pack_alloc':
> /home/amd/linux_mainline/kernel/bpf/core.c:891: undefined reference to `numa_set_memory_rox'
> ld: vmlinux.o: in function `bpf_trampoline_update':
> /home/amd/linux_mainline/kernel/bpf/trampoline.c:447: undefined reference to `numa_set_memory_rox'
> ld: vmlinux.o: in function `bpf_struct_ops_map_update_elem':
> /home/amd/linux_mainline/kernel/bpf/bpf_struct_ops.c:515: undefined reference to `numa_set_memory_rox'
> ld: vmlinux.o:/home/amd/linux_mainline/kernel/bpf/bpf_struct_ops.c:524: more undefined references to `numa_set_memory_rox' follow
>
>
> After some investigation, I've put together a patch that resolves this compilation issues for me.
>
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2268,6 +2268,15 @@ int numa_set_memory_nonglobal(unsigned long addr, int numpages)
>
>         return ret;
>  }
> +
> +#else
> +
> +int numa_set_memory_rox(unsigned long addr, int numpages)
> +{
> +       return set_memory_rox(addr, numpages);
> +
> +}
> +
>  #endif
>
> Additionally, I'm interested in evaluating the performance impact of this patchset on AMD processors.
> Could you please point me the benchmarks that you have used in cover letter?
>
> Best Regards,
> Shivank
>
Regarding the benchmarks, we used self-implemented test with system calls load for now.
We used RedHawk Linux approach as a reference.

The "An Overview of Kernel Text Page Replication in RedHawk™ Linux® 6.3" article was used.
https://concurrent-rt.com/wp-content/uploads/2020/12/kernel-page-replication.pdf

The test is very simple:
All measured system calls have been invoked using syscall wrapper from glibc, e.g.

#include <sys/syscall.h>      /* Definition of SYS_* constants */
#include <unistd.h>
 
long syscall(long number, ...);

fork/1
    Time measurements include only one time of invoking this system call. Measurements are made between entering
    and exiting the system call.
fork/1024
    The system call is invoked in  a loop 1024 times. The time between entering a loop and exiting it was measured.
mmap/munmap
    A set of 1024 pages (if PAGE_SIZE is not defined it is equal to 4096) was mapped using mmap syscall
    and unmapped using munmap one. Every page is mapped/unmapped per a loop iteration.
mmap/lock
    The same as above, but in this case flag MAP_LOCKED was added.
open/close
    The /dev/null pseudo-file was opened and closed in a loop 1024 times. It was opened and closed once per iteration.
mount
    The pseudo-filesystem procFS was mounted to a temporary directory inside /tmp only one time.
    The time between entering and exiting the system call was measured.
kill
    A signal handler for SIGUSR1 was setup. Signal was sent to a child process, which was created using fork glibc's wrapper.
    Time between sending and receiving SIGUSR1 signal was measured.

Testing environment:
    Processor Intel(R) Xeon(R) CPU E5-2690
    2 nodes with 12 CPU cores for each one.

Best Regards,
Artem

