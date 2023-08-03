Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706E1C04A6A
	for <linux-modules@archiver.kernel.org>; Thu,  3 Aug 2023 10:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjHCKW1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 3 Aug 2023 06:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbjHCKV1 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 3 Aug 2023 06:21:27 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE19049E9
        for <linux-modules@vger.kernel.org>; Thu,  3 Aug 2023 03:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YKCUWbLQ0BO4l7eNlaG2yqekoJxF3PKq2BjwfzmBuzc=; b=eHRpgcSx9mYKsaUOl3HEsRUuan
        oOYkzvqFP7gCxlTnQBqalwqluMVw41ornUtnBsdC9TTtUFqDdGcOc2Xzuc8uSe8rwrPPesDazgMX7
        fb/u6YuKXQVKmutCR1CDPW+WXY/Uyhd3dvEYP7vxhXorahOnoqSWymLY0rwN575ZpWD9Q64Ptnrmr
        8JNub324oR33aUBCtwMYIDqSJIzOG+7LEW58eFRgGfPjGm8ihvU9mPsgKnRm9KLrcQkPDszYYWJRH
        xSdB1cRGJ7hw4Mzljp4sczI+F3mf/i8JQfEsIWf5gJC4B8e8BkD/gdszvElxVa7k5lLPljxwEbDGe
        4R3TkVhg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54856)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qRVR8-0006jc-2G;
        Thu, 03 Aug 2023 11:20:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qRVR8-0002pX-Kb; Thu, 03 Aug 2023 11:20:06 +0100
Date:   Thu, 3 Aug 2023 11:20:06 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     James Morse <james.morse@arm.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Adam Johnston <adam.johnston@arm.com>
Subject: Re: [PATCH 0/3] ARM/arm64: Fix loading of modules with an exit
 section
Message-ID: <ZMt/VgQoovUDi4g7@shell.armlinux.org.uk>
References: <20230801145409.8935-1-james.morse@arm.com>
 <ZMk9g/muvx66HOj4@bombadil.infradead.org>
 <4f9af3c3-bafa-c536-22a0-86d427049eb3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f9af3c3-bafa-c536-22a0-86d427049eb3@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Aug 02, 2023 at 05:28:10PM +0100, James Morse wrote:
> Hi Luis,
> 
> On 01/08/2023 18:14, Luis Chamberlain wrote:
> > On Tue, Aug 01, 2023 at 02:54:06PM +0000, James Morse wrote:
> >> Adam reports that Yocto can't load modules on arm64. This turns out to be due
> >> to the arch code disagreeing with the core code when it comes to the layout
> >> of the modules exit text, resulting in a shortage of PLTs and a bunch of
> >> warnings.
> >>
> >> arm and arm64 are unusual here as they are counting the PLTs based on the
> >> section name. This series exposes the helper that core code uses to decide
> >> the layout.
> >>
> >> I've been unable to reproduce the behaviour on 32bit - but it looks like
> >> its possible to reach the BUG_ON() in get_module_plt(). To test this, disable
> >> CONFIG_MODULE_UNLOAD, and try to load modules with relocations in their exit
> >> text.
> >>
> >> This series is based on v6.5-rc4, and can be retrieved from:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git arm64/modules/exit_sections/v1
> >>
> > 
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> Thanks!
> 
> 
> > Do you want this to go through the modules tree or do you want to take
> > this in your tree? Either way is fine by me, at this point there should
> > be no conflicts.
> 
> If Russell agrees the problem exists on 32bit arm, then I think it would be best to keep
> these three together - going via the modules tree would make the most sense.
> 
> This has been broken for a while, so it can wait for v6.6-rc1.
> I think the yocto folk plan to carry this out of tree until its in their chosen stable
> version.

The thing about PLTs is that it's something I've never had the need to
make use of - because I've never been in the situation where the
arm32 module space has been close to overflowing. The addition of PLT
support for 32-bit arm did make my eyebrows raise for this very reason,
but I guess there are a small number of people who want to use really
large modules.

As such, I couldn't say whether it's broken or not - but it seems
sensible to keep both the 64-bit and 32-bit code tracking each other.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
