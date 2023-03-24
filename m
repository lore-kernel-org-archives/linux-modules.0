Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395D2C6FD20
	for <linux-modules@archiver.kernel.org>; Fri, 24 Mar 2023 20:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjCXU3O (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCXU3N (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 24 Mar 2023 16:29:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D310E2
        for <linux-modules@vger.kernel.org>; Fri, 24 Mar 2023 13:29:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cn12so12504183edb.4
        for <linux-modules@vger.kernel.org>; Fri, 24 Mar 2023 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679689750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szzCt9QgYlmv+MdPEpdeehiy7Y3yIBOornBldbmElZU=;
        b=HEUkzzFfbkd2t4QLVjmsN13rGr1E08bjBTMtmniTEh0Fy0XI5uOWH1TtTY9aNvmD22
         q9H9RNHRg2DeFl/u4HCp8SgTThcUmm8MfCtuz+JLq8p6lXyBG44RR5UEOJpH+7SNcocW
         xStZYNej2tf1wJTuyM94i+dhQCVtOQb+3L4LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679689750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szzCt9QgYlmv+MdPEpdeehiy7Y3yIBOornBldbmElZU=;
        b=m8qsRfHm7bYKApzURdrFEcVxOx5CfCOnxEVKi2NedrdxqeIW5Vt+NerzG5Pg9rKEbe
         3nqYK41e1/glvhmKG4ZUR1RomGLAfg8T/jmLLMVl8CxkYcrUpk2++9GZVQJ+i8piN80r
         tITSLWzxKfhXuFUzGtFKkR6fsGEyKK7X7sjPqZYldQLwCJeMF8pEeOx23lC2N3eji2Q2
         dmXJiV9HRcGUKxbS1wKiYPbFF+TL9pBxAfc7LQQQobQVE4cCCF/qS9AiNjgy6d4oz+rT
         aPACdj8udc1MDDINi/5GEWf5qTcOS2NyYxR41lkTrsHpc7iTRMUG4RR1fmCpHjnU/t0w
         PS3g==
X-Gm-Message-State: AAQBX9cNdz3vaniitpdmryU0vizatqXjExctqFD6S8YRtj1ZSYCidwIt
        iB2SxkWEP5zUWH26wjulJIyEgEN0UFhKbKHDy6276J5U
X-Google-Smtp-Source: AKy350ZS4TaE8CtHbyVmnRV32Au1whmw9vToABj23iAhoate6xQPR2dn8XUzyqj06EU0HnS8GyN/tQ==
X-Received: by 2002:a17:906:3a45:b0:88a:cbd1:e663 with SMTP id a5-20020a1709063a4500b0088acbd1e663mr4318875ejf.6.1679689750213;
        Fri, 24 Mar 2023 13:29:10 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id kn6-20020a1709079b0600b0093f2e69c715sm52931ejc.110.2023.03.24.13.29.09
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 13:29:09 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id eh3so12372764edb.11
        for <linux-modules@vger.kernel.org>; Fri, 24 Mar 2023 13:29:09 -0700 (PDT)
X-Received: by 2002:a17:906:d54d:b0:932:da0d:9375 with SMTP id
 cr13-20020a170906d54d00b00932da0d9375mr2532911ejc.4.1679689748729; Fri, 24
 Mar 2023 13:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com> <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com> <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org> <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
 <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com> <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
 <CAHk-=wij=z-C6puGv+E5gGKgFMam-ucCjyji0-vP1wd=aUpFvQ@mail.gmail.com> <ZB4BP0ZgxNirBNOJ@bombadil.infradead.org>
In-Reply-To: <ZB4BP0ZgxNirBNOJ@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Mar 2023 13:28:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkj6=wyi201JXkw9iT_eTUTsSx+Yb9d4OgmZFjDJA18g@mail.gmail.com>
Message-ID: <CAHk-=whkj6=wyi201JXkw9iT_eTUTsSx+Yb9d4OgmZFjDJA18g@mail.gmail.com>
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted allocations
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Mar 24, 2023 at 1:00=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On the modules side of things we can be super defensive on the second
> vmalloc allocation defensive [0] but other than this the initial kread
> also needs care too.

Please don't re-implement semaphores. They are a *classic* concurrency limi=
ter.

In fact, probably *THE* classic one.

So just do something like this instead:

   --- a/kernel/module/main.c
   +++ b/kernel/module/main.c
   @@ -2937,6 +2937,11 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
        return load_module(&info, uargs, 0);
    }

   +#define CONCURRENCY_LIMITER(name, n) \
   +    struct semaphore name =3D __SEMAPHORE_INITIALIZER(name, n)
   +
   +static CONCURRENCY_LIMITER(module_loading_concurrency, 50);
   +
    SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs,
int, flags)
    {
        struct load_info info =3D { };
   @@ -2955,8 +2960,12 @@ SYSCALL_DEFINE3(finit_module, int, fd, const
char __user *, uargs, int, flags)
                      |MODULE_INIT_COMPRESSED_FILE))
                return -EINVAL;

   +    err =3D down_killable(&module_loading_concurrency);
   +    if (err)
   +            return err;
        len =3D kernel_read_file_from_fd(fd, 0, &buf, INT_MAX, NULL,
                                       READING_MODULE);
   +    up(&module_loading_concurrency);
        if (len < 0)
                return len;

NOTE! Entirely untested. Surprise surprise.

I'm a tiny bit worried about deadlocks here, so somebody needs to make
sure that the kernel_read_file_from_fd() case cannot possibly in turn
cause a "request_module()" recursion.

We most definitely have had module recursion before, but I *think*
it's always just in the module init function (ie one module requests
another when ithe mod->init() function is called).

I think by the time we have opened the module file descriptors and are
just reading the data, we should be ok and the above would never
deadlock, but I want people to at least think about it.

Of course, with that "max 50 concurrent loaders" limit, maybe it's
never an issue anyway. Even if you get a recursion a few deep, at most
you just wait for somebody else to get out of their loaders. Unless
*everybody* ends up waiting on some progress.

              Linus
