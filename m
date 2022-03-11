Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA67C433EF
	for <linux-modules@archiver.kernel.org>; Fri, 11 Mar 2022 18:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349942AbiCKSBR (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 11 Mar 2022 13:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344592AbiCKSBR (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Mar 2022 13:01:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F351D3068;
        Fri, 11 Mar 2022 10:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9Fsxced+cP/JAU6qIJzXyFDQ+HLcljGI9FeqA2TwMJo=; b=KIDm4YiGuH+nwsiNGJW1PBi3GW
        7nzmByTGtnRb9hV3Fwwu30Ih39CCBejNxk+AezmWDSt0QlL+Y8SuLt48mjpA75/B/GQiF0YeHedJa
        fUxDGUv3V72Wl6hb5hjku6ieBi2KPta1cHgg9UxgBTnCI0+TdT4WA8E5v16pLOrr9Gegb9TIPpDlQ
        xIgY5hMrl653Vez8uUhG+kfes/oHxFrSkNDLgd2eTxiaQuWMKy9D1DSQXbnmR5QWZbbvo7P0Q4YeY
        hU52+7VnJKmUwG6Hz5lMxGHotXoiM/p9AIeVphA7GXyH9tjxHyBMMZS0DINuQJE22BYLiAmJXHC3B
        fopZVllA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSjYb-00HZXL-Na; Fri, 11 Mar 2022 18:00:05 +0000
Date:   Fri, 11 Mar 2022 10:00:05 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>, christophe.leroy@csgroup.eu,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com, hch@infradead.org
Subject: Re: [PATCH v11 13/14] module: Move kdb module related code out of
 main kdb code
Message-ID: <YiuOJclTu3/C9Olo@bombadil.infradead.org>
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102625.3441888-1-atomlin@redhat.com>
 <20220310102625.3441888-2-atomlin@redhat.com>
 <20220311161736.2i53cjovg3plbiqu@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311161736.2i53cjovg3plbiqu@maple.lan>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Mar 11, 2022 at 04:17:36PM +0000, Daniel Thompson wrote:
> On Thu, Mar 10, 2022 at 10:26:24AM +0000, Aaron Tomlin wrote:
> > No functional change.
> > 
> > This patch migrates the kdb 'lsmod' command support out of main
> > kdb code into its own file under kernel/module. In addition to
> > the above, a minor style warning i.e. missing a blank line after
> > declarations, was resolved too. The new file was added to
> > MAINTAINERS. Finally we remove linux/module.h as it is entirely
> > redundant.
> > 
> > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Likewise w.r.t. to landing this via the modules tree, that's fine:
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Groovy thanks, this won't go in for the upcoming merge window, it will
wait until the next kernel release as we have tons of testing to do
still.

Thanks!

  Luis
