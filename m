Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C49C7619A
	for <linux-modules@archiver.kernel.org>; Tue, 21 Mar 2023 17:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCURCf (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCURCe (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Mar 2023 13:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215FBCC2D
        for <linux-modules@vger.kernel.org>; Tue, 21 Mar 2023 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679418105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lcFH3Gw2MS2hxoUbFfkXJb2/O9gx/UdG3VWmXz/ijFE=;
        b=b6zKlhUNbrAKjiqWHj3pLkeZLH1KyI1tSoHmc9RFuBFEGVIAJ8vRNXTb/y8vR4NSE6KtsL
        whl/Cwnp5sY4xK1oINULaGaT4J3i9FdurqYAUJQfy5kI5COX8ZHuFBp8FlrmUShtIn+dou
        Hk8CV23JOXMvxgJ2gw3MHPM4a2aCayo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-1MufQ2sCMGG0oymTzm7eUA-1; Tue, 21 Mar 2023 13:01:43 -0400
X-MC-Unique: 1MufQ2sCMGG0oymTzm7eUA-1
Received: by mail-wm1-f70.google.com with SMTP id m30-20020a05600c3b1e00b003ed31d151ecso6203993wms.1
        for <linux-modules@vger.kernel.org>; Tue, 21 Mar 2023 10:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418102;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcFH3Gw2MS2hxoUbFfkXJb2/O9gx/UdG3VWmXz/ijFE=;
        b=SRBTzblOUq2CBC9Vn86jS8Mgtb9RitZWvSZ4udThqar7eWB/g41lj7O2T5YY9zeWYz
         RBVzuxg76t1bSEXoAipHluQmWDTz46JNmKyjdi3B9149Vtho3rEKJrMAF9jxTdIK90Bm
         E1uc6DG3hJQGUhP/HtCNAfTMsuJdFvWjoc0oJu6QShB9imVejfX+vQpE8sh0dxZBavyf
         n9+0I4hrgdN48q7MQ0Gh8yz+4E17K5dCXHPxiuCZv5+6QZ+Tkc2ybIg5wRF9ZOimY8xS
         EewPU3oGfYUnCyN2AP9io52gA0zliCEWE6WZhwAKIXwiIyjXKB2b9S2TQ8vwCieRZ34p
         PPyA==
X-Gm-Message-State: AO0yUKUVmJ6RTWUxUUWH4ykCTjD5/zSAJ7ggmoM+pEpYw9M0VWErFmnR
        EVSRoq43qtj2HryMR94i8P3LYbor1AYu+bdQdf7SHzW1xFMS3uZVE5z07sWva4rjyX5krtlnYHy
        7gQNz/E7xa0OGD4LGNJsP4OBu6Q==
X-Received: by 2002:a05:6000:10d0:b0:2ce:a7f6:2fe5 with SMTP id b16-20020a05600010d000b002cea7f62fe5mr3069233wrx.60.1679418102729;
        Tue, 21 Mar 2023 10:01:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set8H4j1IS2DP9wgMOOzB3lkgc0urxBfNv94zaRLD/dw6IB/eqVFyZlA2Ttlu6q9hf9hZ1CwfOA==
X-Received: by 2002:a05:6000:10d0:b0:2ce:a7f6:2fe5 with SMTP id b16-20020a05600010d000b002cea7f62fe5mr3069210wrx.60.1679418102393;
        Tue, 21 Mar 2023 10:01:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7f00:8245:d031:7f8b:e004? (p200300cbc7057f008245d0317f8be004.dip0.t-ipconnect.de. [2003:cb:c705:7f00:8245:d031:7f8b:e004])
        by smtp.gmail.com with ESMTPSA id a7-20020adff7c7000000b002c70ce264bfsm11856785wrq.76.2023.03.21.10.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 10:01:41 -0700 (PDT)
Message-ID: <d8318657-f119-b0f3-cfb8-ed314a8144e6@redhat.com>
Date:   Tue, 21 Mar 2023 18:01:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
References: <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
 <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <eaa75ce0-7064-7919-0e72-6bb4ccc5d0d6@redhat.com>
 <ZBng0qnm/ADtSTBQ@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBng0qnm/ADtSTBQ@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 21.03.23 17:52, Luis Chamberlain wrote:
> On Tue, Mar 21, 2023 at 04:11:27PM +0100, David Hildenbrand wrote:
>> On 20.03.23 22:23, Luis Chamberlain wrote:
>>> On Mon, Mar 20, 2023 at 10:15:23PM +0100, David Hildenbrand wrote:
>>>> On 20.03.23 22:09, Luis Chamberlain wrote:
>>>>> On Mon, Mar 20, 2023 at 08:40:07PM +0100, David Hildenbrand wrote:
>>>>>> On 20.03.23 10:38, David Hildenbrand wrote:
>>>>>>> On 18.03.23 01:11, Luis Chamberlain wrote:
>>>>>>>> On Thu, Mar 16, 2023 at 04:56:56PM -0700, Luis Chamberlain wrote:
>>>>>>>>> On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
>>>>>>>>>> On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
>>>>>>>>>>> I expect to have a machine (with a crazy number of CPUs/devices) available
>>>>>>>>>>> in a couple of days (1-2), so no need to rush.
>>>>>>>>>>>
>>>>>>>>>>> The original machine I was able to reproduce with is blocked for a little
>>>>>>>>>>> bit longer; so I hope the alternative I looked up will similarly trigger the
>>>>>>>>>>> issue easily.
>>>>>>>>>>
>>>>>>>>>> OK give this a spin:
>>>>>>>>>>
>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts
>>>>>>>>
>>>>>>>> Today I am up to here:
>>>>>>>>
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230317-module-alloc-opts
>>>>>>>>
>>>>>>>> The last patch really would have no justification yet at all unless it
>>>>>>>> does help your case.
>>>>>>>
>>>>>>> Still waiting on the system (the replacement system I was able to grab
>>>>>>> broke ...).
>>>>>>>
>>>>>>> I'll let you know once I succeeded in reproducing + testing your fixes.
>>>>>>
>>>>>> Okay, I have a system where I can reproduce.
>>>>>>
>>>>>> Should I give
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts
>>>>>>
>>>>>> from yesterday a churn?
>>>>>
>>>>> Yes please give that a run.
>>>>
>>>> Reproduced with v6.3.0-rc1 (on 1st try)
>>>
>>> By reproduced, you mean it fails to boot?
>>
>> It boots but we get vmap allocation warnings, because the ~440 CPUs manage
>> to completely exhaust the module vmap area due to KASAN.
> 
> Thanks, can you post a trace?

See

https://lkml.kernel.org/r/20221013180518.217405-1-david@redhat.com

where I also describe the issue in more detail.

> 
>>>> Not able to reproduce with 20230319-module-alloc-opts so far (2 tries).
>>>
>>> Oh wow, so to clarify, it boots OK?
>>
>> It boots and I don't get the vmap allocation warnings.
> 
> Wonderful!

I'm still compiling/testing the debug kernels 
(20230319-module-alloc-opts-adjust +  single revert of the rcu patch). I 
should have some systemd-analyze results for !debug kernels later.

-- 
Thanks,

David / dhildenb

