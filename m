MIME-Version: 1.0
In-Reply-To: <CAG-2HqWV53rOdN+GDit9aL9ttTvmG9fFxiHTyNRB6oAbN4BBSw@mail.gmail.com>
References: <CAG-2HqVHuafFrYSZ3Uobr3ZdcoiqvN0v0OagK3nW3oddmsV73w@mail.gmail.com>
	<CAG-2HqXCQVzrfz5O+ffHvs=wWyFa_VysBvCm4CFn67ZkVEhUBA@mail.gmail.com>
	<20141028132111.GH29695@in.waw.pl>
	<CAG-2HqWV53rOdN+GDit9aL9ttTvmG9fFxiHTyNRB6oAbN4BBSw@mail.gmail.com>
Date: Tue, 28 Oct 2014 16:50:57 -0200
Message-ID: <CAKi4VAKLOg9rtXvA7NtE7QU9QbPQ77Or10ybmrQAuZOv3bvz1Q@mail.gmail.com>
Subject: Re: [PATCH] static-nodes: indicate that creation of static nodes
 should only happen at boot
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Tom Gundersen <teg@jklm.no>
Cc: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Oct 28, 2014 at 12:45 PM, Tom Gundersen <teg@jklm.no> wrote:
> On Tue, Oct 28, 2014 at 2:21 PM, Zbigniew J=C4=99drzejewski-Szmek
> <zbyszek@in.waw.pl> wrote:
>> On Tue, Oct 28, 2014 at 12:23:53PM +0100, Tom Gundersen wrote:
>>> On Tue, Oct 28, 2014 at 12:16 PM, Tom Gundersen <teg@jklm.no> wrote:
>>> > On Tue, Oct 28, 2014 at 3:31 AM, Lucas De Marchi
>>> > <lucas.de.marchi@gmail.com> wrote:
>>> >> On Mon, Oct 27, 2014 at 2:55 PM, Tom Gundersen <teg@jklm.no> wrote:
>>> >>> udev will only manage static nodes that exist at the time udev is s=
tarted, so
>>> >>> creating static nodes later on will likely not behave as expected. =
In
>>> >>> particular, recreating the static nodes at run-time will reset any =
permissions
>>> >>> udev may have applied to the nodes at boot.
>>> >>>
>>> >>> See <https://bugzilla.redhat.com/show_bug.cgi?id=3D1147248> and the=
 discussion
>>> >>> following <http://permalink.gmane.org/gmane.comp.sysutils.systemd.d=
evel/23795>.
>>> >>>
>>> >>> Note that this requires (the yet to be released) systemd v217 or a =
backport
>>> >>> of systemd patch 8c94052ee543c3598a3c7b0c46688150aa2c6168.
>>> >>
>>> >> Is this patch going to systemd-stable?
>>> >
>>> > I think that makes sense, as the current status is broken in distros.
>>> > Not entirely sure though, as the --boot logic is new functionality.
>>> > Zbigniew, what do you think?
>> Yeah, I'll pull it into -stable.
>>
>> (But the kmod patch doesn't really depend on your patch 'units:
>> tmpfiles-setup-dev - allow unsafe file creation to happen in /dev at
>> boot', just on the --boot functionality, which I think was done for F20,
>> so can be considered available.)
>
> It is true that even F20 will parse the new kmod.conf file correctly,
> but since --boot is not passed to tmpfiles, the entries will be
> ignored. So you really want that patch as well.

Yeah, as far as I can see you need that as well.

Applied.

--=20
Lucas De Marchi
