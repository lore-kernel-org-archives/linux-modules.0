Received: from mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37951370D57
	for <linux-modules@vger.kernel.org>; Thu,  3 Sep 2026 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415190; cv=none; b=GtDC+5QF0AnToPVAN0C9JJ2oJ8w2d/g2dk7PHBg3zzU3uT0Ce9q2oDzGRRwAiH7O04xfGLkzuBJeYabaHQS/qXZL+xSyIkQ+2yLgFIHlobklaRX+i0fSaiDXrmTX6be6F4tQjrHVbBuTon3ZEiqd/wDXvRNu7pzILT+F1fZK+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415190; c=relaxed/simple;
	bh=9SuhweMKbBbiKyBYe3uZh3Jrb7lY6yWhwscAgm2/kQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnX4pTVdgzt59y5BPdtnti60k5yeIzSnR46XfC7vOB0NfqX+KPitfzngfAbWB5D4A727uULGXzh0eAj55r92+aypfW3Fgn+LcZUy5IOXC7yeJ+vJNCmdxEzwX0pGdv191Lwt51uIb/9S8qQ+kAdftAgID6GuJkHB0cDWryGHbfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VAmTDlTg; arc=none smtp.client-ip=95.215.58.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VAmTDlTg"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9SuhweMKbBbiKyBYe3uZh3Jrb7lY6yWhwscAgm2/kQM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788415183; v=1; x=1789019983;
 b=VAmTDlTgEdXX7LbdSSWpAlhbVg/Y7lx8oOpM6HbzoA93fDkhsk6c19cosFsym8oAwqbDEwcn
 SQkoKceA/Ye8igHmxC08VFmDfW7IifFS/hkGKKf6BXwNbYFc/xYfCs4J9WVK06aOwRrfI0MyrSa
 9l04VJtQMoThySYHfx7Ahdlg=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eaf1e0343e8d7019;
	Thu, 03 Sep 2026 05:59:43 +0000
X-Mizu-Trace-ID: eaf1e0343e8d7019
X-Migadu-Flow: FLOW_OUT
Message-ID: <cf829450-497f-4456-b229-3387fa24b177@linux.dev>
Date: Thu, 3 Sep 2026 14:00:34 +0800
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
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20260902083338.706451F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Petr and Suren

On 2026/9/2 16:33, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `.data..percpu` section is incorrectly exported in sysfs with a dangling pointer to a freed temporary buffer.
> --
> 
> commit 5082dc654c1b8850af405eef473b249c0d936de9
> Author: Hao Ge <hao.ge@linux.dev>
> 
> module: introduce SH_ENTSIZE_STANDALONE for separately allocated sections
> 
> This commit introduces a new marker, SH_ENTSIZE_STANDALONE, to indicate
> sections with a separate allocation. Instead of clearing the SHF_ALLOC
> flag, it utilizes sh_entsize so that sections with separate allocations
> like the percpu section can be correctly skipped during layout.
> 
> Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/
> 
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index d0e1e0bd2ad06..b114b815187a9 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
> [ ... ]
>> @@ -2822,7 +2810,8 @@ static int move_module(struct module *mod, struct load_info *info)
>>  		Elf_Shdr *shdr = &info->sechdrs[i];
>>  		const char *sname;
>>  
>> -		if (!(shdr->sh_flags & SHF_ALLOC))
>> +		if (!(shdr->sh_flags & SHF_ALLOC)
>> +		    || shdr->sh_entsize == SH_ENTSIZE_STANDALONE)
>>  			continue;
>>  
>>  		sname = info->secstrings + shdr->sh_name;
> [ ... ]
>> @@ -2967,8 +2957,13 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>>  	if (err < 0)
>>  		return ERR_PTR(err);
>>  
>> +	/* Repurpose sh_entsize to track where each section is allocated. */
>> +	for (i = 0; i < info->hdr->e_shnum; i++)
>> +		info->sechdrs[i].sh_entsize = ~0UL;
>> +
>>  	/* We will do a special allocation for per-cpu sections later. */
>> -	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
>> +	if (info->index.pcpu)
>> +		info->sechdrs[info->index.pcpu].sh_entsize = SH_ENTSIZE_STANDALONE;
>>  
>>  	/*
>>  	 * Mark relevant sections as SHF_RO_AFTER_INIT so layout_sections() can
> 
> [Severity: Medium]
> Because SHF_ALLOC is no longer cleared here, does this cause the
> .data..percpu section to be incorrectly exported via sysfs?
> 
> With SHF_ALLOC remaining intact, sect_empty() in kernel/module/sysfs.c now
> returns false for the percpu section, causing it to be processed instead of
> skipped.
> 
> Additionally, because move_module() explicitly skips sections marked with
> SH_ENTSIZE_STANDALONE, the sh_addr is never updated to the final allocated
> memory.
> 
> This means when add_sect_attrs() exports the section:
> 
> kernel/module/sysfs.c:add_sect_attrs() {
>     ...
> 	if (sect_empty(sec))
> 		continue;
>     ...
> 	sattr->private = (void *)sec->sh_addr;
>     ...
> }
> 
> Will sattr->private end up storing an unmodified sh_addr pointing to the
> freed temporary load_info buffer (info->hdr)?
> 
> This appears to leak a stale vmalloc pointer address to userspace when
> reading the sysfs file for the section.
> 
Yes, Sashiko is correct. The fix is just one line after percpu_modcopy():

info->sechdrs[info->index.pcpu].sh_addr = (unsigned long)mod_percpu(mod); 

But .data..percpu will show up in /sys/module/*/sections/, it was never
exported before. Stable will get this too via backport, since later fixes
depend on it.

Could you please advise on the preferred way forward?

Thanks
Best Regards
Hao


