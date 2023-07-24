Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F243CC41513
	for <linux-modules@archiver.kernel.org>; Mon, 24 Jul 2023 19:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGXT4h (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 24 Jul 2023 15:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGXT4f (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 24 Jul 2023 15:56:35 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1D41712
        for <linux-modules@vger.kernel.org>; Mon, 24 Jul 2023 12:56:34 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b9e081b9f7so7460403a34.0
        for <linux-modules@vger.kernel.org>; Mon, 24 Jul 2023 12:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690228593; x=1690833393;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bqy++k90y41wMJfzlow3b+lCJ8ynuiD7DIqIylcfRDo=;
        b=BC3DCDnucw/UUymDglifOptcM0VTpppY1LhlBphJfCBp8Dak/gSK4lzLO2r4CI6B6U
         P900Yr8GOMSqHHgO2QpzoyCk7/JftPXEBfySdighBQ+nV1cXHf88vSWQJjqnyLQALaqj
         loGV2YVA7rdUzuKtJpDRVHVXdwoohO75MUANRWgdF9fMLocH5OrGV7jm6qnR4JHMJkw2
         +6rdu+G6K+YL0afZUua77y/LgJoo86vIUPyUoHe79QLXJKJWXpD7dGBzRKi50lIAv4hf
         cdXc9djOo/Cbdb6bZWTLGgekmWMDF8jH65HgOUW3ciG0zn/qQj46LdJvL1nyQ+7nNH48
         ALOQ==
X-Gm-Message-State: ABy/qLYHALtE6ZEGz/5qP+d9wZOh9qFIZbEwQWqsDCpaPDCQoPbl12Tq
        7OYha8ooyg8dotKoCSxPbPvkZYp8bCXQtY5jc2vYgD1CaaFH
X-Google-Smtp-Source: APBJJlHlWs+LFB7k3NIuMhWUm8QZfovlY8FvMe8cw31aYRNPGdP4kGfjP2cedYFiR+mvcbKKTWKUqWkzzDN0Hlb3tS+kAExpxT+o
MIME-Version: 1.0
X-Received: by 2002:a05:6870:76b3:b0:1bb:4279:4be9 with SMTP id
 dx51-20020a05687076b300b001bb42794be9mr7995398oab.3.1690228593707; Mon, 24
 Jul 2023 12:56:33 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:56:33 -0700
In-Reply-To: <ZL7U/V3SFaJndkhW@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ead1d006014102dc@google.com>
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
From:   syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
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
dashboard link: https://syzkaller.appspot.com/bug?extid=9e4e94a2689427009d35
compiler:       

Note: no patches were applied.
