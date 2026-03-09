Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E56B1DBB3A
	for <linux-modules@vger.kernel.org>; Mon,  9 Mar 2026 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066027; cv=none; b=VHEyUC44VRWeSK+D2h+QOxFYvvJPyGkETr0jlKkxORhtdeg2Elw2l2oyr77cX85CiwDGibPyH7kyJagG23aOHC+eS/vDjnAJiIKwdMNenmLg8KFD6nitx/IKUA2NP67OdD41f+Z89T6k2PmQYqDdrAR1gRiM8ykUQlO+FEiQC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066027; c=relaxed/simple;
	bh=LzyjKgv2bXxSlQMCvYXbx2Aq+ATSN9DPSdbmTudx4pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTqqewHJ9hv/DCTcg1ucQ5n+VVWsBvPcS2XtnWIQmMiXzTTtmH21SY3yu0yX3fISe1krJJ2XVTj5QSpbazzP3U5IjT3guNM+IrglItNWX63FjHZXPHULSALHDwlZFIlFAdVPpXhE9xsdGzfCTFJQAkma1LK8uon3f8ZZoNtZqiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aVvHJm83; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aVvHJm83"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b9b190easo5512892f8f.2
        for <linux-modules@vger.kernel.org>; Mon, 09 Mar 2026 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773066023; x=1773670823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EeqJU1rq7Do+u/ewah/ffxBf7w02u4hwzOEjyKa05s8=;
        b=aVvHJm83Jo/o2JJc++9qbKFgcfNzDyttm5bJhMzvm84FxVtyTORAn2qVuS65PAsLhI
         U8avTltMEVKx5rXW+XXgM8qp5OhqpbBh8Otdi3H+xZVZwBgPbe0/X01JfONtNCTYAWtN
         bOMq8ZvLGDjGiuaXJ4BCeD58UPWDbF7KHHvvRhtmrX3rxnsuOcLUfQNZE8dkGp4lANMY
         iJQYSUSov4Qv0+D3nEmehkj8tou5xDup120y1fXqbvgGjlwviDZR+FSbgu2Tvo2Zxkh+
         01blKdC3gwEdXbkctrq+yv/l2z4uwWc/g6cVXX33SslcwIWwSva23ey41IVAUY2wFMJn
         MBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066023; x=1773670823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeqJU1rq7Do+u/ewah/ffxBf7w02u4hwzOEjyKa05s8=;
        b=nm5Xd2+Yw1n1wLFJQhBKd7XhfjAq6goOXxPU/4fVdQs5xlIccmlR2ZQzDHWAV0Mkq+
         MJTVUtZ9kGQK8ZQ7l1vcdifKgxkF+h3VzO7esNWzuyAWi3cwBYUCCx1mmGBWyj4ir3FM
         uimlSSVFuQBypg5wMPXLyxv6dbcLNCkKKZynRp5qWGu7hxsDHyJZdxOQQtfB3dBauE72
         YRSuo0KEhWJWukS5BoeZGVb32Koi4i48mF9yS86/X+UdTH7cktkSB3gMEQjLIrWZbSGm
         5Sra58/AFNo4YfsUL0G2txW6BtF+Fapntw/k0oDTCeRUIyBbgqUFk2vgXg/kmduoJhml
         bRsA==
X-Forwarded-Encrypted: i=1; AJvYcCUoLgZuVynuLr9PudY2Nnfus+6YmEtQxJygyYYszYqcdKvPFZ6WPDapoA6h5c99k9CKitHi3pL83Dvyn3fF@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDOGsoPEJG4OeBCS/HqeHSVN7iqppyPM/hWpp/+0FJRhiq3k7
	cwvjmo17OUff32Sqtr8KtJHOUtgIaBjF/legaYUHMNWUM+7ipa9dpKuTN0YRCQcNnyE=
X-Gm-Gg: ATEYQzye3CW8TJx6KzcigFBSPPAYwBDeVDwrLesvf4UsLBiCt/FlYAZAKXI6GRLmznm
	Ibb/fOscKofjs6Vp6BpTLde3KDRnHgujqP+jRSiLgw88msyAiU5xbzdev/EawKP7EY1aQN1+Rgo
	8+AvtQ7I5SICRPpeC32O+NuxLOuDWWtYVknmluRS8xjj+LvmYjQ3wOW9Nmxy0iJqSTINktAkOn6
	8MIjN/gtZonBr1pV5dvQCVK57za50/E8nxVJcyjypSSaj5aCunfcirqJXxIp0o0DFc8/59AfCMk
	Nhc8o0nAfaEoZMVZAO63EOM34LoTCzQNVBrQ6sn1oxlhNccRlttaANgJ+Kheo4btYrEzXNsXscG
	CpwZ1pyc6s552r5B4Gsd3Wi3aBWMrUZhxI8C/zWjm+FOrxBuy8iwx8knZrjOkUlVx5pJZnS3AnS
	HqIxrRAkkf6tggKt/BfMgFKMQKsapErLxFXAA2bM0VwVGpO4wtmtOSDnfkT9+n0r4wtJv9J6Rr+
	TR/NPSygG6/H04kmKKVXpWwd53XolEG7tKH3FSiE6HfCqPGFm2mYdmKUSTW/pVE829Qj3FLwmvx
	WKMt
X-Received: by 2002:a05:600c:1913:b0:483:6f7c:19f4 with SMTP id 5b1f17b1804b1-4852696d4abmr174091765e9.30.1773066023279;
        Mon, 09 Mar 2026 07:20:23 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48534fa65a6sm91584425e9.2.2026.03.09.07.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 07:20:22 -0700 (PDT)
Message-ID: <ca5efcce-22f4-4e6f-8cf4-364c1738051e@suse.com>
Date: Mon, 9 Mar 2026 15:20:22 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Fix freeing of charp module parameters when
 CONFIG_SYSFS=n
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260306125457.1377402-1-petr.pavlu@suse.com>
 <d6ae7800-f284-488b-aef8-d321e550dfa1@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <d6ae7800-f284-488b-aef8-d321e550dfa1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/9/26 12:26 PM, Christophe Leroy (CS GROUP) wrote:
> Le 06/03/2026 à 12:10, Petr Pavlu a écrit :
>> When setting a charp module parameter, the param_set_charp() function
>> allocates memory to store a copy of the input value. Later, when the module
>> is potentially unloaded, the destroy_params() function is called to free
>> this allocated memory.
>>
>> However, destroy_params() is available only when CONFIG_SYSFS=y, otherwise
>> only a dummy variant is present. In the unlikely case that the kernel is
>> configured with CONFIG_MODULES=y and CONFIG_SYSFS=n, this results in
>> a memory leak of charp values when a module is unloaded.
>>
>> Fix this issue by making destroy_params() always available when
>> CONFIG_MODULES=y. Rename the function to module_destroy_params() to clarify
>> that it is intended for use by the module loader.
>>
>> Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>   include/linux/moduleparam.h | 12 ++++--------
>>   kernel/module/main.c        |  4 ++--
>>   kernel/params.c             | 27 ++++++++++++++++++---------
>>   3 files changed, 24 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
>> index 7d22d4c4ea2e..6283665ec614 100644
>> --- a/include/linux/moduleparam.h
>> +++ b/include/linux/moduleparam.h
>> @@ -426,14 +426,10 @@ extern char *parse_args(const char *name,
>>                 void *arg, parse_unknown_fn unknown);
>>     /* Called by module remove. */
>> -#ifdef CONFIG_SYSFS
>> -extern void destroy_params(const struct kernel_param *params, unsigned num);
>> -#else
>> -static inline void destroy_params(const struct kernel_param *params,
>> -                  unsigned num)
>> -{
>> -}
>> -#endif /* !CONFIG_SYSFS */
>> +#ifdef CONFIG_MODULES
>> +extern void module_destroy_params(const struct kernel_param *params,
>> +                  unsigned num);
> 
> 'extern' is pointless for function prototypes, don't add new ones.
> 
> num has no type.
> 
>> +#endif
>>     /* All the helper functions */
>>   /* The macros to do compile-time type checking stolen from Jakub
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index c3ce106c70af..ef2e2130972f 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -1408,7 +1408,7 @@ static void free_module(struct module *mod)
>>       module_unload_free(mod);
>>         /* Free any allocated parameters. */
>> -    destroy_params(mod->kp, mod->num_kp);
>> +    module_destroy_params(mod->kp, mod->num_kp);
>>         if (is_livepatch_module(mod))
>>           free_module_elf(mod);
>> @@ -3519,7 +3519,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>       mod_sysfs_teardown(mod);
>>    coming_cleanup:
>>       mod->state = MODULE_STATE_GOING;
>> -    destroy_params(mod->kp, mod->num_kp);
>> +    module_destroy_params(mod->kp, mod->num_kp);
>>       blocking_notifier_call_chain(&module_notify_list,
>>                        MODULE_STATE_GOING, mod);
>>       klp_module_going(mod);
>> diff --git a/kernel/params.c b/kernel/params.c
>> index 7188a12dbe86..1a436c9d6140 100644
>> --- a/kernel/params.c
>> +++ b/kernel/params.c
>> @@ -745,15 +745,6 @@ void module_param_sysfs_remove(struct module *mod)
>>   }
>>   #endif
>>   -void destroy_params(const struct kernel_param *params, unsigned num)
>> -{
>> -    unsigned int i;
>> -
>> -    for (i = 0; i < num; i++)
>> -        if (params[i].ops->free)
>> -            params[i].ops->free(params[i].arg);
>> -}
>> -
>>   struct module_kobject * __init_or_module
>>   lookup_or_create_module_kobject(const char *name)
>>   {
>> @@ -985,3 +976,21 @@ static int __init param_sysfs_builtin_init(void)
>>   late_initcall(param_sysfs_builtin_init);
>>     #endif /* CONFIG_SYSFS */
>> +
>> +#ifdef CONFIG_MODULES
>> +
>> +/*
>> + * module_destroy_params - free all parameters for one module
>> + * @params: module parameters (array)
>> + * @num: number of module parameters
>> + */
>> +void module_destroy_params(const struct kernel_param *params, unsigned num)
> 
> num has no type
> 
>> +{
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < num; i++)
>> +        if (params[i].ops->free)
>> +            params[i].ops->free(params[i].arg);
>> +}
>> +
>> +#endif /* CONFIG_MODULES */
>>
>> base-commit: c107785c7e8dbabd1c18301a1c362544b5786282
> 
> Note, checkpatch reports the same:
> 
> CHECK: extern prototypes should be avoided in .h files
> #47: FILE: include/linux/moduleparam.h:430:
> +extern void module_destroy_params(const struct kernel_param *params,
> 
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> #48: FILE: include/linux/moduleparam.h:431:
> +                  unsigned num);
> 
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> #107: FILE: kernel/params.c:987:
> +void module_destroy_params(const struct kernel_param *params, unsigned num)
> 
> total: 0 errors, 2 warnings, 1 checks, 70 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> Commit 4aad08ba007a ("module: Fix freeing of charp module parameters when CONFIG_SYSFS=n") has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.

I intentionally kept the `extern` keyword and the `unsigned` parameter
to maintain consistency with the surrounding style in moduleparam.h.
I'll send a v2 to correct this in my patch. Additionally, I can include
cleanup patches for moduleparam.h to remove the unnecessary `extern` and
change `unsigned` to `unsigned int` in other occurrences, so the content
of the file remains consistent in this regard.

-- 
Thanks,
Petr
