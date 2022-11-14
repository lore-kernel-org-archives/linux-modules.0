Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85D3C433FE
	for <linux-modules@archiver.kernel.org>; Mon, 14 Nov 2022 08:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiKNI7k (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 14 Nov 2022 03:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbiKNI7a (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 14 Nov 2022 03:59:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FABB1DDF2
        for <linux-modules@vger.kernel.org>; Mon, 14 Nov 2022 00:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668416281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZg0DxB8so7m34QKRBpTnK7NzeILrTRgIJDNhSB4dJs=;
        b=Fehn472R6kXcyhS5dVEpWFOqbwPmMloEmgMfEMpYVwgSP+nVCKpsMqf42z+liP7v6UzLbw
        JUZmb1/vv+UfFmn+EAM5CHGEMoGJgU7//cmDAk1cJjka05OZSq/KbastrutEiDKdCUYWxA
        MUqn7aZI3OVsYP8HQ6BJ2OiVmaC9WTA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-nvARq5h0N2SXYBFcNJt6JA-1; Mon, 14 Nov 2022 03:57:59 -0500
X-MC-Unique: nvARq5h0N2SXYBFcNJt6JA-1
Received: by mail-wr1-f69.google.com with SMTP id j20-20020adfb314000000b002366d9f67aaso1748238wrd.3
        for <linux-modules@vger.kernel.org>; Mon, 14 Nov 2022 00:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZg0DxB8so7m34QKRBpTnK7NzeILrTRgIJDNhSB4dJs=;
        b=j4ScVKZwEu4pGOilACnEx1Z4xKTMKraaTRabWRiAPrO6woRTE7EcLtFAYMHdkeDCZ6
         b2TSSRJeNcB+opzsAxnrPxqoB7GL4LcMX6TI8+cFyXLrWBmnMiYC+A/xtOWknzUXz/I5
         RmjCZeRuXn+0AVClJfFt7JGYELQ00vZeJGPhIqjuOXHpxGQ9rrtrKvTec62cfL1EmD2t
         RuQPoWjA0YNxjRtm2pM0/QpysBNdm0lAqqldZwwLvn5K1eBE9pYhlyjhJBieTsRl0666
         olIrUqUBn0K5ViwyQiGqXhIVTNo6Re79WGMv657MC6l7ZJo6tj3EeK8QSK3TguyO2/Qg
         hF5Q==
X-Gm-Message-State: ANoB5pmg/T8Y1hiJksfc/seSfRxUo9tI15aU9DhGFrbj/i2qZJGjqysr
        NaNm6vLluYbZRtbExM5XL5a2gSKso1j3BEXEDHZSfTHC6K3otoEnJQeGqQWzFviBZ3+tj45+vjw
        CIGYyvzoEZQWKmsMe+O9xvcs7Cw==
X-Received: by 2002:adf:ea42:0:b0:236:cfcf:8e36 with SMTP id j2-20020adfea42000000b00236cfcf8e36mr6883704wrn.323.1668416277878;
        Mon, 14 Nov 2022 00:57:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6C4tbw+mII5DH1BvxyEuPB/WV9+rqn3TOzxHf0EGkwtwfnzuHykZnjcAk4yYnUVmxJBgTX3g==
X-Received: by 2002:adf:ea42:0:b0:236:cfcf:8e36 with SMTP id j2-20020adfea42000000b00236cfcf8e36mr6883692wrn.323.1668416277602;
        Mon, 14 Nov 2022 00:57:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:d300:8765:6ef2:3111:de53? (p200300cbc703d30087656ef23111de53.dip0.t-ipconnect.de. [2003:cb:c703:d300:8765:6ef2:3111:de53])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d6942000000b0022e47b57735sm9002499wrw.97.2022.11.14.00.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:57:57 -0800 (PST)
Message-ID: <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
Date:   Mon, 14 Nov 2022 09:57:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Prarit Bhargava <prarit@redhat.com>
Cc:     pmladek@suse.com, Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 12.11.22 02:47, Luis Chamberlain wrote:
> On Wed, Oct 19, 2022 at 02:00:55PM +0200, Petr Pavlu wrote:
>> On 10/18/22 20:33, Luis Chamberlain wrote:
>>> On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
>>>> The patch does address a regression observed after commit 6e6de3dee51a
>>>> ("kernel/module.c: Only return -EEXIST for modules that have finished
>>>> loading"). I guess it can have a Fixes tag added to the patch.
>>>>
>>>> I think it is hard to split this patch into parts because the implemented
>>>> "optimization" is the fix.
>>>
>>> git describe --contains 6e6de3dee51a
>>> v5.3-rc1~38^2~6
>>>
>>> I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
>>> right thing to do, but without it, it still leaves the issue reported
>>> by Prarit Bhargava. We need a way to resolve the issue on stable and
>>> then your optimizations can be applied on top.
>>
>> Simpler could be to do the following:
>>
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index d02d39c7174e..0302ac387e93 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -2386,7 +2386,8 @@ static bool finished_loading(const char *name)
>>   	sched_annotate_sleep();
>>   	mutex_lock(&module_mutex);
>>   	mod = find_module_all(name, strlen(name), true);
>> -	ret = !mod || mod->state == MODULE_STATE_LIVE;
>> +	ret = !mod || mod->state == MODULE_STATE_LIVE
>> +		|| mod->state == MODULE_STATE_GOING;
>>   	mutex_unlock(&module_mutex);
>>   
>>   	return ret;
>> @@ -2566,7 +2567,8 @@ static int add_unformed_module(struct module *mod)
>>   	mutex_lock(&module_mutex);
>>   	old = find_module_all(mod->name, strlen(mod->name), true);
>>   	if (old != NULL) {
>> -		if (old->state != MODULE_STATE_LIVE) {
>> +		if (old->state == MODULE_STATE_COMING
>> +		    || old->state == MODULE_STATE_UNFORMED) {
>>   			/* Wait in case it fails to load. */
>>   			mutex_unlock(&module_mutex);
>>   			err = wait_event_interruptible(module_wq,
>> @@ -2575,7 +2577,7 @@ static int add_unformed_module(struct module *mod)
>>   				goto out_unlocked;
>>   			goto again;
>>   		}
>> -		err = -EEXIST;
>> +		err = old->state != MODULE_STATE_LIVE ? -EBUSY : -EEXIST;
>>   		goto out;
>>   	}
>>   	mod_update_bounds(mod);
> 
> 
> Prarit, can you verify this still does not break the issue you reported?
> David, does this also fix your issue?

I didn't try, but from a quick glimpse I assume no. Allocating module 
space happens before handling eventual duplicates right now, before a 
module even is "alive" and in the MODULE_STATE_UNFORMED state.

But maybe I am missing something important.

-- 
Thanks,

David / dhildenb

