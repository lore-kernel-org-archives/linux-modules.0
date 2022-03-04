Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A2C433EF
	for <linux-modules@archiver.kernel.org>; Fri,  4 Mar 2022 11:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiCDLNB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 4 Mar 2022 06:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiCDLM7 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 4 Mar 2022 06:12:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B094C1B01B1
        for <linux-modules@vger.kernel.org>; Fri,  4 Mar 2022 03:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646392331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AUSVwhnfRZoC3iB2YwKFKxHIJ6yrWchu41uAkpUPwY4=;
        b=InGSPztKnCfy5WQFY/QyVNDVB7JFlY7ZK/FPjenZx2E+UbT/RAVIfEtPSauSAhwGPvaxKc
        Abx88U6j3XkuNF0xbmjwKArh4iCRogC9kM94NDc4QFdRQN3DA7/mdteIi2biWfOm4gF1YJ
        nsP8m3TlYIQ3g7WN89//vgtgtwV2u1M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-xSGePGaLOQyERNlPN5ihTQ-1; Fri, 04 Mar 2022 06:12:10 -0500
X-MC-Unique: xSGePGaLOQyERNlPN5ihTQ-1
Received: by mail-wm1-f71.google.com with SMTP id c62-20020a1c3541000000b003815245c642so4027989wma.6
        for <linux-modules@vger.kernel.org>; Fri, 04 Mar 2022 03:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AUSVwhnfRZoC3iB2YwKFKxHIJ6yrWchu41uAkpUPwY4=;
        b=jWn0Sk6j3CmPTAKDJAzQOYIEAaIvwzjY0QWnmvBXZgDj07zruoTvbegW3vmUzTweTF
         swEYuVr2GkDzcQRlWs8HLkDSwxD6OHRO33rqiNL0WHA5i+xK7e61S7nvJY8971Q/Guo0
         WURwkIsKxyT1DukZ6x+YAQaJdBVGPts8VnThzh2wLGEyPKoqLB1/3QsNK++ujUKpN2K2
         PPE6eP9j0/UojUZtJ/CVw47YsYKsMq9AzgeI5+/LxyKvx/nvgNMCvEwLJu/tZ+0rgYnz
         EmDmnig34je02q1MGDIYnp9/wMwJ7046CwfTWjPRZWD5fJuIj89qlLoSqYNS/A+x4lfw
         u86A==
X-Gm-Message-State: AOAM532Pwm3Lrc3LwGnKtyfVx3bykaGhThcpUeWjV/vEZNRR9839Q1oL
        yYkaPIsj1zFjQPH4a9seYitc/Z0XNEnV7A68u4fn2f7clCX9zf0hE9FI3PFdA1fl4lXrI15Bhx/
        78mG0a35x/B6WxNHzkgjRhgS4
X-Received: by 2002:a5d:598f:0:b0:1e3:649:e6c3 with SMTP id n15-20020a5d598f000000b001e30649e6c3mr30074416wri.520.1646392329759;
        Fri, 04 Mar 2022 03:12:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvcDuGsktUT/oYRoSqkT5GCN7ol05dt6eg/Yp3ZoumXCrcGzAwTCnCSrQyurvMrQV4T5HLjQ==
X-Received: by 2002:a5d:598f:0:b0:1e3:649:e6c3 with SMTP id n15-20020a5d598f000000b001e30649e6c3mr30074410wri.520.1646392329543;
        Fri, 04 Mar 2022 03:12:09 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id bg18-20020a05600c3c9200b0037c2ef07493sm5716793wmb.3.2022.03.04.03.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 03:12:08 -0800 (PST)
Date:   Fri, 4 Mar 2022 11:12:07 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220304111207.pmopl7vgxrniwava@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
 <YiDEmRf3X0fxSayK@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YiDEmRf3X0fxSayK@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu 2022-03-03 05:37 -0800, Christoph Hellwig wrote:
> On Wed, Mar 02, 2022 at 08:56:23PM +0000, Christophe Leroy wrote:
> > Do we really want to hide the 'struct list_head modules' from external 
> > world ?
> > 
> > Otherwise we could declare it in include/linux/module.h ?
> I'd just move the trivial code that uses it from kernel/kdb/ to
> kernel/module/ as it is tied to module internals and just uses the
> KDB interfaces exposed to other parts of the kernel.

Hi Christoph,

This is a great idea. I'll do this instead.


Kind regards,

-- 
Aaron Tomlin

