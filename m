Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A279C4332F
	for <linux-modules@archiver.kernel.org>; Thu,  8 Dec 2022 14:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLHOYf (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 8 Dec 2022 09:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiLHOXs (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 8 Dec 2022 09:23:48 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B029D2E4
        for <linux-modules@vger.kernel.org>; Thu,  8 Dec 2022 06:23:08 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id 3so1573558vsq.7
        for <linux-modules@vger.kernel.org>; Thu, 08 Dec 2022 06:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=As/CZIt5orfwQ7Fab3NuD7sU3ZdGXQ0KUV67djSyEM4=;
        b=Svr4EJWyVAy8ZEDYXtdX/3PhjyfOQy/jlGEJYjzvXbZJ6WagFt+kE6B4+1PJM6DBBd
         tYLQU11uo0Z6tw7curiNweecxh8wA0L2msqtQg35Kt9uQJ/dXmeLKTyiqwPV/R3mCv+8
         s/kqcY20HDJpUPmsSOHZCjyjivbBegAoR5eo9s2XyR9jQ+FzbCQYs+D8P4SLK2q9cHF5
         r1KZoEqqJlj3PDOcAXEyAwXUsH7TG2q0p4LRsrwOhuBV7+vP6LMwSLSBAtOQ4HDGd05q
         jd4gAD5Xs9r394g3IL1vPEWZXMXX2Y1gR2c9NUz29GhNXHqBljPeOBwSjxcp//Zl+qql
         /0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=As/CZIt5orfwQ7Fab3NuD7sU3ZdGXQ0KUV67djSyEM4=;
        b=QR/RXG4TGaOoXeRxT1/0ky/zWl+ABN3Fuz9qtJYl5kbspZ/hfub2IsnvRcQNlBBuC1
         YlY3ozrIcxwG1UZO1rsFxzwXJHWnA2egNTjQfJNzJdpuJxa85OLzVJghQR1dUmez0X2f
         3cQ64KKJI6AMYU0N6DHqNJetPKTh8RfeJrjZKdC6aO3RqDAzI52Wlr5+hkxp/rC1hy+U
         qXv6B6Rg3iT1TvEZSGf++L70g1olckn8CoHg/xIx61uAD9J8wF7Rx+GaOzieilF8j382
         YxCS2TjFfyQTQ4fqIBhtSCg7n69yIPFVUEqpp4Jeo9GMk8yzOMunNtd2buqAGigxoGAQ
         HF+w==
X-Gm-Message-State: ANoB5pnQyg2+ZPEfptW178jLKfW3bhmuFo342HJERkADQpC51Y7bhyG9
        wluIeS1cLr5KJCz7gS4RpdFOC7egsgawFSBwy3qLdg==
X-Google-Smtp-Source: AA0mqf5hrLUh6geFTTa3xvTozjjJK81CXBxyGaTS+c820T86mab4aBRhrL3B/1Vxhuy4Xvm3PYggqZk+jFxLc26n1DQ=
X-Received: by 2002:a67:ed4b:0:b0:3b1:1506:bca5 with SMTP id
 m11-20020a67ed4b000000b003b11506bca5mr14620578vsp.35.1670509387721; Thu, 08
 Dec 2022 06:23:07 -0800 (PST)
MIME-Version: 1.0
References: <CAJzde06+FXNpyBzT+NfS2GCfqEERMkGDpdsmHQj=v1foLJW4Cw@mail.gmail.com>
 <20221129224313.455862-1-allenwebb@google.com> <Y5FNNYVSRglS0Lpe@bombadil.infradead.org>
In-Reply-To: <Y5FNNYVSRglS0Lpe@bombadil.infradead.org>
From:   Allen Webb <allenwebb@google.com>
Date:   Thu, 8 Dec 2022 08:22:56 -0600
Message-ID: <CAJzde06ACctpK-5ht_Ow9dMuisOwTM5CKE_SK+bW5eWTmwCUxg@mail.gmail.com>
Subject: Re: [PATCH v3] modules: add modalias file to sysfs for modules.
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     lucas.de.marchi@gmail.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Dec 7, 2022 at 8:34 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Nov 29, 2022 at 04:43:13PM -0600, Allen Webb wrote:
> > This information is readily available for external modules in
> > modules.alias. However, builtin kernel modules are not covered.
>
> Why add this into the kernel instead of just a modules.builtin.alias
> or something like that?
>
>   Luis

I am fine with that approach and already have a PoC for it. Here are
some considerations:
* This would add a new file to the kernel packaging requirements.
* It is easier for separate files to get out of sync with the runtime
state (this isn't really a big deal because we already have to deal
with it for modules.alias)
