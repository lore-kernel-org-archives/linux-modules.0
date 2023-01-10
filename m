Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A905C678D6
	for <linux-modules@archiver.kernel.org>; Tue, 10 Jan 2023 18:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbjAJSXs (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 10 Jan 2023 13:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbjAJSXH (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 10 Jan 2023 13:23:07 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174472F789
        for <linux-modules@vger.kernel.org>; Tue, 10 Jan 2023 10:21:09 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id 3so13164634vsq.7
        for <linux-modules@vger.kernel.org>; Tue, 10 Jan 2023 10:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LhqMrGa+5XAAvhdm/qvpg845MSH/5HVvI+D0qxBhnAg=;
        b=crr5n8812Ux90csqTMCY/9ikO5dYLT3PeVDNtY+owxJs8/cjRLyN1GSEJqAArFKTYb
         agQgQUwTuvIk9IQJxSP3rIKMlMQQlzgZEm4UGHvaULonPAeeMu73bl3cW6yHbKm/gHnT
         VqwKyMPjuXBIPRtGhzahm/OC2GLvx+fTbDdII7YqlezLFaEA3Z5yaoD48lRrA6tBlvo+
         0yxanczW/1ondR9hgf5yumrJMu5vbWR3VjOvdhSx4UFkpxn0npAqkikgciwgs8Gc6Bo+
         1CXEuVECVkCIhYvgGqzVj79z+0RpAb8DXUwEvEymg6QjPG5b8GCmPVOQaTDukOJjmKOZ
         uG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhqMrGa+5XAAvhdm/qvpg845MSH/5HVvI+D0qxBhnAg=;
        b=yNsq0OSosBDguq5ZiofEDXWHaz4617lzGONN+DSa2+5w5/tnYnMHP+en70C1qnZcXt
         R9GXJbQ59/EpYWS1JO+C/V2Rvr/cx9MJ6Qsi6KQSUBfCon8BklTP7xH9e95nv9k+Lrsd
         R7+9dKOquqW4CbBxm+wPexculRkWgpwAm1XOxi9g5+ON6454uDNNGX6jj0ZPD0nKMJ2U
         +/uT1pXLOXFZW2+98E2BImR/tXfhmkG4ZOqeITAuDn5LhHtussz6UnEPCl7+bG/Azc4h
         rxPjs0UVLKd/pWIVCkc3kIrL7H7zI8iO4mcWU/ooZLqg1cKFPMuMREDsMkwLwkUtkk87
         VeMw==
X-Gm-Message-State: AFqh2kq3yo1HRIVHPQtVrFvg5c9Y456epmiH1e13HJjVp3m5Kf8JL1Jy
        VyKS57HXCmUwsDpWbcJk3xkAOm83VOMYbAXF/0xTFQ==
X-Google-Smtp-Source: AMrXdXulHZB8SHI/FLgkZGq1+rQO1MVRnWBVjyA9v3ohzuwYh+ownssImMjB38Pe8P3yocbk2Q10H0Wvk/BKaCPzyt8=
X-Received: by 2002:a05:6102:94e:b0:3b5:1de3:19fa with SMTP id
 a14-20020a056102094e00b003b51de319famr8349620vsi.35.1673374867880; Tue, 10
 Jan 2023 10:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com>
 <20221219204619.2205248-1-allenwebb@google.com> <20221219204619.2205248-3-allenwebb@google.com>
 <Y6FaUynXTrYD6OYT@kroah.com> <CAJzde04Hbd2+s-Bqog2V81dBEeZD7WWaFCf2BkesQS4yUAKiNA@mail.gmail.com>
 <Y6H6/U0w96Z4kpDn@bombadil.infradead.org> <CAJzde04igO0LJ46Hsbcm-hJBFtPdqJC6svaoMkb3WBG0e1fGBw@mail.gmail.com>
 <Y6IDOwxOxZpsdtiu@bombadil.infradead.org> <87cz7nsz24.fsf@esperi.org.uk>
In-Reply-To: <87cz7nsz24.fsf@esperi.org.uk>
From:   Allen Webb <allenwebb@google.com>
Date:   Tue, 10 Jan 2023 12:20:56 -0600
Message-ID: <CAJzde05oSJuxSz1dBjxXppu39kcbNvZt1tP6QRxkHAqy94c-9w@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] rockchip-mailbox: Fix typo
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 9, 2023 at 5:54 AM Nick Alcock <nick.alcock@oracle.com> wrote:
>
> On 20 Dec 2022, Luis Chamberlain uttered the following:
> >> It also raises the question how many modules have device tables, but
> >> do not call MODULE_DEVICE_TABLE since they are only ever built-in.
> >> Maybe there should be some build time enforcement mechanism to make
> >> sure that these are consistent.
> >
> > Definitely, Nick Alcock is doing some related work where the semantics
> > of built-in modules needs to be clearer, he for instance is now removing
> > a few MODULE_() macros for things which *are never* modules, and this is
> > because after commit 8b41fc4454e ("kbuild: create modules.builtin
> > without Makefile.modbuiltin or tristate.conf") we rely on the module
> > license tag to generate the modules.builtin file. Without that commit
> > we end up traversing the source tree twice. Nick's work builds on
> > that work and futher clarifies these semantics by adding tooling which
> > complains when something which is *never* capable of being a module
> > uses module macros. The macro you are extending, MODULE_DEVICE_TABLE(),
> > today is a no-op for built-in, but you are adding support to extend it
> > for built-in stuff. Nick's work will help with clarifying symbol locality
> > and so he may be interested in your association for the data in
> > MODULE_DEVICE_TABLE and how you associate to a respective would-be
> > module. His work is useful for making tracing more accurate with respect
> > to symbol associations, so the data in MODULE_DEVICE_TABLE() may be
> > useful as well to him.
>
> The kallmodsyms module info (and, thus, modules.builtin) and
> MODULE_DEVICE_TABLE do seem interestingly related. I wonder if we can in
> future reuse at least the module names so we can save a few KiB more
> space... (in this case, the canonical copy should probably be the one in
> kallmodsyms, because that lets kallmodsyms reuse strings where modules
> and their source file have similar names. Something for the future...)

It appeared to me like the symbols added for MODULE_DEVICE_TABLE are
only needed temporarily and could be stripped as part of the final
linking step. This would make space less of a concern, but extern
variables don't support the visibility attribute and in the build I am
using the space difference is less than 1MB out of 613MB for the
uncompressed kernel.

>
> > You folks may want to Cc each other on your patches.
>
> I'd welcome that.
>
> btw, do you want another kallmodsyms patch series from me just arranging
> to drop fewer MODULE_ entries from non-modules (just MODULE_LICENSE) or
> would this be considered noise for now? (Are we deadlocked on each
> other, or are you still looking at the last series I sent, which I think
> was v10 in late November?)

For now I just need MODULE_DEVICE_TABLE to stick around for USB and
thunderbolt related modules (including built-in modules), so if you
aren't removing it for any then I don't think we are blocking each
other.

Longer term it makes sense to have MODULE_DEVICE_TABLE for any module
that makes use of a subsystem that had the authorized attribute. While
this is currently just USB/thunderbolt it could expand in the future,
but there are subsystems where it is likely to make no difference.

We might have a tiny amount of redundancy in our patch sets because
there are some cases of invalid MODULE_DEVICE_TABLE entries I fixed in
my patch series, but that could be dropped. These have the potential
for conflicts / blocking each other, but it should be easy to resolve
them if I change my fixes to a removal of the MODULE_DEVICE_TABLE
entries.

>
> --
> NULL && (void)
