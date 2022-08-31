Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F86ECAAD4
	for <linux-modules@archiver.kernel.org>; Wed, 31 Aug 2022 15:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiHaPhb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiHaPh2 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 31 Aug 2022 11:37:28 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A1CD8E05
        for <linux-modules@vger.kernel.org>; Wed, 31 Aug 2022 08:37:27 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-324ec5a9e97so310661677b3.7
        for <linux-modules@vger.kernel.org>; Wed, 31 Aug 2022 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Z5bWT124P9msiKtHJxXWtamGxGE9nU7NFSbNkXeVir4=;
        b=q4yt7LQZaKZTdzRnqOfBDWuxDUawgahY2C4+8NClZrlVWpZiq8b8wuUtt2FXanHGEc
         GKUHZeMZM5jPluxM3gpqfRkq+ZEpQLG+BNvz98YUVO6qqcwbNq/QfwpxfY1bBqJ/PbUe
         qN9rURlcwiX2U8yaFrSKUwROmM3LF8ndCfS6j0AHC4HsQL8z7s2/MCCQMTRvX3Ne6rDh
         NX1iVO84IZTdrxORhVNpFjbUB389eDGDLX9acAC39/jQL/Xkcw+zdEhsbVQSkIB5PGSl
         3MgCLAYUQZJEhdAOCDXe/UR2KtUxqwQZuMK/LjLdJHtYQZbxs0yHQAWgM70EmS5KjdKg
         raEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Z5bWT124P9msiKtHJxXWtamGxGE9nU7NFSbNkXeVir4=;
        b=bHmar/cKmYxW6VFiq1+gHmhLyOiSM+4tOKm7IYR+Dj2Tty9H06YGol6kB4mI0s4d9D
         uUVp7ReMKlTeBJJ1JarB3NghgjzzoToiPE824h09mWGrNDRSyjblbU4eU0FSc2os/Phm
         1Av6nVFBH5NvlHOcdYNMLvbRbo42rAm7r8BLoP0kUmC/iPFp8z2/Xz5Q8r1X+I33Olsk
         Est8PKIyYnVeGOMn9igumLyq/DTqm2009OC/F6QD59kXXBRpovj7fhAhUFdZGCbiZoS8
         RZht2JsBv2Xer816FW/e4/eybKWD+nk/Y9p4gMl9kyU+AMyS01QLIufPTg5l6OOoz4Eu
         5rCQ==
X-Gm-Message-State: ACgBeo0Nc0b6kOtDNnav2qCAnwenZvu+kuiTXckElwaw4+UuxyXfavfE
        RvoBO5RNBIOZOes4M2Q/uzLikAyewHo/SCsMIqVVjQ==
X-Google-Smtp-Source: AA6agR4eyfrVHwFKMQTAM4+K85p4B7I6c+zSy9tLGnKDo68fc8kY3s9yyQtJtbnPccojelXd5+hkkFEpEU7+woAq0vg=
X-Received: by 2002:a81:7784:0:b0:33d:ca62:45f5 with SMTP id
 s126-20020a817784000000b0033dca6245f5mr18452862ywc.180.1661960245620; Wed, 31
 Aug 2022 08:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com> <20220830214919.53220-4-surenb@google.com>
 <20220831100249.f2o27ri7ho4ma3pe@suse.de>
In-Reply-To: <20220831100249.f2o27ri7ho4ma3pe@suse.de>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 31 Aug 2022 08:37:14 -0700
Message-ID: <CAJuCfpHpBCUma_=AdTQ+UkfSkfkov2JbKfxLdp5K9_MoonkT7g@mail.gmail.com>
Subject: Re: [RFC PATCH 03/30] Lazy percpu counters
To:     Mel Gorman <mgorman@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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
        Marco Elver <elver@google.com>, dvyukov@google.com,
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

On Wed, Aug 31, 2022 at 3:02 AM Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Aug 30, 2022 at 02:48:52PM -0700, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > This patch adds lib/lazy-percpu-counter.c, which implements counters
> > that start out as atomics, but lazily switch to percpu mode if the
> > update rate crosses some threshold (arbitrarily set at 256 per second).
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>
> Why not use percpu_counter? It has a per-cpu counter that is synchronised
> when a batch threshold (default 32) is exceeded and can explicitly sync
> the counters when required assuming the synchronised count is only needed
> when reading debugfs.

The intent is to use atomic counters for places that are not updated very often.
This would save memory required for the counters. Originally I had a config
option to choose which counter type to use but with lazy counters we sacrifice
memory for performance only when needed while keeping the other counters
small.

>
> --
> Mel Gorman
> SUSE Labs
