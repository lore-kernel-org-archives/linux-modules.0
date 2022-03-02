Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A229BC433F5
	for <linux-modules@archiver.kernel.org>; Wed,  2 Mar 2022 20:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbiCBUcx (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243820AbiCBUct (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 2 Mar 2022 15:32:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7323DD21D3
        for <linux-modules@vger.kernel.org>; Wed,  2 Mar 2022 12:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646253118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1OP/2uKx8aEk4QRV1/mS4vizgIt0EsBCCmcOClKYRNA=;
        b=O995EEp3ddOEd/DvNzKmdcSg7xuzIve8PzP/FeNP2y8Z0H1eu3JJeDmbqO02SUueZYQgSv
        0hteHT/v4LsPdeB/yKckGAvlW5rgPGvqNXQ8R80abVVPzT0Fom+2RAWxBH+HhQoojt5gDv
        aFuFq5EUvhEl5w4IaQmQmhm6r1ClcTM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-IjNFxTGTNqCBRiurgf5i_A-1; Wed, 02 Mar 2022 15:31:57 -0500
X-MC-Unique: IjNFxTGTNqCBRiurgf5i_A-1
Received: by mail-wm1-f69.google.com with SMTP id f189-20020a1c38c6000000b0037d1bee4847so2320982wma.9
        for <linux-modules@vger.kernel.org>; Wed, 02 Mar 2022 12:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1OP/2uKx8aEk4QRV1/mS4vizgIt0EsBCCmcOClKYRNA=;
        b=FaUQVNH14XUnV/3o8i6kz9TO4UXxx91EYYzdgkyFDwZBaOginJBZC9u9qM4k9vHCEb
         cZYW4rUCAjVohzdLvRplmE/hVLRTw82TspFlFMBr9rlVUxW5FD7raA6eehGlXFgILj/T
         gZ4+Va3STiWqtGC+OjFtDMg/F3TZ8vSWUrdgw74ARvGl48FHfBkLmf0itUp1Cwde7M/d
         yFo8kPnq1gLExmCNyUy62WUr7RHrqTT0gnYm6wnw8YtHW+sdMqoaHmeJ2NMnK+cdEbeD
         kOZYHrIRjwhVXV4mXIZSA29H+dWl9miGZX7CR9KMF2KgQUJS4BMEMgk7Fm5AR4+6g746
         NjqA==
X-Gm-Message-State: AOAM530dN2V0bz7OWOZFcnHWhtijL1GIGqJAGCwNhP2Cs0cQph/wliUN
        jxyHEU5/ZxCKK/7Bqi0lNmEi7NIrYCmfXSAYbORWrB1pPBliEo9i4AXXgXKDiC32feiuf8aNNd3
        y9ChOB/I8tiD6u7vUw40K/Y1E
X-Received: by 2002:a1c:5410:0:b0:380:b8bb:9d22 with SMTP id i16-20020a1c5410000000b00380b8bb9d22mr1260567wmb.29.1646253115406;
        Wed, 02 Mar 2022 12:31:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFWBKJG8eQpQiJzTkTDgjatLYV6yxzNWz1goIG7XaShVpZwHqsqnvMh53pcIgZ0494L6cA4w==
X-Received: by 2002:a1c:5410:0:b0:380:b8bb:9d22 with SMTP id i16-20020a1c5410000000b00380b8bb9d22mr1260551wmb.29.1646253115198;
        Wed, 02 Mar 2022 12:31:55 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id m10-20020adfe94a000000b001ef57f562ccsm37971wrn.51.2022.03.02.12.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:31:54 -0800 (PST)
Date:   Wed, 2 Mar 2022 20:31:53 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220302161917.gx5icfszakoye4uh@maple.lan>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed 2022-03-02 16:19 +0000, Daniel Thompson wrote:
> On Mon, Feb 28, 2022 at 11:43:21PM +0000, Aaron Tomlin wrote:
> > No functional change.
> > 
> > This patch migrates kdb_modules list to core kdb code
> > since the list of added/or loaded modules is no longer
> > private.
> > 
> > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > ---
> >  kernel/debug/kdb/kdb_main.c    | 5 +++++
> >  kernel/debug/kdb/kdb_private.h | 4 ----
> >  kernel/module/main.c           | 4 ----
> >  3 files changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index 0852a537dad4..5369bf45c5d4 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -59,6 +59,11 @@ EXPORT_SYMBOL(kdb_grepping_flag);
> >  int kdb_grep_leading;
> >  int kdb_grep_trailing;
> >  
> > +#ifdef CONFIG_MODULES
> > +extern struct list_head modules;
> > +static struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */

Hi Daniel,

> If modules is no longer static then why do we kdb_modules at all?
> kdb_modules is used exactly once and it can now simply be replaced
> with &modules.

In my opinion, I would prefer to avoid an explicit include of "internal.h"
in kernel/module. By definition it should be reserved for internal use to
kernel/module only. Please keep to the above logic.

Christophe, Luis,

Thoughts?


Kind regards,

-- 
Aaron Tomlin

