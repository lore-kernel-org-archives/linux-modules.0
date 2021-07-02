Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F27C11F68
	for <linux-modules@archiver.kernel.org>; Fri,  2 Jul 2021 15:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD5C61416
	for <linux-modules@archiver.kernel.org>; Fri,  2 Jul 2021 15:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhGBPTU (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhGBPTT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 2 Jul 2021 11:19:19 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF76C061762
        for <linux-modules@vger.kernel.org>; Fri,  2 Jul 2021 08:16:46 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id m6-20020a9d1d060000b029044e2d8e855eso10344808otm.8
        for <linux-modules@vger.kernel.org>; Fri, 02 Jul 2021 08:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B9EIAtqvJkd6e9xc3VesLciiUAHcDoNUbTx9mbowXis=;
        b=gUfyTN2euikHY1wpgr4MTO9j3ohm9e2s9pEkm7FFKC6JwuJsNq2g8Q/QlaM67ayEyJ
         f2Fzynt6onQxr1EmimTCXdxAmb2MLxY3jo1pKc/NCL1SXlAzECWpUmgBamFNfxjpNHi+
         3WIZd3BAh5qpWHJlBjR+eigy3wBLjCSo5yfAZW1KJGIZEoINqtreGIBGDJFcARfEKXNe
         Y9k0forkp9h68HTlG22ILSiqU5YOMpDiMZrpJHDy1U+foBu46Mw5zvI3KFGQaKnr54UE
         rjBTuzVZug13JiI0IRzT2HUYngtiVX0s80ri4rbKcePE883WFqDAPWooLlzp340E2qJ4
         LvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B9EIAtqvJkd6e9xc3VesLciiUAHcDoNUbTx9mbowXis=;
        b=itNQwPMZY0G7LMcttOtb9m9zoOgg+BkslMB4/Sx+1trS7j4la6jMXHhWpRMcHcwtFC
         DFH0DmFlbb1J7FDRWHs/ZcUnJwBPRCzYC9c8T7rUq/FohWgs44pW/qnkbzhd5vkMzRd0
         V48RPTNgyx05lz/YvK6F8Iz+4p3rXevuyXk8cO/AVp9TQBajD3cTbM/TS4c4IlWTqYmw
         GwYVk8ZX8K0+0ltHXpvyfTt1MQk3LKGO6kZSbB3lVkZFYXWO8Z+5X6/9YiHAjpxiFL9j
         Z95ZfsgM4OTVGQhOlYuVHj59A4U6uNl0ITYNrPT//mO5sq6MW+aZ2oCqk04ztD/iw7nm
         Ii0g==
X-Gm-Message-State: AOAM532b32FLd4OZ0l5VJ4BOfEpgIr4Nww94yJYUiQTrAqvJpLLPhdwj
        Dh0p41kC1vgALXEGtT7ufdAwsm+trBk=
X-Google-Smtp-Source: ABdhPJwtF3LBAMoM3qmqU6fLIEOjjCjY2ljXDLrZLubsJWzkZvPW8/fK7eUwF8wTR6xhaSlER6IYpA==
X-Received: by 2002:a05:6830:224e:: with SMTP id t14mr1557203otd.69.1625239005615;
        Fri, 02 Jul 2021 08:16:45 -0700 (PDT)
Received: from ian.penurio.us ([47.184.51.90])
        by smtp.gmail.com with ESMTPSA id c4sm673008ots.15.2021.07.02.08.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 08:16:44 -0700 (PDT)
Subject: Re: Seeking advice on "monkey patching" a driver
To:     Greg KH <greg@kroah.com>
Cc:     linux-modules@vger.kernel.org, kernelnewbies@kernelnewbies.org
References: <30faa352-0f60-10b9-887e-b2ee522d0a16@gmail.com>
 <YN4Ccf96sqMoPJM3@kroah.com> <b6e41740-94b7-e32e-5d57-deb7b730b2d9@gmail.com>
 <YN6Wml2QT2ZfppA2@kroah.com> <5c34419f-ef7d-a9bd-0c90-c77e2526b739@gmail.com>
 <YN8EecLokJuHrptR@kroah.com>
From:   Ian Pilcher <arequipeno@gmail.com>
Message-ID: <f524169d-4f5c-bd05-3190-b2544887cca1@gmail.com>
Date:   Fri, 2 Jul 2021 10:16:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YN8EecLokJuHrptR@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 7/2/21 7:20 AM, Greg KH wrote:
> Again, without a real patch, no maintainer or developer will ever say if
> they will, or will not, accept such a thing.  That's just not how kernel
> development works.  Working patches are what is discussed as that proves
> that at least, the idea works.

And that's certainly their prerogative.  You asked why I hadn't
attempted to submit changes upstream to address my issue, and I provided
my reasons for not doing so.

After several experiences where I've invested a significant (to me)
amount of time, only to ultimately be told that the functionality that I
implemented really wasn't desired, I'm very reluctant to repeat that
experience (and I honestly don't think that's particularly selfish or
unreasonable).

This doesn't mean that I absolutely won't make an attempt to do this.
As I mentioned in my previous note, the existence of ledtrig-disk.c
gives me some hope that changes might be accepted.

I'll just have to see ...

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
