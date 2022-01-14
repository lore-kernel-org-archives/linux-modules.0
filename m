Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BF9C433F5
	for <linux-modules@archiver.kernel.org>; Fri, 14 Jan 2022 09:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiANJOG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 14 Jan 2022 04:14:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237440AbiANJOF (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 14 Jan 2022 04:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642151644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pWvo2OEmMNI1tZRpROSSx7Oe7LhQALrcOqQAzgndTM=;
        b=DNaWPwS8TzD6qkX8AhspsImAC8Q4TCFRI1Hj5L1GAXfO1Aaaa52pxDfM6zxHEYLAJrdwwQ
        0CHGuxJ9Vyi587gY/KrVbBczpJd98Ld8ezOOw2rWSF959uVkrc4KF1TkOn2r3QH2A8iIJg
        6ZJOLuxAx/D1Mx2CcV0ZlnPEmiAgDZI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-QPwk5LLSNuOwt3d8okUDRg-1; Fri, 14 Jan 2022 04:14:03 -0500
X-MC-Unique: QPwk5LLSNuOwt3d8okUDRg-1
Received: by mail-wm1-f70.google.com with SMTP id a3-20020a05600c348300b0034a0dfc86aaso5031115wmq.6
        for <linux-modules@vger.kernel.org>; Fri, 14 Jan 2022 01:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+pWvo2OEmMNI1tZRpROSSx7Oe7LhQALrcOqQAzgndTM=;
        b=FsR/GgeG6W9DdE0im5uimAXp8kAHzx6ODFxtPUNwK2jBc6tzJVuQTlx/N0Woye4Bsx
         0JDpAX13KUuIeBgx6PH0VcwjGRUt9gzBqcFSYPinNcLITeyBYs8nq3AhGKFTENsKFrAx
         3jumryGyInoi25jTldHgNHSIXCylctQWjl7zWKbfz1a7RwxLemvNGYql8jiYpbBzvodp
         nkUDWU316KudKO4bxKnwdgjUVsp969efAysIZnW2gSF5JqEVp0rwa6vesq2XSN3d0tQZ
         7magrN0rFAG8xOsodS7wbZxCSjJepJnORBC3rp2/nitFEYCjOFzI5FFVEu+MEs0D43U0
         io0g==
X-Gm-Message-State: AOAM533skRRwYNEV9293FUkMbvUTIV4UBoeCWRbEV90CLfwbm8qca5jY
        Javwy0rSqCtLlWfm6g7bgax894t5ot0vue+XKQo9EpjERZtlPUDi5G22TmgU+La/gzQsJgPdR74
        kucFt2ql/842bJy2C5CeKRgkv
X-Received: by 2002:adf:e2c4:: with SMTP id d4mr7449712wrj.247.1642151642035;
        Fri, 14 Jan 2022 01:14:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRWSX6LUT9jDBPafrWdsVXhH8natyGtUEoDRAx4Eqym1QjMxZ7ScRzSJ2TMS04IjlUfo2Tyw==
X-Received: by 2002:adf:e2c4:: with SMTP id d4mr7449692wrj.247.1642151641814;
        Fri, 14 Jan 2022 01:14:01 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id d16sm5347116wrq.27.2022.01.14.01.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 01:14:01 -0800 (PST)
Date:   Fri, 14 Jan 2022 09:14:00 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     mcgrof@kernel.org, cl@linux.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com,
        live-patching@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/13] module: Move livepatch support to a
 separate file
Message-ID: <20220114091400.3jyiohxh26bzjzvi@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220106234319.2067842-1-atomlin@redhat.com>
 <20220106234319.2067842-4-atomlin@redhat.com>
 <Yd8HpK44aWhhNI/Q@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yd8HpK44aWhhNI/Q@alley>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed 2022-01-12 17:53 +0100, Petr Mladek wrote:
> It would be better to have the two variants close each other. I mean
> to have it somewhere like:
> 
> #ifdef CONFIG_LIVEPATCH
> 
>    variant A
> 
> #else
> 
>    variant B
> 
> #endif

Petr,

I agree. I'll incorporate this approach into RFC PATCH v3.


Kind regards,

-- 
Aaron Tomlin

