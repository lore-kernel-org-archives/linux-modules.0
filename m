MIME-Version: 1.0
In-Reply-To: <1461435512.8450.29.camel@v3.sk>
References: <1456931893-13545-1-git-send-email-lkundrak@v3.sk>
	<20160302155551.GA31679@bongo.bofh.it>
	<1456934860.3200.4.camel@intel.com>
	<1456936094.32064.40.camel@v3.sk>
	<CAKi4VA+B7YOpVV5ogUqx4HuL2re=C7D+1aaB_VRjP0F9tUNF6g@mail.gmail.com>
	<1459247226.25498.30.camel@v3.sk>
	<CAKi4VA+VAYZ8zPGG=0qR1yMQGLfwZD5qMO8kW4kHYoqJes6KVA@mail.gmail.com>
	<1461435512.8450.29.camel@v3.sk>
Date: Tue, 14 Jun 2016 09:55:05 -0300
Message-ID: <CAKi4VALHJXukXrO3YPk7Uoa2Y9SkFY0g3iJ=Q_-sRW8f4yohvg@mail.gmail.com>
Subject: Re: [PATCH] modprobe: install default configuration
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: "De Marchi, Lucas" <lucas.demarchi@intel.com>, "md@Linux.IT" <md@linux.it>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

CC'ing lkml and Rusty to get opinions on this.

On Sat, Apr 23, 2016 at 3:18 PM, Lubomir Rintel <lkundrak@v3.sk> wrote:
> On Wed, 2016-04-13 at 01:11 -0300, Lucas De Marchi wrote:
>> On Tue, Mar 29, 2016 at 7:27 AM, Lubomir Rintel <lkundrak@v3.sk>
>> wrote:
>> >
>> > On Fri, 2016-03-04 at 02:02 -0300, Lucas De Marchi wrote:
>> > >
>> > > On Wed, Mar 2, 2016 at 1:28 PM, Lubomir Rintel <lkundrak@v3.sk>
>> > > wrote:
>> > > >
>> > > >
>> > > > On Wed, 2016-03-02 at 16:07 +0000, De Marchi, Lucas wrote:
>> > > > >
>> > > > >
>> > > > > On Wed, 2016-03-02 at 16:55 +0100, Marco d'Itri wrote:
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > > On Mar 02, Lubomir Rintel <lkundrak@v3.sk> wrote:
>> > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > > The kernel maintainers seem opposed to fixing this in
>> > > > > > > kernel
>> > > > > > > (despite a similar
>> > > > > > > thing has been done with loop block devices) [1]. Let's
>> > > > > > > fix
>> > > > > > > this
>> > > > > > > my
>> > > > > > > overriding the
>> > > > > > > defaults from userspace.
>> > > > > > Because, guess what? This breaks userspace.
>> > > > > > Feel free to configure your system this way if it is what
>> > > > > > you
>> > > > > > want.
>> > > > > More context: https://github.com/systemd/systemd/pull/2778
>> > > > >
>> > > > > Marco, could you be more specific on how this breaks
>> > > > > userspace?
>> > > > > It
>> > > > > seems already pretty much broken to me. We can even argue if
>> > > > > people
>> > > > > wants the broken system back they can equally well configure
>> > > > > their
>> > > > > system to do that (even putting on /etc to override what was
>> > > > > set
>> > > > > on
>> > > > > /usr/lib).
>> > > > >
>> > > > > The commit message doesn't reflect the feedback from kernel
>> > > > > maintainers
>> > > > > very well IMO.  Main argument there was the compile-time
>> > > > > option
>> > > > > rather
>> > > > > than allowing it to be in runtime like this one.
>> > > > I thought that this part of feedback was a bit uninformed or
>> > > > there
>> > > > has
>> > > > been some misunderstanding (perhaps on my side). There already
>> > > > are
>> > > > options; the kernel patch just changed defaults for the options
>> > > > --
>> > > > not
>> > > > hardcoding the values or anything like that; just allowing to
>> > > > choose
>> > > > different defaults at compile time.
>> > > >
>> > > > The point was that if the user merely does "make oldconfig" to
>> > > > update
>> > > > his kernel configuration the behavior wouldn't change. Thus it
>> > > > would be
>> > > > safe for anyone to install an new kernel on an old distro even
>> > > > if
>> > > > they're relying on the ancient behavior.
>> > > >
>> > > > On the other hand, it would still allow for behavior change on
>> > > > distro
>> > > > upgrades. I'm assuming it's okay to do that -- far bigger
>> > > > changes
>> > > > regularly occur and users of exotic interfaces often end up
>> > > > adjusting
>> > > > their tooling on major upgrades.
>> > > I would say the better patch to the kernel would be to bite the
>> > > bullet
>> > > and change the default.
>> > > The default is bad as shown by your example and people
>> > > complaining
>> > > about the behavior. With a patch to kmod we are acknowledging the
>> > > default is bad and changing it, just like we would be if the
>> > > patch to
>> > > the kernel was applied (i.e. people wanting the old behavior back
>> > > would have to change the option in kernel cmdline or
>> > > /etc/modprobe.d)
>> > >
>> > > Anyway, I don't oppose to applying it here, but I'll wait some
>> > > more
>> > > days for people to chime in.
>> > Hi, I'm wondering if this could be moved forwards or needs some
>> > more
>> > discussion/work?
>> Maybe getting an ack from kernel people involved since we still got
>> no
>> feedback. Unfortunately our archives vanished and would be hard to
>> point them to the whole thread. Do you want to CC them here?
>
> Sorry for the late reply; I'm not sure whom to include; you probably
> have a better idea. Please feel free to CC whoever might be interested
> in providing feedback to this.

So in the intention of getting this patch going, I gave it some tests.
First, just mentioning you added all the network-related modules to
the same file.  A distro can change the default by not shipping the
file and the user can override it by having a file with the same name
on /etc (or /run). However if the user overrides a file this way, all
the content would need to be copied if he wants to change the options
for just one module.

Adding another file with another name doesn't really work:  the
configuration files are sorted alphabetically so there could be 2
scenarios: options are _added_ either before or after the default
options given by distro.  The kernel doesn't dictate what happens if
you provide the same option multiple times, but AFAICS it calls the
set function for each of them - this may or may not work.

I think that in order to get this patch applied we need to provide a
better way to allow distro and user to opt out: one idea would be to
add another keyword to the configuration file to allow people to
_override_ options rather than add new ones. In this case the user
would have to name the file to be loaded after the others, something
like 99-override-xyz.conf. Something like below

/usr/lib/modprobe.d/50-defaults.conf
        options foo paramfoo=1
        options bar paramfoo2=1

/etc/modprobe.d/99-test.conf
        options foo paramfoo=2

`modprobe foo' would mean the options are passed as `paramfoo=1 paramfoo=2'

If we have something like "options-override":

/etc/modprobe.d/99-test.conf
        options-override foo paramfoo=2

`modprobe foo' would mean the options are passed as `paramfoo=2'

Or we could add an "options-erase <modulename>" which just erases all
the options.


Thoughts?

-- 
Lucas De Marchi
