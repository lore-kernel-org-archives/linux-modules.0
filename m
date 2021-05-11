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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2E8C433B4
	for <linux-modules@archiver.kernel.org>; Tue, 11 May 2021 16:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380C3610C9
	for <linux-modules@archiver.kernel.org>; Tue, 11 May 2021 16:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhEKRAT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 11 May 2021 13:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKRAT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 11 May 2021 13:00:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD000C061574
        for <linux-modules@vger.kernel.org>; Tue, 11 May 2021 09:59:11 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a2so8657168lfc.9
        for <linux-modules@vger.kernel.org>; Tue, 11 May 2021 09:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N972uEZ/zT+jVjfElPaGlMCMXJnUDWnHxGE2/rZu4G4=;
        b=t6aEeeK+U8Px6hgEJUVl4INqDf8b7U7V+c0tuWj0zsrOzYqEbL77BpEHuu7V/qj2MU
         nuMDON5mf/sEkbdkyZn+e+kQlyRskqMwX4Cu0BJQ3mymSC7Po+A0vx4U4h2uc8FphUb7
         ZH2HNsvDlbQXITbcPwvlZWO0azkxHdZO94/49gm0D3RFIRdnZXhJBxf1Tx9rTdsTk4ss
         tSLx1dYg4OVCz4mW71aIh7LA1qcKzTy5Epu+Yugpgr7UUE9II/unWCu/U1ZN2I8KaPa4
         YliuGW1AjFwK4Rg3jYWIEAawRSMRaZf14nAdANvY0TFaGTXVUeOKx25YxFv6Hd6apfko
         2+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N972uEZ/zT+jVjfElPaGlMCMXJnUDWnHxGE2/rZu4G4=;
        b=NTvK0DzGO9QlmEo4XN0vyLyR0Uvu+MBALHu5b8a+L8ibnUI5y0PbbJfSFSiz7nsVUr
         F0NF1XhYUjXwy9UkzkCkKcAwv1DN8yAx4+V8iUSDMjf1WFDbiPsL6wON08HgpAibJHVO
         WyuW3DR/3t9GlA57zMe0be+hM/bs1Wt7G58a1rooTLHxq0tB/lrghns1sp/GnVMWsuss
         yRlBgGYmTe77VwZxxtHAlPLGL2V5F/0rBSUrVD301sYOK2RNfjuuj5DutT7jp0Ly4upc
         nW2LysLCko8u9O20hvPtPWlZ6UKlGRkI1UjCt1zvgea0kRryhNjcQNHW0Rdj9dQIdZRG
         gPGQ==
X-Gm-Message-State: AOAM532V1NjgHSPINWJEfb2N/rxh0GRJiaMZmmR4FGIZiQztCAaUlhmw
        BLlpqEuiauOh/6Kjv+bXy91W7iR1DsoM6kh/Hf4J5K5isx8=
X-Google-Smtp-Source: ABdhPJzlARXoE+ipTjAhN1Vo3pUQ+8RWhA0lAzWB2GV2awxBR1tc6e2h5Lu17kH2yvawudkFjkJXseZS7qlpc/3svvk=
X-Received: by 2002:a05:6512:22c9:: with SMTP id g9mr21144337lfu.351.1620752350180;
 Tue, 11 May 2021 09:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210504235836.24246-1-pkj@axis.com> <CAKi4VAJLS7_9T3kUcxqphASF+3FegXeDmaDebsEFEaejU0BS0w@mail.gmail.com>
 <91eb2b9fbd854cb0a3436fb4fcb7ceb1@XBOX03.axis.com>
In-Reply-To: <91eb2b9fbd854cb0a3436fb4fcb7ceb1@XBOX03.axis.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 11 May 2021 09:58:58 -0700
Message-ID: <CAKi4VAJxZM2RGdQcqun_=oSJ5v1pqXkgV7tW+BbOshYMBSsMyw@mail.gmail.com>
Subject: Re: [PATCH] libkmod: Always search modules.builtin if no alias has
 been found
To:     Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, May 10, 2021 at 6:55 AM Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
>
> > -----Original Message-----
> > From: Lucas De Marchi <lucas.de.marchi@gmail.com>
> > Sent: den 9 maj 2021 07:55
> > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > Cc: linux-modules <linux-modules@vger.kernel.org>; Peter Kjellerstedt
> > <peter.kjellerstedt@axis.com>
> > Subject: Re: [PATCH] libkmod: Always search modules.builtin if no alias
> > has been found
> >
> > On Tue, May 4, 2021 at 5:17 PM Peter Kjellerstedt <pkj@axis.com> wrote:
> > >
> > > Commit 89443220e broke the lookup for builtin modules. modules.builtin
> > > was no longer searched if kmod_lookup_alias_from_kernel_builtin_file()
> > > returned 0.
> > >
> > > Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > > ---
> > >
> > > I do not know if this is the correct thing to do, or if the commit
> > > message makes any sense. However, it solves the problem we were seeing.
> > > We use fuse, which installs /etc/modules-load.d/fuse.conf to load the
> > > fuse kernel module. However, we have fuse built-in. Normally, the
> > > following can be seen in the log:
> > >
> > >   systemd-modules-load[192]: Module 'fuse' is built in
> > >
> > > but after commit 89443220e, we instead got:
> > >
> > >   systemd-modules-load[193]: Failed to find module 'fuse'
> > >
> > > //Peter
> > >
> > >  libkmod/libkmod-module.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> > > index 76a6dc3..6720930 100644
> > > --- a/libkmod/libkmod-module.c
> > > +++ b/libkmod/libkmod-module.c
> > > @@ -577,7 +577,7 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
> > >
> > >         DBG(ctx, "lookup modules.builtin.modinfo %s\n", alias);
> > >         err = kmod_lookup_alias_from_kernel_builtin_file(ctx, alias, list);
> > > -       if (err == -ENOSYS) {
> > > +       if (err == 0 || err == -ENOSYS) {
> >
> > So in your case you do have modules.builtin.modinfo, but fuse doesn't
> > show up there. On the other hand it is listed in modules.builtin.
> > Does modules.builtin.info contain anything or is it an empty file?
>
> We have neither modules.builtin.modinfo nor modules.builtin.info.
> A little googling turned out that modules.builtin.modinfo seems to have
> been introduced in 5.2, but this product uses a 4.19 based kernel.

ok, now I understood the entire context. So it seems the problem is
not that we are
missing the handling for return 0, but rather that
kmod_lookup_alias_from_kernel_builtin_file()
is not returning -ENOSYS when it should (index doesn't exist).  I
thought this was covered, but
obviously I was wrong. I will take a look what's going on.... we
should not handle err == 0 the same
way we handle err == -ENOSYS. If the index is missing we want to
fallback to the old one, but if
the index is there and we didn't find the module, we should just
return an error.

Lucas De Marchi

>
> > It seems to me something else is broken:  all modules in
> > modules.builtin should be in modules.builtin.modinfo as well. What is
> > the result of the following commands?
> >
> > grep fuse /lib/modules/$(uname -r)/modules.builtin
>
> kernel/fs/fuse/fuse.ko
>
> > grep fuse /lib/modules/$(uname -r)/modules.builtin.modinfo
>
> grep: /lib/modules/4.19.110-axis8/modules.builtin.modinfo: No such file or directory
>
> This is an embedded product built with our own distribution based on
> Poky Gatesgarth from the Yocto Project. The rootfs is read-only, including
> /lib/modules, so any contest there is created when the firmware image is
> built.
>
> > thanks
> > Lucas De Marchi
> >
> > >                 /* Optional index missing, try the old one */
> > >                 DBG(ctx, "lookup modules.builtin %s\n", alias);
> > >                 err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
>
> //Peter
>
