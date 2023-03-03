Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F596C64EC4
	for <linux-modules@archiver.kernel.org>; Fri,  3 Mar 2023 20:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjCCUfP (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Mar 2023 15:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjCCUfO (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Mar 2023 15:35:14 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328525D885
        for <linux-modules@vger.kernel.org>; Fri,  3 Mar 2023 12:35:13 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i12so2459375ila.5
        for <linux-modules@vger.kernel.org>; Fri, 03 Mar 2023 12:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677875712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIG2lbV3x/WX9TfJ5m60GjgJzOprT7gRvYSAmb5a31o=;
        b=FJ6sA/TjbHdt21vqiG/xhHJRqG1X3Ljh5C7RueEy8gydHu9b2Jl9lOsiOWbdjiIaf5
         rceMPxoDBWdfvkHh5/Zi9ac+wskE7SL5PgGSxco/M8lFW2YrttbpyE3KhC/I7BNsceXa
         XBSR3g2ufq3iNR30Amjty05e/yfyUuVnFAb30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677875712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIG2lbV3x/WX9TfJ5m60GjgJzOprT7gRvYSAmb5a31o=;
        b=bOiOoSKrdYombc1hlPmX3h67x02hF/igKlmSLd34RxZE+ud2iHmRuMOJCITYJwdc9S
         QgePvDYwiZs+SRBRhon2N/I/iDrRbQZlDXvwadasjhZpmz12k3ppJ6c9dUUctaVmh9o3
         auJANZuFkyIsivyglRVIFV3/OrsM/BChYi4JQPV8p72WJpLdrehqK318EvJuMRotwN48
         cn9Eyv4FpSk8bIxLbnxsehfv2e/677ZLZaXwpdG8PiySMZeSBcYiLCB931p204vIJP0D
         e+pYIK56503i6aN5K1Wb8RjJebIKitu/t8nARF4PDqEEMNQjlRnbSrKtFz6PIqMIkftG
         kzkw==
X-Gm-Message-State: AO0yUKUqJ6qIMfh9lFcSJQPakS+7g+mDfLlzBiOMh/9aXAaPQwEJ6QVI
        Z+6TUXDgQILnw5dpGV7fVx66XA==
X-Google-Smtp-Source: AK7set+2ZPUb82QYuAk/QXD4BGuCC4sZziz3GWsudAilWkd7LUyCFZMZW8PST6dhsPxBvdfaA9ljsg==
X-Received: by 2002:a05:6e02:156d:b0:313:fb1b:2f86 with SMTP id k13-20020a056e02156d00b00313fb1b2f86mr2340332ilu.0.1677875712434;
        Fri, 03 Mar 2023 12:35:12 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e5-20020a02a785000000b003a971c488cesm969583jaj.173.2023.03.03.12.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:35:11 -0800 (PST)
Message-ID: <537d3d3d-9ecc-bdd9-f703-708f6826d1f2@linuxfoundation.org>
Date:   Fri, 3 Mar 2023 13:35:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] selftests/kmod: increase the kmod timeout from 45 to
 165
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.de, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, keescook@chromium.org,
        tweek@google.com, a.manzanares@samsung.com, dave@stgolabs.net,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230206234344.2433950-1-mcgrof@kernel.org>
 <20230206234344.2433950-2-mcgrof@kernel.org>
 <b094dc23-a96d-93c4-a350-8fb92476f431@linuxfoundation.org>
 <Y/0xx0cedxlRMKpH@bombadil.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Y/0xx0cedxlRMKpH@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 2/27/23 15:42, Luis Chamberlain wrote:
> On Mon, Feb 27, 2023 at 03:32:50PM -0700, Shuah Khan wrote:
>> On 2/6/23 16:43, Luis Chamberlain wrote:
>>> The default sefltests timeout is 45 seconds. If you run the kmod
>>> selftests on your own with say:
>>>
>>> ./tools/testings/selftests/kmod.sh
>>>
>>> Then the default timeout won't be in effect.
>>>
>>> I've never ran kmod selftests using the generic make wrapper
>>> (./tools/testing/selftests/run_kselftest.sh -s) util now
>>> that I have support for it on kdevops [0]. And with that the
>>> test is limitted to the default timeout which we quickly run
>>> into. Bump this up to what I see is required on 8GiB / 8 vcpu
>>> libvirt q35 guest as can be easily created now with kdevops.
>>>
>>> To run selftests with kdevops:
>>>
>>> make menuconfig # enable dedicated selftests and kmod test
>>> make
>>> make bringup
>>> make linux
>>> make selftests-kmod
>>>
>>> This ends up taking about 280 seconds now, give or take add
>>> 50 seconds more more and we end up with 350. Document the
>>> rationale.
>>>
>>> [0] https://github.com/linux-kdevops/kdevops
>>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>>> ---
>>>    tools/testing/selftests/kmod/settings | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>    create mode 100644 tools/testing/selftests/kmod/settings
>>>
>>> diff --git a/tools/testing/selftests/kmod/settings b/tools/testing/selftests/kmod/settings
>>> new file mode 100644
>>> index 000000000000..6fca0f1a4594
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/kmod/settings
>>> @@ -0,0 +1,4 @@
>>> +# measured from a manual run:
>>> +# time ./tools/testing/selftests/kmod/kmod.sh
>>> +# Then add ~50 seconds more gracetime.
>>> +timeout=350
>>
>> Adding timeouts like this for individual tests increases the overall kselftest
>> run-time. I am not in favor of adding timeouts.
>>
>> We have to find a better way to do this.
> 
> Well if folks don't have this the test will fail, and so a false
> positive. If the goal is to have a low time timeout for "do not run
> tests past this time and do not fail if we stopped the test" then
> that seems to be likely one way to go and each test may need to be
> modified to not fail fatally in case of a special signal.
> 

We are finding more and more that timeout values are requiring
tweaks. I am in favor of coming up a way to exit the test with
a timeout condition.

thanks,
-- Shuah

