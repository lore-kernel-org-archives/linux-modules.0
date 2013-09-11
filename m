Return-Path: <stern+52301582@rowland.harvard.edu>
Date: Wed, 11 Sep 2013 10:29:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
cc: Tom Gundersen <teg@jklm.no>,  <linux-usb@vger.kernel.org>,
    LKML <linux-kernel@vger.kernel.org>,
    "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: ohci/uhci - add soft dependencies on ehci_hcd
In-Reply-To: <CAKi4VAJeXoBu=kr8nhMJFneNwGFP8TFiDNNzdwQC4imyefe_jQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1309111015000.1352-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-modules.vger.kernel.org>

On Tue, 10 Sep 2013, Lucas De Marchi wrote:

> >>> > The ordering is more of a recommendation than a necessity.  Systems
> >>> > should work oksy if the modules are loaded in the wrong order.
> >>> >
> >>> > The only issue if the drivers are loaded in the wrong order is that
> >>> > full- and low-speed devices will end up being detected and enumerated
> >>> > twice, with a disconnection in between.  This can result in
> >>> > disconcerting messages appearing in the system log.
> >>> >
> >>> > In theory, it is possible for a problem to arise.  For example, suppose
> >>> > a full-speed flash drive is plugged in when the system starts up.
> >>> > When uhci-hcd or ohci-hcd gets loaded, the drive will be detected and
> >>> > it may even be mounted.  Then when ehci-hcd loads, the drive will get
> >>> > disconnected and reconnected.  Any open file references to the original
> >>> > mount will be orphaned.
> 
> Then IMO it should not only be advised to have this dependency, but
> also require it.

Requiring the ordering won't fix all the possible problems.  For
example, ehci-pci might be compiled into the kernel while ohci-pci is
built as a module (although this probably could be prevented by
tweaking the Kconfig file).

> >> So this means that before installing ohci-hcd, modprobe would attempt
> >> to install ehci-hcd?  And if the attempt failed, it would go ahead and
> >> load ohci-hcd anyway?
> >
> > Exactly.
> 
> Not really. If we try to load the module, but then fail we fail the
> operation altogether. Whereas if the module simply doesn't exist, then
> we carry on. In reality what we do is to assume the indexes and
> softdeps in configuration are correct)

What if somebody really does want to load ohci-pci without loading 
ehci-pci?  That is a perfectly valid thing to do (and I often want to 
do it for testing).

It sounds like the only way to accomplish this would be to load both 
and then unload ehci-pci.  Yes?  Or would that unload ohci-pci as well?

> >> What about during unloading?  Would this mean that rmmod ohci-hcd would
> >> automatically cause ehci-hcd to be unloaded also?  Or would unloading
> >> ehci-hcd cause ohci-hcd to be unloaded?
> >
> > No, unloading does not care about dependencies.
> 
> modprobe -r will remove then as well, in the opposite order, i.e. post
> softdep, module, pre softdep.  However this applies only to modprobe,
> not to the related function in libkmod since it would be weird to
> other programs using this library function.

Aside from testing, people hardly ever unload drivers.  So this is a 
relatively minor concern.

> Try playing with this in /etc/modprobe.d/bla.conf (and replace echo
> with whatever unknown command to test a failure scenario):
> install bla echo install bla
> remove bla echo remove bla
> softdep sr_mod pre: bla

Good recommendation.

Alan Stern
