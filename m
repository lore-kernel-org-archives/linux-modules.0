Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751EDC433F5
	for <linux-modules@archiver.kernel.org>; Mon,  7 Mar 2022 21:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiCGVGm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiCGVGm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 7 Mar 2022 16:06:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8834E3A71D;
        Mon,  7 Mar 2022 13:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rTo6nVrAOSY9mQpf6gkXrAqeW6EuelOZe8YAKdbzzdk=; b=giPL96kQW4E0oVdG2l40h1z44m
        8e8+hQ1Q32s4lyjinCwi34CPZ0RnDe2mzqHrjfr1NYrtiAny0TTVQn3F56TK4tmVk7WFDgmNL32KR
        ppo4wvedT2T0o6r0trql04AQsWQ2YGj2QUlnsXAYZhaw5hP0xxz8RjuivtN0UjygyuI8Slpomegot
        BuTa43YIFetudh/NOOb2xhoYW0ceAN/2YewdqBtT2KWuyK3NRBIwwTAwZpN2bXnU29AE+eXIIwMeu
        knF5lX8hrQ1fw+8NeUSazrV6gbGyjnaumqUWgzM2rrFYHBHwbxf6yr32ZDVuxy+a+MbNzLnmWlMPx
        3tPHzJWA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRKXy-001ba7-Do; Mon, 07 Mar 2022 21:05:38 +0000
Date:   Mon, 7 Mar 2022 13:05:38 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     christophe.leroy@csgroup.eu, cl@linux.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        hch@infradead.org, pmladek@suse.com
Subject: Re: [PATCH v10 00/14] module: core code clean up
Message-ID: <YiZzotNHdKsvixLD@bombadil.infradead.org>
References: <20220307174509.2887714-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307174509.2887714-1-atomlin@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Mar 07, 2022 at 05:44:55PM +0000, Aaron Tomlin wrote:
> Hi Luis,
> 
> As per your suggestion [1], this is an attempt to refactor and split
> optional code out of core module support code into separate components.
> This version is based on Linus' commit 7993e65fdd0f ("Merge tag
> 'mtd/fixes-for-5.17-rc5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux").

Thanks! Pushed out to modules-testing to see what 0-day can find.
Further review from others is welcomed in the meantime. If no issues
are found, we also get kmod testing done, and more reviews, I can
push then later to modules-next for further testing on linux-next.

  Luis
