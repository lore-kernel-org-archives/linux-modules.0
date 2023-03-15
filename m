Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BE8C6FD1D
	for <linux-modules@archiver.kernel.org>; Wed, 15 Mar 2023 16:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjCOQMB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 15 Mar 2023 12:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjCOQLf (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 15 Mar 2023 12:11:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7770828E4A;
        Wed, 15 Mar 2023 09:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3XlQ2R46wG8cwBKJqO7Irjo0abOg70WOiMVivhr6Fp8=; b=RDc7oUjej/NnnPFHAwKac7QRnE
        OYkWivqMql3Xrfl3cyGt3EO20SYcPLqyXR8xZuYv4dKZ3SN3HzNUMm3s3FANc89odd5ee76kUyckm
        HEsjT4YIvDoX/MkIA5lSfVuMEiZmZCCabMjU/+hJYn7Rdt7D5yKOC/kjHpklRzrW2cONDWxxUzG2L
        nKWPjwZP2X8ipwjn1qV0A31KSgeO5LKQZ7MSPFlbZc7vRroO9ZKGrNBqI7n1ivG6zBvinkZVcSD5s
        d4sXcvkFVRhk1WI5fWxtRq5ftVRYoaHRNhV/zPDvjns3Ig/4eK2nfu9iz2j/0YSJe3tP/wck4lN4h
        ++e9EL3g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcTiA-00E1rj-1p;
        Wed, 15 Mar 2023 16:10:46 +0000
Date:   Wed, 15 Mar 2023 09:10:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Message-ID: <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
References: <20230311051712.4095040-1-mcgrof@kernel.org>
 <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 15, 2023 at 01:24:41PM +0100, David Hildenbrand wrote:
> On 11.03.23 06:17, Luis Chamberlain wrote:
> > A long time ago we had some issues with userspace doing stupid stuff.
> > Well, it turns out even the kernel and do stupid stuff too, as we're
> > learning with the ACPI modules aliaes and that hammering tons of loads.
> > 
> > So add a bit of code which gets us a bit more in the defensive about
> > these situations.
> > 
> > To experiment, this also adds in-kernel alias support to see if this helps
> > with some larger systems.
> > 
> > This is all based on some old code which tried to add defensive
> > mechanisms the last of which was here and I had dropped the ball:
> > 
> > https://lore.kernel.org/all/20171208001540.23696-1-mcgrof@kernel.org/
> > 
> > I've only compile tested this for now. Will need to stress to test
> > with kmod tests 0008 and 0009 to see if there's any differences.
> > I'll have to re-test and re-gnuplot stuff there. But early feedback
> > is appreciated, hence the RFC.
> > 
> > David Hildenbrand had reported a while ago issues with userspace
> > doing insane things with allocations bringing a system down to
> > its knees. This is part of the motivation for this series.
> 
> 
> I'll try to grab a system where I can reproduce the issue and give your
> patches a churn.

Great, then please wait for v2 RFC as the first patch was missing an
obvious mutex grab / release, I already have some memory pressure data
that shows gains. Hope to post soon.

  Luis
