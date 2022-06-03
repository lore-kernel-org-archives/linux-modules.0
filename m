Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BC6C433EF
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 03:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiFCDtX (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 2 Jun 2022 23:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiFCDtW (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 2 Jun 2022 23:49:22 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF361387B7
        for <linux-modules@vger.kernel.org>; Thu,  2 Jun 2022 20:49:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e184so11693983ybf.8
        for <linux-modules@vger.kernel.org>; Thu, 02 Jun 2022 20:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0G3hNmJ1Q+LBbZjXTfnwdweJz3xAS+mZEvr88JcCvQ=;
        b=bRjPq4lmj8WInhJ15PMPfSVXJoO/swvg7UhxweuNU0nJFWf1+0DZsecCmWyBKA+Fd6
         ozmumW+Z+ppnPyMdPU7aLevHVjkvv8ALEiv8NkG95KlYLyKAPraw+XFpqNNmu28zMObm
         ehN8mB3sILfbEvA3c0IT82AwJu+rQintkx7yignuffVh4w/Gnrb22Kb3vOqfXB9KQDNp
         4ZJBtVM3l+AAsJ3hewtsX4mIyDIv3ji86LGvopKxM+qOoXZ5fJ2aLe5NVpiFm4VEnosT
         7Dpw0B1WofbWFNNJiREeD/iOxzPrlq2zYjDd+Q9lRKlrfaljO14ESGh817+NWPH7zI2H
         Y6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0G3hNmJ1Q+LBbZjXTfnwdweJz3xAS+mZEvr88JcCvQ=;
        b=vMNsdxw4TdDaxLiKUZvAekVCT2bHVTTLjAlVLwgo+Gqfr5PAZT7UrxArIWxbA1Hh5e
         oWX/AjiwHDh8tb1gToy8dG0hoPMb2hJfDKyVjmigSlCDA0oPV5Ax9J2lFSxKJcD31KIF
         oAUHHeBCbW+4/LcgRAA/E1kYbff76EuUdBWwLPvk6A8jBf4jAC+YQ2K7p+fjYtGhnw6m
         pS4Xazyr+Rl2zjPt860EOYWyZNJGuWtOK6CubXliBloFgz7e6hC8ToZXP2EFjvvNJ5OD
         jj1xdQieDNw1rfPF+BrgHn3SwWU+hd8xVLCvcLcU070QR5KKUFEC28iNOnxEAx69IWke
         vfKw==
X-Gm-Message-State: AOAM531VXU6MDixkz+Yi+0zwQIfPELQBV6T65UDIPdIIvV6+4b4gcbhv
        DkvUbJOmAZf+/Ya1sXKGP4wkp2qZ9+pwP/+PbIIITg==
X-Google-Smtp-Source: ABdhPJymXKG/UH/tPPgw+S0UAR6BL4WzGB0zzD11iV96sfqYdX3qJdDD6dUtTkaBrOcf6+GJ9ODmhJZEitddQrOJ96Y=
X-Received: by 2002:a25:1cc3:0:b0:660:1c62:1f3b with SMTP id
 c186-20020a251cc3000000b006601c621f3bmr8776990ybc.115.1654228157825; Thu, 02
 Jun 2022 20:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220322140344.556474-2-atomlin@redhat.com> <20220602035653.4167316-1-saravanak@google.com>
 <YpkMelZC+E5hKTw6@bombadil.infradead.org> <CAHk-=wit6ttmzdFsbH+YLkMeLucTspYADHnENn4fBXNrit0BUQ@mail.gmail.com>
 <CAGETcx9f5BiojqU6wr29eUrYr9s8k+CGj_t-7RvrTSmDm6WwJw@mail.gmail.com> <YplAxCvRiNnthK6d@bombadil.infradead.org>
In-Reply-To: <YplAxCvRiNnthK6d@bombadil.infradead.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 2 Jun 2022 20:48:41 -0700
Message-ID: <CAGETcx-gEbH2ymx7FXCXZNt3p=r=5FXuhLUiMuNvofcb1HXysA@mail.gmail.com>
Subject: Re: [PATCH v1] module: Fix prefix for module.sig_enforce module param
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, Allen Pais <allen.lkml@gmail.com>,
        Joe Perches <joe@perches.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 2, 2022 at 3:59 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Jun 02, 2022 at 02:47:04PM -0700, Saravana Kannan wrote:
> > On Thu, Jun 2, 2022 at 12:41 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Thu, Jun 2, 2022 at 12:16 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > >
> > > > Linus want to take this in or should I just queue these up?
> > >
> > > I'll take it, and remove the unnecessary #ifdef/#endif. The #undef
> > > might as well be unconditional - simpler and doesn't hurt.
> >
> > Sounds good. I just copy-pasted how it was done elsewhere. Luis was
> > mentioning adding a wrapper to go this cleanly and I needed it in
> > another instance too. So I'll look into doing that in a future patch.
>
> Virtual hug, or something hippie like that.

Thanks :)

I gave this a shot.

+ #define set_module_param_prefix(prefix) \
+ #undef MODULE_PARAM_PREFIX              \
+ #define MODULE_PARAM_PREFIX prefix

I even wrote up a nice chunk of "function doc" before I tried
compiling it. And once I compiled it, I was smacked in the head by the
compiler for trying to put a #define inside a #define (Duh, the
preprocessing in a single pass).

Before I tried this, I looked up the current uses of the "hacky" snippet:

$ git grep -l "define.*MODULE_PARAM_PREFIX" -- :^include/
block/disk-events.c
drivers/misc/cxl/fault.c
drivers/mmc/core/block.c
drivers/pci/pcie/aspm.c
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
drivers/tty/serial/8250/8250_core.c
drivers/xen/balloon.c
drivers/xen/events/events_base.c
kernel/debug/kdb/kdb_main.c
kernel/kcsan/core.c
kernel/rcu/tree.c
kernel/rcu/update.c
mm/damon/reclaim.c
mm/kfence/core.c


In a lot of those files, there are a lot of module params that follow
this snippet. Going on a tangent, some of the uses of #define
MODULE_PARAM_PREFIX don't seem to have any obvious use or param
macros.

So adding a module_param_prefixed() doesn't make sense to me either,
because I'll have to repeat the same prefix in every usage of
module_param_prefixed() AND I'll have to create a _prefixed() variant
for other param macros too.

So, something like:
module_param_prefixed("module.", sig_enforce, bool, 644);
module_param_prefixed("module.", another_param1, bool, 644);
module_param_prefixed("module.", another_param2, bool, 644);

Or replace "module." with a MY_PREFIX so that it's easy to ensure the
string is the same across each use:
#define MY_PREFIX "module."
module_param_prefixed(MY_PREFIX, sig_enforce, bool, 644);
module_param_prefixed(MY_PREFIX, another_param1, bool, 644);
module_param_prefixed(MY_PREFIX, another_param2, bool, 644);

But at that point, all I'm avoiding is one #undef MODULE_PARAM_PREFIX
and a whole lot of code churn.

One other option is to do something like:
#ifndef MOD_PREFIX
#define MODULE_PARAM_PREFIX KBUILD_MODNAME "."
#else
#define MODULE_PARAM_PREFIX MOD_PREFIX "."
#endif

But that will have the limitation that MOD_PREFIX has to be defined
before any #includes is in a file (similar to pr_fmt())  and doesn't
allow you to redefine the prefix half way through a file -- which is
also a thing that happens in drivers/tty/serial/8250/8250_core.c.

So, long story short, none of these options sound especially appealing
that it's worth all the code churn across multiple maintainer trees.
Let me know if you have other ideas that might work or you think one
of the options I dismissed is actually worth doing.

Thanks,
Saravana
