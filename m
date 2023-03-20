Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3A4C761AF
	for <linux-modules@archiver.kernel.org>; Mon, 20 Mar 2023 19:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjCTTpZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 20 Mar 2023 15:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjCTToz (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 20 Mar 2023 15:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC743270F
        for <linux-modules@vger.kernel.org>; Mon, 20 Mar 2023 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679341211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JX45utUIC7hI1qYbp3xg6KRxTGUFDZZZdRkQSxIo/4s=;
        b=LOMPpeTQNGw6tSQie8SuGYc+WBKcVZFO2ymTT/9L++p634yLTNuuRSOq1N1pRuJTyLrm0O
        abgmU4q3vjvB3honeXcFvQMWR1rj2npC7AGG0g6cuZ376NQyqMPUA9t1zfs4hz/8GCedv6
        aBPLMHAgSgp0dbxpfJs+iMY7F45ms+0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-3dAx7DIWOtqXptXnBO8RFg-1; Mon, 20 Mar 2023 15:40:10 -0400
X-MC-Unique: 3dAx7DIWOtqXptXnBO8RFg-1
Received: by mail-wr1-f70.google.com with SMTP id h18-20020adfa4d2000000b002cea098a651so1553578wrb.3
        for <linux-modules@vger.kernel.org>; Mon, 20 Mar 2023 12:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679341209;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JX45utUIC7hI1qYbp3xg6KRxTGUFDZZZdRkQSxIo/4s=;
        b=ABQTWLoACKin82qIt8XY4MMezZAofbmLbr587XgZRfjbgU2MfPo2QVtb8ytS47xlR4
         B7NhtvN36CntUS1oXYiigU1U7+MvGz3pHHfV7IKC7etmSAXtNMaRUiTx3FVscVzqRmST
         ZlLsns5XubaVmHY4E0NQ3i838TqF/JY9JDp+SyqQIR+nuLLveIucrQzn50ORo6pcU6AD
         2wS/SIAp6oruyfy5PfIqj8Xv00NYB4iooL3tg+BjdF4TNvcs/gl84pRFYqjhBGSGzTgJ
         RKip/5C8lJfzHOeqiURz+s8xzGXQcc8DjeyT/2YmRfOb1/kNwgQNrnvftbYcqznXKzfb
         0DBw==
X-Gm-Message-State: AO0yUKUArdylHcr5mwnWdDEhRMTB5TdJ/CmpQJdTpS7T3umbb8nnVhLQ
        FtxmQ4GH1rShAvOyUjd555pKxVm+/NH2AO8HoflDFx3QbR2J3swAoQhglUCg1OHmE53wXVOgjoV
        /sAaXkQZms/DtZc9ruOiJWmPDqg==
X-Received: by 2002:a1c:f718:0:b0:3eb:389d:156c with SMTP id v24-20020a1cf718000000b003eb389d156cmr436946wmh.37.1679341209443;
        Mon, 20 Mar 2023 12:40:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set9nsShGK8n5z0GUDsaUOWY/sI3LQt6u5/RPo38YRxXb+8+DHrB0HpAf6jJ5DEhNevfct5XXdg==
X-Received: by 2002:a1c:f718:0:b0:3eb:389d:156c with SMTP id v24-20020a1cf718000000b003eb389d156cmr436937wmh.37.1679341209147;
        Mon, 20 Mar 2023 12:40:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id q2-20020a1ce902000000b003ed1fa34bd3sm11332380wmc.13.2023.03.20.12.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 12:40:08 -0700 (PDT)
Message-ID: <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
Date:   Mon, 20 Mar 2023 20:40:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
References: <20230311051712.4095040-1-mcgrof@kernel.org>
 <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
 <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
 <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
 <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
Organization: Red Hat
In-Reply-To: <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 20.03.23 10:38, David Hildenbrand wrote:
> On 18.03.23 01:11, Luis Chamberlain wrote:
>> On Thu, Mar 16, 2023 at 04:56:56PM -0700, Luis Chamberlain wrote:
>>> On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
>>>> On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
>>>>> I expect to have a machine (with a crazy number of CPUs/devices) available
>>>>> in a couple of days (1-2), so no need to rush.
>>>>>
>>>>> The original machine I was able to reproduce with is blocked for a little
>>>>> bit longer; so I hope the alternative I looked up will similarly trigger the
>>>>> issue easily.
>>>>
>>>> OK give this a spin:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts
>>
>> Today I am up to here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230317-module-alloc-opts
>>
>> The last patch really would have no justification yet at all unless it
>> does help your case.
> 
> Still waiting on the system (the replacement system I was able to grab
> broke ...).
> 
> I'll let you know once I succeeded in reproducing + testing your fixes.

Okay, I have a system where I can reproduce.

Should I give

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts

from yesterday a churn?

-- 
Thanks,

David / dhildenb

