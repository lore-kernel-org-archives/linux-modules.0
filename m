Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6783C4332F
	for <linux-modules@archiver.kernel.org>; Mon, 14 Nov 2022 15:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiKNPqJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 14 Nov 2022 10:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiKNPqI (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 14 Nov 2022 10:46:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979F412D33
        for <linux-modules@vger.kernel.org>; Mon, 14 Nov 2022 07:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668440712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+xPiYnu4pkWEmH1p92vUZspB2keG3AyvQckrQsd//E0=;
        b=EKoKP5UWao+Bv9AqtD51XikItrX/8rsV9J1LcjW4KA5rrV9ePlc+EU4vv94S5052RKA7EJ
        sKc9dbKzz2vvOAC3mj/2Bm1pYefeDk4FdzCqwxIdDEHFTPdkmKf7jsYfPg/8tnhR02lyzK
        wS+4M6GLXAo1a+DD3+J+iosgI6XPT7U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-whiiN-OLNUykc8rf33TGDg-1; Mon, 14 Nov 2022 10:45:09 -0500
X-MC-Unique: whiiN-OLNUykc8rf33TGDg-1
Received: by mail-wr1-f70.google.com with SMTP id i14-20020adfa50e000000b0023652707418so2141567wrb.20
        for <linux-modules@vger.kernel.org>; Mon, 14 Nov 2022 07:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xPiYnu4pkWEmH1p92vUZspB2keG3AyvQckrQsd//E0=;
        b=tlJaCljE2A8h3WgfBfqY2jYiggoFr/1W0c7lT8d76cubTN/jmh/A/ndtQ6hwJ48tGK
         EVZYrEaj4UrfT3kTduhUI49qmWnlwHTs0Q0mnF/yb5JbkopXz8dhU4c+iTzZILBO7Mf5
         p9xwbQe36+2gmS/tdNUZ27J2GUOgWu2AZ6cSevETZhwyOnoKSjm7BhNJOVSvkE3bqaLf
         k902S/lpa1UZMgukfKs437jYgQ4U95UJg0Pkb4EVtzMYCXPpfMIbymUTbQjQrdv6Npi6
         5J3Z/CFgz4PHjKNTwRvQiyrRGPohVjm2fLgsUyOhMmYZQSoL0J0UfiiUiqIU4NMWQYe+
         dYzg==
X-Gm-Message-State: ANoB5plkO1iNy9stuOGxlNVE0WQ2gKdtFoE46mDClAQ31zhlHSTVPtY/
        ldTkR8lkRIusU38u6l7IE1lqZbS6JYo7hck3U4abPoH6aNqHuKEjFXKiB50zg5uxZk/7My3sb6q
        NUmgjAvdkzlI3/ZRNPAYUtyJkMw==
X-Received: by 2002:a1c:7504:0:b0:3cf:7385:7621 with SMTP id o4-20020a1c7504000000b003cf73857621mr8349826wmc.62.1668440707803;
        Mon, 14 Nov 2022 07:45:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Yfvg/80tM1j9uxQlPEghXzgZ+j6SPZGey2mM2dwoYYalADZakvgS1xnMIarRZ1MeXD3QzYw==
X-Received: by 2002:a1c:7504:0:b0:3cf:7385:7621 with SMTP id o4-20020a1c7504000000b003cf73857621mr8349803wmc.62.1668440707478;
        Mon, 14 Nov 2022 07:45:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:d300:d881:1fd5:bc95:5e2d? (p200300cbc703d300d8811fd5bc955e2d.dip0.t-ipconnect.de. [2003:cb:c703:d300:d881:1fd5:bc95:5e2d])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b003c6d21a19a0sm14391032wms.29.2022.11.14.07.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 07:45:06 -0800 (PST)
Message-ID: <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
Date:   Mon, 14 Nov 2022 16:45:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Prarit Bhargava <prarit@redhat.com>, pmladek@suse.com,
        Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
In-Reply-To: <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 14.11.22 16:38, Luis Chamberlain wrote:
> On Mon, Nov 14, 2022 at 09:57:56AM +0100, David Hildenbrand wrote:
>> On 12.11.22 02:47, Luis Chamberlain wrote:
>>> On Wed, Oct 19, 2022 at 02:00:55PM +0200, Petr Pavlu wrote:
>>>> On 10/18/22 20:33, Luis Chamberlain wrote:
>>>>> On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
>>>>>> The patch does address a regression observed after commit 6e6de3dee51a
>>>>>> ("kernel/module.c: Only return -EEXIST for modules that have finished
>>>>>> loading"). I guess it can have a Fixes tag added to the patch.
>>>>>>
>>>>>> I think it is hard to split this patch into parts because the implemented
>>>>>> "optimization" is the fix.
>>>>>
>>>>> git describe --contains 6e6de3dee51a
>>>>> v5.3-rc1~38^2~6
>>>>>
>>>>> I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
>>>>> right thing to do, but without it, it still leaves the issue reported
>>>>> by Prarit Bhargava. We need a way to resolve the issue on stable and
>>>>> then your optimizations can be applied on top.
>>>>
>>>> Simpler could be to do the following:
>>>>
>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>> index d02d39c7174e..0302ac387e93 100644
>>>> --- a/kernel/module/main.c
>>>> +++ b/kernel/module/main.c
>>>> @@ -2386,7 +2386,8 @@ static bool finished_loading(const char *name)
>>>>    	sched_annotate_sleep();
>>>>    	mutex_lock(&module_mutex);
>>>>    	mod = find_module_all(name, strlen(name), true);
>>>> -	ret = !mod || mod->state == MODULE_STATE_LIVE;
>>>> +	ret = !mod || mod->state == MODULE_STATE_LIVE
>>>> +		|| mod->state == MODULE_STATE_GOING;
>>>>    	mutex_unlock(&module_mutex);
>>>>    	return ret;
>>>> @@ -2566,7 +2567,8 @@ static int add_unformed_module(struct module *mod)
>>>>    	mutex_lock(&module_mutex);
>>>>    	old = find_module_all(mod->name, strlen(mod->name), true);
>>>>    	if (old != NULL) {
>>>> -		if (old->state != MODULE_STATE_LIVE) {
>>>> +		if (old->state == MODULE_STATE_COMING
>>>> +		    || old->state == MODULE_STATE_UNFORMED) {
>>>>    			/* Wait in case it fails to load. */
>>>>    			mutex_unlock(&module_mutex);
>>>>    			err = wait_event_interruptible(module_wq,
>>>> @@ -2575,7 +2577,7 @@ static int add_unformed_module(struct module *mod)
>>>>    				goto out_unlocked;
>>>>    			goto again;
>>>>    		}
>>>> -		err = -EEXIST;
>>>> +		err = old->state != MODULE_STATE_LIVE ? -EBUSY : -EEXIST;
>>>>    		goto out;
>>>>    	}
>>>>    	mod_update_bounds(mod);
>>>
>>>
>>> Prarit, can you verify this still does not break the issue you reported?
>>> David, does this also fix your issue?
>>
>> I didn't try, but from a quick glimpse I assume no. Allocating module space
>> happens before handling eventual duplicates right now, before a module even
>> is "alive" and in the MODULE_STATE_UNFORMED state.
> 
> The first two hunks are a revert of commit 6e6de3dee51a and I'm under
> the impression that cauased your issues as *more* modules states are
> allowed through.
> 
> The last hunk tries to fix what 6e6de3dee51a wanted to do.
> 

Note that I don't think the issue I raised is due to 6e6de3dee51a.

>> But maybe I am missing something important.
> 
> Please do test if you can.

I don't have the machine at hand right now. But, again, I doubt this 
will fix it.


The flow is in load_module():

	mod = layout_and_allocate(info, flags);
	if (IS_ERR(mod)) {
		...
	}

	audit_log_kern_module(mod->name);

	/* Reserve our place in the list. */
	err = add_unformed_module(mod);
	if (err)
		goto free_module;


You can have 400 threads in layout_and_allocate() loading the same 
module at the same time and running out of module space. Any changes to 
add_unformed_module() and finished_loading() won't change that, because 
they are not involved before the module space allocations happened.

-- 
Thanks,

David / dhildenb

