Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FE0C43334
	for <linux-modules@archiver.kernel.org>; Mon, 11 Jul 2022 20:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiGKUC6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 11 Jul 2022 16:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiGKUC4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 11 Jul 2022 16:02:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D16C45F69
        for <linux-modules@vger.kernel.org>; Mon, 11 Jul 2022 13:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2901D615E9
        for <linux-modules@vger.kernel.org>; Mon, 11 Jul 2022 20:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83359C34115;
        Mon, 11 Jul 2022 20:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657569775;
        bh=kRdW7hkywXO+vOz5XEoww4FCXZDivTrHgpI1RLqgCn0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z738+XkoSLyB9PZO2tCnbYjECeeSyCuxlAU7DpsiuDPy/FnW63bdJzLX08cp2TTGK
         2L9td6gvQmaAwtQs/S7rADXzTrFg8Gpx4Exbj4tvPk3V2+v8JvD4ID0Hz9a9BnCfRK
         5lkORUNoKzL1uGLRqsxqobBv6wdufb2wYo6ZinpamQFoplFOn4ClnuLrXK1QmKJSqI
         kQiBS12a0Hj0qwYkd79UKDjPVHidhLE2K6qlI+aMxUaL4sPY4Mog1JwTsyvzhhX4s7
         GHpn4+1Xjx/L1VlMVY5X/fBT9lFsF5w64LvV8NFYWEAB+PbBR0TnsHh+6nMDt0PLlf
         jGqQ2I+AQSpUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F39EE4521F;
        Mon, 11 Jul 2022 20:02:55 +0000 (UTC)
Subject: Re: [GIT PULL] Modules fixes for v5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YsxkpIjGs7YwdIai@bombadil.infradead.org>
References: <YsxkpIjGs7YwdIai@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-modules.vger.kernel.org>
X-PR-Tracked-Message-Id: <YsxkpIjGs7YwdIai@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-5.19-rc7
X-PR-Tracked-Commit-Id: e69a66147d49506062cd837f3b230ee3e98102ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5374396e5de0402822bce4945c886d2a2962a40
Message-Id: <165756977544.22959.3460302847665260417.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Jul 2022 20:02:55 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The pull request you sent on Mon, 11 Jul 2022 10:57:56 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5374396e5de0402822bce4945c886d2a2962a40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
