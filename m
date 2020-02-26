Return-Path: <SRS0=C6ur=4O=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D41C4BA24
	for <linux-modules@archiver.kernel.org>; Wed, 26 Feb 2020 19:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E612A21556
	for <linux-modules@archiver.kernel.org>; Wed, 26 Feb 2020 19:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn1I39kw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgBZTgQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:36:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52811 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbgBZTgQ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 26 Feb 2020 14:36:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so593940wmc.2
        for <linux-modules@vger.kernel.org>; Wed, 26 Feb 2020 11:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyHOWysGrbvauHwksX3VVHUmtDpJyeFPmBAD1Q2H4z0=;
        b=Rn1I39kwy+dpt16D3x8oSY+FfOge4y2OLgMdCvPqZqhASd6xFXvgraEu8U0gPI8D9l
         oTwoC9gIFmHXys7cGm22TMCk4DXLKB+Hx9E4F47ps8PFTYgve59nS/w2FqKV8fALhG6O
         XZByqjg13/PjtK6TNqdwOLg79sYidtNSEjqJJJGsqytlXjkLhPefDPsIfLb0CT1uViPx
         1RtV6TMVTAQGZYZ57Rag/3gbqjc0GU/ykkbRZJg/VwW+fzvwUMpqiOZzu+oCEgMgPT0/
         W2FJzotBuHfU0o+u63wV5smAvyFSaOPLsQT8pu9PfuzWJGIUx8EhlYsWurh9Vv3UZCLW
         owSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyHOWysGrbvauHwksX3VVHUmtDpJyeFPmBAD1Q2H4z0=;
        b=mhx2za+BC+1Gm9mkrostTLGIXA2sJOq+ItQ38/eiJEM9yvx3Y5Hw17pimI8YoX+syf
         bWOYEOmrXWXTDcdBLXa/IT+mXJVjsxBpT82uwGhmEnYGUfuChbI9V/HLlLAwN2LTCHmG
         szX8eYIzu7nSzM6vdWMaRRIcK39Cc9s/8ql83kY3ablLocePlH4rrC/G/QEZGCiX66l2
         y42NMDCGNPz9YFRkL8maXM7Aqy5Vh6/9WDc9/d4q/sNkxq2H6S8ENXzUN/ah7mJlyv88
         a09Wi8ycaKM2aKndkpebKSoMVyGvzRVwO6jlBYA/TV+poN6Du5Rh/C6yfcRy9Um8t4mR
         RP3w==
X-Gm-Message-State: APjAAAWBHLEgjl7yrwGtlOy1Cy+PtNZ+Juli/hGK/oREPQfAg3rXdDgV
        lZc+1o6cZkOdzJx8TCfGmoazEpFawPSKGzROXHQ=
X-Google-Smtp-Source: APXvYqwGHbHUxLwOhHEpqJSU3FtTPBH3x5UbyyvfNHhXjJIp4ARprEy7Ye5TADYI2D4AReuEG0jfi9HjPYpY2C/Ycs0=
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr455718wmf.136.1582745774303;
 Wed, 26 Feb 2020 11:36:14 -0800 (PST)
MIME-Version: 1.0
References: <dda23def071a8d087cca3538289de1e0@bspu.by> <20200226183153.35qmuu57svmx62ab@comp-core-i7-2640m-0182e6>
In-Reply-To: <20200226183153.35qmuu57svmx62ab@comp-core-i7-2640m-0182e6>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Wed, 26 Feb 2020 11:36:00 -0800
Message-ID: <CAKi4VAJFM0oM5r0oUtgT0oChH2q6+5YNq_46e01ih4j5qXsCxQ@mail.gmail.com>
Subject: Re: modinfo must show real module info, not context if filename set
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     mahatma@eu.by, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 26, 2020 at 10:33 AM Alexey Gladkov
<gladkov.alexey@gmail.com> wrote:
>
> On Wed, Feb 26, 2020 at 04:53:45AM +0200, Denis Kaganovich wrote:
> > After commit e7e2cb61fa9f1db3429d91ef6accff549500d268, even if real filename
> > passed - modinfo show info from context (so, I got built-in info from
> > running
> > kernel, but asking for new kernel's external module). This behaviour
> > unobvious
> > and incompatible with pre-v27. Simple use fake context for filename - IMHO
> > much less ugly then current results.
>
> Can you give an example of this misbehavior ?
>
> I have a two kernel directories (generic and current) with
> modules.builtin.modinfo:
>
> $ ls -1 /lib/modules/{5.2.0-generic,`uname -r`}/modules.builtin.modinfo
> /lib/modules/5.2.0-generic/modules.builtin.modinfo
> /lib/modules/5.2.0-current/modules.builtin.modinfo
>
> The ext4 module is built into both:
>
> $ tr '\0' '\n' < /lib/modules/`uname -r`/modules.builtin.modinfo |grep ^ext4.description
> ext4.description=Fourth Extended Filesystem
>
> $ tr '\0' '\n' < /lib/modules/5.2.0-generic/modules.builtin.modinfo |grep ^ext4.description
> ext4.description=Fourth Extended Filesystem
>
> Now I have build this module separately and put it into the tree:

that's why you don't have this problem. If you just build a new
ext4.ko module and give it
in the command line without putting it into the tree, then this
problem would be triggered.

$ ~/p/kmod/tools/modinfo fs/ext4/ext4.ko
filename:       /home/ldmartin/p/gfx-internal/drm-intel-internal/fs/ext4/ext4.ko
modinfo: ERROR: could not get modinfo from 'ext4': No such file or directory

$ modinfo fs/ext4/ext4.ko
filename:       /home/ldmartin/p/gfx-internal/drm-intel-internal/fs/ext4/ext4.ko
softdep:        pre: crc32c
license:        GPL
description:    Fourth Extended Filesystem
author:         Remy Card, Stephen Tweedie, Andrew Morton, Andreas
Dilger, Theodore Ts'o and others
alias:          fs-ext4
alias:          ext3
alias:          fs-ext3
alias:          ext2
alias:          fs-ext2
depends:        mbcache,jbd2
retpoline:      Y
intree:         Y
name:           ext4
vermagic:       5.4.17+ SMP preempt mod_unload

Lucas De Marchi

>
> $ find /lib/modules/{5.2.0-generic,`uname -r`} -name 'ext4.*'
> /lib/modules/5.2.0-generic/kernel/fs/ext4/ext4.ko.gz
>
> For current kernel:
>
> $ tools/modinfo ext4 |grep filename
> filename: (builtin)
>
> For the other kernel:
>
> $ tools/modinfo -k 5.2.0-generic ext4 |grep filename
> filename: /lib/modules/5.2.0-generic/kernel/fs/ext4/ext4.ko.gz
>
> Only the external module is displayed, even if there is a module with the
> same name in the modules.builtin.modinfo.
>
> I also have a very old kernel without modules.builtin.modinfo:
>
> $ tools/modinfo -k 4.14.96-generic ext4 |grep filename
> filename: /lib/modules/4.14.96-generic/kernel/fs/ext4/ext4.ko.gz
>
> > Signed-off-by: Dzianis Kahanovich <mahatma@eu.by>
> >
> > --- a/tools/modinfo.c 2020-02-25 13:46:38.181693570 +0300
> > +++ b/tools/modinfo.c 2020-02-26 05:18:39.393790919 +0300
> > @@ -359,7 +359,7 @@ static bool is_module_filename(const cha
> >
> >  static int do_modinfo(int argc, char *argv[])
> >  {
> > -     struct kmod_ctx *ctx;
> > +     struct kmod_ctx *ctx, *ctx0;
> >       char dirname_buf[PATH_MAX];
> >       const char *dirname = NULL;
> >       const char *kversion = NULL;
> > @@ -437,7 +437,8 @@ static int do_modinfo(int argc, char *ar
> >       }
> >
> >       ctx = kmod_new(dirname, &null_config);
> > -     if (!ctx) {
> > +     ctx0 = kmod_new("/dev/null", &null_config);
> > +     if (!ctx || !ctx0) {
> >               ERR("kmod_new() failed!\n");
> >               return EXIT_FAILURE;
> >       }
> > @@ -448,7 +449,7 @@ static int do_modinfo(int argc, char *ar
> >               int r;
> >
> >               if (is_module_filename(name))
> > -                     r = modinfo_path_do(ctx, name);
> > +                     r = modinfo_path_do(ctx0, name);
> >               else
> >                       r = modinfo_alias_do(ctx, name);
> >
> > @@ -456,6 +457,7 @@ static int do_modinfo(int argc, char *ar
> >                       err = r;
> >       }
> >
> > +     kmod_unref(ctx0);
> >       kmod_unref(ctx);
> >       return err >= 0 ? EXIT_SUCCESS : EXIT_FAILURE;
> >  }
> >
>
> --
> Rgrds, legion
>


-- 
Lucas De Marchi
