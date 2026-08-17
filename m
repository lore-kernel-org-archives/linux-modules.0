Received: from mta1.migadu.com (out-247.mta1.migadu.com [95.215.58.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933612CDA5
	for <linux-modules@vger.kernel.org>; Mon, 17 Aug 2026 05:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943099; cv=none; b=EHHRhaXw65hGhoelQ+rqp52gTWXRcu8hfJsDIDlQe8AWR6uOat+QLs3inX9OkDTPM9EpusPqKMeSUQmM9ztb3GyIr+2oFHfrydLFG/FcFyNfCey0t5ZjpCzx57lmWEKX12qQBMDhFrDa9BhgXEdHRaqSrgHbgXLYkNVSYsT5dvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943099; c=relaxed/simple;
	bh=zZ6GXwC5OG4b5xcls/Kj0bSMKnufqj9IxmzWaj0rIqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXDWUAyU8lNVdPkAnFoFXOLJ4yPoMLguKNYTxtcJmuBBB3lkeJOIghb+lG9DLylrfcO3wTB6eyZqApeBtZjfZ4hRrzohP97Yq7u1LEKnFNvoflniGY+blleURpkAG+Gj4A849h3WEb1r7jwL8QCmJvcfPIwmMRdZZdzCvoo3EgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HXw63Snk; arc=none smtp.client-ip=95.215.58.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HXw63Snk"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zZ6GXwC5OG4b5xcls/Kj0bSMKnufqj9IxmzWaj0rIqQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786943095; v=1; x=1787547895;
 b=HXw63SnkTarUFftqNxeC993R4l0BP1quQYnLVYcO85cZKsIwwBan/e8cRqzLDu24hTPeYh4H
 UN71qFRE3eP48C//7BnFi/dYAS44cZLsZtYCuJM/weegDyLjiZ7pZqxUuv8EcaNd4iVfcPe47I4
 vHOvnl4kYklwWdsHnmv98Cis=
X-Envelope-To: linux-modules@vger.kernel.org
Received: from [10.42.12.33] (116.128.244.169)
	by smtp.migadu.com with ESMTPS id abd4cd8211b2a0ad;
	Mon, 17 Aug 2026 05:04:55 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <e19d1b50-4d10-4833-8770-5003a0593518@linux.dev>
Date: Mon, 17 Aug 2026 13:05:36 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] alloc_tag: skip percpu counter allocation when
 profiling is disabled
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260813093421.135230-1-hao.ge@linux.dev>
 <20260813093421.135230-2-hao.ge@linux.dev>
 <CAJuCfpHAzhCC1Sx3uJr7kbhBzc7RFqwLhMyjo04hqZz=HBJH8Q@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpHAzhCC1Sx3uJr7kbhBzc7RFqwLhMyjo04hqZz=HBJH8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren


On 2026/8/15 14:15, Suren Baghdasaryan wrote:
> On Thu, Aug 13, 2026 at 2:34 AM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> After shutdown_mem_profiling() clears mem_profiling_support,
>> needs_section_mem() returns false, so later modules have their codetag
>> section placed as regular data and never enter the alloc_tag maple tree.
>> codetag_load_module() still called load_module(), which allocated a percpu
>> counter for every tag; release_module_tags() could not find these modules
>> on unload, so the counters leaked.
>>
>> Return CODETAG_MODULE_EXCLUDED from load_module() when profiling is off:
>> codetag_module_init() drops the module's cmod and no counters are
>> allocated. codetag_unload_module() now always calls free_section_mem(),
>> since an excluded module may still hold a reserved section.
>>
>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> 
> Thanks for the fix. I think it could be done simpler, see below.

Agree, will do in the next version.

> 
>> ---
>>  include/linux/codetag.h | 4 ++++
>>  lib/codetag.c           | 8 +++++---
>>  mm/alloc_tag.c          | 8 ++++++--
>>  3 files changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
>> index a25a085c2df1..88081c618673 100644
>> --- a/include/linux/codetag.h
>> +++ b/include/linux/codetag.h
>> @@ -52,6 +52,10 @@ struct codetag_type_desc {
>>  #endif
>>  };
>>
>> +/* module_load() return values */
>> +#define CODETAG_MODULE_LOAD    0       /* module loads with its tags */
>> +#define CODETAG_MODULE_EXCLUDED        1       /* module loads without its tags */
> 
> I see no reason for adding these special values. You could simply
> return -ENOTSUP when profiling is disabled.
> 
>> +
>>  struct codetag_iterator {
>>         struct codetag_type *cttype;
>>         struct codetag_module *cmod;
>> diff --git a/lib/codetag.c b/lib/codetag.c
>> index a9cda4c962a3..8506ecab9ea7 100644
>> --- a/lib/codetag.c
>> +++ b/lib/codetag.c
>> @@ -238,9 +238,10 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
>>         }
>>         up_write(&cttype->mod_lock);
>>
>> -       if (err < 0) {
>> +       if (err) {
>> +               /* Error or excluded: cmod is dropped, free it. */
> 
> IIUC here you want to call kfree() if profiling got disabled. If you
> return -ENOTSUP instead of CODETAG_MODULE_EXCLUDED then this condition
> does not need to change.
> 
>>                 kfree(cmod);
>> -               return err;
>> +               return err < 0 ? err : 0;
> 
> Here you can do:
>                     if (err && err != -ENOTSUP)
>                             return err;
>                    return 0;
> 
>>         }
>>
>>         return 0;
>> @@ -388,7 +389,8 @@ void codetag_unload_module(struct module *mod)
>>                         ++cttype->content_id;
>>                 }
>>                 up_write(&cttype->mod_lock);
>> -               if (found && cttype->desc.free_section_mem)
>> +               /* an excluded module may still hold section memory */
>> +               if (cttype->desc.free_section_mem)
>>                         cttype->desc.free_section_mem(mod, true);
>>         }
>>         mutex_unlock(&codetag_lock);
>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>> index 0a7b657fe2de..461fa87fbb0b 100644
>> --- a/mm/alloc_tag.c
>> +++ b/mm/alloc_tag.c
>> @@ -977,9 +977,13 @@ static int load_module(struct module *mod, struct codetag *start, struct codetag
>>         struct alloc_tag *stop_tag;
>>         struct alloc_tag *tag;
>>
>> +       /* Profiling disabled: load the module but exclude its tags. */
>> +       if (!mem_profiling_support)
>> +               return CODETAG_MODULE_EXCLUDED;
> 
> Return -ENOTSUP here.
> 
> 
> 
>> +
>>         /* percpu counters for core allocations are already statically allocated */
>>         if (!mod)
>> -               return 0;
>> +               return CODETAG_MODULE_LOAD;
>>
>>         start_tag = ct_to_alloc_tag(start);
>>         stop_tag = ct_to_alloc_tag(stop);
>> @@ -1002,7 +1006,7 @@ static int load_module(struct module *mod, struct codetag *start, struct codetag
>>                  */
>>                 kmemleak_ignore_percpu(tag->counters);
>>         }
>> -       return 0;
>> +       return CODETAG_MODULE_LOAD;
>>  }
>>
>>  static void replace_module(struct module *mod, struct module *new_mod)
>> --
>> 2.25.1
>>
