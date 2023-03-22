Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9053C74A5B
	for <linux-modules@archiver.kernel.org>; Wed, 22 Mar 2023 23:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCVXdP (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 22 Mar 2023 19:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjCVXdO (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 22 Mar 2023 19:33:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308381EFFB
        for <linux-modules@vger.kernel.org>; Wed, 22 Mar 2023 16:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Ay6mu3D3SXmMbb4vHiX/YPNK8iEGezCM/EVJg6pHPk=; b=dJUF8lQYcm7mF8b9K0AbPJc2NQ
        QCj+bUP9TtU+v03krBeePWaZTvkj5t6Kj95QkI0W5ZKfk0I4wIkOEsdJnypMptBTx2sXHm2SxL7LC
        xI0IFlq7d+8yvPO5zFUbX4p7/cNX2rLdj/TcJhgndZeiqIa2i9cPx/Ke68im9PAvx6MgSQJKJLhy2
        GJk+x6f8l+5HeV41Puf/fWv6HjTHqfg6FVc9BHra2lsiIUiunLMO/uIEaEqMrotx7Q0pyBShrVV1u
        UHvd1yuS1yzj4VitNSI2+850n6spqfJ9SFU0+Nyzlt3JKev54IDK6ZcDRyuYKL6LRP/qAauXc4Ikd
        b2ls88nA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pf7xB-0009Wi-2W;
        Wed, 22 Mar 2023 23:33:13 +0000
Date:   Wed, 22 Mar 2023 16:33:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Subject: Re: module_license tree refreshed against linux-next
Message-ID: <ZBuQOXi+my7bnXzR@bombadil.infradead.org>
References: <87mt46s8i3.fsf@esperi.org.uk>
 <ZBncDHaZfKEHAjGu@bombadil.infradead.org>
 <87r0tiqc6z.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0tiqc6z.fsf@esperi.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Mar 21, 2023 at 04:52:20PM +0000, Nick Alcock wrote:
> On 21 Mar 2023, Luis Chamberlain verbalised:
> 
> > On Tue, Mar 21, 2023 at 10:29:08AM +0000, Nick Alcock wrote:
> >> I have not dropped commits with Greg K-H as maintainer simply because I
> >> kept on oscillating on doing that, so I thought I'd leave the commits in
> >> so you have the option to do either.
> >
> > No, I don't want to do that work, please drop Greg's drivers.
> 
> OK! Repushed to the same branch, sans what I *think* is the relevant set:
> 
> binder: remove MODULE_LICENSE in non-modules
> serial: remove MODULE_LICENSE in non-modules
> vgacon: remove MODULE_LICENSE in non-modules
> tty: serial: imx: remove MODULE_LICENSE in non-modules
> tty: remove MODULE_LICENSE in non-modules
> 
> I hope that's right -- it's all the patches he was directly Cc:ed on.
> 
> (other branches containing kallmodsyms as a whole, etc, have not yet
> been refreshed at all and are old: I'll get to it).

OK I merged this set onto modules-next. Thanks.

  Luis
