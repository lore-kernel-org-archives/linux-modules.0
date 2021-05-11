Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981E8C433B4
	for <linux-modules@archiver.kernel.org>; Tue, 11 May 2021 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67ACC61260
	for <linux-modules@archiver.kernel.org>; Tue, 11 May 2021 18:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhEKSDU (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 11 May 2021 14:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhEKSDT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 11 May 2021 14:03:19 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD25C061574
        for <linux-modules@vger.kernel.org>; Tue, 11 May 2021 11:02:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m11so13483596lfg.3
        for <linux-modules@vger.kernel.org>; Tue, 11 May 2021 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZsEiA1uVmbce/vLH/LzN7FZu8RTqXOS56ZBrmyoKFY=;
        b=XDQPlaWq6UlC9WhJBgYmBJqKT08IYsDMAGBzR1slcEoFdSW4L7xm/5D5kKmJm2pm0W
         MLmvsCPCYlWizTR/0/VxBHBkYw9j+jgqAuSUGJDqwe4OMOvTiTm/cTlb8iRuNJ6voiPS
         NCqCQYfPdK9iKeAy+YnWW3TmsZOJ7RhJ8UTxjZgxu4A9AlGn05dNvxK1+2hlXIMoOCFr
         xbD33ZLfPCXzJhlP6V/yzWWq8mhHh5t4ve87/ueSBUt3x1R86cadqH0q5BldMlL/DhaX
         BOURPeTtIK29DV38J4WGPCASsOal6+sL7GnLofM4n63oUqXWT6djwwp3gX6g7+4X0DBz
         ivjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZsEiA1uVmbce/vLH/LzN7FZu8RTqXOS56ZBrmyoKFY=;
        b=iybj6lX/A78TBi6ZIk/GTJxsa2BjUjNQnc9dEawf1sJd/ELcDTRrDp//L8syaQihQc
         0M4vWBun51qsGMslcqlvDuUpc5/dXfMx3NDCMhrD4ewaLrCMoyRdVJCn16yejHMeD+FI
         ttiT9BDBWTK5UxON7sLP0DljnQtGioUagzUBN2c59mVVoB0/l1oxCfVHDYeaFeTu+jRL
         9XBcQ499NH9xFNcdDeJAoaBh2nqUaK5S+DRtNVM8VYMwbIPwc/4EAvoCAN1QoF/9u9Ns
         DFlJmIlo8ntfKcHsGVsrCbmYtEAakk+1Sl0IRSg2Mm69/uw6uz7fzvRa4jF9bWq4kPw9
         QmDg==
X-Gm-Message-State: AOAM5317ZkKPTq/rO74sq+WZb0X9Z/GOhPAXXfBYtYe3zWtt2cxr2LFj
        sag2VLzo9AW55zvrmMkEV/ByNGqXJFnjGNC64ms7Pop9jcY=
X-Google-Smtp-Source: ABdhPJx50ORkfx9bqdULC4QlyG7XwCMW0lSHBPRYcVIIwF9b4Edn44KRALGWLozRS5dQRRlzd4wJ4efuUAE2e3r70w8=
X-Received: by 2002:a05:6512:3f02:: with SMTP id y2mr22032673lfa.355.1620756131086;
 Tue, 11 May 2021 11:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210504235836.24246-1-pkj@axis.com> <CAKi4VAJLS7_9T3kUcxqphASF+3FegXeDmaDebsEFEaejU0BS0w@mail.gmail.com>
 <91eb2b9fbd854cb0a3436fb4fcb7ceb1@XBOX03.axis.com> <CAKi4VAJxZM2RGdQcqun_=oSJ5v1pqXkgV7tW+BbOshYMBSsMyw@mail.gmail.com>
In-Reply-To: <CAKi4VAJxZM2RGdQcqun_=oSJ5v1pqXkgV7tW+BbOshYMBSsMyw@mail.gmail.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 11 May 2021 11:01:59 -0700
Message-ID: <CAKi4VA+O67X=Tex+_-kitMMGPL33FEEWBoOy5muBfvPq8Ao=6g@mail.gmail.com>
Subject: Re: [PATCH] libkmod: Always search modules.builtin if no alias has
 been found
To:     Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, May 11, 2021 at 9:58 AM Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
>
> On Mon, May 10, 2021 at 6:55 AM Peter Kjellerstedt
> <peter.kjellerstedt@axis.com> wrote:
> >
> > > -----Original Message-----
> > > From: Lucas De Marchi <lucas.de.marchi@gmail.com>
> > > Sent: den 9 maj 2021 07:55
> > > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > > Cc: linux-modules <linux-modules@vger.kernel.org>; Peter Kjellerstedt
> > > <peter.kjellerstedt@axis.com>
> > > Subject: Re: [PATCH] libkmod: Always search modules.builtin if no alias
> > > has been found
> > >
> > > On Tue, May 4, 2021 at 5:17 PM Peter Kjellerstedt <pkj@axis.com> wrote:
> > > >
> > > > Commit 89443220e broke the lookup for builtin modules. modules.builtin
> > > > was no longer searched if kmod_lookup_alias_from_kernel_builtin_file()
> > > > returned 0.
> > > >
> > > > Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > > > ---
> > > >
> > > > I do not know if this is the correct thing to do, or if the commit
> > > > message makes any sense. However, it solves the problem we were seeing.
> > > > We use fuse, which installs /etc/modules-load.d/fuse.conf to load the
> > > > fuse kernel module. However, we have fuse built-in. Normally, the
> > > > following can be seen in the log:
> > > >
> > > >   systemd-modules-load[192]: Module 'fuse' is built in
> > > >
> > > > but after commit 89443220e, we instead got:
> > > >
> > > >   systemd-modules-load[193]: Failed to find module 'fuse'
> > > >
> > > > //Peter
> > > >
> > > >  libkmod/libkmod-module.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> > > > index 76a6dc3..6720930 100644
> > > > --- a/libkmod/libkmod-module.c
> > > > +++ b/libkmod/libkmod-module.c
> > > > @@ -577,7 +577,7 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
> > > >
> > > >         DBG(ctx, "lookup modules.builtin.modinfo %s\n", alias);
> > > >         err = kmod_lookup_alias_from_kernel_builtin_file(ctx, alias, list);
> > > > -       if (err == -ENOSYS) {
> > > > +       if (err == 0 || err == -ENOSYS) {
> > >
> > > So in your case you do have modules.builtin.modinfo, but fuse doesn't
> > > show up there. On the other hand it is listed in modules.builtin.
> > > Does modules.builtin.info contain anything or is it an empty file?
> >
> > We have neither modules.builtin.modinfo nor modules.builtin.info.
> > A little googling turned out that modules.builtin.modinfo seems to have
> > been introduced in 5.2, but this product uses a 4.19 based kernel.
>
> ok, now I understood the entire context. So it seems the problem is
> not that we are
> missing the handling for return 0, but rather that
> kmod_lookup_alias_from_kernel_builtin_file()
> is not returning -ENOSYS when it should (index doesn't exist).  I
> thought this was covered, but
> obviously I was wrong. I will take a look what's going on.... we
> should not handle err == 0 the same
> way we handle err == -ENOSYS. If the index is missing we want to
> fallback to the old one, but if
> the index is there and we didn't find the module, we should just
> return an error.

Ok, I think I see what's happening. If you have a recent kmod with an
old kernel,
you have this scenario:

1) modules.builtin.modinfo doesn't exist since kernel didn't create it
2) depmod will write and empty index to modules.builtin.alias.bin when
modules.builtin.modinfo
is not present

I have a fix to depmod to stop writing an empty index. I will submit
that for review.

thanks
Lucas De Marchi


>
> Lucas De Marchi
>
> >
> > > It seems to me something else is broken:  all modules in
> > > modules.builtin should be in modules.builtin.modinfo as well. What is
> > > the result of the following commands?
> > >
> > > grep fuse /lib/modules/$(uname -r)/modules.builtin
> >
> > kernel/fs/fuse/fuse.ko
> >
> > > grep fuse /lib/modules/$(uname -r)/modules.builtin.modinfo
> >
> > grep: /lib/modules/4.19.110-axis8/modules.builtin.modinfo: No such file or directory
> >
> > This is an embedded product built with our own distribution based on
> > Poky Gatesgarth from the Yocto Project. The rootfs is read-only, including
> > /lib/modules, so any contest there is created when the firmware image is
> > built.
> >
> > > thanks
> > > Lucas De Marchi
> > >
> > > >                 /* Optional index missing, try the old one */
> > > >                 DBG(ctx, "lookup modules.builtin %s\n", alias);
> > > >                 err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
> >
> > //Peter
> >
