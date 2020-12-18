Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF56C4361B
	for <linux-modules@archiver.kernel.org>; Fri, 18 Dec 2020 14:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6CE23AFD
	for <linux-modules@archiver.kernel.org>; Fri, 18 Dec 2020 14:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgLRO5X (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 18 Dec 2020 09:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgLRO5X (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 18 Dec 2020 09:57:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2763C0617B0
        for <linux-modules@vger.kernel.org>; Fri, 18 Dec 2020 06:56:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m12so6114404lfo.7
        for <linux-modules@vger.kernel.org>; Fri, 18 Dec 2020 06:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQwNLET180BDTG0josdbMtDfa1WyCkI91EyGHELK7i0=;
        b=KmBZvFhD1fcIikXMTyPkQWVqMVZ7Se+RdLHtRGUXF6E8E7ez6ICtOqBmO06rPydd5u
         +4Hez8ih4wxqlLd6gXMHoHTgLM8HAUEnLCZuJqGenA261LU4FGpcl+JsSP6St278VMVQ
         onDE3S7dnNlnFDYOESRfGvR86/Rg7XP32PpXxSXa/2+GNJPOkvoOvh9uUgDIyQEXagjm
         xF4xabQURbcWbIdEAEZ4R2920RHuHnu7Z6b2znyFGRsH6QzTVGMoapwdTDHv8g9Cq/co
         ZIcSjztCLk8WVT1nwcfObhD7gIaFo8Cr8NWc+Pl6/TacFMsO/uToFTQrNEEOkrdnvWlQ
         /IcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQwNLET180BDTG0josdbMtDfa1WyCkI91EyGHELK7i0=;
        b=dWXWxBvt9hVwwisWWeGQ6XhZO4T2eRFL+1rnY4T0SbQyEnqFPxBSWcqVyXBeYTbr/z
         7L9hvy3Yj6v0eUf9Ybq5+utpqmGwmgAYPjDlc2fROuWtbw8FfTSs6hsWEFM9OR8NhbIa
         MABtRxF19IOihhx+JVr71HkWNw/n2lZ55xs6jkzPiexanypUHMd9pkpkl2w9YxCwdMLJ
         H+NnY1/j8w0xHTn13ilTBOdt3vmwLsvzWhKLkZvsR/o1ibnOJNGKYFQEy+zxqXSu3gNo
         /NlaFc9/IZqVu/6KowNS0QMoAIxW9ZmjX3zjeo11uPmwzc8FeXs0kM16pwL+7Iis036v
         dIuw==
X-Gm-Message-State: AOAM531f5Q0dEpJiuP8QRpQCHvvYrN3LnF0GzuQUARQ4V+6XJ9kG+i3K
        QQ+CwCpZlm5v4tcAsHa3l2PEyege7HeDPN48ZG7herOTarA2CQ==
X-Google-Smtp-Source: ABdhPJxl5ZqtCTWVp0g7asHgB97dwAJjTRLJpWDyKFbzXVAxIJVUhFg1UkaQEH2aVBA/PGXfQ3AeTW3gN3o66f3yk8Y=
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr1918899ljp.253.1608303401167;
 Fri, 18 Dec 2020 06:56:41 -0800 (PST)
MIME-Version: 1.0
References: <5FD2AA34.3000409@cox.net>
In-Reply-To: <5FD2AA34.3000409@cox.net>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 18 Dec 2020 06:56:29 -0800
Message-ID: <CAKi4VAK4LFWZH7LD4nON=AOeO+iZBa8WfvCvhr8uhs9KR8pYqw@mail.gmail.com>
Subject: Re: lspci: Unable to load libkmod resources: error -12
To:     Joe Buehler <aspam@cox.net>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Dec 11, 2020 at 2:19 AM Joe Buehler <aspam@cox.net> wrote:
>
> When running lspci -v on Ubuntu 20.40, I get the error message:
>
> lspci: Unable to load libkmod resources: error -12
>
> I tracked this down to a possible libkmod issue.  The kernel I am using
> has an empty modules.builtin.aliases.bin file (modules.builtin.aliases
> does not exist).

It is indeed a little bit confusing, but modules.builtin.alias.bin is
created from
modules.builtin.modinfo that should come with the kernel.  Is this a
custom kernel or
one from the distro? modules.builtin.alias.bin should either not exist
(in case the kernel
doesn't have modules.builtin.modinfo) or should be a valid index.

Indeed depmod doesn't create the file unless it has something to
write. I wonder if the error wasn't
because the call to depmod failed for some reason (out of space?).

Looking at a ubuntu 20.04 system I do have both
modules.builtin.modinfo and modules.builtin.alias.bin. If I remove
modules.builtin.modinfo and call
depmod -a, then the latter is not created.

Lucas De Marchi

>
> kmod_load_resources() doesn't like this.  It calls index_mm_open() which
> checks the file size, sees that it is less than sizeof(hdr), error
> terminates, causing kmod_load_resources() to return -ENOMEM.
>
> kmod version 27 as shipped with ubuntu 20.04
>
> Please copy me on any responses, I am not on this list.
>
> Joe Buehler
>
