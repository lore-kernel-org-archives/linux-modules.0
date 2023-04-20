Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE76C77B7E
	for <linux-modules@archiver.kernel.org>; Thu, 20 Apr 2023 05:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjDTFcT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 20 Apr 2023 01:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjDTFcS (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 20 Apr 2023 01:32:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057E526B2;
        Wed, 19 Apr 2023 22:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73D7261730;
        Thu, 20 Apr 2023 05:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D77AC433EF;
        Thu, 20 Apr 2023 05:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681968733;
        bh=TUvSb3jLAD4SO/CabGVEytTuEPkD5hNOOi9zTj/3c4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1F2Lp4RqFs0s9Hsn9ZCCA0dePukkSHX1+r0RpOoFBpNGP1YELgHENY1/MCq4oxcs
         Emlbr84myUVwwa+qldov5NAcHhhbJ40yZIiqS6Un1hLNoOB4KiARxk0LOrpEFFN/e7
         7UY8oSKGe/unFMChoD0RvqkmcEgETE8f6mDIc56Y=
Date:   Thu, 20 Apr 2023 07:32:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH] module: add debugging auto-load duplicate module support
Message-ID: <ZEDOWi8ifghwmOjp@kroah.com>
References: <20230418204636.791699-1-mcgrof@kernel.org>
 <2023041951-evolution-unwitting-1791@gregkh>
 <ZEB6DmF+l3LVrpFI@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEB6DmF+l3LVrpFI@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Apr 19, 2023 at 04:32:30PM -0700, Luis Chamberlain wrote:
> > It's not "wasted", as it is returned when the module is determined to be
> > a duplicate.  Otherwise everyone will want this enabled as they think it
> > will actually save memory.
> 
> I'll change the language to be clear the issue is memory pressure early
> on boot. I'll also add a bit of language to help at least guide people
> to realize that the real value-add for this, ie, I'll have to mention we
> suspect issue is udev and not module auto-loading and that this however
> may still help find a few cases we can optimize for.

This isn't udev's "problem", all it is doing is what the kernel asked it
to do.  The kernel said "Here's a new device I found, load a module for
it please!"

And it's the kmod code here, not udev itself doing all of this.  Why not
just rate-limit it in userspace if your system can't handle 10's of
thousands of kmod calls all at once?  I think many s390 systems did this
decades ago when they were controlling 10's of thousands of scsi devices
and were hit with "device detection storms" at boot like this.

If you really think it's the kernel's fault, just slow down the kernel's
device detection code for the specific bus that is having problems.
We've worked hard to make the kernel boot really fast and device
detection happen in parallel, maybe that wasn't a good idea for some
systems and so they need to boot slower.  If so, then just turn off the
parallel probing for the offending bus type.

What specific devices and bus types are the problem here for these systems?

thanks,

greg k-h
