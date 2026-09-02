Received: from mta0.migadu.com (out-45.mta0.migadu.com [91.218.175.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542833A6F1C
	for <linux-modules@vger.kernel.org>; Wed,  2 Sep 2026 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331941; cv=none; b=ff/uXldaghQxSgHM2vtIGxL9SNykn+QsZufrNbfAIb5tMhIvhMgzSko+Ie8zMjrjrlexM4VydCtPLCukeumVD13KdUWECpes+openkxfh7wKm06VpEVaaU5LJF5tHRkK6WTLZQuPSOj/jzrZ8rXFNUjWT8QWq4h/A9F8Npo8xos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331941; c=relaxed/simple;
	bh=gSOGauCVBR5yYzeUfsRa/gSX+Yppw2FY99qKdC7hHrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLDUfLpxlLiy4obvAxasuU8O2Je8IvFWh7MVQZQyS6AUZJzIUVcvz5CKrgsHp0U5ZuJh66IZv0K/69ZoVCSSjGMp2CJERzGYVXMJ7XUYKltT5U5MBlxF6j0HpvYAZfNtynFQ+MeKXqYKjNsmQREVryD5B5MZoBRzG0QEZbR5nnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GyMi/LTH; arc=none smtp.client-ip=91.218.175.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GyMi/LTH"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gSOGauCVBR5yYzeUfsRa/gSX+Yppw2FY99qKdC7hHrA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788331922; v=1; x=1788936722;
 b=GyMi/LTHiwbqfY2cc5HfL4BfYnr6YrBBNUG59zY970ejfZqDpLV4yhnRYQ+PWQxsTSzzUFc3
 ipwIWfpAIuFmhGbEtpMaf6FjcxYh7c4ANF1wS2yiFaxNh5GXA1pOe33z15Oe0HUtPdz7oZye5Sm
 dFNzc3ZwNSlepWZ7nQLBpmKI=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d6f0d7879c0d4e99;
	Wed, 02 Sep 2026 06:51:52 +0000
X-Mizu-Trace-ID: d6f0d7879c0d4e99
X-Migadu-Flow: FLOW_OUT
Message-ID: <e4daf0ed-8e30-49f7-9c1f-3d0a9c2ff076@linux.dev>
Date: Wed, 2 Sep 2026 14:52:35 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 2/2] module: allocate codetag sections before the
 regular module layout
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20260831072104.120197-1-hao.ge@linux.dev>
 <20260831072104.120197-3-hao.ge@linux.dev>
 <37eb07db-332c-4da1-a671-6ef1cb753cb3@suse.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <37eb07db-332c-4da1-a671-6ef1cb753cb3@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Petr

Thanks for review.

On 2026/9/1 23:04, Petr Pavlu wrote:
> On 8/31/26 9:21 AM, Hao Ge wrote:
>> Whether a codetag section goes to the codetag region is decided by
>> layout_sections() and asked again in move_module(). A concurrent
>> load can shut profiling down in between, and move_module() then
>> copies the section to offset 0 of its regular destination,
>> overwriting whatever is there.
>>
>> Decide and allocate in one pass, before the layout. Allocation
>> errors fail the load. On a tag area overflow profiling is already
>> disabled, so -EAGAIN makes the section fall back to regular module
>> data and the module still loads.
>>
>> The overflow and populate failure paths of reserve_module_tags() now
>> release their reservation instead of leaking the maple tree entry.
>> When profiling was toggled off, the overflow check did not run, a
>> module could load with more tags than the page flags can address,
>> and re-enabling profiling then silently corrupted /proc/allocinfo.
>> The check no longer depends on mem_alloc_profiling_enabled().
>>
>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Based-on-a-patch-by: Petr Pavlu <petr.pavlu@suse.com>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>> Changes against Petr's prototype:
>> - allocate_codetag_sections() returns an error instead of void, and
>>   only -EAGAIN falls back to a regular section. Any other error now
>>   fails the load. The prototype fell back on everything, which can
>>   leave live tags in module memory.
>> - reserve_module_tags() releases its reservation when populate fails
>>   too, that path used to leak the maple tree entry.
>> - codetag_free_module_sections() on the move_module() error path uses
>>   info->mod, the local mod is assigned only after a successful move.
>> - The percpu section is marked only when index.pcpu != 0, otherwise
>>   sechdrs[0] gets marked.
>> - Dropped the SHF_ALLOC check, .codetag.* sections always have it.
>> ---
>>  include/linux/module.h   |   2 +
>>  kernel/module/internal.h |   4 ++
>>  kernel/module/main.c     | 120 ++++++++++++++++++++-------------------
>>  mm/alloc_tag.c           |   9 ++-
>>  4 files changed, 75 insertions(+), 60 deletions(-)
>>
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index 7566815fabbe..33548daa31a3 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -325,6 +325,8 @@ enum mod_mem_type {
>>  	MOD_INIT_RODATA,
>>  
>>  	MOD_MEM_NUM_TYPES,
>> +
>> +	MOD_STANDALONE = -2,
>>  	MOD_INVALID = -1,
>>  };
>>  
> 
> It might be better to split this patch into two: the first to introduce
> MOD_STANDALONE and use it only for the percpu section, and the second
> with all the codetag-related changes.
> 

OK, will do for the next version.

> The introduction of SH_ENTSIZE_STANDALONE should also allow us to clean
> up the current resetting of SHF_ALLOC for the percpu section, and now
> also for codetag sections. The problem is that find_sec(".data..percpu")

I also like that this keeps SHF_ALLOC semantics closer to the ELF spec.
https://www.sco.com/developers/gabi/latest/ch4.sheader.html

SHF_ALLOC
	The section occupies memory during process execution. Some control sections do
	not reside in the memory image of an object file; this attribute is off for those sections.

(I spent some time reading up on this, so hopefully I've understood it correctly.)

So it feels like we were taking a bit of a shortcut before.
These sections really do satisfy the SHF_ALLOC property by definition.

There were probably other reasons for doing it that way back then, but either‑way
I think adding SH_ENTSIZE_STANDALONE is a much cleaner solution.

> can currently return different results depending on whether it is called
> before layout_and_allocate() or later. In addition, apply_relocations()
> needs a special case for SH_ENTSIZE_STANDALONE, where it could otherwise
> just test SHF_ALLOC.
> 

Yeah, fair point.

> Instead of resetting SHF_ALLOC for percpu/codetag sections, both
> __layout_sections() and move_module() can check for
> SH_ENTSIZE_STANDALONE to determine whether a section is handled
> specially and should be skipped.
> 

Right, While working on the code, I noticed that __layout_sections already has a check for
this.

if ((s->sh_flags & masks[m][0]) != masks[m][0]
    || (s->sh_flags & masks[m][1])
    || s->sh_entsize != ~0UL
    || is_init != module_init_layout_section(sname))
	continue;

s->sh_entsize != ~0UL can be used to handle this.
I'll add a short comment here.

> I think it would be useful to include this change in the first patch
> introducing MOD_STANDALONE, but I'm also ok with the current version.
> I can send a separate patch later to make more use of
> SH_ENTSIZE_STANDALONE in this way.

So cool.

> 
>> @@ -2966,18 +2967,23 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>>  	 */
>>  	module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstrings);
>>  
>> -	/*
>> -	 * Determine total sizes, and put offsets in sh_entsize.  For now
>> -	 * this is done generically; there doesn't appear to be any
>> -	 * special cases for the architectures.
>> -	 */
>> +	/* Allow codetag sections to be allocated separately first. */
>> +	err = allocate_codetag_sections(info);
>> +	if (err) {
>> +		codetag_free_module_sections(info->mod);
> 
> The usual convention is that functions clean up after themselves on
> error. That means this codetag_free_module_sections() call should be
> done ideally by allocate_codetag_sections().
> 

Ack.

Thanks
Best Regards
Hao
