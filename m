Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7474DC76188
	for <linux-modules@archiver.kernel.org>; Wed,  5 Apr 2023 17:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjDERMk (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 5 Apr 2023 13:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjDERMc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 5 Apr 2023 13:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0E259E6
        for <linux-modules@vger.kernel.org>; Wed,  5 Apr 2023 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680714689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaGdM0RBcWTEVyOjxj3WXQhiHUXogDiNZgiaLMNlDoc=;
        b=e1NFN637xjgKs/m7GWH3zb9NuLE8hhyxe8nneQkSzKqu8fbtc+ecmmuEj0s4LJPMaOUCHg
        NxpSdqecmWfZiW/L8+rEzcKHBjiUt5CtmK1+6f2YJDKF0Ym2ad8pMiHN79Rsi9SGAuCYBy
        zHD2NS1I7k45BLFYYoGSHbgZxzE+0W4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-2jKBux-VNPeRoPFYVWhqFA-1; Wed, 05 Apr 2023 13:11:28 -0400
X-MC-Unique: 2jKBux-VNPeRoPFYVWhqFA-1
Received: by mail-wm1-f72.google.com with SMTP id iv18-20020a05600c549200b003ee21220fccso17413676wmb.1
        for <linux-modules@vger.kernel.org>; Wed, 05 Apr 2023 10:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680714687;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaGdM0RBcWTEVyOjxj3WXQhiHUXogDiNZgiaLMNlDoc=;
        b=IWlgt5yZLmE6F3iMi+IncoiY9aOsrShsOvp1D7yLOJm8J1DGzG040UoXSvNBSirwFv
         CM7pzMk4dC4IBnDPR0tk344Ylrix7qXZh1JfLLismzsrKWJRddOMFTVZgdjQNu+cAV3q
         qyjDCmaReEfrc4FXzMMi5SsEfRUsKZZ+ynnYwJZCJ0/wDcs3ehOsYQzW4N9sEqdq461E
         yim6ycGqxzDZojY0ij100+4ICBk7LVbpa666Y0WWET2d+PXuE8QumOB1KKcc6pI0CwCS
         IJ9Ev/yhufX+C2qFfxjRfktvRyBF8JSFUkqTewNPcLiWbXu62YWZ2Qvwnufu+dEq8Zcd
         gMJA==
X-Gm-Message-State: AAQBX9eKfo/fHM4rvtSkAtkNrgk8BLieakOLgt9v4HQ665R7LEN1ZR5v
        tam/yBOuk0MuRhUJYTWm3x48f6Fql+br+MHbJvb49ltw+QqvM19fODCAd6IWCWqrJGsPXvJ10KS
        qee+fdBoGUaFNtroSNVi3NZWEkcAHQ16vEg==
X-Received: by 2002:a5d:6144:0:b0:2e5:5439:6b4c with SMTP id y4-20020a5d6144000000b002e554396b4cmr4762461wrt.27.1680714687204;
        Wed, 05 Apr 2023 10:11:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y4zmKmQ3ZM2FZDf69Pi5WOZYFEL/2c2JOaPa9hUYc1dcsd+xnIAEQuULrtZEzO4Y9hgF1aaA==
X-Received: by 2002:a5d:6144:0:b0:2e5:5439:6b4c with SMTP id y4-20020a5d6144000000b002e554396b4cmr4762446wrt.27.1680714686866;
        Wed, 05 Apr 2023 10:11:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id v8-20020a5d4a48000000b002c557f82e27sm15384420wrs.99.2023.04.05.10.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 10:11:26 -0700 (PDT)
Message-ID: <b069b2b0-05fd-5c32-23c7-fbdd513681de@redhat.com>
Date:   Wed, 5 Apr 2023 19:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 3/6] module: extract patient module check into helper
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
References: <20230405022702.753323-1-mcgrof@kernel.org>
 <20230405022702.753323-4-mcgrof@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230405022702.753323-4-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 05.04.23 04:26, Luis Chamberlain wrote:
> The patient module check inside add_unformed_module() is large
> enough as we need it. It is a bit hard to read too, so just
> move it to a helper and do the inverse checks first to help
> shift the code and make it easier to read. The new helper then
> is module_patient_check_exists().
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   kernel/module/main.c | 71 +++++++++++++++++++++++++-------------------
>   1 file changed, 40 insertions(+), 31 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 98c261928325..8f382580195b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2638,6 +2638,43 @@ static bool finished_loading(const char *name)
>   	return ret;
>   }
>   
> +/* Must be called with module_mutex held */
> +static int module_patient_check_exists(const char *name)
> +{
> +	struct module *old;
> +	int err = 0;
> +
> +	old = find_module_all(name, strlen(name), true);
> +	if (old == NULL)
> +		return 0;
> +
> +	if (old->state == MODULE_STATE_COMING
> +	    || old->state == MODULE_STATE_UNFORMED) {

I never understood why people prefer to prefix the || on a newline. But 
it seems to be a thing in the module/ world :)


> +		/* Wait in case it fails to load. */
> +		mutex_unlock(&module_mutex);
> +		err = wait_event_interruptible(module_wq,
> +				       finished_loading(name));
> +		if (err)
> +			return err;

You return with the mutex unlocked. The caller will unlock again ...

> +
> +		/* The module might have gone in the meantime. */
> +		mutex_lock(&module_mutex);
> +		old = find_module_all(name, strlen(name), true);
> +	}
> +
> +	/*
> +	 * We are here only when the same module was being loaded. Do
> +	 * not try to load it again right now. It prevents long delays
> +	 * caused by serialized module load failures. It might happen
> +	 * when more devices of the same type trigger load of
> +	 * a particular module.
> +	 */
> +	if (old && old->state == MODULE_STATE_LIVE)
> +		return -EEXIST;
> +	else
> +		return -EBUSY;

You can drop the else and return right away.

> +}
> +
>   /*
>    * We try to place it in the list now to make sure it's unique before

Besides, LGTM.

-- 
Thanks,

David / dhildenb

