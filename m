Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CBCC433EF
	for <linux-modules@archiver.kernel.org>; Wed,  2 Mar 2022 13:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242089AbiCBNeQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237796AbiCBNeP (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 2 Mar 2022 08:34:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9CAC5D5F8
        for <linux-modules@vger.kernel.org>; Wed,  2 Mar 2022 05:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646228009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wwGzeYALfyBwg0W+DN9EfRv02WTck/Nh84p6AnYsDk=;
        b=Yxlv7miiMeDN7IlB9BprvHePGs1oM8u8OBt3+ymT3VJXIMg7MbhvJeDLWyLx9SKjOt/IrG
        eQR3XCoiBy/wx2ynOlidgY4dDPj1JkI37RpRhL1TlXw1blv//6LV6fuTLfh4YeTtjsDL+3
        LTaW29wWBs3fG7FqeIL8d4ZU9OuNwgI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-NgSSeaM5MdOGlHDWxj2o7g-1; Wed, 02 Mar 2022 08:33:28 -0500
X-MC-Unique: NgSSeaM5MdOGlHDWxj2o7g-1
Received: by mail-wm1-f72.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso1934217wmh.3
        for <linux-modules@vger.kernel.org>; Wed, 02 Mar 2022 05:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7wwGzeYALfyBwg0W+DN9EfRv02WTck/Nh84p6AnYsDk=;
        b=6qwlgz32rGuwZ1xCrSMwhrOKFOdvHvac7K0KbPlPRKyv2KdftvwwWxI3qMiqf+4bhF
         20rfg7spb7x80Gn52tfXFj5ZiWHXyAfiiROWgQJ3WmQ38E2KqXXjibiibTEAHzgYHFd8
         lDyRu+KTKN9S/UebL1qyMecvYZ2yBP8JZTmod4bcClNpb9bc33lzld7jdyNSl0M5eJdQ
         RUbuic0qwm4BL/LowIjczxhuA2NXrWDSjklf1STIOYazC635BYVkyboEJVPlIm/6UizG
         oZl8nfSDfrRMK++BzDKndXx//2NH9VAp1bwqvpRjUzMaZf0f2LQIZ3GZSbMXHwKh02Z8
         XLaQ==
X-Gm-Message-State: AOAM531gPng4Hunp0dSEWvdDRmUWbFm9PIzdKd84WYjqd/dcsOwcH0na
        aY8fRg9thj8egJbmutJFSc41jZYg2I0yc0sw6/XZlA9pu05R6wDdkBJ+8CH8Jjr9M456DBH+e+f
        WDRiMdca9/AJoQp9D0FDLBHuO
X-Received: by 2002:a05:600c:1988:b0:37c:505:d45c with SMTP id t8-20020a05600c198800b0037c0505d45cmr20369533wmq.107.1646228007642;
        Wed, 02 Mar 2022 05:33:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuOzCNkdBFaq96UmCHlYIRrcOPrm/1vUKIvqh8NhtpQcOTI3r3H44Wf3FHK32QizQKDNFadQ==
X-Received: by 2002:a05:600c:1988:b0:37c:505:d45c with SMTP id t8-20020a05600c198800b0037c0505d45cmr20369518wmq.107.1646228007454;
        Wed, 02 Mar 2022 05:33:27 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id r2-20020adff702000000b001efd7eb7c37sm8716859wrp.34.2022.03.02.05.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:33:25 -0800 (PST)
Date:   Wed, 2 Mar 2022 13:33:24 +0000
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
Message-ID: <20220302133324.dbf5vx45foxa32bu@ava.usersys.com>
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
> > +bool is_module_sig_enforced(void)
> > +{
> > +	return sig_enforce;
> > +}
> > +EXPORT_SYMBOL(is_module_sig_enforced);
> 
> As reported by the test robot, that's not enough.

Hi Christophe,

Thanks for testing this.

> When it was in main.c, is_module_sig_enforced() was build as soon as 
> CONFIG_MODULES was set.
> Now it is only built when CONFIG_MODULE_SIG is selected,

Agreed.

> so you have to modify include/linux/modules.h and have the stub
> is_module_sig_enforced() when CONFIG_MODULE_SIG is not selected and not
> only when CONFIG_MODULES is not selected.

Sure: when Kconfig CONFIG_MODULE_SIG is not selected.

Luis,

I can see that the latest series is in mcgrof/modules-testing.
Should I address the above as a separate patch with "Fixes:" or
provide a whole new series, with the fix within the same patch?
In my opinion, another iteration would be cleaner.


Kind regards,

-- 
Aaron Tomlin

