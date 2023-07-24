Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED58EB64DD
	for <linux-modules@archiver.kernel.org>; Mon, 24 Jul 2023 19:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjGXTrt (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 24 Jul 2023 15:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjGXTrm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 24 Jul 2023 15:47:42 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2B4173B
        for <linux-modules@vger.kernel.org>; Mon, 24 Jul 2023 12:47:35 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-56777e4d2d5so8200002eaf.0
        for <linux-modules@vger.kernel.org>; Mon, 24 Jul 2023 12:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690228054; x=1690832854;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpU/pq4NcXq5eoCMak+87h/qMFbXrT3YYZv+5M6Z810=;
        b=d+N/9b3U2c4Isk7b/Z3bceDGXGEGPawIAOaTLERcRVsDhrW9D+73AD7N8Px5B/QLiL
         jHZdcoVD5cjmi1bZ1fuuNFSIls8gIyvkz1nxEUE7xrqMcOhOLlny/Uv1l8w9GzsXFjya
         NHBYzpE4IXpxbxmqFRqBO9fV+Nb6ODNuMNVHMb3bGF71cW+1JsYYyIQK30lw2WwP90bf
         538TG9zUcRNzsugkess/IpNIyJgIY/5/oOheDj/aX1pInO1GDvpzdAFaZ2FOjyS05nzF
         7BuEfBG+jI7+2H5wXIyZ8Y+jEjQoxGv9C/HA6E9vm2RD0EV3r3pJZgfNcuzYlPHfGz3c
         pGWw==
X-Gm-Message-State: ABy/qLbQ/8yehp+YABXHuyjZP6ktQyK3Ay+QlP+1tzIpU1qgRiZmWb5O
        KMjLCLc30r0J+eKdJkletetmOpUxL/YGh7AStXSkn9Cqp4rg
X-Google-Smtp-Source: APBJJlFhOkXgA1GDXy6ZXZyeXWFwikYSsd/PZ9QEgWnWucvf96IBK7XT0JXjTa9x+AGx3ADzu3aYiG7whxxn3I6COqeIsSFrzEVO
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1211:b0:38d:ca0a:8e18 with SMTP id
 a17-20020a056808121100b0038dca0a8e18mr20908707oil.2.1690228054801; Mon, 24
 Jul 2023 12:47:34 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:47:34 -0700
In-Reply-To: <ZL7UedKQUDAUThHM@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbc360060140e291@google.com>
Subject: Re: [syzbot] [modules?] WARNING in init_module_from_file
From:   syzbot <syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 910e230d5f1bb72c54532e94fbb1705095c7bab6: failed to run ["git" "checkout" "910e230d5f1bb72c54532e94fbb1705095c7bab6"]: exit status 128
fatal: reference is not a tree: 910e230d5f1bb72c54532e94fbb1705095c7bab6



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6
dashboard link: https://syzkaller.appspot.com/bug?extid=9c2bdc9d24e4a7abe741
compiler:       
userspace arch: arm64

Note: no patches were applied.
