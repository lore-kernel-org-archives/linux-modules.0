Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF13C61DA4
	for <linux-modules@archiver.kernel.org>; Wed, 15 Mar 2023 12:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjCOM1T (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 15 Mar 2023 08:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjCOM1C (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 15 Mar 2023 08:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21469AFC6
        for <linux-modules@vger.kernel.org>; Wed, 15 Mar 2023 05:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678883085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fO3xvWEOxLtGfBjQzTV1j3rg9kZXhnrlyWqpPgmzUR0=;
        b=F6CfKZAB2VxCEr+peRwc19VJXlVOMwusSSZkSXW9IeOj9hOmsKvY9smQQiRSgf/3/HRGR7
        ANwHKaxVQPfd1Yq8SWQ0ObMCffQ5Z7nSOVirsk7/DquWbjdcl/7kLSFtHTLmydVXI5J8Ez
        ZlFqul/dZEiWvaN26S8MbdA436lCqR8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-q6rVfiMQP8uRNe65s96HTw-1; Wed, 15 Mar 2023 08:24:44 -0400
X-MC-Unique: q6rVfiMQP8uRNe65s96HTw-1
Received: by mail-wm1-f71.google.com with SMTP id 1-20020a05600c024100b003ec8023ac4eso705613wmj.0
        for <linux-modules@vger.kernel.org>; Wed, 15 Mar 2023 05:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883083;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fO3xvWEOxLtGfBjQzTV1j3rg9kZXhnrlyWqpPgmzUR0=;
        b=KwHfsmlV7ooHJ2+yJ8CP/zpALy6j6WP3fXMxiA6sD3/bv135xESQdY99fKBh66hyP6
         abKL2rQWka0C5WJtsR9dbzkXuizqYKVIKkAxGNobHy8CgbomL6ncSzAkoeknNPH/8xxw
         Cs10L6+pGB+q+YiYhpRPP+dZDAGjuw3LYmdpDwavMORhwb+1fVwSg6yIT+HOtnHw4sZy
         GmyUjX+Id5q232drS0wu5VOu5UAyuVgCZwoZh+2b8k2AibBRszvqrpUh9SuBWlilmDWN
         0ZQ0H7Qv7wRPAAISJMaGdfIERY8AgPsqbxbLsTArnV9Y3vRuTmk128Vxk9Ya0NPSmqGS
         67MA==
X-Gm-Message-State: AO0yUKXB5qBK/fq5MaphIPXKy0SNCZpzEsPAEvwjNoyE8qANejvzon0q
        2nBsx8b+SrtdRQo7ByiEVPYKBfcNNfDBMexPmBZ+hYLINNxwhI4fbEgEbR6t2tFDUEgga3aRze5
        1R6IBDF2uQKSsqs6GRmnwoOl/Qg==
X-Received: by 2002:a05:600c:458f:b0:3eb:4162:7344 with SMTP id r15-20020a05600c458f00b003eb41627344mr18437503wmo.22.1678883083146;
        Wed, 15 Mar 2023 05:24:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set8fqujSiAvEVS1OAzs9541Izlj/1kOWdRv6q66LMMnewVwESOzM8VL2rQfJ44GE6WjeMsCyzA==
X-Received: by 2002:a05:600c:458f:b0:3eb:4162:7344 with SMTP id r15-20020a05600c458f00b003eb41627344mr18437482wmo.22.1678883082847;
        Wed, 15 Mar 2023 05:24:42 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6936.dip0.t-ipconnect.de. [91.12.105.54])
        by smtp.gmail.com with ESMTPSA id iz11-20020a05600c554b00b003ed201ddef2sm1796689wmb.2.2023.03.15.05.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 05:24:42 -0700 (PDT)
Message-ID: <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
Date:   Wed, 15 Mar 2023 13:24:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
References: <20230311051712.4095040-1-mcgrof@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230311051712.4095040-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 11.03.23 06:17, Luis Chamberlain wrote:
> A long time ago we had some issues with userspace doing stupid stuff.
> Well, it turns out even the kernel and do stupid stuff too, as we're
> learning with the ACPI modules aliaes and that hammering tons of loads.
> 
> So add a bit of code which gets us a bit more in the defensive about
> these situations.
> 
> To experiment, this also adds in-kernel alias support to see if this helps
> with some larger systems.
> 
> This is all based on some old code which tried to add defensive
> mechanisms the last of which was here and I had dropped the ball:
> 
> https://lore.kernel.org/all/20171208001540.23696-1-mcgrof@kernel.org/
> 
> I've only compile tested this for now. Will need to stress to test
> with kmod tests 0008 and 0009 to see if there's any differences.
> I'll have to re-test and re-gnuplot stuff there. But early feedback
> is appreciated, hence the RFC.
> 
> David Hildenbrand had reported a while ago issues with userspace
> doing insane things with allocations bringing a system down to
> its knees. This is part of the motivation for this series.


I'll try to grab a system where I can reproduce the issue and give your 
patches a churn.

Thanks!

-- 
Thanks,

David / dhildenb

