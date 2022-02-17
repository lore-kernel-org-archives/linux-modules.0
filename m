Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05469C433EF
	for <linux-modules@archiver.kernel.org>; Thu, 17 Feb 2022 16:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbiBQQ1E (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:27:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242846AbiBQQ1E (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C9129AE52
        for <linux-modules@vger.kernel.org>; Thu, 17 Feb 2022 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645115208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hCGdZ67U7n7QTxmEpkXTMre/CxFj1dLb8EpsB9Wt9NU=;
        b=GezvIP/FDCuCmOONL2/N+znUrvSlf3Dn1YzdVsR8UGtqHkUlHeHjrzXvZ4uMgpgTxfZdQB
        5Fdi+oNp1g9Pot3OTRH3VRqxQNJxihltcVv0Bw7qEyr0U+qAbCIbXMp9h+usElW1+8fgAH
        yT1qx1qbo0kM/mYTRrQVGvDci7EE68E=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-b3IxMaaWOjOQOoJUHiuvEA-1; Thu, 17 Feb 2022 11:26:47 -0500
X-MC-Unique: b3IxMaaWOjOQOoJUHiuvEA-1
Received: by mail-lf1-f71.google.com with SMTP id q25-20020a056512211900b004422b53ec42so33506lfr.5
        for <linux-modules@vger.kernel.org>; Thu, 17 Feb 2022 08:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hCGdZ67U7n7QTxmEpkXTMre/CxFj1dLb8EpsB9Wt9NU=;
        b=qU+ZTqsinrErGqAyrPYpK5ol/iemXIbgQBP1cjH2jdAwcdik+gK1cmwobzbeACpAaJ
         q0OdTBtqZHJmVShxkHVrvT4FePIIQHyaXiYX8htjzKnp4xUHUNC2wtie+eeSzZ4zuqHb
         qE+akJ6p6q/sqmuRMao37g+r0YpVNBO/2dlGkjT+y/bIfky2VB4EubLCdtsceT1ZLCBH
         zA/pLTpeUg5hfVf6YZoTCxYULXbRtfBUp3FxPF4Ac/z0tH/k1vdrCRmEsMXZwYWfhOI7
         MGXmNU2ySYaeP52jbLbZVv7iADUmLsOCCiMYOcUqRXz4GV5SRcOtIACxlNn4iBe1839e
         97nw==
X-Gm-Message-State: AOAM530BZU4OZMX3j2F7Xqr6YoxfdIvjXBZzDSbM4mo6a1I2xFVZrzYV
        xo9XwkmsaEgoHgPUcJQCGahAYdWacXqCD5DqCQ81LzVqHMzAQQxhRWnsSsTJBHOZNuipO3SBbD4
        EcCINd5CBvu/B5eTFmO9c175FVSM3/6I5rtFN2qGh
X-Received: by 2002:a05:6512:150d:b0:442:aad5:2550 with SMTP id bq13-20020a056512150d00b00442aad52550mr2567901lfb.678.1645115205792;
        Thu, 17 Feb 2022 08:26:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLZ9H9RgrFT61tMlkFrlaF/ED3Z9gDTXl+XfGnohcx4TPIGO+mRgxBZFxuaJb0yee8DvwIgmsS16CP6ZukixU=
X-Received: by 2002:a05:6512:150d:b0:442:aad5:2550 with SMTP id
 bq13-20020a056512150d00b00442aad52550mr2567879lfb.678.1645115205613; Thu, 17
 Feb 2022 08:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20220209171118.3269581-1-atomlin@redhat.com> <20220209171118.3269581-3-atomlin@redhat.com>
 <14a1678f-0c56-1237-c5c7-4ca1bac4b42a@csgroup.eu> <CANfR36gVY+1k7YJy0fn1z+mGv-LqEmZJSvSHXn_BFR4WC+oJrQ@mail.gmail.com>
 <alpine.LSU.2.21.2202171648590.29121@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2202171648590.29121@pobox.suse.cz>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Thu, 17 Feb 2022 16:26:33 +0000
Message-ID: <CANfR36hExnjBM1=529Ae6EvETx7XiPFDSmZCTOV2MLS_YEfoCQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] module: Move version support into a separate file
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "void@manifault.com" <void@manifault.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu 2022-02-17 16:51 +0100, Miroslav Benes wrote:
> It is not, but "struct find_symbol_arg", which you moved, uses "enum
> mod_license" defined above, so you can either leave it as it is, or carve
> "enum mod_license" definition out.

Hi Miroslav,

I've done this already for v6. I hope to share the latest version for
review shortly.


Kind regards,

-- 
Aaron Tomlin

