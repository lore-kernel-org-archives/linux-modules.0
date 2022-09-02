Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433A8ECAAD3
	for <linux-modules@archiver.kernel.org>; Fri,  2 Sep 2022 00:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiIBAY6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Sep 2022 20:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbiIBAYz (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Sep 2022 20:24:55 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6100C9FEE
        for <linux-modules@vger.kernel.org>; Thu,  1 Sep 2022 17:24:52 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 11so1136926ybu.0
        for <linux-modules@vger.kernel.org>; Thu, 01 Sep 2022 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/pPOPbPw8AnpH29BUzSqTrm5ZvDmaEgEyFxuBQlNiEg=;
        b=JFydOg9QoPX5QvCMFfTX+qzkxy7dX+yug3qLsycd8X5fIiKliNhG2sOdd7n2FZxg0x
         wlIQ0PSe2w+jF1eYJALDSn9VwIQg7e+fojjEXzmIOWtowrPcZ8vVaDgvGlc5viuLzbLq
         BuWwUYh3dJTjnuDVzKYwlUlnzQN1dlqhuf8e4UUJj0Gz3yVOw7ZhtZlACThcN+JogWbQ
         XLiaLX50zBOT8vT4sikyfQhvA5G9n7Ys1zkULvj3Bu6V7OPgO3m2SYNlgkEGLVgRXA6S
         YaT8WKnNiPs7HVTvCKPZfxYMJ9fk0eCfVfQjSQqADIJwkH1wr6+8aSYndPr9n1G1vqpS
         RvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/pPOPbPw8AnpH29BUzSqTrm5ZvDmaEgEyFxuBQlNiEg=;
        b=jHOrYJ5ddgOSSNmqiTFfnCut3b3OXkhnpbajNr/0Tmm4ggdEXyqLorm6joJ46s52N6
         O4fSJFf13Yansp/h/PZ5IUbYpYQZN8L/asFdeC+6lgc74ZVScUbxo3P3txUdEDqe1UCS
         37CRotnqz+d6LClhNa4tgI2CkRamNW5N6m6Bt4MAki0ZWEvvBhPkJE3iVXtlPXf94HGm
         69sDoaA8hmAwP8ZDsQBkGi20mFrjWDVKm/pNa440MSxuTDR0f1Hef2P7eX01baMY2r6P
         v6fPV2jyOfSLz1rfB44VbRrWpCZqYZmbBmWdDfRFnY4T5rVVE6N4Bwd4wdAZHq0jKPpL
         dwHQ==
X-Gm-Message-State: ACgBeo0OFfZw4Ge6jzVgXZdXN7uoQfTM49oDrFkFNvkL+guk8mMMrW7c
        53bgUwj/2zBoInT1FG4hkFR8d12d/KC/kNu2BgeFgA==
X-Google-Smtp-Source: AA6agR5/Ulv2F+QXTz0x1dcq0Ynnhj3rjvCeoD8VrxwV966KDu/pwW+2XwncQnNg3JY46QNFp+MHM1SP5XYuAvh7JKU=
X-Received: by 2002:a05:6902:705:b0:695:b3b9:41bc with SMTP id
 k5-20020a056902070500b00695b3b941bcmr21283555ybt.426.1662078291363; Thu, 01
 Sep 2022 17:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com> <20220830214919.53220-15-surenb@google.com>
 <YxFC9NSQ7OADTEwp@P9FQF9L96D.corp.robot.car>
In-Reply-To: <YxFC9NSQ7OADTEwp@P9FQF9L96D.corp.robot.car>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Sep 2022 17:24:40 -0700
Message-ID: <CAJuCfpGRL72qghDf9bNsp_K0kabvLBs5ags2hHXn-5_Ar8RX5A@mail.gmail.com>
Subject: Re: [RFC PATCH 14/30] mm: prevent slabobj_ext allocations for
 slabobj_ext and kmem_cache objects
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        David Vernet <void@manifault.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, changbin.du@intel.com,
        ytcoode@gmail.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, 42.hyeyoo@gmail.com,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>, arnd@arndb.de,
        jbaron@akamai.com, David Rientjes <rientjes@google.com>,
        Minchan Kim <minchan@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>, iommu@lists.linux.dev,
        kasan-dev@googlegroups.com, io-uring@vger.kernel.org,
        linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-bcache@vger.kernel.org, linux-modules@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Sep 1, 2022 at 4:41 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Tue, Aug 30, 2022 at 02:49:03PM -0700, Suren Baghdasaryan wrote:
> > Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
> > objects. Also prevent slabobj_ext allocations for kmem_cache objects.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Patches 12-14 look good to me.
> It's probably to early to ack anything, but otherwise I'd ack them.

Thank you for reviewing!

>
> Thanks!
