Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D6BC6FA8F
	for <linux-modules@archiver.kernel.org>; Tue, 29 Aug 2023 16:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbjH2QnA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Aug 2023 12:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbjH2Qmr (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Aug 2023 12:42:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0E619A
        for <linux-modules@vger.kernel.org>; Tue, 29 Aug 2023 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I6m4zEE7kIPs842TrSRVupT6Gxuw5hwNfl04THE23BY=; b=jIIovA6tLEJViK+2JMAPwiFHUM
        5KBhnejvqu6xRqrs7fWGQBV2HCjhccV+79gxXVLxvTOvlPw7N9E7LIdy//J33AS/PAaJmPkWRtYnM
        BfVilpHFkfcBk2k4HVgstx7WH3Imv6bVGVDT8/OpJnM95rq00THXypj26AVZXDdHrJjyOcTnln4lQ
        byezS6QHS2K8mAt++gOplAn2uvZ+OND7MbAwLUAYd/sSJ9Xlv9PUYaYpX0rhQH4mwB6fHUACCLhzs
        MRQqpeJu6R5FVeuTzXLlFNaYue8maCpdFIsZHXnIIr5UxcxGJ6EzaTzquIYxMRVUnTQhbh8gDGL/7
        7AAZdEqA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qb1nf-00Bs14-0O;
        Tue, 29 Aug 2023 16:42:43 +0000
Date:   Tue, 29 Aug 2023 09:42:43 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] libkmod: allow to fallback to user-space decompression
Message-ID: <ZO4gA5mhGK1nN54Q@bombadil.infradead.org>
References: <20230829123808.325202-1-andrea.righi@canonical.com>
 <yxq5obi4rh2k54xw3fm6mtg36gmvluophe7slmc352wwccak27@2azm6bid2l5r>
 <ZO4NbbE8SvVkzN6R@righiandr-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO4NbbE8SvVkzN6R@righiandr-XPS-13-7390>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Aug 29, 2023 at 05:23:25PM +0200, Andrea Righi wrote:
> For the records, I've also sent this patch to address the issue from a
> kernel perspective:
> https://lore.kernel.org/lkml/20230829120508.317611-1-andrea.righi@canonical.com/T/#u
> 
> That seems to solve the issue in my particular case, but I'm not sure if
> that's a valid solution across all architectures.

I can't think of a reason why it would regress on other architectures.
We'll give it a spin soon fast as it will be on its way to Linus today.

  Luis
