Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from shell.v3.sk ([92.60.52.57]:52417 "EHLO shell.v3.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857AbcCBQ2W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 2 Mar 2016 11:28:22 -0500
Message-ID: <1456936094.32064.40.camel@v3.sk>
Subject: Re: [PATCH] modprobe: install default configuration
From: Lubomir Rintel <lkundrak@v3.sk>
To: "De Marchi, Lucas" <lucas.demarchi@intel.com>,
	"md@Linux.IT" <md@Linux.IT>
Cc: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Date: Wed, 02 Mar 2016 17:28:14 +0100
In-Reply-To: <1456934860.3200.4.camel@intel.com>
References: <1456931893-13545-1-git-send-email-lkundrak@v3.sk>
	 <20160302155551.GA31679@bongo.bofh.it> <1456934860.3200.4.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Wed, 2016-03-02 at 16:07 +0000, De Marchi, Lucas wrote:
> On Wed, 2016-03-02 at 16:55 +0100, Marco d'Itri wrote:
> > 
> > On Mar 02, Lubomir Rintel <lkundrak@v3.sk> wrote:
> > 
> > > 
> > > 
> > > The kernel maintainers seem opposed to fixing this in kernel
> > > (despite a similar
> > > thing has been done with loop block devices) [1]. Let's fix this
> > > my
> > > overriding the
> > > defaults from userspace.
> > Because, guess what? This breaks userspace.
> > Feel free to configure your system this way if it is what you want.
> More context: https://github.com/systemd/systemd/pull/2778
> 
> Marco, could you be more specific on how this breaks userspace? It
> seems already pretty much broken to me. We can even argue if people
> wants the broken system back they can equally well configure their
> system to do that (even putting on /etc to override what was set on
> /usr/lib).
> 
> The commit message doesn't reflect the feedback from kernel
> maintainers
> very well IMO.  Main argument there was the compile-time option
> rather
> than allowing it to be in runtime like this one.

I thought that this part of feedback was a bit uninformed or there has
been some misunderstanding (perhaps on my side). There already are
options; the kernel patch just changed defaults for the options -- not
hardcoding the values or anything like that; just allowing to choose
different defaults at compile time.

The point was that if the user merely does "make oldconfig" to update
his kernel configuration the behavior wouldn't change. Thus it would be
safe for anyone to install an new kernel on an old distro even if
they're relying on the ancient behavior.

On the other hand, it would still allow for behavior change on distro
upgrades. I'm assuming it's okay to do that -- far bigger changes
regularly occur and users of exotic interfaces often end up adjusting
their tooling on major upgrades.

To me, the important part of the netdev@ feedback is: this is
unnecessary in kernel since it could be equally well done in userspace.

> Lucas De Marchi

Lubo
