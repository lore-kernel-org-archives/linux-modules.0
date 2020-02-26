Return-Path: <SRS0=C6ur=4O=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB25C4BA24
	for <linux-modules@archiver.kernel.org>; Wed, 26 Feb 2020 22:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6194D24656
	for <linux-modules@archiver.kernel.org>; Wed, 26 Feb 2020 22:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBZWgd (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:36:33 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:59688 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgBZWgd (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 26 Feb 2020 17:36:33 -0500
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id C720AC61832;
        Wed, 26 Feb 2020 22:36:29 +0000 (UTC)
Date:   Wed, 26 Feb 2020 23:36:28 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     mahatma@eu.by, linux-modules <linux-modules@vger.kernel.org>
Subject: Re: modinfo must show real module info, not context if filename set
Message-ID: <20200226223628.ncpovmhd6kpyph2l@comp-core-i7-2640m-0182e6>
References: <dda23def071a8d087cca3538289de1e0@bspu.by>
 <20200226183153.35qmuu57svmx62ab@comp-core-i7-2640m-0182e6>
 <CAKi4VAJFM0oM5r0oUtgT0oChH2q6+5YNq_46e01ih4j5qXsCxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKi4VAJFM0oM5r0oUtgT0oChH2q6+5YNq_46e01ih4j5qXsCxQ@mail.gmail.com>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 26, 2020 at 11:36:00AM -0800, Lucas De Marchi wrote:
> On Wed, Feb 26, 2020 at 10:33 AM Alexey Gladkov
> <gladkov.alexey@gmail.com> wrote:
> >
> > On Wed, Feb 26, 2020 at 04:53:45AM +0200, Denis Kaganovich wrote:
> > > After commit e7e2cb61fa9f1db3429d91ef6accff549500d268, even if real filename
> > > passed - modinfo show info from context (so, I got built-in info from
> > > running
> > > kernel, but asking for new kernel's external module). This behaviour
> > > unobvious
> > > and incompatible with pre-v27. Simple use fake context for filename - IMHO
> > > much less ugly then current results.
> >
> > Can you give an example of this misbehavior ?
> >
> > I have a two kernel directories (generic and current) with
> > modules.builtin.modinfo:
> >
> > $ ls -1 /lib/modules/{5.2.0-generic,`uname -r`}/modules.builtin.modinfo
> > /lib/modules/5.2.0-generic/modules.builtin.modinfo
> > /lib/modules/5.2.0-current/modules.builtin.modinfo
> >
> > The ext4 module is built into both:
> >
> > $ tr '\0' '\n' < /lib/modules/`uname -r`/modules.builtin.modinfo |grep ^ext4.description
> > ext4.description=Fourth Extended Filesystem
> >
> > $ tr '\0' '\n' < /lib/modules/5.2.0-generic/modules.builtin.modinfo |grep ^ext4.description
> > ext4.description=Fourth Extended Filesystem
> >
> > Now I have build this module separately and put it into the tree:
> 
> that's why you don't have this problem. If you just build a new
> ext4.ko module and give it
> in the command line without putting it into the tree, then this
> problem would be triggered.

Ouch, I see. The phrase "new kernel's external module" confused me because
usually the modules for the new kernel are in the tree. My bad.

> $ ~/p/kmod/tools/modinfo fs/ext4/ext4.ko
> filename:       /home/ldmartin/p/gfx-internal/drm-intel-internal/fs/ext4/ext4.ko
> modinfo: ERROR: could not get modinfo from 'ext4': No such file or directory
> 
> $ modinfo fs/ext4/ext4.ko
> filename:       /home/ldmartin/p/gfx-internal/drm-intel-internal/fs/ext4/ext4.ko
> softdep:        pre: crc32c
> license:        GPL
> description:    Fourth Extended Filesystem
> author:         Remy Card, Stephen Tweedie, Andrew Morton, Andreas
> Dilger, Theodore Ts'o and others
> alias:          fs-ext4
> alias:          ext3
> alias:          fs-ext3
> alias:          ext2
> alias:          fs-ext2
> depends:        mbcache,jbd2
> retpoline:      Y
> intree:         Y
> name:           ext4
> vermagic:       5.4.17+ SMP preempt mod_unload
> 
> Lucas De Marchi

-- 
Rgrds, legion

