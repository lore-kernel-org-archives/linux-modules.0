Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670B2C433FE
	for <linux-modules@archiver.kernel.org>; Tue, 18 Oct 2022 19:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJRTUN (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiJRTUE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 Oct 2022 15:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AE636BC4
        for <linux-modules@vger.kernel.org>; Tue, 18 Oct 2022 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666120796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0NZK5a4hlDEe42mcL1hOBkrM8mEbIxo3HSEb4Uc/k4s=;
        b=FRfxV0BqWH6M1ELu6QBuEWgBFjcMZwddKy79SfIh3YGJyVdmxe2iq0QUfc7Pk9pswena72
        0GFrOfXFDG5UEkwf9lGLZxCdYAQcZYgRs/IvXmPVth5KDcVSRJ/peOhzELHw02LI6vvFoJ
        x8j6d7Z1ggKdYuS5yuivK/IjXtDjj0E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-119-Sa8YlLA0MjCn7W-64CzUCQ-1; Tue, 18 Oct 2022 15:19:54 -0400
X-MC-Unique: Sa8YlLA0MjCn7W-64CzUCQ-1
Received: by mail-qv1-f70.google.com with SMTP id h3-20020a0ceec3000000b004b17a25f8bcso9383576qvs.23
        for <linux-modules@vger.kernel.org>; Tue, 18 Oct 2022 12:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NZK5a4hlDEe42mcL1hOBkrM8mEbIxo3HSEb4Uc/k4s=;
        b=u4Jioxu3OG2HIy4oYA1tT8yDdAJRrnZlELsVhrPybpwkK5yqw2NvngIKESLHpWHyXt
         fjOo2pWNeVJ27Y9DeF62j4PMG7VGOjTKlA+4QYaYGAkKrjGHSw6PMOW7vgNEMt42io+B
         mbE3nnirtI3vX/g59J6Y4s+8BJur9XpU33na3qieJrS7VSWgNpIqTJzzeXlhGn853QZL
         vACP+mRuFZ3yyWJWfkasP/fdETWK6gjulBx6DGSBX8Rdx3dELXz0uIG29CTQdMV8vF24
         ukanQKbRww4WPQqSCqcxNTLUla8bAQfg9q0gyS4pG+eXZl0SVBWDEEyRKA0pEQEBB0DT
         e/MQ==
X-Gm-Message-State: ACrzQf0/bLXSnmJ+FnaMjjJ0QfyQKxMOk0/t00K2M028wni4W379qPXZ
        lQg3vDMUTmqEFrjMaowZakMBiLjgTuotV9MDGzxPk0OAhkx7LRMX0etKy9Os2JeF13zPNLWNOhN
        Q9WoCrCNcCSKHNojDKLNwQwycrw==
X-Received: by 2002:a05:620a:4548:b0:6ee:deba:2795 with SMTP id u8-20020a05620a454800b006eedeba2795mr2994077qkp.621.1666120794057;
        Tue, 18 Oct 2022 12:19:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7w4Z6sIZOnBg9vt5u3oo1kQARfnV39SGme7KRkbMiU9gu5XhYjstTQ9meJrPllvn67OhmNmg==
X-Received: by 2002:a05:620a:4548:b0:6ee:deba:2795 with SMTP id u8-20020a05620a454800b006eedeba2795mr2994059qkp.621.1666120793722;
        Tue, 18 Oct 2022 12:19:53 -0700 (PDT)
Received: from [10.16.222.26] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a25cd00b006bbf85cad0fsm3064126qko.20.2022.10.18.12.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 12:19:53 -0700 (PDT)
Message-ID: <9b6f8b9f-11bd-6850-0f73-3a4352181b97@redhat.com>
Date:   Tue, 18 Oct 2022 15:19:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 10/18/22 14:33, Luis Chamberlain wrote:
> On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
>> The patch does address a regression observed after commit 6e6de3dee51a
>> ("kernel/module.c: Only return -EEXIST for modules that have finished
>> loading"). I guess it can have a Fixes tag added to the patch.
>>
>> I think it is hard to split this patch into parts because the implemented
>> "optimization" is the fix.
> 
> git describe --contains 6e6de3dee51a
> v5.3-rc1~38^2~6
> 
> I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
> right thing to do, but without it, it still leaves the issue reported
> by Prarit Bhargava. We need a way to resolve the issue on stable and
> then your optimizations can be applied on top.
> 
> Prarit Bhargava, please review Petry's work and see if you can come up
> with a sensible way to address this for stable.

Thanks for the heads up Luis.  I'll take a closer look.  [A long time 
ago] I could swear we made a very targeted decision to *NOT* allow 
modules with the same name to be loaded into the kernel.  What's changed 
that we think this is okay to do today?

Thanks,

P.

> 
>    Luis
> 

