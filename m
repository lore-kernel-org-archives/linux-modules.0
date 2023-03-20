Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15CDC7618A
	for <linux-modules@archiver.kernel.org>; Mon, 20 Mar 2023 09:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCTJkC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 20 Mar 2023 05:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCTJj0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 20 Mar 2023 05:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A62F24130
        for <linux-modules@vger.kernel.org>; Mon, 20 Mar 2023 02:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679305097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGDPRnw1QH/lCuH6pKurUzPJ4+UKHmuK/kwnuU0RCE0=;
        b=Np3xjSLVxlPBxbUr90JQAdCYqWnUD5ocYX5VTOQqPuNKaYuxSLhkK3xB1FFMZHKML7GphT
        AXstycxiW+5T3Ju4bAKTXNJg8DXzSbU+l1DkOpVerNOBUfq2+mzKwcJv6KtgQ46S0lF73F
        PEUgXMTt4+fTHD8/XEdyI6i26815DRc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-9BetDz8SNiC3s-IwlK6V8g-1; Mon, 20 Mar 2023 05:38:16 -0400
X-MC-Unique: 9BetDz8SNiC3s-IwlK6V8g-1
Received: by mail-wr1-f70.google.com with SMTP id j17-20020adfb311000000b002d660153278so219317wrd.20
        for <linux-modules@vger.kernel.org>; Mon, 20 Mar 2023 02:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679305095;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGDPRnw1QH/lCuH6pKurUzPJ4+UKHmuK/kwnuU0RCE0=;
        b=z9HeDs8bJz3lxTQHAAQJlUFLy1TX7A09F82BYnJgR5lWHby8g7Y1h0RCcJu/u38fL1
         o0O2GVyR9stEzPG7bWkMmrhUBfKDSnUlCymb9UsFl6A1zsDwDzmnlAgpGYOSjblI78s4
         1ybB+dcdGE9RKwsZuoKombHeb9GhQ5cX2v8jZwhWQvxJ2icewtVB41+eer8PqUo2qj5k
         RBjp/1ZLfVvpdD4ixfRpyLveqVaXSzf7z183p8DQ6BY+KjiuG2autn19nL2pv4ZhH0q5
         xOzgB+bYu/sZDt9FXvkQFtBNwXSn+ega31fVTC5uDOiybI4hrSOUKVExIgJHwjwZLRtb
         pkZA==
X-Gm-Message-State: AO0yUKUE/J0XK3ZdeGUNQF23m+M/RzDBNbxJUHRZmcumfRCMdPusMS3q
        9mFIBSsjgBUOSIIio884rYNMTd6cIab5B1cw7bEwfVHfneCpfWDS9XlI/qeE27M74nWP9LazYYv
        XgPmcZTIu7NWz0s/Gg2IEFtp59A==
X-Received: by 2002:a05:600c:3109:b0:3eb:3104:efef with SMTP id g9-20020a05600c310900b003eb3104efefmr31671905wmo.31.1679305095223;
        Mon, 20 Mar 2023 02:38:15 -0700 (PDT)
X-Google-Smtp-Source: AK7set83QC9uGibITnAfeztg19NJ6jZYL/XkfE0u7xq+2shUYwd5s2SuVvFk8M0/NRZRSHy0WjJUeg==
X-Received: by 2002:a05:600c:3109:b0:3eb:3104:efef with SMTP id g9-20020a05600c310900b003eb3104efefmr31671894wmo.31.1679305094944;
        Mon, 20 Mar 2023 02:38:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id h10-20020adffa8a000000b002ce3d3d17e5sm8518881wrr.79.2023.03.20.02.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 02:38:14 -0700 (PDT)
Message-ID: <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
Date:   Mon, 20 Mar 2023 10:38:13 +0100
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
 <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
 <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 18.03.23 01:11, Luis Chamberlain wrote:
> On Thu, Mar 16, 2023 at 04:56:56PM -0700, Luis Chamberlain wrote:
>> On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
>>> On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
>>>> I expect to have a machine (with a crazy number of CPUs/devices) available
>>>> in a couple of days (1-2), so no need to rush.
>>>>
>>>> The original machine I was able to reproduce with is blocked for a little
>>>> bit longer; so I hope the alternative I looked up will similarly trigger the
>>>> issue easily.
>>>
>>> OK give this a spin:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts
> 
> Today I am up to here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230317-module-alloc-opts
> 
> The last patch really would have no justification yet at all unless it
> does help your case.

Still waiting on the system (the replacement system I was able to grab 
broke ...).

I'll let you know once I succeeded in reproducing + testing your fixes.

-- 
Thanks,

David / dhildenb

