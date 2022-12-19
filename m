Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA16C4167B
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 21:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiLSVk7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 16:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiLSVk4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 16:40:56 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B579DBF73
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 13:40:54 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id a66so10072959vsa.6
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 13:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b0lZ9H61ffuyWT5v/mD9MPUBMs9gBi6BOfPbdE5H3Cc=;
        b=RGKpKnvwsu92s39ZICRbT6oNnETwNW3atD20amN/lcRp18RYNoO4wGtDFQDU+oeevE
         tR3zVtefmWET6AXP6ucq5gASmcH62ZLkSqzv7cKmx1QG8AyEMguXdgTMN944C/zo8yGv
         AxYgVRe8iccPJFPo92zKrPHz2gRwnRMawy755OsP0aH7BPO4wCUDpAki9F9pmDwmIg9t
         feWk3S0+wTgieqkXVLcJobshpCKOYWR6T+eRgminpytOAEO87HqC5HrPTLd7nrBIt0Ie
         pBd2+qmxKwiQuW7F/igh9192OvD+IvOy1Cw5NvW1hrO3cxd1Sp99CbOzONgjkBJ31zO0
         TRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0lZ9H61ffuyWT5v/mD9MPUBMs9gBi6BOfPbdE5H3Cc=;
        b=CPF1f7xFjCUF6+wqme3xNErJQXD2n0ik+HgHTXITPBfPKBKPxvflQKAxo72Xk3/5lH
         ghAXVeceL0UIue8CQDI2cY05zmK517gPbiIIHEkd4F/cyKQwqIiez+f7UjVHwCo2b9uN
         2U/sInwMSWFciIkXlU77V42P1QTBkyubnpiuOWLSmMMSV4+0takeKd90X0dwoCTLqM57
         g7dwRTRrq92G49yeOv0dNNHiYj3BquWCJP8nLM2BPVqPgF9NQH40s3zgqCd/cnmo4gyZ
         SgXefe396wRJVLWs8cVEc42eCQbPsCEbWmDiFRO4LDX3ZfV592/W5zaKdQTrLk9teOsz
         dVtQ==
X-Gm-Message-State: AFqh2kpX1NjNdcablRCTI152u14BMAvTEMPNDjw4aqbaxsK9/s7Pfmwu
        ZXWHSRaLIKZtlrI5G6KLwaEbyvuMswrRsSVQrpsYmg==
X-Google-Smtp-Source: AMrXdXunXpVUQSC1E212BDorayyxTvtJQdCJ3MFfjCdbPC4ogzCh2qmoge/BZ4NqmL2AsBHr95/mAWiLa0TfgJV+fkI=
X-Received: by 2002:a67:ffd5:0:b0:3bc:441f:a808 with SMTP id
 w21-20020a67ffd5000000b003bc441fa808mr984012vsq.36.1671486053254; Mon, 19 Dec
 2022 13:40:53 -0800 (PST)
MIME-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com>
 <20221219204619.2205248-1-allenwebb@google.com> <20221219204619.2205248-11-allenwebb@google.com>
 <Y6DWaODE5F9x+Qq1@bombadil.infradead.org>
In-Reply-To: <Y6DWaODE5F9x+Qq1@bombadil.infradead.org>
From:   Allen Webb <allenwebb@google.com>
Date:   Mon, 19 Dec 2022 15:40:42 -0600
Message-ID: <CAJzde07K0siUs-eKfXxVp7R47hF8TdADGeTEvFtwxHVg9NV7FA@mail.gmail.com>
Subject: Re: [PATCH v9 10/10] docs: Include modules.builtin.alias
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Dec 19, 2022 at 3:23 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Dec 19, 2022 at 02:46:18PM -0600, Allen Webb wrote:
> > Update the documentation to include the presense and use case of
> > modules.builtin.alias.
> >
> > Signed-off-by: Allen Webb <allenwebb@google.com>
> > ---
> >  Documentation/kbuild/kbuild.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> > index 08f575e6236c..1c7c02040a54 100644
> > --- a/Documentation/kbuild/kbuild.rst
> > +++ b/Documentation/kbuild/kbuild.rst
> > @@ -17,6 +17,12 @@ modules.builtin
> >  This file lists all modules that are built into the kernel. This is used
> >  by modprobe to not fail when trying to load something builtin.
> >
> > +modules.builtin.alias
> > +---------------------
> > +This file lists all match-id based aliases for modules built into the kernel.
> > +These are intended to enable userspace to make authorization decisions based
> > +on which modules are likely to be bound to a device after it is authorized.
>
> What is an example? This sounds obscure.

Many of the devices that match the usb_storage driver only specify the
vendor id, product id, and device id (VID:PID:D) and do not match
against device class, interface class, etc. Here are some examples
from modules.alias: A grep for wildcards in these fields yields 6136
matches:
grep 'dc\*dsc\*dp\*ic\*isc\*ip\*in\*'
/lib/modules/5.19.11-1rodete1-amd64/modules.alias | wc -l
6136

To write USBGuard policy that only authorizes devices that bind to a
particular module the policy needs to be aware of all these VID:PID:D
which can change between kernel versions.

This is done at runtime rather than excluding modules from the build
because some devices are not needed at or before login or when a
device is locked. By not authorizing new devices that would bind to a
set of modules, these modules become unreachable to an attacker who
seeks to exploit kernel bugs in those modules.

I could add this detail to the documentation file, but I was trying to
keep the description to about the same length as the others around it.

>
>   Luis
