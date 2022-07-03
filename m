Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AB1C43334
	for <linux-modules@archiver.kernel.org>; Sun,  3 Jul 2022 14:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiGCOZD (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 3 Jul 2022 10:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiGCOZB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 3 Jul 2022 10:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E578A62F9
        for <linux-modules@vger.kernel.org>; Sun,  3 Jul 2022 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656858300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vt8sM7P6c/5KQFjfgPv9CeGYHkTEe+4ULo2jY/ipBlM=;
        b=CdTVlE2tMuKiVpbIG+cHVrgl1T0y4ucwOTtlVqZz4m7GxhoftNiA5wHT6pnXt5nFiVFm5t
        DJ7HFnJFzqyR7AIYOM3Xt+8ilRavOjGYiwBvzHsajH1mDN7xqIDZwsRU89yE/UMZ6+qq0Z
        P5XEtzkHvyfL2lOsKBJthgu5mjC4tfs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-kUUF_UzkPZ-Q7bwie0E8qQ-1; Sun, 03 Jul 2022 10:24:58 -0400
X-MC-Unique: kUUF_UzkPZ-Q7bwie0E8qQ-1
Received: by mail-wm1-f72.google.com with SMTP id p22-20020a05600c359600b0039c7b23a1c7so5998077wmq.2
        for <linux-modules@vger.kernel.org>; Sun, 03 Jul 2022 07:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vt8sM7P6c/5KQFjfgPv9CeGYHkTEe+4ULo2jY/ipBlM=;
        b=LuqUzNO0gJG3171aa1DlNsCDrk9Ik3/1fRkb2t0iMdgLYOhbIMFM34ZQH6VTZbp84p
         3eRe0XrSFCwUCSjyGbCcX3U6fzPWh8v3xHbavcmx0txOKc8gbaAjrXKPrHIP/zA+TRpp
         V/Ms6sHRWWChDUsStyRoBz2H1568rjIYkk1JFDe957PUV6t6UhNLoMDvn5a0+7RObyII
         gb5bJn5oD63yYlpXFz84/hSW6A5N9YFphNSPy677BgaIGo130CLt4nc3rKLzFYsiSVRb
         QXems2P6vWufn6+qdzIByUh96EHzYwCr80Qz4CEp1mPkQl+h0NzmcMnbG+gDV/6gm4tZ
         77tA==
X-Gm-Message-State: AJIora/sPVmk28iWqpH1azLaHrH3Dgn8DP4eRqEGgdC11rR+BDwYKArT
        rsLG1TWyMGkuaaYBhdXzGQdvJ9/Jwdj1WiHSjpYr0VlPYjmdeSIdh4PmqJYPNiktndsMmfpYt3e
        N+Q8uPCUfnR2OUe+sV8gEVGgz
X-Received: by 2002:a05:600c:4e46:b0:3a0:4d54:f206 with SMTP id e6-20020a05600c4e4600b003a04d54f206mr29360653wmq.151.1656858297686;
        Sun, 03 Jul 2022 07:24:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uSeMKHEu9k5bVj3/yIEKGl1d5sksubHwC6uSi0vcAI9vvGDGmnLmVofg9HMfsQtPic3cf+SA==
X-Received: by 2002:a05:600c:4e46:b0:3a0:4d54:f206 with SMTP id e6-20020a05600c4e4600b003a04d54f206mr29360640wmq.151.1656858297516;
        Sun, 03 Jul 2022 07:24:57 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c020d00b0039c362311d2sm14933620wmi.9.2022.07.03.07.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 07:24:56 -0700 (PDT)
Date:   Sun, 3 Jul 2022 15:24:56 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, christophe.leroy@csgroup.eu,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 09/14] module: Move kallsyms support into a separate
 file
Message-ID: <20220703142456.l6mwruh6jvwjvq4k@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102413.3438665-10-atomlin@redhat.com>
 <20220628000526.11c57cd8@gandalf.local.home>
 <20220628081906.jln2ombfej5473xi@ava.usersys.com>
 <Yr92YtG12f+II+ea@bombadil.infradead.org>
 <20220703083324.az24ou7nrngvp73v@ava.usersys.com>
 <20220703092305.1e5da4c2@rorschach.local.home>
 <20220703135708.kn535pdrqv24f7kn@ava.usersys.com>
 <20220703101344.59710a42@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220703101344.59710a42@rorschach.local.home>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun 2022-07-03 10:13 -0400, Steven Rostedt wrote:
> On Sun, 3 Jul 2022 14:57:08 +0100
> Sorry about being harsh. It's something that was engrained in me when
> doing kernel development, and something I found useful for all software
> development.

Not at all! I welcome the feedback :)

> Honestly, the hardest thing about kernel development is the review
> process. The easier we can make reviewing, the better the code will be.

+1


Kind regards,

-- 
Aaron Tomlin

