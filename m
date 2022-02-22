Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4DCC433F5
	for <linux-modules@archiver.kernel.org>; Tue, 22 Feb 2022 11:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiBVLTM (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiBVLTL (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Feb 2022 06:19:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED76810876A
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645528725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A2gckBtnixMVaahVtnNibGnabKhb0jcedbRGPNNAXj0=;
        b=YQNUO0erd2QUKYfR/AbHaCec38fv2MvrXL9NyGsZ5/82YTC2MaN4IgtzSMiB9Yge8qgNat
        Ur8BG5GNECbfZc3MdfXA61qVvtnA+TEEtaRL5sLC7rnGBm3uuhWoalzAsEVcCulJC7K2Ok
        JaIvIvoOu7TLAekXNuCLYv2BYoYyTew=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-X2ZvEomBOhu04QSoDbY2cA-1; Tue, 22 Feb 2022 06:18:43 -0500
X-MC-Unique: X2ZvEomBOhu04QSoDbY2cA-1
Received: by mail-lj1-f197.google.com with SMTP id bf20-20020a2eaa14000000b0024634b36cdaso3672772ljb.0
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 03:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2gckBtnixMVaahVtnNibGnabKhb0jcedbRGPNNAXj0=;
        b=MoG4fCRhUbYvN6aTGF4whoPCi8++tCULHZvRlf8/kMH0GiZoIeShxoH6Qan9XPoMJG
         61KG0fjMCz+GULFW/0h2Ar1clHJa+BbSQ3d2kTP5NAOslqpnd6GPS9uDWNB/Fq+3i9gJ
         VNcBvKIiGbjtJ03D4r5fkbOZkwwTOuvMoFHImADLFU69IJVab2aBN/cHg2IS+kUt0bwb
         7324hJEuRC6dJbg8++i/K1bWvxv7b+Y3tcuCm+QA5QZDHTHFPrWrDa98mqHojvNZi0Q+
         YeXxewjf0Zouq8UNM+3GK4HFv7TC+wZXsSw3hlpnnNhdlE2yYBNVVf1PQ44frwNP33Dj
         bpyw==
X-Gm-Message-State: AOAM532rZyGz5ONJcomkvH0Uuw3Hp8SDZm7zMDiTW4/PzJjBOQopTmTI
        Jgbyt5c5nnTkW1rFBZVn7qIj2h9fJWhBS59MIp6kDoICp560an9XeSaXh/fKVHQGhGa62tY7VfM
        hjAZ1ygnHL9MISiI/nkPsmM5en8vkr2g+314KRCez
X-Received: by 2002:ac2:5cd0:0:b0:443:b112:e512 with SMTP id f16-20020ac25cd0000000b00443b112e512mr14638292lfq.118.1645528722353;
        Tue, 22 Feb 2022 03:18:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfIlZqtjd+JGObGg/qk7CWDZ/9xEu4n9eTUbEhI/8LWxeCG+1eUeDp/NcygYU0N+2juzdpOKkYm0z34f9B6/A=
X-Received: by 2002:ac2:5cd0:0:b0:443:b112:e512 with SMTP id
 f16-20020ac25cd0000000b00443b112e512mr14638272lfq.118.1645528722101; Tue, 22
 Feb 2022 03:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20220218212511.887059-1-atomlin@redhat.com> <YhBSBzmuiDQ4yMER@bombadil.infradead.org>
In-Reply-To: <YhBSBzmuiDQ4yMER@bombadil.infradead.org>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Tue, 22 Feb 2022 11:18:30 +0000
Message-ID: <CANfR36jqAk2DMxVOawYZfAz-BL-g-Dxj=x-mOes3wqnukz+VAg@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] module: core code clean up
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Lameter, Christoph" <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, live-patching@vger.kernel.org,
        Aaron Tomlin <atomlin@atomlin.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Allen <allen.lkml@gmail.com>, Joe Perches <joe@perches.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>, oleksandr@natalenko.name
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri 2022-02-18 18:12 -0800, Luis Chamberlain wrote:
> On Fri, Feb 18, 2022 at 09:24:58PM +0000, Aaron Tomlin wrote:
> > Hi Luis,
> >
> > As per your suggestion [1], this is an attempt to refactor and split
> > optional code out of core module support code into separate components.
> > This version is based on Linus' commit 7993e65fdd0f ("Merge tag
> > 'mtd/fixes-for-5.17-rc5' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux").
> > Please let me know your thoughts.
>
> Fantastic, thanks for doing all this work, I've pushed this out to
> modules-next so that the testing can start as this will be in linux-next
> soon. I'll obviously wait for more reviews, we have a long time before this
> gets merged to Linus, so just want to start getting testing done now rather
> than later. And other folks are depending on your changes to start
> getting their own code up too.

Hi Luis,

No problem. Unfortunately, this was not the complete series. I can send a
v7 later today with the suggested improvements made by Christophe.


Kind regards,

-- 
Aaron Tomlin

