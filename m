Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409D9C11F68
	for <linux-modules@archiver.kernel.org>; Fri,  2 Jul 2021 04:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27AC86141D
	for <linux-modules@archiver.kernel.org>; Fri,  2 Jul 2021 04:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhGBEd6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 2 Jul 2021 00:33:58 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48603 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhGBEd6 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 2 Jul 2021 00:33:58 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3BBE23200918;
        Fri,  2 Jul 2021 00:31:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 02 Jul 2021 00:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ZSco6ai+HKGcLMnrXE7k+lNDLid
        rd5v0IQPXWIs0O0U=; b=mQSiqZYlz0z1TsV9r2lJALCsq2lzTLLe8F0MP9hqWcp
        Kr54/CEjFUpGX7eMZ6LbwlpIecEAqdUwHWC3LJ7zO7OUN0LSK3OnJHMkYy/yANYW
        7FY3WAeYEsN4K2ZMEF0LTvNdRNlUQD1MlJezoXXdBCI+dW7tavKrO5+a236pOjzF
        ZbmjFxgSzIxzJEZcc2Qe1S0RqRx75g/pOe0yboJhvgx0Y5MIND48f3hGeRXRSxC4
        Zdq8zhg9NznPKxNQzRFhHTUbBm1KrcNO+o/fhruXNamR+aIF71FRR2JvznoZ6ejF
        qkcaZQPquiyPsReQkbPr+lgQBhpUHjMTKIIIhWN34Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZSco6a
        i+HKGcLMnrXE7k+lNDLidrd5v0IQPXWIs0O0U=; b=UmrzsIA3HgLLf1gWodv+RF
        C7MYOgRqE14yrZHPJ3+/t0gGAKkPiBj4k9RO4k8P6iUw/fee052weYcePBx9u6Df
        VLmmaImyZQunVPkg7g56GGcuTfrIrs9Yo8fbneAg+tqezETntto47mac8nNKUaEs
        jYDk1Hpz78DoIHab4OBpBqCmkTTa6JYp/PKr7P8cRmXhVs5Q6SKVwRDgdJiXkq/A
        NYJXLW8HM0kZBkOLR/sKRRWvBgZqZ7n1dYO8KARKJqyA6YkzLmOulxKQxAMm7+6I
        mvWh1e9mfCfJJ1fkoUrbRdU1KBddeCFA4uIsRNRdyYRuH3wuIXb/qaav/Bc/wsFg
        ==
X-ME-Sender: <xms:nZbeYBumhkCqZ9eIYkm4Ln-RQNlp7X2AFXnPnT3zZSMLCkTHEna3rg>
    <xme:nZbeYKcXa0WFuiRwXFz_j6CT6-azwOzZJq4dPcWYc12PJ8AKc7ryIoqnx8fmb9fy9
    kSyfvcV6_liUw>
X-ME-Received: <xmr:nZbeYEx0LV1PS4r43NhtD1J33HS7QDSdiK_e_GPKiu-C6YbRfmofXJzD5ucwEB4Iubz30Yqq51rRtZzyHXILrUXnu8NCo1XZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeijedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:nZbeYIM4yuW3IeXpn_8khWs2CDVdXdXduaLXNgGYLcwZPnzDc3GkrQ>
    <xmx:nZbeYB-G53TUYl6nh5kY_PlUDmHNEawkf9kfjnxCqGKvvLwpSpb5tQ>
    <xmx:nZbeYIWRjtCIhb4xm5WNTFwOCH49JA4fMD52vAf6t0Fq4AUIrP04rQ>
    <xmx:nZbeYNZx06xWQgOPghu89L5_Glqg_p1S1mM8QJkVcxaGAmCWaYTJdQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jul 2021 00:31:25 -0400 (EDT)
Date:   Fri, 2 Jul 2021 06:31:22 +0200
From:   Greg KH <greg@kroah.com>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     linux-modules@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: Re: Seeking advice on "monkey patching" a driver
Message-ID: <YN6Wml2QT2ZfppA2@kroah.com>
References: <30faa352-0f60-10b9-887e-b2ee522d0a16@gmail.com>
 <YN4Ccf96sqMoPJM3@kroah.com>
 <b6e41740-94b7-e32e-5d57-deb7b730b2d9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e41740-94b7-e32e-5d57-deb7b730b2d9@gmail.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jul 01, 2021 at 03:03:12PM -0500, Ian Pilcher wrote:
> On 7/1/21 12:59 PM, Greg KH wrote:
> > Oh that's horrible, please no, do not do that :)
> 
> Indeed it is, but it works, and it meets my main objective, which is to
> allow the use of distribution kernel packages and modules.
> 
> > How about a third option, the correct one:
> > 	- submit your code changes upstream and they get merged into the
> > 	  main kernel tree and no monkeypatching is ever needed at all!
> > 
> > Have you submitted your changes upstream to the existing drivers?  What
> > is preventing that from happening today?
> 
> There are a couple of reasons that I've never attempted to do this.
> 
> * Scope of work - Currently, there is simply no mechanism to call an LED
>   trigger from the ahci or libahci modules, presumably because this is
>   something that  really ought to be done by the hardware.  So I would
>   have to add some sort of generic framework to associate LED triggers
>   with AHCI ports.
> 
>   I probably also don't really have the knowledge to do this.  I am not
>   familiar with locking, memory management, etc. in the kernel.  Just
>   because my "hack" works on a specific 2-core NAS doesn't mean that it
>   won't cause all sorts of breakage on a higher-performance system with
>   more parallelism.

Why are ahci devices somehow "special" here?  Just add a trigger to the
ahci core for LEDs and all should "just work".  We've done that for many
subsystems already.

> * (Probable) lack of upstream interest - As I mentioned, disk activity
>   LEDs really ought to be handled by the hardware.  I don't know of any
>   other system that suffers from this particular limitation.  So this
>   is a very, very niche use case.  (Most users of this hardware use the
>   manufacturer's "firmware".)

Are you sure we don't already have LED triggers for disk activity?  Have
you tried the ledtrig-disk.c driver?  It says it works on ATA devices,
no reason it can't also work for other device types.

>   I did ask about this on the linux-ide mailing list long ago when I
>   first wrote the modules, but I don't think that I ever received a
>   response, which reinforces my belief that upstream isn't likely to be
>   receptive.
> 
> I've invested significant time in kernel patches in the past, only to
> see them ultimately not be accepted, so I would need to know that
> upstream was truly interested in such a feature before I would consider
> making such a commitment.

That's not fair, there is no way anyone can promise anyone that their
patches will be accepted, _before_ anyone sees them.  What would _you_
do if you were in the kernel maintainer's position and read something
like this?

good luck!

greg k-h
