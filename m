Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E483DD532
	for <linux-modules@vger.kernel.org>; Thu,  3 Sep 2026 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416236; cv=none; b=NJnYH0O3kRrpMjjeuSIw+RINuhEjjgBEA+wN6sE4e+GJSlZVrQgq634uvZfEZmgO6r8POh2EacZJcRTlOwzKYYIxgptO2GfIoiTj0FNuk5WFmdlphg6+RfQ9rMPrfwDfkqLYvlMp7Npwp+0mi6W2Yl3XLIDC6gakghBzsIz23pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416236; c=relaxed/simple;
	bh=jX0mW6/o2BWJjdYWWZ2M6FTwEcaLXwNknINYyAduUL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVJOXHaEIQKEbbBSsuMPX7C46WP/Vy2EpdDU/0gNwU9l5YDtg78EpTX0J0rUA16cnW15hh4Y6Hoo5JlrD71IWsNMH1pMEyLbiQnOjCGuk9F0yS1swv2qN4TNTUAAB71R/47sHQINTbb2gEZbXga+TwefWwhVFEZiUDGdjswZxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jHCvhcji; arc=none smtp.client-ip=91.218.175.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jHCvhcji"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jX0mW6/o2BWJjdYWWZ2M6FTwEcaLXwNknINYyAduUL4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788416230; v=1; x=1789021030;
 b=jHCvhcjiDMUoGh+EcATLJ5H9JGAf1l8Z0RUvyWwoqJ0vvCFve5QCGxlk8KSOz9vXqxw5M5Hp
 ypDxFis/MRNvupx7hauNO3IFsef3TqbYAnnguSNH3ZmGUqnUrzWLZ0pCd4VWr/6EEFK6lxegOhL
 sK4zuiAnkYv7Wla9NP/GGPaA=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8dfbcddb9c46c234;
	Thu, 03 Sep 2026 06:17:10 +0000
X-Mizu-Trace-ID: 8dfbcddb9c46c234
X-Migadu-Flow: FLOW_OUT
Message-ID: <920be24a-f8be-4388-b1bc-6bad0cfbb178@linux.dev>
Date: Thu, 3 Sep 2026 14:17:58 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] module: allocate codetag sections before the
 regular module layout
To: Sashiko <sashiko-bot@kernel.org>
Cc: linux-modules@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Pavlu <petr.pavlu@suse.com>
References: <20260902081802.146145-1-hao.ge@linux.dev>
 <20260902081802.146145-4-hao.ge@linux.dev>
 <20260902083652.2C3BD1F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20260902083652.2C3BD1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2026/9/2 16:36, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Per-CPU memory leak of module allocation tag counters on module unload when falling back to regular section allocation.
> - [Medium] Skipping memcpy for SHT_NOBITS codetag sections leaves them filled with uninitialized kernel memory.
> 
> Pre-existing issues:
> - [High] AB-BA deadlock between `/proc/allocinfo` file readers (`pde->in_use`) and module loading (`cttype->mod_lock`).
> --
> 
> commit 073ca6b0680c884f9d863cdcbd7d5db665a17c3b
> Author: Hao Ge <hao.ge@linux.dev>
> 
> module: allocate codetag sections before the regular module layout
> 
> Whether a codetag section goes to the codetag region is decided by
> layout_sections() and asked again in move_module(). A concurrent
> load can shut profiling down in between, and move_module() then
> copies the section to offset 0 of its regular destination,
> overwriting whatever is there.
> 
> Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/
> 
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index b114b815187a9..b94830c5b9a10 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
> 
> [ ... ]
> 
>> @@ -2940,6 +2901,47 @@ static bool blacklisted(const char *module_name)
>>  }
>>  core_param(module_blacklist, module_blacklist, charp, 0400);
>>  
>> +/*
>> + * Allocate codetag sections separately. They are loaded into preallocated
>> + * contiguous memory because they may still be used after the module is
>> + * unloaded.
>> + *
>> + * If the separate allocation overflows, allocate the section normally
>> + * so that the module can still be loaded.
>> + */
>> +static int allocate_codetag_sections(struct load_info *info)
>> +{
>> +	for (unsigned int i = 1; i < info->hdr->e_shnum; i++) {
>> +		Elf_Shdr *shdr = &info->sechdrs[i];
>> +		const char *sname = info->secstrings + shdr->sh_name;
>> +		void *dest;
>> +
>> +		if (!codetag_needs_module_section(info->mod, sname, shdr->sh_size))
>> +			continue;
>> +
>> +		dest = codetag_alloc_module_section(info->mod, sname, shdr->sh_size,
>> +				arch_mod_section_prepend(info->mod, i), shdr->sh_addralign);
>> +		if (WARN_ON(!dest)) {
>> +			codetag_free_module_sections(info->mod);
>> +			return -EINVAL;
>> +		}
>> +		if (dest == ERR_PTR(-EAGAIN))
>> +			/* Allocate the section as a regular section. */
>> +			continue;
> 
> [Severity: High]
> Does this code leak the per-cpu memory on module unload when falling back to
> regular section allocation?
> 
> If tags_addressable() returns false, reserve_module_tags() returns -EAGAIN
> and removes the module from mod_area_mt. The fallback mechanism here allocates
> the tags in regular module memory, but the module loading process still
> unconditionally allocates per-cpu counters for each tag, oblivious to the
> fallback or the disabled profiling state:
> 
>     for (tag = start_tag; tag < stop_tag; tag++) {
>         WARN_ON(tag->counters);
>         tag->counters = alloc_percpu(struct alloc_tag_counters);
> 
> On unload, release_module_tags() fails to find the module in mod_area_mt
> because it was removed, skipping clean_unused_counters() and leaking the
> previously allocated per-cpu memory.

This has already been fixed by the commit below:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=394aff7091a0278b0495549b5d2ff3b318e639d2

> 
>> +		if (IS_ERR(dest)) {
>> +			codetag_free_module_sections(info->mod);
>> +			return PTR_ERR(dest);
>> +		}
>> +
>> +		if (shdr->sh_type != SHT_NOBITS)
>> +			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
> 
> [Severity: Medium]
> Could this expose uninitialized kernel memory if the codetag section is
> parsed from an ELF module with the SHT_NOBITS type?
> 
> The code skips memcpy() but fails to use memset() to zero-initialize the
> destination buffer. Regular module sections are safe because
> module_memory_alloc() explicitly zeroes them, but reserve_module_tags() backs
> its memory with alloc_pages_bulk_node() without the __GFP_ZERO flag:
> 

OK. Considering that codetag is a general‑purpose framework,
it shouldn't assume anything about which codetag types exist
today or later. Will fix for the next version.


> mm/alloc_tag.c:vm_module_tags_populate() {
> ...
>     allocated = alloc_pages_bulk_node(GFP_KERNEL | __GFP_NOWARN,
>             NUMA_NO_NODE, more_pages - nr, next_page + nr);
> ...
> }
> 
>> +		shdr->sh_addr = (unsigned long)dest;
>> +		shdr->sh_entsize = SH_ENTSIZE_STANDALONE;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> 
> [ ... ]
> 
>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>> index 2070e682fe106..112a014d4b890 100644
>> --- a/mm/alloc_tag.c
>> +++ b/mm/alloc_tag.c
>> @@ -950,10 +950,12 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>>  		int grow_res;
>>  
>>  		module_tags.size = offset + size;
>> -		if (mem_alloc_profiling_enabled() && !tags_addressable()) {
>> +		if (!tags_addressable()) {
>>  			shutdown_mem_profiling(true);
> 
> [Severity: High]
> This is a pre-existing issue, but does this shutdown_mem_profiling(true) call
> introduce an AB-BA deadlock between /proc/allocinfo file readers (pde->in_use)
> and module loading (cttype->mod_lock)?
> 
> A user reading /proc/allocinfo acquires the procfs in_use reference in
> use_pde(), then blocks on down_read(&alloc_tag_cttype->mod_lock) in
> allocinfo_start().
> 
> Concurrently, if a module loads and tags_addressable() fails,
> codetag_alloc_module_section() holds down_write(&cttype->mod_lock) and calls
> shutdown_mem_profiling(true), which removes the proc entry. This removal waits
> indefinitely for the in_use reference to drop to zero, hanging both procfs
> reads and module loading.
> 
>> -			pr_warn("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
>> -				mod->name, NR_UNUSED_PAGEFLAG_BITS);
>> +			pr_warn_once("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
>> +				     mod->name, NR_UNUSED_PAGEFLAG_BITS);
>> +			release_module_tags(mod, false);
>> +			return ERR_PTR(-EAGAIN);
>>  		}
>>  
>>  		grow_res = vm_module_tags_populate();
> 
This has already been fixed by the commit below:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=4cd27d57fd9468491f2ea48cee93e233c55edda8

Thanks
Best Regards
Hao
