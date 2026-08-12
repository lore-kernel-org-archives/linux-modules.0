Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B4C2E03F1
	for <linux-modules@vger.kernel.org>; Wed, 12 Aug 2026 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516375; cv=none; b=bUHWdLMfYINM+AZbYfADb1i4ICL0+Nqz1aghXIzbriGewZRAQTjvL/8SzOHfMxI1K0g/inWOspiIIU174nZU8EN7TaJ4ifz86GtzTgC7lYrsM9CIiHbeSFGwtyObfwPKMI6gJclxApjp+aMnAQfUuuEy7a1H5EiaOArBiB9cFMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516375; c=relaxed/simple;
	bh=h5JXSvc1ufL6bkPE/woM5yaUaXQLAZ8qaqklf9eMHAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2TSnPczz0e6D9rkjXMNP20vobff9ntkb2cSyqKQiocTn/afWr47xVjG5jZqOHjzHDwN+gZIOHbRGLkcmSqNPzfJ43WvJnv11ztUe9h02QeFFZmL+EmzfDB9aXdJLxnuRMsSQnXTT6vJ2fs/9nNtgBj2gh92tLR8S7cFFYOtNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PLdyU+qs; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PLdyU+qs"
Message-ID: <f244c880-c907-456b-81ae-07c28456185e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786516361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ExJys5qSDXQWFXg8uSDgxGRkENE87NKcgW0l7vfMryo=;
	b=PLdyU+qsm8C9P29r4fmpfnSmLBODoUGdBqzDh9D1uirmugiUqWiF1KJNxYfAaOVCcJzh2Z
	KRfHKXbsCYtnXvQFGVljlD+C+wgQcCnfBoPVvyRT+/quU+lQ429XSl+lMcooNE8j+CDw63
	1xOwbNgx2ftc9XiwadFKgdEGZt4cJjQ=
Date: Wed, 12 Aug 2026 14:32:40 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/2] alloc_tag: fix undetected compressed tag overflow
 when profiling is disabled
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>
References: <20260812054105.102637-1-hao.ge@linux.dev>
 <20260812054105.102637-3-hao.ge@linux.dev>
 <20260812060411.968631F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20260812060411.968631F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

CC Andrew and Suren


On 2026/8/12 14:04, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Unconditional allocation of per-CPU counters for modules causes a memory leak when memory profiling is disabled and the module load is retried.
> 
> Pre-existing issues:
> - [Critical] Concurrent module loading can cause an out-of-bounds memory write and module corruption because the global profiling flag is toggled without cross-phase synchronization.
> - [High] A race condition on the global module tags size variable can lead to unmapped virtual memory access and a kernel panic.
> - [High] If page population fails, a dangling module pointer is left in the maple tree, leading to a Use-After-Free.
> --
> 
> --- Patch [2]: [PATCH v5 2/2] alloc_tag: fix undetected compressed tag overflow when profiling is disabled ---
> commit ffb2b208763f32cdfb3d6cb740d4d4efa5c99ae0
> Author: Hao Ge <hao.ge@linux.dev>
> 
> alloc_tag: fix undetected compressed tag overflow when profiling is disabled
> 
> This patch modifies module layout and allocation to retry loading without
> memory profiling if the compressed tag limit is exceeded. It removes the
> profiling enabled guard when checking for tag overflow and handles the
> fallback by resetting section flags and repeating the layout process.
> 
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
> 
> [ ... ]
> 
>> @@ -2966,18 +2967,38 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>>   	 */
>>   	module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstrings);
>>   
>> +	/*
>> +	 * Save the sizes reserved by module_frob_arch_sections() so they can
>> +	 * be restored if we retry below.
>> +	 */
>> +	for_each_mod_mem_type(type)
>> +		frob_size[type] = info->mod->mem[type].size;
>> +
>>   	/*
>>   	 * Determine total sizes, and put offsets in sh_entsize.  For now
>>   	 * this is done generically; there doesn't appear to be any
>>   	 * special cases for the architectures.
>>   	 */
>> +retry:
>>   	layout_sections(info->mod, info);
>>   	layout_symtab(info->mod, info);
>>   
>>   	/* Allocate and move to the final place */
>>   	err = move_module(info->mod, info);
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but can concurrent module loading
> cause memory corruption if profiling is disabled mid-flight?
> 
> In move_module(), if one thread disables profiling globally via
> shutdown_mem_profiling() while another thread is halfway through module
> loading (between layout calculation and memory movement), the second thread's
> section offset queries could evaluate to false.
> 
> This would cause the module loader to use an un-incremented 0 offset and
> incorrectly write the codetag section into the base memory, overwriting the
> start of the module's core memory block.
> 
>> -	if (err)
>> -		return ERR_PTR(err);
>> +	if (err) {
>> +		if (err != -EAGAIN)
>> +			return ERR_PTR(err);
>> +		/*
>> +		 * -EAGAIN means profiling was disabled but the module
>> +		 * can still load without it. Reset state and retry.
>> +		 */
>> +		rewrite_section_headers(info, flags);
>> +		for_each_mod_mem_type(type)
>> +			info->mod->mem[type].size = frob_size[type];
>> +		info->sechdrs[info->index.sym].sh_flags &= ~(unsigned long)SHF_ALLOC;
>> +		info->sechdrs[info->index.str].sh_flags &= ~(unsigned long)SHF_ALLOC;
>> +		goto retry;
> 
> [Severity: High]
> Does this retry mechanism cause a memory leak for per-CPU counters?
> 
> When the module load is retried via this new loop, the codetag section is
> treated as standard memory and bypasses maple tree registration. However, the
> subsequent codetag module initialization unconditionally allocates per-CPU
> memory for these tags regardless of the profiling state.
> 
> During module unload in release_module_tags(), the cleanup path exits early
> because the module cannot be found in the maple tree, permanently leaking
> the per-CPU memory on every unload.

The per-CPU counter leak is pre-existing, not introduced by the retry 
 
 
                                                      mechanism.

The root cause is that shutdown_mem_profiling() permanently sets 
 
 
 
mem_profiling_support to false, after which needs_section_mem() 
 
 
                                                        returns false 
for every subsequent module. Their codetag sections are 
 
 
                                         placed as regular data, so they 
are never inserted into the alloc_tag 
 
 
                       maple tree. Yet codetag_load_module() still 
unconditionally invokes 
 
 
          the load_module() callback, which allocates percpu counters 
that 
 
 
release_module_tags() cannot find on unload.

I'll send out a separate patch to fix this leak later.



> 
>> +	}
>>   
>>   	/* Module has been copied to its final place now: return it. */
>>   	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
> 
>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>> --- a/mm/alloc_tag.c
>> +++ b/mm/alloc_tag.c
> 
> [ ... ]
> 
>> @@ -950,10 +950,12 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>>   		int grow_res;
>>   
>>   		module_tags.size = offset + size;
> 
> [Severity: High]
> This is a pre-existing issue, but does the update to module_tags.size race
> with concurrent module loads?
> 
> The high-water mark for the module tags size is updated here without a lock
> after the maple tree lock is released. If two concurrent module loads race on
> this update, a higher offset might be overwritten by a smaller one.
> 
> Subsequently, vm_module_tags_populate() relies on this corrupted size and
> would fail to map the physical pages for the higher virtual addresses, leading
> to a page fault when the module accesses its allocated tags.
> 
>> -		if (mem_alloc_profiling_enabled() && !tags_addressable()) {
>> +		if (!tags_addressable()) {
>>   			shutdown_mem_profiling(true);
>> -			pr_warn("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
>> -				mod->name, NR_UNUSED_PAGEFLAG_BITS);
>> +			pr_warn_once("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
>> +				     mod->name, NR_UNUSED_PAGEFLAG_BITS);
>> +			release_module_tags(mod, false);
>> +			return ERR_PTR(-EAGAIN);
>>   		}
>>   
>>   		grow_res = vm_module_tags_populate();
> 
> [Severity: High]
> This is a pre-existing issue, but could this lead to a dangling pointer in
> the maple tree if page population fails?
> 
> If vm_module_tags_populate() fails and returns an error, the allocation
> routine returns an error here but doesn't remove the newly inserted module
> pointer from the maple tree.
> 
> Since this error bypasses the standard codetag cleanup routines in the module
> loader (where codetag_section_found might remain false in move_module()),
> the maple tree retains a pointer to the aborted module. Once the module
> structure is freed, future maple tree iterations could dereference this freed
> pointer.
> 
