Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6E1C6FD1D
	for <linux-modules@archiver.kernel.org>; Thu, 30 Mar 2023 16:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjC3QYQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 30 Mar 2023 12:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjC3QYP (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 30 Mar 2023 12:24:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FE9BBBA
        for <linux-modules@vger.kernel.org>; Thu, 30 Mar 2023 09:24:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so78763258edo.2
        for <linux-modules@vger.kernel.org>; Thu, 30 Mar 2023 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680193453; x=1682785453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGpUIuNkSWwlblo4NAnZsLgXHjXX1OX/SqTfrwIswRg=;
        b=AFYT3SGXEtyYn4OT3ks6sc4GPeEzfx8R1Ny++loIyq8dLRZtxKJlH/lzZ3iMCW8//b
         vbs0x9sQD2Medk4I+5U+5ewpG0fPgB0am/EK7gNkZG6hcHxg4211BAjG9mJ2V3FntKwx
         HNWxTj9LhHbpZ6rRIoQYE4MhOoeDV/y1rj198=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680193453; x=1682785453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGpUIuNkSWwlblo4NAnZsLgXHjXX1OX/SqTfrwIswRg=;
        b=4Lekate6uioXkmbQrBjL1FgADLJevyndeD3tSALhW4M4c9YaL+w7Pn/q5V0NJ1iHsy
         zRgaRk3NKMrx4x8ta7ZStkPxR+caO4/JYb8BmXtbgxShRXYcSnd/xiKPRbOeAG26BDX3
         mRdWsWxKkMOQ1S7flENG+xazmQTS5Iu8SGZzX8x42nfqEBXeNJbfiniK55C6MbVcXgU0
         lxi+qIN7NpmzbHjtu7FYlEDtLjpPg2kjFm0kKF8B9ZVswLf6PuOZOSstgfYhOeHJxCxJ
         BsjAX0ZOefQCNWNQZ0NwAkbJjE3Jng8mAznjqHOfh7w/ZDYD7siQu99g2Ets8XQfbL2g
         /jOQ==
X-Gm-Message-State: AAQBX9d7fooZGCG71xXsJI70SEF0Mczn9/XdJJavgexMRWWpsLddlM8c
        7TL7dwKPBdXFGSwv8DzxqbXR7r/Fn53KpGJFNtrcpIn8
X-Google-Smtp-Source: AKy350bxaz7TRDSkV2l821vOhO/CzpKVZkmCu86XBQm4+ybjPzJxrmM/QFHlLUWwl8d/B1SP4PWPtA==
X-Received: by 2002:a17:906:9618:b0:884:3174:119d with SMTP id s24-20020a170906961800b008843174119dmr26012190ejx.14.1680193452860;
        Thu, 30 Mar 2023 09:24:12 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id w10-20020a1709060a0a00b00933c4a25735sm7877ejf.100.2023.03.30.09.24.11
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:24:11 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id ek18so78728259edb.6
        for <linux-modules@vger.kernel.org>; Thu, 30 Mar 2023 09:24:11 -0700 (PDT)
X-Received: by 2002:a05:6402:4306:b0:4af:6e95:85e9 with SMTP id
 m6-20020a056402430600b004af6e9585e9mr4039473edc.4.1680193450898; Thu, 30 Mar
 2023 09:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230329053149.3976378-1-mcgrof@kernel.org> <20230329053149.3976378-5-mcgrof@kernel.org>
 <20230329072112.GG4253@hirez.programming.kicks-ass.net> <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
 <20230329091935.GP4253@hirez.programming.kicks-ass.net> <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
 <20230330115626.GA124812@hirez.programming.kicks-ass.net>
In-Reply-To: <20230330115626.GA124812@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Mar 2023 09:23:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgF34MkhZnM_Kc1zggTWCAQ=BzEgAaAbE5wDM07bWiYeg@mail.gmail.com>
Message-ID: <CAHk-=wgF34MkhZnM_Kc1zggTWCAQ=BzEgAaAbE5wDM07bWiYeg@mail.gmail.com>
Subject: Re: [PATCH 4/7] sempahore: add a helper for a concurrency limiter
To:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        petr.pavlu@suse.com, prarit@redhat.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        song@kernel.org, rppt@kernel.org, willy@infradead.org,
        vbabka@suse.cz, mhocko@suse.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 30, 2023 at 4:56=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Sure thing; still completely untested...

Seems obvious enough.

Looking at the people who use a semaphore as a mutex, one core user stands =
out:

>  kernel/printk/printk.c                                        |    2 +-

.. and I'm not entirely sure why that uses a semaphore. It may be
*entirely* legacy, and should just be changed to be a mutex.

But it may also be that the 'console_sem' has some subtle reason why
it wants to be a semaphore, and why it then plays games with lockdep
(which doesn't support counting semaphores) and does things like

  #define down_console_sem() do { \
        down(&console_sem);\
        mutex_acquire(&console_lock_dep_map, 0, 0, _RET_IP_);\
  } while (0)

Anyway, I think your patch is obviously safe as-is, and I think it's
long overdue to make it clear that the only real reason to use
semaphores rather than mutexes is if you do need the counting thing.

Of course, there is the thing about lockdep, and also about how
semaphores these days have no architecture-specific parts, so if
anybody wants to play deep games with their locking, that may be a
reason for using them.

Although we also do have some other issues - I think down_trylock() is
ok in irq contexts, but mutex_trylock() is not. Maybe that's why
printk uses semaphores? I forget.

                Linus
