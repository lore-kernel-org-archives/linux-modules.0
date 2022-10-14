Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EAEC433FE
	for <linux-modules@archiver.kernel.org>; Fri, 14 Oct 2022 07:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJNHzD (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 14 Oct 2022 03:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiJNHzB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 14 Oct 2022 03:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D0032AB4
        for <linux-modules@vger.kernel.org>; Fri, 14 Oct 2022 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665734093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kwtn6uvhgQEqm/XpkC52bizaNd8cjGpKe1WGKPimX2I=;
        b=UNGzN68VwMF05ZNykEjg7O9sYN7F15kZ+AYjJvFYX4arZNj2+Aabbh6TIu+WXBmZcvqIuP
        OlSK3HBshyLolCSVDzcpyecrVAqEgzlcQh9JywpscsBbrbncMaoHxPgkhuXk9gFIEEZuw7
        X7kQC4mWTF94u1b3R2EmnqNbf090y2Y=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-527-E41bAKeiN0SALFOUew90ig-1; Fri, 14 Oct 2022 03:54:52 -0400
X-MC-Unique: E41bAKeiN0SALFOUew90ig-1
Received: by mail-vs1-f70.google.com with SMTP id z190-20020a6765c7000000b003a6ec561837so1078990vsb.19
        for <linux-modules@vger.kernel.org>; Fri, 14 Oct 2022 00:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwtn6uvhgQEqm/XpkC52bizaNd8cjGpKe1WGKPimX2I=;
        b=fjCeLGkEF+Zh1O5KVSeCh6Abg9eOXKsG5rguEDnM0JRe5WxF/z8G75kMIM4I+T3prG
         Dxdu4BTD+GbYnLPFEEHs0ucOGLdOrsJtrE+uV+/mxs3QBjM7sJHICaymd/tnf29KayHL
         Xi4GCpgr+qFs3pS+viZXTGE5OpI3IGrGFfXMKNeCSFv1ddEhiM0NA3NhCuujWT3sJr7a
         EK9TBM3xsTeYCknC3g9sgVierDoeToQ8JEfv/blE28BQzdziVx/H22z1U0gsPlMh1zUO
         3EXtKhEaTQPH8PV8lhp6e+FycKyR8u7d7XpT7Bkq2UgytR0tTr9Cx/2yBSLXpudgXjaQ
         wD3Q==
X-Gm-Message-State: ACrzQf3zaZdJhQL2uuceLEUXjm6AKWBaeOrF60SJ1BV72SEUa5ZiOUN8
        P+AuX1kJXlo4VWehPcA4BWbZuaFhx9dAZbYRqWPqz1CD8RWwzCqJT7Qv5DIdkuloMlp5kCg/jMG
        9Mvxy2DULfIYxQAG8na73Xc12lK6T4nvR86AQAKA6hA==
X-Received: by 2002:ab0:7590:0:b0:3ea:d2ef:ee0d with SMTP id q16-20020ab07590000000b003ead2efee0dmr1991788uap.62.1665734091459;
        Fri, 14 Oct 2022 00:54:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM56JqUVAqmbVw+dtHtQM+y2Di+UwZLKyQqOqheAu6wo2RecBdTSfwx+px7+hQCfD79pvuwlD+7EI56QH9y5dR4=
X-Received: by 2002:ab0:7590:0:b0:3ea:d2ef:ee0d with SMTP id
 q16-20020ab07590000000b003ead2efee0dmr1991781uap.62.1665734091201; Fri, 14
 Oct 2022 00:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220919123233.8538-1-petr.pavlu@suse.com> <20220919123233.8538-3-petr.pavlu@suse.com>
In-Reply-To: <20220919123233.8538-3-petr.pavlu@suse.com>
From:   David Hildenbrand <david@redhat.com>
Date:   Fri, 14 Oct 2022 09:54:40 +0200
Message-ID: <CADFyXm5AP8pvXAKRBVNsZd5SUPziKBV0UktwORokuLU7c6Sbvg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mcgrof@kernel.org, pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Sep 19, 2022 at 2:33 PM Petr Pavlu <petr.pavlu@suse.com> wrote:
>
> During a system boot, it can happen that the kernel receives a burst of
> requests to insert the same module but loading it eventually fails
> during its init call. For instance, udev can make a request to insert
> a frequency module for each individual CPU when another frequency module
> is already loaded which causes the init function of the new module to
> return an error.
>
> The module loader currently serializes all such requests, with the
> barrier in add_unformed_module(). This creates a lot of unnecessary work
> and delays the boot.
>
> This patch improves the behavior as follows:
> * A check whether a module load matches an already loaded module is
>   moved right after a module name is determined. -EEXIST continues to be
>   returned if the module exists and is live, -EBUSY is returned if
>   a same-name module is going.
> * A new reference-counted shared_load_info structure is introduced to
>   keep track of duplicate load requests. Two loads are considered
>   equivalent if their module name matches. In case a load duplicates
>   another running insert, the code waits for its completion and then
>   returns -EEXIST or -EBUSY depending on whether it succeeded.
>
> Note that prior to 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
> for modules that have finished loading"), the kernel already did merge
> some of same load requests but it was more by accident and relied on
> specific timing. The patch brings this behavior back in a more explicit
> form.
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---

Hi Petr,

as you might have seen I sent a patch/fix yesterday (not being aware
of this patch and that
this is also a performance issue, which is interesting), that
similarly makes sure that modules
are unique early.

https://lkml.kernel.org/r/20221013180518.217405-1-david@redhat.com

It doesn't perform the -EBUSY changes or use something like
shared_load_info/refcounts;
it simply uses a second list while the module cannot be placed onto
the module list yet.

Not sure if that part is really required (e.g., for performance
reasons). Like Luis, I feel like
some of these parts could be split into separate patches, if the other
parts are really required.

I just tested your patch in the environment where I can reproduce the
vmap allocation issue, and
(unsurprisingly) this patch similarly seems to fix the issue.

So if your patch ends up upstream, it would be good to add some details
of my patch description (vmap allocation issue) to this patch description.


Cheers,
David

