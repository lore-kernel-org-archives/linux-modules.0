Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344D6C43334
	for <linux-modules@archiver.kernel.org>; Thu,  2 Jun 2022 19:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiFBTlv (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 2 Jun 2022 15:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiFBTlO (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 2 Jun 2022 15:41:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C21D33889
        for <linux-modules@vger.kernel.org>; Thu,  2 Jun 2022 12:40:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m20so11874300ejj.10
        for <linux-modules@vger.kernel.org>; Thu, 02 Jun 2022 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8dK6D+XTwQM6Q2wZRKTjnaTGLe0PvZRBSojaTGRw0o=;
        b=Fw9O5ZQr2akCs4XmkAleh4S1lzR/HnmE+gr+ExVcOzwPxlPBN+cxqks9XAmHum3a9r
         EdR/pADzdNu2xsnplxjkFSOSAh4MgTkZa39ydrHWleBPDB0V3sGb1fyOvp86Qg0iOUmA
         ZL4/cbSunc8oCfQv/NmSPlM9MXREEBXgNEDzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8dK6D+XTwQM6Q2wZRKTjnaTGLe0PvZRBSojaTGRw0o=;
        b=Q8yPIuxccyRonFAkFDiKt9E2Vy8IyBd5ij0jRwk5+ZpYuPsYa9ZXZ9e/8OQpl8Mddc
         2Amh4r1geI2epUYymLY0l9okTCOY++ah1pGiLqPBX+09CmnbmNMkse6NBcJ63hspSJbR
         KMubzLXQ1VugAFLZ1aF/UhRzPFAmpaRG9r6oT8z+h9gSmQvZ/W6AojuwJiVL9lxrcNhA
         TN4hEaXnnGc5073QZBetdFtcltLjD9hNbIZ9n1ZPDgzAxkyEgtLFx5jHrvonPVgYjARq
         VOJTRN6KsLc52263zpi74hlzSDmqnPzvI/TIg2CsIHNMieM6r6p3jduSXgJwwn/nR163
         IbLw==
X-Gm-Message-State: AOAM5321LG4UyGmNmjjKIO8nXK7DiW6cmFphWFlKRxAwBWmgnVVOPXuG
        xZiX/5loNwGtlglNz+uDQhONRKCZDZzZAh2Q
X-Google-Smtp-Source: ABdhPJwTF50pkzr/rVqUdyS1yCmj/tz0k2DyC+pr6/xJBzikkh/KdeR3iBxz3ZEHtMVF8jr3N006tw==
X-Received: by 2002:a17:907:7d8a:b0:6fe:dccb:cf4c with SMTP id oz10-20020a1709077d8a00b006fedccbcf4cmr5750033ejc.714.1654198851900;
        Thu, 02 Jun 2022 12:40:51 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id x25-20020a170906b09900b006f52dbc192bsm2045290ejy.37.2022.06.02.12.40.48
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 12:40:49 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id q21so7731664wra.2
        for <linux-modules@vger.kernel.org>; Thu, 02 Jun 2022 12:40:48 -0700 (PDT)
X-Received: by 2002:a5d:6da6:0:b0:20f:bc8a:9400 with SMTP id
 u6-20020a5d6da6000000b0020fbc8a9400mr4890049wrs.274.1654198848176; Thu, 02
 Jun 2022 12:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220322140344.556474-2-atomlin@redhat.com> <20220602035653.4167316-1-saravanak@google.com>
 <YpkMelZC+E5hKTw6@bombadil.infradead.org>
In-Reply-To: <YpkMelZC+E5hKTw6@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jun 2022 12:40:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit6ttmzdFsbH+YLkMeLucTspYADHnENn4fBXNrit0BUQ@mail.gmail.com>
Message-ID: <CAHk-=wit6ttmzdFsbH+YLkMeLucTspYADHnENn4fBXNrit0BUQ@mail.gmail.com>
Subject: Re: [PATCH v1] module: Fix prefix for module.sig_enforce module param
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, Allen Pais <allen.lkml@gmail.com>,
        Joe Perches <joe@perches.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 2, 2022 at 12:16 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Linus want to take this in or should I just queue these up?

I'll take it, and remove the unnecessary #ifdef/#endif. The #undef
might as well be unconditional - simpler and doesn't hurt.

            Linus
