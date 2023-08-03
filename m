Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15786C001DF
	for <linux-modules@archiver.kernel.org>; Thu,  3 Aug 2023 20:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjHCUno (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 3 Aug 2023 16:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjHCUnn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 3 Aug 2023 16:43:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE9F359E
        for <linux-modules@vger.kernel.org>; Thu,  3 Aug 2023 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oXhBOzNpj3Yw3I8gI2TE/Xatubr7AEiYckYw/Jxi7iA=; b=x//V1eKoEkzxYjcsHs/9ydz17r
        M6xzV79SVuld+5q01dcPtJYL9GUlnPUc9Qp2jOtmC1ryCiruP73fR3vhVWQy5ipe/7AZgELRGs8wV
        0ektRUkNV+RfvxBktpB24McbfJzbcEUmDTdCA6wG3YCNp+bYVB6Ayz3yupUUdmhJlh/FnEbZhGsuH
        mcJ2viwyE7fpyut6vyO+0o/gdkVYnN8AcOPxLX7py0wPnyz4b1Eb0zv9DcarBCQ7798LXfvJ1YvbW
        +TjsxD4I2dwopNowkGjqpoQX0RYXktEw77N8Ydg1C2mTHkcmNwGUg70fEHV0gny27Y1Lk6yJPNCq4
        Rdsuy0mw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qRfAZ-00Aqn4-2F;
        Thu, 03 Aug 2023 20:43:39 +0000
Date:   Thu, 3 Aug 2023 13:43:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     James Morse <james.morse@arm.com>, linux-modules@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Adam Johnston <adam.johnston@arm.com>
Subject: Re: [PATCH 0/3] ARM/arm64: Fix loading of modules with an exit
 section
Message-ID: <ZMwRezKXKye1bsSN@bombadil.infradead.org>
References: <20230801145409.8935-1-james.morse@arm.com>
 <ZMk9g/muvx66HOj4@bombadil.infradead.org>
 <4f9af3c3-bafa-c536-22a0-86d427049eb3@arm.com>
 <ZMt/VgQoovUDi4g7@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMt/VgQoovUDi4g7@shell.armlinux.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Aug 03, 2023 at 11:20:06AM +0100, Russell King (Oracle) wrote:
> On Wed, Aug 02, 2023 at 05:28:10PM +0100, James Morse wrote:
> > If Russell agrees the problem exists on 32bit arm, then I think it
> > would be best to keep these three together - going via the modules
> > tree would make the most sense.
> 
> The thing about PLTs is that it's something I've never had the need to
> make use of - because I've never been in the situation where the
> arm32 module space has been close to overflowing. The addition of PLT
> support for 32-bit arm did make my eyebrows raise for this very reason,
> but I guess there are a small number of people who want to use really
> large modules.
> 
> As such, I couldn't say whether it's broken or not - but it seems
> sensible to keep both the 64-bit and 32-bit code tracking each other.

Alrighty, merged and pushed onto modules-next.

  Luis
