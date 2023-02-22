Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B225C61DA4
	for <linux-modules@archiver.kernel.org>; Wed, 22 Feb 2023 22:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjBVWwZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 22 Feb 2023 17:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjBVWwY (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 22 Feb 2023 17:52:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412E3301B6;
        Wed, 22 Feb 2023 14:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8qxHtZKL8t+iAYd4jXFPwWUnv28iDGlBoIEMDUa0ZVw=; b=3xMBTeWfCPo5bXUO7wsJX7seJb
        JyUU9eLT76l6qdIWw/fqLUbaJ+yuvDwZh1pII6c86Dk8XBi/R53l38/70UACDhvpUD7D+kdY9jxkZ
        4QHEeMa9xfY0kRdSffThh7hFx5fJskO/SADxnOB5Zx5eoCfJ3lVMP6Frfz7LRBAuWjP+afE0bR648
        XcgjBBAKadfWLx2CkpgdP5t2vj7lLCfmy/3V7xhNIMfZR9/1UB75Kkh/FmlPrRePoNC1r/qI+Z2K0
        jADpb+rocxm80bHSvcbh97EN7mZrfYG1NsmoVn/lnlYVXy+ijAt2P6FmLGTtd1sB4GZ/ID4YrFI6g
        tMemO6Ww==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUxyD-00EMIC-TS; Wed, 22 Feb 2023 22:52:17 +0000
Date:   Wed, 22 Feb 2023 14:52:17 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev
Subject: Re: [PATCH 21/27] kbuild, dma-mapping: benchmark: remove
 MODULE_LICENSE in non-modules
Message-ID: <Y/acoc6MDKNnrG+g@bombadil.infradead.org>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-22-nick.alcock@oracle.com>
 <20230222144856.GA14220@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222144856.GA14220@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 22, 2023 at 03:48:56PM +0100, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> On Wed, Feb 22, 2023 at 12:14:47PM +0000, Nick Alcock wrote:
> > Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> > Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> > are used to identify modules.
> 
> .. but this seems like a really odd design.  How is this going to
> continue working once we can autogenerate the module license section
> from the SPDX tags, which we eventually really should?

Yes I totally agree we should. But I think we should take this by steps.
First, we ensure we have only MODULE_LICENSE() macros upstream on things which
are really possible modules, ie we remove the false positives. We then put a
stop-gap script which can complain if it finds new usecases which are buggy.

Then we look for an optimal way to address the final step:

 * remove all MODULE_LICENSE() and autogenerate them from SPDX

The difficulty in this will be that we want to upkeep existing build
heuristics and avoid to have to traverse the tree twice (see details
on commit 8b41fc4454e). I can't think of an easy way to do this that
does not involve using kconfig tristate somehow. This is a bit of
tricky homework we have. Perhaps Masahiro can come up with something
clever.

  Luis
