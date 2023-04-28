Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A24C7EE21
	for <linux-modules@archiver.kernel.org>; Fri, 28 Apr 2023 00:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344673AbjD1Abf (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 27 Apr 2023 20:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344651AbjD1Abc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 27 Apr 2023 20:31:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828C82711;
        Thu, 27 Apr 2023 17:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E21A6407F;
        Fri, 28 Apr 2023 00:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E78AC433D2;
        Fri, 28 Apr 2023 00:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682641890;
        bh=cicCvL2Y3dw3hewtVeMWVpcMwLGfqKYTwoCActhJm/E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KQ+GEbnu5P52IGrPwqps5BXeXLEYvMzWf+ptc2AIE4GTp8Cs32Mty7qRbGVFmkMH3
         GsCW27v4hOVjpv2pdcdOlD/eB3L7+55kd4aP7IfB8eFU5LWhNvzLY0gpjj7BHGBCG4
         fbmDEdqIPxGnd0d7i4wdhAS1+JmF1rmdvcVyftcQSRONhS4H0VKl2bABryjmdrJHuL
         PrfRgcfCwBOqX3SXa0LuEiJLpZ7F/L9BBi7oMtYrKIZpp+GEwt6HnrxbQYUeroiewA
         k1GJRD5KFzX4cFMwvbEPddK793rHv5Iq5SV1Tgfz5XZsSfTCHSwuviWAlhQikS/ILA
         EQsq4B3Sr35wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CBA5E5FFC8;
        Fri, 28 Apr 2023 00:31:30 +0000 (UTC)
Subject: Re: [GIT PULL] modules changes for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEbkqq1tvm1WHVHw@bombadil.infradead.org>
References: <ZEbkqq1tvm1WHVHw@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEbkqq1tvm1WHVHw@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.4-rc1
X-PR-Tracked-Commit-Id: 8660484ed1cf3261e89e0bad94c6395597e87599
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6a7828502dc769e1a5329027bc5048222fa210a
Message-Id: <168264189044.7031.17626089944290499041.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 00:31:30 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, arnd@arndb.de,
        bagasdotme@gmail.com, fmdefrancesco@gmail.com, jbaron@akamai.com,
        jiapeng.chong@linux.alibaba.com, jim.cromie@gmail.com,
        linux@weissschuh.net, mcgrof@kernel.org, nick.alcock@oracle.com,
        peterz@infradead.org, p.raghav@samsung.com, rdunlap@infradead.org,
        song@kernel.org, thunder.leizhen@huawei.com, trix@redhat.com,
        yangtiezhu@loongson.cn, jpoimboe@kernel.org,
        joe.lawrence@redhat.com, tglx@linutronix.de,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The pull request you sent on Mon, 24 Apr 2023 13:20:58 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6a7828502dc769e1a5329027bc5048222fa210a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
