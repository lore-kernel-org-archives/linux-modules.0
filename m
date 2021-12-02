Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246ECC433EF
	for <linux-modules@archiver.kernel.org>; Thu,  2 Dec 2021 08:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhLBIRn (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 2 Dec 2021 03:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356049AbhLBIRm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 2 Dec 2021 03:17:42 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB01C06174A
        for <linux-modules@vger.kernel.org>; Thu,  2 Dec 2021 00:14:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so1802932pjb.5
        for <linux-modules@vger.kernel.org>; Thu, 02 Dec 2021 00:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJxQPii2eM0OjBaUwzKIAcC+30dSRaA4PHYRb7ql8XY=;
        b=mLsFwzeKWy8lpWdemNEIznpcOmPd8Klm6htYELaEZuTsuz2LVe/lGSQZovS0UxMneQ
         aGgF++CyK5fTIqhwAoV3NN23HmbAVNMp5uTi7ag4pncBHEF54KrCiiXWd11WI9iZuR05
         xGNf7KR3luZ+wTalqKYsf25tGiGVLnI+CcTc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJxQPii2eM0OjBaUwzKIAcC+30dSRaA4PHYRb7ql8XY=;
        b=ffdSHTiK5GIWxCiHGDggq3tbKlon5qZ7pH9swkcMJTqbHLxw3V79X7o5H7JSW97LV/
         P8MqdwXDqqwKVdKAn0Z0gPpcaedwvQbrVrafEB+3+XFLgP9elinAGCoDvrCWS9babgXp
         j3NEDvXaEIpn6OLzYHl8BHwn3L04qQzL7X2t4Z/EZFfjxXkdyd5LVXoovw0XS2QlKoTx
         tYZNusgKvI9cxqgFeBei6eySYxoPiQORgtg+hy0U/UkS2g7EWStuSifpVsrbMHD89sOo
         hizSz7HhYG5KBG2GIUptesltoz8mxE4woYn3iCDyiNqOSyBuvPQSPANyjPsSIfB6WR/9
         Dxkw==
X-Gm-Message-State: AOAM5310sHtHMfIHsERYk2WTdrLTFJZumpudRm1Zs0j2IItrCJYbKvZs
        SQEyRT4AiTihuOvNOWTRndrKnNYGwY9W5A==
X-Google-Smtp-Source: ABdhPJw5UHuID70Zi2x18cwMdDKJ9F7/Xbo83ZPrNqO2xBrXz/vvr5BGHj+4KwiELOwY02vQ4jWicA==
X-Received: by 2002:a17:902:d395:b0:141:a913:1920 with SMTP id e21-20020a170902d39500b00141a9131920mr13872811pld.81.1638432859544;
        Thu, 02 Dec 2021 00:14:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm2510371pfi.154.2021.12.02.00.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 00:14:19 -0800 (PST)
Date:   Thu, 2 Dec 2021 00:14:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] module: add in-kernel support for decompressing
Message-ID: <202112020012.8B4C205@keescook>
References: <YaMYJv539OEBz5B/@google.com>
 <202112011112.83416FCA2C@keescook>
 <YafYvA5JWMgb6PVy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YafYvA5JWMgb6PVy@google.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Dec 01, 2021 at 12:19:08PM -0800, Dmitry Torokhov wrote:
> On Wed, Dec 01, 2021 at 11:24:35AM -0800, Kees Cook wrote:
> > On Sat, Nov 27, 2021 at 09:48:22PM -0800, Dmitry Torokhov wrote:
> > >  /* Flags for sys_finit_module: */
> > >  #define MODULE_INIT_IGNORE_MODVERSIONS	1
> > >  #define MODULE_INIT_IGNORE_VERMAGIC	2
> > > +#define MODULE_INIT_COMPRESSED_DATA	4
> > 
> > bikeshedding: adding "_DATA" seems redundant/misleading? The entire
> > module is compressed, so maybe call it just MODULE_INIT_COMPRESSED ?
> 
> OK, or maybe MODULE_INIT_COMPRESSED_FILE since we are indeed dealing
> with a file?

Sounds good to me! :)

As far as my tangent on using the crypto subsystem, I think that looks
like a long path, so your existing routines are likely the right place
to start. I still wonder if it might be able to use of the "acomp" API
instead of calling directly into the specific decompressor.

-- 
Kees Cook
