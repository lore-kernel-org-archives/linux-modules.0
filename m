Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC28C61DA4
	for <linux-modules@archiver.kernel.org>; Wed, 22 Feb 2023 14:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjBVOue (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 22 Feb 2023 09:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBVOuT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 22 Feb 2023 09:50:19 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5B355A8;
        Wed, 22 Feb 2023 06:49:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5EF19227AA8; Wed, 22 Feb 2023 15:48:57 +0100 (CET)
Date:   Wed, 22 Feb 2023 15:48:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev
Subject: Re: [PATCH 21/27] kbuild, dma-mapping: benchmark: remove
 MODULE_LICENSE in non-modules
Message-ID: <20230222144856.GA14220@lst.de>
References: <20230222121453.91915-1-nick.alcock@oracle.com> <20230222121453.91915-22-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222121453.91915-22-nick.alcock@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

On Wed, Feb 22, 2023 at 12:14:47PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules.

.. but this seems like a really odd design.  How is this going to
continue working once we can autogenerate the module license section
from the SPDX tags, which we eventually really should?
