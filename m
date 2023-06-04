Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8029C7EE29
	for <linux-modules@archiver.kernel.org>; Sun,  4 Jun 2023 14:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjFDO03 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 4 Jun 2023 10:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFDO02 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 4 Jun 2023 10:26:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A53D2
        for <linux-modules@vger.kernel.org>; Sun,  4 Jun 2023 07:26:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-653fcd58880so874365b3a.0
        for <linux-modules@vger.kernel.org>; Sun, 04 Jun 2023 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1685888785; x=1688480785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HA5YrIYH9MawD+4VRjcWbjHM//DpBE3FGKspT1TvJ+c=;
        b=CcQtwON+W3n7y7rA9m3IbuMZf1gq/6rWVzSIyiMZaJ9Vp4L7cwZl7Eptdo7f5/JYrH
         VY96BmCnZdcD+JuKrA0Kjp42bz0LLhrV3VQlkDWcACaWtSQ2lb+QUxFB38AQn87H3lTj
         U+n4Q9vvxFpFS30gxqxlMKuZ5R50iQVSLSHXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685888785; x=1688480785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HA5YrIYH9MawD+4VRjcWbjHM//DpBE3FGKspT1TvJ+c=;
        b=gHpMbmM3Bkl2mdhjjkrYeuu25BrOi0VX5il9IpzMrHDTjHElsv1Rw3+fdsV5+hsG9s
         OTqPSHVFVPp16F8eIeDlJDv5axj87TUxzIVpOHgTvRRdE4xveYaQLrE7DJ6GyB95M84I
         WIf2zmh0CfMGQL7jOUM0M7mUcA26BihbHWGZzkfpNzsxnByOxR6eSeTtZ6HV6EVlb4X1
         hqopqo2kFTVp3aP5HgIitf09uw21qz1U39bFvUzNNJAT5q7A53Tec8L2G7Eli9mcT75h
         w6idsgP6jWrUfJbMSGprVH5hknGNBDdeYm8izNNnBKyjGkWjGINA6htOBUH7atx9VC9B
         IUOg==
X-Gm-Message-State: AC+VfDwtl3ZqALtY85dyjjtMAAUsOvXuQdo3ZFFOAI8RG4C8IWHzOYxf
        sz3VuzGeE0jC1vMtzL65b0FkfQ==
X-Google-Smtp-Source: ACHHUZ5L7kPdWHNyYrkbAXFw/Ud0NVHz/4s8+yRhJJX2mlG+9wCBm0pRDUZD3gxZ8iMp5wqgAPDJQQ==
X-Received: by 2002:a05:6a20:158b:b0:10c:4c76:e909 with SMTP id h11-20020a056a20158b00b0010c4c76e909mr1573877pzj.8.1685888784842;
        Sun, 04 Jun 2023 07:26:24 -0700 (PDT)
Received: from 80e1dc6c40da ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id h6-20020a62b406000000b00637b0c719c5sm3657475pfn.201.2023.06.04.07.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 07:26:23 -0700 (PDT)
Date:   Sun, 4 Jun 2023 14:26:12 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net, imre.deak@intel.com
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <ZHyfBLbZCE4cUMdV@80e1dc6c40da>
References: <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
 <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
 <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
 <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, May 29, 2023 at 09:55:15PM -0400, Linus Torvalds wrote:
> On Mon, May 29, 2023 at 11:18 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > I took a closer look at some of the modules that failed to load and
> > noticed a pattern in that they have dependencies that are needed by more
> > than one device.
> 
> Ok, this is a "maybe something like this" RFC series of two patches -
> one trivial one to re-organize things a bit so that we can then do the
> real one which uses a filter based on the inode pointer to return an
> "idempotent return value" for module loads that share the same inode.
> 
> It's entirely untested, and since I'm on the road I'm going to not
> really be able to test it. It compiles for me, and the code looks
> fairly straightforward, but it's probably buggy.

The updated patches fix the issue experienced with 6.4-rc4 where the Intel
NUC12 booted fine, but on media playback resulted in the video stuttering,
then freezing - and that audio was not coming though.

# diff modules-rc4 modules-rc4-patched
< snd_hda_codec_hdmi     77824  0
< snd_hda_codec_realtek   159744  0
---
> snd_hda_codec_hdmi     77824  1
> snd_hda_codec_realtek   159744  1

 Revert "module: error out early on concurrent load of the same module file"
 module: split up 'finit_module()' into init_module_from_file() helper
 modules: catch concurrent module loads, take two
 Johan's fix:
  -static struct spinlock idem_lock;
  +static DEFINE_SPINLOCK(idem_lock);

Tested-by: Rudi Heitbaum <rudi@heitbaum..com>
