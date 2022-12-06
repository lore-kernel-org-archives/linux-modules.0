Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1720C352A1
	for <linux-modules@archiver.kernel.org>; Tue,  6 Dec 2022 12:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiLFMcc (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 6 Dec 2022 07:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbiLFMcY (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 6 Dec 2022 07:32:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4629806
        for <linux-modules@vger.kernel.org>; Tue,  6 Dec 2022 04:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670329885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=liaMtdwZz66knjpgHV1DLOGIhlv7I5qOXrHvC/9gpP0=;
        b=OOLyShxBjlXmHSvZ9nKN289Uab4NZEwwoTNTPXG2bGTa/V/w4B0hVsQw/Pg8Eitp1MoHfE
        zwUG2+u2X4qBTYwHqlwNgpo73TLMTo7vPpCmfxJ8iwdr+RlRF+lMOKaY7tGPcMyNgKMpBW
        9MJViAKA+GUKYBjfVMn86GHXCc8cdIk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-35HdFPQrOyazltTOmjSW5g-1; Tue, 06 Dec 2022 07:31:24 -0500
X-MC-Unique: 35HdFPQrOyazltTOmjSW5g-1
Received: by mail-qv1-f69.google.com with SMTP id fc5-20020ad44f25000000b004c71efc3528so34853633qvb.22
        for <linux-modules@vger.kernel.org>; Tue, 06 Dec 2022 04:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liaMtdwZz66knjpgHV1DLOGIhlv7I5qOXrHvC/9gpP0=;
        b=bzbM1vVyGcxWbnvkygTCHjq97uqughfQWMdKdY3nmlBdiIPSGiB8AdSJKVQ2EOZoHe
         Rnio3PWOu8d+E4dr1CkVMC3h80RSin1gXyxX9pwKKoAAOz+BJmiek1wPSxWX/4/g0dQ1
         jf7E0cqnxKp+fJM0xb5uhkvPqiACzbQ+3GrbWzvSsrx9HgkaDwZ7eipaRWyri0BGn5Nf
         d6xX/yk2S8VzNfelndjgxjIOsScqaaIaeWtOpGWn80DH6JoJBOseyd8K3Qt1YlloC3GG
         1deNWzMmknvhkZ9vHTGCkcMMAgwd6dlpQC6QsToxXi7BBHIWQQY4qi1mCRriJGNfZTn5
         q8aA==
X-Gm-Message-State: ANoB5plV/deTwyWOJjHXxW5k7SqSUqGL7zhLee0h/6PErhR3qkYDkvDq
        Vne1axbkpjlXs87Paxmw1Esx59Kp4O6xUekb/JFPJjjuADXTK8GokyPpNfckdUKevuikT9Dpxn5
        OWPpaGDBsEIX4qlchbfW/mbQb4A==
X-Received: by 2002:a05:622a:4819:b0:3a6:9d10:ad73 with SMTP id fb25-20020a05622a481900b003a69d10ad73mr14582783qtb.458.1670329883247;
        Tue, 06 Dec 2022 04:31:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf53vvDbZ1mrEzLJQBK38Cb3qg6pzjo2PWIWJ0YIbwTN4hxH+XLtHWEDvimTYM0c3lguIYE0DQ==
X-Received: by 2002:a05:622a:4819:b0:3a6:9d10:ad73 with SMTP id fb25-20020a05622a481900b003a69d10ad73mr14582758qtb.458.1670329882886;
        Tue, 06 Dec 2022 04:31:22 -0800 (PST)
Received: from [10.16.222.26] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o1-20020ac841c1000000b0039cc82a319asm11371995qtm.76.2022.12.06.04.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:31:22 -0800 (PST)
Message-ID: <2e8d862d-fa3d-0879-9097-215d17cb1fed@redhat.com>
Date:   Tue, 6 Dec 2022 07:31:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>, Petr Pavlu <petr.pavlu@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <94cd5565-1058-2c97-57bb-0ddf12416cd6@redhat.com>
 <2ac0b871-60d0-c535-3fe0-bfaa0d9f7685@suse.com> <Y4opfN6MTsFhrYfu@alley>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <Y4opfN6MTsFhrYfu@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


> 
>> Could you please boot the machine with 'udev.log_level=debug' and provide me
>> logs ('journalctl -b -o short-monotonic') from a run with the vanilla kernel
>> and with the discussed patch?
> 

Petr, I tried to in-line the logs however the email bounced due to its size.

I know this isn't a preferred method of passing information on LKML and 
other lists, but here are links to the logs:

https://people.redhat.com/prarit/4petr/

Both outputs were done with, as requested, 'journalctl -b -o 
short-monotonic'.

vanilla.log is kernel booted with 'udev.log_level=debug'
with-changeset.log is kernel + patch booted with 'udev.log_level=debug'

P.

