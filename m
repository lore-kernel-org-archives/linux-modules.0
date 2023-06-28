Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35148EB64DC
	for <linux-modules@archiver.kernel.org>; Wed, 28 Jun 2023 23:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjF1XP4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 28 Jun 2023 19:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjF1XPy (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 28 Jun 2023 19:15:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F8199B
        for <linux-modules@vger.kernel.org>; Wed, 28 Jun 2023 16:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2421861490
        for <linux-modules@vger.kernel.org>; Wed, 28 Jun 2023 23:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FE6FC433C8;
        Wed, 28 Jun 2023 23:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687994152;
        bh=tVju4l6hvpkP77pkawz8GIGW47X3o2xDRDQhbJhma0c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YomwYr076lWgTRTYcdyptvi60NJIDlfNKvqp8cPAlRxdVHquS5xVCge/QFlR0du98
         PkNGBuOp44UnB0GErHJxaSxgsANTka+/8msoIRhKTviLV7U6qQFg59R2XV7gCQ5cNB
         USNo9YAOu+drtsCDG1bpt0XeshyHP/td5bKDHQZ3DFUJBCnz99Kwjyi8TLbROgHatO
         72An7SAUtB6Bln5M+BFk/GVpOYx+fjB09LjbreAqPLY+c5kfyS2QMAPxYQlHe6NVjn
         cVEnIXooeAB6A6aJPZT75gbXyEiTNyZ6maX7e3rUnCoWlK5DHO0WjQIgnV5g+oJxYu
         kkpY7kDggjfVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C38EC0C40E;
        Wed, 28 Jun 2023 23:15:52 +0000 (UTC)
Subject: Re: [GIT PULL] Modules for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJx/0HbObiC9kMAH@bombadil.infradead.org>
References: <ZJx/0HbObiC9kMAH@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-modules.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJx/0HbObiC9kMAH@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/v6.5-rc1-modules-next
X-PR-Tracked-Commit-Id: 0eeaf1eb40a34fddd1d568a9b32c3d6669238743
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e3c09e95499e83dafc93860d56070a76d20e830
Message-Id: <168799415243.32317.7017040340370031131.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 23:15:52 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-modules@vger.kernel.org, maninder1.s@samsung.com,
        thunder.leizhen@huawei.com, onkarnath.1@samsung.com,
        keescook@chromium.org, arnd@arndb.de, bigeasy@linutronix.de,
        mcgrof@kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The pull request you sent on Wed, 28 Jun 2023 11:45:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/v6.5-rc1-modules-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e3c09e95499e83dafc93860d56070a76d20e830

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
