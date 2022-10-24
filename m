Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F3EECAAA1
	for <linux-modules@archiver.kernel.org>; Mon, 24 Oct 2022 15:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiJXPXY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 24 Oct 2022 11:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiJXPXA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 24 Oct 2022 11:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAFF2B5
        for <linux-modules@vger.kernel.org>; Mon, 24 Oct 2022 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666620241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zfAUAmtuZAJ2/gdCGNu3yXanAGczpHvB4SK/U8ucWH4=;
        b=GyAYui5eVAHbjnUzXuaQLiSm9UaIn9LSgOljxHAiYdXYjRaqNFBVcxnkLAtklYPfdiFEP4
        jC1zeV3VsNJzGxPhyKmG0wjiEz2RmeJVQt1fwifv+2raRXianzKVDe8f0R/TTdPUVznRyQ
        RGaTdtCDS+0WGBEmu3bC1prfAaE96i8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-249-0AwdnSJ_MK-WTIK8wqEzlA-1; Mon, 24 Oct 2022 10:00:23 -0400
X-MC-Unique: 0AwdnSJ_MK-WTIK8wqEzlA-1
Received: by mail-qt1-f198.google.com with SMTP id b12-20020a05622a020c00b003983950639bso7103491qtx.16
        for <linux-modules@vger.kernel.org>; Mon, 24 Oct 2022 07:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfAUAmtuZAJ2/gdCGNu3yXanAGczpHvB4SK/U8ucWH4=;
        b=ApLyI0X3V6yfYxMNfJwAsC5ugyJiq52iRyLsqEGU43iyopjjQVa6ifR14awa85n27k
         hv8h5vIpSlu4jAdUVYa9LSB1YwGtY/D7EawmoK4AiN9uKn7EDxkp1u4Z1h2GukxrHPet
         VCRiHdh+Ox8t424Ejx/KQqZ9DyM/PJULpQ7lVwIc10JGVesXIP9lw48alO2oqIILe/zW
         lN3DC0mVsSkVEe3AAWJe5/7MV4+UC77pJxxz4Fix178W+2CCmihOuC/Kxt7GKBpCDd1s
         wUJffpWIqG+u4z2ObyY2AdBwgAXSl//BR1K1E7hX2KpEvFQ8GtIqFRIR28WlhN/gmdjC
         gt6A==
X-Gm-Message-State: ACrzQf3KSXXdSZKg0t8h72NXoQMdwKVvVBYavMONzDYWF47MQj4rmA5v
        DQTW/qX2i1GnVa5ioz/VAvU5jATkELid01F0LprDjSFW4H1N2UhkcLSooY/8On59Kp9oeEduGZ+
        SZG9KZqHuMWl+MK/kNQPBccTzVg==
X-Received: by 2002:a05:620a:4111:b0:6ed:ddf9:6955 with SMTP id j17-20020a05620a411100b006edddf96955mr22791746qko.19.1666620023279;
        Mon, 24 Oct 2022 07:00:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4b+bYbc6QWX6s1Eqnf4Y9AvCIRYdXACGADlzYGuUDmKZpTN1IFVNl7kD66DHjZw/UmufcYcQ==
X-Received: by 2002:a05:620a:4111:b0:6ed:ddf9:6955 with SMTP id j17-20020a05620a411100b006edddf96955mr22791716qko.19.1666620022904;
        Mon, 24 Oct 2022 07:00:22 -0700 (PDT)
Received: from [10.16.222.26] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a258400b006ef1a8f1b81sm31248qko.5.2022.10.24.07.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:00:22 -0700 (PDT)
Message-ID: <3ca5f15d-7d14-2ab0-db1f-1c4384894e0d@redhat.com>
Date:   Mon, 24 Oct 2022 10:00:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Petr Pavlu <petr.pavlu@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <2342ef17-f8f9-501f-0f7b-5a69e85c2cf4@redhat.com>
 <1b747e11-d358-52aa-0dfc-e795a8949106@suse.com>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <1b747e11-d358-52aa-0dfc-e795a8949106@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 10/24/22 08:37, Petr Pavlu wrote:
> On 10/18/22 21:53, Prarit Bhargava wrote:
>> Quoting from the original thread,
>>
>>>
>>> Motivation for this patch is to fix an issue observed on larger machines with
>>> many CPUs where it can take a significant amount of time during boot to run
>>> systemd-udev-trigger.service. An x86-64 system can have already intel_pstate
>>> active but as its CPUs can match also acpi_cpufreq and pcc_cpufreq, udev will
>>> attempt to load these modules too. The operation will eventually fail in the
>>> init function of a respective module where it gets recognized that another
>>> cpufreq driver is already loaded and -EEXIST is returned. However, one uevent
>>> is triggered for each CPU and so multiple loads of these modules will be
>>> present. The current code then processes all such loads individually and
>>> serializes them with the barrier in add_unformed_module().
>>>
>>
>> The way to solve this is not in the module loading code, but in the udev
>> code by adding a new event or in the userspace which handles the loading
>> events.
>>
>> Option 1)
>>
>> Write/modify a udev rule to to use a flock userspace file lock to
>> prevent repeated loading.  The problem with this is that it is still
>> racy and still consumes CPU time repeated load the ELF header and,
>> depending on the system (ie a large number of cpus) would still cause a
>> boot delay.  This would be better than what we have and is worth looking
>> at as a simple solution.  I'd like to see boot times with this change,
>> and I'll try to come up with a measurement on a large CPU system.
> 
> It is not immediately clear to me how this can be done as a udev rule. You
> mention that you'll try to test this on a large CPU system. Does it mean that
> you have a prototype implemented already? If yes, could you please share it?
> 

Hi Petr,

Sorry, I haven't had a chance to actually test this out but I see this 
problem with the acpi_cpufreq and other multiple-cpu drivers which load 
once per logical cpu.  I was thinking of adding a udev rule like:

ACTION!="add", GOTO="acpi_cpufreq_end"

# I may have to add CPU modaliases here to get this to work correctly
ENV{MODALIAS}=="acpi:ACPI0007:", GOTO="acpi_cpufreq_start"

GOTO="acpi_cpufreq_start"
GOTO="acpi_cpufreq_end"

LABEL="acpi_cpufreq_start"

ENV{DELAY_MODALIAS}="$env{MODALIAS}"
ENV{MODALIAS}=""
PROGRAM="/bin/sh -c flock -n /tmp/delay_acpi_cpufreq sleep 2'", 
RESULT=="", RUN{builtin}+="kmod load $env{DELAY_MODALIAS}"

LABEL="acpi_cpufreq_end"


> My reading is that one would need to update the "MODALIAS" rule in
> 80-drivers.rules [1] to do this locking. However, that just collects
> 'kmod load' (builtin) for udev to execute after all rules are processed. It
> would then be required to synchronize udev workers to prevent repeated
> loading?
> 

Yes, that would be the case.

>> Option 2)
>>
>> Create a new udev action, "add_once" to indicate to userspace that the
>> module only needs to be loaded one time, and to ignore further load
>> requests.  This is a bit tricky as both kernel space and userspace would
>> have be modified.  The udev rule would end up looking very similar to
>> what we now.
>>
>> The benefit of option 2 is that driver writers themselves can choose
>> which drivers should issue "add_once" instead of add.  Drivers that are
>> known to run on all devices at once would call "add_once" to only issue
>> a single load.
> 
> On the device event side, I more wonder if it would be possible to avoid tying
> up cpufreq and edac modules to individual CPU devices. Maybe their loading
> could be attached to some platform device, even if it means introducing an
> auxiliary device for this purpose? I need to look a bit more into this idea.

That's an interesting idea and something I had not considered.  Creating 
a virtual device and loading against that device would be much better 
(easier?) of a solution.

P.

> 
> [1] https://github.com/systemd/systemd/blob/4856f63846fc794711e1b8ec970e4c56494cd320/rules.d/80-drivers.rules
> 
> Thanks,
> Petr
> 

