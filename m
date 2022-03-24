Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0F3C433EF
	for <linux-modules@archiver.kernel.org>; Thu, 24 Mar 2022 23:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355705AbiCXXUW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 24 Mar 2022 19:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbiCXXUW (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 24 Mar 2022 19:20:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D8C506DE;
        Thu, 24 Mar 2022 16:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V3ILAWm1EFfLxfCGFuHqiB2ko+YtyLNMwhTcp2AtwhA=; b=sJUOTxGP4DrxQIcLVPYWF0mecU
        QHDm52pvG10GlRr6ZCzpRRAn3wRRe0EaMXvKA2kitjn8l8LJkmPwEGQzjixhuewBIQNuBTCD9RWZL
        684sBEGPYa+vsASbrDK5Am+UikPpBA8t2uGW/wyj+HQAreSZcdeDJQUxA5GOOkCthB7rcTHCysOGn
        GR702nhzQUpoq3/+O4MytUYTlTNVgtDdQy/gyjHSzY0lwakT7jWkIqEwjYIdoGkn/7kCMcMvkMRlf
        QBpR2WjCEeTkOsBQCxUUZamR3At+8XOEnp/DnItT8pYIPgH6s0GxKcCNtayQuOk6rudrXCLTcLwKs
        4LwB+GVQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXWj8-000Xbf-4i; Thu, 24 Mar 2022 23:18:46 +0000
Date:   Thu, 24 Mar 2022 16:18:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] lib/test: use after free in register_test_dev_kmod()
Message-ID: <Yjz8VtXvR5Zr61EA@bombadil.infradead.org>
References: <20220324055207.GA21683@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324055207.GA21683@kili>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 24, 2022 at 08:52:07AM +0300, Dan Carpenter wrote:
> The "test_dev" pointer is freed but then returned to the caller.
> 
> Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks queued onto modules-testing!

  Luis
