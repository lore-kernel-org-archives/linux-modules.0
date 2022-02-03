Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C340BC433F5
	for <linux-modules@archiver.kernel.org>; Thu,  3 Feb 2022 19:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbiBCTTz (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiBCTTy (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 3 Feb 2022 14:19:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBE5C061714
        for <linux-modules@vger.kernel.org>; Thu,  3 Feb 2022 11:19:54 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m11so8093420edi.13
        for <linux-modules@vger.kernel.org>; Thu, 03 Feb 2022 11:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cSZa6DBBFDOxX2GW/qnTrsYZ3zoJ+ZjemRz7cnhpqE=;
        b=fCNr7CPXFLdcVd8PjZvoiasGZnLEu8KQ/XZwbGLm+yV2wWLdo8/zz6Gwya8F4pMZH2
         9PrtXR7djkoDFL0VDJIh2cWDBzJnLY6/s1O7jndQ40X6X4ZFDpwZUZloZr6Vh92pTMZI
         G9LaPnBdpVo9UTRwk6KpYQEb8gnycoM8Dr+wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cSZa6DBBFDOxX2GW/qnTrsYZ3zoJ+ZjemRz7cnhpqE=;
        b=JzT5HDL1UaDHyCuAHdkssrhrRCJGxR0vXpRU3YWxtPExsnGcj642pwEW/ahL32qRmw
         MYL/gBeAHSlB5R5t4+lUInE/ipd27bFR/EuATTytnf5NYT2rSi6Z1j+Diy2lvdQcd8aR
         A5r1rW69Obbp7Q74mQughAksSbBcdcKpp1VvceK0R2wkaEheMn6LXWFcv/mYVnwJ+fr0
         CZhZl508B8x5AQZasUnjnkYH6OrN9RWRJtzjwkJsfrHyzzJpJIIpvWvCiybC8upet5IS
         K1AlPh1584oDrwpC7Z1lzl2WW71+91Zn6YjEdcaXpVrrZ4GB+gZ7CZTTSpQCwQLSSSwX
         vayw==
X-Gm-Message-State: AOAM532e06Y+zCaPX5MvmweK0vnGQTWIPIo01iEo/W9FaraAhPY/kXhX
        QkEGxzGeu3ux8GKMfvAPfaVqo0uAGEFzZXDJ
X-Google-Smtp-Source: ABdhPJxQKJp+MbovnQeRFzMPer4IF6L8l94BdsCLXEz59GdLTPsopdnnwHv96nQrySNNNorpfPaGdw==
X-Received: by 2002:a50:ee09:: with SMTP id g9mr8300146eds.387.1643915992537;
        Thu, 03 Feb 2022 11:19:52 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id oz18sm17078861ejb.106.2022.02.03.11.19.51
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 11:19:51 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id k18so6938368wrg.11
        for <linux-modules@vger.kernel.org>; Thu, 03 Feb 2022 11:19:51 -0800 (PST)
X-Received: by 2002:adf:f90c:: with SMTP id b12mr29879801wrr.97.1643915991226;
 Thu, 03 Feb 2022 11:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20220127233953.2185045-1-ipylypiv@google.com> <YflxP28HlVrrNBU2@slm.duckdns.org>
 <Yfly0P4e84373mGF@slm.duckdns.org>
In-Reply-To: <Yfly0P4e84373mGF@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Feb 2022 11:19:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg4Tk-cV=nQ2Xrj7P9wN-TxVCR5hjtW3iDpNyjW4x3fzw@mail.gmail.com>
Message-ID: <CAHk-=wg4Tk-cV=nQ2Xrj7P9wN-TxVCR5hjtW3iDpNyjW4x3fzw@mail.gmail.com>
Subject: Re: [PATCH] Revert "module, async: async_synchronize_full() on module
 init iff async is used"
To:     Tejun Heo <tj@kernel.org>
Cc:     Igor Pylypiv <ipylypiv@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Feb 1, 2022 at 9:50 AM Tejun Heo <tj@kernel.org> wrote:
>
> BTW, I can route this through workqueue tree but -mm or going to Linus's
> tree directly might be a better option. Any opinions?

I'll take it directly. Hopefully nobody notices anything at all - but
if it causes unexpected serialization and somebody screams we'll know
more at that point..

           Linus
