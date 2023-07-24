Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB77EB64DD
	for <linux-modules@archiver.kernel.org>; Mon, 24 Jul 2023 21:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGXVlr (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 24 Jul 2023 17:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjGXVlk (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 24 Jul 2023 17:41:40 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87159120
        for <linux-modules@vger.kernel.org>; Mon, 24 Jul 2023 14:41:37 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-187959a901eso9503716fac.0
        for <linux-modules@vger.kernel.org>; Mon, 24 Jul 2023 14:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234896; x=1690839696;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=di6kLt4kiOi9HIX9Zl3sHUse4426YeJyuKx98IZXml0=;
        b=D35pxNa+1hknr2T+X39ehgHloLtVYfLXN5UDA/IpeUMX30eVbYRPryZvIxCvNoDTcE
         klysp4Yqo7aft27Vlqd8TYv5VxNhS3M4ymSUb65g7tm4zZ1SUJT9P1Xgsrcrb//JBuKQ
         9e8onxxzCOUmlgdjq6OZLfWnc7P+8IqR69WG7WIW7JlsW65koddgqPZwEiubNT7P910P
         zc8x3Fdr5bf/HM2Lf9qhklfL/pgdklsSwCLm1SqX4bvN5zPz4vFyGJMfgKYHnNExeWJS
         VQfpt+RddnJTWgk7KDEriC4iF/LJd1IUXS/kJT64RD7IKCVraCQKvczJhECRnoiPdDFi
         Burg==
X-Gm-Message-State: ABy/qLakz7M6w+NPfVSY8rN0R7LuymR2r9MBG4GCTXMZRQ86yZLmTrnD
        CfzqCwK0PsSsPs/Y7PmlaXl340Lb14aA8Tr66qKZ0+rcxQMW
X-Google-Smtp-Source: APBJJlEHgKxbiRqzAo1p5ExJxSaFpMdx4xL8bTDt7lWT7iVoKpAvcWJPdTYgcDdzSeBNd2JY6Wg309G2oeLjLyHxKN+KQCnnhWMe
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c7af:b0:1bb:470c:901c with SMTP id
 dy47-20020a056870c7af00b001bb470c901cmr7990684oab.7.1690234896203; Mon, 24
 Jul 2023 14:41:36 -0700 (PDT)
Date:   Mon, 24 Jul 2023 14:41:36 -0700
In-Reply-To: <ZL7fogwmV+JJcrVN@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009347d50601427a92@google.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com

Tested on:

commit:         910e230d samples/hw_breakpoint: Fix kernel BUG 'invali..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=156bed06a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d182f762168e165e
dashboard link: https://syzkaller.appspot.com/bug?extid=9e4e94a2689427009d35
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
