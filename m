Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFC5C433DB
	for <linux-modules@archiver.kernel.org>; Sat, 23 Jan 2021 19:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795BC22B4E
	for <linux-modules@archiver.kernel.org>; Sat, 23 Jan 2021 19:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbhAWTFB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 23 Jan 2021 14:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAWTFA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 23 Jan 2021 14:05:00 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEDEC06174A
        for <linux-modules@vger.kernel.org>; Sat, 23 Jan 2021 11:04:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o10so12163070lfl.13
        for <linux-modules@vger.kernel.org>; Sat, 23 Jan 2021 11:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ar5MQLzQOmmCXVei8K8Zkn9gdITDm7Sk600uo7mbIqk=;
        b=nZ3Cfzi627m44zi1qpGC1+IJnZ3S5tx2PSQTM53jhCDnd+5VAQqVrcLy5O8Pf3Ya1G
         Lm7coxGFPZKjx5I1FbsRG+1OOTK4dlYCcLJLzWoFVbEAxIcU7ZM/Fs1iRiHKKCzRzWCg
         Y210S2cY1y7cBR7BZOEbMcDrqf2Ojg/91uo1Ckeh4gagCV1XIxXotHj1BKEuFtHbrDJO
         t/5MFWfDi7ufs5/vyUkS2tG35GvqevpHOrihXC2FMb4PNfemJY4xG6QgOfIXE19QP9D5
         QTAXfs7BM/oqtt1GdCZIkZt6rIX/RoWRl4lnh/AkQGxff0sBS3bDM1fsxQnvUJK47xUh
         +BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ar5MQLzQOmmCXVei8K8Zkn9gdITDm7Sk600uo7mbIqk=;
        b=paoLRNEM220DAAqCF/L1K3/UVL+oUAjEv2Yu/LGBa8BiLUy+azQoRnzdUJFAViPQOU
         u4hOyuDOti9XQEp23bcCYZ5LtoLc0Ot29iYMuhbAL6mQfh158w9V6EWFIrTcqslOcAiN
         gNSs0P3i1nIsmhBwgvTrDJSJeErB3G4CXuqnAQUSsneNf5U+vHnPFzrseAN6CZKk6aVf
         QFuVKkohxQWaP/IgfflXuHSfbH+teyEClJGPAwCF0Mj5cY9vycj/2D/a1dnEp4pjJEnJ
         nC3pQ2Am74VAvQ0Xn337Yz/IdsMepNd7cNMhpsLRSnHvCciBTQ5CTJ6ps5Ar42YDNefv
         28Lg==
X-Gm-Message-State: AOAM532JoKw6D/W45uL9GWymw4IQXOZUNErsnkYWWT58fcxrx4JJR3ou
        X3pDe1Ac8RBYj2si7baoiSrG9cjAd4TBqpOjA7g=
X-Google-Smtp-Source: ABdhPJzgg0WwKwP0t+5FY1TmqMCzVQ4mRcyD2yoKdjKLrUXrUBb5fUlGwyc2p6zipoRuRQDIjekTtazkSKGHfCw6Cj0=
X-Received: by 2002:a05:6512:49b:: with SMTP id v27mr15226lfq.220.1611428658603;
 Sat, 23 Jan 2021 11:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20210121070627.17072-1-wangshuo47@huawei.com>
In-Reply-To: <20210121070627.17072-1-wangshuo47@huawei.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Sat, 23 Jan 2021 11:04:06 -0800
Message-ID: <CAKi4VALZ9ymom6-7ry++0cVPQTC2UhUqv8QU30kXpuR3dUG=Lg@mail.gmail.com>
Subject: Re: [PATCH] libkmod: assign values to variables to fix warnings
To:     Shuo Wang <wangshuo47@huawei.com>
Cc:     patchwork-bot@kernel.org,
        linux-modules <linux-modules@vger.kernel.org>,
        hushiyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jan 20, 2021 at 11:06 PM Shuo Wang <wangshuo47@huawei.com> wrote:
>
>
>         Dear Lucas,
>
> Thanks for your reply. I was wondering if these changes will
>  be merged in the future?

It seems those errors are actually compiler mistakes. Aren't there
updates to the compiler?  What distro is shipping gcc 7.3.0??
See below.

>
> Best regards,
> Shuo
>
> >gcc version 7.3.0 (GCC)
> >
> >>what compiler?
> >>>libkmod/libkmod.c: In function 'kmod_lookup_alias_is_builtin':
> >>>./shared/util.h:73:9: warning: 'line' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >>>         free(*(void**) p);
> >>>         ^~~~~~~~~~~~~~~~~
> >>>libkmod/libkmod.c:581:23: note: 'line' was declared here
> >>>  _cleanup_free_ char *line;
> >>>                       ^~~~
> >>>In file included from libkmod/libkmod-module.c:42:0:
> >>>libkmod/libkmod-module.c: In function 'kmod_module_probe_insert_module':
> >>>./shared/util.h:73:9: warning: 'cmd' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >>>         free(*(void**) p);
> >>>         ^~~~~~~~~~~~~~~~~
> >>>libkmod/libkmod-module.c:1009:23: note: 'cmd' was declared here
> >>>  _cleanup_free_ char *cmd;
> >>>
> >>>---
> >>> libkmod/libkmod-module.c | 2 +-
> >>> libkmod/libkmod.c        | 2 +-
> >>> 2 files changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>>diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> >>>index 76a6dc3..2e973b5 100644
> >>>--- a/libkmod/libkmod-module.c
> >>>+++ b/libkmod/libkmod-module.c
> >>>@@ -1006,7 +1006,7 @@ static int module_do_install_commands(struct kmod_module *mod,
> >>> {
> >>>     const char *command = kmod_module_get_install_commands(mod);
> >>>     char *p;
> >>>-    _cleanup_free_ char *cmd;
> >>>+    _cleanup_free_ char *cmd = NULL;
> >>>     int err;
> >>>     size_t cmdlen, options_len, varlen;
> >>>
> >>>diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
> >>>index 43423d6..66e658c 100644
> >>>--- a/libkmod/libkmod.c
> >>>+++ b/libkmod/libkmod.c
> >>>@@ -578,7 +578,7 @@ finish:
> >>>
> >>> bool kmod_lookup_alias_is_builtin(struct kmod_ctx *ctx, const char *name)
> >>> {
> >>>-    _cleanup_free_ char *line;
> >>>+    _cleanup_free_ char *line = NULL;
> >>>
> >>>     line = lookup_builtin_file(ctx, name);

line is declared above and just assigned here, the initial NULL makes
no difference.

Lucas De Marchi

> >>>
> >>>--
> >>>2.23.0
