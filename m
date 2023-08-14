Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1126DC04FE1
	for <linux-modules@archiver.kernel.org>; Mon, 14 Aug 2023 12:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjHNMIl (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 14 Aug 2023 08:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjHNMIi (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 14 Aug 2023 08:08:38 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F6E1717
        for <linux-modules@vger.kernel.org>; Mon, 14 Aug 2023 05:08:27 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1bbb34b0abaso85104545ad.1
        for <linux-modules@vger.kernel.org>; Mon, 14 Aug 2023 05:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014907; x=1692619707;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJNRfP8cUatIsJc6YU7EUPAo/O9QZ6sb5iejP2DNk7g=;
        b=Q+73K7gorAQg6xEBR61MBRbNou1JNSqWtKkdJ0QCX4nwGgR1w6CxOXdtzqQNIijxqD
         GBQjH1bAfr1UBCu1jO7F+gGMj9GwtM2E+0JeU3BEneCgBBu1DHLT+Cy3OMQ/Z94Zv2/N
         r0se0gLXwE+qwwSrKcS0FPvIj1x7iWtxaE7OWfgC+cVm5N7r85mHZ++MJuPe0ayRv+FP
         vgFhnOoxPEs98NZ2Oh/zcE8//jDGBbuefg61xf9bcEkajXj5+QGPTiu0Rg+ESwSqxxJs
         rEX1f0V8IgsLIXBoAONziVhiKNQJIe6uhg8c+wuXi6Rj6AS6q1BQkKJYY8Ghuc6xwhwi
         7uPg==
X-Gm-Message-State: AOJu0YwBrOAgK7woxsiMlP3z9qTzcdx6tLK3T7Bmdamp5tMG1+GtnUxL
        7VX2AJT8ECR/FGFt4sKQupK5k70PgTbDSUIMChrkSFvOQbGg
X-Google-Smtp-Source: AGHT+IGfcIkUiHrqX6S1IiQDnpfA7pI0z5lomwAUYnqquL64y/gfrx5YhhnnQ+4btgQR6c0hoTwQIEUozbHJHcQ6cTPptARUW4Gu
MIME-Version: 1.0
X-Received: by 2002:a17:902:c94b:b0:1b8:97ed:a437 with SMTP id
 i11-20020a170902c94b00b001b897eda437mr4164664pla.4.1692014907452; Mon, 14 Aug
 2023 05:08:27 -0700 (PDT)
Date:   Mon, 14 Aug 2023 05:08:27 -0700
In-Reply-To: <0000000000000e4cc105ff68937b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083735b0602e0eb7d@google.com>
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in init_module_from_file
From:   syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, chris@chrisdown.name, linan122@huawei.com,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nogikh@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

syzbot suspects this issue was fixed by commit:

commit f1962207150c8b602e980616f04b37ea4e64bb9f
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Jul 4 13:37:32 2023 +0000

    module: fix init_module_from_file() error handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17c80763a80000
start commit:   995b406c7e97 Merge tag 'csky-for-linus-6.5' of https://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f27fb02fc20d955
dashboard link: https://syzkaller.appspot.com/bug?extid=e3705186451a87fd93b8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12219fbf280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1278c8a4a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: module: fix init_module_from_file() error handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
