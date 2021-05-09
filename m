Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C06CC433B4
	for <linux-modules@archiver.kernel.org>; Sun,  9 May 2021 05:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEAF6100C
	for <linux-modules@archiver.kernel.org>; Sun,  9 May 2021 05:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhEIF4l (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 9 May 2021 01:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhEIF4k (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 9 May 2021 01:56:40 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0E4C061573
        for <linux-modules@vger.kernel.org>; Sat,  8 May 2021 22:55:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c15so2242588ljr.7
        for <linux-modules@vger.kernel.org>; Sat, 08 May 2021 22:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pZzQLXw2iPm2Lwj/83NF/G1QQb/8U6cHLq1nGEOQE8=;
        b=jdY/WZZrx8mSOAwGUKRMUR3IdE24B+wrTbu9UOWKjEO0bHE4FDFblZkugIXUXCXBQY
         dKY9D6i+U9wydpAqVwUpPUZIeTcDTyDRank0u35Tsz4pxxq9+Qe9OibGHBX+rnYlK6wR
         aXwkd/j6/CIPkbeL99q6zqlFaSv5TGW4Q6D45h/vw2382hTbxQjPFdNl9z5Co9PtoK0X
         ooIPMHefBRcT1clz7HkVAUNSTCFGevXZk01MM2GGXxqI2U9wYFg3JYpzdPlxWpUWAvZP
         2OKJ/3mLK7sAikXXVXMiHU9Q1KhWGIqGkeJW28rcL9wn/elwt8F5Vl9pVpeNZ2mfqJ6D
         2Kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pZzQLXw2iPm2Lwj/83NF/G1QQb/8U6cHLq1nGEOQE8=;
        b=DURdipd1UANXuStq1ALEhjsZFJ+ggLQaVSW9TlibcMaFhm3Gr4zeXRDuG+0YnUoKR6
         yEP5HECi0VmD7YhaPjVMEhiP4da3Ke++wwClIwUW8KFBOZbM8TR0rA/DIkCdlW6cC5dR
         w5mrNCs0wdxH90Yw83J33EnWRIaAh/X0jxhTupoNDAyepwn/K7oCHQawFhgEIpWbf/Ap
         HilcLLI0dJ9h80IeGPdgFh44SVg+MS+AYGOATbIeVev7mOsYOwm3T7bXrC5TZSpuV/YS
         l4yGi6nql5IDeS1Lwris8+XnaV2dLbIBdwTKSqk1ebTkSrayqNP9FMHXnot/sZQHkrwQ
         S+GA==
X-Gm-Message-State: AOAM530+tN20l2dLw9FCiuOU2SDD04KusYC9JVUzJnGQHTFKduz9iL8O
        U7QXR9YtTsnzlxlEZi2q+Z6IP0UJnvKuKAbNk9IUK0IjSVI=
X-Google-Smtp-Source: ABdhPJyQRp1DYN8QHU7ELtBMfi0lEI7IIodKjcB/P64U7Js01zvM03ordhRDVRWNLEJcCG1i5N8Jto/ykmnbeD1xzRE=
X-Received: by 2002:a2e:a401:: with SMTP id p1mr15146625ljn.142.1620539734938;
 Sat, 08 May 2021 22:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210504235836.24246-1-pkj@axis.com>
In-Reply-To: <20210504235836.24246-1-pkj@axis.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Sat, 8 May 2021 22:55:23 -0700
Message-ID: <CAKi4VAJLS7_9T3kUcxqphASF+3FegXeDmaDebsEFEaejU0BS0w@mail.gmail.com>
Subject: Re: [PATCH] libkmod: Always search modules.builtin if no alias has
 been found
To:     Peter Kjellerstedt <pkj@axis.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, May 4, 2021 at 5:17 PM Peter Kjellerstedt <pkj@axis.com> wrote:
>
> Commit 89443220e broke the lookup for builtin modules. modules.builtin
> was no longer searched if kmod_lookup_alias_from_kernel_builtin_file()
> returned 0.
>
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>
> I do not know if this is the correct thing to do, or if the commit
> message makes any sense. However, it solves the problem we were seeing.
> We use fuse, which installs /etc/modules-load.d/fuse.conf to load the
> fuse kernel module. However, we have fuse built-in. Normally, the
> following can be seen in the log:
>
>   systemd-modules-load[192]: Module 'fuse' is built in
>
> but after commit 89443220e, we instead got:
>
>   systemd-modules-load[193]: Failed to find module 'fuse'
>
> //Peter
>
>  libkmod/libkmod-module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 76a6dc3..6720930 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -577,7 +577,7 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
>
>         DBG(ctx, "lookup modules.builtin.modinfo %s\n", alias);
>         err = kmod_lookup_alias_from_kernel_builtin_file(ctx, alias, list);
> -       if (err == -ENOSYS) {
> +       if (err == 0 || err == -ENOSYS) {

So in your case you do have modules.builtin.modinfo, but fuse doesn't
show up there. On the other hand it is listed in modules.builtin.
Does modules.builtin.info contain anything or is it an empty file?

It seems to me something else is broken:  all modules in
modules.builtin should be in modules.builtin.modinfo as well. What is
the result of the following commands?

grep fuse /lib/modules/$(uname -r)/modules.builtin
grep fuse /lib/modules/$(uname -r)/modules.builtin.modinfo

thanks
Lucas De Marchi

>                 /* Optional index missing, try the old one */
>                 DBG(ctx, "lookup modules.builtin %s\n", alias);
>                 err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
