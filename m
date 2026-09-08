Received: from mta0.migadu.com (out-131.mta0.migadu.com [91.218.175.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EDA38655E
	for <linux-modules@vger.kernel.org>; Tue,  8 Sep 2026 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849557; cv=none; b=JD4q/ujJdQ/ecUMKkc650/DriupTsauBULv97I1GhdroAnsvhRlEJmelUTwLraw/XzUSRdXMc2MlKLiBjyUOjG0QsBvngdIw/C7IpIiFTGd/2FcylzvJkA9MC5H1UHght8j/Yev++5E9x8guWt8kP/kMl2FNL/RBBeholbtHWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849557; c=relaxed/simple;
	bh=wFZJjvwExLoI0CbQJDLkjMr6gJvYCN6ii8ItZkDOIr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0mosq55UURB44A9iNew1wnH+W34YQ0c2CmvEehlCC8ZgCUpBKoN+h04udK96hJjPFSgPAFlMN2gZ9hGp8zB4ChfwsmB31xYuE9pWI5v53CSobV3x+JsnTtGn8/R9AY2MNhVDjRMUIbTUau1Z4kVR0aXpb7K50LuKU7VatTN3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s3YtOmvx; arc=none smtp.client-ip=91.218.175.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s3YtOmvx"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wFZJjvwExLoI0CbQJDLkjMr6gJvYCN6ii8ItZkDOIr4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788849551; v=1; x=1789454351;
 b=s3YtOmvxisorxzP8LW1Byk3b7X3a20V3JiyYiqbB7LrGeWJjYOPi1cR+cZ95VAPqNsr2RyRD
 NF1id0PbpDaOLttPuAR0NJUA9Vh1U4PuyScTtPGO2prLTZHUTOVpBkNno+HrytR767ontEYlbnZ
 WWKVBAIW1U6z+0mww/s+9NPg=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 304a22148e1ed007;
	Tue, 08 Sep 2026 06:39:11 +0000
X-Mizu-Trace-ID: 304a22148e1ed007
X-Migadu-Flow: FLOW_OUT
Message-ID: <6a9e1d1e-ca90-4ef4-8099-95cfb3dae87e@linux.dev>
Date: Tue, 8 Sep 2026 14:39:58 +0800
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
 <100a9358-1c7b-4f08-a5d2-072362aea492@linux.dev>
 <534b9178-068f-4808-8ed3-e989dee2be0f@suse.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <534b9178-068f-4808-8ed3-e989dee2be0f@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Petr


On 2026/9/7 20:17, Petr Pavlu wrote:
> On 9/7/26 8:10 AM, Hao Ge wrote:
>> Hi Petr
>>
>> On 2026/9/4 23:25, Petr Pavlu wrote:
>>> On 9/3/26 8:00 AM, Hao Ge wrote:
>>>> Hi Petr and Suren
>>>>
>>>> On 2026/9/2 16:33, sashiko-bot@kernel.org wrote:
>>>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>>> - [Medium] The `.data..percpu` section is incorrectly exported in sysfs with a dangling pointer to a freed temporary buffer.
>>>>> --
>>>>>
>>>>> commit 5082dc654c1b8850af405eef473b249c0d936de9
>>>>> Author: Hao Ge <hao.ge@linux.dev>
>>>>>
>>>>> module: introduce SH_ENTSIZE_STANDALONE for separately allocated sections
>>>>>
>>>>> This commit introduces a new marker, SH_ENTSIZE_STANDALONE, to indicate
>>>>> sections with a separate allocation. Instead of clearing the SHF_ALLOC
>>>>> flag, it utilizes sh_entsize so that sections with separate allocations
>>>>> like the percpu section can be correctly skipped during layout.
>>>>>
>>>>> Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/
>>>>>
>>>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>>>> index d0e1e0bd2ad06..b114b815187a9 100644
>>>>>> --- a/kernel/module/main.c
>>>>>> +++ b/kernel/module/main.c
>>>>> [ ... ]
>>>>>> @@ -2822,7 +2810,8 @@ static int move_module(struct module *mod, struct load_info *info)
>>>>>>  		Elf_Shdr *shdr = &info->sechdrs[i];
>>>>>>  		const char *sname;
>>>>>>  
>>>>>> -		if (!(shdr->sh_flags & SHF_ALLOC))
>>>>>> +		if (!(shdr->sh_flags & SHF_ALLOC)
>>>>>> +		    || shdr->sh_entsize == SH_ENTSIZE_STANDALONE)
>>>>>>  			continue;
>>>>>>  
>>>>>>  		sname = info->secstrings + shdr->sh_name;
>>>>> [ ... ]
>>>>>> @@ -2967,8 +2957,13 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>>>>>>  	if (err < 0)
>>>>>>  		return ERR_PTR(err);
>>>>>>  
>>>>>> +	/* Repurpose sh_entsize to track where each section is allocated. */
>>>>>> +	for (i = 0; i < info->hdr->e_shnum; i++)
>>>>>> +		info->sechdrs[i].sh_entsize = ~0UL;
>>>>>> +
>>>>>>  	/* We will do a special allocation for per-cpu sections later. */
>>>>>> -	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
>>>>>> +	if (info->index.pcpu)
>>>>>> +		info->sechdrs[info->index.pcpu].sh_entsize = SH_ENTSIZE_STANDALONE;
>>>>>>  
>>>>>>  	/*
>>>>>>  	 * Mark relevant sections as SHF_RO_AFTER_INIT so layout_sections() can
>>>>>
>>>>> [Severity: Medium]
>>>>> Because SHF_ALLOC is no longer cleared here, does this cause the
>>>>> .data..percpu section to be incorrectly exported via sysfs?
>>>>>
>>>>> With SHF_ALLOC remaining intact, sect_empty() in kernel/module/sysfs.c now
>>>>> returns false for the percpu section, causing it to be processed instead of
>>>>> skipped.
>>>>>
>>>>> Additionally, because move_module() explicitly skips sections marked with
>>>>> SH_ENTSIZE_STANDALONE, the sh_addr is never updated to the final allocated
>>>>> memory.
>>>>>
>>>>> This means when add_sect_attrs() exports the section:
>>>>>
>>>>> kernel/module/sysfs.c:add_sect_attrs() {
>>>>>     ...
>>>>> 	if (sect_empty(sec))
>>>>> 		continue;
>>>>>     ...
>>>>> 	sattr->private = (void *)sec->sh_addr;
>>>>>     ...
>>>>> }
>>>>>
>>>>> Will sattr->private end up storing an unmodified sh_addr pointing to the
>>>>> freed temporary load_info buffer (info->hdr)?
>>>>>
>>>>> This appears to leak a stale vmalloc pointer address to userspace when
>>>>> reading the sysfs file for the section.
>>>>>
>>>> Yes, Sashiko is correct. The fix is just one line after percpu_modcopy():
>>>>
>>>> info->sechdrs[info->index.pcpu].sh_addr = (unsigned long)mod_percpu(mod); 
>>>
>>> mod_percpu() (mod->percpu) isn't really the execution address of the
>>> .data..percpu section. That section in the ELF file is only a template
>>> to initialize the individual per-CPU variable areas.
>>>
>>
>> Yes, I used mod_percpu() to stay consistent with /proc/kallsyms.
> 
> That's a good point. /proc/kallsyms directly shows the st_value of each
> symbol. For per-CPU symbols in modules, that is mod->percpu+offset.
> I wonder whether it possible to make any use of such an address unless
> one also knows the per_cpu_offset() mapping.
> 

Right. Without the mapping it is not dereferenceable. bpftrace passes
the kallsyms value to bpf_per_cpu_ptr(), which does the addition in 
the kernel. I would expect most tools do the same (crash, for
example).

> However, maybe it is really simpler not to export .data..percpu under
> /sys/module/*/sections/, rather than trying to determine what address it
> should provide.
> 
OK, I will keep it hidden for now. We can revisit it some day if a
real need for the entry ever comes up.

Thanks
Best Regards
Hao
