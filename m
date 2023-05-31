Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23768C77B7A
	for <linux-modules@archiver.kernel.org>; Wed, 31 May 2023 07:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjEaHyG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 31 May 2023 03:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjEaHxh (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 31 May 2023 03:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FF8198
        for <linux-modules@vger.kernel.org>; Wed, 31 May 2023 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685519506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gzt4NYLA85nb15i+zO3AepaT972sSN8cGl5vcJ610U=;
        b=VaWpl4YeO7M2mQSo3D0daSaZNMJejhBmN/9Ww1SSkUnxfDhXvHiL87PNPlUjBThlh2TdLy
        HqPJF4eUDRl4Ptg1kufODvUYWN97/V3Lx8AttUvUz8dIDcpxOFIdJ+PDkoVYX413R/qckW
        lpKp2JnkD5WAhHcC/d5ZAgdH+Rgz3xg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-c8umzc-rMgK30xbPivX_Pw-1; Wed, 31 May 2023 03:51:45 -0400
X-MC-Unique: c8umzc-rMgK30xbPivX_Pw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f6fa88a86bso23989595e9.0
        for <linux-modules@vger.kernel.org>; Wed, 31 May 2023 00:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519504; x=1688111504;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gzt4NYLA85nb15i+zO3AepaT972sSN8cGl5vcJ610U=;
        b=l7nIAUIaDdx3V8BuufcAqlVPQxJAmnp7/6Mh3JNj9MeAYNgZDeOnzojEtAODdRk1P2
         ohcWkF2YFtwzNepcXD1ELHPsNjenCCwdQwoghT13w0hiDc6jVqcx2Sr5zuNFKnHdYQ4v
         W+WGexiVr8SXBP5tqlBn8s9SyWKygp8gzvkg+5FPul/jVRQoDfQdNyo/sgu+8Kw3hR8k
         2Orj5GGIc2r4PAbHROW7acz2P5lJTGGZY9endZpUzmnSgcbhexy+CS3jcbSZSVBxsw/v
         mf7yh4jhzCN4ee8iVkP3jk41d0lRRH3z+Fdg295oT4n+fSBs++i8zkcAtaMbQ0TkSWuB
         FvnQ==
X-Gm-Message-State: AC+VfDwcmJQUx3YhUx1xXHw4QaNnQQWsOlZ+VdgyaPRLJ8ikoHcnEJvi
        c/gPJOYRAtQEDDw/LHvVcoCYI8zBSP7angpW2OT6uxhf3Fv6EnEXWdYl8H002J7vUzvrm0g78C8
        6qInkAoR0Dwb8BsImBNw0ZpvR1Q==
X-Received: by 2002:a7b:cd15:0:b0:3f6:787:5e53 with SMTP id f21-20020a7bcd15000000b003f607875e53mr3581117wmj.20.1685519504181;
        Wed, 31 May 2023 00:51:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6bCBqd3WX5AOMaN61sImcYYeJ+NBjDRzwYuiEBhSn/dqrErSjURByTklhdc1d09OgLqsdFwA==
X-Received: by 2002:a7b:cd15:0:b0:3f6:787:5e53 with SMTP id f21-20020a7bcd15000000b003f607875e53mr3581083wmj.20.1685519503784;
        Wed, 31 May 2023 00:51:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:cb00:fc9f:d303:d4cc:9f26? (p200300cbc749cb00fc9fd303d4cc9f26.dip0.t-ipconnect.de. [2003:cb:c749:cb00:fc9f:d303:d4cc:9f26])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600c364600b003f420667807sm23170451wmq.11.2023.05.31.00.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:51:43 -0700 (PDT)
Message-ID: <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
Date:   Wed, 31 May 2023 09:51:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
References: <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
 <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
 <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
 <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZHYitt7P7W+8ZlSB@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 30.05.23 18:22, Luis Chamberlain wrote:
> On Mon, May 29, 2023 at 09:55:15PM -0400, Linus Torvalds wrote:
>> On Mon, May 29, 2023 at 11:18 AM Johan Hovold <johan@kernel.org> wrote:
>>>
>>> I took a closer look at some of the modules that failed to load and
>>> noticed a pattern in that they have dependencies that are needed by more
>>> than one device.
>>
>> Ok, this is a "maybe something like this" RFC series of two patches -
>> one trivial one to re-organize things a bit so that we can then do the
>> real one which uses a filter based on the inode pointer to return an
>> "idempotent return value" for module loads that share the same inode.
>>
>> It's entirely untested, and since I'm on the road I'm going to not
>> really be able to test it. It compiles for me, and the code looks
>> fairly straightforward, but it's probably buggy.
>>
>> It's very loosely based on Luis' attempt,  but it
>>   (a) is internal to module loading
>>   (b) uses a reliable cookie
>>   (c) doesn't leave the cookie around randomly for later
>>   (d) has seen absolutely no testing
>>
>> Put another way: if somebody wants to play with this, please treat it
>> as a starting point, not the final thing. You might need to debug
>> things, and fix silly mistakes.
>>
>> The idea is to just have a simple hash list of currently executing
>> module loads, protected by a trivial spinlock. Every module loader
>> adds itself to the right hash list, and if they were the *first* one
>> (ie no other pending module loads for that inode), will actually do
>> the module load.
>>
>> Everybody who *isn't* the first one will just wait for completion and
>> return the same error code that the first one returned.
> 
> That's also a hell much more snazzier MODULE_DEBUG_AUTOLOAD_DUPS if we
> ever wanted to do something similar there if we wanted to also
> join request_module() calls, instead of it hiding under debug.
> 
>> This is technically bogus. The first one might fail due to arguments.
> 
> For boot it's fine, as I can't think of boot wanting to support trying
> to load a module with different arguments but who knows. But I can't
> see it sensible to issue concurrent multiple requests for modules
> with different arguments without waiting in userspace for the first
> to fail.
> 
> Even post-boot, doing that sounds rather insane, but it would certainly
> be a compromise and should probably be clearly documented. I think just
> a comment acknolwedging that corner case seems sensible.
> 
> Because we won't be able to get the arguments until we process the
> module, so it would be too late for this optimization on kread. So it is
> why I had also stuck to the original feature being in kread, as then it
> provides a uniq kread call and the caller is aware of it. But indeed I
> had not considered the effects of arguments.
> 
> Lucas, any thoughts from modules kmod userspace perspective into
> supporting anyone likely issuing concurrent modules requests with
> differing arguments?
> 
>> So the cookie shouldn't be just the inode, it should be the inode and
>> a hash of the arguments or something like that.
> 
> Personally I think it's a fine optimization without the arguments.
> 
>> But it is what it is,
>> and apart from possible show-stopper bugs this is no worse than the
>> failed "exclusive write deny" attempt. IOW - maybe worth trying?
> 
> The only thing I can think of is allowing threads other than the
> first one to complete before the one that actually loaded the
> module. I thought about this race for module auto-loading, see
> the comment in kmod_dup_request_announce(), so that just
> further delays the completion to other thread with a stupid
> queue_work(). That seems more important for module auto-loading
> duplicates than for boot finit_module() duplicates. But not sure
> if odering matters in the end due to a preemtible kernel and maybe
> that concern is hysteria.
> 
>> And if *that* didn't sell people on this patch series, I don't know
>> what will. I should be in marketing! Two drink minimums, here I come!
> 
> Sold:
> 
> on 255 vcpus 0 duplicates found with this setup:
> 
> root@kmod ~ # cat /sys/kernel/debug/modules/stats
>           Mods ever loaded       66
>       Mods failed on kread       0
> Mods failed on decompress       0
>    Mods failed on becoming       0
>        Mods failed on load       0
>          Total module size       11268096
>        Total mod text size       4149248
>         Failed kread bytes       0
>    Failed decompress bytes       0
>      Failed becoming bytes       0
>          Failed kmod bytes       0
>   Virtual mem wasted bytes       0
>           Average mod size       170729
>      Average mod text size       62868
> 
> So:
> 
> Tested-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> In terms of bootup timing:
> 
> Before:
> Startup finished in 41.653s (kernel) + 44.305s (userspace) = 1min 25.958s
> graphical.target reached after 44.178s in userspace.
>                                                                                   
> After:
> Startup finished in 23.995s (kernel) + 40.350s (userspace) = 1min 4.345s
> graphical.target reached after 40.226s in userspace.

I'll try grabbing the system where we saw the KASAN-related issues [1] 
and give it a churn with and without the two patches. Might take a bit 
(~1 day), unfortunately.

[1] https://lkml.kernel.org/r/20221013180518.217405-1-david@redhat.com

-- 
Thanks,

David / dhildenb

