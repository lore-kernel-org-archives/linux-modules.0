Received: from 189.cn (ptr.189.cn [183.61.185.104])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B5F191;
	Wed, 20 Nov 2024 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.61.185.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732069044; cv=none; b=oEIo7rvS00SEOBTP3k/xTl0CaRcE4C+aaiItjrghwEa8LUp8EsntOqn7v+k0PX4sQmQV7ZfP1k8/N5otZUSS8N7KV9iZsPgoa0Ea1Vy/K9t7AbX+COTaIkZjoKgFPiZoHIfzclgYUpv6wJyAvUfhPoX8SIY6l2+HwnNpUVnWoJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732069044; c=relaxed/simple;
	bh=hVGhOStGSaQAnY+/wqyIUlVbKeyMJCsCDkyvLBNzN9o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vu1GSGSqYTxgSYbupLbevl3VX4LxrQBSVEcMUseX/PgobaWDPN6Dskm6QeWi/13rvn9sfeq63OfnCK6Wy8+W7YwFKtgD7O+qrCcjLt+ZwNu1XuMd++7k3oQ6MJnqyyvAsxbCQkfLgNdo+FSjEfOdu92EG9aGI2jUofVxNvzctY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.61.185.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.243.18:35581.401365535
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-123.150.8.42 (unknown [10.158.243.18])
	by 189.cn (HERMES) with SMTP id 4B4DA10296C;
	Wed, 20 Nov 2024 10:17:10 +0800 (CST)
Received: from  ([123.150.8.42])
	by gateway-153622-dep-5c5f88b874-pd459 with ESMTP id 08c685f21664449ab4ea252d4fcee535 for petr.pavlu@suse.com;
	Wed, 20 Nov 2024 10:17:11 CST
X-Transaction-ID: 08c685f21664449ab4ea252d4fcee535
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <d3cad11c-a65d-4faf-a636-3d85474d7175@189.cn>
Date: Wed, 20 Nov 2024 10:17:10 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Song Chen <chensong_2000@189.cn>
Subject: Re: [PATCH] kmod: verify module name before invoking modprobe
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: mcgrof@kernel.org, samitolvanen@google.com, da.gomez@samsung.com,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20241110114233.97169-1-chensong_2000@189.cn>
 <21423aea-65c3-430e-932d-2ba70b6b9ac3@suse.com>
 <524b444f-4b81-4005-b93a-39b7d3fd3db1@189.cn>
 <8ea8dfed-608f-44b9-8adb-fb1798619215@suse.com>
Content-Language: en-US
In-Reply-To: <8ea8dfed-608f-44b9-8adb-fb1798619215@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Petr,

在 2024/11/18 20:54, Petr Pavlu 写道:
> On 11/13/24 03:15, Song Chen wrote:
>> 在 2024/11/12 20:56, Petr Pavlu 写道:
>>> On 11/10/24 12:42, Song Chen wrote:
>>>> Sometimes when kernel calls request_module to load a module
>>>> into kernel space, it doesn't pass the module name appropriately,
>>>> and request_module doesn't verify it as well.
>>>>
>>>> As a result, modprobe is invoked anyway and spend a lot of time
>>>> searching a nonsense name.
>>>>
>>>> For example reported from a customer, he runs a user space process
>>>> to call ioctl(fd, SIOCGIFINDEX, &ifr), the callstack in kernel is
>>>> like that:
>>>> dev_ioctl(net/core/dev_iovtl.c)
>>>>     dev_load
>>>>        request_module("netdev-%s", name);
>>>>        or request_module("%s", name);
>>>>
>>>> However if name of NIC is empty, neither dev_load nor request_module
>>>> checks it at the first place, modprobe will search module "netdev-"
>>>> in its default path, env path and path configured in etc for nothing,
>>>> increase a lot system overhead.
>>>>
>>>> To address this problem, this patch copies va_list and introduces
>>>> a helper is_module_name_valid to verify the parameters validity
>>>> one by one, either null or empty. if it fails, no modprobe invoked.
>>>
>>> I'm not sure if I fully follow why this should be addressed at the
>>> request_module() level. If the user repeatedly invokes SIOCGIFINDEX with
>>> an empty name and this increases their system load, wouldn't it be
>>> better to update the userspace to prevent this non-sense request in the
>>> first place?
>>
>> If the user process knew, it wouldn't make the mistake.
> 
> The user process should be able to check that the ifr_name passed to
> SIOCGIFINDEX is empty and avoid the syscall altogether, or am I missing
> something? Even if the kernel gets improved in some way to handle this
> case better, I would still suggest looking at what the application is
> doing and how it ends up making this call.
> 

yes, agree, it's the user space process's fault after all.

>> moreover, what
>> happened in dev_load was quite confusing, please see the code below:
>>
>>       no_module = !dev;
>>       if (no_module && capable(CAP_NET_ADMIN))
>>           no_module = request_module("netdev-%s", name);
>>       if (no_module && capable(CAP_SYS_MODULE))
>>           request_module("%s", name);
>>
>> Running the same process, sys admin or root user spends more time than
>> normal user, it took a while for us to find the cause, that's why i
>> tried to fix it in kernel.
>>
>> Similarly, if something should be done in the kernel,
>>> wouldn't it be more straightforward for dev_ioctl()/dev_load() to check
>>> this case?
>>
>> I thought about it at the beginning, not only dev_ioctl/dev_load but
>> also other request_module callers should check this case as well, that
>> would be too much effort, then I switched to check it at the beginning
>> of request_module which every caller goes through.
>>
>>>
>>> I think the same should in principle apply to other places that might
>>> invoke request_module() with "%s" and a bogus value. The callers can
>>> appropriately decide if their request makes sense and should be
>>> fixed/improved.
>>>
>>
>> Callees are obliged to do fault tolerance for callers, or at least let
>> them know what is going on inside, what kinds of mistake they are
>> making, there are a lot of such cases in kernel, such as call_modprobe
>> in kernel/module/kmod.c, it checks if orig_module_name is NULL.
> 
> Ok, I see the idea behind checking that a value passed to
> request_module() to format "%s" is non-NULL.
> 
> I'm however not sure about rejecting empty strings as is also done by
> the patch. Consider a call to request_module("mod%s", suffix) where the
> suffix could be empty to select the default variant, or non-empty to
> select e.g. some optimized version of the module. Only the caller knows
> if the suffix being empty is valid or not.
> 
> I've checked if this pattern is currently used in the kernel and wasn't
> able to find anything, so that is good. However, I'm not sure if
> request_module() should flat-out reject this use.
> 

I accidentally found another problem in request_module when i was 
testing this patch again, if the caller just passes a empty pointer to 
request_module, like request_module(NULL), the process will be broken:

[    2.336160]  ? asm_exc_page_fault+0x2b/0x30
[    2.336160]  ? __pfx_crc64_rocksoft_notify+0x10/0x10
[    2.336160]  ? vsnprintf+0x5a/0x4f0
[    2.336160]  __request_module+0x93/0x2b0
[    2.336160]  ? __pfx_crc64_rocksoft_notify+0x10/0x10
[    2.336160]  ? notifier_call_chain+0x65/0xd0
[    2.336160]  ? __pfx_crc64_rocksoft_notify+0x10/0x10
[    2.336160]  crypto_probing_notify+0x43/0x60

(please ignore the caller, that is a testing code.)

I searched kernel code if this patter exists, and found in 
__trace_bprintk of kernel/trace/trace_printk.c, it checks fmt at the 
beginning of the function:

      va_list ap;

      if (unlikely(!fmt))
          return 0;

Therefore, i would like to suggest we should at least add this check in 
request_module too. In that sense, why don't we do a little further to 
verify every parameter's validity to provide better fault tolerance, 
besides, it costs almost nothing.

If you like this idea, i will send a v2.

Many thanks.

Song
