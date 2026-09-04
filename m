Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37A3CF673
	for <linux-modules@vger.kernel.org>; Fri,  4 Sep 2026 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535559; cv=none; b=NW1QfLUJEtSffSxIJZf02MpcnCKbCsS2DUuLIT/rtbZyVSavmj5dlmUXOSUGAhrLA8Jl64sgVKXbAb6SMbFzRORSqh2iag5/Do4rgaiH16RB4rRcEcEDCpT7BCdcCHRfJT4iFXkDPLicCluZWZmq8RXqU2fCYhjLJGJ/VhSejq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535559; c=relaxed/simple;
	bh=0S/yDNSpy1oapOifaOSGHp+n9FA0u06NrTnF2HapZAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TF7+4BV+E0I580vgndD+eusUGrDfmQgc5U1WpwzKE8aih3bGucJjX8vPQzuNCpP3aVSHAfwUiMIezLZdno9EMu6yTIRuM2o2SebEabfHaO/D9GeZmasZAa5vA20Dm7lLfneSJGqZxreX+uiFddr+bkkBkZjge9IcZWT7OeutyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M7wrJr4X; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M7wrJr4X"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495590dde14so15913345e9.0
        for <linux-modules@vger.kernel.org>; Fri, 04 Sep 2026 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788535555; x=1789140355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RS03LLsyhG6wvyFekNOmy/GaO/oQnMp4qgvy/SOaFgQ=;
        b=M7wrJr4XMts91y7gxaxzIGJVxlwxiawrhF9MPVpw1GCyHruyaj7tSMrMk1ISEg3V86
         I7po47TOn/Oe35vuzBKbCi8PBze37ugqOT1SX3FdfrpIXiOdFG1W6L1bLec5efoJ8+vf
         +4oX+q5aoxUtyiu85Ql+bkeCB2r3mOGurdjs6ptrFBR68oSLWQhpOGv0dxbYp+gDS7nS
         nVuSo3By7iZGDboqD0PrPHk/TnoyKWpAYC62rWYW7btFPdMpuuoK/dfLCwGcegRKr61J
         UIV1Gxe7w/onel5CdBkGs8hL2bsI/lsPpFS39nwfd/vK0NxCd0Rj+v0qRT1JIyVUNucU
         UKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535555; x=1789140355;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RS03LLsyhG6wvyFekNOmy/GaO/oQnMp4qgvy/SOaFgQ=;
        b=d0pJ2eXJSSA53xFNpWf1kN7CxsT9VZq4Wsanlewyr+V+MElhnRf4wKKqnd32Q8YZj4
         rdtYY20xu84cfHroYM/aVqAKMpfd/RPlQrUzkSssPBeiWmWnsO1i8cmFk5i6uGrxxLNY
         hLIE/RO4GQnfN+gXyAt3D/g6ESag+oJ8C9TRedOAkeIKCorL5lwReCzMljFNnQTvK0Ou
         aIU+S0rUhib8QV5F6T4VBwn8bikFFyFIbbvM+bkQjCcOfY2GETaf0fog0TNicsgqDHJ8
         EBRqYzTDqnzPOEL22FkchCAqQHSI56RVjNHO633PsvFulmIiE32v8xfdCcjorfoFyQKr
         x5zQ==
X-Gm-Message-State: AFuF++mJDwW2b6y7cZCk+ETCgcr2C4IsiJrhKCQWPz0X9epDULqSVCcI
	igJXfsWyHqEXZG71bTyMo1x2EaotscGO6W71mppq6etldqulaKewv1qeDmB+G4b0mw0=
X-Gm-Gg: AYBFou1QPokTjiT3eW0pdox1clgii7l9K/sT2uaFeMqHJIeXhy13nxYTPCgS1XB8utM
	VNq2Lgpk+T8wedYY9ZPs4MvCPBe5VJK21vQmZdHaydnYkOg0rytpz1A0vNt1hQL85zIHdl+BnRZ
	KKW/gBnU/UHsKxGcpMX2CVzOn9S46moh7m+s69jTG2fnVDjax0GOBrlET+5fSr+6GyZyGUWaA8H
	OEWbD0pGFGQPRtD1+L4HpeZFVR3FplD9OX+ocguv/Us4HxaaxWp6nPKSte+fuMkilUtFb++Qvbf
	ltobHOgUdHvXXTP1UHyROoTfeAbQ2IliBn987X4tdu5FSQ/V6PXH+/W1cJO7RMOueON/JO7blZf
	Ac0xtSBDqg0fPnxG8x+UVNXuQ7pMZPI6q8ZCMXsxsFNCjHMMZ/S+E7M0ui12l7nRcfV41G68UVc
	/YM7U/SKVJzOCJ+VmPBtD36BkUqT64M1VQkCoWHFiMnAHm3oHic2fR6o1rIgQaCqiEqkxZCHPuK
	2JVysgtwdg5l9Nc10ecQFt0
X-Received: by 2002:a05:600c:860b:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49cf7fe62e9mr129919575e9.1.1788535555177;
        Fri, 04 Sep 2026 08:25:55 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf5135353sm87945265e9.2.2026.09.04.08.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:25:54 -0700 (PDT)
Message-ID: <48658d4c-4920-40ba-afbf-65400dffc863@suse.com>
Date: Fri, 4 Sep 2026 17:25:54 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] module: introduce SH_ENTSIZE_STANDALONE for
 separately allocated sections
To: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-modules@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Sashiko <sashiko-bot@kernel.org>
References: <20260902081802.146145-1-hao.ge@linux.dev>
 <20260902081802.146145-3-hao.ge@linux.dev>
 <20260902083338.706451F000E9@smtp.kernel.org>
 <cf829450-497f-4456-b229-3387fa24b177@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <cf829450-497f-4456-b229-3387fa24b177@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 8:00 AM, Hao Ge wrote:
> Hi Petr and Suren
> 
> On 2026/9/2 16:33, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] The `.data..percpu` section is incorrectly exported in sysfs with a dangling pointer to a freed temporary buffer.
>> --
>>
>> commit 5082dc654c1b8850af405eef473b249c0d936de9
>> Author: Hao Ge <hao.ge@linux.dev>
>>
>> module: introduce SH_ENTSIZE_STANDALONE for separately allocated sections
>>
>> This commit introduces a new marker, SH_ENTSIZE_STANDALONE, to indicate
>> sections with a separate allocation. Instead of clearing the SHF_ALLOC
>> flag, it utilizes sh_entsize so that sections with separate allocations
>> like the percpu section can be correctly skipped during layout.
>>
>> Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/
>>
>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>> index d0e1e0bd2ad06..b114b815187a9 100644
>>> --- a/kernel/module/main.c
>>> +++ b/kernel/module/main.c
>> [ ... ]
>>> @@ -2822,7 +2810,8 @@ static int move_module(struct module *mod, struct load_info *info)
>>>  		Elf_Shdr *shdr = &info->sechdrs[i];
>>>  		const char *sname;
>>>  
>>> -		if (!(shdr->sh_flags & SHF_ALLOC))
>>> +		if (!(shdr->sh_flags & SHF_ALLOC)
>>> +		    || shdr->sh_entsize == SH_ENTSIZE_STANDALONE)
>>>  			continue;
>>>  
>>>  		sname = info->secstrings + shdr->sh_name;
>> [ ... ]
>>> @@ -2967,8 +2957,13 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>>>  	if (err < 0)
>>>  		return ERR_PTR(err);
>>>  
>>> +	/* Repurpose sh_entsize to track where each section is allocated. */
>>> +	for (i = 0; i < info->hdr->e_shnum; i++)
>>> +		info->sechdrs[i].sh_entsize = ~0UL;
>>> +
>>>  	/* We will do a special allocation for per-cpu sections later. */
>>> -	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
>>> +	if (info->index.pcpu)
>>> +		info->sechdrs[info->index.pcpu].sh_entsize = SH_ENTSIZE_STANDALONE;
>>>  
>>>  	/*
>>>  	 * Mark relevant sections as SHF_RO_AFTER_INIT so layout_sections() can
>>
>> [Severity: Medium]
>> Because SHF_ALLOC is no longer cleared here, does this cause the
>> .data..percpu section to be incorrectly exported via sysfs?
>>
>> With SHF_ALLOC remaining intact, sect_empty() in kernel/module/sysfs.c now
>> returns false for the percpu section, causing it to be processed instead of
>> skipped.
>>
>> Additionally, because move_module() explicitly skips sections marked with
>> SH_ENTSIZE_STANDALONE, the sh_addr is never updated to the final allocated
>> memory.
>>
>> This means when add_sect_attrs() exports the section:
>>
>> kernel/module/sysfs.c:add_sect_attrs() {
>>     ...
>> 	if (sect_empty(sec))
>> 		continue;
>>     ...
>> 	sattr->private = (void *)sec->sh_addr;
>>     ...
>> }
>>
>> Will sattr->private end up storing an unmodified sh_addr pointing to the
>> freed temporary load_info buffer (info->hdr)?
>>
>> This appears to leak a stale vmalloc pointer address to userspace when
>> reading the sysfs file for the section.
>>
> Yes, Sashiko is correct. The fix is just one line after percpu_modcopy():
> 
> info->sechdrs[info->index.pcpu].sh_addr = (unsigned long)mod_percpu(mod); 

mod_percpu() (mod->percpu) isn't really the execution address of the
.data..percpu section. That section in the ELF file is only a template
to initialize the individual per-CPU variable areas.

I think the two options are:

1) Do not export the section under /sys/module/*/sections/.
2) Treat the boot CPU area as the canonical location of
   .data..percpu. In other words, do:
   info->sechdrs[info->index.pcpu].sh_addr = (unsigned long)per_cpu_ptr(mod->percpu, get_boot_cpu_id());

The /sys/module/*/sections/ interface is intended for debugging. From
that perspective, exposing the .data..percpu address for the boot CPU
may be useful and seems fairly reasonable to me. On the other hand, one
could argue that this can cause confusion, since a loaded module has
multiple .data..percpu instances.

I don't see a strong argument for either option, but I would lean toward
the second.

> But .data..percpu will show up in /sys/module/*/sections/, it was never
> exported before. Stable will get this too via backport, since later fixes
> depend on it.

I think exposing .data..percpu under /sys/module/*/sections/ is a minor
change and is fine for stable. As mentioned, /sys/module/*/sections/ is
a debugging interface. Additionally, most uses of per-CPU variables are
in the core kernel, with only a handful modules defining per-CPU data.
On my system, 30 modules out of 5383 contain a .data..percpu section.

-- 
Thanks,
Petr
