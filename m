Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B55C4332F
	for <linux-modules@archiver.kernel.org>; Mon, 21 Nov 2022 19:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiKUTvV (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiKUTvR (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 21 Nov 2022 14:51:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533E1D39DC
        for <linux-modules@vger.kernel.org>; Mon, 21 Nov 2022 11:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669060216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=En7S4ToAZ7C1d2RdYAB0+iVFnYG0ZnYEDFN8qv1i8Ng=;
        b=MJ5DFM1+uTP7CqTMbGRWReEPl+rEOlDa4od+Gt0IL6C/BYy6I+XLz9Flqi6nT3jIKkAvmz
        h2IBzt8ATN7551a3kPRbiQW6htpU+v7v/p2gO+A91+VkjaY3iJlkPjWVs74Di+/XXEzK1q
        bYCmU0Pvwsd5kmf48vcvZ2bCtSnD6rw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-jhF07tYrPRy2ZUqbpPeU1A-1; Mon, 21 Nov 2022 14:50:14 -0500
X-MC-Unique: jhF07tYrPRy2ZUqbpPeU1A-1
Received: by mail-wm1-f69.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so9770323wmb.8
        for <linux-modules@vger.kernel.org>; Mon, 21 Nov 2022 11:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=En7S4ToAZ7C1d2RdYAB0+iVFnYG0ZnYEDFN8qv1i8Ng=;
        b=zKZrNMff64pKoG9zEBB+kxW04dl0h3zOs+A+nHeZDrViMQNxcRUWl6fT4HrCqbvIM/
         uDapB/eyvvOYbhEMJywk11ZMujNnh/LZfBrRbbHwPEr7fU5YN6wC+3i6aOnDAy+/b00H
         xG/U766PPE+YWbiwWJqbBSIAcvn7mgbsWQbULZ/gTVhpXDwilXoFEKppvBSQ3gfsOXt9
         Qn5M3mlUgwaP2r+ctr4cDPDkbd4JD13OU0zynLlB/8xYQHaB2+gnsWnOEzrJZ99dtacK
         n8z9EPrT7mDdrsr8kORlLuvsvmBfH96sALRL1cvTWlQ4hMkiWTlECs+Ey5mQW318KeCw
         ibeA==
X-Gm-Message-State: ANoB5pk3mRJ9HZBXBMk1jnT43yNIQoaQ/kvkxc8W3tybXtkCaE92D1PM
        FMSQbfKTWdT+oSxc9Ul1it+7TyUZLphKK1Zyz9Ck1PDxQ3QyqCp4CZSnlDP27bz2gL22N2FtPEZ
        Yu6kjpqKSoL5MF9yf2y0eOGo1vw==
X-Received: by 2002:a05:600c:19d1:b0:3cf:4d12:1b4b with SMTP id u17-20020a05600c19d100b003cf4d121b4bmr17146440wmq.23.1669060212897;
        Mon, 21 Nov 2022 11:50:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4oAelbVCwjbeETHEH/KsM25flrvhhZ4bAv1IWQpJNBVIgBeB4DaoW2Fmr5Mj4IolOhPCoE+Q==
X-Received: by 2002:a05:600c:19d1:b0:3cf:4d12:1b4b with SMTP id u17-20020a05600c19d100b003cf4d121b4bmr17146428wmq.23.1669060212577;
        Mon, 21 Nov 2022 11:50:12 -0800 (PST)
Received: from [192.168.3.108] (p5b0c67dc.dip0.t-ipconnect.de. [91.12.103.220])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003b95ed78275sm15738785wmn.20.2022.11.21.11.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 11:50:12 -0800 (PST)
Message-ID: <11f65f51-5d77-e1cc-8f8a-779e35dd6af3@redhat.com>
Date:   Mon, 21 Nov 2022 20:50:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, pmladek@suse.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
 <c2e841b7-e2b3-09f9-8187-328131d72c5d@redhat.com>
 <049a8f8a-baf8-744d-6250-575fc0dc533e@suse.com>
 <Y3vLbDAeILx7gJPT@bombadil.infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y3vLbDAeILx7gJPT@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 21.11.22 20:03, Luis Chamberlain wrote:
> On Mon, Nov 21, 2022 at 05:00:49PM +0100, Petr Pavlu wrote:
>> On 11/16/22 17:03, Prarit Bhargava wrote:
>>> On 11/15/22 14:29, Luis Chamberlain wrote:
>>>> On Mon, Nov 14, 2022 at 04:45:05PM +0100, David Hildenbrand wrote:
>>>>> Note that I don't think the issue I raised is due to 6e6de3dee51a.
>>>>> I don't have the machine at hand right now. But, again, I doubt this will
>>>>> fix it.
>>>>
>>>> There are *more* modules processed after that commit. That's all. So
>>>> testing would be appreciated.
>>>>
>>>
>>> Can anyone tell us if
>>>
>>> https://lore.kernel.org/linux-pm/20221102195957.82871-1-stuart.w.hayes@gmail.com/
>>>
>>> resolves the module loading delay problem?
>>
>> This patch unfortunately makes no difference on my test system. In my case,
>> the kernel has already intel_pstate loaded when udev starts inserting a burst
>> of acpi_cpufreq modules. It then causes the init function acpi_cpufreq_init()
>> to immediately return once the check cpufreq_get_current_driver() fails. The
>> code modified by the patch is not reached at all.
> 
> To be clear I don't care about the patch mentioned in the above URL, I care
> about this:
> 
> https://lkml.kernel.org/r/d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com
> 
> David was this the on you tested too?

Yes, that's the one I tried without luck.

-- 
Thanks,

David / dhildenb

