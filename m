Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13C17A2E1
	for <linux-modules@vger.kernel.org>; Tue, 26 Aug 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192853; cv=none; b=NaQTMC9oR1oZm2w4h7wM22ho4tCOszd7RJeWj2t/G+85pZ/smYVsJAuV154/bq690EdoXeRfee/vAThGXGLHnPFH7Hdwa3KNjKpnKxOGJ/c1mt2+KzjmbQ547jGtpmGoou5m/jSSBMgc51oAQTz+uir+LF+KBausJtrkdwi5skk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192853; c=relaxed/simple;
	bh=2XV70DXtRdeJWRvqev7Ho1XUXSVdy0EAT46IxziZtG4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=twXlNZujF4o1JgsTiiyk9FP07QOuCLic42RUHPvG+NTICEK6QQEG8JsCNnFHoxUQLtn1yaoh8DdM9R9/N7uADXGLcolGx74RGkakRScbtWdqsg0vNSjpY8JV/MRCgk7TG3Ni7kQ+BhnMCt5prANND2mXwrQPX5KLk++skdq0VpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DfmWPm+w; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DfmWPm+w"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so43001455e9.3
        for <linux-modules@vger.kernel.org>; Tue, 26 Aug 2025 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756192849; x=1756797649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8j7H5uRNRVfpr2RoLmazQJDGtG67y63v9eTivt5LDZY=;
        b=DfmWPm+wp4okXvf5vxSnOKoPptQTT7m48snxn6KoGilQ6PY7e/LTI9/sib56B/0Uz8
         Y6nvtLepIEUd6N7FxMP2Uk4IegOnDROxIAQqKZtEsqLbL56MFF/i2Ny1xFXYm7CS7nfh
         ZXmie84JMuSBh+gSGmxkOnWS+PN1b44ZA+CeAOMel+YAUDpgbJEA9xPiNpOGZBAAoAaZ
         3YbaFw/dR32FsXVLmphe4Vt0SDGTPNz+vijcu0E2eYuLsmiwr+Pi5lfS4OVtoVnvYsfz
         HMBsHHOslC0qqZhWrVV0XMxmXeFqFL6TbAkIIA7KxAxChtvjfPvlMbZ6D5uW/vuvVLtb
         vYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192849; x=1756797649;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8j7H5uRNRVfpr2RoLmazQJDGtG67y63v9eTivt5LDZY=;
        b=AJSGfIWb9n1RRbFJlh0sGo60klyQ8x+usjBKr+p+B9R6qu/SZ4VLcvnYhPOdc8FsjC
         m4FdNOc2xSQLSIBY2FnjqUvgfKG+cajt+zdqrn7BnCukUl3fFkuqvxol0QJUZJv0E3me
         53TLv6/d6wSMBgLpXpN+ro4zydY3Lwxje6U/Csr1AZkEVWmaEN7VrmV2MP4M6kD7R+Yd
         tNxx7wNt8eKfYgCf+rcUg+tws8riyP8rGjN+KV70TkcV2yQ+VijmG4+T16cuuSayWb0k
         ykXBC+lnkDrFedCmMU8c1JSVJ8dLe6JLYAQl/Uw0s8dkkHYSZT+V8FBDuiGDnmn+ONMa
         lfDg==
X-Forwarded-Encrypted: i=1; AJvYcCX+X9bTWLvGNCBNWMTGZwmjcWCk40DoI6iXuDL1ONewJXIaRj253SYfLeYz+eECekNq4Y8BOxfPpjBP/IQu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd4gOlJpJnIBXpR5yt+BoQmQtg+43vqA7Sevi1Kgk1K2sA9lQ2
	GM2InZSAROBnmfKc44cUKljY6Eephdpy6IQKHPFDzJdSSdTz9iRIJOMCSaqTw0plbuk=
X-Gm-Gg: ASbGncuuSGFRF50OceWRbgB4ouMpNvBdMsjKxoQ2umdp0J2H+kbwz48oY74isljg27h
	/aGf9blmYogUfpAfiKO0d/p+E1/f6ljEQViaQy3PglG8yNfSmqJsM3o/b0FJcWnhYNklTDwUoXp
	L2vIUX8J+JcGJG6hAkcG+jQxv1cQbhc5+iHQSaarcexvVbtp4pcUJeCjtULu5NqC8K5kxx0aMAu
	9Ha5f19iJ8S7fWWKB+JXjb6udE2UnAtf78OTxARg4qPzEH5vNq2w1QcIS3b5XPzcIxEBj9iV/y7
	17qjsqGAukwoVZ/AgifHoS+Nc6jPdcnptplcZnE7ZmIAflQgvR6rMj8TWIIqeJetjGk2urXf+iQ
	COjnIjCMD/2ST5V6RAM/VLKyZyWA9Fx4oNX8eiinuPmxP1/phmAx+oQ==
X-Google-Smtp-Source: AGHT+IEa8dUQPJuzo3X6St5/O4QRfPzFlsks4e4xA+PtVoaCLFcUQM8IWKdpWzS3yndvGn5+bjb7MQ==
X-Received: by 2002:a05:6000:18ab:b0:3ca:921:7e95 with SMTP id ffacd0b85a97d-3ca09218308mr3344756f8f.49.1756192848692;
        Tue, 26 Aug 2025 00:20:48 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8b4b98sm8384889a12.19.2025.08.26.00.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 00:20:48 -0700 (PDT)
Message-ID: <80d7313a-0f0c-494d-b2ad-2662d1992b2b@suse.com>
Date: Tue, 26 Aug 2025 09:20:41 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: pr_debug when there is no version info
From: Petr Pavlu <petr.pavlu@suse.com>
To: Wang Jinchao <wangjinchao600@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20250721045224.391745-1-wangjinchao600@gmail.com>
 <3992b57d-3d8b-4d60-bc4a-f227f712dcca@suse.com>
 <86062810-ff6b-4181-83b7-dfe443ff4012@gmail.com>
 <9b768f91-121a-4072-88b2-36cb48be3917@suse.com>
Content-Language: en-US
In-Reply-To: <9b768f91-121a-4072-88b2-36cb48be3917@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 10:25 AM, Petr Pavlu wrote:
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
>>>>   kernel/module/version.c | 4 +++-
>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/module/version.c b/kernel/module/version.c
>>>> index 2beefeba82d9..bc28c697ff3a 100644
>>>> --- a/kernel/module/version.c
>>>> +++ b/kernel/module/version.c
>>>> @@ -42,8 +42,10 @@ int check_version(const struct load_info *info,
>>>>       }
>>>>         /* No versions at all?  modprobe --force does this. */
>>>> -    if (versindex == 0)
>>>> +    if (versindex == 0) {
>>>> +        pr_debug("No version info for module %s\n", info->name);
>>>>           return try_to_force_load(mod, symname) == 0;
>>>> +    }
>>>>         versions = (void *)sechdrs[versindex].sh_addr;
>>>>       num_versions = sechdrs[versindex].sh_size
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
>>>       add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
>>>       return 0;
>>>   #else
>>> +    pr_err("%s: %s\n", mod->name, reason);
>>>       return -ENOEXEC;
>>>   #endif
>>>   }
>>> diff --git a/kernel/module/version.c b/kernel/module/version.c
>>> index 2beefeba82d9..4d9ebf0834de 100644
>>> --- a/kernel/module/version.c
>>> +++ b/kernel/module/version.c
>>> @@ -41,9 +41,9 @@ int check_version(const struct load_info *info,
>>>           return 1;
>>>       }
>>>   -    /* No versions at all?  modprobe --force does this. */
>>> +    /* No versions? Ok, already tainted in check_modstruct_version(). */
>>>       if (versindex == 0)
>>> -        return try_to_force_load(mod, symname) == 0;
>>> +        return 1;
>>>         versions = (void *)sechdrs[versindex].sh_addr;
>>>       num_versions = sechdrs[versindex].sh_size
>>> @@ -90,6 +90,11 @@ int check_modstruct_version(const struct load_info *info,
>>>           have_symbol = find_symbol(&fsa);
>>>       BUG_ON(!have_symbol);
>>>   +    /* No versions at all?  modprobe --force does this. */
>>> +    if (!info->index.vers && !info->index.vers_ext_crc)
>>> +        return try_to_force_load(
>>> +                   mod, "no versions for imported symbols") == 0;
>>> +
>>>       return check_version(info, "module_layout", mod, fsa.crc);
>>>   }
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

To answer my own confusion, the thing that I missed is that the
MODULE_INIT_IGNORE_* flags are available only for the finit_module
syscall, not for init_module. In the case of init_module, the force
logic is handled by kmod in userspace by stripping the relevant
modversions and vermagic data. This means that when using init_module,
the module loader cannot distinguish between a module that lacks this
data and one that has it deliberately removed. When finit_module was
introduced in 2012, commit 2f3238aebedb ("module: add flags arg to
sys_finit_module()") added the MODULE_INIT_IGNORE_* flags, and they were
simply implemented to mirror the kmod behavior.

-- Petr
