Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE014C605
	for <linux-modules@vger.kernel.org>; Mon, 29 Jan 2024 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706510339; cv=none; b=T8OTkbllJf+PAtMVI6SCOnwod1fL3pBG7I6lB9TQMkXHTJboKz9kGtCCxSo6qLUAYXgs5Q2BUs2/P8EVHToHmWIK5HJ7ZXtz+8AeNXj18bfMGIEEWNfUir/QYHuSHVDbFgXiYtuLsVXMYcYufApR/UnmfGCXnZS3wxiYHDor9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706510339; c=relaxed/simple;
	bh=YW2GSfqLb1anPfEjgk1lbUZdv+JlYoKcIHyUfuNsBxk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ugfCW2phSCrLR6fVr2L8uR7as4KTUcVh7g1ZEMJAFOboLOXkwymXaN6JWm9zatE0ig77o7nEp3PpU6dbGGh34cDktJDG8oY/NalcoRpQvlTUhpISnwW3ICcy6sQ7GQfCOcZ1D3DsumZ5QjDcNsV9g9nI1EMoL73BK0DvJ+1Kpn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TNdT34nFHz67pY8;
	Mon, 29 Jan 2024 14:20:23 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DDF7140B55;
	Mon, 29 Jan 2024 14:23:12 +0800 (CST)
Received: from [10.123.123.147] (10.123.123.147) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 06:23:10 +0000
Message-ID: <5a7485f8-a070-465d-9e17-e7cd3d2aaa80@huawei.com>
Date: Mon, 29 Jan 2024 09:22:59 +0300
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
To: Dave Hansen <dave.hansen@intel.com>, "Christoph Lameter (Ampere)"
	<cl@gentwo.org>
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
 <c5c8d372-ee12-4ccc-8080-a2c33301b812@huawei.com>
 <6c5c72ab-01b1-45b4-9a33-529688e449eb@intel.com>
Content-Language: en-US
In-Reply-To: <6c5c72ab-01b1-45b4-9a33-529688e449eb@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100004.china.huawei.com (7.188.51.133) To
 lhrpeml500001.china.huawei.com (7.191.163.213)


On 1/25/2024 6:07 PM, Dave Hansen wrote:
> On 1/9/24 08:57, Artem Kuzin wrote:
>> We already have per-NUMA node init_mm, but this is not enough.
>> We need this array of pointers in the task struct due to the proper pgd 
>> (per-NUMA node) should be used for threads of process that occupy more 
>> than one NUMA node.
> Let me repeat what Christoph said in a bit more forceful way.
>
> MAX_NUMNODES can be 1024.  You're adding 1023*8 bytes of overhead for
> each process ... everywhere, including on my single node laptop.  That's
> completely unacceptable.  You need to find another way to do this.
>
> I'd suggest just ignoring the problem for now.  Do multi-node processes
> with a later optimization.

Hi Dave, thanks to you and Christoph for the comments. I've just gave some details why this is necessary, and didn't want to push the solution with MAX_NUMNODES forward, this is temporarily
thing and this place should be definitely updated in future.

As for possible options, for now I am thinking about two:
1. additional config option to limit the number of page tables and corresponding replicas
2. setup per-NUMA node page tables and replicas in a lazy way allocating them on demand

But here I need to try and test everything.

Thanks!

