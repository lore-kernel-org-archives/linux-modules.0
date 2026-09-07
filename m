Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78CA448D03
	for <linux-modules@vger.kernel.org>; Mon,  7 Sep 2026 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773216; cv=none; b=dbGRuIWRw/vjrmPYtfHCrvOPXGYCSc7uJthG34durKvA4ofqZ5anzGUOTK32rcRNPxCEQl73ziqgs2aeXhXQVvOv0/kbrX+N+lDW8ZEBuQs4ubwfBsZorCSmlQpG0D0ZCjibEG9reayuObL9Vdhfn0T6RwnMVv48msumdYFmYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773216; c=relaxed/simple;
	bh=kEupld+SgHbnNxdb3tq/awQ0PP5s3GL6aSkheElec1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVeBPKxrR9m8s8vbc7jUPIjAfNRKXllJnmiXEgMlD3gySq5Yc1kxbxuLYQK+5M+9jvd724I63NRgkccws4StlAeF7W5fus0M2iZTnErmn2C57XxkC2Vu0Us4jbjHllEI/lojeklnWZW/2o+Z6AIwKu0+30tzzObjO0/+XUkJOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZiCzngYl; arc=none smtp.client-ip=91.218.175.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZiCzngYl"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kEupld+SgHbnNxdb3tq/awQ0PP5s3GL6aSkheElec1k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788773206; v=1; x=1789378006;
 b=ZiCzngYllYV+PC1GOo7wITMyrTcrGXfdUyhoDr9rie0SoxFEHkD+RzgWQnM7z1TpwtVkxD4l
 NX+hx5FoiXmFXvaiBH5o4EZ79slJe/R9AySrq4Yq+5TX8TY280kAS8NTV7ZlZ6q5ZY1t3z2pjsg
 o29M3K4zH7F4wIEfpahTIeas=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4443323dd04fce52;
	Mon, 07 Sep 2026 09:26:46 +0000
X-Mizu-Trace-ID: 4443323dd04fce52
X-Migadu-Flow: FLOW_OUT
Message-ID: <6cb23255-cf0f-41af-a097-d969e659e2f8@linux.dev>
Date: Mon, 7 Sep 2026 17:27:39 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] alloc_tag: release the reservation when populate
 fails
To: Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, sashiko-reviews@lists.linux.dev
References: <20260907062414.106873-1-hao.ge@linux.dev>
 <20260907062414.106873-5-hao.ge@linux.dev>
 <20260907064336.E33BE1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20260907064336.E33BE1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2026/9/7 14:43, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [Critical] The patch introduces a kernel crash by freeing the maple tree entry without rolling back module_tags.size on failure.
> 
> Pre-existing issues:
> - [High] vmap_pages_range() failure in vm_module_tags_populate() leaves physical pages mapped while freeing them, leading to Use-After-Free.
> - [High] AB-BA Deadlock between procfs read and module loading via shutdown_mem_profiling().
> - [Medium] Memory leak of percpu counters when module falls back to standard section allocation.
> --
> 
> commit 09d0b9820f6ab861e4c9680b44a685c8658fb571
> Author: Hao Ge <hao.ge@linux.dev>
> 
> alloc_tag: release the reservation when populate fails
> 
> vm_module_tags_populate() can fail after a reservation is stored in the
> maple tree. The error return previously leaked the entry because a failed
> load never unloads the module. This patch calls release_module_tags()
> on failure to free the reservation.
> 
>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>> index 112a014d4b890..c11813cd9e153 100644
>> --- a/mm/alloc_tag.c
>> +++ b/mm/alloc_tag.c
>> @@ -963,6 +963,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>>  			shutdown_mem_profiling(true);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but could calling
> shutdown_mem_profiling(true) here risk an AB-BA deadlock?
> 
> A read to /proc/allocinfo enters proc_reg_read_iter(), taking an 'in_use'
> reference on the proc entry, then calls allocinfo_start() which waits for
> down_read(&alloc_tag_cttype->mod_lock).
> 
> Concurrently, module loading calls codetag_alloc_module_section(), holding
> down_write(&alloc_tag_cttype->mod_lock).
> 
> If reserve_module_tags() encounters an error, it calls
> shutdown_mem_profiling(true), which invokes remove_proc_entry().
> 
> Since remove_proc_entry() blocks waiting for the 'in_use' reference count
> to drop to zero, and the procfs reader blocks on the mod_lock held by the
> writer, doesn't this create a system hang during a module load failure?
> 
>>  			pr_err("Failed to allocate memory for allocation tags in the module %s. Memory allocation profiling is disabled!\n",
>>  			       mod->name);
>> +			release_module_tags(mod, false);
> 
> [Severity: Critical]
> Will this new call to release_module_tags() cause a kernel crash on a
> subsequent module load?
> 
> In reserve_module_tags(), module_tags.size is optimistically updated
> (module_tags.size = offset + size;) before attempting to allocate physical
> memory via vm_module_tags_populate().
> 
> If population fails, this patch frees the maple tree entry, but
> module_tags.size is left artificially inflated.
> 
> A subsequent module load will search the maple tree and reuse this freed gap.
> Because module_tags.size is already inflated, the allocation check bypasses
> vm_module_tags_populate(), returning an unmapped virtual address. Can copying
> section data into this address then trigger a fatal page fault?
> 

I see.

No, not for a subsequent load. The failure path shuts profiling
down before returning:

grow_res = vm_module_tags_populate();
if (grow_res) {
	shutdown_mem_profiling(true); /* mem_profiling_support = false */
	...
	release_module_tags(mod, false);
	 return ERR_PTR(grow_res);
}

and any later load bails out in needs_section_mem() long before it
reaches reserve_module_tags():
	if (!mem_profiling_support)
		return false;          

so no new reservation is made and the unmapped address is never
handed out.

But this reminds me of another race condition:

CPU0: failing load                 	CPU1: concurrent load                                                                           
----------------------             	---------------------------
needs_section_mem(): true         	needs_section_mem(): true
reserve_module_tags(): reserve the gap,
	module_tags.size = end
	populate() fails, gap released
                                  	reserve_module_tags(): reuse the gap,
                                  	end <= size -> skip populate
                                  	memcpy() -> page fault

I have a fix for this, but I'd like to wait for Petr and Suren to review the
remaining parts before sending it out.

Thanks
Best Regards
Hao

> [Severity: Medium]
> This is a pre-existing issue, but might the use of release_module_tags()
> when falling back to a standard section allocation leak percpu counters?
> 
> If tags are not addressable, reserve_module_tags() calls
> release_module_tags(mod, false) to remove the module from the maple tree
> and returns -EAGAIN.
> 
> The module loader catches -EAGAIN and falls back to a normal section
> allocation. Later, load_module() successfully allocates percpu counters for
> the tags.
> 
> On unload, release_module_tags(mod, true) is called to free the counters.
> However, because the module is no longer in the maple tree, the search fails
> and exits early:
> 
> mm/alloc_tag.c:release_module_tags() {
>     ...
>     if (!val) /* module not found */
>         goto out;
>     ...
> }
> 
> Are the percpu counters allocated during load_module() permanently leaked
> in this scenario?
> 
>>  			return ERR_PTR(grow_res);
> 
> [Severity: High]
> This is a pre-existing issue, but is there a risk that the failure path of
> vm_module_tags_populate() leaves dangling PTEs causing a Use-After-Free?
> 
> In vm_module_tags_populate(), vmap_pages_range() maps allocated pages into
> the kernel virtual address space.
> 
> If it fails, it returns an error but may leave successfully mapped PTEs
> active in the page tables. The error path calls release_pages() to free the
> physical pages back to the allocator, but fails to call vunmap_range():
> 
> mm/alloc_tag.c:vm_module_tags_populate() {
>     ...
>     if (nr < more_pages || vmap_pages_range(...) < 0) {
>         release_pages(arg, nr);
>         return -ENOMEM;
>     }
>     ...
> }
> 
> Could this leave dangling PTEs with PAGE_KERNEL permissions pointing to
> freed pages, risking data corruption when the pages are reallocated?
> 
>>  		}
>>  	}
> 
