Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F6AC001DB
	for <linux-modules@archiver.kernel.org>; Sun, 13 Aug 2023 16:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjHMQDl (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 13 Aug 2023 12:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjHMQDY (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 13 Aug 2023 12:03:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F38E2116
        for <linux-modules@vger.kernel.org>; Sun, 13 Aug 2023 09:02:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so9592123a12.0
        for <linux-modules@vger.kernel.org>; Sun, 13 Aug 2023 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691942549; x=1692547349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g5ugHtb+gFLqHmdHj/rIBNWAy0u9pV9CjmqakNJzIxY=;
        b=Oj0mSsS46jeV/oUT5MAXfcjss6McfNfiKYQrraiQMRL8sTJBw4d8L4S8yxi/lYj7/A
         7r3S5rxoqAmN6oWXyEodKqbZEwXf6+pND145SyK6r7I//24q0FiBkBdxVi4vJltOF7bT
         lO4vZDPaKABMHKqKaR3tn6kp7YpOPeVcnRgOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691942549; x=1692547349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5ugHtb+gFLqHmdHj/rIBNWAy0u9pV9CjmqakNJzIxY=;
        b=CjnjVL1657k45KFMLAfdy7f7IjPcEqCt3A663L18M9mvuphGY8poiOuGgPOc4cFe+N
         koF0lwD4bh9j7kADYg3QdAv4Qq70CiHqjzmbftKpLrrTfOfTD5b6Lk+yeTsfNDf/es3l
         54xyF3jBJuOjkEW1WMxj2nm00VWaBbpv41ANcaT452Apykplptw8jEZjO+sOuOmCgri5
         FrkDEDpqjdHc+3Hz1wTUI5B7IjwRenMiSKRUb08FHK0jruN15oDNhFNPwSd487HkdRao
         mDhTmi+dUeJkASQCzSo4XZ5Yzk8E3BgCFi8rqbUrvkw+dxw8A2sXQQp6ZSa7dPCSrW4S
         BZhg==
X-Gm-Message-State: AOJu0YzT3Oe0LWuxvd3GLNepjTRpu/duRvVo7FOr/NZf+4m8dMpFQ40a
        t7V89fANq1O5pXBecc7QSFyNSfZISEGqT1eJGlj2vl/N
X-Google-Smtp-Source: AGHT+IEJ2Q6XMmCAhi1Nl7q01K1vSc4C0JHzEbnsCKSmmAKseS50mZ17yIMkqFQSb4FNP9WPJnt14Q==
X-Received: by 2002:a05:6402:293:b0:523:e25:5656 with SMTP id l19-20020a056402029300b005230e255656mr8177546edv.5.1691942549514;
        Sun, 13 Aug 2023 09:02:29 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id h9-20020a50ed89000000b0052229d203a4sm4575622edr.36.2023.08.13.09.02.27
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 09:02:28 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so9592086a12.0
        for <linux-modules@vger.kernel.org>; Sun, 13 Aug 2023 09:02:27 -0700 (PDT)
X-Received: by 2002:aa7:c683:0:b0:523:3e27:caa7 with SMTP id
 n3-20020aa7c683000000b005233e27caa7mr6430259edq.20.1691942547533; Sun, 13 Aug
 2023 09:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000094ac8b05ffae2bf2@google.com> <000000000000ab16cf0602ce0f9d@google.com>
In-Reply-To: <000000000000ab16cf0602ce0f9d@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Aug 2023 09:02:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsitvsCyu0+Pu8Hdmzd6XaCjugktE5aQVjUbCRYgQU=Q@mail.gmail.com>
Message-ID: <CAHk-=wjsitvsCyu0+Pu8Hdmzd6XaCjugktE5aQVjUbCRYgQU=Q@mail.gmail.com>
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
To:     syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
Cc:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun, 13 Aug 2023 at 06:38, syzbot
<syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit f1962207150c
> ("module: fix init_module_from_file() error handling")
>
> dashboard link: https://syzkaller.appspot.com/bug?extid=9e4e94a2689427009d35

Looks right. Apparently syzkaller had two different bugs attributed to
this. It was already marked as fixing syzbot issue
x=9c2bdc9d24e4a7abe741

#syz fix: module: fix init_module_from_file() error handling

             Linus
