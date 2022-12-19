Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA66C4332F
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 19:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiLSTzy (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 14:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiLSTzu (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 14:55:50 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E4C5F60
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 11:55:48 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id d185so9867590vsd.0
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 11:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KMPbr/YqIXmXwH4UmLhkRJRaeSJKDsuAYf/cvCUotS0=;
        b=JpMeMxjvXxZF5MEHqZayj5kCkPsZw/v9lr0jnSiFzpXYQ8kVg8iUdarQ0ZwCC3eid2
         5NbdCGtZK/moRBdE/R16LNGoegKeWtD/FyfaJZkjNMa5qOfteNHoPl4oFZVNho09xf9Z
         3OR33V9DPWN8q/CxdrR5lPNHhqAVBfBbz/Df2pAvm3QdXyaAo7YqVXfOCjTHcuLJTVna
         r7MjQWa6GNmtFg/SeWc+HFM+d8YiEChdCE0yEBP3zxjoRl3DQclE9dm7CVpNUeTi3vpK
         rhbZ5MUJv2aanF5paAGM6VEvr3aEY0hKnnrBdvojifmah98JYDzAtmhzshMNQXWE66Di
         iSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMPbr/YqIXmXwH4UmLhkRJRaeSJKDsuAYf/cvCUotS0=;
        b=BPl1mkhd6o9Mzf5vRph8pVjzv+GPqQbkmEtcyIho6eaiJWjbUNJeIgEgTpd8Dt+yjB
         eKzNgKTYr3bXuH+CpUK5X77puo6SkIqkfK14WmrprJiqkoiLSRWn1vSnwey5XLHtEzhR
         HVtu+XKny1JAxfBBdygcovSUbkpLYoPCZ7/DCMyujeFtIQefvU3M2Hn1LTzCm4lULMNQ
         nk0DU2eXiCJ6V5z6dg/E/r4LMv0AFmJIGLcT746j4yIcABWJf0NLQGS5DwKjSbJ9Ihwr
         l2OPdNPwUWymc1J/e2jKyE9PJssJwqPjfGQxNF5UtAO/dvjpOcs4IrWBtsRx5Ia35+yI
         icHw==
X-Gm-Message-State: AFqh2krXaomD4zsj5vZcTV5AKr+f3SzSquwBQf3UGAWW2qsOv1sOlCfk
        Dq1bukaQCPkLUo/zyAqgFm6RoPDPCjex3oClTa6BnQ==
X-Google-Smtp-Source: AMrXdXuk31U8gOC1dwtmajZncAh/L7BZwuM0SGNgvvkcZrF/5iJujZch9A45gqAV66xPjI+D9fyJBSlAzehmHEo/6OU=
X-Received: by 2002:a67:ffd5:0:b0:3bc:441f:a808 with SMTP id
 w21-20020a67ffd5000000b003bc441fa808mr940637vsq.36.1671479747842; Mon, 19 Dec
 2022 11:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com> <20221219191855.2010466-1-allenwebb@google.com>
 <20221219191855.2010466-2-allenwebb@google.com> <Y6C51KVSviGrLmsb@kroah.com>
In-Reply-To: <Y6C51KVSviGrLmsb@kroah.com>
From:   Allen Webb <allenwebb@google.com>
Date:   Mon, 19 Dec 2022 13:55:36 -0600
Message-ID: <CAJzde04Cyw+GswLE0-uKNOXEHe9FH34zmR248MDXE=SB6DgN6g@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] imx: Fix typo
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Dec 19, 2022 at 1:22 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 19, 2022 at 01:18:47PM -0600, Allen Webb wrote:
> > A one character difference in the name supplied to MODULE_DEVICE_TABLE
> > breaks a future patch set, so fix the typo.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Allen Webb <allenwebb@google.com>
> > ---
> >  drivers/soc/imx/imx8mp-blk-ctrl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
> > index 0e3b6ba22f943..344a0a71df14a 100644
> > --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> > +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> > @@ -743,7 +743,7 @@ static const struct of_device_id imx8mp_blk_ctrl_of_match[] = {
> >               /* Sentinel */
> >       }
> >  };
> > -MODULE_DEVICE_TABLE(of, imx8m_blk_ctrl_of_match);
> > +MODULE_DEVICE_TABLE(of, imx8mp_blk_ctrl_of_match);
>
> What commit id does this fix?  Shouldn't this be also cc: stable to
> resolve this issue for older kernels as obviousl the module device table
> for auto-loading is not correct?

I have included Cc stable and Fixes: for the three patches that were
obvious typos and will upload a follow-up series shortly. It is
unlikely these drivers were being built as modules because the build
would have been broken for that configuration.

This seems to be the most recent case so it is the most likely to make
a difference, but I would imagine SOC drivers might not be loadable in
practice if they are needed to bootstrap the system to a point that
loadable modules can be accessed.

>
> thanks,
>
> greg k-h
