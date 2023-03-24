Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088FAC6FD1C
	for <linux-modules@archiver.kernel.org>; Fri, 24 Mar 2023 19:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCXTL3 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 24 Mar 2023 15:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCXTL2 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 24 Mar 2023 15:11:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A401B2D0
        for <linux-modules@vger.kernel.org>; Fri, 24 Mar 2023 12:11:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn12so11826103edb.4
        for <linux-modules@vger.kernel.org>; Fri, 24 Mar 2023 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679685085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qCK54soErGy7EGQQweZ79LKMpldqIoIIr3maQfIWTI=;
        b=hRn/Z0izsUiNdQXow5plGyOYBJetP8//fT0D0swRfMc/xTXgsiRPPSCsFSQ5EQHduX
         rQvuWGtz2Pwi+TbTLu+6cXbehDGmmmcNg/5AM0XIYF77yWFyh0G4goyYXaidajQmNt6F
         CbBiBwLIIK7vdsy7iRL46tjB4r9IvgYLulKtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679685085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qCK54soErGy7EGQQweZ79LKMpldqIoIIr3maQfIWTI=;
        b=r2NZnkBhqn3uCukxtZaNHz+ZEfEDYzjA8tLprOIeli+iSCwrA7ZGROzmBh540uklj+
         N8ojMJ3Q+Gh9ACDPIm6RYRM/85Ezr8O461/NbeyW0I8ycF0UHOkJZYoD+3o3pDnl2gpA
         0mwZ9uv74L5hIR7axHUQfUDO6ychP2TNhjnWjAaLwlhfolBzFl243/f1uMGkMRo0T5pG
         cHiG4iO/V8PXfo9jgbLB4tqL0SV73Yyj9awAUJRoCXR7bPyOa2Dfr0HqiAVHcfOsNU1+
         5sjdEv1b+3A1S1XBpa0oZLZ34Wljgmqm1RCojEdcqfwlNyxR8JI5QjTUemOfPUKQhgrO
         AlMA==
X-Gm-Message-State: AAQBX9cFiMYEoBwj/5F5xGM3SRI0fCpE+JIvSL37YwOvvlP/fUYegBGC
        XELGHCByQChJ3Or4Ijm/vfbhOZWJxuCZQlUIjfFdNg==
X-Google-Smtp-Source: AKy350YXTEgHx2vTt27tC2ptthbEAyv5J1vp7vHMGZPZ/TNkjzvorGQL7wJqMY0KImdHaN+nf35esw==
X-Received: by 2002:a17:906:bcd1:b0:921:5cce:6599 with SMTP id lw17-20020a170906bcd100b009215cce6599mr4215671ejb.41.1679685085760;
        Fri, 24 Mar 2023 12:11:25 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id c16-20020a170906925000b009327f9a397csm10086982ejx.145.2023.03.24.12.11.24
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 12:11:24 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id i5so12001059eda.0
        for <linux-modules@vger.kernel.org>; Fri, 24 Mar 2023 12:11:24 -0700 (PDT)
X-Received: by 2002:a17:906:eec7:b0:93e:186f:ea0d with SMTP id
 wu7-20020a170906eec700b0093e186fea0dmr1585791ejb.15.1679685084132; Fri, 24
 Mar 2023 12:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <ZBOsyBu68d4vh6yU@bombadil.infradead.org> <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com> <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org> <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org> <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com> <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
 <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
In-Reply-To: <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Mar 2023 12:11:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wij=z-C6puGv+E5gGKgFMam-ucCjyji0-vP1wd=aUpFvQ@mail.gmail.com>
Message-ID: <CAHk-=wij=z-C6puGv+E5gGKgFMam-ucCjyji0-vP1wd=aUpFvQ@mail.gmail.com>
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

On Fri, Mar 24, 2023 at 10:54=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> +/*
> + * This clutch ensures we only allow a certain number concurrent threads=
 at a

kludge, not clutch.

And it's much worse than a kludge. It's just wrong and disgusting.

> +               pr_warn_ratelimited("kread_concurrent_max (%u) close to 0=
 (max_loads: %u), throttling...",
> +                                   atomic_read(&kread_concurrent_max),
> +                                   MAX_KREAD_CONCURRENT);

This is also wrong, since it's not kernel_read_file() that is the
problem, but whatever broken caller.

Yeah, yeah, in practice it's presumably always just finit_module()
doing kernel_read_file_from_fd(), but it's still *completely* wrong to
just say "function X is throttling" when "X" isn't the problem, and
doesn't tell what the _real_ problem is.

I really think this all needs some core fixing at the module layer,
not these kinds of horrific hacks.

          Linus
