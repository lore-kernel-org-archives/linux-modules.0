Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C948AC83F12
	for <linux-modules@archiver.kernel.org>; Tue, 29 Aug 2023 15:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjH2PXg (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Aug 2023 11:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjH2PXe (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Aug 2023 11:23:34 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA47132
        for <linux-modules@vger.kernel.org>; Tue, 29 Aug 2023 08:23:30 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 298173F628
        for <linux-modules@vger.kernel.org>; Tue, 29 Aug 2023 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693322609;
        bh=Oh9PU6VwXKyC0ElpvtPzD/xYW6P3zmLqzcugqv6L8C0=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=ik7HxiZzmcOEnVv9dEgcsWCNbRy1ojz1565Te4JmoThRlo5uU7DOen1knyU9vFFdx
         rWUbPaOOU/VWo2wKgSfYAlmSi/2VpeLcMI0VAmkCw1Q/HY2xTGpy6LVX9aDjfHxOOg
         MYnClKXYxDTsKEB6hlb4lHsPivgrvAhdPi7uuidBL844RXsfIY5wkgu0yvjUvzCxFv
         83Sl2WsDlpCUos+ZpqRUc95ukJYm/ZnI/istOWwmHMKYUCbPsjUJU7VAK0wlq634D9
         U1KTwuSSx8eeMTmvgQRtCf3EL7nV/QtrRV2tFyNaWEDyrSH0pW17l8n0vSVX08H+a2
         w02TLXtps3CsA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bca0b9234so364532966b.2
        for <linux-modules@vger.kernel.org>; Tue, 29 Aug 2023 08:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693322607; x=1693927407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh9PU6VwXKyC0ElpvtPzD/xYW6P3zmLqzcugqv6L8C0=;
        b=DxzagYlPCnwZ3+gm2809350w52RxGdAe0XyDuxlybP+M5X+upFKXWvcTRJYQLuplMi
         tDvmmvttBug0wnnm3jNyoXnMQDXpXi0PJWzR69S+FnPEu54aK3PNGa8khI5ahGubXIsl
         CI0lKP/bdhN9swyt0DyK9RV8PcFadSV4guBCdzBq0z9pqBpFxZDoML6uIjet3JOGGHea
         NdYjZYDUCGJguG3iaDIqahf04CnOs4O8pCNqTeeHlxiESk7jhy/NswKv9QQttEL9TvUJ
         iGlcjp0VxZPuEBavJCifTWuksu6k77xmbi3xZ83oGSwfiZ8g3xMSFIq4YLOuEGEaCCqf
         NTiw==
X-Gm-Message-State: AOJu0YxfpodJxIISujGX+KZMwimCQH5uDfj8MY5l/2nqpmMR4k2TOSXm
        89o2/myFb9z28viKZu0yG6Q9zfmJxtgMIax3NhuBsQk/7VlyfCVPZgt4mshikZvSzg44802qRp8
        USyE7OTuPQKTjaMe91iSbtmp4GMekLsKZo+cf8tkcUUw=
X-Received: by 2002:a17:906:3094:b0:9a1:fda6:2e26 with SMTP id 20-20020a170906309400b009a1fda62e26mr13291306ejv.55.1693322607334;
        Tue, 29 Aug 2023 08:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv9tz51z5ECDkIBebO9HlEJpIe0bUNH3OPKzrBeoqP749X1h1IrDxexKcWyzS0HtjtHUlIAw==
X-Received: by 2002:a17:906:3094:b0:9a1:fda6:2e26 with SMTP id 20-20020a170906309400b009a1fda62e26mr13291291ejv.55.1693322607010;
        Tue, 29 Aug 2023 08:23:27 -0700 (PDT)
Received: from localhost (host-95-252-65-153.retail.telecomitalia.it. [95.252.65.153])
        by smtp.gmail.com with ESMTPSA id qq21-20020a17090720d500b0099329b3ab67sm6100960ejb.71.2023.08.29.08.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 08:23:26 -0700 (PDT)
Date:   Tue, 29 Aug 2023 17:23:25 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] libkmod: allow to fallback to user-space decompression
Message-ID: <ZO4NbbE8SvVkzN6R@righiandr-XPS-13-7390>
References: <20230829123808.325202-1-andrea.righi@canonical.com>
 <yxq5obi4rh2k54xw3fm6mtg36gmvluophe7slmc352wwccak27@2azm6bid2l5r>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yxq5obi4rh2k54xw3fm6mtg36gmvluophe7slmc352wwccak27@2azm6bid2l5r>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Aug 29, 2023 at 07:47:05AM -0700, Lucas De Marchi wrote:
> On Tue, Aug 29, 2023 at 02:38:08PM +0200, Andrea Righi wrote:
> > Fallback to user-space decompression when the kernel cannot allocate
> > enough memory to perform the decompression.
> > 
> > This can happen with large modules, such as xfs on linux 6.5 for
> > example, an ENOMEM would be returned and the module fails to load.
> > 
> > It seems more reliable to try again with user-space decompression
> > rather than reporting an error and failing to load the module.
> > 
> > Fixes: 09c9f8c ("libkmod: Use kernel decompression when available")
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > ---
> > libkmod/libkmod-module.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> > index 585da41..d2d4815 100644
> > --- a/libkmod/libkmod-module.c
> > +++ b/libkmod/libkmod-module.c
> > @@ -978,7 +978,7 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
> > 	}
> > 
> > 	err = do_finit_module(mod, flags, args);
> > -	if (err == -ENOSYS)
> > +	if (err == -ENOSYS || err == -ENOMEM)
> 
> oh... ENOMEM can be returned in several places. I don't think it's a great
> interface to just retry in userspace.
> 
> Luis, can we do better on the kernel side?
> 
> Andrea, did you track the exact location triggering the ENOMEM? Is it
> the return of kvmalloc_array() or alloc_page() from
> module_get_next_page()?  Or one of the previous kmalloc we use for the
> different deflate methods?

It was this kmalloc() right here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/module/decompress.c?h=v6.5#n244

For the records, I've also sent this patch to address the issue from a
kernel perspective:
https://lore.kernel.org/lkml/20230829120508.317611-1-andrea.righi@canonical.com/T/#u

That seems to solve the issue in my particular case, but I'm not sure if
that's a valid solution across all architectures.

Thanks,
-Andrea
