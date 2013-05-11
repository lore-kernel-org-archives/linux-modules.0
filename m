Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:61853 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474Ab3EKRxw (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Sat, 11 May 2013 13:53:52 -0400
Received: from [192.168.0.7] ([188.105.208.203]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lh6fv-1UDlGb3v3n-00oTP8 for
 <linux-modules@vger.kernel.org>; Sat, 11 May 2013 19:53:51 +0200
Subject: Re: depmod difference between module-init-tools and kmod
From: Stefan Achatz <stefan_achatz@web.de>
To: linux-modules@vger.kernel.org
In-Reply-To: <CAKi4VAJd5AGRfJ2otK5P_RJ2JFdiPDm8K=iHk5CLih4e=zuovg@mail.gmail.com>
References: <1367765701.2383.11.camel@neuromancer.tessier-ashpool>
	 <CAKi4VAJd5AGRfJ2otK5P_RJ2JFdiPDm8K=iHk5CLih4e=zuovg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 11 May 2013 19:53:50 +0200
Message-ID: <1368294830.2403.11.camel@neuromancer.tessier-ashpool>
Mime-Version: 1.0
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Am Montag, den 06.05.2013, 12:59 -0300 schrieb Lucas De Marchi:
> Hi Stefan,
> 
> On Sun, May 5, 2013 at 11:55 AM, Stefan Achatz <stefan_achatz@web.de> wrote:
> > Hello,
> >
> > I'm writing kernel modules for usb peripheries that are in mainline kernel and
> > also available as external compileable package[1].
> >
> > The external modules have the newest code before it gets into the next kernel,
> > also backported for older kernels. To distinguish between outdated kernel
> > included and newer external modules they have different names. The device
> > specific kernel internal modules are called hid-roccat-* whereas the external
> > ones are called just *. This way a blacklist can prohibit loading the internal
> > modules when the external are installed.
> 
> Since depmod (both from kmod and module-init-tools) doesn't know
> anything about blacklists it can't rely on this existing so to not
> creating "invalid" indexes.
> 
> Taking a look on our current implementation, it looks like we fail on
> warning about duplicate symbols while inserting them on hash table to
> calculate the dependencies. I guess this only worked for you on
> module-init-tools by luck since its  hash table allows duplicate
> entries, but then on lookup you will get the first one, depending on
> the order in which they were inserted. IMO it seems a very weak
> guarantee on which module will get.
> 
> 
> >
> > Nevertheless, having both, internal and external, modules installed leads to
> > double symbols. depmod from module-init-tools has no problem with that (some
> > of the last versions tested), where the variant from kmod has its problem (v5
> > up to v12 tested). I observed this using Fedora 18, which seems to be the first
> > distro that uses kmods depmod.
> >
> > Some outputs of both depmods for comparison are further down this text.
> >
> > My question: Should this behaviour be fixed in kmods depmod, or is there a
> > intended, perhaps more intelligent, way for me to do what I intend?
> 
> I'd propose you check if the following scheme fits your needs:
> 
> 1) change the external modules to have the same names as the internal ones
> 2) install a file under /usr/lib/depmod.d/module-name.conf containing
> an "override" line - see depmod.d(5)
> or
> 2a) Use a .conf file with "search" keyword, ensuring its priority is
> higher than the standard ones

I chose the override method and got no complaints from users so far.
DKMS doesn't even need the config file since it ensures uniqueness
itself by moving the original modules to a backup location if the
modules have the same names.

Thanks for helping
Stefan

