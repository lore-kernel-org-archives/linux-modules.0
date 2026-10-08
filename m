Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856DF3F44E4
	for <linux-modules@vger.kernel.org>; Thu,  8 Oct 2026 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446935; cv=none; b=cMZh1O8mVUPZa4hWeXDOBD0nWmVpTOo+wDc+qHqoqiFEueK6LTmMBO/h3JfNAQH4fGe3ArzxDaV1yCOE0fRDOMmQtIUZFeJJcOxRkFit2lMQB44KKOITsKV6/UFab0m1hPqz1QwCnlBtzNrogNciZ7RdadipZsm1fcSsv+UfYOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446935; c=relaxed/simple;
	bh=Yhnnial9CyXjQfMJe0x/bX884j72gzHkQhTCBK9VwN4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KEkdQQ9m4lSUYcNhFtgukzwGmk+pD8Z7WCCLQva/ffUiqY87PXEaQtm8GiWZtN4PGNaCsv2KzwnKxpgtTQNEOQjfdklz9PTjQl3RkTtPDT/D3BC4T9ViejTItK/y9babBsz+Q4qBqVLdGhjDoOWadxfHQqhLJzQEtrxYzywYVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MYvdfg28; arc=none smtp.client-ip=91.218.175.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MYvdfg28"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Yhnnial9CyXjQfMJe0x/bX884j72gzHkQhTCBK9VwN4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791446929; v=1; x=1792051729;
 b=MYvdfg28EDDZxHLrbIMD8LSFd2V6WESK+O+0i94XAs8hY0qrmW42FaDC2R3O58GV0LOKy/E7
 JIVlOecD3PJedK8YS74Vj7myc9+i3YqthNLrwXLvk6PLJOy3pJjfaNmDXnnpCui7qNxLZ7jGKls
 SHw9KB7EZpnzCMu6gFVQDLTw=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ef9c66e098076910;
	Thu, 08 Oct 2026 08:08:38 +0000
X-Mizu-Trace-ID: ef9c66e098076910
X-Migadu-Flow: FLOW_OUT
Message-ID: <f70fd2a2-cf46-4c25-babf-9382aed69730@linux.dev>
Date: Thu, 8 Oct 2026 16:09:41 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/7] mm/vmalloc: undo partial mappings inside the
 mapping functions
From: Hao Ge <hao.ge@linux.dev>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vlastimil Babka <vbabka@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260929082014.160587-1-hao.ge@linux.dev>
 <20260929082014.160587-3-hao.ge@linux.dev> <arzgoe-bXAz1poAt@milan>
 <a15de109-a88a-49f8-80cc-7bf216d6954d@linux.dev>
Content-Language: en-US
In-Reply-To: <a15de109-a88a-49f8-80cc-7bf216d6954d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2026/10/8 14:53, Hao Ge wrote:
> Hi Uladzislau
> 
> 
> On 2026/9/30 18:12, Uladzislau Rezki wrote:
>> On Tue, Sep 29, 2026 at 04:20:09PM +0800, Hao Ge wrote:
>>> __vmap_pages_range_noflush() and friends can install some PTEs before
>>> failing and leave them mapped, and the kernel callers do not agree on
>>> who cleans them up. For example, pcpu_map_pages() and
>>> kmsan_ioremap_page_range() unmap the leftovers themselves, while
>>> vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
>>> __vmalloc_area_node() relied on the mapping functions cleaning up and
>>> did not call anything like vunmap_range() themselves. When the same
>>> range is mapped again, the attempt hits the leftovers and fails, with
>>> BUG() in vmap_pte_range() for huge mappings.
>>>
>>> After discussing with Suren and Ulad, we decided the cleanup belongs
>>> to __vmap_pages_range_noflush() and friends, so the callers no longer
>>> need to unmap the partial mappings themselves. Each function now
>>> undoes the PTEs it installed itself.
>>>
>>> The rollback calls the low-level __vunmap_range_noflush(), it just
>>> clears the PTEs of the range it is given, which is all a rollback
>>> needs. It cannot use vunmap_range_noflush() because these mapping
>>> functions also map the KMSAN shadow and origin, and for a metadata
>>> range its hook would look up the metadata of the metadata, get 0
>>> and BUG() on addr >= end. The failed mappings were never accessed,
>>> no TLB flush needed.
>>>
>>> Fixes: 9376130c390a ("mm/vmalloc: add support for __GFP_NOFAIL")
>>> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as needed")
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>> ---
>>>  mm/kmsan/shadow.c |  4 ++++
>>>  mm/vmalloc.c      | 31 +++++++++++++++++++++++++++++--
>>>  2 files changed, 33 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
>>> index 0c88d89bf0d6..2166086d3dc3 100644
>>> --- a/mm/kmsan/shadow.c
>>> +++ b/mm/kmsan/shadow.c
>>> @@ -258,6 +258,10 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>>>  					    o_pages, page_shift);
>>>  	kmsan_leave_runtime();
>>>  	if (mapped) {
>>> +		/* Undo the shadow mapping set up above. */
>>> +		kmsan_enter_runtime();
>>> +		__vunmap_range_noflush(shadow_start, shadow_end);
>>> +		kmsan_leave_runtime();
>>>  		err = mapped;
>>>  		goto ret;
>>>  	}
>>>
>> Can we just do that inside the vmalloc? For example in the
>> __vmap_pages_range_noflush() as entry function for all(?) helpers?
>> So we do not need do it manually?
>>
> The hunk was for the failure path in kmsan_vmap_pages_range_noflush().
> Shadow and origin are mapped there as two separate calls, and when                                                                   
> the origin one fails the shadow is already up. __vmap_pages_range_noflush()                                                          
> cannot do that undo, it only sees its own range.
> 
> kmsan_vmap_pages_range_noflush() has a single caller, so if we were to move this
> logic into vmalloc, it would require some modifications as follows:
> 
> @@ -712,9 +724,14 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>         int ret = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
>                                                 page_shift, gfp_mask);
>  
> +       if (!ret)
> +               ret = __vmap_pages_range_noflush(addr, end, prot, pages,
> +                                                page_shift);
> +       /* Undo whatever was mapped before the failure. */
>         if (ret)
> -               return ret;
> -       return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
> +               kmsan_vunmap_range_noflush(addr, end);
> +
> +       return ret;
>  }
>

I'd rather put this logic inside kmsan_vmap_pages_range_noflush

This function should clean things up on its own, not depend on the
caller to do it, just like kmsan_ioremap_page_range.

https://elixir.bootlin.com/linux/v7.3-rc5/source/mm/kmsan/hooks.c#L185

Uladzislau，WDYT?

Thanks
Best Regards
Hao

>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index 859e6d2d57a3..9bbf75706627 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -349,6 +349,10 @@ static int vmap_range_noflush(unsigned long addr, unsigned long end,
>>>  	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
>>>  		arch_sync_kernel_mappings(start, end);
>>>  
>>> +	/* Undo the PTEs installed before the failure. */
>>> +	if (err)
>>> +		__vunmap_range_noflush(start, end);
>>> +
>>>  	return err;
>>>  }
>>>  
>>> @@ -363,6 +367,9 @@ int vmap_page_range(unsigned long addr, unsigned long end,
>>>  	if (!err)
>>>  		err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
>>>  					       ioremap_max_page_shift);
>>> +	if (err)
>>> +		__vunmap_range_noflush(addr, end);
>>> +
>>>  	return err;
>>>  }
>>>  
>>> @@ -667,6 +674,10 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
>>>  	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
>>>  		arch_sync_kernel_mappings(start, end);
>>>  
>>> +	/* Undo the PTEs installed before the failure. */
>>> +	if (err)
>>> +		__vunmap_range_noflush(start, end);
>>> +
>>>  	return err;
>>>  }
>>>  
>> The only one user of that function is __vmap_pages_range_noflush()
>> so we can cover both cases there small and huge path.
>>
>> Is that enough just to do unroll in the below:
>>
>> __vmap_pages_range_noflush()
>> vmap_page_range()
>>
>> functions? It will also fix NOFAIL case:
>>
> 
> I see. right, __vmap_pages_range_noflush() is just above the
> actual page‑table mapping, so it's low‑level enough.
> Thanks a lot for your prototype.
> 
> I'm tidying up the code and will post a REF patch afterwards.
> 
> Thanks
> Best Regards
> Hao
> 
>> <snip>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 89c327a6ce7d..fa1f357ecf3f 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -359,10 +359,19 @@ int vmap_page_range(unsigned long addr, unsigned long end,
>>  
>>  	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
>>  				 ioremap_max_page_shift);
>> +	if (err)
>> +		goto error_cleanup_range;
>> +
>>  	flush_cache_vmap(addr, end);
>> -	if (!err)
>> -		err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
>> +	err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
>>  					       ioremap_max_page_shift);
>> +	if (err)
>> +		goto error_cleanup_range;
>> +
>> +	return 0;
>> +
>> +error_cleanup_range:
>> +	__vunmap_range_noflush(addr, end);
>>  	return err;
>>  }
>>  
>> @@ -683,26 +692,35 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>>  		pgprot_t prot, struct page **pages, unsigned int page_shift)
>>  {
>>  	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
>> +	unsigned long start = addr;
>> +	int err;
>>  
>> -	WARN_ON(page_shift < PAGE_SHIFT);
>> -
>> -	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
>> -			page_shift == PAGE_SHIFT)
>> -		return vmap_small_pages_range_noflush(addr, end, prot, pages);
>> +	if (WARN_ON(addr >= end))
>> +		return -EINVAL;
>>  
>> -	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
>> -		int err;
>> +	if (WARN_ON(page_shift < PAGE_SHIFT))
>> +		return -EINVAL;
>>  
>> -		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
>> +	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
>> +		page_shift == PAGE_SHIFT) {
>> +		err = vmap_small_pages_range_noflush(addr, end, prot, pages);
>> +	} else {
>> +		for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
>> +			err = vmap_range_noflush(addr, addr + (1UL << page_shift),
>>  					page_to_phys(pages[i]), prot,
>>  					page_shift);
>> -		if (err)
>> -			return err;
>> +			if (err)
>> +				break;
>>  
>> -		addr += 1UL << page_shift;
>> +			addr += 1UL << page_shift;
>> +		}
>>  	}
>>  
>> -	return 0;
>> +	if (err)
>> +		__vunmap_range_noflush(start, end);
>> +
>> +	/* 0 on success. */
>> +	return err;
>>  }
>>  
>>  int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>> @@ -714,7 +732,13 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>>  
>>  	if (ret)
>>  		return ret;
>> -	return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
>> +
>> +	ret = __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
>> +	if (ret)
>> +		/* Cleanup KMSAN metadata. */
>> +		kmsan_vunmap_range_noflush(addr, end);
>> +
>> +	return ret;
>>  }
>>  
>>  static int __vmap_pages_range(unsigned long addr, unsigned long end,
>> <snip>
>>
>> --
>> Uladzislau Rezki
