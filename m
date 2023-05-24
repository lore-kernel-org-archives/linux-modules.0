Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DCDC7EE23
	for <linux-modules@archiver.kernel.org>; Wed, 24 May 2023 05:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbjEXFYA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 24 May 2023 01:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjEXFX4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 24 May 2023 01:23:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF59813E
        for <linux-modules@vger.kernel.org>; Tue, 23 May 2023 22:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nsjH/HN6kj1/wt6b4rU56h+riV/Vd9LrpUUInLQr8Q8=; b=ja/wOQCwkCOi7tX1PU5L18SH/4
        Xu7/TW/1+PzNoHwPYkmOslHZumh/z23ULQhqP2iJ2kiTT/JolBWQm1zp5vdL2lH1n9l9ilhtM4VUg
        yKnytbLdH4NQzoraN+qxnKY4/U2I28fX/qc2QC5dqgxG+GOzAr2rRhy7RdPxw1/MgX1fGitE91snB
        /TJf4epWsx8zaNNsgfqk8Wao6xTRnAguA6jSSOqCUuSqb6gR3PcVuQ7EKoe5+FTkwbeKhxEIuSg1z
        9f881EaRf5NgWKkmpBHOEL+L2LZl4oL1SLf6AXrmrYqJ5slIK8DhbGjIHyGpecNN9AbcOuiNjBs/0
        Ak2aWRtg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1gyZ-00COl7-2Y;
        Wed, 24 May 2023 05:23:55 +0000
Date:   Tue, 23 May 2023 22:23:55 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-modules@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] module: Remove preempt_disable() from module reference
 counting.
Message-ID: <ZG2fazDXRzxT0R0W@bombadil.infradead.org>
References: <20230509134902.yQ-EWRpI@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509134902.yQ-EWRpI@linutronix.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, May 09, 2023 at 03:49:02PM +0200, Sebastian Andrzej Siewior wrote:
> The preempt_disable() section in module_put() was added in commit
>    e1783a240f491 ("module: Use this_cpu_xx to dynamically allocate counters")
> 
> while the per-CPU counter were switched to another API. The API requires
> that during the RMW operation the CPU remained the same.
> 
> This counting API was later replaced with atomic_t in commit
>    2f35c41f58a97 ("module: Replace module_ref with atomic_t refcnt")
> 
> Since this atomic_t replacement there is no need to keep preemption
> disabled while the reference counter is modified.
> 
> Remove preempt_disable() from module_put(), __module_get() and
> try_module_get().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks! Queued up onto modules-next.

  Luis
