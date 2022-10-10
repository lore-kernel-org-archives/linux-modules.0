Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC82DC433F5
	for <linux-modules@archiver.kernel.org>; Mon, 10 Oct 2022 20:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJJUF2 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJJUFJ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 10 Oct 2022 16:05:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEE57657
        for <linux-modules@vger.kernel.org>; Mon, 10 Oct 2022 13:05:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D0EF6CE13AE
        for <linux-modules@vger.kernel.org>; Mon, 10 Oct 2022 20:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 264B7C433C1;
        Mon, 10 Oct 2022 20:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665432305;
        bh=4npCgcpsH4kvJeNcsw1ZHvQy175qDBfVQnPaCQQzNPM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HGIPMJ9MAWvdMK8zwnhORDpqwQBPZqvuxJxSUPdiHwtJVcra+nb7aGSaOBTVAs+Tb
         Bo84XcrfJyDtYoqSMnI1YWnJVwmB+X56n/3TYUIe/+QAfOVYemfe2K0DmUeZBcZXN8
         brlkhKzsdVAhPdphSaKtjyAA/eqmBCtSk2fdDAxz21ZglJuxypB2QmVaNT9e9X+4sQ
         Q25/qoHUYbkTXa0WE40P5OnQH2GrXbWTS1lZJNc//lCBgbbJ2RJ1VzHqrL+SFzvIGV
         dgQr54BEDO8tHUYSJlFQ5zJPmN7TyFtu/WHSAWxNsTzPxI8EEejoIlroX8Kk8CqSdJ
         IFsqjfsEEr7/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E590E43EFE;
        Mon, 10 Oct 2022 20:05:05 +0000 (UTC)
Subject: Re: [GIT PULL] Modules updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yz9upiun+Y4FUMbV@bombadil.infradead.org>
References: <Yz9upiun+Y4FUMbV@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-modules.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yz9upiun+Y4FUMbV@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.1-rc1
X-PR-Tracked-Commit-Id: 77d6354bd422c8a451ef7d2235322dbf33e7427b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 385f4a10191d95f40b5af72097df06e70f85d69a
Message-Id: <166543230504.6988.1762606705467812135.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 20:05:05 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ddiss@suse.de,
        Aaron Tomlin <atomlin@redhat.com>, Song Liu <song@kernel.org>,
        linux-modules@vger.kernel.org, mcgrof@kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The pull request you sent on Thu, 6 Oct 2022 17:11:18 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/385f4a10191d95f40b5af72097df06e70f85d69a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
