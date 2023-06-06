Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD27C77B73
	for <linux-modules@archiver.kernel.org>; Tue,  6 Jun 2023 18:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbjFFSii (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 6 Jun 2023 14:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbjFFSig (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 6 Jun 2023 14:38:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41D3125
        for <linux-modules@vger.kernel.org>; Tue,  6 Jun 2023 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oQLX8/xe6NQ9iXPaomZ8rX82ALM9VP+Q3WRpXij9wnU=; b=KcwKH1kbVWSGqntkessugOuiM9
        hTEo+be1j52Or183dihv4kpCIKZ+s331AgKt3Vgba+K4/r+fVJaeDX57k7Zs5m5Tfba8ZXPLaF5Ir
        CRguxaW2vehyFKqobjQo7+e9BjvzSIHGMdW+Dq+xA3w+gXJ5dV7nLdMvH1hZGw25SfZuiQ9x23w6Z
        jKcMl900wJBBjU24CltK489EMWtN926WnWmlxYUMCVLYsLspglKpGOvk6wEPbePmNu3g8KK1g0TvF
        jZiKd4mJ/OXAdNG5B/DPEefeOtFU6k78JLZeQqTl6k/0a3MomtJyimqAwy87YtGT86dQSyiiaqmaI
        lU9N89XA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6bZj-002n1D-21;
        Tue, 06 Jun 2023 18:38:35 +0000
Date:   Tue, 6 Jun 2023 11:38:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 5/5] libkmod: Use kernel decompression when available
Message-ID: <ZH99K7CwPQrykkIf@bombadil.infradead.org>
References: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
 <20230601224001.23397-6-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601224001.23397-6-lucas.de.marchi@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 01, 2023 at 03:40:01PM -0700, Lucas De Marchi wrote:
> With the recent changes to bypass loading the file it's possible to
> reduce the work in userspace and delegating it to the kernel. Without
> any compression to illustrate:
> 
> Before:
> 	read(3, "\177ELF\2\1", 6)               = 6
> 	lseek(3, 0, SEEK_SET)                   = 0
> 	newfstatat(3, "", {st_mode=S_IFREG|0644, st_size=238592, ...}, AT_EMPTY_PATH) = 0
> 	mmap(NULL, 238592, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fd85cbd1000
> 	finit_module(3, "", 0)                  = 0
> 	munmap(0x7fd85cbd1000, 238592)          = 0
> 	close(3)                                = 0
> 
> After:
> 	read(3, "\177ELF\2\1", 6)               = 6
> 	lseek(3, 0, SEEK_SET)                   = 0
> 	finit_module(3, "", 0)                  = 0
> 	close(3)                                = 0

It's not clear to me how the patches did the above, in particular
avoiding the newfstatat() for the non-decompression use case.

  Luis
