Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEE6C761AF
	for <linux-modules@archiver.kernel.org>; Wed, 29 Mar 2023 16:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjC2QvT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Mar 2023 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjC2QvS (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Mar 2023 12:51:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C218658D
        for <linux-modules@vger.kernel.org>; Wed, 29 Mar 2023 09:51:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ek18so65957174edb.6
        for <linux-modules@vger.kernel.org>; Wed, 29 Mar 2023 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680108658; x=1682700658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuabhBI/cJhvDusEUPo+YOaR3W7tGSIZ44NN+9mu0w0=;
        b=WPU7CQZXsHT2W6o+O27Wpj5VLxahEGVYuFGJ09lWVVUb6Uog7j2W3oCfdskI6i1Ubk
         gOKt3sOlvhKigmmF1pAoCh6e/zApTuFMSDe/1Ogb06wgZ5eTbVWDjmqb/YOcqB8hVtud
         n9GOwJeinQ3x7aNVLHZ7ZSgZ/qGs4xL/xImVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680108658; x=1682700658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuabhBI/cJhvDusEUPo+YOaR3W7tGSIZ44NN+9mu0w0=;
        b=rOWauXWUhn3MpAYkXbJ5CjQf8I59xwauXsFKaP9jDaHTMbpXT8YpceoPRbzXi5hQfp
         mmXN/rsJsw1rRzr1qx6xkaHNDMHqRDbZ7BV2s6ZoSI2h0Ui6f1IRZN3de/OST9iGg6Nm
         XqFZogQZ86ZZNsmtrqtOwqZIGSVgS/5pCfHxyL0PjCZOiKw7mRnFnCBVQkBkQAbIWZEY
         H3iq0gGV1KILTxJ3jAT//fpq21TqtmRWRCsB9g9XuMsk9tNLYC6t4Tnb1IhLFu0A4FLF
         vf+3REQp+I//i3SIijRgVQmqw/Vz6mvczGTIlWrhd/9JrlAmGh5QXquI1Y6f15xow0dk
         ji3Q==
X-Gm-Message-State: AAQBX9eqOeshoXPQ1ECPAU0u26cnLOBL9wISlwJKEtR7ZSYHnVlqMo/E
        v6pXVfM9JVAbXuCGA7J2jVCr3Fnc5/a6VGD8Sm0qgA==
X-Google-Smtp-Source: AKy350YbzQhpJUj5JHsGh+IkYTKPHXH2Ui85xNApYzKbYV3ySJVH07qjdL4Li6WtYXJEw/kkg3LRjA==
X-Received: by 2002:a05:6402:34c7:b0:500:2a9d:1870 with SMTP id w7-20020a05640234c700b005002a9d1870mr3235403edc.13.1680108658185;
        Wed, 29 Mar 2023 09:50:58 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id m1-20020a50c181000000b005024faae65esm2287023edf.10.2023.03.29.09.50.56
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 09:50:56 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id t10so65790896edd.12
        for <linux-modules@vger.kernel.org>; Wed, 29 Mar 2023 09:50:56 -0700 (PDT)
X-Received: by 2002:a17:906:eec7:b0:93e:186f:ea0d with SMTP id
 wu7-20020a170906eec700b0093e186fea0dmr9808123ejb.15.1680108655974; Wed, 29
 Mar 2023 09:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230329053149.3976378-1-mcgrof@kernel.org> <20230329053149.3976378-5-mcgrof@kernel.org>
 <20230329072112.GG4253@hirez.programming.kicks-ass.net> <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
 <20230329091935.GP4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230329091935.GP4253@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Mar 2023 09:50:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
Message-ID: <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] sempahore: add a helper for a concurrency limiter
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        song@kernel.org, rppt@kernel.org, willy@infradead.org,
        vbabka@suse.cz, mhocko@suse.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 29, 2023 at 2:19=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Arguably DEFINE_SEMAPHORE() should have the argument, as binary
> semaphores are a special case, but then we gotta go and fix up all
> users.

Using semaphores for just pure mutual exclusion used to be *the* most
common use of it, which is why we didn't have an argument.

Then we got the mutexes, and now semaphores are almost entirely a legacy th=
ing.

I think we should just make DEFINE_SEMAPHORE() take the number, and
people who want a mutex should either put in the "1", or they should
just use a mutex.

> /me git-greps a little.. Hmm, not too bad.
>
> How's this?

I'd actually prefer to not have that DEFINE_BINARY_SEMAPHORE() at all.
It really shouldn't exist in this day and age.

It's not even less typing, ie

    static DEFINE_SEMAPHORE(efivars_lock, 1);

is actually shorter than

    static DEFINE_BINARY_SEMAPHORE(efivars_lock);

And what you actually *want* is

    static DEFINE_MUTEX(efivars_lock);

and converting the up/down to mutex_unlock/mutex_lock.

So let's just make it clear that the only reason to use semaphores
these days is for counting semaphores, and just make
DEFINE_SEMAPHORE() take the number.

Strangely, sema_init() already does that, but I guess that's because
some people really *do* use semaphores for concurrency control (ie I
see things like

        sema_init(&dc->in_flight, 64);

which is clearly using a semaphore in that very traditional way).

So ack on your patch, but don't bother with DEFINE_BINARY_SEMAPHORE().

               Linus
