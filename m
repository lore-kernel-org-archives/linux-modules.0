Received: from mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3768371D14
	for <linux-modules@vger.kernel.org>; Wed, 30 Sep 2026 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738756; cv=none; b=bGERkEcTiA4OF1MwgJ8gBewM1O5Z9HJ62YHS+NiC+Lu5Plok4EMhuG60mNcHuQ6EoFmxm1JDGhs62xgFWMfjIMrinEiqiYrTvRIK/XNkv4wxuPrjiiMeLSObKlrOZcwdXmSVTzXmCtSljQpwjDMt+crmeXoAPVL9ZVNg9TDgQ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738756; c=relaxed/simple;
	bh=tmx3X4PgFtMsV+xxZ1IMDVsyAWoakSL8TqQSX2VjB/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8EEFmCI6+8hb0x+SP4T8wubF7U/NmlxnJkcrrPQ1mn/kAKNfZfPmVzI9zdhjwBcqG4GI7JG5x6mSo1rVo1KucXmaNI61OMOxEVkpASQSTv9cfeSY+BmIgxFCfP9T9CvRg1ggjG4GjAnnBXbkqJfDidrdgz3l6+4w9FK/VdUHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SLzA18dw; arc=none smtp.client-ip=91.218.175.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SLzA18dw"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tmx3X4PgFtMsV+xxZ1IMDVsyAWoakSL8TqQSX2VjB/Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790738751; v=1; x=1791343551;
 b=SLzA18dwU+mCXqj02LPTrThA3PD587eWehE2DOUGWvWMKJ8mgYvOEWdkz8S7ljxvzBXE5/Ie
 QtIcEKxpZPbnbDz6UUZeZf7ttLfTnqMIWQyHlHpDyFsI1nhOZfMf7aqFr+GCOGGqq7dBH7Iw/YR
 iPY0vF3+OdIfN0ykC5jyCUec=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0e3241359faa91a0;
	Wed, 30 Sep 2026 03:25:51 +0000
X-Mizu-Trace-ID: 0e3241359faa91a0
X-Migadu-Flow: FLOW_OUT
Message-ID: <fc4f3d08-393f-43ed-934b-e7e1ba6d0137@linux.dev>
Date: Wed, 30 Sep 2026 11:26:41 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/7] alloc_tag and module codetag section fixes
To: Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vlastimil Babka <vbabka@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com
References: <20260929082014.160587-1-hao.ge@linux.dev>
 <20260929134401.a1a385ff4369661f879b5d2f@linux-foundation.org>
 <CAJuCfpFRW3uNUW_VrjpOfLwS1LBHqGEpqK3yBTPSpGOORY5jiQ@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpFRW3uNUW_VrjpOfLwS1LBHqGEpqK3yBTPSpGOORY5jiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren and Andrew


On 2026/9/30 10:39, Suren Baghdasaryan wrote:
> On Tue, Sep 29, 2026 at 8:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Tue, 29 Sep 2026 16:20:07 +0800 Hao Ge <hao.ge@linux.dev> wrote:
>>
>>> With profiling toggled off, the overflow check in
>>> reserve_module_tags() did not run, a module could load with more
>>> tags than the page flags can address, and re-enabling profiling
>>> then silently corrupted /proc/allocinfo. On overflow the fix shuts
>>> profiling down, releases the reservation and returns -EAGAIN, and
>>> the codetag section lands as regular module data in the same load,
>>> so the module loads without profiling.
>>>
>>> Review of the earlier series by Sashiko turned up more problems.
>>>
>>> One is a race. layout_sections() and move_module() both asked
>>> codetag_needs_module_section() where a codetag section goes, and
>>> mem_profiling_support can change between the two calls, for instance
>>> when another module load overflows the tag index and shuts profiling
>>> down. move_module() then copied the codetag section to offset 0 of
>>> its regular destination and clobbered the first section placed in
>>> that region.
>>>
>>> v7 reworks where codetag sections are allocated, on a prototype by
>>> Petr Pavlu [1]. The allocation runs before layout_sections() and the
>>> placement is decided in one step, so nothing re-asks the question
>>> and the race is gone. The retry is gone too, on -EAGAIN the section
>>> is laid out as regular module data right in the same load.
>>
>> Thanks.
>>
>> Seven patches, all cc:stable.  Why is a backport proposed?
>> Documentation/process/stable-kernel-rules.rst gives guidelines - does
>> this series meet them?  Does Suren have thoughts?

Thanks, I've just gone through this carefully.

> 
> I think vmalloc fix in patch#2 should be posted separately and clearly
> quialifies for backporting as if fixes issues Hao found at [1].

Agreed. Patch #2 was added to this patch series because vm_module_tags_populate
suffers from the same issue. If we want to be more conservative, I'd prefer to keep
vm_module_tags_populate as it was in V10:
https://lore.kernel.org/all/20260915070001.113559-3-hao.ge@linux.dev/

Then we can submit a fix for __GFP_NOFAIL retry loop in __vmalloc_area_node() as a hotfix together
with our new patch #2. While at it, we can also check if there are any unnecessary calls to
vunmap_range family functions that can be cleaned up now that patch #2 is applied.


> 
> The rest are also bug fixes but their size is concerning. I'll review
> them first before advising on which ones should be backported. Some
> fixes address issues that happen very rarely and if a fix is too
> complex it might make sense to leave it be or fix it some other way
> with less churn. Please give me a couple of days to review them. With
> the upcoming LPC I'm trying to multiplex between several projects.

Thanks, sorry for all the hassle on you folks.

Thanks
Best Regards
Hao

> 
> [1] https://lore.kernel.org/all/b8005c24-ecac-45c4-840a-fd282f9693b5@linux.dev/
> 
>>
>> Also, Sashiko has been busy again:
>>         https://sashiko.dev/#/patchset/20260929082014.160587-1-hao.ge@linux.dev
