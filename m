Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49440C77B73
	for <linux-modules@archiver.kernel.org>; Tue,  6 Jun 2023 18:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjFFS3H (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 6 Jun 2023 14:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbjFFS3G (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 6 Jun 2023 14:29:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7E2170D
        for <linux-modules@vger.kernel.org>; Tue,  6 Jun 2023 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wzv4tIvQ2JCxG0vwz92etX6nJHWaoFQgeH23tksz+9I=; b=3XdKnYQoqIuNvgMlmzI6gSHXXZ
        C+FtxOVpfAGNXPPp4bhCWWBgbnmVuTJWEmiUXL7bIJIqA6kSCgnIggDZYeqATtnlnIq3KMNeHxCYn
        vD815WIdiwiaSnsMIU60PueXZBC9bIhPXmsq5RLzi1z0jURLPdUrdSTsYFtVvQUJH6LRYEx9y+xBk
        jV0hAwPL1tPEB/sfaqp2vpm5cZa4Lb3HOPecm7vxhZ+eBV8nUUaOvpNkBmWy6NZ8rLNYIMDDqCrev
        hKCW6iTVLrK8cH9IrFeoQGwqSA6Hh/8pBYOHjVq1Oyt78vFXLgIiWQN/MMM49Paaq+6r3m9G+Jtr7
        Ma29KFRw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6bQU-002lqs-1K;
        Tue, 06 Jun 2023 18:29:02 +0000
Date:   Tue, 6 Jun 2023 11:29:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 4/5] libkmod: Keep track of in-kernel compression support
Message-ID: <ZH967oybKMDMPsNt@bombadil.infradead.org>
References: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
 <20230601224001.23397-5-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601224001.23397-5-lucas.de.marchi@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 01, 2023 at 03:40:00PM -0700, Lucas De Marchi wrote:
> When creating the context, read /sys/kernel/compression to check what's
> the compression type supported by the kernel. This will later be used
> when loading modules to check if the decompression step has to happen in
> userspace or if it can be delegated to the kernel.
> 
> Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
