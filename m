Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC06DC11F67
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jul 2021 21:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A1D613C7
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jul 2021 21:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhGAVH1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGAVH1 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Jul 2021 17:07:27 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E0EC061762
        for <linux-modules@vger.kernel.org>; Thu,  1 Jul 2021 14:04:55 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id l26so4628042vsm.9
        for <linux-modules@vger.kernel.org>; Thu, 01 Jul 2021 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8zG0lXa1LkWpJy9vKopborSI43CzkGXr3W656qJ8sA0=;
        b=Jnr48n2d/NJ1GLqjctd27gaXBq2+TxA9ZjzOFOk4wWPg3njxPM5E6W0xWUc4fYah/k
         ivm049VibO1KKQh7WKQ0l9hDPq6zSyX4uOZ2tg5Ht5CKG0iZFp6yhuOtMUF01/8+ABqy
         XDrDRTQbQXobxBzoe4U+E4GmYRfjnjfxMKNNPu2+UHx7Ce2i0FPm/C/ORvHAjiTzFrZc
         sayLatWvFcXmFj6RMCo3iMLksuOMwZqIREkcr8IjKApswyEbnwfCw+6JOdvh6qKFbuwH
         VedI5k12/ITjS69vShraZCPg9RneiX3A/MTeDywTXCcO8g0YtHOPBmU4T47E+aOaP5dS
         35VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8zG0lXa1LkWpJy9vKopborSI43CzkGXr3W656qJ8sA0=;
        b=khGxL/ocC8k/SnGGslb4w4Z+EeiYF+jDdm56IOlHcHixxxqhWqw1vLVwIg4ofnn9xX
         XQ/0s3igsBWYwTjyDUQuSRIzOJiamkVYdxKbz1iXW/kQlN7c41i018jHY1CsdM5XMtoz
         BSwPnC9pWpMxnevTKnz7KTVDDbaFzcLSaqjmBhshnL9eNfqw4G/vnap/J2CMN0cCOMGz
         +jdhaoOXFyJ0OebY/f+e12aOYziBMMVNYSggA8EiGoXbRNxDQLA1UatKa1EHnC/GjXhS
         muSpca3Qp0yfYhF4QrtC6+cGiFf9ku3yJtFb+Pa0KlZffv9UUqzLIITargEltMOipFRn
         VI2Q==
X-Gm-Message-State: AOAM531IDhxnrFH2JdBshLDCnb6I8NnEjHw6NvLDsquGIVSzr3QQ3NPw
        rAkp0qz83s1hMP1qy0Wh2j6tnQTQOMMuP9SqbMM=
X-Google-Smtp-Source: ABdhPJzWN6cfd6S8WeqlDeUvGlstPtxTwYYUI3aKuKGvSQl8A3Eg1pbtrw2JUC9wDclLTaotoVK5aRoLCpZb131t9/o=
X-Received: by 2002:a05:6102:ed6:: with SMTP id m22mr2575285vst.60.1625173494232;
 Thu, 01 Jul 2021 14:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <30faa352-0f60-10b9-887e-b2ee522d0a16@gmail.com>
 <YN4Ccf96sqMoPJM3@kroah.com> <b6e41740-94b7-e32e-5d57-deb7b730b2d9@gmail.com>
In-Reply-To: <b6e41740-94b7-e32e-5d57-deb7b730b2d9@gmail.com>
From:   jim.cromie@gmail.com
Date:   Thu, 1 Jul 2021 15:04:28 -0600
Message-ID: <CAJfuBxwoFGh9ei=_GEe4V8f7vMtH-G-pdOy4CvQKi-2nHeBQ8g@mail.gmail.com>
Subject: Re: Seeking advice on "monkey patching" a driver
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     Greg KH <greg@kroah.com>, linux-modules@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jul 1, 2021 at 2:03 PM Ian Pilcher <arequipeno@gmail.com> wrote:
>
> On 7/1/21 12:59 PM, Greg KH wrote:
> > Oh that's horrible, please no, do not do that :)
>
> Indeed it is, but it works, and it meets my main objective, which is to
> allow the use of distribution kernel packages and modules.
>
> > How about a third option, the correct one:
> >       - submit your code changes upstream and they get merged into the
> >         main kernel tree and no monkeypatching is ever needed at all!
> >
> > Have you submitted your changes upstream to the existing drivers?  What
> > is preventing that from happening today?
>
> There are a couple of reasons that I've never attempted to do this.
>
> * Scope of work - Currently, there is simply no mechanism to call an LED
> * (Probable) lack of upstream interest - As I mentioned, disk activity
>    LEDs really ought to be handled by the hardware.

Are LEDs really that important?
Unless theyre rigged intrinsically into the operation, it seems tertiary



  I don't know of any
>    other system that suffers from this particular limitation.  So this
>    is a very, very niche use case.  (Most users of this hardware use the
>    manufacturer's "firmware".)
>
>    I did ask about this on the linux-ide mailing list long ago when I
>    first wrote the modules, but I don't think that I ever received a
>    response, which reinforces my belief that upstream isn't likely to be
>    receptive.
>

theres a firehose of patches.

FWIW, now robots watch the list, and will grind your patches on lots
of configs. arches



> I've invested significant time in kernel patches in the past, only to
> see them ultimately not be accepted, so I would need to know that
> upstream was truly interested in such a feature before I would consider
> making such a commitment.
>

no guarantees, but there is staging. (here, more or less)
provisional home for code while quality develops
once youre in-tree, warts and all (to some extent, I dont know)
you may well get help (patches) improving it, surely lots of feedback.



elsewhere, nobody knows it exists.
