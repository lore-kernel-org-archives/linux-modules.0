Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCB0C11F6C
	for <linux-modules@archiver.kernel.org>; Fri,  2 Jul 2021 12:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85F761425
	for <linux-modules@archiver.kernel.org>; Fri,  2 Jul 2021 12:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhGBMIl (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 2 Jul 2021 08:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhGBMI3 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 2 Jul 2021 08:08:29 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8787AC061762
        for <linux-modules@vger.kernel.org>; Fri,  2 Jul 2021 05:05:28 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so9872573otl.0
        for <linux-modules@vger.kernel.org>; Fri, 02 Jul 2021 05:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jvwC5DbBInbwZG2KYmEH3CjHWiOnuR8SzMXujEWKZ+g=;
        b=r+2zbeiLi2ZDdV0FhhULHAnnqg4sSxq325d50K/u0H9nwHFIQgzjBNxZJvS2XQhoY5
         0cg3CNc633s3E0iE+Pn7XxYESgBDzkWZTE1uVHBGn8OYxEsKtppb6/yOJYHwPjj/hHVo
         wPpNJi8vlEMm5oACj45Kap6ALf9p+8sNTxI6W2EtUTrkjpB8GLilWCkkE98WBiv06RJO
         kjZd8VREWl/u4zFpzt45GmR/wh45oLQXeu8SdN8h9jbU3PXg2yHaV+q4KS+mjzwGk4/8
         oQL1jBffcxXG5Jp7Af9Uf+Lse0zb1qTVU1WbZ1XTTxrtD2pg9NFxMwf8Sb6rTZVhpqfg
         sfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jvwC5DbBInbwZG2KYmEH3CjHWiOnuR8SzMXujEWKZ+g=;
        b=uC7sF/PyRtg1I6zCVjjrbkq8QVjXyceKzjtH58BYf5IZvIPXJHetTF/6uMLAQN64YP
         Su9BeybSV+f33vbSmrDbRPwphMtfSeHt2QiWOLScuGGydNt60kSa5MaYMWIAc9PJ/oeO
         iRI1AN2WTb4s3MmixORgokQVZFQqEvXxX3Tb2gqQYuKP7AaQ7UW4kokO7aODCuCRjtjY
         tp+aNiOHJN1IwVdVF1/mlKjT6AavIOdbpklY5xKtK73yzru7DM2DX7W5ACZtzDZcg0zY
         KGhrlDwAoBS1C+kxjPTzmLGF4PBIKWZtADBdNGFmQkuI1PhiT3feOLX/pPSgDsuLTLgQ
         xt0A==
X-Gm-Message-State: AOAM530Xg6Eq6fJ8kjccWdidTwddM2f1RkmcaU2/9J2VUaWgRcgyfo1o
        +bklA69QfbvPDuijIzSiPK7yVpvQBFk=
X-Google-Smtp-Source: ABdhPJwTU2NVPuWXYhOvlk+RwmCm9vXg2mXUTldO23vYY7OWd89GZpdc/uCgZ0q9YxAo0HjrjBTRiQ==
X-Received: by 2002:a05:6830:2315:: with SMTP id u21mr4164166ote.327.1625227527689;
        Fri, 02 Jul 2021 05:05:27 -0700 (PDT)
Received: from ian.penurio.us ([47.184.51.90])
        by smtp.gmail.com with ESMTPSA id i133sm675826oia.2.2021.07.02.05.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 05:05:27 -0700 (PDT)
Subject: Re: Seeking advice on "monkey patching" a driver
To:     Greg KH <greg@kroah.com>
Cc:     linux-modules@vger.kernel.org, kernelnewbies@kernelnewbies.org
References: <30faa352-0f60-10b9-887e-b2ee522d0a16@gmail.com>
 <YN4Ccf96sqMoPJM3@kroah.com> <b6e41740-94b7-e32e-5d57-deb7b730b2d9@gmail.com>
 <YN6Wml2QT2ZfppA2@kroah.com>
From:   Ian Pilcher <arequipeno@gmail.com>
Message-ID: <5c34419f-ef7d-a9bd-0c90-c77e2526b739@gmail.com>
Date:   Fri, 2 Jul 2021 07:05:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YN6Wml2QT2ZfppA2@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 7/1/21 11:31 PM, Greg KH wrote:
> Why are ahci devices somehow "special" here?  Just add a trigger to the
> ahci core for LEDs and all should "just work".  We've done that for many
> subsystems already.

It's more complicated than that, as it would need to be a separate
trigger for each drive (ATA port).

> Are you sure we don't already have LED triggers for disk activity?  Have
> you tried the ledtrig-disk.c driver?  It says it works on ATA devices,
> no reason it can't also work for other device types.

I stumbled on that file myself last night.  I either wasn't aware of it
before, or I had forgotten its existence, possibly because it's disabled
(CONFIG_LEDS_TRIGGER_DISK=n).  As mentioned above, I would be looking to
enable "per port" LEDs, so it doesn't work in its current form.  It does
at least give me hope that enhancements might be accepted upstream.

>> I've invested significant time in kernel patches in the past, only to
>> see them ultimately not be accepted, so I would need to know that
>> upstream was truly interested in such a feature before I would consider
>> making such a commitment.
> 
> That's not fair, there is no way anyone can promise anyone that their
> patches will be accepted, _before_ anyone sees them.  What would _you_
> do if you were in the kernel maintainer's position and read something
> like this?

You're right, but that isn't what I intended to say.  Basically, I can't
afford to invest the time in implementing something if the subsystem
maintainers have no interest in the *functionality*, regardless of the
state of the code.  I.e., if the ATA/LED subsystem maintainers think
that  software-controlled disk activity LEDs are stupid and have no
place in the kernel, then code quality is irrelevant, and anything I do
will be a waste of time.

> good luck!

Thanks!

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
