Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B820CC61DA4
	for <linux-modules@archiver.kernel.org>; Wed, 15 Mar 2023 22:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCOWkg (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 15 Mar 2023 18:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjCOWke (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 15 Mar 2023 18:40:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3792828225
        for <linux-modules@vger.kernel.org>; Wed, 15 Mar 2023 15:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lh/fTH0IApa4rUjij2hKr4uEpS9VPGARS8cLZJTnHdc=; b=MjPMrn8HDaFHfwL+LcuQsHZULq
        Tg7rLfUs4HpcJDbU1IjQBCnHXah/kXya9bPWfI0z5BVEeQb0ae5ioaCqSRNPhPyZ50VLix1vyJsYI
        ZS2eDm6ViAOG0K1VFdQMDh4nVcc7qjWkBOmLfqrMIc9V3lSRkqVvMJ/ssCmYb7diZ1ItVbmLqaQxe
        CIOBcupMgFmhUCt2pT28OtkwlzxnvBX+5wBB1mgWJnagG336qfpSJTINPMzLjVTbTObDXIzxvhI0V
        N/aiJy1Srkaomp7OqpvlVqWIWg/MZ4495dUPVK40E5i6z6SriFQ7yZ8hvwXqjwchtv09SM/VG5fSC
        78q2JQvg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcZnI-00Ed2h-0U;
        Wed, 15 Mar 2023 22:40:28 +0000
Date:   Wed, 15 Mar 2023 15:40:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: enhancing module info to allow grouping of firmwares
Message-ID: <ZBJJXJ4TzF4ZUmNL@bombadil.infradead.org>
References: <CAPM=9txaQfHkjs6nWcwBtnYQXtr996dyht7wasJ7QOovjepmAw@mail.gmail.com>
 <CADnq5_PdxFdvVwVnQ2n4vXXPYKe0ZOVYBPT0Kf+6aPuQLc960g@mail.gmail.com>
 <CAPM=9txGT2hFNAQbY8Fncz_zGr0nNeQ4KbN_s=D0XXueCtDmLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9txGT2hFNAQbY8Fncz_zGr0nNeQ4KbN_s=D0XXueCtDmLQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 16, 2023 at 07:18:11AM +1000, Dave Airlie wrote:
> MODULE_FIRMWARE_GROUP("g1")
> MODULE_FIRMWARE("fwv1.bin")
> MODULE_FIRMWARE("fwv2.bin")
> MODULE_FIRMWARE_GROUP_END("g2")

The way module namespaces were implemented could be used to leverage
something like this, just that you'd use it for firmware tags, not
symbols.

drivers/dma-buf/dma-buf.c:EXPORT_SYMBOL_NS_GPL(dma_buf_export, DMA_BUF);

Just that that would look like something like this, which might be
even nicer:

MODULE_FIRMWARE_GROUP("fwv1.bin", "nvidia/g1");
MODULE_FIRMWARE_GROUP("fwv2.bin", "nvidia/g1");

  Luis
