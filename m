Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B88C6FD1D
	for <linux-modules@archiver.kernel.org>; Mon, 20 Mar 2023 09:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjCTJi7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 20 Mar 2023 05:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjCTJik (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 20 Mar 2023 05:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1615C1E1CC
        for <linux-modules@vger.kernel.org>; Mon, 20 Mar 2023 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679305062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSehupr3ZQFIxZG5J2UEktXA19d5C1cRws69ufPXWy0=;
        b=Eu6rIWz7r8r5bX/OBbbAWaXq4kUI34FlNCfrdMYb1eJFczcbyvNs6W6i0gQDYnHbIvjTBF
        isJX+O5z1ULpY1YlmRj2JTHXvkLVKstBu3KWr1RaiR0DPxpmB8oEsbMKs6h/vNstqIEHlX
        O8zuYg+ULiSNhptV/hZDPz82pXZucrg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-Q-_kDVybP4OEluzTJugQug-1; Mon, 20 Mar 2023 05:37:41 -0400
X-MC-Unique: Q-_kDVybP4OEluzTJugQug-1
Received: by mail-wm1-f71.google.com with SMTP id m30-20020a05600c3b1e00b003ed31d151ecso4168987wms.1
        for <linux-modules@vger.kernel.org>; Mon, 20 Mar 2023 02:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679305060;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSehupr3ZQFIxZG5J2UEktXA19d5C1cRws69ufPXWy0=;
        b=A2Eoyyn05l25zFvmO0Ah4OPJMlFRVcOq0CcCfd7mawH8HbmMQTThJ658E9nctShVBF
         UfwY//A8PIoe6TZqoyvi3eH9m76Wjf1sC+SdAwBpMKS356aWO1J1gYiYh3NEebFdXJSH
         kEwaRw6ptV9uvCFHvhBcCpY3ae1t5jrGxHmnxYctKub6whD6njJzkIh72lLA93QaDe4R
         zDk5uQFMUJ2hq5nuAlwz4B9CHF1eQOyvw/O1zJl3lu2zhUgtel54PHtf46YCZYx/J2+Q
         3nE80aPacTyW3qzHFZx7aXsie5Zoba7I02eAkTPUm/F9Sw5SECorf6XHMbTAt1UJuaJr
         a59Q==
X-Gm-Message-State: AO0yUKXbPBh1Ngjs44LSVqW1adIMv9e6iTmRa4A6NQ9YBFi99TADl9WU
        V8vs+QP/bq0kOHWTbvfWymBE6pldTnevEcJiTjDX522cMbOPiqr4gbadHE8B0b6yxLi+PApx+UD
        oDd15dEfwwJHaVVAp8AehQEh7nw==
X-Received: by 2002:adf:e74b:0:b0:2cf:e3d8:5dff with SMTP id c11-20020adfe74b000000b002cfe3d85dffmr12265914wrn.9.1679305059956;
        Mon, 20 Mar 2023 02:37:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set8/r56O578u5RSgT8sy/rU880Ts62o7ET9TXhnWuxBe7vr18+YzsfivcSxLVJ6J57cPrNNMlw==
X-Received: by 2002:adf:e74b:0:b0:2cf:e3d8:5dff with SMTP id c11-20020adfe74b000000b002cfe3d85dffmr12265901wrn.9.1679305059662;
        Mon, 20 Mar 2023 02:37:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d6e54000000b002cea8664304sm8371060wrz.91.2023.03.20.02.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 02:37:39 -0700 (PDT)
Message-ID: <f65a5bca-ad5f-bd8d-e063-382c076924a8@redhat.com>
Date:   Mon, 20 Mar 2023 10:37:38 +0100
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 17.03.23 00:56, Luis Chamberlain wrote:
> On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
>> On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
>>> I expect to have a machine (with a crazy number of CPUs/devices) available
>>> in a couple of days (1-2), so no need to rush.
>>>
>>> The original machine I was able to reproduce with is blocked for a little
>>> bit longer; so I hope the alternative I looked up will similarly trigger the
>>> issue easily.
>>
>> OK give this a spin:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts
>>
>> I'm seeing about ~86 MiB saving on the upper bound on memory usage
>> while hammering on kmod test 0008, and this is on a small system.
>>
>> Probably won't help *that* much but am curious... if it helps somewhat.
> 
> How much cpu count BTW?

220 physical ones and 440 virtual ones.

-- 
Thanks,

David / dhildenb

