Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22F5224246
	for <linux-modules@vger.kernel.org>; Thu, 27 Feb 2025 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661717; cv=none; b=EQ9Ej1NzH9F/7bYnr6i6LlkBLzxkp/qul8cy1Y13dg4ehNfQvBexU+69DWpr+DlKmMWLEhKVMsLUAEp65Y06sBaBgr9L/5kUjEead4uUGoxcIOEgppXL+eeRrlVEGX+UqK6Oty2Dg7SvceUvVnfavWunZBnZRXQv6vz5v+RH1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661717; c=relaxed/simple;
	bh=XVHlC8x3itEURXt5LJzCblyJmCQ+leneZrT/azQ6zrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgWp6kBCe0X6sVe2vT46bP4xPqNd8tSR0g62dIJBGplTl4zHHApPvOifGD+6WrvhFCJdYoQDZR0kUPirblrKBKJX14iiTPF2vQjLOU77k+577Wkylz/uWyd099ZWPgdEBTfK051+rSkk8zR3czgvd/i00fr7pK2mSOAXECkzrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MW+rBpWZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MW+rBpWZ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb7520028bso114570766b.3
        for <linux-modules@vger.kernel.org>; Thu, 27 Feb 2025 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740661714; x=1741266514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltZavpJgM+BS7J/L1W7hHYg1KSQyKOJV5k3lMLLU0v4=;
        b=MW+rBpWZDfCxhYTIacYGP6b3EGrN54C7uHNaQrRrhmcmHNqit5noXDQZ3dM7NU8+T/
         FITRdP4TkN9oEo0l1XUSwFFth1RR3QqUZlIlPDXZt92re2Jm4VBG7cl3P2AofN45hgU9
         VGrWVpZfRI7zMlFgzFrqerK4pweLmUtqAXmGEHoVg2S2Gk3C+GUb7WASyO5rY3aM7e/8
         cJt9wze2KmVMqJ39QBLUeiUyUv2jRJCP/f47ygMzy3taVymWdG5KLshr9N5JSwCbtQnw
         JdOESi+zJzFyjtNhBJldMBLfU+dTAUc+Je5vkg0+djC8dCEDN0ILrH9YFt22CTgwG40A
         FFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740661714; x=1741266514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltZavpJgM+BS7J/L1W7hHYg1KSQyKOJV5k3lMLLU0v4=;
        b=hVzPSUL8r9J+34UOjHKEawiudljZtR2CfGQPyFYpCi4jyto7h0bTYC9YV3kPEOMPcu
         4yPrf4GOVGKIhbnExfKzPFkeXDLU3dPoClslVkszmmyjMDXRWH21fsxDu052cBB7JVCZ
         rTV8vk/qjM232LXX0bAB1janW3TixzseBuxdTizEBrnrLG8KBSg1GQz2JfEDUqDEYHmj
         +FeGrlNBk+9UDLnjfn4+FGuOOszniChjV5C/9e4Yzqdi8B1IK0fBjOFBkj1MlgfieAnW
         27CD4kzrFlDt+vbEhNS12cLw4Bbkhr8xA0byIHat3LZUz/cBY+pfTBQSu985D8Fj5+Lr
         zGnA==
X-Forwarded-Encrypted: i=1; AJvYcCUYPqaMJgaK3GmhHWq0cduwLHRtABfjpLO9PrM3uMPKzBqkRbWKU605JCqo6WeqOyHV0jrtfUhVBXUbN7wj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95Wyl7K3u3U3xVGyVcyvVKIi1V389drLzTxEO1rm7qEfEtyLw
	3Wk8w9eCh3JPZOMF0OmxLXKXRdvmVU0q5LhlRgfLOLAGOn9jp3fzsxQHUYimbZg=
X-Gm-Gg: ASbGncueLTMUgDWpCrRq0JkJGiVugkTxJJid4H4MM723GbVNoQOYmBWda7CkfiZb8QL
	gcyYvkm3iAwbdH+w195SfEsLud203G/LyI4eXYtJCJlwE7Kky16ry5qwe07p9kj83o02uARTe05
	9QF3yLGMzihU95OXjtyoyxCGd+Tshth0C2JYGvKOZx8zM9beqFI1mk4FODknYR3MvzQPJ3WCjXv
	YVz1EruolpCAbuvLbm5/IOx9TPZi+HamZ+s8d2/fuXTLC5FRXesAcGBQes8bCTr4ma81ytDU3FU
	5RbbReOcwezmKrtXSNI3qWNeAhA6UA==
X-Google-Smtp-Source: AGHT+IF8xXvncbhY1CLeRlJWNXq/FAdjs4IJuCR6PP00b7u2RBTgTCDqFTFJhcfvFK58DwA1Shkcpg==
X-Received: by 2002:a17:906:3105:b0:ab7:f2da:8122 with SMTP id a640c23a62f3a-abeeecfd662mr823323066b.3.1740661713789;
        Thu, 27 Feb 2025 05:08:33 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6f5363sm118658866b.123.2025.02.27.05.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 05:08:33 -0800 (PST)
Message-ID: <957f038b-4d68-468c-9e14-9c38f1ed6a2f@suse.com>
Date: Thu, 27 Feb 2025 14:08:31 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] kernel: refactor lookup_or_create_module_kobject()
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 code@tyhicks.com, christophe.leroy@csgroup.eu, hch@infradead.org,
 mcgrof@kernel.org, frkaya@linux.microsoft.com, vijayb@linux.microsoft.com,
 linux@weissschuh.net, samitolvanen@google.com, da.gomez@samsung.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
 <20250211214842.1806521-3-shyamsaini@linux.microsoft.com>
 <4039ec74-8b46-417e-ad71-eff22239b90f@suse.com> <87wmdjo9yp.fsf@prevas.dk>
 <e8ba9f36-e33d-4c53-9d34-ff611cb1c221@suse.com>
 <20250225172445.GA28595@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250225172445.GA28595@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 18:24, Shyam Saini wrote:
> On Tue, Feb 25, 2025 at 09:33:10AM +0100, Petr Pavlu wrote:
>> On 2/21/25 11:42, Rasmus Villemoes wrote:
>>> On Thu, Feb 13 2025, Petr Pavlu <petr.pavlu@suse.com> wrote:
>>>
>>>> On 2/11/25 22:48, Shyam Saini wrote:
>>>>> In the unlikely event of the allocation failing, it is better to let
>>>>> the machine boot with a not fully populated sysfs than to kill it with
>>>>> this BUG_ON(). All callers are already prepared for
>>>>> lookup_or_create_module_kobject() returning NULL.
>>>>>
>>>>> This is also preparation for calling this function from non __init
>>>>> code, where using BUG_ON for allocation failure handling is not
>>>>> acceptable.
>>>>
>>>> I think some error reporting should be cleaned up here.
>>>>
>>>> The current situation is that locate_module_kobject() can fail in
>>>> several cases and all these situations are loudly reported by the
>>>> function, either by BUG_ON() or pr_crit(). Consistently with that, both
>>>> its current callers version_sysfs_builtin() and kernel_add_sysfs_param()
>>>> don't do any reporting if locate_module_kobject() fails; they simply
>>>> return.
>>>>
>>>> The series seems to introduce two somewhat suboptimal cases.
>>>>
>>>> With this patch, when either version_sysfs_builtin() or
>>>> kernel_add_sysfs_param() calls lookup_or_create_module_kobject() and it
>>>> fails because of a potential kzalloc() error, the problem is silently
>>>> ignored.
>>>>
>>>
>>> No, because (IIUC) when a basic allocation via kzalloc fails, the kernel
>>> complains loudly already; there's no reason for every caller of
>>> kmalloc() and friends to add their own pr_err("kmalloc failed"), that
>>> just bloats the kernel .text.
>>
>> I wasn't suggesting to log a kmalloc() error specifically. The idea was
>> that if lookup_or_create_module_kobject() fails for whatever reason,
>> kernel_add_sysfs_param() and version_sysfs_builtin() should log the
>> failure to create/get the kobject.
>>
>>>
>>>> Similarly, in the patch #4, when module_add_driver() calls
>>>> lookup_or_create_module_kobject() and the function fails, the problem
>>>> may or may not be reported, depending on the error.
>>>>
>>>> I'd suggest something as follows:
>>>> * Drop the pr_crit() reporting in lookup_or_create_module_kobject().
>>>
>>> No, because that reports on something other than an allocation failing
>>> (of course, it could be that the reason kobject_init_and_add or
>>> sysfs_create_file failed was an allocation failure, but it could
>>> also be something else), so reporting there is the right thing to do.
>>
>> The error message says:
>> pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n", name, err);
>>
>> I think it was appropriate for locate_module_kobject() to do this error
>> reporting when the function was only called by code in kernel/params.c
>> and in the boot context. Now that the patch makes the function available
>> to external callers, I'm not sure if it should remain reporting this
>> error.
>>
>> The function itself shouldn't directly make the system unstable when it
>> fails. Each caller can appropriately determine how to handle the error.
>> Functions kernel_add_sysfs_param() and version_sysfs_builtin() don't
>> have much of an option and can only log it, but module_add_driver()
>> could roll back its operation.
>>
> 
> before this patch series [1] kset_find_obj() was called in module_add_driver()
> and the function immediately returned when no valid module_kobject was found,
> 
> module_add_driver returns immediately if some error is encountered or module_kobject
> is not found in lookup_or_create_module_kobject()
> Since module_kobject() is anyway no-op if it [2] returns early so it shouldn't require
> any rollback, right?
> 
> Assuming rollback is not required for module_add_driver() in lookup_or_create_module_kobject()
> failure scenario, what should be the appropriate messaging from pr_crit() if it
> fails in module_add_driver()?
> 
> [1] https://elixir.bootlin.com/linux/v6.14-rc4/source/drivers/base/module.c#L48
> [2] https://elixir.bootlin.com/linux/v6.14-rc4/source/drivers/base/module.c#L58

Sorry, I partly misunderstood the different context in which
module_add_driver() is called. I still think my suggestion makes some
sense, but looking again, the current version seems ok to me too.

-- 
Thanks,
Petr
