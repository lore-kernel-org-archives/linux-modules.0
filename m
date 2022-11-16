Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D61C433FE
	for <linux-modules@archiver.kernel.org>; Wed, 16 Nov 2022 16:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiKPQFE (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiKPQFD (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 16 Nov 2022 11:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECB8429A5
        for <linux-modules@vger.kernel.org>; Wed, 16 Nov 2022 08:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668614640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkGu3btRF6wX/8Cp9qFReUmy5dmFx47Q/M8BwCZWHrw=;
        b=M9ihxuNHBP365/xAqrvo8D+12m7PEd6DsjPTixx53ib1xJ5mQ/j5tbdXBEj8blYKiYaiSp
        0RQN9s6lUJ3lKec8YXlj4c3Aw/CCAmp2QyDqCEdp2im8UycxZiU8YcJnk7j4veRB03XF7G
        vHVLpNGKOi+gMrH5RvM/gXQOdZr5COI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-381-wtcXg5DNNUO2OnFQWKi1CA-1; Wed, 16 Nov 2022 11:03:58 -0500
X-MC-Unique: wtcXg5DNNUO2OnFQWKi1CA-1
Received: by mail-qv1-f72.google.com with SMTP id mi12-20020a056214558c00b004bb63393567so13729704qvb.21
        for <linux-modules@vger.kernel.org>; Wed, 16 Nov 2022 08:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkGu3btRF6wX/8Cp9qFReUmy5dmFx47Q/M8BwCZWHrw=;
        b=znDItoPiJMajolGPOabWLJI9g0msbbCdeHeHThiVSOCP6HYvakmLO48xnqlz9pO3GG
         A0fGQAvj9tQS59YaF8Wcms81kL2joWzUUCOc3ZmysgLiA5jxeE2Ma/B/Eyp70O81JKay
         ihQ3apYmAU6oByWkIr2bd2J8Vo/AK+SjTyD9Sj9BQ5HzW5USnFjAUJPhKFpVtKW9FYUS
         AegcyRsg/YQK1ogopQ7G766hSXBuWy+niAdNBHor/J6ZmOPmrJLIXZYpOnYnQOULDr6/
         ksyeqJWSj8Nt61HM5K5es9mqsedH3sggH6uXLVLw+S5yKIigcmAv8Uk3kov3tkvOkyN9
         gpXg==
X-Gm-Message-State: ANoB5pkSsF10QrPp1FBLpiOMwfO/xfTBFOFRbPRft4TQxzFKjKdGlBDU
        Qv539g1nENV3IoXQdpuWefl2uwqrLL2Ocn9uSPV1p396+yTz3RYHrNpB6PXkivt0amASV7A/Ncj
        K85EQaYFoxYo3WtgCbOI/sz+r9g==
X-Received: by 2002:ac8:71c4:0:b0:3a4:f1c1:49a9 with SMTP id i4-20020ac871c4000000b003a4f1c149a9mr21556962qtp.464.1668614636017;
        Wed, 16 Nov 2022 08:03:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Do1ucZVCi1sjsbyFAMwyi1hUQR7O3+Bc8G5p09qPDkp+L5YZTGFKwkNN7X5R/zNxYgRDGpA==
X-Received: by 2002:ac8:71c4:0:b0:3a4:f1c1:49a9 with SMTP id i4-20020ac871c4000000b003a4f1c149a9mr21556937qtp.464.1668614635721;
        Wed, 16 Nov 2022 08:03:55 -0800 (PST)
Received: from [10.16.222.26] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bi28-20020a05620a319c00b006fb0e638f12sm10465916qkb.4.2022.11.16.08.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 08:03:55 -0800 (PST)
Message-ID: <c2e841b7-e2b3-09f9-8187-328131d72c5d@redhat.com>
Date:   Wed, 16 Nov 2022 11:03:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        David Hildenbrand <david@redhat.com>
Cc:     pmladek@suse.com, Petr Pavlu <petr.pavlu@suse.com>,
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
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 11/15/22 14:29, Luis Chamberlain wrote:
> On Mon, Nov 14, 2022 at 04:45:05PM +0100, David Hildenbrand wrote:
>> Note that I don't think the issue I raised is due to 6e6de3dee51a.
>> I don't have the machine at hand right now. But, again, I doubt this will
>> fix it.
> 
> There are *more* modules processed after that commit. That's all. So
> testing would be appreciated.
> 

Can anyone tell us if

https://lore.kernel.org/linux-pm/20221102195957.82871-1-stuart.w.hayes@gmail.com/

resolves the module loading delay problem?

/me is testing now

P.

>    Luis
> 

