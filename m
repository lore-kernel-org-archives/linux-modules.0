Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8A3C4332F
	for <linux-modules@archiver.kernel.org>; Wed, 16 Nov 2022 16:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKPQFu (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiKPQFs (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 16 Nov 2022 11:05:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76B725C4D
        for <linux-modules@vger.kernel.org>; Wed, 16 Nov 2022 08:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668614688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VD8rIBKq9wf/FUSXyylUkCpNknVyWclxbOCFJ0JUI4U=;
        b=UV4NmKWXEIAnXRMQ95rVjeKVNfVxmF8x5DBPldTG8RT9pi3L5Ic/Ez4b78cMdaWpV3aZeb
        aNy44BTD4BNxkGT7xZa1I29JobKmdpI3ZATVsi51+3lTgZ6eIQNZHTA4dM8mJqoW4MMszC
        n6Tgk8wBvYUQjkw6NijN0IJlAVtGmLM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-51aR6WuVOYiFzoxxy-2Kfg-1; Wed, 16 Nov 2022 11:04:46 -0500
X-MC-Unique: 51aR6WuVOYiFzoxxy-2Kfg-1
Received: by mail-wm1-f71.google.com with SMTP id 1-20020a05600c028100b003cf7833293cso1375675wmk.3
        for <linux-modules@vger.kernel.org>; Wed, 16 Nov 2022 08:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VD8rIBKq9wf/FUSXyylUkCpNknVyWclxbOCFJ0JUI4U=;
        b=M3wvqwLUUzGzKfws3W943qs2rTxP4XKv1CV5B3QWADy98VdSHcGlhTdFuz6XsVZiCN
         TTj0LWEQxmU/v4EsHuyg51j54nQ/xlmVPrLqJZ1Tua7L3IKZ57M4gSI3IKi6IKObgdY1
         RumFQFqiweT60yxI7HfXAJr2qrGv7uR84lGPO8bM/ucgculfPZZZ2qOgbbfzMiKZEZbo
         h8PvYfkyfl4io63APjVkvNzzt2/8eOT1++rae2vjJ5xNU3JtNyUPA8OSiiEor8AeiAd5
         003960sgvOWNsTE0DSDdacP4jFe64kM5qk8Rj9Am56CpiqtKDt7z7FuyCoIiIR2r2rXN
         pB1A==
X-Gm-Message-State: ANoB5pkQcZ59UD2Qt4Cy2wh7MIhK7YqJbQhOQl9pxQUyQR6IUSHGnIBR
        B/5UYBkSDE7s1LHJHE0bQZjgdmC4sWc5z6TE4l80ibCpxS4ancX4+YVO7Tzvqmf/InHuYQAhRgd
        Vrx/0bddFwMq2T+EWhfC+gpzKIg==
X-Received: by 2002:a05:600c:4a2a:b0:3b4:c00d:2329 with SMTP id c42-20020a05600c4a2a00b003b4c00d2329mr2537900wmp.124.1668614685618;
        Wed, 16 Nov 2022 08:04:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7EMEglFrPf91N9t9bXegttTA5+iZOC/JSZ1DTnLQiKDskxEyH/ekNzhjX8iFnAl8w3x3Cw+A==
X-Received: by 2002:a05:600c:4a2a:b0:3b4:c00d:2329 with SMTP id c42-20020a05600c4a2a00b003b4c00d2329mr2537870wmp.124.1668614685244;
        Wed, 16 Nov 2022 08:04:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c444f00b003b4cba4ef71sm2678715wmn.41.2022.11.16.08.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 08:04:44 -0800 (PST)
Message-ID: <f4699655-c137-1d9c-72cd-0e67e6cfcc2c@redhat.com>
Date:   Wed, 16 Nov 2022 17:04:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Prarit Bhargava <prarit@redhat.com>, pmladek@suse.com,
        Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 15.11.22 20:29, Luis Chamberlain wrote:
> On Mon, Nov 14, 2022 at 04:45:05PM +0100, David Hildenbrand wrote:
>> Note that I don't think the issue I raised is due to 6e6de3dee51a.
>> I don't have the machine at hand right now. But, again, I doubt this will
>> fix it.
> 
> There are *more* modules processed after that commit. That's all. So
> testing would be appreciated.

I'll try to get a grab on a suitable system.

-- 
Thanks,

David / dhildenb

