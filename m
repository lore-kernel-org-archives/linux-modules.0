Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CCAC77B73
	for <linux-modules@archiver.kernel.org>; Tue,  2 May 2023 18:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjEBSdb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 2 May 2023 14:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjEBSdb (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 2 May 2023 14:33:31 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8CB19A2
        for <linux-modules@vger.kernel.org>; Tue,  2 May 2023 11:33:27 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9d9dad9edfso5350914276.2
        for <linux-modules@vger.kernel.org>; Tue, 02 May 2023 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683052406; x=1685644406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HVL3xDTGrQVKytv3307oE4wI2qXt6O5pXdSbfIsmfw=;
        b=1qOKHMcI8DulkSfoRMvX8Pr+Zk5uyPKcuzTjDblLNP1XefPQJkSAxIcSan4hxrkYmM
         mijXYJDbwYfBriku1yo2jZFFkuGOQV27nGEoociEa+x4EBkt6xdc8TTdBr8ExPJqJxj3
         I+cfPJCKCtCybq2dUPwiVCF4ankuJVJJAVwM7AetAdBoRpl61AdRNAdTS18dObY9arIk
         e9qSsTvg8C0oNmcsYUHHNiUOhvlpSnEvLmwlJBc13gXCsXeR7WXU4bYyLgUPMLC/5oWj
         1vsg/b1NFVc8TUatQihkDpPMckBOmQMwujeGiTah+4Xw72cOHRDooXz8s6AG9qHHNqgj
         yg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683052406; x=1685644406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HVL3xDTGrQVKytv3307oE4wI2qXt6O5pXdSbfIsmfw=;
        b=SuaNroEMG/wbsi1QsBBZziN0h5Y4HsZjdM+8MO7UR5laG1C2PWdYwMJNdzpBwFpUcn
         QquDLueOWM2NUhAaxUttGomy3d/4hKkOl8d+HWIqS0f1TesnSs/Fwy2IrpXgTowMHPYR
         cYt6aLYvWHcU4P77z7NzEwxYqkpTCC1vWIDbGRtRZTia56j9P/7GuUnDsIz1Wbj0aBpm
         gDrM9IUyA4uDN89kDYPKouWnMMr88/GEaEFOv2UJ/CFiB/NL1ysrR7DTjqvmRV9U1bGe
         2g0KEsMxhZ9kGFGPptT5/A35/tDTPbgkDOJPul9g+zQ3gOYKjQqKXCCur7gpiuxFGVJI
         tP0w==
X-Gm-Message-State: AC+VfDz7c/seJN1LiMgMbEz/muld4ThoOBx4D6MdYrz25Gh6WjTHzJSE
        +efvtCVaW1MvURjh4+ODA1RUM1dTUjMrWBb3Ltkqaw==
X-Google-Smtp-Source: ACHHUZ4Ewf11C+rTiwahBlNL1qKIj3O23xR+7SsYrPD/20BDq48yN50kv92ybg7MVXiIqETdHq5IqlKzhO8SvqkLc+8=
X-Received: by 2002:a25:4115:0:b0:b9e:9159:6a0c with SMTP id
 o21-20020a254115000000b00b9e91596a0cmr1235704yba.6.1683052406321; Tue, 02 May
 2023 11:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-10-surenb@google.com>
 <20230502145014.24b28e64@meshulam.tesarici.cz>
In-Reply-To: <20230502145014.24b28e64@meshulam.tesarici.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 May 2023 11:33:15 -0700
Message-ID: <CAJuCfpGA9SMwyQ44XHRHHVf32MPu4o6wy1Q6H=AfJy61Ez-06Q@mail.gmail.com>
Subject: Re: [PATCH 09/40] mm: introduce __GFP_NO_OBJ_EXT flag to selectively
 prevent slabobj_ext creation
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
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

On Tue, May 2, 2023 at 5:50=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@tesaric=
i.cz> wrote:
>
> On Mon,  1 May 2023 09:54:19 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocatio=
ns
> > when allocating slabobj_ext on a slab.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/gfp_types.h | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> > index 6583a58670c5..aab1959130f9 100644
> > --- a/include/linux/gfp_types.h
> > +++ b/include/linux/gfp_types.h
> > @@ -53,8 +53,13 @@ typedef unsigned int __bitwise gfp_t;
> >  #define ___GFP_SKIP_ZERO     0
> >  #define ___GFP_SKIP_KASAN    0
> >  #endif
> > +#ifdef CONFIG_SLAB_OBJ_EXT
> > +#define ___GFP_NO_OBJ_EXT       0x4000000u
> > +#else
> > +#define ___GFP_NO_OBJ_EXT       0
> > +#endif
> >  #ifdef CONFIG_LOCKDEP
> > -#define ___GFP_NOLOCKDEP     0x4000000u
> > +#define ___GFP_NOLOCKDEP     0x8000000u
>
> So now we have two flags that depend on config options, but the first
> one is always allocated in fact. I wonder if you could use an enum to
> let the compiler allocate bits. Something similar to what Muchun Song
> did with section flags.
>
> See commit ed7802dd48f7a507213cbb95bb4c6f1fe134eb5d for reference.

Thanks for the reference. I'll take a closer look and will try to clean it =
up.

>
> >  #else
> >  #define ___GFP_NOLOCKDEP     0
> >  #endif
> > @@ -99,12 +104,15 @@ typedef unsigned int __bitwise gfp_t;
> >   * node with no fallbacks or placement policy enforcements.
> >   *
> >   * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
> > + *
> > + * %__GFP_NO_OBJ_EXT causes slab allocation to have no object
> > extension. */
> >  #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
> >  #define __GFP_WRITE  ((__force gfp_t)___GFP_WRITE)
> >  #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
> >  #define __GFP_THISNODE       ((__force gfp_t)___GFP_THISNODE)
> >  #define __GFP_ACCOUNT        ((__force gfp_t)___GFP_ACCOUNT)
> > +#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
> >
> >  /**
> >   * DOC: Watermark modifiers
> > @@ -249,7 +257,7 @@ typedef unsigned int __bitwise gfp_t;
> >  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
> >
> >  /* Room for N __GFP_FOO bits */
> > -#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
> > +#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
>
> If the above suggestion is implemented, this could be changed to
> something like __GFP_LAST_BIT (the enum's last identifier).

Ack.

Thanks for reviewing!
Suren.

>
> Petr T
