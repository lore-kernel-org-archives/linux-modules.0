Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008F6C4332F
	for <linux-modules@archiver.kernel.org>; Tue, 20 Dec 2022 18:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiLTSUD (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 20 Dec 2022 13:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLTSUC (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 20 Dec 2022 13:20:02 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698FB1C111
        for <linux-modules@vger.kernel.org>; Tue, 20 Dec 2022 10:20:01 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id 3so12542963vsq.7
        for <linux-modules@vger.kernel.org>; Tue, 20 Dec 2022 10:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=botoMruAittvs+rTHSmzE3zrQGz596aYpbROQsMAW8A=;
        b=N3/3XOMf30/cvQ8Yxflqc8xDvvKIdFXEIfFToqSiw8sHWW69unaujMovBLHOue+TEF
         oaUTqjGhRgxvLGkjCJvvetJyGePOMcRYZy1RrY0l7sFJIa+ElElKIh5PO3fiN8YITtUg
         B9nic5CJRwBRd9L88dQ5B8AxwXWaoDfTXjWKh4KLIBT+mw5tlyYHNQMQvUlftXQapFIu
         g80SV0RRYdRszPeAqDnqoV2olfVoGiCS8tP9e8EDdnY7QZzlMgXB8THifsfD8IZpBKBH
         7DYR6qrK/gE9k78axURhYvhNFT2gZWlT1P/PJ5kpReB4bNv7IeefokQqvrZnNiXkn3ct
         Yy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=botoMruAittvs+rTHSmzE3zrQGz596aYpbROQsMAW8A=;
        b=n7DhyGuGHOXpjX0MkixvLdmfH/Op0EvbaQUrULb3Sy3Q+LJThMfbGduges5nKx3Vsu
         MQjR4DEq5ad/KzRdQhDtDC5HGktVuh5KgrkZQMxqJnUKEKKzdmHLc/oW/cSF68Mo646N
         Jx45bQN2y3skj4Ys/rnpAYeULpRbARdr9PYXIoWVoz7gAxlosmvY5Rw0FX+ZEmmVmRWD
         fXLwwvVpTK3+5ZfVvfx3pKsk+M22p3iDJdlzMUIFU+oo71vv52ui/HVIImP0TEjm10/G
         gYGjQnrSNWgsmP6J3ryh4ZBbbWINkF0lj3V22MovLkbgFGpesJA/O0zkqjSlsoT1oATg
         XMow==
X-Gm-Message-State: ANoB5plTINbx/n7vQku77CdFgYWWZUUUyyTDB07SPHt8lMABBij/I5ZJ
        S/mtQIIMD4RdlukedZpNkih1OFBk6swzOsz4qnTopXFgdy5ibGimZqM=
X-Google-Smtp-Source: AA0mqf7erm0Oj3LUs9Qxaq96ITPNngZ894gOmdkDcPjxJqB/rvjmTnBJI2L68bZknCHaVECiTMKDoWMnSKQUyiiAUKI=
X-Received: by 2002:a05:6102:578c:b0:3b5:1de3:19fa with SMTP id
 dh12-20020a056102578c00b003b51de319famr3230005vsb.35.1671560400231; Tue, 20
 Dec 2022 10:20:00 -0800 (PST)
MIME-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com>
 <20221219204619.2205248-1-allenwebb@google.com> <20221219204619.2205248-3-allenwebb@google.com>
 <Y6FaUynXTrYD6OYT@kroah.com> <CAJzde04Hbd2+s-Bqog2V81dBEeZD7WWaFCf2BkesQS4yUAKiNA@mail.gmail.com>
 <Y6H6/U0w96Z4kpDn@bombadil.infradead.org>
In-Reply-To: <Y6H6/U0w96Z4kpDn@bombadil.infradead.org>
From:   Allen Webb <allenwebb@google.com>
Date:   Tue, 20 Dec 2022 12:19:49 -0600
Message-ID: <CAJzde04igO0LJ46Hsbcm-hJBFtPdqJC6svaoMkb3WBG0e1fGBw@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] rockchip-mailbox: Fix typo
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Dec 20, 2022 at 12:12 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Dec 20, 2022 at 08:58:36AM -0600, Allen Webb wrote:
> > As mentioned in a different sub-thread this cannot be built as a
> > module so I updated the commit message to:
> >
> > imx: Fix typo
> >
> > A one character difference in the name supplied to MODULE_DEVICE_TABLE
> > breaks compilation for SOC_IMX8M after built-in modules can generate
> > match-id based module aliases, so fix the typo.
>
> Are you saying that it is a typo *now* only, and fixing it does not fix
> compilation now, but that fixing the typo will fix a future compilation
> issue once your patches get merged for built-in module aliases?

It was always a typo, it just doesn't affect the build because
MODULE_DEVICE_TABLE is not doing anything for built-in modules before
this patch series.

>
> > This was not caught earlier because SOC_IMX8M can not be built as a
> > module and MODULE_DEVICE_TABLE is a no-op for built-in modules.
>
> Odd, so why did it use MODULE_DEVICE_TABLE then? What was the reason for
> the driver having MODULE_DEVICE_TABLE if it was a no-op?

That is a good question. I can only speculate as to the answer but it
is plausible people copied a common pattern and since no breakage was
noticed left it as is.

It also raises the question how many modules have device tables, but
do not call MODULE_DEVICE_TABLE since they are only ever built-in.
Maybe there should be some build time enforcement mechanism to make
sure that these are consistent.

>
>   Luis
