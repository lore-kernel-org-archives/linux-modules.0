Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6D3C00528
	for <linux-modules@archiver.kernel.org>; Tue,  1 Aug 2023 17:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjHAROw (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbjHAROt (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 1 Aug 2023 13:14:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AD61BCF
        for <linux-modules@vger.kernel.org>; Tue,  1 Aug 2023 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GLe6Dvw3VmciE4xi03HjUazMl82XCIQ73+LASqGRUBY=; b=MX3m8kxzjEx6vmln2AKPSp+jH1
        Fc/dyba/sz0R1UbdP5uPfEbMNt0ywmygCt37GYOPdluU9nLQfFdUBsvTqHXaYI1lYIu1RiJH6hNy+
        0vVh0Ga4H51Vu1MswGRxJvbQs/pf4l+CeJJ3vLGrPS/VhbN+//ievyWtYYJLXZVaPZSnnq0ry+/Nw
        LuiX8Q/DifLoDFoCWZxxF/JI+kF6ICZMHyG/M9k7XGtOmGIp79B6i4i52cH1Prk1y0DkSC8URD169
        edEM66EibqRcy007QM8ki1EnGIfD0QefVVog1pKU4CcFn0zPP+GK6ZtC4n1rzwa19clH5oPeEMn4A
        Hecp5dHg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQsxH-002tr4-34;
        Tue, 01 Aug 2023 17:14:43 +0000
Date:   Tue, 1 Aug 2023 10:14:43 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     linux-modules@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Adam Johnston <adam.johnston@arm.com>
Subject: Re: [PATCH 0/3] ARM/arm64: Fix loading of modules with an exit
 section
Message-ID: <ZMk9g/muvx66HOj4@bombadil.infradead.org>
References: <20230801145409.8935-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801145409.8935-1-james.morse@arm.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Aug 01, 2023 at 02:54:06PM +0000, James Morse wrote:
> Adam reports that Yocto can't load modules on arm64. This turns out to be due
> to the arch code disagreeing with the core code when it comes to the layout
> of the modules exit text, resulting in a shortage of PLTs and a bunch of
> warnings.
> 
> arm and arm64 are unusual here as they are counting the PLTs based on the
> section name. This series exposes the helper that core code uses to decide
> the layout.
> 
> I've been unable to reproduce the behaviour on 32bit - but it looks like
> its possible to reach the BUG_ON() in get_module_plt(). To test this, disable
> CONFIG_MODULE_UNLOAD, and try to load modules with relocations in their exit
> text.
> 
> This series is based on v6.5-rc4, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git arm64/modules/exit_sections/v1
> 

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Do you want this to go through the modules tree or do you want to take
this in your tree? Either way is fine by me, at this point there should
be no conflicts.

  Luis
