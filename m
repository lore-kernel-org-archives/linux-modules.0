Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D696DC77B7C
	for <linux-modules@archiver.kernel.org>; Fri,  5 May 2023 18:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjEESKk (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 5 May 2023 14:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjEESKh (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 5 May 2023 14:10:37 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FB617DED
        for <linux-modules@vger.kernel.org>; Fri,  5 May 2023 11:10:32 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9ef06cb784so2755448276.0
        for <linux-modules@vger.kernel.org>; Fri, 05 May 2023 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683310232; x=1685902232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVZYG1JecNO86jzNV6C/AMNw6VQt+fJvqwCxq5mp/Nc=;
        b=JuehaV/RJK9Y4fUOdxkcZEuqDGAuEF/acJdDqJ45XbKARUoqq4czDg4ZH8mqWvQs0W
         C3cMUZ3VtCr6q/eI+6qJp58nulUMjZvQdZpvpUFXRdmOfRfhasZuNayk1xVHyGVy9Mwz
         ItoP45q/KUOjBJ5HUc+Vlm240zAnqes7cusDh4wsBFNSxkmDsbQVgr1QY7ENaCb2Pf+o
         stmyjKNibly7r3/lcAzIGX4ZSS4stgbgtYjMfq5c0cI/ZADNQtKt98fqV/f8MiQv11Tt
         rfeoXeDHmM1lnkcbyLTsW9UrOEazY/VwbfsLiL1Vyfp7oqXyyedjHeSP3hv1vKGbwqQn
         8juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683310232; x=1685902232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVZYG1JecNO86jzNV6C/AMNw6VQt+fJvqwCxq5mp/Nc=;
        b=QoA1kJUq4UEppFr5vUNKzEWdGQcpebZ6rlWvw5FaLQDGemmlCmqms2YtjjBwCOCzz5
         wzFhR/apJ+MRejlO1vfikboj37+D3HCa0yvuGcos7KRN1GdsaLn6nK3V2DFcR1v6dKrj
         HI+/YPXVQKVz7SnmudUy4xiAe3U41fjcAWzU0s1UhGrx6qN93pDKqWp6t++y+xAHuzRt
         d8OTU6ZSRVhNKc/ditSuBc5wfzviLGYK2E/PMf0Yur+G08j+9TZR20j7PdEHzN/0arTF
         XIgf/vbVMq0tUno90ptHVpCsjRDvM5ZTzn4JbFJdl/eseAbMAqc//NSGYGH5oN+E6V3T
         +lZQ==
X-Gm-Message-State: AC+VfDz3yrAe4nFlV/L8+HfxVjMpSOBm7EWNHdg06nrjEJGQRFCvh8tC
        VQqXaXkEXl73SAVzFUz2XLhHlGD1Cg5taCfCu9xLnw==
X-Google-Smtp-Source: ACHHUZ7QHqfeTFCV6iTpJ174mK2XnlUcdiV6R/LWDFZ2cFLepn3d5BnEaLb2X1/400R6vZerp7fSwFYV9RLQ6kw5Ucs=
X-Received: by 2002:a25:19d7:0:b0:b97:1e2e:a4e5 with SMTP id
 206-20020a2519d7000000b00b971e2ea4e5mr2351347ybz.40.1683310231779; Fri, 05
 May 2023 11:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-36-surenb@google.com>
 <ZFIPmnrSIdJ5yusM@dhcp22.suse.cz> <CAJuCfpGsvWupMbasqvwcMYsOOPxTQqi1ed5+=vyu-yoPQwwybg@mail.gmail.com>
 <ZFNoVfb+1W4NAh74@dhcp22.suse.cz> <CAJuCfpGUtw6cbjLsksGJKATZfTV0FEYRXwXT0pZV83XqQydBgg@mail.gmail.com>
 <ZFTA8xVzxWc345Ug@dhcp22.suse.cz>
In-Reply-To: <ZFTA8xVzxWc345Ug@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 5 May 2023 11:10:20 -0700
Message-ID: <CAJuCfpFOLyZKvtqHuukOZvegxGHVUcAtbh3Egt+01yZ9kcEAew@mail.gmail.com>
Subject: Re: [PATCH 35/40] lib: implement context capture support for tagged allocations
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
        mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
        peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, May 5, 2023 at 1:40=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Thu 04-05-23 09:22:07, Suren Baghdasaryan wrote:
> [...]
> > > But even then I really detest an additional allocation from this cont=
ext
> > > for every single allocation request. There GFP_NOWAIT allocation for
> > > steckdepot but that is at least cached and generally not allocating.
> > > This will allocate for every single allocation.
> >
> > A small correction here. alloc_tag_create_ctx() is used only for
> > allocations which we requested to capture the context. So, this last
> > sentence is true for allocations we specifically marked to capture the
> > context, not in general.
>
> Ohh, right. I have misunderstood that part. Slightly better, still
> potentially a scalability issue because hard to debug memory leaks
> usually use a generic caches (for kmalloc). So this might be still a lot
> of objects to track.

Yes, generally speaking, if a single code location is allocating very
frequently then enabling context capture for it will generate many
callstack buffers.

Your note about use of generic caches makes me think we still have a
small misunderstanding. We tag at the allocation call site, not based
on which cache is used. Two kmalloc calls from different code
locations will have unique codetags for each, so enabling context
capture for one would not result in context capturing for the other
one.

>
> > > There must be a better way.
> >
> > Yeah, agree, it would be good to avoid allocations in this path. Any
> > specific ideas on how to improve this? Pooling/caching perhaps? I
> > think kmem_cache does some of that already but maybe something else?
>
> The best I can come up with is a preallocated hash table to store
> references to stack depots with some additional data associated. The
> memory overhead could be still quite big but the hash tables could be
> resized lazily.

Ok, that seems like the continuation of you suggestion in another
thread to combine identical callstack traces. That's an excellent
idea! I think it would not be hard to implement. Thanks!

> --
> Michal Hocko
> SUSE Labs
