Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D09C6FD1D
	for <linux-modules@archiver.kernel.org>; Wed, 15 Mar 2023 16:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCOQrI (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 15 Mar 2023 12:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjCOQrB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 15 Mar 2023 12:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288CF1BACE
        for <linux-modules@vger.kernel.org>; Wed, 15 Mar 2023 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678898706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ish4HOwYk+bfvweZUG7R/ggOz5EHjTFqrtCH+lkNtE0=;
        b=Nqep7BdHDPs8tbbVQ1jGDV5+GvC4VaQLvQMfaelQisPlQX0UDocRr8eNRfNb4BOE89PY6f
        nkythqlqTfuWZYUmQbj+rLliAM6E+7Wtap9Wee2ObYn6x7XyIK0y5sssPsoN1MllEnFaap
        BxpR0CI4QY/xmJc0YlhnIAdkqjnv7gE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-OPELtO5dNwKAfLo7EE7Hsw-1; Wed, 15 Mar 2023 12:41:56 -0400
X-MC-Unique: OPELtO5dNwKAfLo7EE7Hsw-1
Received: by mail-wm1-f70.google.com with SMTP id v8-20020a05600c470800b003ed3b575374so420159wmo.7
        for <linux-modules@vger.kernel.org>; Wed, 15 Mar 2023 09:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678898515;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ish4HOwYk+bfvweZUG7R/ggOz5EHjTFqrtCH+lkNtE0=;
        b=n7E1C9hE3jkw6+csiYVzJK07pNpt3cCyAfGf4bX+4tRQMHIN7nAu9bj3XZH1d7rshf
         yDav/vBRdDFzp59w2EqYGQCQ+VGwHQzScRTI2Q7uY/gWb0CXLpzC6PFyqMHvxKxiHCeQ
         gkqKMd1o0G/d1LaM23JeoPPqF9uokWWRTrt+r/ydtyIeli4frTRKriimAiEh6lQvLaU3
         D7A5bXk1+f6UDRe9SBxfX3PfzFgogTu2c37z2Od7Y4RYoeMIAOqFb0q3b7foBu7MVQvI
         wUFs90VH47j3myuCbXG3SA0D56U9DSwmXey6PPLSzwccYFVCvli+6loW1GxMawJoc1XC
         tKJg==
X-Gm-Message-State: AO0yUKXXKmUnG5vsBv7JERTJFcb8Vh2GHgXuzLJFIp9sr9Z09iJmOfbS
        zNQfXQ2FkS+Rg2opp3XEWOQjmH5Q4SkGI3PgF6cGQyl9U949Sw4S5Q2v2jNpnOUJahWvyoRrPDj
        1BazZBa7HSQ7zOG9FpbD5N8Y89Q==
X-Received: by 2002:a05:600c:1d29:b0:3eb:3945:d3f4 with SMTP id l41-20020a05600c1d2900b003eb3945d3f4mr21233147wms.2.1678898514909;
        Wed, 15 Mar 2023 09:41:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set+MrHac4o2ZwkDMHboYyrIICw8C859iTL0x1tIQW0QrRbGroJmH92hX+qLCk/+Iv4fZd3Aa9w==
X-Received: by 2002:a05:600c:1d29:b0:3eb:3945:d3f4 with SMTP id l41-20020a05600c1d2900b003eb3945d3f4mr21233131wms.2.1678898514603;
        Wed, 15 Mar 2023 09:41:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:2f00:2038:213d:e59f:7d44? (p200300cbc7022f002038213de59f7d44.dip0.t-ipconnect.de. [2003:cb:c702:2f00:2038:213d:e59f:7d44])
        by smtp.gmail.com with ESMTPSA id l4-20020a1c7904000000b003ed1ff06faasm2324765wme.19.2023.03.15.09.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:41:54 -0700 (PDT)
Message-ID: <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
Date:   Wed, 15 Mar 2023 17:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
References: <20230311051712.4095040-1-mcgrof@kernel.org>
 <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
 <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 15.03.23 17:10, Luis Chamberlain wrote:
> On Wed, Mar 15, 2023 at 01:24:41PM +0100, David Hildenbrand wrote:
>> On 11.03.23 06:17, Luis Chamberlain wrote:
>>> A long time ago we had some issues with userspace doing stupid stuff.
>>> Well, it turns out even the kernel and do stupid stuff too, as we're
>>> learning with the ACPI modules aliaes and that hammering tons of loads.
>>>
>>> So add a bit of code which gets us a bit more in the defensive about
>>> these situations.
>>>
>>> To experiment, this also adds in-kernel alias support to see if this helps
>>> with some larger systems.
>>>
>>> This is all based on some old code which tried to add defensive
>>> mechanisms the last of which was here and I had dropped the ball:
>>>
>>> https://lore.kernel.org/all/20171208001540.23696-1-mcgrof@kernel.org/
>>>
>>> I've only compile tested this for now. Will need to stress to test
>>> with kmod tests 0008 and 0009 to see if there's any differences.
>>> I'll have to re-test and re-gnuplot stuff there. But early feedback
>>> is appreciated, hence the RFC.
>>>
>>> David Hildenbrand had reported a while ago issues with userspace
>>> doing insane things with allocations bringing a system down to
>>> its knees. This is part of the motivation for this series.
>>
>>
>> I'll try to grab a system where I can reproduce the issue and give your
>> patches a churn.
> 
> Great, then please wait for v2 RFC as the first patch was missing an
> obvious mutex grab / release, I already have some memory pressure data
> that shows gains. Hope to post soon.

I expect to have a machine (with a crazy number of CPUs/devices) 
available in a couple of days (1-2), so no need to rush.

The original machine I was able to reproduce with is blocked for a 
little bit longer; so I hope the alternative I looked up will similarly 
trigger the issue easily.

-- 
Thanks,

David / dhildenb

