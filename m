Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90384C4332F
	for <linux-modules@archiver.kernel.org>; Mon, 14 Nov 2022 16:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiKNQnG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 14 Nov 2022 11:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbiKNQnE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 14 Nov 2022 11:43:04 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602C065FD
        for <linux-modules@vger.kernel.org>; Mon, 14 Nov 2022 08:43:02 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id g4so5230855vkk.6
        for <linux-modules@vger.kernel.org>; Mon, 14 Nov 2022 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r6+Uc7KspS9LnQ7lQ8KADE8xYhNwIZ0EslnJy4rOJIQ=;
        b=pXlLzqqea3rFwcAo0BCKnnKZine2dIaVs1WKl0zC8f4r5mX8yfoWOTYXBcNQ2k/CTC
         gyonvxZA1RIE8qxHdaqSwRlS7sZDrmqAVs0CnAJqR8m8BRyFOMRk+o05e9V4RPFowx1h
         y8ZHwMXLftERyS8j3xA5e3N3ogEVd/3ej8xV8nVh2rGuMmI36uy1Dbrm6fTf6+LaUeu1
         hEBfdKjruLa+K7j9XDqq64OZyLc4emGZDSwhaT9X1htGTY289G/xd4+E26slJ6ESzO5f
         y1NivQybEzJ7mRb8u4RBBFZYiCZx8WczDldkFTGRjok2QuPet9Ciklqo50m3x4u0pcXp
         5e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6+Uc7KspS9LnQ7lQ8KADE8xYhNwIZ0EslnJy4rOJIQ=;
        b=TEgw4hRFBaVrWcXi9A39dsAYeiB3bk8aSKr1xBAjOUSD0nYLOuMRRiZ7L1Fu+yYCdM
         6WfiIwU7+ahm50qkpw+OdOsVEvdtXIfmYL+rQz0cJR+1d/SZ+xcBVB0pmcniO1jgvur1
         VOG/ICT3S/KUSkyLo/gJYWb5RRGSP+a6WBKnhpONuiEj7jNDCAJtAP61eFp+eRrvl1CA
         ekCm6vBmFgBJRcCANQXb4ydZVihZbTAu8hO3KotZtzG7G/fYfLm3iEedyJW+UV+uZyQD
         S5WI/Vl+S6jVi7+ifWFIL4wpm012ScOIuuI1cXAukHfsfoXoA8DSKAmTw9nXAN8YhGQP
         wOLA==
X-Gm-Message-State: ANoB5pmWFIQ2B97D0+WKkdF0G8Zt/d+y2xwC6FTWejM5ovwxEKzAt8+Y
        d6b/Dwlo/w/SMI2V+cjCsEDTPPPxN0ejuzRlHDHUzw==
X-Google-Smtp-Source: AA0mqf4JZZcyI0e3LlhvIJqy5/kKz/rCYZl9cgjvokgRpT+9Gh2L4+/4nkyXKZB7aoi88JomTTlBCNt8+58AZgDef1U=
X-Received: by 2002:a05:6122:1989:b0:3b8:1bb4:b750 with SMTP id
 bv9-20020a056122198900b003b81bb4b750mr6892769vkb.20.1668444181396; Mon, 14
 Nov 2022 08:43:01 -0800 (PST)
MIME-Version: 1.0
References: <b2d1004d-4a76-ab0b-d369-a38c2d7c1624@csgroup.eu>
 <20221111152852.2837363-1-allenwebb@google.com> <Y26UcbviRaoK9a3C@bombadil.infradead.org>
In-Reply-To: <Y26UcbviRaoK9a3C@bombadil.infradead.org>
From:   Allen Webb <allenwebb@google.com>
Date:   Mon, 14 Nov 2022 10:42:50 -0600
Message-ID: <CAJzde06b4d065y7KSoGO6qQBgvcVdkUai1WAy_TkrkTCDHS41A@mail.gmail.com>
Subject: Re: [PATCH] modules: add modalias file to sysfs for modules.
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Nov 11, 2022 at 12:29 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Nov 11, 2022 at 09:28:52AM -0600, Allen Webb wrote:
> > USB devices support the authorized attribute which can be used by
> > user-space to implement trust-based systems for enabling USB devices. It
> > would be helpful when building these systems to be able to know in
> > advance which kernel drivers (or modules) are reachable from a
> > particular USB device.
> >
> > This information is readily available for external modules in
> > modules.alias. However, builtin kernel modules are not covered. This
> > patch adds a sys-fs attribute to both builtin and loaded modules
> > exposing the matching rules in the modalias format for integration
> > with tools like USBGuard.
> >
> > Signed-off-by: Allen Webb <allenwebb@google.com>
>
> Thanks for the patch Allen!
>
> I'd rather have something generic though, and it would seem kmod [0] already
> does this, have you seen the kmod support for builtin.alias.bin
>
> Can't that be used?

Probably, but I don't see the builtin.alias.bin in my build. Is it experimental?

>
> [0] git://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git
>
>   Luis
