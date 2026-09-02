Received: from mta1.migadu.com (out-68.mta1.migadu.com [95.215.58.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789137F312
	for <linux-modules@vger.kernel.org>; Wed,  2 Sep 2026 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334043; cv=none; b=Dsyz5UClfqKTGW0XOn8E5EJOf59d4e5SOooTA0+R3BFE5Rcn5FAdlg0hhe43tZsl0Kd6n2CvUVe4TSp1FDSZHsTu7rixKYYCzw11zBvo/goLiXvh2X7luRdBYA6vnLuT89nOjL8vJx3B1lqFxucZ8DT1z7hBuEKNHJZAEv/yQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334043; c=relaxed/simple;
	bh=5d+nW84vcx6ba4Msp2rFptCPFpP2LtEZsGnTr+2A50s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiTsI2ukpcIq7dBHpEhNu6kZ7x7lFAq6dTZdRS/2LbQASRyf+Yc/l7Ssze/VMgbEOXxeAlqRq6ytq/TnF9HeVkYoyeYMZFkxe6+Lq1NUO58gDPefxprfNOoXZw4FbiKz+YTPJrDIzjJa2YaX9MYXYCZCKq7A2slDNMIWw18d/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KYQudEkm; arc=none smtp.client-ip=95.215.58.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KYQudEkm"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5d+nW84vcx6ba4Msp2rFptCPFpP2LtEZsGnTr+2A50s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788334036; v=1; x=1788938836;
 b=KYQudEkmPveH6gIEMwMIQ3RDfttzANTkk2MEwlCJNuFPtGKT/nkQgrxmTMqPJbjWKRHXKCrj
 hd2CU/Vwpi/ID9HsDqS7rSSzWkZPMYAVEAnBCk1mOK47hDxzq0q3xT0cTZlx7se8mAo8iDPKsH1
 7DQGn/tWu0P9yIdRKTPauP9Y=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 572b371ec690fa84;
	Wed, 02 Sep 2026 07:27:16 +0000
X-Mizu-Trace-ID: 572b371ec690fa84
X-Migadu-Flow: FLOW_OUT
Message-ID: <8d879e04-3dce-4725-a9e0-8a4b1edec30f@linux.dev>
Date: Wed, 2 Sep 2026 15:28:03 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 2/2] module: allocate codetag sections before the
 regular module layout
To: Suren Baghdasaryan <surenb@google.com>, Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20260831072104.120197-1-hao.ge@linux.dev>
 <20260831072104.120197-3-hao.ge@linux.dev>
 <37eb07db-332c-4da1-a671-6ef1cb753cb3@suse.com>
 <CAJuCfpHdevUVms+WPHXET0M912hxRo_+QiV2zh2+O5ZCNTy+mA@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpHdevUVms+WPHXET0M912hxRo_+QiV2zh2+O5ZCNTy+mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren

Thanks for your review.

On 2026/9/2 02:36, Suren Baghdasaryan wrote:
> On Tue, Sep 1, 2026 at 8:04 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> On 8/31/26 9:21 AM, Hao Ge wrote:
>>> Whether a codetag section goes to the codetag region is decided by
>>> layout_sections() and asked again in move_module(). A concurrent
>>> load can shut profiling down in between, and move_module() then
>>> copies the section to offset 0 of its regular destination,
>>> overwriting whatever is there.
>>>
>>> Decide and allocate in one pass, before the layout. Allocation
>>> errors fail the load. On a tag area overflow profiling is already
>>> disabled, so -EAGAIN makes the section fall back to regular module
>>> data and the module still loads.
>>>
>>> The overflow and populate failure paths of reserve_module_tags() now
>>> release their reservation instead of leaking the maple tree entry.
>>> When profiling was toggled off, the overflow check did not run, a
>>> module could load with more tags than the page flags can address,
>>> and re-enabling profiling then silently corrupted /proc/allocinfo.
>>> The check no longer depends on mem_alloc_profiling_enabled().
>>>
>>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Based-on-a-patch-by: Petr Pavlu <petr.pavlu@suse.com>
>>> Cc: Suren Baghdasaryan <surenb@google.com>
>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>> ---
>>> Changes against Petr's prototype:
>>> - allocate_codetag_sections() returns an error instead of void, and
>>>   only -EAGAIN falls back to a regular section. Any other error now
>>>   fails the load. The prototype fell back on everything, which can
>>>   leave live tags in module memory.
>>> - reserve_module_tags() releases its reservation when populate fails
>>>   too, that path used to leak the maple tree entry.
>>> - codetag_free_module_sections() on the move_module() error path uses
>>>   info->mod, the local mod is assigned only after a successful move.
>>> - The percpu section is marked only when index.pcpu != 0, otherwise
>>>   sechdrs[0] gets marked.
>>> - Dropped the SHF_ALLOC check, .codetag.* sections always have it.
>>> ---
>>>  include/linux/module.h   |   2 +
>>>  kernel/module/internal.h |   4 ++
>>>  kernel/module/main.c     | 120 ++++++++++++++++++++-------------------
>>>  mm/alloc_tag.c           |   9 ++-
>>>  4 files changed, 75 insertions(+), 60 deletions(-)
>>>
>>> diff --git a/include/linux/module.h b/include/linux/module.h
>>> index 7566815fabbe..33548daa31a3 100644
>>> --- a/include/linux/module.h
>>> +++ b/include/linux/module.h
>>> @@ -325,6 +325,8 @@ enum mod_mem_type {
>>>       MOD_INIT_RODATA,
>>>
>>>       MOD_MEM_NUM_TYPES,
>>> +
>>> +     MOD_STANDALONE = -2,
>>>       MOD_INVALID = -1,
>>>  };
>>>
>>
>> It might be better to split this patch into two: the first to introduce
>> MOD_STANDALONE and use it only for the percpu section, and the second
>> with all the codetag-related changes.
>>
>> The introduction of SH_ENTSIZE_STANDALONE should also allow us to clean
>> up the current resetting of SHF_ALLOC for the percpu section, and now
>> also for codetag sections. The problem is that find_sec(".data..percpu")
>> can currently return different results depending on whether it is called
>> before layout_and_allocate() or later. In addition, apply_relocations()
>> needs a special case for SH_ENTSIZE_STANDALONE, where it could otherwise
>> just test SHF_ALLOC.
>>
>> Instead of resetting SHF_ALLOC for percpu/codetag sections, both
>> __layout_sections() and move_module() can check for
>> SH_ENTSIZE_STANDALONE to determine whether a section is handled
>> specially and should be skipped.
>>
>> I think it would be useful to include this change in the first patch
>> introducing MOD_STANDALONE, but I'm also ok with the current version.
>> I can send a separate patch later to make more use of
>> SH_ENTSIZE_STANDALONE in this way.
> 
> I ran some tests on my side and nothing blew up.
> 

Thanks.

> Petr's suggestion to split the patch sounds good to me and
> release_module_tags() change in alloc_tag.c could also be done in a
> separate patch. It's the cleanup after we do shutdown_mem_profiling(),
> so I think it would be correct on its own.

OK, if I understand you correctly, you'd like the release_module_tags() call
on vm_module_tags_populate() failure to go into its own separate patch.
That's because our -EAGAIN fallback depends on the reserve_module_tags() change.
Without it the overflow entry stays in the maple tree, codetag_module_replaced()
retargets it at the live module, and rmmod then walks the never-populated tag area
and faults.                                                                                                                  

Thanks
Best Regards
Hao

> Thanks,
> Suren.
> 
>>
>>> @@ -2966,18 +2967,23 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>>>        */
>>>       module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstrings);
>>>
>>> -     /*
>>> -      * Determine total sizes, and put offsets in sh_entsize.  For now
>>> -      * this is done generically; there doesn't appear to be any
>>> -      * special cases for the architectures.
>>> -      */
>>> +     /* Allow codetag sections to be allocated separately first. */
>>> +     err = allocate_codetag_sections(info);
>>> +     if (err) {
>>> +             codetag_free_module_sections(info->mod);
>>
>> The usual convention is that functions clean up after themselves on
>> error. That means this codetag_free_module_sections() call should be
>> done ideally by allocate_codetag_sections().
>>
>> --
>> Thanks,
>> Petr
