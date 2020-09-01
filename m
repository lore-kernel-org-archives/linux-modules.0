Return-Path: <SRS0=uSYI=CK=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DB5C43461
	for <linux-modules@archiver.kernel.org>; Tue,  1 Sep 2020 12:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E1F206CD
	for <linux-modules@archiver.kernel.org>; Tue,  1 Sep 2020 12:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598964819;
	bh=Brs+lf/R/MlJ1+x3HEKweM4D04wEiistdk5KzeF5Hws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kCQqwMUE0C3SQEwu5IsOvcQnbZCOVhVPvYrXHgdUHxRqKlhS0VDdVSMm9A7nujo+U
	 drakCZyrijNMOFnh+82rTdSEw1ozm0eE/fQhgGcKsHyM45x6RbeYn9VpecSghdX2+N
	 nkY+bK9gLsSuzUA/z5IRE2cn1ZfaBM6833ryhrZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgIAMxi (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgIAMxX (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 1 Sep 2020 08:53:23 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 278AC206CD;
        Tue,  1 Sep 2020 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598964800;
        bh=Brs+lf/R/MlJ1+x3HEKweM4D04wEiistdk5KzeF5Hws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xWaccGebQYNPVTpdulBC8hZOTW0uBmMoi0pJPPEFEr89kFRJoUaHZLdE74AxrdKgG
         veEAnJhrlKIugbtWM5kjePWkLMsVvDpOUzTJJIEjGSBuMMXzkaWpWGEvs5S4iThjza
         hUaGOPujBCVLwunbV4UjbdFCSXqlqGkurdoRaQqI=
Date:   Tue, 1 Sep 2020 13:53:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-modules@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [ARM64][GCC10] Kernel can't load any module due to RWX check
Message-ID: <20200901125316.GB3307@willie-the-truck>
References: <b3158cec-b722-cbe8-5a82-47890a227da4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3158cec-b722-cbe8-5a82-47890a227da4@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat, Aug 29, 2020 at 03:44:37PM +0800, Qu Wenruo wrote:
> Recently built a v5.9-rc2 kernel, it boots fine, but unable to load any
> kernel module.
> 
> After some debugging, it shows that it's due to RWX check failure:
> 
>   load_module: start
>   module_enforce_rwx_sections: index=22 sh_flags=0x7 shf_wx=0x5
>   layout_and_allocate: module enforce rwx sections
>   load_module: failed to alloc layout and allocate
>   load_module: end

May well be related to:

https://lore.kernel.org/r/20200831094651.GA16385@linux-8ccs

Will
