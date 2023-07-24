Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8390CC0015E
	for <linux-modules@archiver.kernel.org>; Mon, 24 Jul 2023 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGXVS1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 24 Jul 2023 17:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjGXVS0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 24 Jul 2023 17:18:26 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC591722
        for <linux-modules@vger.kernel.org>; Mon, 24 Jul 2023 14:18:23 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b9d34de264so9418568a34.0
        for <linux-modules@vger.kernel.org>; Mon, 24 Jul 2023 14:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690233503; x=1690838303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fISgzzCd91Gj2U/gkz81qNRRRlc1K+b9y/Uqzybe3fQ=;
        b=CckEByuc7adqxzAJ6yrwaESr/g5tmhz2BKSW3tKsEC85BlUfA6mENVOP+acJljUjgu
         L3f93WLkfPAqskxx2GBaP+mbMLfnAftSsSW6kSBKKp0nrl74gOkpER8JPk3nqTPTnmji
         ADmn8BAvkTNGCS4qM6uFkUg8mPcl21VHdWF6+7i2eMMrVmFXQowzFGGNLuHdHn7gMLL+
         1whjo6eJuPr+OO0/iupcmpsV5qa1sf9VcxxGMCvWBDkusWpAvgvl9uypoc5cDQtpaF4n
         3HMb5XV6zJnXxlQ5hp0uHCR0dDAGzuhBNyBTL9ZKiU3r4x3VRaC+av259OfC6Ud0u4iW
         b3yw==
X-Gm-Message-State: ABy/qLaxDObthpoh55tE3hIrQno4c5QKuwuqyGNxu1cKrM6/pNQiOyxG
        zOpl2NoT7G6VKf5UwZfL605HCd6PTvvsWWgcDjoHKURYpuRn
X-Google-Smtp-Source: APBJJlHk6oTqxAMI0w9v9Q+HPlsKWKA/HtbUSkECk0SsualRSe5kQSUlByEONDF4yteCaaof/kh7pLqOuhIdzPmNrCyk5HqO1DGU
MIME-Version: 1.0
X-Received: by 2002:a9d:7488:0:b0:6b9:f343:acfd with SMTP id
 t8-20020a9d7488000000b006b9f343acfdmr9566732otk.5.1690233503160; Mon, 24 Jul
 2023 14:18:23 -0700 (PDT)
Date:   Mon, 24 Jul 2023 14:18:23 -0700
In-Reply-To: <ZL7fllo9Td1gJmHo@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b1f3e06014227e6@google.com>
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in init_module_from_file
From:   syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com

Tested on:

commit:         910e230d samples/hw_breakpoint: Fix kernel BUG 'invali..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11e83081a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34364e75687fa9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=e3705186451a87fd93b8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
