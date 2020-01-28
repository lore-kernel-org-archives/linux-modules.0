Return-Path: <SRS0=0AOX=3R=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85869C2D0DB
	for <linux-modules@archiver.kernel.org>; Tue, 28 Jan 2020 15:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F7924686
	for <linux-modules@archiver.kernel.org>; Tue, 28 Jan 2020 15:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NrfQZ4QW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgA1PDn (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:03:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54445 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgA1PDm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 28 Jan 2020 10:03:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id g1so2866104wmh.4
        for <linux-modules@vger.kernel.org>; Tue, 28 Jan 2020 07:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Axyj/NbFSnIl0HYu62QnCK4SWRXHIt6D3V7oPwwOInI=;
        b=NrfQZ4QWPu3Rb+QHzoU8egqadRK3eCgtHBxR6VPCxkrjo5HnCpW3txwt88lWEwQEmM
         Yp+MAASFruKGMoSmOfSi3hyrTiIwBxRj7ieNG5alDXvoudYISPNJlgjJHnaxnHlNipp4
         hHJxT+iP7AKgvdMSJbE76Na5nJOO4k21HadxfsgLf0LwMFHooPHVCAOEmBQbzeTf6Wl1
         lM9CMFMwqr4mlHPKSYQL+i8hapB/7CMJrpAvgO4XLm0lsPD+TdX0SrGETs5+ZHU1wBXZ
         t+Xn480wdyDIAteDYgbM2lg0AqE1UDVaURdSZ9lIDAOGpog8oaCXkaymtMfK7+Lu3zjS
         MLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Axyj/NbFSnIl0HYu62QnCK4SWRXHIt6D3V7oPwwOInI=;
        b=Cw6tajhENTySJz9N2t7SRQ2LUqrg9Xf9V+DqpcMhXERpstOELlLIRnYooQpI2Sr4S9
         bhKFAmCelBPzoB/0BELDILuc6G0bFicmTYpefInOV37z6usmJtssbQvf8P7pKTx3arpp
         sluXBRo0WDfs4IbmC07nVr4kci+E6dGH+nDyfqn8wGVR1DZRDk0EqBD72nCR5/M11lU2
         ujfcE4xvALzXmKJZyDUdBRJODIVWRNedTqPRN4EmqLUNFvvXMIrvZ0RRKXVzQdvcbPWv
         +E3e/7qn35yg+Xk+AtNNk9c/5y3/uEybojy/7lp2fR8AVS2rjz290KiuQesuNqu27aGz
         G8Sg==
X-Gm-Message-State: APjAAAXJvXg8UJtcgKcti+GMkc+V+2jHq626YkcmnQXv8gKJHPPOXMBR
        T/Ow+QefsfYUDBX00zg28//lt27VBx+EmmO7ISTk8A==
X-Google-Smtp-Source: APXvYqyBKz8HZuCP5GonLOjpwjZ7Y0A5nEgrzKtjUYyD4n+Ar3xGpedZQVkmi5Cyo949ytYA1fQeFixK3Atn9z8YydM=
X-Received: by 2002:a7b:caf2:: with SMTP id t18mr5750447wml.131.1580223820386;
 Tue, 28 Jan 2020 07:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20200120192210.6370-1-lucas.de.marchi@gmail.com> <CAKi4VAJjA_G5KZ2Z6uAMKcp-38mF3PfAsfM1MvLQcKuDO7vWsA@mail.gmail.com>
In-Reply-To: <CAKi4VAJjA_G5KZ2Z6uAMKcp-38mF3PfAsfM1MvLQcKuDO7vWsA@mail.gmail.com>
From:   Jorge Lucangeli Obes <jorgelo@google.com>
Date:   Tue, 28 Jan 2020 10:03:28 -0500
Message-ID: <CAKYuF5QuxP1S3ZQGdQDnzj2jmKp2Knr4GyYBaEKjg0efXVgreA@mail.gmail.com>
Subject: Re: [PATCH] libkmod: reset was_space on second pass
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Thanks!

On Mon, Jan 27, 2020 at 8:46 AM Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
>
> On Mon, Jan 20, 2020 at 4:22 PM Lucas De Marchi
> <lucas.de.marchi@gmail.com> wrote:
> >
> > From: Lucas De Marchi <lucas.demarchi@intel.com>
> >
> > The softdep config parser uses a 2-pass approach to use a single
> > allocation for all the softdep struct. However "was_space" variable
> > isn't reset between them. This can lead to a buffer overflow.
> >
> > Reported-by: Jorge Lucangeli Obes <jorgelo@google.com>
> > Link: https://lore.kernel.org/linux-modules/CAKYuF5QhGCPCazHQjN-=kFc5kHs7Ok8WqmmGLo31CiOEN8TYdA@mail.gmail.com
> > ---
>
> Applied,
>
> Lucas De Marchi
>
> >  libkmod/libkmod-config.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
> > index aaac0a1..7b62367 100644
> > --- a/libkmod/libkmod-config.c
> > +++ b/libkmod/libkmod-config.c
> > @@ -335,6 +335,7 @@ static int kmod_config_add_softdep(struct kmod_config *config,
> >         n_pre = 0;
> >         n_post = 0;
> >         mode = S_NONE;
> > +       was_space = false;
> >         for (p = s = line; ; s++) {
> >                 size_t plen;
> >
> > --
> > 2.24.1
> >
>
>
> --
> Lucas De Marchi
