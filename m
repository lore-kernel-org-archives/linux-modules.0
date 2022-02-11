Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640FAC433FE
	for <linux-modules@archiver.kernel.org>; Fri, 11 Feb 2022 13:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350666AbiBKNvw (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 11 Feb 2022 08:51:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350649AbiBKNvv (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Feb 2022 08:51:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF8D0F8
        for <linux-modules@vger.kernel.org>; Fri, 11 Feb 2022 05:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644587509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVg5C30Oj6ty7sDy10JOxyHHGxYzU297SK2Orj9qUYs=;
        b=CAkCvJCQgtduXww6fbrBHD9OywpOJWNQ4on59PfuQigaEsGJsHHWr1gbrezDT5OCF/XI9+
        pyrvsZyzOEOQc5/WoJOZ+qz5Q+AS9rUh7z3t1Sa0V0lhwAWB4QR9mHmOI83+wYqZMGnRDV
        PNw7u7bjg9rJFI+lHN6soJpi6l5ueFM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-TUB1RPCVO7St5kOxU7052g-1; Fri, 11 Feb 2022 08:51:48 -0500
X-MC-Unique: TUB1RPCVO7St5kOxU7052g-1
Received: by mail-lj1-f198.google.com with SMTP id f13-20020a2ea0cd000000b00243de4301e4so4011786ljm.5
        for <linux-modules@vger.kernel.org>; Fri, 11 Feb 2022 05:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVg5C30Oj6ty7sDy10JOxyHHGxYzU297SK2Orj9qUYs=;
        b=puwQOuISd/NTLgjptpIalUrsF0axUcF7/e/LouqDBDw3CBYeYycUf4MGGMegdOtd7U
         +CUl3PPtveQLiVFmLcNdeKhnzXMyh9jQ48pS0NruSi2dUdSZZuzfl3cUQ8gZf0906zhD
         3S7Q1c5JHh5Fi74xi+ws5YlyPolNluo/7G33guJo0yn5GZNpyLwouP9plgjshp8C2D22
         9AbECea4oqOq4Ctb8aDWXNZ4biOrhciVjRG0qAWKEOn5KoqxnglEO2XnzP9ogwA4v3+s
         LYgCWtvDSh6vDihjwCo3lM3xD+HpjzqQ1NcbYyz5KRXQ8T5aFTH9A+ex6zwwRo6bnA7I
         SS7w==
X-Gm-Message-State: AOAM532PZMtZwB0uGJU5RfoUvoAz99Trz7rqjjTzv3wlh1kGMHtYeLnr
        oVdv/BbdZWGCBn39n0j+7xFZ9VXUaWk4rSk4SMeDKPAZqygTsOga43xcImm5JUi/6L8aKrP1Pvf
        IBTh5koizcyNE6B3bSX2RT0LY1Kz5WVOOZQidSBhb
X-Received: by 2002:a2e:7311:: with SMTP id o17mr1072583ljc.303.1644587507236;
        Fri, 11 Feb 2022 05:51:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxYYIQ7iaZgj9t/ZkVJp2mKf0LBRcoXCaVyjq0xBb6DehIRF94SGL/fyH56gx3Xj0+ahH/2wW7s0aHY1BVMqs=
X-Received: by 2002:a2e:7311:: with SMTP id o17mr1072568ljc.303.1644587507053;
 Fri, 11 Feb 2022 05:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20220209170814.3268487-1-atomlin@redhat.com> <8b7988be-488e-f570-b499-5892c57f5e04@csgroup.eu>
In-Reply-To: <8b7988be-488e-f570-b499-5892c57f5e04@csgroup.eu>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Fri, 11 Feb 2022 13:51:35 +0000
Message-ID: <CANfR36i7fny7_z1j6bVAnzxVpxTXPQYTrZ-NoSTs63K-YuvNWg@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] module: Move extra signature support out of core code
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "20220209170358.3266629-1-atomlin@redhat.com" 
        <20220209170358.3266629-1-atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
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
        "void@manifault.com" <void@manifault.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu 2022-02-10 13:01 +0000, Christophe Leroy wrote:
> Why do patches 7 to 13 have a Reply-to:
> 20220209170358.3266629-1-atomlin@redhat.com and not patches 1 to 6 ?

Christophe,

Please disregard this mishap. Unfortunately, at the time I hit the relay
quota.

> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index fd6161d78127..aea0ffd94a41 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -863,6 +863,7 @@ static inline bool module_sig_ok(struct module *module)
> >   {
> >       return true;
> >   }
> > +#define sig_enforce false
> sig_enforce is used only in signing.c so it should be defined there
> exclusively.

Agreed.

> And checkpatch is not happy:
>
> CHECK: Please use a blank line after function/struct/union/enum declarations
> #27: FILE: include/linux/module.h:866:
>   }
> +#define sig_enforce false

Ok.


Kind regards,

-- 
Aaron Tomlin

