Received: from mta0.migadu.com (out-69.mta0.migadu.com [91.218.175.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038C636D51B
	for <linux-modules@vger.kernel.org>; Mon,  7 Sep 2026 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761368; cv=none; b=Ynltgi9LgsqcgR/dtZOSAypKUYLQRZAs9/N4hjYUMWfSVg/duO7orVnpIC6VFYLcjdgZ0Obq4vohu76+eCnRXdKO1D1SlAm0npQHBEnDYdEoiS1hVItrpvb1SXXHHrys3BZYe6+KBhWdMnaCtTxXXJLap7VJZUJ4E9c2s5/XOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761368; c=relaxed/simple;
	bh=VnpEvvYENPmY6CkdRz6pSC8Z6BLnppVZRvdo1TXNVwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNe0umuY1teOm9HvK0jOrJ/6Y5H+PnT2KvUylQx+yEofGGlc5In9DJSKqxHfEVOVilU6M8n/aO97hqUJsPGSQyXEnYVfvgiu6y7rRBayKDvGKuq5onz0o8ZfWDQ6b/8h0PHyIo1YvzBrIFi2s3XvV4yRHifXyq5diI5l81ZRriM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l0QrtUGN; arc=none smtp.client-ip=91.218.175.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l0QrtUGN"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VnpEvvYENPmY6CkdRz6pSC8Z6BLnppVZRvdo1TXNVwg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788761363; v=1; x=1789366163;
 b=l0QrtUGNCGdnE5hlQkKC96xQUxcYlf3rVFaWWa2HqWrjSefPOUfrZNwGdOquHpnD+BKmUe4e
 p44jythtWujsvCDX0XWG5ujtRkCN5+2MIQbjWxFlFmUeelxkCcTt3dk2XIwz0LBIwRMEuBHo7Yy
 yLQL43IkGSL3wbN18zQwgdLk=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f93e350a5d8b16f5;
	Mon, 07 Sep 2026 06:09:23 +0000
X-Mizu-Trace-ID: f93e350a5d8b16f5
X-Migadu-Flow: FLOW_OUT
Message-ID: <100a9358-1c7b-4f08-a5d2-072362aea492@linux.dev>
Date: Mon, 7 Sep 2026 14:10:17 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] module: introduce SH_ENTSIZE_STANDALONE for
 separately allocated sections
To: Petr Pavlu <petr.pavlu@suse.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-modules@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Sashiko <sashiko-bot@kernel.org>
References: <20260902081802.146145-1-hao.ge@linux.dev>
 <20260902081802.146145-3-hao.ge@linux.dev>
 <20260902083338.706451F000E9@smtp.kernel.org>
 <cf829450-497f-4456-b229-3387fa24b177@linux.dev>
 <48658d4c-4920-40ba-afbf-65400dffc863@suse.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <48658d4c-4920-40ba-afbf-65400dffc863@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Petr

On 2026/9/4 23:25, Petr Pavlu wrote:
> On 9/3/26 8:00 AM, Hao Ge wrote:
>> Hi Petr and Suren
>>
>> On 2026/9/2 16:33, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>> - [Medium] The `.data..percpu` section is incorrectly exported in sysfs with a dangling pointer to a freed temporary buffer.
>>> --
>>>
>>> commit 5082dc654c1b8850af405eef473b249c0d936de9
>>> Author: Hao Ge <hao.ge@linux.dev>
>>>
>>> module: introduce SH_ENTSIZE_STANDALONE for separately allocated sections
>>>
>>> This commit introduces a new marker, SH_ENTSIZE_STANDALONE, to indicate
>>> sections with a separate allocation. Instead of clearing the SHF_ALLOC
>>> flag, it utilizes sh_entsize so that sections with separate allocations
>>> like the percpu section can be correctly skipped during layout.
>>>
>>> Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/
>>>
>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>> index d0e1e0bd2ad06..b114b815187a9 100644
>>>> --- a/kernel/module/main.c
>>>> +++ b/kernel/module/main.c
>>> [ ... ]
>>>> @@ -2822,7 +2810,8 @@ static int move_module(struct module *mod, struct load_info *info)
>>>>  		Elf_Shdr *shdr = &info->sechdrs[i];
>>>>  		const char *sname;
>>>>  
>>>> -		if (!(shdr->sh_flags & SHF_ALLOC))
>>>> +		if (!(shdr->sh_flags & SHF_ALLOC)
>>>> +		    || shdr->sh_entsize == SH_ENTSIZE_STANDALONE)
>>>>  			continue;
>>>>  
>>>>  		sname = info->secstrings + shdr->sh_name;
>>> [ ... ]
>>>> @@ -2967,8 +2957,13 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>>>>  	if (err < 0)
>>>>  		return ERR_PTR(err);
>>>>  
>>>> +	/* Repurpose sh_entsize to track where each section is allocated. */
>>>> +	for (i = 0; i < info->hdr->e_shnum; i++)
>>>> +		info->sechdrs[i].sh_entsize = ~0UL;
>>>> +
>>>>  	/* We will do a special allocation for per-cpu sections later. */
>>>> -	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
>>>> +	if (info->index.pcpu)
>>>> +		info->sechdrs[info->index.pcpu].sh_entsize = SH_ENTSIZE_STANDALONE;
>>>>  
>>>>  	/*
>>>>  	 * Mark relevant sections as SHF_RO_AFTER_INIT so layout_sections() can
>>>
>>> [Severity: Medium]
>>> Because SHF_ALLOC is no longer cleared here, does this cause the
>>> .data..percpu section to be incorrectly exported via sysfs?
>>>
>>> With SHF_ALLOC remaining intact, sect_empty() in kernel/module/sysfs.c now
>>> returns false for the percpu section, causing it to be processed instead of
>>> skipped.
>>>
>>> Additionally, because move_module() explicitly skips sections marked with
>>> SH_ENTSIZE_STANDALONE, the sh_addr is never updated to the final allocated
>>> memory.
>>>
>>> This means when add_sect_attrs() exports the section:
>>>
>>> kernel/module/sysfs.c:add_sect_attrs() {
>>>     ...
>>> 	if (sect_empty(sec))
>>> 		continue;
>>>     ...
>>> 	sattr->private = (void *)sec->sh_addr;
>>>     ...
>>> }
>>>
>>> Will sattr->private end up storing an unmodified sh_addr pointing to the
>>> freed temporary load_info buffer (info->hdr)?
>>>
>>> This appears to leak a stale vmalloc pointer address to userspace when
>>> reading the sysfs file for the section.
>>>
>> Yes, Sashiko is correct. The fix is just one line after percpu_modcopy():
>>
>> info->sechdrs[info->index.pcpu].sh_addr = (unsigned long)mod_percpu(mod); 
> 
> mod_percpu() (mod->percpu) isn't really the execution address of the
> .data..percpu section. That section in the ELF file is only a template
> to initialize the individual per-CPU variable areas.
>

Yes, I used mod_percpu() to stay consistent with /proc/kallsyms.

> I think the two options are:
> 
> 1) Do not export the section under /sys/module/*/sections/.
> 2) Treat the boot CPU area as the canonical location of
>    .data..percpu. In other words, do:
>    info->sechdrs[info->index.pcpu].sh_addr = (unsigned long)per_cpu_ptr(mod->percpu, get_boot_cpu_id());
> 
> The /sys/module/*/sections/ interface is intended for debugging. From
> that perspective, exposing the .data..percpu address for the boot CPU
> may be useful and seems fairly reasonable to me. On the other hand, one
> could argue that this can cause confusion, since a loaded module has
> multiple .data..percpu instances.
> 
> I don't see a strong argument for either option, but I would lean toward
> the second.
>

OK. I spent the morning looking for relevant specs, but found none.
Nor is this documented in Documentation/ABI/testing/sysfs-module.

https://elixir.bootlin.com/linux/v7.2.2/source/Documentation/ABI/testing/sysfs-module
https://elixir.bootlin.com/linux/v7.2.2/source/Documentation/ABI/stable/sysfs-module

But I've noticed similar usage in __is_module_percpu_address,
https://elixir.bootlin.com/linux/v7.2.2/source/kernel/module/main.c#L516

So I will first add documentation for this in Documentation/ABI/testing/sysfs-module.

>> But .data..percpu will show up in /sys/module/*/sections/, it was never
>> exported before. Stable will get this too via backport, since later fixes
>> depend on it.
> 
> I think exposing .data..percpu under /sys/module/*/sections/ is a minor
> change and is fine for stable. As mentioned, /sys/module/*/sections/ is
> a debugging interface. Additionally, most uses of per-CPU variables are
> in the core kernel, with only a handful modules defining per-CPU data.
> On my system, 30 modules out of 5383 contain a .data..percpu section.
> 

Agree.

Thanks for your help.

Best Regards
Hao
