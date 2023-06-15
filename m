Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B4AEB64D9
	for <linux-modules@archiver.kernel.org>; Thu, 15 Jun 2023 10:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbjFOKKM (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 15 Jun 2023 06:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343785AbjFOKKL (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 15 Jun 2023 06:10:11 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08222688
        for <linux-modules@vger.kernel.org>; Thu, 15 Jun 2023 03:10:10 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bc4e41b7bc9so1547331276.2
        for <linux-modules@vger.kernel.org>; Thu, 15 Jun 2023 03:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686823810; x=1689415810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dls0/gu95jCtnBSLGmhCVxlAMuscuHOtGNDuUfVQ9+I=;
        b=ANmqqX9InSzDhtssOnJoSfE+djs8reEW01N3VOo+xFtMJibrW03Tz7LznRVVg9+VH/
         HKHjV+QxouO5caSeHQS0qpyCFTrYhz+v9Xw+hvZvEu79n4gPatoS3zsi3L0GIHX6GD1R
         6cVMIfd70MIESBLwjab3Hv2UA50BP2UZMYNEbyt52OhvaoFMPFbE2e0Im0pVQ2zNOSPz
         2bK2anJIBrlvyFjXyGarQLzjw/FB/0McS1EZbinpsPWR2NVrQEq0D63gYCGOpEH8bGrO
         ddcpPEe6WdIFRHbAIt6TXRChuGX/9oRf3Fi2euclIHJG6HtGcYcezjybxHoL9BPzzZyk
         RssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686823810; x=1689415810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dls0/gu95jCtnBSLGmhCVxlAMuscuHOtGNDuUfVQ9+I=;
        b=iTaxDjZZuxYcQxaOtOMly0n6iO8cboBTX1S4gAQSDuN51+OukIYPk0mRrYMCf9Utvp
         c4INnPdFWQ9kb9Trz+BKygWzMtoBwXHLWrwUF+HWRsHGGz3Btp6rVlo792CMU87ihpwC
         XwBjNUyIXwrLNUlTqWryCPbc2Ono8RI1VixZYNI/BZtJr+4H54VdEkKbWnSpq0JP5gBv
         xhEwi6z56fdE/+KPoauNB8pIkAFM5Gib7opgbVqIkZTBD5gwDcSQhHSPWuhN1dxVmCfV
         2rGlfBuw9so2XEO3o3K/4eILFE/pSoRw97WObfmrZzkloOy2MP6DPLW3tW2c+aooA0PQ
         kH6w==
X-Gm-Message-State: AC+VfDzE7JEPwz+vegGAUnQTKiy5dGvf9Tt5zRZEW2SnXekRXJHtFEK/
        l1gekdGgimGIJuoB7UAZ5yWbJ2CAdKndwNtUgd4uS+K8HmU=
X-Google-Smtp-Source: ACHHUZ69Xh8x3SKCygCHj9XDugCzrNPifea5R+3t0yCJvIVEb4HnLn++xnuuNK4IdQ7YkkceMwUhCQh8YJ6A+0aRJDQ=
X-Received: by 2002:a25:4251:0:b0:bca:5dab:1e55 with SMTP id
 p78-20020a254251000000b00bca5dab1e55mr4103323yba.16.1686823809722; Thu, 15
 Jun 2023 03:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <CACvgo53yHOd964PoQkM_oX3LGcr+qCagz64T+sxcP-eAveS85g@mail.gmail.com>
In-Reply-To: <CACvgo53yHOd964PoQkM_oX3LGcr+qCagz64T+sxcP-eAveS85g@mail.gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 15 Jun 2023 11:09:59 +0100
Message-ID: <CACvgo51chK2SU0an2dD5uYaUdm8sQd6DmRWdUf5bY=2sZnBoNQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] libkmod: Use kernel decompression when available
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, 15 Jun 2023 at 10:36, Emil Velikov <emil.l.velikov@gmail.com> wrote:
>
> Greetings Lucas, list,
>
> I've pulled the email off lore.kernel.org manually (haven't played
> with lei yet), so chances are the following will be "slightly"
> malformed.
>
> Above all - hell yeah, thank you for wiring this neat functionality.
>
> Out of curiosity: have you done any measurements - CPU cycles, memory
> or other - how well the kernel decompression performs vs the userspace
> one?
>
> That said, I may have spotted a small bug, namely:
>
> > --- a/libkmod/libkmod-module.c
> > +++ b/libkmod/libkmod-module.c
> > @@ -864,15 +864,24 @@ extern long init_module(const void *mem, unsigned long len, const char *args);
> >  static int do_finit_module(struct kmod_module *mod, unsigned int flags,
> >     const char *args)
> >  {
> > + enum kmod_file_compression_type compression, kernel_compression;
> >  unsigned int kernel_flags = 0;
> >  int err;
> >
> >  /*
> > - * Re-use ENOSYS, returned when there is no such syscall, so the
> > - * fallback to init_module applies
> > + * When module is not compressed or its compression type matches the
> > + * one in use by the kernel, there is no need to read the file
> > + * in userspace. Otherwise, re-use ENOSYS to trigger the same fallback
> > + * as when finit_module() is not supported.
> >  */
> > - if (!kmod_file_get_direct(mod->file))
> > - return -ENOSYS;
> > + compression = kmod_file_get_compression(mod->file);
> > + kernel_compression = kmod_get_kernel_compression(mod->ctx);
> > + if (!(compression == KMOD_FILE_COMPRESSION_NONE ||
> > +       compression == kernel_compression))
> > + return ENOSYS;
> > +
>
> Old code returns negative -ENOSYS (negative), the new one a positive
> ENOSYS. Where the fallback, mentioned in the comment just above,
> triggers on the former negative ENOSYS.
>
> Mind you I'm still sipping coffee, so chances are I'm missing something here.
>
> Thanks again and HTH o/
> Emil

Somewhat related:

Would it make sense to read /sys/module/compression if it contained
multiple lines - one for each supported compression. This way, kmod
will just work when the kernel is updated to advertise them all.

There is about 0.000001% chance that changing the format of the sysfs
file might cause regression, which can be looked into if an issue.
After all the sysfs entry is just 1 year old and is undocumented
(cough) so nobody should be using it, right :-P

I'm really tempted to send a patch tweaking the sysfs file and adding
documentation. Please let me know if you think that's a bad idea, or
you have one already queued.

Thanks
Emil
