Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE7BC0015E
	for <linux-modules@archiver.kernel.org>; Fri,  7 Jul 2023 18:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjGGSlz (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 7 Jul 2023 14:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGGSlz (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 7 Jul 2023 14:41:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F7A1FD8
        for <linux-modules@vger.kernel.org>; Fri,  7 Jul 2023 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PMlx6JapGPAjsjJ641XTtidFI0B1sEa/zy+3jnNhN2w=; b=A8sVGtbGQzO/pi8pFTvrQjeAzf
        2aYuiS9EXvwc/gCLs5IlheN/ANzoLIoKMUSnFHRHlcK4yi2DU++Ylv8c14ZJ8v5OdxQrZK85+o6rV
        nBD+4F2TnURHyjrUYZL2j9lmCcPYekfwma6z5BlKZ9JBu9HZKk5+B/AxhYbfU4M6b5pzvH0mQO/DB
        6w7K0OfCZ24hc4RpBRs69yJV1heYC/csYHvkOvnWIxcOiY3rzjphonwTJPRyxQghxjym0d5eRmeKJ
        q88weq27aL8n9aZDe867FkUK3K2tjCa5ASPhxHUti6IYOj78R2roxJM4HN+heX2tuU5d6LHmOMDhl
        rNeFvgRg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHqOq-005RX9-2i;
        Fri, 07 Jul 2023 18:41:48 +0000
Date:   Fri, 7 Jul 2023 11:41:48 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dave Airlie <airlied@gmail.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH 2/2] modules/firmware: add a new option to denote a
 firmware group to choose one.
Message-ID: <ZKhcbBHqkEmGtU6I@bombadil.infradead.org>
References: <20230704025322.2623556-1-airlied@gmail.com>
 <20230704025322.2623556-3-airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704025322.2623556-3-airlied@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jul 04, 2023 at 12:50:50PM +1000, Dave Airlie wrote:
> From: Dave Airlie <airlied@redhat.com>
> 
> This adds two tags that will go into the module info.
> 
> The first denotes a group of firmwares, when that tag is present all
> MODULE_FIRMWARE lines between the tags will be ignored by new versions of
> dracut.
> 
> The second makes an explicitly ordered group of firmwares to search for
> inside a group setting. New dracut will pick the first available firmware
> from this to put in the initramfs.
> 
> Old dracut will just ignore these tags and fallback to installing all
> the firmwares.
> 
> The corresponding dracut code it at:
> https://github.com/dracutdevs/dracut/pull/2309
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Dave Airlie <airlied@redhat.com>

Lucas, did this end up working for you as well?

  Luis
