Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3B5C00140
	for <linux-modules@archiver.kernel.org>; Mon,  8 Aug 2022 22:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244555AbiHHWhL (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 8 Aug 2022 18:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244565AbiHHWhG (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 8 Aug 2022 18:37:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7832B0
        for <linux-modules@vger.kernel.org>; Mon,  8 Aug 2022 15:37:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B232B810D5
        for <linux-modules@vger.kernel.org>; Mon,  8 Aug 2022 22:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 181D7C433C1;
        Mon,  8 Aug 2022 22:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659998223;
        bh=zH0nL1o6Z/99NMpgI0YM4OV4E7c+zQoR5ZrO8tMmEo4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sfyoHpgtiDfJS1sTnqASj4MZC6SDIs2SSwnbKp5bqyKJpMufwbLFGaVvYU68T/KSh
         58WNnQbrqKWGYNPhGORGeVLVYnLY2Lk4V8Y1efXbnWg0TjOhJCvKRB6/BSYd56l/TL
         ZUsmYuHW+YDk/IwP9bDAJhULm1fWhXijxS4uvyE+pC6GiLsIWCbIYwRGAvk5qxcq57
         e+uQosrMCAkICLBUYKLzq8Jjm0KYZgJidvc23ZTlieexPpu7oKsQ9sFtr1eKAk6wDy
         s30OFyHyrSRwj0ufDZ/ljlNpM6ij/6djYTnwxDDj1U8xf/U9n83AnqcS9vcU7z0CqD
         mN7O6+ZbzbjBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0674AC43140;
        Mon,  8 Aug 2022 22:37:03 +0000 (UTC)
Subject: Re: [GIT PULL] Modules updates for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvExYYWJY4HRi/NS@bombadil.infradead.org>
References: <YvExYYWJY4HRi/NS@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-modules.vger.kernel.org>
X-PR-Tracked-Message-Id: <YvExYYWJY4HRi/NS@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.0-rc1
X-PR-Tracked-Commit-Id: 554694ba120b87e39cf732ed632e6a0c52fafb7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e74acdf55da6649dd30be5b621a93b71cbe7f3f9
Message-Id: <165999822301.1400.8208683830483525322.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 22:37:03 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        fmdefrancesco@gmail.com, deller@gmx.de, yangyingliang@huawei.com,
        saravanak@google.com, mcgrof@kernel.org,
        linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The pull request you sent on Mon, 8 Aug 2022 08:53:05 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e74acdf55da6649dd30be5b621a93b71cbe7f3f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
