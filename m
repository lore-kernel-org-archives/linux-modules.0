Return-Path: <teg@jklm.no>
MIME-Version: 1.0
In-Reply-To: <20141028132111.GH29695@in.waw.pl>
References: <CAG-2HqVHuafFrYSZ3Uobr3ZdcoiqvN0v0OagK3nW3oddmsV73w@mail.gmail.com>
 <CAG-2HqXCQVzrfz5O+ffHvs=wWyFa_VysBvCm4CFn67ZkVEhUBA@mail.gmail.com> <20141028132111.GH29695@in.waw.pl>
From: Tom Gundersen <teg@jklm.no>
Date: Tue, 28 Oct 2014 15:45:39 +0100
Message-ID: <CAG-2HqWV53rOdN+GDit9aL9ttTvmG9fFxiHTyNRB6oAbN4BBSw@mail.gmail.com>
Subject: Re: [PATCH] static-nodes: indicate that creation of static nodes
 should only happen at boot
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Oct 28, 2014 at 2:21 PM, Zbigniew J=C4=99drzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
> On Tue, Oct 28, 2014 at 12:23:53PM +0100, Tom Gundersen wrote:
>> On Tue, Oct 28, 2014 at 12:16 PM, Tom Gundersen <teg@jklm.no> wrote:
>> > On Tue, Oct 28, 2014 at 3:31 AM, Lucas De Marchi
>> > <lucas.de.marchi@gmail.com> wrote:
>> >> On Mon, Oct 27, 2014 at 2:55 PM, Tom Gundersen <teg@jklm.no> wrote:
>> >>> udev will only manage static nodes that exist at the time udev is st=
arted, so
>> >>> creating static nodes later on will likely not behave as expected. I=
n
>> >>> particular, recreating the static nodes at run-time will reset any p=
ermissions
>> >>> udev may have applied to the nodes at boot.
>> >>>
>> >>> See <https://bugzilla.redhat.com/show_bug.cgi?id=3D1147248> and the =
discussion
>> >>> following <http://permalink.gmane.org/gmane.comp.sysutils.systemd.de=
vel/23795>.
>> >>>
>> >>> Note that this requires (the yet to be released) systemd v217 or a b=
ackport
>> >>> of systemd patch 8c94052ee543c3598a3c7b0c46688150aa2c6168.
>> >>
>> >> Is this patch going to systemd-stable?
>> >
>> > I think that makes sense, as the current status is broken in distros.
>> > Not entirely sure though, as the --boot logic is new functionality.
>> > Zbigniew, what do you think?
> Yeah, I'll pull it into -stable.
>
> (But the kmod patch doesn't really depend on your patch 'units:
> tmpfiles-setup-dev - allow unsafe file creation to happen in /dev at
> boot', just on the --boot functionality, which I think was done for F20,
> so can be considered available.)

It is true that even F20 will parse the new kmod.conf file correctly,
but since --boot is not passed to tmpfiles, the entries will be
ignored. So you really want that patch as well.

Cheers,

Tom
