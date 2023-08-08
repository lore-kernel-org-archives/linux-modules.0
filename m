Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6B5C001B0
	for <linux-modules@archiver.kernel.org>; Tue,  8 Aug 2023 17:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjHHRRK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjHHRQg (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Aug 2023 13:16:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15871D446
        for <linux-modules@vger.kernel.org>; Tue,  8 Aug 2023 09:06:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so88135e9.0
        for <linux-modules@vger.kernel.org>; Tue, 08 Aug 2023 09:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691510792; x=1692115592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=en4BANwXReNJdtVv23CMrzP6JO/+20SEX8H3hOTpv5o=;
        b=myWSq4lPvBKhbe4+zSbtARG2ka8adzgpdxrGR/PkL7IS+S1OubWLaJ3PjZLNvhJy5F
         Xxx8J5Do9SX4jKy9jMtYoXQrT2tMTOGGb6tx6htlzAflRvPrEIFTF/Rmk7QkwR5YHGVz
         JdV8msNkCSWWUevTqzOhoHQTZQ8lZPprWLFxllO+tDH/UFYWNkyGoBNXkX3fHO4R3QoI
         UPXOREvlo7HlTAfGM9pYpPVCmPupS5fK7rQia78bAJZZd9jL9iiHNDB6uwYHKN2q2Ybo
         9cJPjGl9yg5d/Rgfc2HxZcto8aGFRA7PmIARN2MFk+wkNjx0zxZ4fN/yRC31aiKkjhas
         6gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510792; x=1692115592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=en4BANwXReNJdtVv23CMrzP6JO/+20SEX8H3hOTpv5o=;
        b=IyPF+rMeoswsi87hu+BmUxSHQvt9n1zjMra/zqMEZ6YGuw4p6qVrRju8Bbl3gCgHv3
         GiEykWJkFMPpe8pEQ9/ItVHSVQCNVLUb6Qof+zZI6kyglXVQM9iedcdVCn6VtRGgugFh
         yWCWWs+HEMzaFI6RQD0Ge54x9UmfG1fQa2BFHWc7vUgmdmuUMtPRxPq+Vy2XiskF2rps
         zlYlyjOEJ2eT7v2yZX1FfikD70pQHb7pFL0Jyqs+YsS59cS9pmci+yEiRuPPu1UaDYPZ
         bJ655AMMjcGU46hnNOKvTzC6XIdVMF/WeCSpLJ6c+cKpq8z2no6zbM/JeKdtTV/7tDMk
         Nxsg==
X-Gm-Message-State: AOJu0Yyz2UV0h00wSVi44gafYtj2p/6S6m5DWzLhIlrBLewwqGjDZYIZ
        kpuPm94t7cjONybsin8vyS/+hULhNpEP2XbqEFvEGw==
X-Google-Smtp-Source: AGHT+IEyE8ErD7uTJxSl5pOL1gNwgH/rpoc3NrRUJbIX+CCqivojjSoogbdUBi8R44J+rqzNlPOm0e/5+oOFVS4Mew4=
X-Received: by 2002:a05:600c:6023:b0:3f1:70d1:21a6 with SMTP id
 az35-20020a05600c602300b003f170d121a6mr311208wmb.0.1691510792379; Tue, 08 Aug
 2023 09:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000e4cc105ff68937b@google.com> <000000000000166f9e06025c8139@google.com>
In-Reply-To: <000000000000166f9e06025c8139@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 8 Aug 2023 18:06:20 +0200
Message-ID: <CANp29Y7q49HBoV+_xD1wpztUGDu4ykEFb-2H-d71rZAkY=M67A@mail.gmail.com>
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in init_module_from_file
To:     syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
Cc:     bpf@vger.kernel.org, chris@chrisdown.name, linan122@huawei.com,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Aug 8, 2023 at 12:09=E2=80=AFAM syzbot
<syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 125bfc7cd750e68c99f1d446e2c22abea08c237f
> Author: Li Nan <linan122@huawei.com>
> Date:   Fri Jun 9 09:43:20 2023 +0000
>
>     md/raid10: fix the condition to call bio_end_io_acct()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15c26ba9a8=
0000
> start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.k=
e..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df5e1158c5b2f8=
3bb
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De3705186451a87f=
d93b8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12518548a80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D124ccf70a8000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: md/raid10: fix the condition to call bio_end_io_acct()

No, that's unrelated.

Most likely it's due to https://github.com/google/syzkaller/issues/4117
TL;DR: for bugs that only existed for a very short time syzbot is
having problems differentiating between revisions where the bug is not
yet introduced and where it's already fixed.

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
