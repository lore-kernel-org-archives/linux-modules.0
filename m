Return-Path: <lkundrak@v3.sk>
Message-ID: <1459247226.25498.30.camel@v3.sk>
Subject: Re: [PATCH] modprobe: install default configuration
From: Lubomir Rintel <lkundrak@v3.sk>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: "De Marchi, Lucas" <lucas.demarchi@intel.com>, "md@Linux.IT"
 <md@linux.it>,  "linux-modules@vger.kernel.org"
 <linux-modules@vger.kernel.org>
Date: Tue, 29 Mar 2016 12:27:06 +0200
In-Reply-To: <CAKi4VA+B7YOpVV5ogUqx4HuL2re=C7D+1aaB_VRjP0F9tUNF6g@mail.gmail.com>
References: <1456931893-13545-1-git-send-email-lkundrak@v3.sk>
	 <20160302155551.GA31679@bongo.bofh.it> <1456934860.3200.4.camel@intel.com>
	 <1456936094.32064.40.camel@v3.sk>
	 <CAKi4VA+B7YOpVV5ogUqx4HuL2re=C7D+1aaB_VRjP0F9tUNF6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-modules.vger.kernel.org>

On Fri, 2016-03-04 at 02:02 -0300, Lucas De Marchi wrote:
> On Wed, Mar 2, 2016 at 1:28 PM, Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> >=20
> > On Wed, 2016-03-02 at 16:07 +0000, De Marchi, Lucas wrote:
> > >=20
> > > On Wed, 2016-03-02 at 16:55 +0100, Marco d'Itri wrote:
> > > >=20
> > > >=20
> > > > On Mar 02, Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > >=20
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > The kernel maintainers seem opposed to fixing this in kernel
> > > > > (despite a similar
> > > > > thing has been done with loop block devices) [1]. Let's fix
> > > > > this
> > > > > my
> > > > > overriding the
> > > > > defaults from userspace.
> > > > Because, guess what? This breaks userspace.
> > > > Feel free to configure your system this way if it is what you
> > > > want.
> > > More context: https://github.com/systemd/systemd/pull/2778
> > >=20
> > > Marco, could you be more specific on how this breaks userspace?
> > > It
> > > seems already pretty much broken to me. We can even argue if
> > > people
> > > wants the broken system back they can equally well configure
> > > their
> > > system to do that (even putting on /etc to override what was set
> > > on
> > > /usr/lib).
> > >=20
> > > The commit message doesn't reflect the feedback from kernel
> > > maintainers
> > > very well IMO.=C2=A0=C2=A0Main argument there was the compile-time =
option
> > > rather
> > > than allowing it to be in runtime like this one.
> > I thought that this part of feedback was a bit uninformed or there
> > has
> > been some misunderstanding (perhaps on my side). There already are
> > options; the kernel patch just changed defaults for the options --
> > not
> > hardcoding the values or anything like that; just allowing to
> > choose
> > different defaults at compile time.
> >=20
> > The point was that if the user merely does "make oldconfig" to
> > update
> > his kernel configuration the behavior wouldn't change. Thus it
> > would be
> > safe for anyone to install an new kernel on an old distro even if
> > they're relying on the ancient behavior.
> >=20
> > On the other hand, it would still allow for behavior change on
> > distro
> > upgrades. I'm assuming it's okay to do that -- far bigger changes
> > regularly occur and users of exotic interfaces often end up
> > adjusting
> > their tooling on major upgrades.
> I would say the better patch to the kernel would be to bite the
> bullet
> and change the default.
> The default is bad as shown by your example and people complaining
> about the behavior. With a patch to kmod we are acknowledging the
> default is bad and changing it, just like we would be if the patch to
> the kernel was applied (i.e. people wanting the old behavior back
> would have to change the option in kernel cmdline or /etc/modprobe.d)
>=20
> Anyway, I don't oppose to applying it here, but I'll wait some more
> days for people to chime in.

Hi, I'm wondering if this could be moved forwards or needs some more
discussion/work?

Thanks,
Lubo
