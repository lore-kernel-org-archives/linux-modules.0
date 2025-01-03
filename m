Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE71B415D
	for <linux-modules@vger.kernel.org>; Fri,  3 Jan 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918851; cv=none; b=dcJyD2UacYNF5rTsnqB3y1G7CjqPLAxYfDDqJlxsEtFhB/A9b7S/0x5CwBbPTAJk8D2ZzzxzjlzbRtL5fChOyacQkTAaI3UZCFTyWIbTrppxDYbCNqxo3VngJA54Pr5FVZbEr6PN0Bt9mrtHl6P6ILrSW6EHG16LCO4Wcqbz/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918851; c=relaxed/simple;
	bh=i5qZzjFI1WY+8apiO4HiUgfnSPJe2ob5sL+NIBhLzBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhL/cnJNSSb9GcDO5fxI46V+YMiC6Eesk8PodDG0X1jZfroeoLqexqYGXh6yRPmm1sDnUxeKYORStqU1s2cs5k/xqdZnVdVg7QemwvNmd/QdVQwvoFhFBhXBJ2ib+IbWXLKrpiCaYcvBBMOzFtghjmajkUkQGyQs9NNerCcOpJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZAdQWdjq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZAdQWdjq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so140141295e9.0
        for <linux-modules@vger.kernel.org>; Fri, 03 Jan 2025 07:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735918848; x=1736523648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbeD/WTyNi2SfqmhdF3cFrvUskEhvZV4JIz8EOPAPaA=;
        b=ZAdQWdjqQGJ1EY+XMH8DyyIDQMsymkl5X95WnAAVcPHu/NuaIZ2ffHgEWtGXCgMTtx
         12l5vRTLhxoiKUJvmlWZMawZ6KfbDh1zkGGTT6Nw0PGvWFqDUlKPVVHSMManIXN9aziy
         GYX18acjnswlO8UUSSgjSN6DJ+HUyzkK+POFF3tz3Rkk3mszltWKydgT15GWwTgRDybM
         TX4TPvGI4EgKvhdoyfGJvPsPhx8AvqOKiR68i+MOeNho1IhmmrA1w3uA03GL/hwQ7p+t
         p7gTPekM+MXY8XnnO/5taR08P07Vge4hbmQgddfQ+7dBDjFoR+Mdl1SpxWLCqRd3luXi
         zC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735918848; x=1736523648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbeD/WTyNi2SfqmhdF3cFrvUskEhvZV4JIz8EOPAPaA=;
        b=V/4QVmlfFbk95rn7a7T8RC/7Sx9gFRjo2orBaoTYsJIvMIH0epE79ROOPys8qlK31f
         Ku9bKQuoC2QwV6to/UkhtSlrjYEciXdI11VfhP2wWRgJ2VsWn4WNRV5uddpkDgWB9LZ1
         Y79uj+0+I5j6SUZGW372S4PRi8gDbYv+PxcpwnhdDrG88l5QTHodfCTVuiHR/HHUeY2O
         9RQfZ90XElx/FZymDVHahHZetjIUdOMI+uH4t36XwBiCUEtyEqWTuLk5HcOWe/WlodTd
         GsIzZ2ixQ0wjUBM6w2TzikwNt3YPFOOyftalvgDgi71GAWl8ifAiE+/RduuoVxaTrBsN
         wdJw==
X-Forwarded-Encrypted: i=1; AJvYcCUKAIbPN10QQ3bHRWPzFw/D11kYQTC/TFbkUuPNveZ97IJlQl3HmIlPElXMEuIGp+iPJcixKJSh7hqwwJUX@vger.kernel.org
X-Gm-Message-State: AOJu0YyTiZnaS+R7stkO/bqHyHU4nzYBjZ5KbEFGbxXzh9xhvl3O45YD
	8EZfmYJaD0BFssCFbUrhFA+pvXOa7kHN+t1IyMGJwtzKl+6hfdg0hftmB/XzsRjp1ndv7+Gvf59
	e
X-Gm-Gg: ASbGncsEbqNT4V0SD2eAh7Cf6d3xqSfvK3enKVodZ0wBAunQtefAfe55rut4T5lIGba
	eovRTlYB70us2JVfzsvoeFScvzUyPBGyqPORligoVwbpM2NJFLOWdGHnhxsdEvB86T5ecobOZFR
	BGIP+IPLd3TofBiETuI2AKymf83Ycv+2Esfnhd4gENlxzFkLp7Y3Kt0w4TlimRGimDdco2C7tZv
	CEhwtlGytS2N7HMbLlixLinli8LhHbWzhluwXogow/qcJiEODm3nfrB/IYW
X-Google-Smtp-Source: AGHT+IECgUYwniAsxFLc1SYC51Z2oBI3ve2Fx8W6o9bmzfhvt47rnW6U2yJjiCFwF6ArBII0heZa4A==
X-Received: by 2002:a05:6000:2af:b0:385:e1a8:e28e with SMTP id ffacd0b85a97d-38a221e1e76mr41089713f8f.10.1735918847740;
        Fri, 03 Jan 2025 07:40:47 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436723cb159sm434158075e9.16.2025.01.03.07.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 07:40:47 -0800 (PST)
Message-ID: <d6a7fbda-4938-4630-b264-a4f6611bcef3@suse.com>
Date: Fri, 3 Jan 2025 16:40:46 +0100
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
 <cee55e3b-9028-4f56-8ac6-9895ca383334@suse.com>
 <95871917-9747-40d4-8305-51bc5d75cf82@samsung.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <95871917-9747-40d4-8305-51bc5d75cf82@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/10/24 11:49, Daniel Gomez wrote:
> On 12/4/2024 4:14 PM, Petr Pavlu wrote:
>> On 11/28/24 21:23, Daniel Gomez wrote:
>>> On 11/12/2024 3:35 PM, Petr Pavlu wrote:
>>>> On 11/12/24 10:43, Daniel Gomez wrote:
>>>>> On Mon Nov 11, 2024 at 7:53 PM CET, Christophe Leroy wrote:
>>>>>>
>>>>>>
>>>>>> Le 09/11/2024 à 23:17, Daniel Gomez a écrit :
>>>>>>> On Sat Nov 9, 2024 at 11:35 AM CET, Christophe Leroy wrote:
>>>>>>>> Once module init has succeded it is too late to cancel loading.
>>>>>>>> If setting ro_after_init data section to read-only fails, all we
>>>>>>>> can do is to inform the user through a warning.
>>>>>>>>
>>>>>>>> Reported-by: Thomas Gleixner <tglx@linutronix.de>
>>>>>>>> Closes: https://protect2.fireeye.com/v1/url?k=d3deb284-b2a35ac3-d3df39cb-74fe485fff30-288375d7d91e4ad9&q=1&e=701066ca-634d-4525-a77d-1a44451f897a&u=https%3A%2F%2Feur01.safelinks.protection.outlook.com%2F%3Furl%3Dhttps%253A%252F%252Flore.kernel.org%252Fall%252F20230915082126.4187913-1-ruanjinjie%2540huawei.com%252F%26data%3D05%257C02%257Cchristophe.leroy%2540csgroup.eu%257C26b5ca7363e54210439b08dd010c4865%257C8b87af7d86474dc78df45f69a2011bb5%257C0%257C0%257C638667874457200373%257CUnknown%257CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%253D%253D%257C0%257C%257C%257C%26sdata%3DZeJ%252F3%252B2Nx%252FBf%252FWLFEkhxKlDhZk8LNkz0fs%252Fg2xMcOjY%253D%26reserved%3D0
>>>>>>>> Fixes: d1909c022173 ("module: Don't ignore errors from set_memory_XX()")
>>>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>>> ---
>>>>>>>>     kernel/module/main.c | 6 +++---
>>>>>>>>     1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>>>>>> index 2de4ad7af335..1bf4b0db291b 100644
>>>>>>>> --- a/kernel/module/main.c
>>>>>>>> +++ b/kernel/module/main.c
>>>>>>>> @@ -2583,7 +2583,9 @@ static noinline int do_init_module(struct module *mod)
>>>>>>>>     #endif
>>>>>>>>     	ret = module_enable_rodata_ro_after_init(mod);
>>>>>>>>     	if (ret)
>>>>>>>> -		goto fail_mutex_unlock;
>>>>>>>> +		pr_warn("%s: %s() returned %d, ro_after_init data might still be writable\n",
>>>>>>>> +			mod->name, __func__, ret);
>>>>>>>> +
>>>>>>>>     	mod_tree_remove_init(mod);
>>>>>>>>     	module_arch_freeing_init(mod);
>>>>>>>>     	for_class_mod_mem_type(type, init) {
>>>>>>>> @@ -2622,8 +2624,6 @@ static noinline int do_init_module(struct module *mod)
>>>>>>>>     
>>>>>>>>     	return 0;
>>>>>>>
>>>>>>> I think it would make sense to propagate the error. But that would
>>>>>>> require changing modprobe.c. What kind of error can we expect when this
>>>>>>> happens?
>>>>>>
>>>>>> AFAIK, on powerpc it fails with EINVAL when
>>>>>> - The area is a vmalloc or module area and is a hugepage area
>>>>>> - The area is not vmalloc or io register and MMU is not powerpc radix MMU
>>>>>>
>>>>>> Otherwise it propagates the error from apply_to_existing_page_range().
>>>>>> IIUC it will return EINVAL when it hits a leaf PTE in upper directories.
>>>>>
>>>>> Looking at that path I see we can also fail at __apply_to_page_range()
>>>>> -> apply_to_p4d_range() and return with -ENOMEM.
>>>>>
>>>>> My proposal was to do something like the change below in modprobe:
>>>>>
>>>>> diff --git a/tools/modprobe.c b/tools/modprobe.c
>>>>> index ec66e6f..8876e27 100644
>>>>> --- a/tools/modprobe.c
>>>>> +++ b/tools/modprobe.c
>>>>> @@ -572,6 +572,11 @@ static int insmod_insert(struct kmod_module *mod, int flags, const char *extra_o
>>>>>                   err = 0;
>>>>>           else {
>>>>>                   switch (err) {
>>>>> +               case -EINVAL:
>>>>> +                       ERR("module '%s'inserted: ro_after_init data might"
>>>>> +                           "still be writable (see dmesg)\n",
>>>>> +                           kmod_module_get_name(mod));
>>>>> +                       break;
>>>>>                   case -EEXIST:
>>>>>                           ERR("could not insert '%s': Module already in kernel\n",
>>>>>                               kmod_module_get_name(mod));
>>>>>
>>>>> But I think these error codes may be also be reported in other parts
>>>>> such as simplify_symbols() so may not be a good idea after all.
>>>>
>>>> It isn't really possible to make a sensible use of the return code from
>>>> init_module(), besides some basic check for -EEXIST. The problem is that
>>>> any error code from a module's init function is also propagated as
>>>> a result from the syscall.
>>>>
>>>>>
>>>>> Maybe we just need to change the default/catch all error message in
>>>>> modprobe.c and to indicate/include this case:
>>>>>
>>>>> diff --git a/tools/modprobe.c b/tools/modprobe.c
>>>>> index ec66e6f..3647d37 100644
>>>>> --- a/tools/modprobe.c
>>>>> +++ b/tools/modprobe.c
>>>>> @@ -582,7 +582,8 @@ static int insmod_insert(struct kmod_module *mod, int flags, const char *extra_o
>>>>>                               kmod_module_get_name(mod));
>>>>>                           break;
>>>>>                   default:
>>>>> -                       ERR("could not insert '%s': %s\n", kmod_module_get_name(mod),
>>>>> +                       ERR("could not insert '%s' or inserted with error %s, "
>>>>> +                           "(see dmesg)\n", kmod_module_get_name(mod),
>>>>>                               strerror(-err));
>>>>>                           break;
>>>>>                   }
>>>>>
>>>>>
>>>>>>
>>>>>> On other architectures it can be different, I know some architecture try
>>>>>> to split the pages when they hit hugepages and that can fail.
>>>>>
>>>>> Is it worth it adding an error code for this case in case we want to
>>>>> report it back?
>>>>
>>>> I feel that the proposed kernel warning about this situation is
>>>> sufficient and the loader should then return 0 to indicate that the
>>>> module got loaded. It would be more confusing to return an error but
>>>> with the module actually remaining inserted.
>>>>
>>>> A module loaded without having its RO-after-init section changed
>>>> properly to RO is still fully functional. In practice, if this final
>>>> set_memory_ro() call fails, the system is already in such a state where
>>>> the additional warning is the least of the issues?
>>>>
>>>
>>> __ro_after_init is used for kernel self protection. We are loading
>>> "successfully" the module yes, but variables with this attribute are
>>> marked read-only to reduce the attack surface [1]. Since we have
>>> considered this stage already too late to unload the module, IMHO we
>>> should at least indicate that there was an error during the module
>>> initialization and propagate that to the loader, so it can decide the
>>> best action for their particular case. Warning once in the kernel log
>>> system, does not seem sufficient to me.
>>>
>>> [1] Documentation/security/self-protection.rst
>>
>> I'd be careful about introducing this new state where (f)init_module()
>> returns an error, yet the module actually gets loaded.
> 
> Perhaps we just need this new stage? module loaded with 
> permission/security error?
> 
>>
>> The init_module() interface has one return value which can originate
>> from anywhere during the load process, including from the module's own
>> init function. As mentioned, this means that the userspace cannot
>> distinguish why the module load failed. It would be needed to have
>> a specific error code returned only for this case, or to extend the
>> interface further in some way.
>>
>> Another concern is consistency of the module loader interface as
>> a whole. Returning an error from init_module() in this case would mean
>> that only the specific caller is made aware that the module was loaded
>> with some issues. A different task that then decides to check the module
>> state under /sys/module would see it as normally loaded, and similarly a
> 
> Maybe we need to change this state too to indicate the problem.
> 
>> task trying to insert it again would get -EEXIST. That likely would need
>> changing too.
>>
>> What I'd like to understand is how reporting this as an error to the
>> userspace would help in practice. I think the userspace can decide to
>> report it as a warning and continue, or treat is as a hard problem and
>> stop the system? I would expect that most tools/systems would opt for
>> the former, but then this doesn't seem much different to me than when
>> the kernel produces the warning itself. The second option, with some
>> stretch, could be implemented with panic_on_warn=1.
> 
> Ideally, we would reverse the module initialization when encountering 
> this error [1]. However, since it's not feasible to undo it correctly at 
> this stage, reporting the error back to the caller allows them to assess 
> and decide whether to accept the risk.
> 
> [1] https://lore.kernel.org/all/Zuv0nmFblHUwuT8v@bombadil.infradead.org/
>>
>> Do you envision that the userspace would handle this problem differently
>> and it is worth adding the complexity?
> 
> What complexity do you mean?

The complexity that I was referring to here is mainly the earlier
described limitation of the current init_module() interface and the
consistency of the module loader interface as a whole.

Another aspect is that a number of modules is loaded directly by the
kernel via request_module(). I'm not sure how the new error would be
handled in such cases. I suspect request_module() would be also only
able to log it as a kernel warning.

If I had to choose how to handle this corner case better (in long term),
I would rather try to avoid the error in the first place, potentially as
mentioned in my other reply by splitting set_memory_ro().

-- 
Thanks,
Petr
