Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4130C433EF
	for <linux-modules@archiver.kernel.org>; Sat,  5 Mar 2022 20:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiCEUix (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 5 Mar 2022 15:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiCEUiw (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 5 Mar 2022 15:38:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39F87655A
        for <linux-modules@vger.kernel.org>; Sat,  5 Mar 2022 12:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646512681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTq2l8ofz9rdVgsUXAyYiBJlx/2wq7tGHGb9qgHLPos=;
        b=Na7IWn8d4p3kFHKi7aGUaDrYwKML0YsJX4BIt+EtF6qT6lAQsrGdu0icoNRQy1ZlzbeNCk
        w8SIt4L/YMfDHIOdu6HzZ2rDOe1iSTbRWZwQgB8APnhPtL0dY8qVLPZUMwN+2INGxnnf+B
        4XlRrdNSrCGW0BEZC6SATS/teab2fj8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-vzS1Bqb6PTqVszUedXYHYw-1; Sat, 05 Mar 2022 15:38:00 -0500
X-MC-Unique: vzS1Bqb6PTqVszUedXYHYw-1
Received: by mail-wm1-f70.google.com with SMTP id 20-20020a05600c231400b00389886f6b23so2000374wmo.6
        for <linux-modules@vger.kernel.org>; Sat, 05 Mar 2022 12:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LTq2l8ofz9rdVgsUXAyYiBJlx/2wq7tGHGb9qgHLPos=;
        b=L0Lscz4a1UnsNsuUeH99fdSisbvBPtC7zDx5KxH4LvRQbd+lU8SELWnf4OmbU0KToe
         JuBwkDJRVaDTZNzUmVA4YMy53v457NrelD6chcHsQS+RtJussYCyCeBBu3PxrV1tnONv
         pJHMbt0bAcjs+kjkNjUDMqCnfSsBARa8CVCbTCBcqr72fjdwRlAndj+jW2CFl8K3mLxJ
         QW5Qw7oyW92Yga1vDuq5Gl5vIng1Hkji0ZJWzpyLN3rNIVl3IdUEF1RJmfPXW5dMz/Kh
         ijiQKTeM3PPl/gK0dfBFXBLhccMpvQWe2+LkDId6Ze7FzS8xc4H8dltAnsxpR7jkYXWd
         23pw==
X-Gm-Message-State: AOAM532ohFFT/ib6AIKv2ENouEs9Xr/CNMApo3X9IFLrThvGLCPpHDqk
        Grtzn0cjdoufPRzdsW37KTZ9+U+A0QViBJ09nTRE0w4m6Q9HvVCXXa4eBFEdXD4MXcn8pp4BsjW
        II8HmAzCXrPTeJaIGI0g8Xbrq
X-Received: by 2002:a5d:6da8:0:b0:1f0:4c26:3f57 with SMTP id u8-20020a5d6da8000000b001f04c263f57mr3501224wrs.460.1646512679088;
        Sat, 05 Mar 2022 12:37:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzV1YoK0tLxXR6swa6/8fXMxsqZhiV8WJMWAsr0QJnH+uc8+sh3Wp/MtpytQyrJNwH1BzNGwQ==
X-Received: by 2002:a5d:6da8:0:b0:1f0:4c26:3f57 with SMTP id u8-20020a5d6da8000000b001f04c263f57mr3501203wrs.460.1646512678803;
        Sat, 05 Mar 2022 12:37:58 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c2c4c00b003816932de9csm15206434wmg.24.2022.03.05.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 12:37:57 -0800 (PST)
Date:   Sat, 5 Mar 2022 20:37:56 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
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
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "pmladek@suse.com" <pmladek@suse.com>
Subject: Re: [PATCH v9 07/14] module: Move extra signature support out of
 core code
Message-ID: <20220305203756.jc5ayzboea6ixm4a@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-8-atomlin@redhat.com>
 <c03fa2bb-1b0e-62c7-53fe-33e44d20b564@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c03fa2bb-1b0e-62c7-53fe-33e44d20b564@csgroup.eu>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed 2022-03-02 08:08 +0000, Christophe Leroy wrote:
> When it was in main.c, is_module_sig_enforced() was build as soon as 
> CONFIG_MODULES was set.
> 
> Now it is only built when CONFIG_MODULE_SIG is selected, so you have to 
> modify include/linux/modules.h and have the stub 
> is_module_sig_enforced() when CONFIG_MODULE_SIG is not selected and not 
> only when CONFIG_MODULES is not selected.

Hi Christophe,

Looking at this again, perhaps I'm missing something. If I understand
correctly, Kconfig CONFIG_MODULE_SIG cannot be selected without
CONFIG_MODULES; also CONFIG_MODULE_SIG depends on CONFIG_MODULES, no?
So, what is present is enough right i.e. the stub when CONFIG_MODULES is
not enabled?


Kind regards,

-- 
Aaron Tomlin

