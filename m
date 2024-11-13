Received: from 189.cn (ptr.189.cn [183.61.185.103])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783F3171D2;
	Wed, 13 Nov 2024 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.61.185.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464778; cv=none; b=UsMNuukZaP5i0Tkr9KGAphvJq6BGLT9wURk4k7k2/p0gjE6FUsE7ejTS5P23NhIRO0IM9m0cFZMte7CdOouDCmpRZ06uO/+sQlR2x85rIdjfg2GfXUmX37T5+d2xnNX7qirI4AbwwSg987Uw40dzBx78D+GFRKEBuAZwR48f380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464778; c=relaxed/simple;
	bh=drOEuEoKWWdBpwkAqGYKGfNbQpjOKskcieottOIMqLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKHCQ1C3jYsQlSiDti4FK/tj+jh5YjK+ygoS5oHp0n26VkNS7s9/6pSFm+YGvqwwABFM58whq6Lkuh/bug8dxAtElVlKEhRwFMGhe2PJR8ZblbrsGnhUl/OD2Y/9up8WvhdjcNG+ZzTC8R4A663dY0WSxh189oAWGL1rkG4NgfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.61.185.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:22611.736088664
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-123.150.8.42 (unknown [10.158.242.145])
	by 189.cn (HERMES) with SMTP id B70831002A1;
	Wed, 13 Nov 2024 10:15:20 +0800 (CST)
Received: from  ([123.150.8.42])
	by gateway-153622-dep-5c5f88b874-qw5z2 with ESMTP id df1b45bd4cab4b7283a98e55a5d760b2 for petr.pavlu@suse.com;
	Wed, 13 Nov 2024 10:15:20 CST
X-Transaction-ID: df1b45bd4cab4b7283a98e55a5d760b2
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <524b444f-4b81-4005-b93a-39b7d3fd3db1@189.cn>
Date: Wed, 13 Nov 2024 10:15:19 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kmod: verify module name before invoking modprobe
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: mcgrof@kernel.org, samitolvanen@google.com, da.gomez@samsung.com,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20241110114233.97169-1-chensong_2000@189.cn>
 <21423aea-65c3-430e-932d-2ba70b6b9ac3@suse.com>
Content-Language: en-US
From: Song Chen <chensong_2000@189.cn>
In-Reply-To: <21423aea-65c3-430e-932d-2ba70b6b9ac3@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Petr,

Please see my inline comments, many thanks.

BR

Song

在 2024/11/12 20:56, Petr Pavlu 写道:
> On 11/10/24 12:42, Song Chen wrote:
>> Sometimes when kernel calls request_module to load a module
>> into kernel space, it doesn't pass the module name appropriately,
>> and request_module doesn't verify it as well.
>>
>> As a result, modprobe is invoked anyway and spend a lot of time
>> searching a nonsense name.
>>
>> For example reported from a customer, he runs a user space process
>> to call ioctl(fd, SIOCGIFINDEX, &ifr), the callstack in kernel is
>> like that:
>> dev_ioctl(net/core/dev_iovtl.c)
>>    dev_load
>>       request_module("netdev-%s", name);
>>       or request_module("%s", name);
>>
>> However if name of NIC is empty, neither dev_load nor request_module
>> checks it at the first place, modprobe will search module "netdev-"
>> in its default path, env path and path configured in etc for nothing,
>> increase a lot system overhead.
>>
>> To address this problem, this patch copies va_list and introduces
>> a helper is_module_name_valid to verify the parameters validity
>> one by one, either null or empty. if it fails, no modprobe invoked.
> 
> I'm not sure if I fully follow why this should be addressed at the
> request_module() level. If the user repeatedly invokes SIOCGIFINDEX with
> an empty name and this increases their system load, wouldn't it be
> better to update the userspace to prevent this non-sense request in the
> first place? 

If the user process knew, it wouldn't make the mistake. moreover, what 
happened in dev_load was quite confusing, please see the code below:

     no_module = !dev;
     if (no_module && capable(CAP_NET_ADMIN))
         no_module = request_module("netdev-%s", name);
     if (no_module && capable(CAP_SYS_MODULE))
         request_module("%s", name);

Running the same process, sys admin or root user spends more time than 
normal user, it took a while for us to find the cause, that's why i 
tried to fix it in kernel.

Similarly, if something should be done in the kernel,
> wouldn't it be more straightforward for dev_ioctl()/dev_load() to check
> this case?

I thought about it at the beginning, not only dev_ioctl/dev_load but 
also other request_module callers should check this case as well, that 
would be too much effort, then I switched to check it at the beginning 
of request_module which every caller goes through.

> 
> I think the same should in principle apply to other places that might
> invoke request_module() with "%s" and a bogus value. The callers can
> appropriately decide if their request makes sense and should be
> fixed/improved.
> 

Callees are obliged to do fault tolerance for callers, or at least let 
them know what is going on inside, what kinds of mistake they are 
making, there are a lot of such cases in kernel, such as call_modprobe 
in kernel/module/kmod.c, it checks if orig_module_name is NULL.

Song

