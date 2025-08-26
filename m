Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E15393DE2;
	Tue, 26 Aug 2025 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201552; cv=none; b=H2yrWm8JoXA7YaT4U6bNN46oUKZKy8HzLSksWQSETFRgQyYLz1mrpd+3Tnz1xjoFhj5oLtTXB7nlTJkvUCYani9v4axkjWgaYpcWseCH0Z3M0t+YrVUryubmbEX4Mi++f+jszaLKqajlttL3usQT7/P8+QIwAulL5z4b+0zzkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201552; c=relaxed/simple;
	bh=6msbRT8PiaSF90DjFMZPcNqnswgMCUAQXyIoLxVUz24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYm6Xb25HgcUhN+Lr/ickgx5IFjBbLEGLVPqZ9oFko9TcZDuF26OnHzoI7J1CQNtFfkDI/g6x5tOXGIbcFU0/0b/D56GPcpaDdLn3qUXht8Ad8R9BCV+h1MHsixYh6Tm5Bnp61h7Lm81oIRRiHF3u0YtSvyl33jjsyyTRtR4c6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvYoJUkN; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvYoJUkN"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b476c67c5easo3545030a12.0;
        Tue, 26 Aug 2025 02:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756201550; x=1756806350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDP+RTbtDINd6o1nnOABAkhuWEnh9vV0J6pWo1c0c1E=;
        b=QvYoJUkN5mj8PPanCoFfdql5qTvzX4kR3uL4MabLgTiPXgaYe+h8f9c1HsWteVXmvX
         r4UFNEzQLi8tepFvdRconCPIDeCuO4i3Z2aB7BX0vfbPhUf0Wpy86iOB3GgF0GSwewy5
         TFCiYDa4oACk79+bW8+oUCNa2IfObl2PA9qel+fVfkt6fBV71FRqYhd984t3ni7noa3U
         LGSHkWmPQSGPxgilLftLfNrmHc9g5uDJfSz5GMTabQz86aRjHe+eARiXzNzxcOuyaiNE
         d7DKG/nRpmfJM5mA+gIm15k+bLEPE+qW+9Jj/uwN7rZocnPtoVAvwY4kHvq1p2dKLLEk
         /3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756201550; x=1756806350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDP+RTbtDINd6o1nnOABAkhuWEnh9vV0J6pWo1c0c1E=;
        b=nJq6+Zfi9OiQpWMXYx2SOdAiNBBpQ+ZwfOAX/1De9oR849A+2yted3Ay+mesvw+/z1
         nynkuUSt8KUOUaW71++SJC8Ij0t8DLewmpuVE8INhN+n9eNK9xtSArOJgGTbsGz1DxRf
         yUC28hc6aEP1dpdJB+UKk7ZHwexEp1lldzqtz64bk9K/Br2qUPykyqqlypNEi7dDXkSc
         X3lLpClMEkOXVrTqDaj4jKegZKho6WjrysaY2TTRYhiQzE59cU47oh4cUAdJ3VONJdZT
         OyCVmAxTuA1wYGsdXsIuktG4AWPq8LHFDIqrv4l148IPk3NKs9cI1gFqfnlOxj9ldT8J
         yOhg==
X-Forwarded-Encrypted: i=1; AJvYcCWUfi+sRHEHooebl89H2Cl/B1eQwH3B0l6nlLmsJERt5Rjh5HlhoXxoQ9kqYP7WpiWpiKW5zH5mNLYUAwc=@vger.kernel.org, AJvYcCWVqLdaLWlqXbfGzP1nmQEWLYHJnYLxvS+te7xQ10T3jSWYhJZ/z7rdtqsIaD+UIhxx5DMcFSq6IBjEN75+hA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+A92sSHDaB5V1mwt6NYUcXxxi7gbGSoa0qF+bKCq1lvn3dhr
	V1GB7x65xDJ9vLFWDFe1YDhkJMTlLVOyyjFwyriARqQ6truwcfljYsVk
X-Gm-Gg: ASbGncsSjj6Olgw2SKcywWRQgn3UIUcW2PYF69vidVty7TwbbrgGW9xXgJjMA3xjisn
	vM/cPTQle8k/J9v5iwS0gEGLuGGHAwFHRDEyHWDKK0G7hV/4hjK1aRGR+rmzDbTtgdTELI5vx1E
	k9WqC25D5lSdXtZC2StmCEq7d0GfOv+GtHOWF5ZayP9VJxP/+we5eG0+uDbpwUBdoKkMs6QNnnL
	4YjkC6Zcb2QJUr5ZVcydg9/tRZpVBfmOKF/0kqHxTIuklFHiUha65XIDbuyhEMqrU8bVAtbgLUF
	P0/ziO6ORCw4x+XadHk0bG1HE0y+6ZyY6m9ceItwOSQ42JVitJj5g5AoWKVfFdriXRizRqSAoje
	lTgXLTNib1Yk7tQai1Nf7gUmCFw==
X-Google-Smtp-Source: AGHT+IGsULEag2oTed69ifti6hnZe9gYWu+YJL5JNZkpMyF13RhP5hIAh9mJ4pShRS3EOVwLti9UPg==
X-Received: by 2002:a17:902:db08:b0:242:5f6c:6b4e with SMTP id d9443c01a7336-248753a298amr13496735ad.7.1756201549785;
        Tue, 26 Aug 2025 02:45:49 -0700 (PDT)
Received: from [127.0.0.1] ([2a12:a305:4::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24884a629fcsm38185ad.19.2025.08.26.02.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:45:48 -0700 (PDT)
Message-ID: <0d4dd263-cccb-4195-9312-4ac358fb2493@gmail.com>
Date: Tue, 26 Aug 2025 17:45:43 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: pr_debug when there is no version info
Content-Language: en-US
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20250721045224.391745-1-wangjinchao600@gmail.com>
 <3992b57d-3d8b-4d60-bc4a-f227f712dcca@suse.com>
 <86062810-ff6b-4181-83b7-dfe443ff4012@gmail.com>
 <9b768f91-121a-4072-88b2-36cb48be3917@suse.com>
 <80d7313a-0f0c-494d-b2ad-2662d1992b2b@suse.com>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <80d7313a-0f0c-494d-b2ad-2662d1992b2b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 15:20, Petr Pavlu wrote:
> On 7/22/25 10:25 AM, Petr Pavlu wrote:
>> On 7/22/25 5:08 AM, Wang Jinchao wrote:
>>> On 7/21/25 22:40, Petr Pavlu wrote:
>>>> On 7/21/25 6:52 AM, Wang Jinchao wrote:
>>>>> When there is no version information, modprobe and insmod only
>>>>> report "invalid format".
>>>>> Print the actual cause to make it easier to diagnose the issue.
>>>>> This helps developers quickly identify version-related module
>>>>> loading failures.
>>>>> Signed-off-by: Wang Jinchao <wangjinchao600@gmail.com>
>>>>> ---
>>>>>    kernel/module/version.c | 4 +++-
>>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/kernel/module/version.c b/kernel/module/version.c
>>>>> index 2beefeba82d9..bc28c697ff3a 100644
>>>>> --- a/kernel/module/version.c
>>>>> +++ b/kernel/module/version.c
>>>>> @@ -42,8 +42,10 @@ int check_version(const struct load_info *info,
>>>>>        }
>>>>>          /* No versions at all?  modprobe --force does this. */
>>>>> -    if (versindex == 0)
>>>>> +    if (versindex == 0) {
>>>>> +        pr_debug("No version info for module %s\n", info->name);
>>>>>            return try_to_force_load(mod, symname) == 0;
>>>>> +    }
>>>>>          versions = (void *)sechdrs[versindex].sh_addr;
>>>>>        num_versions = sechdrs[versindex].sh_size
>>>>
>>>> I think it would be better to instead improve the behavior of
>>>> try_to_force_load(). The function should print the error reason prior to
>>>> returning -ENOEXEC. This would also help its two other callers,
>>>> check_modinfo() and check_export_symbol_versions().
>>>>
>>>> Additionally, I suggest moving the check to ensure version information
>>>> is available for imported symbols earlier in the loading process.
>>>> A suitable place might be check_modstruct_version(). This way the check
>>>> is performed only once per module.
>>>>
>>>> The following is a prototype patch:
>>>>
>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>> index c2c08007029d..c1ccd343e8c3 100644
>>>> --- a/kernel/module/main.c
>>>> +++ b/kernel/module/main.c
>>>> @@ -1053,6 +1053,7 @@ int try_to_force_load(struct module *mod, const char *reason)
>>>>        add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
>>>>        return 0;
>>>>    #else
>>>> +    pr_err("%s: %s\n", mod->name, reason);
>>>>        return -ENOEXEC;
>>>>    #endif
>>>>    }
>>>> diff --git a/kernel/module/version.c b/kernel/module/version.c
>>>> index 2beefeba82d9..4d9ebf0834de 100644
>>>> --- a/kernel/module/version.c
>>>> +++ b/kernel/module/version.c
>>>> @@ -41,9 +41,9 @@ int check_version(const struct load_info *info,
>>>>            return 1;
>>>>        }
>>>>    -    /* No versions at all?  modprobe --force does this. */
>>>> +    /* No versions? Ok, already tainted in check_modstruct_version(). */
>>>>        if (versindex == 0)
>>>> -        return try_to_force_load(mod, symname) == 0;
>>>> +        return 1;
>>>>          versions = (void *)sechdrs[versindex].sh_addr;
>>>>        num_versions = sechdrs[versindex].sh_size
>>>> @@ -90,6 +90,11 @@ int check_modstruct_version(const struct load_info *info,
>>>>            have_symbol = find_symbol(&fsa);
>>>>        BUG_ON(!have_symbol);
>>>>    +    /* No versions at all?  modprobe --force does this. */
>>>> +    if (!info->index.vers && !info->index.vers_ext_crc)
>>>> +        return try_to_force_load(
>>>> +                   mod, "no versions for imported symbols") == 0;
>>>> +
>>>>        return check_version(info, "module_layout", mod, fsa.crc);
>>>>    }
>>>>   
>>>> As a side note, I'm confused why with CONFIG_MODULE_FORCE_LOAD=y, the
>>>> code treats missing modversions for imported symbols as ok, even without
>>>> MODULE_INIT_IGNORE_MODVERSIONS. This is at least consistent with the
>>>> handling of missing vermagic, but it seems this behavior should be
>>>> stricter.
>>>>
>>> When debugging syzkaller, I noticed that the insmod command always reports errors. However, to get the exact information, I need to trace the kernel, so I casually submitted this patch.
>>>
>>> Based on your response, I also feel that the meaning of force_load here is somewhat unclear. It would be better to create a mask or a clear list to indicate which fields can be forced and which cannot. Once this is clear, we can create a function named may_force_check().
>>
>> I cannot find an explicit reason in the Git history why a missing
>> vermagic is treated as if the module was loaded with
>> MODULE_INIT_IGNORE_VERMAGIC, and similarly why missing modversions data
>> is treated as if the module was loaded with
>> MODULE_INIT_IGNORE_MODVERSIONS.
>>
>> I would argue that a more sensible behavior would be to consider
>> a missing vermagic as an error and allow loading the module only if
>> MODULE_INIT_IGNORE_VERMAGIC is explicitly specified. And analogously for
>> missing modversions and MODULE_INIT_IGNORE_MODVERSIONS.
>>
>> Nonetheless, if I understand correctly, this should be mostly separate
>> from your issue.
> 
> To answer my own confusion, the thing that I missed is that the
> MODULE_INIT_IGNORE_* flags are available only for the finit_module
> syscall, not for init_module. In the case of init_module, the force
> logic is handled by kmod in userspace by stripping the relevant
> modversions and vermagic data. This means that when using init_module,
> the module loader cannot distinguish between a module that lacks this
> data and one that has it deliberately removed. When finit_module was
> introduced in 2012, commit 2f3238aebedb ("module: add flags arg to
> sys_finit_module()") added the MODULE_INIT_IGNORE_* flags, and they were
> simply implemented to mirror the kmod behavior.
> 
> -- Petr

The composition of 'force' and 'ignore' is confusing.
I learn much from your feedback, thank you very much.

-- 
Best regards,
Jinchao
