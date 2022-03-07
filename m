Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7698C433FE
	for <linux-modules@archiver.kernel.org>; Mon,  7 Mar 2022 09:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiCGJnQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 7 Mar 2022 04:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240793AbiCGJle (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 7 Mar 2022 04:41:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1734C6A034
        for <linux-modules@vger.kernel.org>; Mon,  7 Mar 2022 01:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646645889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2hRKjru0jaANdaMFZ+K70lfTDMO4iHRVAfY2BeEn/4o=;
        b=jQk5gpEtJWwNhOvksWAZxbQ53+Gssjq09jUFLxZZDiesiX0Om5gZQzMBt2PGjkDeBdDFQR
        xBon27XRfXf/75qRB/dCEpKdoRBFsoRVvOUmH6HTVBvSTQ6liPv8CsYUyUCPzjoi0OPpXG
        F6prtxYh6yztHwYi33hsDMOygege1ro=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-F1GtUp7RPG6WTWId--4qRA-1; Mon, 07 Mar 2022 04:38:08 -0500
X-MC-Unique: F1GtUp7RPG6WTWId--4qRA-1
Received: by mail-wm1-f70.google.com with SMTP id o21-20020a05600c511500b003818c4b98b5so5050801wms.0
        for <linux-modules@vger.kernel.org>; Mon, 07 Mar 2022 01:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2hRKjru0jaANdaMFZ+K70lfTDMO4iHRVAfY2BeEn/4o=;
        b=pT8JpTJTG5g1ORYGAJK3h5LpRAbwgidy2baunyUGFOKOp90bL7g2u4YZ9vXEkOhRf8
         wx5dT2cEeR2MgBbCTn45B4jQUHxD+nr4fgTcc14WmQ7D5VW6KeUH71B1N9bMs9XSsDBl
         YoMHqOpmo2PPx0N+cSmzvR7LwkjqCpwdTMk960cbJgdXx1DA0lINf/Kqy1M5tRV9Gc5P
         0wky6Uuo3Ox24+NzJ1UA3KJcpK/7YH6EIktuhHOd89AdPBxEGmdfefpEA/pXx0cdpTri
         +pndkmFnmiOuRy7b30itWIORiKHOLL/zlSA6M7Pb/3H9wmjSJGs8e8nl8GRmRoYaWWdO
         JIog==
X-Gm-Message-State: AOAM5309rje6bdFM8PrWVqucVPR40wGez1yWAcMbVeQWDjQ8LbRIFy/L
        l+Cp49OJKecbAgenH/D3HOi+4iNuWr8jDB/Y+iXxTA7r+oPX2l5ErAUPU7OaeoTg+NCBo2UatWB
        rfdyPfZ58rJER63R69alFiGQX
X-Received: by 2002:a5d:69c7:0:b0:1f0:61f3:642b with SMTP id s7-20020a5d69c7000000b001f061f3642bmr7650078wrw.632.1646645887134;
        Mon, 07 Mar 2022 01:38:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYgPmZBFCYVwYlVuJ55u4vArcYAHv9y3dFz+eZ23t3tabZPf1FdajgzMXADgtlXevyUTT86g==
X-Received: by 2002:a5d:69c7:0:b0:1f0:61f3:642b with SMTP id s7-20020a5d69c7000000b001f061f3642bmr7650058wrw.632.1646645886967;
        Mon, 07 Mar 2022 01:38:06 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600003cc00b001f34d8c5baesm918078wrg.78.2022.03.07.01.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:38:06 -0800 (PST)
Date:   Mon, 7 Mar 2022 09:38:04 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     christophe.leroy@csgroup.eu, mcgrof@kernel.org
Cc:     "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
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
Message-ID: <20220307093804.eor4dn5gp2dwn5jk@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-8-atomlin@redhat.com>
 <c03fa2bb-1b0e-62c7-53fe-33e44d20b564@csgroup.eu>
 <20220305203756.jc5ayzboea6ixm4a@ava.usersys.com>
 <4b00cc1c-0fc9-7348-28ee-b06de0fef3c7@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b00cc1c-0fc9-7348-28ee-b06de0fef3c7@csgroup.eu>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun 2022-03-06 17:46 +0000, Christophe Leroy wrote:
> 2/ CONFIG_MODULES=y, CONFIG_MODULE_SIG=n

Christophe,

I see, I did not notice that the above is even possible.

> Case 2/, is_module_sig_enforced() is nowhere.

Understood.


Luis,

I'll send a v10 later today.


Kind regards,

-- 
Aaron Tomlin

