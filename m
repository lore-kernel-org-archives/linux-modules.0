Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E32CC7EE26
	for <linux-modules@archiver.kernel.org>; Wed,  3 May 2023 17:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjECRk7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 3 May 2023 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjECRk5 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 3 May 2023 13:40:57 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4009C6185
        for <linux-modules@vger.kernel.org>; Wed,  3 May 2023 10:40:55 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55a5e0f5b1aso36077527b3.0
        for <linux-modules@vger.kernel.org>; Wed, 03 May 2023 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683135654; x=1685727654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnWJwoqbKS+XkHViPIVupavn1s9FL+9QLrnitzrqP5g=;
        b=eK3o90MKtG0sAxJkQzBjjPPdgC8Naf0DW8LSnzzFyGy7r2iplN6tx8LRS+K1pesqQ/
         +dlPpm9XhI5MpmbmybPkhrAEcSQe8jXQWxke9zLF0oWZbujbmGNiLr16iUXkN33UUHSx
         XBXGIEWcktzdHazuLFLqwBuOkd1R9zqRh1rR05EQP6mEIW+Y870cMvkQ+YZdkTbO3EXe
         JnQPUyB6BIyM6BqPoFJBWX+ubIIjmGY6Y6TRZTV6HlKG9bq6FA2QoEZiVTg495moZLJm
         8j7J7Vy9fMLWKuo3JHmpkQUMBoO2kqt3hu+UuR0WJjg5iixGZu5y4Lvke1eQTwl5WZQa
         NpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683135654; x=1685727654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnWJwoqbKS+XkHViPIVupavn1s9FL+9QLrnitzrqP5g=;
        b=VySrbk5TqJNTRonToXdLB0sFreqS3cffTU39MO45cR7Gq6ANK3DW76+dnGgBNwDuOE
         QP4Ye+hA9WRtUuA3FtIAK2Ptv1MxOCZQx8P/nj/zxfKWxl8569zujmA/hr+AOp7PDz+H
         zZRg4K8VsgvkLIHIsJqMJ4G00nhHLWvlJ4W2AoCrm36pYEBgGE39MQvYqyrc/KWxEt92
         TOncIzy79VUnCCrrrLd9WVyD4rYaal0p7/0G8TAW2LFzZCWO4ol5ad9vkl0oupNK2R0L
         bpTWeBPLknPbm9UrXRS8oOYIrwOnhKHGTp2/FBzQVg408XRrKnNMgOrrlG6K0WPicqTE
         vekg==
X-Gm-Message-State: AC+VfDyUlqmPad5wD5y1ybHzokiOT2Qg49sj56k1/6kMUPcGzWJdDZQ4
        cOUqmzgHi7iDmMyOCuYPsQJJ1BNBEKLnRpJGxseceQ==
X-Google-Smtp-Source: ACHHUZ5+xgmBEFDJhkEbV6hOZk2BeNhUs5riMMl8CEWVIZEPl5lRwY7k05WxOPH80Nz6y5uKgnKRw8/1iWaKnQTfG2Y=
X-Received: by 2002:a25:1885:0:b0:b92:3f59:26e with SMTP id
 127-20020a251885000000b00b923f59026emr18942712yby.41.1683135654167; Wed, 03
 May 2023 10:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <CAJuCfpHxbYFxDENYFfnggh1D8ot4s493PQX0C7kD-JLvixC-Vg@mail.gmail.com> <20230503122839.0d9934c5@gandalf.local.home>
In-Reply-To: <20230503122839.0d9934c5@gandalf.local.home>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 May 2023 10:40:42 -0700
Message-ID: <CAJuCfpFYq7CZS4y2ZiF+AJHRKwnyhmZCk_uuTwFse26DxGh-qQ@mail.gmail.com>
Subject: Re: [PATCH 00/40] Memory allocation profiling
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
        paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
        minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, May 3, 2023 at 9:28=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 3 May 2023 08:09:28 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > There is another issue, which I think can be solved in a smart way but
> > will either affect performance or would require more memory. With the
> > tracing approach we don't know beforehand how many individual
> > allocation sites exist, so we have to allocate code tags (or similar
> > structures for counting) at runtime vs compile time. We can be smart
> > about it and allocate in batches or even preallocate more than we need
> > beforehand but, as I said, it will require some kind of compromise.
>
> This approach is actually quite common, especially since tagging every
> instance is usually overkill, as if you trace function calls in a running
> kernel, you will find that only a small percentage of the kernel ever
> executes. It's possible that you will be allocating a lot of tags that wi=
ll
> never be used. If run time allocation is possible, that is usually the
> better approach.

True but the memory overhead should not be prohibitive here. As a
ballpark number, on my machine I see there are 4838 individual
allocation locations and each codetag structure is 32 bytes, so that's
152KB.

>
> -- Steve
