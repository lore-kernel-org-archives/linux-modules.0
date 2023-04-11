Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A328AC76196
	for <linux-modules@archiver.kernel.org>; Tue, 11 Apr 2023 08:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjDKInQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 11 Apr 2023 04:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDKInP (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 11 Apr 2023 04:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7B5171F
        for <linux-modules@vger.kernel.org>; Tue, 11 Apr 2023 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681202550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0G40HMMtqNusZREMWnmDmOZTULsZQjdvFBX6d0j6nM=;
        b=c04WVj0XM27mqf4xvNVOFE6/UlYYdSiHVbtCmaDokTe0mMOmTi6h9mpijcu7x3niLnFtSX
        1XMmyTgp2FNpdvTiDt28eRYHskQCXMf6+1ej+EAf4aBKub+E1UYIXMMz9odrzo/TdTxus9
        be+oy5nIyV0N3QtYcyaILky98N4ZWiw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-qP7CRp5UPrKdc91CaoPOfQ-1; Tue, 11 Apr 2023 04:42:26 -0400
X-MC-Unique: qP7CRp5UPrKdc91CaoPOfQ-1
Received: by mail-wr1-f70.google.com with SMTP id r4-20020adfa144000000b002db44581302so978894wrr.7
        for <linux-modules@vger.kernel.org>; Tue, 11 Apr 2023 01:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681202545; x=1683794545;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0G40HMMtqNusZREMWnmDmOZTULsZQjdvFBX6d0j6nM=;
        b=t2TNyHMH7bVIdD4ubdhj9A6HxBd5q01skf/St8AIy21a+zNv+iCwOctFRgY79CzijP
         As6wiOWo9jJ7zYZIQ8ujSjR9BsKJnJoIUkjLReQqEFJXm23BRhYplDx/52m/HWtqTx9E
         AnOckV7mTgNGgrw+1U20DrVWeA6RLtuHV3RWdRkcDqSddvUz7kUAE/rgwL8ft1Qk+Bz1
         ZCVkban+Ak47l6CE3qmf5Lk3pBXDh4pJBv23Uv5mN/Fte7xq5qJnVn5qPmjAaNM99Cyp
         RIBIqzzGwA3tRFAeHmZm5Z2QqJT73/r7BKnh7Eamqs4i3QdeaiDkIO8U7ydxMc5YjouD
         LoEQ==
X-Gm-Message-State: AAQBX9d0ahRQ+k8joPzK6fQZXw8BW9GqG4q8iUzWrsumHOtHAJ2u/QU4
        p1uEjSx9TRScsMXueyG3gQ7RuUVdQWReTTnuOMhBMQy3+9o35pTVFKtn2RvohSsXVHkuXXHBDQf
        bi6BR4sHEPrneh2qrJM0S9HfyYQ==
X-Received: by 2002:a7b:cb81:0:b0:3ee:1acd:b039 with SMTP id m1-20020a7bcb81000000b003ee1acdb039mr9362616wmi.34.1681202545138;
        Tue, 11 Apr 2023 01:42:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y0ozkUapL4MwnXUftzJoDwFRIUNHeFl1HSv1T0LtFvCqpcIZ1xQSSekp/uyzdWD3ViMfmTvg==
X-Received: by 2002:a7b:cb81:0:b0:3ee:1acd:b039 with SMTP id m1-20020a7bcb81000000b003ee1acdb039mr9362604wmi.34.1681202544706;
        Tue, 11 Apr 2023 01:42:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:1300:6f08:1748:eba7:b2a9? (p200300cbc70613006f081748eba7b2a9.dip0.t-ipconnect.de. [2003:cb:c706:1300:6f08:1748:eba7:b2a9])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c021600b003dc522dd25esm16326602wmi.30.2023.04.11.01.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 01:42:24 -0700 (PDT)
Message-ID: <3132a8ca-49a3-3d6a-09fe-984293116d76@redhat.com>
Date:   Tue, 11 Apr 2023 10:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] modules/kmod: replace implementation with a
 sempahore
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
References: <20230405203505.1343562-1-mcgrof@kernel.org>
 <20230405203505.1343562-3-mcgrof@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230405203505.1343562-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 05.04.23 22:35, Luis Chamberlain wrote:
> Simplfy the concurrency delimiter we user for kmod with the semaphore.
> I had used the kmod strategy to try to implement a similar concurrency
> delimiter for the kernel_read*() calls from the finit_module() path
> so to reduce vmalloc() memory pressure. That effort didn't provid yet
> conclusive results, but one thing that did became clear is we can use
> the suggested alternative solution with semaphores which Linus hinted
> at instead of using the atomic / wait strategy.
> 
> I've stress tested this with kmod test 0008:
> 
> time /data/linux-next/tools/testing/selftests/kmod/kmod.sh -t 0008
> 
> And I get only a *slight* delay. That delay however is small, a few
> seconds for a full test loop run that runs 150 times, for about ~30-40
> seconds. The small delay is worth the simplfication IMHO.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   kernel/module/kmod.c | 26 +++++++-------------------
>   1 file changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
> index b717134ebe17..925eb85b8346 100644
> --- a/kernel/module/kmod.c
> +++ b/kernel/module/kmod.c
> @@ -40,8 +40,7 @@
>    * effect. Systems like these are very unlikely if modules are enabled.
>    */
>   #define MAX_KMOD_CONCURRENT 50
> -static atomic_t kmod_concurrent_max = ATOMIC_INIT(MAX_KMOD_CONCURRENT);
> -static DECLARE_WAIT_QUEUE_HEAD(kmod_wq);
> +static DEFINE_SEMAPHORE(kmod_concurrent_max, MAX_KMOD_CONCURRENT);
>   
>   /*
>    * This is a restriction on having *all* MAX_KMOD_CONCURRENT threads
> @@ -148,29 +147,18 @@ int __request_module(bool wait, const char *fmt, ...)
>   	if (ret)
>   		return ret;
>   
> -	if (atomic_dec_if_positive(&kmod_concurrent_max) < 0) {
> -		pr_warn_ratelimited("request_module: kmod_concurrent_max (%u) close to 0 (max_modprobes: %u), for module %s, throttling...",
> -				    atomic_read(&kmod_concurrent_max),
> -				    MAX_KMOD_CONCURRENT, module_name);
> -		ret = wait_event_killable_timeout(kmod_wq,
> -						  atomic_dec_if_positive(&kmod_concurrent_max) >= 0,
> -						  MAX_KMOD_ALL_BUSY_TIMEOUT * HZ);
> -		if (!ret) {
> -			pr_warn_ratelimited("request_module: modprobe %s cannot be processed, kmod busy with %d threads for more than %d seconds now",
> -					    module_name, MAX_KMOD_CONCURRENT, MAX_KMOD_ALL_BUSY_TIMEOUT);
> -			return -ETIME;
> -		} else if (ret == -ERESTARTSYS) {
> -			pr_warn_ratelimited("request_module: sigkill sent for modprobe %s, giving up", module_name);
> -			return ret;
> -		}
> +	ret = down_timeout(&kmod_concurrent_max, MAX_KMOD_ALL_BUSY_TIMEOUT);
> +	if (ret) {
> +		pr_warn_ratelimited("request_module: modprobe %s cannot be processed, kmod busy with %d threads for more than %d seconds now",
> +				    module_name, MAX_KMOD_CONCURRENT, MAX_KMOD_ALL_BUSY_TIMEOUT);
> +		return ret;
>   	}
>   
>   	trace_module_request(module_name, wait, _RET_IP_);
>   
>   	ret = call_modprobe(module_name, wait ? UMH_WAIT_PROC : UMH_WAIT_EXEC);
>   
> -	atomic_inc(&kmod_concurrent_max);
> -	wake_up(&kmod_wq);
> +	up(&kmod_concurrent_max);
>   
>   	return ret;
>   }

Much cleaner

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

