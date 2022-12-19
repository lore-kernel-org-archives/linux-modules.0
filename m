Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F64C4332F
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 20:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiLSUmw (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiLSUmv (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 15:42:51 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22726120A5
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:42:47 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id i188so3980381vsi.8
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z8oCd/Pm1Hmgpcoa3tIG49zIBs1fxwhTneH98C02n5g=;
        b=MtIkhklUwk0t+gki0Bjfo9FL4+ztzi4C9haF2a5v64Kbl9eMIkMPRBJDvworF9CmJ/
         JXpCmWfdETyOazn5wIJaqtnXUPcg+DNBPgRYo4rfNY3qS7MKeAz/0M3yxsRwmB2VVLD5
         g5m0RHNWueiDeYI2olWHx8HFq2l2YlSFlIVMaWsCjUFkzpl+1OFOaZlHI1XZJBUTBAJ7
         S9EQTilhkH7ceIjOEq5YKJcgiwCj7AZRGq/RJVKK0PaZW40nhVsui+X1cSa9kypYBU7i
         gpdQsigRF0R/h8M0icLE2lc5NhFQJcyUYYCtzlTnZV9RZ0HeDbJwurFZDo55aZhRdkER
         YoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8oCd/Pm1Hmgpcoa3tIG49zIBs1fxwhTneH98C02n5g=;
        b=qPGzwuuHUtGKfxozYufqZc87x1x0djhyJLOud5RQYO2S1j97o4QI39P0NM/EhYbWYy
         xUF1AiPF1OUXMhlYk9oz2ePZXH1MgN7m4D7lQmp35EMIvnlL5Ba2Zss+oExFSw4XUyMh
         BMRufxFb+Y67jhev0r4+2DcsYDN5lV1r3EdkfLEUpMCa+sCKgX0y7IYKc3Z0BeHjRkXg
         iykP7sq293x/KjhG47esz2Zjala7pyHMuJtDpzj+XUxWz+JSPZ9hi0kyc4e8ZyClemlP
         k/9vvFnqpt4IVO5Q1I1uuPk/oF3xKpQKdIuuqZ7oU01uzDnPHwTHI29OMhryOof/oIFv
         1E7Q==
X-Gm-Message-State: ANoB5pnGfM8m8/uSiwGmgca5TbeOvMKiY4BCM6oQc6nLSt3rDY43UJEl
        cz912CsMa8Vx1IS4IVncqIPBBOb4nBhKPKqk3RQWag==
X-Google-Smtp-Source: AA0mqf4yslSCRa2mcrqdsnDAC26l1GZxDMJ0agmgr6lSEMfHSkQBfqy4s20vsmSSEeWHDQbA6IX+5u6m3oVl1/0JZ2g=
X-Received: by 2002:a67:f04e:0:b0:3b1:1713:ba11 with SMTP id
 q14-20020a67f04e000000b003b11713ba11mr21184486vsm.76.1671482566875; Mon, 19
 Dec 2022 12:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com> <20221219191855.2010466-1-allenwebb@google.com>
 <Y6DEWDeNw/yOXWWQ@bombadil.infradead.org>
In-Reply-To: <Y6DEWDeNw/yOXWWQ@bombadil.infradead.org>
From:   Allen Webb <allenwebb@google.com>
Date:   Mon, 19 Dec 2022 14:42:35 -0600
Message-ID: <CAJzde06a+deNszTj=zSSSqbm0M40QVP9Kw4aSKLwgWWy39Et1w@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] Generate modules.builtin.alias from match ids
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Dec 19, 2022 at 2:06 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Dec 19, 2022 at 01:18:46PM -0600, Allen Webb wrote:
> > Generate modules.builtin.alias from match ids
>
> This is looking much better, thanks! Please expand with proper
> documentation on the use case / value of this on the file:
>
> Documentation/kbuild/kbuild.rst

Thanks I added another commit with an update to the documentation
which will be included in the next version of the series.

>
>   Luis
>
