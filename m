Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F020B1F7
	for <linux-modules@vger.kernel.org>; Wed,  4 Dec 2024 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325279; cv=none; b=e+qt373dnrWqkD1bHuCL+nIkMe/mDeewXMj8wUiPKDsB69GcwZSohsSjXLicrjcpWE/0iieb5XxDwBe1bWYckrVd0cJQV9HUcl6+6RFTzBHpjxuhgEpClLs/byR1iJMatUa6d8dst9Nr8fIIQ+waSUkcLNKsQMZh1KbjdrbeYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325279; c=relaxed/simple;
	bh=WVIz0Ydw6KGVhv3VYC7noFhWp6UrZxGam8Cb6Nr0Ugo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxWypZXlqZR3NIZbESvI/gWJUEXfCFj1ymsaZh55/qqWyu8dC/GmitOam4Ez9rfSY1kTOcM7++0SBoUO1ZkzKhzuN2j7VR8kLroVTpikM/2KTRDob26vIgqkwJ7bEv8BID9xiG82DPbYSKdQCRt/qevSJjdaJ2m6OGKwgM3thOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BpN8Yv5z; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BpN8Yv5z"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e2c52c21so3084619f8f.2
        for <linux-modules@vger.kernel.org>; Wed, 04 Dec 2024 07:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733325275; x=1733930075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrIsxVZo/gcZzbzQFSC8PQLeQjSHRaF+v4+eff7qHIg=;
        b=BpN8Yv5zRP2zmdEaU0q6tLt296Wme3GiTLedUD1C8D4v3d3JutNMZcqB6/dz+RPGkd
         fcbYhGwiWQMMZuifwwB70N7oLEXoj64clu+P6hA+dEg3xe+7iZvSXTeaqhBXT6efGSZ1
         8bIVM4zBCwQaLWR7nRT/Mhn72A6XyWuaIbopQnFYou38QBxxdyaaMci2djc/FOU9f0Rm
         JVAuTyLJXk36i+9oUai5LJnsE4Ccur4jI48ZEcAgSbyV6Q8EazAZMtPtYXX63aE00DT8
         9kxmbhkDdEXbixUtT/BYa5DK6b5/NqLo+08v0J9nTIrSx9T8PBssOFNIwu5IwhIOFaFK
         7tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733325275; x=1733930075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrIsxVZo/gcZzbzQFSC8PQLeQjSHRaF+v4+eff7qHIg=;
        b=OdOTWuRxPwjiW7JV3NEPrWrTdUDXCLVZa9J5lpaB80HBYfjHl7KAj7wmJT/DcTAIz2
         ++1IGgFmB/2H5LCEkT+UoVfCqwLM071vJEQL/ZHdM+goun5UvSz13GbTkQkKkFkJVZy3
         pCTip58ti2cVWrKFl9HdI7hVOnbHB1S42/QXqs4DpxApQfMlbhaGoXTReYW79MvEr17l
         XZSa2UX4ZZcTZrOP+8PVOR8QHgHgatvC6nnKAq6210DQ3ZRYQlUIirigS/GEre6khBgv
         qRAadyWYfCUDOfQgVPquyDTrFWyX07dgXPkT5HlpzNM4+LFH1KiLvn+bC61SRa/lyaFu
         QqPA==
X-Forwarded-Encrypted: i=1; AJvYcCU4k+e2uFfUblp+07Xxqx5zkiqJ/6UsWn0YFWib9TRvDMosuIMRfG4mhnuCWdftLe9JDt8eVZWwoDkuvEAR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2FgDjuOA5/GTUvzAg0FGwdNx7PmQsIEJBgQcFjJ3G/05fUMBF
	9QZ0d8qsYhf3xBvz2DchXzV56ndJ1zG/mo+XpKShJYpKFjYqDQxIfeLA2YuqQv0=
X-Gm-Gg: ASbGncsDWwIxDG317VsjdepvGOPpyEmh3zZcdUX2uuzcaUWQMQk4xCy1uJYwLvAyhto
	4pRKxipPvwYO8J01ut77e9oaGRxOwP14C0OTtS0gWRhDYjTMC4VxjsLFm4rWnf6TJSnuZMJ2MvI
	ESpmu6Af5d9QUcC+Gdt7ocfJyGj/deqdaGvS1kDdzE5pGMA/lYO5/0xByrfGrqEYR2Uf3CtB+DR
	2b4exMoLEC4lpd++/Gj1R2YARy2PrJvRMKmVpbK4AZiv8fLSHRKug==
X-Google-Smtp-Source: AGHT+IED7cGQMULseR3nC5HbQ2v0nT7SjqA3OkkP1K56ek/0BsFB+SldmxhUb19lWCKmqLJy7AZgFg==
X-Received: by 2002:a05:6000:2c6:b0:385:f6c7:90c6 with SMTP id ffacd0b85a97d-385fd3f9082mr6255702f8f.20.1733325275444;
        Wed, 04 Dec 2024 07:14:35 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385eb10bf7esm11243197f8f.14.2024.12.04.07.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 07:14:35 -0800 (PST)
Message-ID: <cee55e3b-9028-4f56-8ac6-9895ca383334@suse.com>
Date: Wed, 4 Dec 2024 16:14:34 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
 <CGME20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be@eucas1p1.samsung.com>
 <164e5f22f8ab59d1d516e3c992efdd9f83ab4819.1731148254.git.christophe.leroy@csgroup.eu>
 <D5HZV4A6SC9A.25U3Q0WUVDJHZ@samsung.com>
 <b74f0845-4916-47eb-945b-eb91ae05fc91@csgroup.eu>
 <D5K3PNXEIKYK.11GZ8BMY02OA4@samsung.com>
 <7fdcf601-524b-4530-861d-e4b0f8c1023b@suse.com>
 <9734d93d-73c8-464e-8f32-6117c6f6c952@samsung.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <9734d93d-73c8-464e-8f32-6117c6f6c952@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/28/24 21:23, Daniel Gomez wrote:
> On 11/12/2024 3:35 PM, Petr Pavlu wrote:
>> On 11/12/24 10:43, Daniel Gomez wrote:
>>> On Mon Nov 11, 2024 at 7:53 PM CET, Christophe Leroy wrote:
>>>>
>>>>
>>>> Le 09/11/2024 à 23:17, Daniel Gomez a écrit :
>>>>> On Sat Nov 9, 2024 at 11:35 AM CET, Christophe Leroy wrote:
>>>>>> Once module init has succeded it is too late to cancel loading.
>>>>>> If setting ro_after_init data section to read-only fails, all we
>>>>>> can do is to inform the user through a warning.
>>>>>>
>>>>>> Reported-by: Thomas Gleixner <tglx@linutronix.de>
>>>>>> Closes: https://protect2.fireeye.com/v1/url?k=d3deb284-b2a35ac3-d3df39cb-74fe485fff30-288375d7d91e4ad9&q=1&e=701066ca-634d-4525-a77d-1a44451f897a&u=https%3A%2F%2Feur01.safelinks.protection.outlook.com%2F%3Furl%3Dhttps%253A%252F%252Flore.kernel.org%252Fall%252F20230915082126.4187913-1-ruanjinjie%2540huawei.com%252F%26data%3D05%257C02%257Cchristophe.leroy%2540csgroup.eu%257C26b5ca7363e54210439b08dd010c4865%257C8b87af7d86474dc78df45f69a2011bb5%257C0%257C0%257C638667874457200373%257CUnknown%257CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%253D%253D%257C0%257C%257C%257C%26sdata%3DZeJ%252F3%252B2Nx%252FBf%252FWLFEkhxKlDhZk8LNkz0fs%252Fg2xMcOjY%253D%26reserved%3D0
>>>>>> Fixes: d1909c022173 ("module: Don't ignore errors from set_memory_XX()")
>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>> ---
>>>>>>    kernel/module/main.c | 6 +++---
>>>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>>>> index 2de4ad7af335..1bf4b0db291b 100644
>>>>>> --- a/kernel/module/main.c
>>>>>> +++ b/kernel/module/main.c
>>>>>> @@ -2583,7 +2583,9 @@ static noinline int do_init_module(struct module *mod)
>>>>>>    #endif
>>>>>>    	ret = module_enable_rodata_ro_after_init(mod);
>>>>>>    	if (ret)
>>>>>> -		goto fail_mutex_unlock;
>>>>>> +		pr_warn("%s: %s() returned %d, ro_after_init data might still be writable\n",
>>>>>> +			mod->name, __func__, ret);
>>>>>> +
>>>>>>    	mod_tree_remove_init(mod);
>>>>>>    	module_arch_freeing_init(mod);
>>>>>>    	for_class_mod_mem_type(type, init) {
>>>>>> @@ -2622,8 +2624,6 @@ static noinline int do_init_module(struct module *mod)
>>>>>>    
>>>>>>    	return 0;
>>>>>
>>>>> I think it would make sense to propagate the error. But that would
>>>>> require changing modprobe.c. What kind of error can we expect when this
>>>>> happens?
>>>>
>>>> AFAIK, on powerpc it fails with EINVAL when
>>>> - The area is a vmalloc or module area and is a hugepage area
>>>> - The area is not vmalloc or io register and MMU is not powerpc radix MMU
>>>>
>>>> Otherwise it propagates the error from apply_to_existing_page_range().
>>>> IIUC it will return EINVAL when it hits a leaf PTE in upper directories.
>>>
>>> Looking at that path I see we can also fail at __apply_to_page_range()
>>> -> apply_to_p4d_range() and return with -ENOMEM.
>>>
>>> My proposal was to do something like the change below in modprobe:
>>>
>>> diff --git a/tools/modprobe.c b/tools/modprobe.c
>>> index ec66e6f..8876e27 100644
>>> --- a/tools/modprobe.c
>>> +++ b/tools/modprobe.c
>>> @@ -572,6 +572,11 @@ static int insmod_insert(struct kmod_module *mod, int flags, const char *extra_o
>>>                  err = 0;
>>>          else {
>>>                  switch (err) {
>>> +               case -EINVAL:
>>> +                       ERR("module '%s'inserted: ro_after_init data might"
>>> +                           "still be writable (see dmesg)\n",
>>> +                           kmod_module_get_name(mod));
>>> +                       break;
>>>                  case -EEXIST:
>>>                          ERR("could not insert '%s': Module already in kernel\n",
>>>                              kmod_module_get_name(mod));
>>>
>>> But I think these error codes may be also be reported in other parts
>>> such as simplify_symbols() so may not be a good idea after all.
>>
>> It isn't really possible to make a sensible use of the return code from
>> init_module(), besides some basic check for -EEXIST. The problem is that
>> any error code from a module's init function is also propagated as
>> a result from the syscall.
>>
>>>
>>> Maybe we just need to change the default/catch all error message in
>>> modprobe.c and to indicate/include this case:
>>>
>>> diff --git a/tools/modprobe.c b/tools/modprobe.c
>>> index ec66e6f..3647d37 100644
>>> --- a/tools/modprobe.c
>>> +++ b/tools/modprobe.c
>>> @@ -582,7 +582,8 @@ static int insmod_insert(struct kmod_module *mod, int flags, const char *extra_o
>>>                              kmod_module_get_name(mod));
>>>                          break;
>>>                  default:
>>> -                       ERR("could not insert '%s': %s\n", kmod_module_get_name(mod),
>>> +                       ERR("could not insert '%s' or inserted with error %s, "
>>> +                           "(see dmesg)\n", kmod_module_get_name(mod),
>>>                              strerror(-err));
>>>                          break;
>>>                  }
>>>
>>>
>>>>
>>>> On other architectures it can be different, I know some architecture try
>>>> to split the pages when they hit hugepages and that can fail.
>>>
>>> Is it worth it adding an error code for this case in case we want to
>>> report it back?
>>
>> I feel that the proposed kernel warning about this situation is
>> sufficient and the loader should then return 0 to indicate that the
>> module got loaded. It would be more confusing to return an error but
>> with the module actually remaining inserted.
>>
>> A module loaded without having its RO-after-init section changed
>> properly to RO is still fully functional. In practice, if this final
>> set_memory_ro() call fails, the system is already in such a state where
>> the additional warning is the least of the issues?
>>
> 
> __ro_after_init is used for kernel self protection. We are loading 
> "successfully" the module yes, but variables with this attribute are 
> marked read-only to reduce the attack surface [1]. Since we have 
> considered this stage already too late to unload the module, IMHO we 
> should at least indicate that there was an error during the module 
> initialization and propagate that to the loader, so it can decide the 
> best action for their particular case. Warning once in the kernel log 
> system, does not seem sufficient to me.
> 
> [1] Documentation/security/self-protection.rst

I'd be careful about introducing this new state where (f)init_module()
returns an error, yet the module actually gets loaded.

The init_module() interface has one return value which can originate
from anywhere during the load process, including from the module's own
init function. As mentioned, this means that the userspace cannot
distinguish why the module load failed. It would be needed to have
a specific error code returned only for this case, or to extend the
interface further in some way.

Another concern is consistency of the module loader interface as
a whole. Returning an error from init_module() in this case would mean
that only the specific caller is made aware that the module was loaded
with some issues. A different task that then decides to check the module
state under /sys/module would see it as normally loaded, and similarly a
task trying to insert it again would get -EEXIST. That likely would need
changing too.

What I'd like to understand is how reporting this as an error to the
userspace would help in practice. I think the userspace can decide to
report it as a warning and continue, or treat is as a hard problem and
stop the system? I would expect that most tools/systems would opt for
the former, but then this doesn't seem much different to me than when
the kernel produces the warning itself. The second option, with some
stretch, could be implemented with panic_on_warn=1.

Do you envision that the userspace would handle this problem differently
and it is worth adding the complexity?

As a side node, I've noticed that the module loader could mark also
static_call sections as ro_after_init. I'll post patches for that.
Additionally, both __jump_table and static_call sections could be
possibly turned RO earlier, after prepare_coming_module() ->
blocking_notifier_call_chain_robust() -> ... ->
jump_label_add_module()/static_call_add_module().

-- 
Thanks,
Petr
