Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F3C6FD1D
	for <linux-modules@archiver.kernel.org>; Tue, 21 Mar 2023 15:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjCUPMi (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Mar 2023 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjCUPMd (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Mar 2023 11:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8373FF949
        for <linux-modules@vger.kernel.org>; Tue, 21 Mar 2023 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679411494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YsalzkC56zpU2rDmbQ0VUjilQkDx+3Gh+sNLgCZQJM0=;
        b=X0dIziM03dI/bEU2RpvHj58Q8p9RRmyycCFtjRHV7uWAHIJ3GsJ2KqabCXVZGgePlMCAIq
        PdE2rqwPdyd9EOzfJeJQS/5e4ZGE7NixJGKn6UJly75D/B3ACl8+DW2d4qDERcKEZnJKfo
        uvKD++REiLmEzuxKxAtDBGwR2sBn5pI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-xKdnNX3hOCyghF5Hf0srPA-1; Tue, 21 Mar 2023 11:11:32 -0400
X-MC-Unique: xKdnNX3hOCyghF5Hf0srPA-1
Received: by mail-wr1-f71.google.com with SMTP id bn9-20020a056000060900b002cfe8493fe6so1809105wrb.4
        for <linux-modules@vger.kernel.org>; Tue, 21 Mar 2023 08:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679411489;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsalzkC56zpU2rDmbQ0VUjilQkDx+3Gh+sNLgCZQJM0=;
        b=k9clPKLe/36S+EMvxwm2X2xSwgx2zJiZmVe9bzX+olNDX4oQWSANABdThyElWJjyo2
         XfyAvkKBHJ1wgAxssC13TpAEEpp+bLVcysm1QnDSyEQFM4aumwZIZ2wYyCoYpJQPR1G9
         x37mAxIl8vtATzGd/794JpGN/k7wTpSwse/bhHvuo1g0QkXumpc9kHLppbTWdbIKOjt5
         eNdFYaok6zllk/6V0ZYhLHIqD62bG02z+Pg6P1YiEaN/vCLPZxhaanvpA3IsLTuGVdg6
         TTAX3VkIR40+DcgizuQ0UzhTVX6ZupkMdbz0u4Ck5JSMMIGKbdv9rHqH28n3mSGCvvZt
         pukw==
X-Gm-Message-State: AO0yUKU43GoHFNsQLfAMDgpwCqyK/ZpiTF136UMc+0w5e7iE26Rd6v8V
        6L6d3AvR+SKDgHzSCaVuyZaivjFBUMbaqnvnJaGJcOf+iYvPXcCqR/6taZYObOieG5lPwlIBbMB
        zEwOnEyQVR/2llrlq3jrE7PrD/g==
X-Received: by 2002:a7b:c7cf:0:b0:3ed:5a7d:fcfe with SMTP id z15-20020a7bc7cf000000b003ed5a7dfcfemr2751332wmk.3.1679411489765;
        Tue, 21 Mar 2023 08:11:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set8c5q656St+C8eydyBRX4ly1NSD5lwVif694CoWt4z3/ARNNlS3mU+K2K0zfpCc8MVaWwcWxQ==
X-Received: by 2002:a7b:c7cf:0:b0:3ed:5a7d:fcfe with SMTP id z15-20020a7bc7cf000000b003ed5a7dfcfemr2751310wmk.3.1679411489460;
        Tue, 21 Mar 2023 08:11:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7f00:8245:d031:7f8b:e004? (p200300cbc7057f008245d0317f8be004.dip0.t-ipconnect.de. [2003:cb:c705:7f00:8245:d031:7f8b:e004])
        by smtp.gmail.com with ESMTPSA id v26-20020a05600c215a00b003eafc47eb09sm13666500wml.43.2023.03.21.08.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 08:11:28 -0700 (PDT)
Message-ID: <eaa75ce0-7064-7919-0e72-6bb4ccc5d0d6@redhat.com>
Date:   Tue, 21 Mar 2023 16:11:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
References: <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
 <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
 <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
 <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 20.03.23 22:23, Luis Chamberlain wrote:
> On Mon, Mar 20, 2023 at 10:15:23PM +0100, David Hildenbrand wrote:
>> On 20.03.23 22:09, Luis Chamberlain wrote:
>>> On Mon, Mar 20, 2023 at 08:40:07PM +0100, David Hildenbrand wrote:
>>>> On 20.03.23 10:38, David Hildenbrand wrote:
>>>>> On 18.03.23 01:11, Luis Chamberlain wrote:
>>>>>> On Thu, Mar 16, 2023 at 04:56:56PM -0700, Luis Chamberlain wrote:
>>>>>>> On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
>>>>>>>> On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
>>>>>>>>> I expect to have a machine (with a crazy number of CPUs/devices) available
>>>>>>>>> in a couple of days (1-2), so no need to rush.
>>>>>>>>>
>>>>>>>>> The original machine I was able to reproduce with is blocked for a little
>>>>>>>>> bit longer; so I hope the alternative I looked up will similarly trigger the
>>>>>>>>> issue easily.
>>>>>>>>
>>>>>>>> OK give this a spin:
>>>>>>>>
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts
>>>>>>
>>>>>> Today I am up to here:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230317-module-alloc-opts
>>>>>>
>>>>>> The last patch really would have no justification yet at all unless it
>>>>>> does help your case.
>>>>>
>>>>> Still waiting on the system (the replacement system I was able to grab
>>>>> broke ...).
>>>>>
>>>>> I'll let you know once I succeeded in reproducing + testing your fixes.
>>>>
>>>> Okay, I have a system where I can reproduce.
>>>>
>>>> Should I give
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts
>>>>
>>>> from yesterday a churn?
>>>
>>> Yes please give that a run.
>>
>> Reproduced with v6.3.0-rc1 (on 1st try)
> 
> By reproduced, you mean it fails to boot?

It boots but we get vmap allocation warnings, because the ~440 CPUs 
manage to completely exhaust the module vmap area due to KASAN.

> 
>> Not able to reproduce with 20230319-module-alloc-opts so far (2 tries).
> 
> Oh wow, so to clarify, it boots OK?

It boots and I don't get the vmap allocation warnings.

> 
>>> Please collect systemd-analyze given lack of any other tool to evaluate
>>> any deltas. Can't think of anything else to gather other than seeing if
>>> it booted.
>>
>> Issue is that some services (kdump, tuned) seem to take sometimes ages on
>> that system to start for some reason,
> 
> How about disabling that?

It seems to be random services. On my debug kernel with KASAN everything 
is just super slow. I'll try to measure on a !debug kernel.

-- 
Thanks,

David / dhildenb

