Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98778C433EF
	for <linux-modules@archiver.kernel.org>; Wed, 23 Feb 2022 16:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbiBWQ6G (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 23 Feb 2022 11:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbiBWQ5x (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 23 Feb 2022 11:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C861D4F46A
        for <linux-modules@vger.kernel.org>; Wed, 23 Feb 2022 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645635442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9lYnlwo80ekeXGGRVop7tuYwutJe1OPkYrSCkXet1IY=;
        b=PCg75THXWbN9SdgPA9/08lLwPNi8562PamPzUMr8FNxuO43TGJVs9of23M+ehtz4mHMsvY
        5O008fO6zLfevyDuPYDRcRF6bYdw9jc4mBGelLq5BOJZMv4QmeUc4z3D2Fb9Yd9RkCyuG3
        5z1NOVHmfD6XqUZdI62W3RcOTNEslE8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-tP0ThhiLNSa8Fihkgz3KTg-1; Wed, 23 Feb 2022 11:57:21 -0500
X-MC-Unique: tP0ThhiLNSa8Fihkgz3KTg-1
Received: by mail-lf1-f72.google.com with SMTP id m13-20020a19520d000000b00443423ff116so3347908lfb.11
        for <linux-modules@vger.kernel.org>; Wed, 23 Feb 2022 08:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lYnlwo80ekeXGGRVop7tuYwutJe1OPkYrSCkXet1IY=;
        b=CoWHGPVoPeASxJHy6Qc1TPJeDTY3n8N6Ksx+LgHJQjN7yDGgrP3vwj97NoO9IgYX88
         yS5Bo7TLuSSea+CdMuExCkh8Tbu4v9WOH8xgVPQb0LP2rdxD66ZNYGf+BjT94evpdXGw
         WvTXBZPpe8T7dPCU3CDzGsy3w+JmFbtPj3mRHKFHvNoPIo9r4x3HWkh0X+Ersbkte7TK
         ZubAbcvLycwaflUQomJ/QtnPkirCft/fLP+eOhaZjW2oPoMmB5mt7z7FK/YxhlQouJPB
         HLd5j4167oJFVVyZh/Vhgr+qVXFCdv1XMZGX9UA6F2s/vb65tVvHd7SEok6g8eqaRCM8
         2PpQ==
X-Gm-Message-State: AOAM533SYIvhVtU4qJlbiU3swVosZF5pkj482jlcbbOPcixEnhHV/SY1
        HPkq0YgUnWy8Du7vED92XjLp4j9GCncUrS7ddfBGIDRKxYGCC9UiFiUl8Gz1GWPXR1/nJpY6RCE
        WrYpCGaK4ANXlfESVsPl755QqyafP8PwVMmrhdQk2
X-Received: by 2002:a05:6512:3e14:b0:429:6e79:ca87 with SMTP id i20-20020a0565123e1400b004296e79ca87mr373907lfv.163.1645635440063;
        Wed, 23 Feb 2022 08:57:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8y+omW9xDDExHxhQDd6HLWNp9jDmHi7Vn79thFemSUK3HSORLo1ni7xvXLOo+Lt62XO3uuANFgjglrY2gMK4=
X-Received: by 2002:a05:6512:3e14:b0:429:6e79:ca87 with SMTP id
 i20-20020a0565123e1400b004296e79ca87mr373887lfv.163.1645635439848; Wed, 23
 Feb 2022 08:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20220218212511.887059-1-atomlin@redhat.com> <20220218212511.887059-2-atomlin@redhat.com>
 <69fcaad3-e48c-11ca-ed50-7a18831e3e91@csgroup.eu> <CANfR36js06qG8HkQBPPz8bnYzcBRUtiZJAqhynt4XJcfcFXAQg@mail.gmail.com>
 <YhWK4woM1g2fAq72@bombadil.infradead.org>
In-Reply-To: <YhWK4woM1g2fAq72@bombadil.infradead.org>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Wed, 23 Feb 2022 16:57:08 +0000
Message-ID: <CANfR36jtiq86FpONCFPOsh6x=eLnC9js+LewtUTSfZxoHoMb6w@mail.gmail.com>
Subject: Re: [PATCH v6 01/13] module: Move all into module/
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-02-22 17:16 -0800, Luis Chamberlain wrote:
> How about:
>
> obj-$(CONFIG_MODULE_SIG_FORMAT) += module/module_signature.o
>
>   Luis

Hi Luis,

Please see v8 [1].

[1]: https://lore.kernel.org/all/20220222141303.1392190-1-atomlin@redhat.com/


Kind regards,

-- 
Aaron Tomlin

