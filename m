Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2F6C77B73
	for <linux-modules@archiver.kernel.org>; Mon, 22 May 2023 21:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjEVVVs (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 22 May 2023 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjEVVVr (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 22 May 2023 17:21:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F88C6;
        Mon, 22 May 2023 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o45skQCW05aoS9DI6od2cBGCBFOyyDBnDFRMJXiZwBM=; b=4N/sUcZ9BUoADLYog1KHCCG9qq
        1MmC0l7U7MMFm/pb/CMiCEGhHde5YvdPAClCnWx6m1AjjWqY1ZXKhjoINwzDcGKGDC0tsBFdRm9QK
        jTxHymltoxiw0ciU9pqQwK9wliQ9ZnW7lDDn4lY54MVMGvallddVj9/Hd7J73nf0RPH3b2vwME+GG
        BVhH02LYW+hYeukDo6BnRrtnvDEnfQBxHVg7Sy2fSS+FgOoHfqPl3vhHtPA4sPnL7z+WIutCS+6K2
        O43+3k6ZX/ZvGJpcoqlzWY1W2eiWEzKqIXnvhPwuT2UxM+8U+ylxCXGLrd/KKBmvGSc3pZ+7q+KwT
        8OJ7MaoQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1CyQ-0085ER-0X;
        Mon, 22 May 2023 21:21:46 +0000
Date:   Mon, 22 May 2023 14:21:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        error27@gmail.com, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] module: Fix use-after-free bug in read_file_mod_stats()
Message-ID: <ZGvc6tMIlvcp8zvt@bombadil.infradead.org>
References: <20230428055933.2699308-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428055933.2699308-1-harshit.m.mogalapalli@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Apr 27, 2023 at 10:59:33PM -0700, Harshit Mogalapalli wrote:
> Smatch warns:
> 	kernel/module/stats.c:394 read_file_mod_stats()
> 	warn: passing freed memory 'buf'
> 
> We are passing 'buf' to simple_read_from_buffer() after freeing it.
> 
> Fix this by changing the order of 'simple_read_from_buffer' and 'kfree'.
> 
> Fixes: df3e764d8e5c ("module: add debug stats to help identify memory pressure")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---

Queued up, thanks!

  Luis
