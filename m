Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6E2C4332F
	for <linux-modules@archiver.kernel.org>; Tue, 18 Oct 2022 19:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJRTxt (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJRTx2 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 Oct 2022 15:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1EA86FB0
        for <linux-modules@vger.kernel.org>; Tue, 18 Oct 2022 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666122788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gjlp1ChEhbJR54DHK9OqHbYPJ/qd9E8PKZoUzlq+2fI=;
        b=jKUILjal1Cyb1QKKVmefbTNwttdpNpj53MPuZEaKLM+ppkDEYpx793md05lOflzVOnQrus
        2QWasGoFGltYiuAyAC8PGqttfbWDQcxQuZlB6VrvZa2OqvP1dhge9ba19TDY6g1Qr8Fd8W
        phU4xUe2mavS/12nqbZmMdHNjiR1sTs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-kFFkX54jMbaKpQk2wL-wuw-1; Tue, 18 Oct 2022 15:53:07 -0400
X-MC-Unique: kFFkX54jMbaKpQk2wL-wuw-1
Received: by mail-qv1-f69.google.com with SMTP id lu3-20020a0562145a0300b004b1d6f4130eso9231929qvb.1
        for <linux-modules@vger.kernel.org>; Tue, 18 Oct 2022 12:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gjlp1ChEhbJR54DHK9OqHbYPJ/qd9E8PKZoUzlq+2fI=;
        b=ZxjiJjHmZvaDVEUOYt/mFuXBnMnQniZ5yT2V5Etus0ZU8Xr3oEVlv3zlowO75idOqX
         E53INGmgsiIdV/ew6F0JWFXMpdzKGHSfLK+MPdd9f+B152iR8geR5i9xSL1kF8hg6TCD
         a+oKceaNINOmqB6RKy9bw+Anh/hf7mwKEDUIFiHN6OKwhF7bSRYQdQr8aC8xEeZK6XoN
         afyZwPEBw11kgdaNNnBNbeznmulhPBEN4wlPCMerlHx+Ntd4ZMfNT/gsw5nlpvz7Rjv/
         xi0q5xmAc7rNoW5xUGJCTs5+P5W9ZkVgchn4G+YFFEBNZrBrtgatubwPLabkxIXjXzUN
         ZKnQ==
X-Gm-Message-State: ACrzQf0xdpCTnG7WFMq6xcosPcjr8mvzXgVFyhw3N9nl2I/UjZPZW4T7
        kpt5EAuHKG03pvAaoC5ICLPBnSEoG7NQdoiOhXnFM1r+Ll7EN1/IF8XF7CDiOmm4FZ7PQA4tKVh
        ztxYmIYb3MPSCeZtqb+S0DH9wWQ==
X-Received: by 2002:a05:620a:4842:b0:6ee:8c09:d7cf with SMTP id ec2-20020a05620a484200b006ee8c09d7cfmr3014953qkb.662.1666122786444;
        Tue, 18 Oct 2022 12:53:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4XwZuYhnNt5pJ+Ga0p80MytSXoidzNh89WZ7owAHjc4vHBOYoRyunzaTS+DAUdRX0F2Nwrgg==
X-Received: by 2002:a05:620a:4842:b0:6ee:8c09:d7cf with SMTP id ec2-20020a05620a484200b006ee8c09d7cfmr3014943qkb.662.1666122786095;
        Tue, 18 Oct 2022 12:53:06 -0700 (PDT)
Received: from [10.16.222.26] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bl12-20020a05620a1a8c00b006bbc09af9f5sm3174222qkb.101.2022.10.18.12.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 12:53:05 -0700 (PDT)
Message-ID: <2342ef17-f8f9-501f-0f7b-5a69e85c2cf4@redhat.com>
Date:   Tue, 18 Oct 2022 15:53:03 -0400
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

I found the original thread surrounding these changes and I do not think 
this solution should have been committed to the kernel.  It is not a 
good solution to the problem being solved and adds complexity where none 
is needed IMO.

Quoting from the original thread,

> 
> Motivation for this patch is to fix an issue observed on larger machines with
> many CPUs where it can take a significant amount of time during boot to run
> systemd-udev-trigger.service. An x86-64 system can have already intel_pstate
> active but as its CPUs can match also acpi_cpufreq and pcc_cpufreq, udev will
> attempt to load these modules too. The operation will eventually fail in the
> init function of a respective module where it gets recognized that another
> cpufreq driver is already loaded and -EEXIST is returned. However, one uevent
> is triggered for each CPU and so multiple loads of these modules will be
> present. The current code then processes all such loads individually and
> serializes them with the barrier in add_unformed_module().
> 

The way to solve this is not in the module loading code, but in the udev 
code by adding a new event or in the userspace which handles the loading 
events.

Option 1)

Write/modify a udev rule to to use a flock userspace file lock to 
prevent repeated loading.  The problem with this is that it is still 
racy and still consumes CPU time repeated load the ELF header and, 
depending on the system (ie a large number of cpus) would still cause a 
boot delay.  This would be better than what we have and is worth looking 
at as a simple solution.  I'd like to see boot times with this change, 
and I'll try to come up with a measurement on a large CPU system.

Option 2)

Create a new udev action, "add_once" to indicate to userspace that the 
module only needs to be loaded one time, and to ignore further load 
requests.  This is a bit tricky as both kernel space and userspace would 
have be modified.  The udev rule would end up looking very similar to 
what we now.

The benefit of option 2 is that driver writers themselves can choose 
which drivers should issue "add_once" instead of add.  Drivers that are 
known to run on all devices at once would call "add_once" to only issue 
a single load.

Thoughts?

P.

