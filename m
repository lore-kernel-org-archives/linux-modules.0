Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FEB3A8C6
	for <linux-modules@vger.kernel.org>; Tue,  9 Jan 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8cVC4VjDz688p7;
	Wed, 10 Jan 2024 00:54:43 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 4530E140595;
	Wed, 10 Jan 2024 00:57:18 +0800 (CST)
Received: from [10.123.123.147] (10.123.123.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 16:57:16 +0000
Message-ID: <c5c8d372-ee12-4ccc-8080-a2c33301b812@huawei.com>
Date: Tue, 9 Jan 2024 19:57:14 +0300
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Artem Kuzin <artem.kuzin@huawei.com>
Subject: Re: [PATCH RFC 02/12] mm: add config option and per-NUMA node VMS
 support
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
CC: <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <akpm@linux-foundation.org>,
	<urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<mcgrof@kernel.org>, <rmk+kernel@armlinux.org.uk>,
	<nikita.panov@huawei-partners.com>, <alexander.grubnikov@huawei.com>,
	<stepanov.anatoly@huawei.com>, <guohanjun@huawei.com>,
	<weiyongjun1@huawei.com>, <wangkefeng.wang@huawei.com>,
	<judy.chenhui@huawei.com>, <yusongping@huawei.com>, <kang.sun@huawei.com>,
	<linux-mm@kvack.org>, <linux-modules@vger.kernel.org>
References: <20231228131056.602411-1-artem.kuzin@huawei.com>
 <20231228131056.602411-3-artem.kuzin@huawei.com>
 <059dc132-af10-fd08-7368-302c765a4269@gentwo.org>
Content-Language: en-US
In-Reply-To: <059dc132-af10-fd08-7368-302c765a4269@gentwo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml100004.china.huawei.com (7.188.51.133) To
 lhrpeml500001.china.huawei.com (7.191.163.213)

On 1/3/2024 10:43 PM, Christoph Lameter (Ampere) wrote:
> On Thu, 28 Dec 2023, artem.kuzin@huawei.com wrote:
>
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -626,7 +628,14 @@ struct mm_struct {
>>         unsigned long mmap_compat_legacy_base;
>> #endif
>>         unsigned long task_size;    /* size of task vm space */
>> -        pgd_t * pgd;
>> +#ifndef CONFIG_KERNEL_REPLICATION
>> +        pgd_t *pgd;
>> +#else
>> +        union {
>> +            pgd_t *pgd;
>> +            pgd_t *pgd_numa[MAX_NUMNODES];
>> +        };
>> +#endif
>
>
> Hmmm... This is adding the pgd pointers for all mm_structs. But we only need the numa pgs pointers for the init_mm. Can this be a separate variable? There are some architecures with larger number of nodes.
>
>
>

Hi, Christoph.

Sorry for such delay with the reply.

We already have per-NUMA node init_mm, but this is not enough.
We need this array of pointers in the task struct due to the proper pgd (per-NUMA node) should be used for threads of process that occupy more than one NUMA node.
On x86 we have one translation table per-process that contains both kernel and user space part. In case of kernel text and rodata replication enabled, we need to take
into account per-NUMA node kernel text and rodata replicas during the context switch and etc. For example, if particular thread runs a system call, we need to use the
kernel replica that corresponds to the NUMA node the thread running on. At the same time, the process can occupy several NUMA nodes, and the threads running on different
NUMA nodes should observe one user space version, but different kernel versions (per-NUMA node replicas).

But you are right that this place should be optimized. We no need this array for the processes that not expected to work in cross-NUMA node way. Possibly, we
need to implement some "lazy" approach for per-NUMA node translation tables allocation. Current version of kernel replication support is implemented in a way
when we try to do all the things as simple as possible.

Thank you!

Best regards,
Artem

