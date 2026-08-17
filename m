Received: from mta0.migadu.com (out-105.mta0.migadu.com [91.218.175.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F3391832
	for <linux-modules@vger.kernel.org>; Mon, 17 Aug 2026 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945265; cv=none; b=kOOHQ6jWBUAlXVWAC9wkYHakkIdb+yhr0sR41Zi/D1UkYKkQEZzmCWreIhzGX9hwV8kMRNUMigetefVnSHb9EQi+2BeR5LOvWL7p8CHurjZ76212/UFnxI7t3i7CfmXhO/3sLVbiEE04h7O+DHykUykB28ihtrEogbdNtn53Fu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945265; c=relaxed/simple;
	bh=DILIHbnqaUpEeThjZgXr1gFeEMPrU2O6UtIr10vba0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xf3W0QrhcDtEr310ULWDsoMR3YYxZt1L5T31IGF8BpIeubO+DSFO/zC7XBqv3zVdwStU/Lwmh9zNgLIJxet8jlHFaRg4t3rJx97thV52TYM26vehvi1AUyKD92TiD1VU2dIf7sT5nC7RyGt322VlN1Z4bsZq9HOYDBDwg8r2i7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U6lISe9a; arc=none smtp.client-ip=91.218.175.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U6lISe9a"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DILIHbnqaUpEeThjZgXr1gFeEMPrU2O6UtIr10vba0E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786945261; v=1; x=1787550061;
 b=U6lISe9aRrKkGMa932VSAurosfsoOgdU7njApQp7glvWira4JCHBEIU32S1AcWT6L2pnyoyh
 54WR4Z0kcrOE6uTdwVlwkYfb3fvFig26SdExiyy1Gh8Pby4Q0JRdUMDN6+AoiRm4f70KIo70p0n
 LgP8DofuLfvS62AQYNSYiZ3U=
X-Envelope-To: linux-modules@vger.kernel.org
Received: from [10.42.12.33] (116.128.244.169)
	by smtp.migadu.com with ESMTPS id a463d7034eb81a89;
	Mon, 17 Aug 2026 05:41:01 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <27f2ea45-cfee-40d4-8cf1-5955574c48bf@linux.dev>
Date: Mon, 17 Aug 2026 13:41:44 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] alloc_tag: remove /proc/allocinfo outside of
 mod_lock
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260813093421.135230-1-hao.ge@linux.dev>
 <20260813093421.135230-4-hao.ge@linux.dev>
 <CAJuCfpGfQrYJ=Rgrar-8btsiUCg=OQotWPou0J-mpMFNzrJC6A@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpGfQrYJ=Rgrar-8btsiUCg=OQotWPou0J-mpMFNzrJC6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren

On 2026/8/15 14:51, Suren Baghdasaryan wrote:
> On Thu, Aug 13, 2026 at 2:34 AM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> shutdown_mem_profiling() calls remove_proc_entry() from
>> reserve_module_tags(), which runs under mod_lock held for write.
>> remove_proc_entry() waits for readers, and a reader takes mod_lock for
>> read in allocinfo_start():
>>
>>   CPU0 (insmod)                      CPU1 (read /proc/allocinfo)
>>   ----------------                   ----------------------------
>>   reserve_module_tags()
>>     down_write(&mod_lock)  [held]
>>                                      use_pde()            [in_use++]
>>                                      allocinfo_start()
>>                                        down_read(&mod_lock)  <- blocks
>>     shutdown_mem_profiling()
>>       remove_proc_entry()
>>         wait for in_use == 0         <- blocks
> 
> Yes, this is indeed a possible race.
> 
>>
>> Move remove_proc_entry() to a workqueue.
>>
>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
> 
> I think all these issues were reported by Sashiko, so you should add a
> Reported-by tag.
> 

Right, I'll add them. Patches 1 and 3 will be resent as a standalone
two-patch series with the Reported-by tags included.
Thanks a lot for all the help on this series.

Thanks
Best Regards
Hao

>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> 
> LGTM
> 
>> ---
>>  mm/alloc_tag.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>> index 7481180dadd2..b80f5a151f28 100644
>> --- a/mm/alloc_tag.c
>> +++ b/mm/alloc_tag.c
>> @@ -591,6 +591,13 @@ void pgalloc_tag_swap(struct folio *new, struct folio *old)
>>         put_page_tag_ref(handle_new);
>>  }
>>
>> +static void remove_allocinfo_file(struct work_struct *work)
>> +{
>> +       remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
>> +}
>> +
>> +static DECLARE_WORK(remove_allocinfo_work, remove_allocinfo_file);
>> +
>>  static void shutdown_mem_profiling(bool remove_file)
>>  {
>>         if (mem_alloc_profiling_enabled())
>> @@ -600,7 +607,7 @@ static void shutdown_mem_profiling(bool remove_file)
>>                 return;
>>
>>         if (remove_file)
>> -               remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
>> +               schedule_work(&remove_allocinfo_work);
>>         mem_profiling_support = false;
>>  }
>>
>> --
>> 2.25.1
>>
