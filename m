Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4F5C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 22 Feb 2022 11:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiBVLkk (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiBVLkj (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Feb 2022 06:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA7BF13758D
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 03:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645530014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDOc+YRLeZJFp9TJBEyVb3TJxfy4VJufE8kNQgp1LCU=;
        b=Bhd3G9cCNrKCrnHuSIU9YqoM+dMflr+GdkW6a+bmeOfVvhbZf4AGpT/rNbc6fYs0bwsJm2
        yHg0WyjIEpopJLc36X9HV1JzahbB8oSyREzS6FQlcNcuE3aEMhBtmVW74T17SgO4grXyrV
        L9y0BwSPDABrrFld2r/lDOgvYcnY+3U=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-h9CtIwjROFquZd7CnIpwIw-1; Tue, 22 Feb 2022 06:40:12 -0500
X-MC-Unique: h9CtIwjROFquZd7CnIpwIw-1
Received: by mail-lj1-f200.google.com with SMTP id v5-20020a2ea605000000b00246322afc8cso3744204ljp.4
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 03:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDOc+YRLeZJFp9TJBEyVb3TJxfy4VJufE8kNQgp1LCU=;
        b=0iQTQfIibOgPMCHgriOrJOvWQFtntzqGyn4D5Cn//fQXjg5+qpCqtl6a8AFUfc2cHh
         HRQnfbEDJ6f3JtyJkCKporEUfQ8y38vBmMSHx01Cp9/nE78m65ZxFmjFRjSqYwBLJQWj
         e9PypQUzwwpWrkhy7GeRpTDR+fvmc/xIWplyl+QKz944afTn3Gr3FzujTYxa3CP4cgWP
         9rjRcx6sB7VMhVlxvIqiUH2H99IDHkC18NZqp8vMzP2EtA18pgZ/nHDHrVKllquz7Hln
         3Hnf4XMfaCltCBS5hnlw8DqC0WwuTRhDsIFEPFBdEjk6qkj/7lkno9ZSJ/yTwtBwRee3
         B0mg==
X-Gm-Message-State: AOAM530R5biL/M7jgFf5aq2PbVOi2DNnTebF/NT4Lzt5jgAf+XgGO0Mk
        Hs93QX/wk6PmqwAou1qUS0QiyHeJxirVM7baundDirj0UHPkXlSXW+VCBLKOIwiUPAFQGxa1h/4
        TfhH0gJKyhvcBamC4un0NWEzZ88kytDSRwwOHb5Ei
X-Received: by 2002:a05:6512:150d:b0:442:aad5:2550 with SMTP id bq13-20020a056512150d00b00442aad52550mr17102464lfb.678.1645530010812;
        Tue, 22 Feb 2022 03:40:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxp9ND52uoXkke98z5pWzxR3iqGGOklbjfe+dVnjKjVL9zW5s8PQ5saQ9Gr2u5WGcVSYz2QwBH1UrpydZkDR2A=
X-Received: by 2002:a05:6512:150d:b0:442:aad5:2550 with SMTP id
 bq13-20020a056512150d00b00442aad52550mr17102457lfb.678.1645530010666; Tue, 22
 Feb 2022 03:40:10 -0800 (PST)
MIME-Version: 1.0
References: <20220218212511.887059-1-atomlin@redhat.com> <20220218212511.887059-2-atomlin@redhat.com>
 <fc315ebf-1ddf-13a8-7fc4-c5310e5785d4@csgroup.eu> <CANfR36jccn4nHTSNOHbCz5mjaQ6r-uJONBt3taTgeX_XTEeWFw@mail.gmail.com>
 <de3fc3fa-bb74-67f9-fb39-81d2307757c6@csgroup.eu>
In-Reply-To: <de3fc3fa-bb74-67f9-fb39-81d2307757c6@csgroup.eu>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Tue, 22 Feb 2022 11:39:59 +0000
Message-ID: <CANfR36jvnngjDQeF5vZ=bw8=Nt26hLUY4W069cvD-qxM0pz-Hw@mail.gmail.com>
Subject: Re: [PATCH v6 01/13] module: Move all into module/
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-02-22 11:20 +0000, Christophe Leroy wrote:
> I don't know.
>
> The comment says:
>
> # These are called from save_stack_trace() on slub debug path,
> # and produce insane amounts of uninteresting coverage.
>
> This was brought by commit 5c9a8750a640 ("kernel: add kcov code coverage")
>
> Since then, some architectures don't have save_stack_trace() anymore as
> they were converted to generic ARCH_STACKWALK.
> It was done on powerpc by commit a1cdef04f22d ("powerpc: Convert
> stacktrace to generic ARCH_STACKWALK")
>
> Whatever you decide to do, you can't leave this in kernel/Makefile as
> module.o is gone.

Fair enough. I'll move it and copy the comment to kernel/module/Makefile.

-- 
Aaron Tomlin

