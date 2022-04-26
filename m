Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D28C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 26 Apr 2022 08:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbiDZI4H (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 26 Apr 2022 04:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347173AbiDZIvL (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 26 Apr 2022 04:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64AAC174F7D
        for <linux-modules@vger.kernel.org>; Tue, 26 Apr 2022 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650962376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jw4mRm1FwTyP9UJn0J2QYoEfx6c/KUy1MZndEek5Xy4=;
        b=DjoJZ7sBS3gXEcKLiJ6VFQzUN5lrt1i6Qw6ZA/TMHuJlYMCtljrdQN2hxM1hvnAOKrkJTY
        0IZ31keiid/0mnzC2ri6QvTIyGJHrj9d6mlNuvZV43uqhjfHgagdPJ31GTzMzXn4VPbG5M
        HThHpTwPdsam5j1XLrOBA9dDkDEFVHk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-X_jTO96EMT2oadtZ9dQYKA-1; Tue, 26 Apr 2022 04:39:33 -0400
X-MC-Unique: X_jTO96EMT2oadtZ9dQYKA-1
Received: by mail-wm1-f69.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso559710wmq.3
        for <linux-modules@vger.kernel.org>; Tue, 26 Apr 2022 01:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jw4mRm1FwTyP9UJn0J2QYoEfx6c/KUy1MZndEek5Xy4=;
        b=2wQaNi1hkms94s4oh5aIXIugNeDRwW6YNUIP+XjjD9uGA/nbFQMET35uEiZoq8Rr4R
         t57Ifci4beoKrpgC/hmnx9FDwDKIi2kMzimNLkPmitUK5/sqyyafhRAiAab7dNG5Scai
         DjN3E8zA1vCZm/oLkmEJtIMgIcad0NgFXTdumHVlsqPnqEZLuwLwfuNYdBoAJL8mplgk
         yE3Wh8o7xCLEEYcQPESiJvj31vsdGOksRcGJWQPy4QUg2Gv2FVsAeWsoe02qSCs6AOmD
         5FpT/9MBj1A7oriM1/QZAKFnKB8hFl57cvEXQb57/oz4CrF2PrdAomrjmqe3TgbFg0K9
         VdzA==
X-Gm-Message-State: AOAM531ufcVtIuYR29tORZXYHOY2F6hgOD/uZtkjEI/csLLfhW8prhWW
        i2sz71CfLEQiqtc7XMGSWOmaIENnCHtQRXB6YwXOdS4WSz0UNINDlnLGBILd6LE30kY6BBuwAHx
        N7UXcNMDNZmNu3mR3M0/hizuJ
X-Received: by 2002:adf:f2cc:0:b0:20a:cfbb:ac29 with SMTP id d12-20020adff2cc000000b0020acfbbac29mr13112685wrp.263.1650962372686;
        Tue, 26 Apr 2022 01:39:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg+iA38qQD6BfGY7gT19eBuYvIEUVtaGrwCfg2tNslK+9+RXqcvF8J8rAbLA8+jmpLyYCg8A==
X-Received: by 2002:adf:f2cc:0:b0:20a:cfbb:ac29 with SMTP id d12-20020adff2cc000000b0020acfbbac29mr13112659wrp.263.1650962372470;
        Tue, 26 Apr 2022 01:39:32 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 204-20020a1c02d5000000b003928c42d02asm12839575wmc.23.2022.04.26.01.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 01:39:31 -0700 (PDT)
Date:   Tue, 26 Apr 2022 09:39:30 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, k@ava.usersys.com
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: Re: [PATCH v4 0/2] module: Introduce module unload taint tracking
Message-ID: <20220426083930.hltsfxoe6ax6dspj@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220425090841.3958494-1-atomlin@redhat.com>
 <YmcvZQSiu95MUvxI@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmcvZQSiu95MUvxI@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon 2022-04-25 16:31 -0700, Luis Chamberlain wrote:
> This all looks good except with all the work you did to remove
> #ifdef hell, it gets me wondering why not just use a new file for this?
> 
> What does that look like?

Hi Luis,

I thought about it. It is indeed possible. Yet, I do not think it is worth
it, for such a small change; albeit, what do you prefer?


Kind regards,

-- 
Aaron Tomlin

