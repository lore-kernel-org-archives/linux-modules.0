Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBF5C77B6E
	for <linux-modules@archiver.kernel.org>; Fri, 14 Apr 2023 09:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDNJir (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 14 Apr 2023 05:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDNJiq (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 14 Apr 2023 05:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D226E81
        for <linux-modules@vger.kernel.org>; Fri, 14 Apr 2023 02:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681465083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ZqWQFIQbGAVQQ02AKEpah3HnVCWIcchEavbUFTWJrk=;
        b=NqDg4CFUWIFaIJKGCHNrMJuZExu27SYGQL5GIMykm2pDdk23w4OF2Lw2+N3OJ6iyd4yEDa
        iJP0Tl+YYQ/DHDjORjx7SHM4BUg/Cu9Xw9LQEQ2bhujnN5B0lOsGhut+Kp90ygG4Q6dhmI
        /IBOHmXoXJf3Zdb0SB/Cs3upGXzov4k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-Kj5_lCmvN4aP2MzDDGuyeA-1; Fri, 14 Apr 2023 05:38:02 -0400
X-MC-Unique: Kj5_lCmvN4aP2MzDDGuyeA-1
Received: by mail-wr1-f72.google.com with SMTP id s18-20020adfa292000000b002f562b8b12bso1317427wra.0
        for <linux-modules@vger.kernel.org>; Fri, 14 Apr 2023 02:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681465081; x=1684057081;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZqWQFIQbGAVQQ02AKEpah3HnVCWIcchEavbUFTWJrk=;
        b=DSB7j2Cmvi2/repYvenfBAeJdPkI7fBBg9rtaA57t4VDE++EjG9hDxZGIXg5ClCm8/
         nVNiwKZvIqkXHjSj6tFep+bOPxxtbLdbf3nFvXgaBiz/GhQDbYBGrXXYvRz6Eng1HfmF
         RF3hC/DPnNKhYbuuPW4TixqmMSjccFWNuE9w6Sp1RJFYFqSq6NBvl1lwqpwmnGJPGX6r
         Scaj7/hg1gOBH5Yv8BKBqFwrTekRu2XqEwSeMO0phyKy+xByOqSE8U0vdOGs/crkSHFz
         01503AUDp5UE86wuUKtKJHg3uxKg9BXtrCJXVc0az8BMcDWJZRCLbOYVGx06qSPg970G
         7BfA==
X-Gm-Message-State: AAQBX9dR9QMX7knUlH1pcLNbrd9qaSPw/IiSq1K4kUqLxisNWdHojgJT
        Hr4RPOa3PoUhyrytz31Puq8WjCRCYsjhop+jd/E+787yhj8CoqD8Um32mukpbahxnK46goDwTLS
        im8i9guuFU0c5opcKuOWvzNqtJQ==
X-Received: by 2002:a7b:cb8c:0:b0:3f0:ae28:f535 with SMTP id m12-20020a7bcb8c000000b003f0ae28f535mr2285324wmi.12.1681465081280;
        Fri, 14 Apr 2023 02:38:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y9Xu/bVbmcLd+4Sut8NvZeOUt34TUWb2xnlg1VpGduxyDufELSeyy/yE0Sh8S046aNbv4z9w==
X-Received: by 2002:a7b:cb8c:0:b0:3f0:ae28:f535 with SMTP id m12-20020a7bcb8c000000b003f0ae28f535mr2285312wmi.12.1681465080934;
        Fri, 14 Apr 2023 02:38:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5700:cb5b:f73a:c650:1d9? (p200300cbc7025700cb5bf73ac65001d9.dip0.t-ipconnect.de. [2003:cb:c702:5700:cb5b:f73a:c650:1d9])
        by smtp.gmail.com with ESMTPSA id s9-20020a5d4ec9000000b002cde25fba30sm3226133wrv.1.2023.04.14.02.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 02:38:00 -0700 (PDT)
Message-ID: <62881f72-f8e8-f6cf-505d-2dd8cdef3643@redhat.com>
Date:   Fri, 14 Apr 2023 11:37:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/2] modules/kmod: replace implementation with a
 semaphore
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
References: <20230414051349.1986744-1-mcgrof@kernel.org>
 <20230414051349.1986744-3-mcgrof@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230414051349.1986744-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 14.04.23 07:13, Luis Chamberlain wrote:
> Simplify the concurrency delimiter we use for kmod with the semaphore.
> I had used the kmod strategy to try to implement a similar concurrency
> delimiter for the kernel_read*() calls from the finit_module() path
> so to reduce vmalloc() memory pressure. That effort didn't provide yet
> conclusive results, but one thing that became clear is we can use
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
> index b717134ebe17..5899083436a3 100644
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
> +	ret = down_timeout(&kmod_concurrent_max, MAX_KMOD_ALL_BUSY_TIMEOUT * HZ);
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

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

