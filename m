Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B12C43334
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 15:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245331AbiFCPJW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Jun 2022 11:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiFCPJV (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Jun 2022 11:09:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D839B91
        for <linux-modules@vger.kernel.org>; Fri,  3 Jun 2022 08:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LYEniF+b/qO2ght9y6nzEPEY4PGpxkeHQMF/6YxuUQo=; b=TXZ/tNAcmjV41zrwvdfLNCwHCH
        bpFDw/F75H0N9b3/YWebHFr7R/DL/hHXxAAPpHrCPPYD4OkGCgrGMROcHL8mFQPy6qxzspZHGcTvk
        Ycp+Ff8JBLzBr56tsiE9RS4HODgZfh1W1kYJldo+qCraAILRFsTlUE2BMsfiwlatWzXvGK8GlVtLs
        cNl4VeVV7PWcuCMFKQPoemQjCT5YZse40q/irJ+osHSeGKifLsWIKcKtVvS+0lQaq+mvRpwUpkpJG
        9ExkKezLDfDB1Rr/Y7+CaUDpxwxkfgLbq+Wk57wqEI3PXQWXyQYnSWt+Ctg9bGN5Ju7MOEK5SyY4g
        Fllt6P7g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx8vN-007wbB-Ej; Fri, 03 Jun 2022 15:09:17 +0000
Date:   Fri, 3 Jun 2022 08:09:17 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Leslie Rhorer <lesrhorer@att.net>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: Module failure on new install of Debian Bullseye
Message-ID: <YpokHQKUPCG4L2Ar@bombadil.infradead.org>
References: <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0.ref@att.net>
 <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0@att.net>
 <7999b7b4-3b58-a9c4-4756-445e54404f0f@csgroup.eu>
 <ba2fb3ff-22dd-d68e-fa99-02de39240f20@infradead.org>
 <3b8f2ed6-11fd-b5a7-5442-7cac90348514@att.net>
 <8de4e4b7-f741-eb4d-9e11-9b23ba65c21a@att.net>
 <13529cf4-a00d-5e59-2e1c-cb1daf24bf71@csgroup.eu>
 <3643b14f-5240-59b1-d442-09e528d228b3@att.net>
 <a3973eea-510a-7091-4760-378b3ff7b0f1@att.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3973eea-510a-7091-4760-378b3ff7b0f1@att.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 02, 2022 at 11:00:00PM -0500, Leslie Rhorer wrote:
> 	I may have a valid module ready to load copied from an archive of the
> kernel I am using on this system.  I have placed it in

Huh? You should not be copying around modules loosely from other
kernels.

> /lib/modules/5.10.0-13-amd64/kernel/drivers/net/ethernet/bnx2x/
> 
> 	How do I proceed with attempting to load the driver?  Is there some way I
> can insure the system will still boot with the existing LAN intact? It looks
> like the system may try to eliminate the 1G interface when a module for the
> 10G exists, whether the 10G is working or not.

Sounds like you want to engage with the bnx2x developers and report
whatever it is you are seeing. But note, you should probably try a
more recent kernel.

./scripts/get_maintainer.pl -f drivers/net/ethernet/broadcom/bnx2x/
Ariel Elior <aelior@marvell.com> (supporter:BROADCOM BNX2X 10 GIGABIT ETHERNET DRIVER)
Sudarsana Kalluru <skalluru@marvell.com> (supporter:BROADCOM BNX2X 10 GIGABIT ETHERNET DRIVER)
Manish Chopra <manishc@marvell.com> (supporter:BROADCOM BNX2X 10 GIGABIT ETHERNET DRIVER)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
netdev@vger.kernel.org (open list:BROADCOM BNX2X 10 GIGABIT ETHERNET DRIVER)
linux-kernel@vger.kernel.org (open list)

  Luis
