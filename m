Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907C200132
	for <linux-modules@vger.kernel.org>; Wed, 27 Nov 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725371; cv=none; b=Y7ZCQg8yhFZ7CUgFPVyj9DPEQCW0IJJ2UwSaOWp9q1wuAcpJGVaHQFAGsqjtOxbWBf4e1BJles5NI2PL7A+iT32YKMOyJQxCW9jhfcjfBRcFAz0Xm1OhzcmnK6IZbp0SNGU3o/wSAHe8HygEvG6+d+C+nCVTpDjhzdmHkieQh2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725371; c=relaxed/simple;
	bh=LFHxdVBYoYAZY0hiY+E3Y2YFGe1NNWQZcPV+JukXgfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Usg3aeIKcdWDU4wwOOfbF6s5pe0asoUGkhp6WcorBfyckeW80Z6RzgKpxe3ySoDtPGwf+WzZDoUm5NZNEmPSZXTXiFF5JVA8G36ybDitnog9sRhM8fzjv3UphGO5ICiWsKyeESMMuN8dVfGd73V284C9P2SgjDP6xgl6qhzddO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fdKdH47a; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fdKdH47a"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-432d86a3085so63600805e9.2
        for <linux-modules@vger.kernel.org>; Wed, 27 Nov 2024 08:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732725367; x=1733330167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7o68Jt3JQlv3ZsSTZZHiyaGjZ/zi4RrNjh1cOfyHrk=;
        b=fdKdH47arqcmaEdJYTYYW0Nkwk1t+407ZHNs40FacHqfbLKrYea3/JfqEXjHknJSsL
         QHOEBWYxGTHYmuMTn0fbePjmHvCHUbCVU/DLYUrE2qWCI7rl3CcWzOUkZaEbm9oBlK+O
         6RWFZy+9ui6oo0cXE6OJx7Y0opciqn6ZF+zdk4rB5j/F7MoM3njaCuR2+DGNd6RXGREz
         fpDoJ/4KUx9K6Ck+LNvWWX+oQxhw2anjM/lRyYO4iN8fgt8MZm1+OahHr9fg4v/NrEcD
         DjZa5sFcozmC/pPDoDtDq3lY6ma1pzscfqf3b89B7mWI6IjZImkD0TDE3dOnJKoQHuvH
         9PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732725367; x=1733330167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7o68Jt3JQlv3ZsSTZZHiyaGjZ/zi4RrNjh1cOfyHrk=;
        b=tzxmQZJKDN6X+c1bh42qb0Hh+waS62Jwaq31KUT+gp0g6vH9CcCdMNRpCG5IwTkG1q
         STZe9je9Dbnd5329Wo3iq+CqVLqwqUo5wD/9eUjMEr97hMNltRuJ83P3JkvU7WmaWrR9
         eLTzlRoBB90zN09sr59xoyqB09MjEo88lnmFxBPujbYXMqUjS3Rgtv+oLJIoIGwxdB8s
         pZf7k+rMlwVjcAuQCl1Qj1GIylFRbP3ovc+dniQmHhT0kaMe4P513IDLPLKx0Z33sWjW
         4Rlu8p+Hbti2zRoZ2dPV8cVb3kvaf65pSQT6VR74sy3Ad30SVE4mLQ8525eOh8t5SMPK
         nvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxVgUNoEACwJw8Rb09TGGp4UGoyNRx5WqWcKx6qxBJpVMGY1SRlMtlC/uHjW1IYYHuFvzZwS13Z8NBroTt@vger.kernel.org
X-Gm-Message-State: AOJu0YzZv2GuYc9a6bah0U2QYfrmgVCEJTjdPrfNXL+wzPCjV5XPYO0q
	AeWAxF4Y0S32of2Fj6X6zWBSxOaC0TbswJRmljY05K1xW1cSt/j8iFB6h0ESnd8=
X-Gm-Gg: ASbGncuKTk3xR3CZpsqW58qL5z+OKVsFsx2VRd0w5qCnxKpgCC3YlXVYpTKrLoplDpr
	+bum3vkRjmF84rA0JWzB0ntjb+UjG2aD1/tNxzKKH1Ykj6WxWQAQwKtnyl7HemGm81VerfpuLz7
	DrKqGvnpho08aoo+guknBJ+vbJrBkV1+v0ok8B0MahMK9pY4bu1ihEIawjUEIheToAVfF81jUcv
	W+mT+ErgVyQYya/gh2DrtyC3NNLYezQeUsqOmZ8nEUF9XvUtHK5dg==
X-Google-Smtp-Source: AGHT+IEWnqn0V5IXY2KkfrK9yKYz57HCzRYVhbvaz++snN7BEPqLaXC4wz5nGYvpZuhZRWsRZuDGCA==
X-Received: by 2002:a05:600c:4f49:b0:431:52a3:d9d9 with SMTP id 5b1f17b1804b1-434a9d4fa7dmr37689545e9.0.1732725367221;
        Wed, 27 Nov 2024 08:36:07 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc42b3sm16836954f8f.68.2024.11.27.08.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 08:36:06 -0800 (PST)
Message-ID: <09567939-f5fb-4281-a912-7f8a6a07c3e5@suse.com>
Date: Wed, 27 Nov 2024 17:36:06 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kmod: verify module name before invoking modprobe
To: Song Chen <chensong_2000@189.cn>
Cc: mcgrof@kernel.org, samitolvanen@google.com, da.gomez@samsung.com,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20241110114233.97169-1-chensong_2000@189.cn>
 <21423aea-65c3-430e-932d-2ba70b6b9ac3@suse.com>
 <524b444f-4b81-4005-b93a-39b7d3fd3db1@189.cn>
 <8ea8dfed-608f-44b9-8adb-fb1798619215@suse.com>
 <d3cad11c-a65d-4faf-a636-3d85474d7175@189.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <d3cad11c-a65d-4faf-a636-3d85474d7175@189.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/20/24 03:17, Song Chen wrote:
> Hi Petr,
> 
> 在 2024/11/18 20:54, Petr Pavlu 写道:
>> On 11/13/24 03:15, Song Chen wrote:
>>> 在 2024/11/12 20:56, Petr Pavlu 写道:
>>>> On 11/10/24 12:42, Song Chen wrote:
>>>>> Sometimes when kernel calls request_module to load a module
>>>>> into kernel space, it doesn't pass the module name appropriately,
>>>>> and request_module doesn't verify it as well.
>>>>>
>>>>> As a result, modprobe is invoked anyway and spend a lot of time
>>>>> searching a nonsense name.
>>>>>
>>>>> For example reported from a customer, he runs a user space process
>>>>> to call ioctl(fd, SIOCGIFINDEX, &ifr), the callstack in kernel is
>>>>> like that:
>>>>> dev_ioctl(net/core/dev_iovtl.c)
>>>>>     dev_load
>>>>>        request_module("netdev-%s", name);
>>>>>        or request_module("%s", name);
>>>>>
>>>>> However if name of NIC is empty, neither dev_load nor request_module
>>>>> checks it at the first place, modprobe will search module "netdev-"
>>>>> in its default path, env path and path configured in etc for nothing,
>>>>> increase a lot system overhead.
>>>>>
>>>>> To address this problem, this patch copies va_list and introduces
>>>>> a helper is_module_name_valid to verify the parameters validity
>>>>> one by one, either null or empty. if it fails, no modprobe invoked.
>>>>
>>>> I'm not sure if I fully follow why this should be addressed at the
>>>> request_module() level. If the user repeatedly invokes SIOCGIFINDEX with
>>>> an empty name and this increases their system load, wouldn't it be
>>>> better to update the userspace to prevent this non-sense request in the
>>>> first place?
>>>
>>> If the user process knew, it wouldn't make the mistake.
>>
>> The user process should be able to check that the ifr_name passed to
>> SIOCGIFINDEX is empty and avoid the syscall altogether, or am I missing
>> something? Even if the kernel gets improved in some way to handle this
>> case better, I would still suggest looking at what the application is
>> doing and how it ends up making this call.
>>
> 
> yes, agree, it's the user space process's fault after all.
> 
>>> moreover, what
>>> happened in dev_load was quite confusing, please see the code below:
>>>
>>>       no_module = !dev;
>>>       if (no_module && capable(CAP_NET_ADMIN))
>>>           no_module = request_module("netdev-%s", name);
>>>       if (no_module && capable(CAP_SYS_MODULE))
>>>           request_module("%s", name);
>>>
>>> Running the same process, sys admin or root user spends more time than
>>> normal user, it took a while for us to find the cause, that's why i
>>> tried to fix it in kernel.
>>>
>>> Similarly, if something should be done in the kernel,
>>>> wouldn't it be more straightforward for dev_ioctl()/dev_load() to check
>>>> this case?
>>>
>>> I thought about it at the beginning, not only dev_ioctl/dev_load but
>>> also other request_module callers should check this case as well, that
>>> would be too much effort, then I switched to check it at the beginning
>>> of request_module which every caller goes through.
>>>
>>>>
>>>> I think the same should in principle apply to other places that might
>>>> invoke request_module() with "%s" and a bogus value. The callers can
>>>> appropriately decide if their request makes sense and should be
>>>> fixed/improved.
>>>>
>>>
>>> Callees are obliged to do fault tolerance for callers, or at least let
>>> them know what is going on inside, what kinds of mistake they are
>>> making, there are a lot of such cases in kernel, such as call_modprobe
>>> in kernel/module/kmod.c, it checks if orig_module_name is NULL.
>>
>> Ok, I see the idea behind checking that a value passed to
>> request_module() to format "%s" is non-NULL.
>>
>> I'm however not sure about rejecting empty strings as is also done by
>> the patch. Consider a call to request_module("mod%s", suffix) where the
>> suffix could be empty to select the default variant, or non-empty to
>> select e.g. some optimized version of the module. Only the caller knows
>> if the suffix being empty is valid or not.
>>
>> I've checked if this pattern is currently used in the kernel and wasn't
>> able to find anything, so that is good. However, I'm not sure if
>> request_module() should flat-out reject this use.
>>
> 
> I accidentally found another problem in request_module when i was 
> testing this patch again, if the caller just passes a empty pointer to 
> request_module, like request_module(NULL), the process will be broken:
> 
> [    2.336160]  ? asm_exc_page_fault+0x2b/0x30
> [    2.336160]  ? __pfx_crc64_rocksoft_notify+0x10/0x10
> [    2.336160]  ? vsnprintf+0x5a/0x4f0
> [    2.336160]  __request_module+0x93/0x2b0
> [    2.336160]  ? __pfx_crc64_rocksoft_notify+0x10/0x10
> [    2.336160]  ? notifier_call_chain+0x65/0xd0
> [    2.336160]  ? __pfx_crc64_rocksoft_notify+0x10/0x10
> [    2.336160]  crypto_probing_notify+0x43/0x60
> 
> (please ignore the caller, that is a testing code.)
> 
> I searched kernel code if this patter exists, and found in 
> __trace_bprintk of kernel/trace/trace_printk.c, it checks fmt at the 
> beginning of the function:
> 
>       va_list ap;
> 
>       if (unlikely(!fmt))
>           return 0;
> 
> Therefore, i would like to suggest we should at least add this check in 
> request_module too. In that sense, why don't we do a little further to 
> verify every parameter's validity to provide better fault tolerance, 
> besides, it costs almost nothing.
> 
> If you like this idea, i will send a v2.

I don't have much of a preference. It can be added, but on the other
hand I think it isn't really necessary. Most functions with format
arguments in the kernel don't perform this type of checking as far as
I can see.

-- 
Thanks,
Petr
