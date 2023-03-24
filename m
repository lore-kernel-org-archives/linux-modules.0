Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F47BC76195
	for <linux-modules@archiver.kernel.org>; Fri, 24 Mar 2023 23:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCXX1l (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 24 Mar 2023 19:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXX1l (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 24 Mar 2023 19:27:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFB91AC;
        Fri, 24 Mar 2023 16:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JaEl4CGqZIMSgWvz/T/A/cVf4WLWQZP2LxPznCrkLQo=; b=gWss8CoWOZ13Zq8BKRsZlvP0qQ
        ulS9o/uxfHo6ibBT6+6cwFxN2+XhXtprAGEFW7T2okWYVXnb3X79IzgY/j5qO/BgPye5+MR+vlYtT
        jctZVdHdrIdoNfsUYCyKT/AgpC32ow8K7liVIA8ejwnbEpCwcZBIkrbNq4Obka6Zca3qV4KKThM6p
        FViAai1egcAPsjZagtTXMsiBEUUa0/YeSfFCOoNZ4xvbNNkvYsI41EZsAAMwo1fSeBx7OHz5mVOw1
        Z/ljKmj9dtZux9zqPRQXq7zCUY1P03cqfSGxIGPD0tBdhv2rqmr/tvmT8I+haeBTDif8rwFDSIVgS
        ouzI7O6w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfqoq-005otG-13;
        Fri, 24 Mar 2023 23:27:36 +0000
Date:   Fri, 24 Mar 2023 16:27:36 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Message-ID: <ZB4x6IY/8P1Xam7d@bombadil.infradead.org>
References: <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
 <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
 <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
 <CAHk-=wij=z-C6puGv+E5gGKgFMam-ucCjyji0-vP1wd=aUpFvQ@mail.gmail.com>
 <ZB4BP0ZgxNirBNOJ@bombadil.infradead.org>
 <CAHk-=whkj6=wyi201JXkw9iT_eTUTsSx+Yb9d4OgmZFjDJA18g@mail.gmail.com>
 <ZB4SoxgM6vydrxrj@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB4SoxgM6vydrxrj@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Mar 24, 2023 at 02:14:11PM -0700, Luis Chamberlain wrote:
> On Fri, Mar 24, 2023 at 01:28:51PM -0700, Linus Torvalds wrote:
> >    +static CONCURRENCY_LIMITER(module_loading_concurrency, 50);
> I'll give it a good wack thanks.

Using a value of 20 above matches what I to get up to 100 stress-ng
module ops without any OOM (which seems to mimick a 400 CPU environment):

echo 0 > /proc/sys/vm/oom_dump_tasks
./stress-ng --module 100 --module-name xfs

I'll go with that and evaluate max memory usage as well, but this is
still inviting us to consider other users interfacing areas with an
implicated vmalloc and the scale of this as we grow number of CPU
counts.

A magic values of 20 is completely empirical.

  Luis
