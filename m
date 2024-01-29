Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F604F1EB
	for <linux-modules@vger.kernel.org>; Mon, 29 Jan 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514687; cv=none; b=iByO+MeL0+pV7/+7q2OK+gahIajLjxIUGKxYbf7gFHEz2h2Z3GU1rHHNK0D3SMSRofpbx4D8ukmyprI1Txv3puD/6D8IE8hDTf7GTxyIyq2OFLOdf17OcWsJYxpIHzkTbNQ7H3MyNE1sQtgtEE7f/GpcJVIypMtxDRr90W7cUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514687; c=relaxed/simple;
	bh=rJfdbwdbUr6K/4Xuo8aMXAOnbMltOv91zYfRKCrR4xc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=M/nPsMIdvv0zv3lTjBPfHj3EZM520KRJpSQ92lg6QUMkjkkd5w7HF+JaD7ZT75jfbfyeeIklqiH3lZS4j1eZnFoD3yMOGbVnuFpKq8pY4wip97+qkoT9uL2gPU9oMolp6urgROHDU24IsrlpkbBc7C3wLYviLg+Ds+NKY58SZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TNgQm02W0z6K5xG;
	Mon, 29 Jan 2024 15:48:32 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 26025140CB9;
	Mon, 29 Jan 2024 15:51:21 +0800 (CST)
Received: from [10.123.123.147] (10.123.123.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 07:51:19 +0000
Message-ID: <dd3526e7-aa4a-436a-8563-0aed6d149d6b@huawei.com>
Date: Mon, 29 Jan 2024 10:51:17 +0300
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Artem Kuzin <artem.kuzin@huawei.com>
Subject: Re: [PATCH RFC 00/12] x86 NUMA-aware kernel replication
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
 <9cbb1c1e-9dd6-478b-b75d-e6c9f3d6c8f7@amd.com>
Content-Language: en-US
In-Reply-To: <9cbb1c1e-9dd6-478b-b75d-e6c9f3d6c8f7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 lhrpeml500001.china.huawei.com (7.191.163.213)


On 1/25/2024 7:30 AM, Garg, Shivank wrote:
> Hi Artem,
>
>> Preliminary performance evaluation results:
>> Processor Intel(R) Xeon(R) CPU E5-2690
>> 2 nodes with 12 CPU cores for each one
>>
>> fork/1 - Time measurements include only one time of invoking this system call.
>>          Measurements are made between entering and exiting the system call.
>>
>> fork/1024 - The system call is invoked in  a loop 1024 times.
>>             The time between entering a loop and exiting it was measured.
>>
>> mmap/munmap - A set of 1024 pages (if PAGE_SIZE is not defined it is equal to 4096)
>>               was mapped using mmap syscall and unmapped using munmap one.
>>               Every page is mapped/unmapped per a loop iteration.
>>
>> mmap/lock - The same as above, but in this case flag MAP_LOCKED was added.
>>
>> open/close - The /dev/null pseudo-file was opened and closed in a loop 1024 times.
>>              It was opened and closed once per iteration.
>>
>> mount - The pseudo-filesystem procFS was mounted to a temporary directory inside /tmp only one time.
>>         The time between entering and exiting the system call was measured.
>>
>> kill - A signal handler for SIGUSR1 was setup. Signal was sent to a child process,
>>        which was created using fork glibc's wrapper. Time between sending and receiving
>>        SIGUSR1 signal was measured.
>>
>> Hot caches:
>>
>> fork-1          2.3%
>> fork-1024       10.8%
>> mmap/munmap     0.4%
>> mmap/lock       4.2%
>> open/close      3.2%
>> kill            4%
>> mount           8.7%
>>
>> Cold caches:
>>
>> fork-1          42.7%
>> fork-1024       17.1%
>> mmap/munmap     0.4%
>> mmap/lock       1.5%
>> open/close      0.4%
>> kill            26.1%
>> mount           4.1%
>>
> I've conducted some testing on AMD EPYC 7713 64-Core processor (dual socket, 2 NUMA nodes, 64 CPUs on each node) to evaluate the performance with this patchset.
> I've implemented the syscall based testcases as suggested in your previous mail. I'm shielding the 2nd NUMA node using isolcpus and nohz_full, and executing the tests on cpus belonging to this node.
>
> Performance Evaluation results (% gain over base kernel 6.5.0-rc5):
>
> Hot caches:
> fork-1		1.1%
> fork-1024	-3.8%
> mmap/munmap	-1.5%
> mmap/lock	-4.7%
> open/close	-6.8%
> kill		3.3%
> mount		-13.0%
>
> Cold caches:
> fork-1		1.2%
> fork-1024 	-7.2%
> mmap/munmap 	-1.6%
> mmap/lock 	-1.0%
> open/close 	4.6%
> kill 		-54.2%
> mount 		-8.5%
>
> Thanks,
> Shivank
>
Hi Shivank, thank you for performance evaluation, unfortunately we don't have AMD EPYC right now,
I'll try to find a way to perform measurements and clarify why such difference.

We currently trying to make performance evaluation using database related benchmarks.
Will return with the results after clarification.

BR

