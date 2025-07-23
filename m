Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF674420;
	Wed, 23 Jul 2025 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245584; cv=none; b=n2NdsyVEObpRr1a96ap/0FZlAjOow/0zEdd2BKDfDLclFzFyiUhcG83wOwVVP5tyL35E5jwkCzUHvBHp3a8aa2MsW18+g50CKeiPQp0CU65PJqEAaP15ksXgUqilgdPwKeAWd4cRYCsLH0Ao/NqLYr7qI6X642SonwoIBkNR/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245584; c=relaxed/simple;
	bh=QnqfoVpp/ySRM60xCtNA/MhxpZ1NSgeFLu0bE8u9GzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJxv24paQkBxdxgs4jteD+AuuHSrgQLhRwzniLk37vqr6gecwcu+95cMPE+Wz851okwyy4v36bJ8mHs/IrvfAEUynqwd0At2Fv0e/UPPVVn6T4BcXmfxHO0mwts72g2vFOS/uhHJ6WxTD3Yy7fhd+cJANzS1IeeBwXIBLkjrlcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJqIafj2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJqIafj2"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-237311f5a54so50119535ad.2;
        Tue, 22 Jul 2025 21:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753245582; x=1753850382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrT4PsyjgrcBfjVG3k3+24D3KHP4lfAf9qGVYGf51Fs=;
        b=fJqIafj2nGFTTbu/yMamQG2rFwWdL6QIr/E9UrP24o00o7fG/Dh3Wn7sZeQ0ZU8CJm
         hqVEv2ntH5VYGy9UbNMBslN0DSgEK56lGy6MhcQw/ZxNAo9Krf4OM9QNLHFJQre32Kbi
         YuyjO7o4yc/AcEJLSc9iILyotisnKlQD5cFkdAvki7YDJMZjr+TGkn2LhfiHPobDgTYi
         e2jTJRUmRIQd4ibsDxhl4FTGi1Rgk424PJo4cQjN12Eld/SCYxdVdvMP7qLF8/JNEfOP
         DF5bgN/dlnZ4bKjJTcBoc/fXvfeWch1cGIcO93ucwksE6RYOBgbM0dEDxiZwXWr+sYNY
         I5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753245582; x=1753850382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrT4PsyjgrcBfjVG3k3+24D3KHP4lfAf9qGVYGf51Fs=;
        b=dyGvF/v0QciHohJ2R/Q10tNbxD8tNUoJey7n0cORxM2GJQDlFa9fzYPj+moO98qiPH
         Ps23JUQC5OyiWfKEqB5CsRsHykzPGmZO/k75ctEzD5NuBOxP0KC41xiQD5anIVDlg+UW
         SK8fjJAOuJVRSNREk8LhQ38ChUoYb+bGFbcmo8C5T3BMRLY/LLV/QzlVVVZPxPIeJK7O
         wrbH0j+kvrKK2qRTvlgFe1JW8XKFjbu4GYOBN1QHM3Vt64LfBAj0RWPAsBdr2ykdgvLp
         x99UxYemLmop4QWWJ/EMvNW0YqFp5tAQEiDEozx740lvdUy9Li2I3SSbrB/8KVBarANp
         YmSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/A2XpKjl0yHtgv36WihejX5wuoqF8/P0pf/zAQHhm0IOxm6IMGutXEJfNDafndlIyz3vpKfZL7JlNdYk=@vger.kernel.org, AJvYcCVOmPxAbRZmNXfdh3O1mhKRRzNCaaOxP5W7MbDEMV+ibxPi57fg/xT1D8lE/jPYpLbjzAO5mOJHT8miqef9xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTh00O2EkqsHiPueU+0CL3wVOGVjRoT34Yx3ZDdfp8EGBtcvE7
	H5DilKaCIe46EWDzo/uRzi1K0g53ZzQzo/kjOUvxQwavfzoPZ6bi4byO
X-Gm-Gg: ASbGncuE6D7Z3kpPh6yLrj82cF4iCQqy1nS2isW/pRjGED96UpS6KvaLXPC+VlZMs0K
	39BPaCqn3N4HXF75KRRpapkyEdZrhXoX4bJwFgVH6s1X6Xnjc/LUebd3l6sOlCzaznVal/XeS2t
	ARu4dzYrY6qvYVTfkHe+zm4JifRNc0+23VBntBghyqpKOEYqcQeACEC4oUEubjkk0aDuA3oNaxM
	LQKuMUSSgY1NvJ6rvQPJf4fTA7NkuqHQE/Wj9RlPRjEibDSH3NWvrTlRsE49JIcW3R4ymV1Gzmd
	RoqvPratowImTHD15Wi+BnlSoiYRBrQl0PUvThiU9p1YdmJAAQdBo+auJP+rxdqeVL5PGRpMi3f
	4CH0+Pe/ggJYg9LIl4ZEt+NUIeQ==
X-Google-Smtp-Source: AGHT+IFuOvz25ExvGtrT8RYvVCAC1yDxpaxfARrhCyQhEq7lwJ4YyxzovPYbqDjrAGTjB0oEnUazXQ==
X-Received: by 2002:a17:902:c942:b0:234:a139:1215 with SMTP id d9443c01a7336-23f981d3e70mr22573975ad.35.1753245581486;
        Tue, 22 Jul 2025 21:39:41 -0700 (PDT)
Received: from [127.0.0.1] ([2403:2c80:6::3058])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4af3sm86600225ad.85.2025.07.22.21.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 21:39:40 -0700 (PDT)
Message-ID: <60626284-dd9e-4e13-82bd-0b7c30db8da9@gmail.com>
Date: Wed, 23 Jul 2025 12:39:36 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: pr_debug when there is no version info
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20250721045224.391745-1-wangjinchao600@gmail.com>
 <3992b57d-3d8b-4d60-bc4a-f227f712dcca@suse.com>
 <86062810-ff6b-4181-83b7-dfe443ff4012@gmail.com>
 <9b768f91-121a-4072-88b2-36cb48be3917@suse.com>
Content-Language: en-US
From: Wang Jinchao <wangjinchao600@gmail.com>
In-Reply-To: <9b768f91-121a-4072-88b2-36cb48be3917@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/25 16:25, Petr Pavlu wrote:
> On 7/22/25 5:08 AM, Wang Jinchao wrote:
>> On 7/21/25 22:40, Petr Pavlu wrote:
>>> On 7/21/25 6:52 AM, Wang Jinchao wrote:
>>>> When there is no version information, modprobe and insmod only
>>>> report "invalid format".
>>>> Print the actual cause to make it easier to diagnose the issue.
>>>> This helps developers quickly identify version-related module
>>>> loading failures.
>>>> Signed-off-by: Wang Jinchao <wangjinchao600@gmail.com>
>>>> ---
>>>>    kernel/module/version.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/module/version.c b/kernel/module/version.c
>>>> index 2beefeba82d9..bc28c697ff3a 100644
>>>> --- a/kernel/module/version.c
>>>> +++ b/kernel/module/version.c
>>>> @@ -42,8 +42,10 @@ int check_version(const struct load_info *info,
>>>>        }
>>>>          /* No versions at all?  modprobe --force does this. */
>>>> -    if (versindex == 0)
>>>> +    if (versindex == 0) {
>>>> +        pr_debug("No version info for module %s\n", info->name);
>>>>            return try_to_force_load(mod, symname) == 0;
>>>> +    }
>>>>          versions = (void *)sechdrs[versindex].sh_addr;
>>>>        num_versions = sechdrs[versindex].sh_size
>>>
>>> I think it would be better to instead improve the behavior of
>>> try_to_force_load(). The function should print the error reason prior to
>>> returning -ENOEXEC. This would also help its two other callers,
>>> check_modinfo() and check_export_symbol_versions().
>>>
>>> Additionally, I suggest moving the check to ensure version information
>>> is available for imported symbols earlier in the loading process.
>>> A suitable place might be check_modstruct_version(). This way the check
>>> is performed only once per module.
>>>
>>> The following is a prototype patch:
>>>
>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>> index c2c08007029d..c1ccd343e8c3 100644
>>> --- a/kernel/module/main.c
>>> +++ b/kernel/module/main.c
>>> @@ -1053,6 +1053,7 @@ int try_to_force_load(struct module *mod, const char *reason)
>>>        add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
>>>        return 0;
>>>    #else
>>> +    pr_err("%s: %s\n", mod->name, reason);
>>>        return -ENOEXEC;
>>>    #endif
>>>    }
>>> diff --git a/kernel/module/version.c b/kernel/module/version.c
>>> index 2beefeba82d9..4d9ebf0834de 100644
>>> --- a/kernel/module/version.c
>>> +++ b/kernel/module/version.c
>>> @@ -41,9 +41,9 @@ int check_version(const struct load_info *info,
>>>            return 1;
>>>        }
>>>    -    /* No versions at all?  modprobe --force does this. */
>>> +    /* No versions? Ok, already tainted in check_modstruct_version(). */
>>>        if (versindex == 0)
>>> -        return try_to_force_load(mod, symname) == 0;
>>> +        return 1;
>>>          versions = (void *)sechdrs[versindex].sh_addr;
>>>        num_versions = sechdrs[versindex].sh_size
>>> @@ -90,6 +90,11 @@ int check_modstruct_version(const struct load_info *info,
>>>            have_symbol = find_symbol(&fsa);
>>>        BUG_ON(!have_symbol);
>>>    +    /* No versions at all?  modprobe --force does this. */
>>> +    if (!info->index.vers && !info->index.vers_ext_crc)
>>> +        return try_to_force_load(
>>> +                   mod, "no versions for imported symbols") == 0;
>>> +
>>>        return check_version(info, "module_layout", mod, fsa.crc);
>>>    }
>>>   
>>> As a side note, I'm confused why with CONFIG_MODULE_FORCE_LOAD=y, the
>>> code treats missing modversions for imported symbols as ok, even without
>>> MODULE_INIT_IGNORE_MODVERSIONS. This is at least consistent with the
>>> handling of missing vermagic, but it seems this behavior should be
>>> stricter.
>>>
>> When debugging syzkaller, I noticed that the insmod command always reports errors. However, to get the exact information, I need to trace the kernel, so I casually submitted this patch.
>>
>> Based on your response, I also feel that the meaning of force_load here is somewhat unclear. It would be better to create a mask or a clear list to indicate which fields can be forced and which cannot. Once this is clear, we can create a function named may_force_check().
> 
> I cannot find an explicit reason in the Git history why a missing
> vermagic is treated as if the module was loaded with
> MODULE_INIT_IGNORE_VERMAGIC, and similarly why missing modversions data
> is treated as if the module was loaded with
> MODULE_INIT_IGNORE_MODVERSIONS.
> 
> I would argue that a more sensible behavior would be to consider
> a missing vermagic as an error and allow loading the module only if
> MODULE_INIT_IGNORE_VERMAGIC is explicitly specified. And analogously for
> missing modversions and MODULE_INIT_IGNORE_MODVERSIONS.
> 
> Nonetheless, if I understand correctly, this should be mostly separate
> from your issue.
Got it, thanks for the explanation.
I agree it would be good to refactor the force-load logic to make the
behavior and options (e.g. ignoring modversions) more explicit.

I’d be happy to work on this in my spare time.

> 
>>
>> In addition, check_modstruct_version also calls check_version to handle tainting. So there's a minor issue with the logic in your example patch.
>>
> 
> I'm not sure I follow here. My example lifts the try_to_force_load()
> call from check_version() to check_modstruct_version(), and should still
> result in tainting the kernel.
> 
You are right. I miss the botton half. :)

-- 
Best regards,
Jinchao
