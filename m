Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13064C04A6A
	for <linux-modules@archiver.kernel.org>; Sun, 13 Aug 2023 13:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjHMNia (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 13 Aug 2023 09:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjHMNi2 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 13 Aug 2023 09:38:28 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0EE1717
        for <linux-modules@vger.kernel.org>; Sun, 13 Aug 2023 06:38:30 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-686baf1c2fbso4403788b3a.0
        for <linux-modules@vger.kernel.org>; Sun, 13 Aug 2023 06:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691933909; x=1692538709;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=neJnpZX6yQ9QkvvT9QAkP8Ws3ecBujJ1QULkPMiV29E=;
        b=WHF7/JE25XtxlGXxS+W7eI8ZU+/a6LgWViBt+2Bpqldkum/p1iQNHe/t4ECR0aSZWq
         7QL0FpiYsXSBvYrDgW1rxXbMEAa6t9CbT5XDbr+vkjJx6Z922OXnIBakbCjhfnQ7BFGv
         Yj3g9+PcZejXTJqPbBAPNfE84CBdIIn9/xKC1WW1l2ZGNOUE3jBcW9YxY+BRrxO3YEXn
         AWU9vdwmEkNwYC++K4vt+HT5uVvNYtzI3Lgu3W7jjlb8sgI/AXNVrgFwlEXi3U1itsEo
         gqv/Cu6I2ilaK+RXheZHL66Z0SPlSb3BSoniuKZnn5RDcS2eGUgwMY+AlRlyetPM0g4Q
         OT/A==
X-Gm-Message-State: AOJu0YywNPLyxVNQkM3ZIYul2ggFcxPrvFCbP3NOPxa29jG3xkUdijgA
        PywO78JyppshB+HQZjLIkQbqB6frnU+nyJIx/ZRFfvA1OMpn
X-Google-Smtp-Source: AGHT+IFvUtqXr76zu2wT3itQvPjtzRoxdBW7cC6qINSUywu2YLhPJ1DCvGf+u/vcRaSITgKK9wNgpHfjYiUe7vo70HM9pGod+tZJ
MIME-Version: 1.0
X-Received: by 2002:a17:902:d4c4:b0:1bb:a78c:7a3e with SMTP id
 o4-20020a170902d4c400b001bba78c7a3emr2668812plg.3.1691933909651; Sun, 13 Aug
 2023 06:38:29 -0700 (PDT)
Date:   Sun, 13 Aug 2023 06:38:29 -0700
In-Reply-To: <00000000000094ac8b05ffae2bf2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab16cf0602ce0f9d@google.com>
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
From:   syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

syzbot suspects this issue was fixed by commit:

commit f1962207150c8b602e980616f04b37ea4e64bb9f
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Jul 4 13:37:32 2023 +0000

    module: fix init_module_from_file() error handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148a0a03a80000
start commit:   995b406c7e97 Merge tag 'csky-for-linus-6.5' of https://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=71a52faf60231bc7
dashboard link: https://syzkaller.appspot.com/bug?extid=9e4e94a2689427009d35
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d6670ca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103be50b280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: module: fix init_module_from_file() error handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
