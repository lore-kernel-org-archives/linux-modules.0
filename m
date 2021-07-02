Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192FBC11F68
	for <linux-modules@archiver.kernel.org>; Fri,  2 Jul 2021 12:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E77A561427
	for <linux-modules@archiver.kernel.org>; Fri,  2 Jul 2021 12:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhGBMWp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 2 Jul 2021 08:22:45 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55833 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232017AbhGBMWo (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 2 Jul 2021 08:22:44 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 711565C0163;
        Fri,  2 Jul 2021 08:20:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 02 Jul 2021 08:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=QubUKMVAG9lGj1Ehpm1o5Hmq/1L
        AaxgfRcq6HBYILCQ=; b=YevLIX2+Gk8caBD8Bfhjxxue79dFGJj3xSZBcZ8kx5O
        x57CTeBVoYv+KyNKRpsZ89PTinjuciaxfYk9NouvRKM+hc6O3FiUMnDw9d2n+Fnh
        o+9OTa8D2C4Sw9G9UNkEpVEpJC1BFT+BvdkpxU8NgEYMtW9iibEEPa3uqt2vuDkM
        ZPebfwW+K1qazFot7jw+XQVTvOQpqpV2m7SYzQ6HwqE9S7F1N0N6+ILuPWDOqgaF
        +VqfJ9uGXShVyeN+D/reBycW6vuVfHvNd7OF4sSuDKqW+H/IVLq0LnHfdXC9mHi7
        1X2h/8TujPOnWHucnryIszAbW2A44FsqlCOwuspdkvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QubUKM
        VAG9lGj1Ehpm1o5Hmq/1LAaxgfRcq6HBYILCQ=; b=mimYhhjpjdKPLVtx+Awhki
        zrDwmyp1zIf+BZ5ITV1tVkWci+vpZbWoshS3PHyZYLTks5oSUbjay88CVVwxc8Al
        J/6wV9M0bQqJMtYL1HN60FYWsJDtIZExdSSytb7gMjQFXJRsOkoDwB35mgNFodPn
        Hy1x3v+bJO+B8Wdeq/EIt5MMzVOtRXu46HjHABp4ch4noALf5Il1L2GxF0fhYxLp
        nHzB2DgGMd6VQc+RJU5DjURzd0NxPqta6UJOAhXn9jgfTLVFPI7teOY8y96aT0Ja
        vJV7n+DtEEe5aPFQIoy+nLTEYtWQPRKV0hgbvCne7ukwEVYIC5WwJpQ8NzSBL8yQ
        ==
X-ME-Sender: <xms:fATfYB7_pixnsrRQMh6p9KmeEZYrI4OmTeaXPf1nv1p3sUECUImgew>
    <xme:fATfYO6v7YctehaMMH2ve1ivoNgu3AtkVfghrBsu4NRYmzU6nZW-Sw9vDdMG9A4k0
    K5oxWA7u-O06w>
X-ME-Received: <xmr:fATfYIcUDPfGBGLTXvRUHbA1shY4DTeeK_PRUruDsR77d5qWmOpq0Xge4SV9j83ZmiDUsz4rO8XKM9q5U4qWl5CTU88LXkhs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeikedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:fATfYKJz7U3ZgYcy8IhUniNSEEScnhx6qk4ftDKwyCfU4GDpi0R4nw>
    <xmx:fATfYFKMmdVXvd_HH_4p_ynPQEUTihrMPjZcT9d0cZtM2OKpscoeNw>
    <xmx:fATfYDwH8d6TM2RWAGJVjUWda4mndELubd4MINRphP0Wh3UhifOVyw>
    <xmx:fATfYCENiPdwxfbjkU0htbFhd0U9_qfEFHWwl_BQ-rxeuzoKgF1erw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jul 2021 08:20:11 -0400 (EDT)
Date:   Fri, 2 Jul 2021 14:20:09 +0200
From:   Greg KH <greg@kroah.com>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     linux-modules@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: Re: Seeking advice on "monkey patching" a driver
Message-ID: <YN8EecLokJuHrptR@kroah.com>
References: <30faa352-0f60-10b9-887e-b2ee522d0a16@gmail.com>
 <YN4Ccf96sqMoPJM3@kroah.com>
 <b6e41740-94b7-e32e-5d57-deb7b730b2d9@gmail.com>
 <YN6Wml2QT2ZfppA2@kroah.com>
 <5c34419f-ef7d-a9bd-0c90-c77e2526b739@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c34419f-ef7d-a9bd-0c90-c77e2526b739@gmail.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jul 02, 2021 at 07:05:26AM -0500, Ian Pilcher wrote:
> > > I've invested significant time in kernel patches in the past, only to
> > > see them ultimately not be accepted, so I would need to know that
> > > upstream was truly interested in such a feature before I would consider
> > > making such a commitment.
> > 
> > That's not fair, there is no way anyone can promise anyone that their
> > patches will be accepted, _before_ anyone sees them.  What would _you_
> > do if you were in the kernel maintainer's position and read something
> > like this?
> 
> You're right, but that isn't what I intended to say.  Basically, I can't
> afford to invest the time in implementing something if the subsystem
> maintainers have no interest in the *functionality*, regardless of the
> state of the code.  I.e., if the ATA/LED subsystem maintainers think
> that  software-controlled disk activity LEDs are stupid and have no
> place in the kernel, then code quality is irrelevant, and anything I do
> will be a waste of time.

Again, without a real patch, no maintainer or developer will ever say if
they will, or will not, accept such a thing.  That's just not how kernel
development works.  Working patches are what is discussed as that proves
that at least, the idea works.

thanks,

greg k-h
