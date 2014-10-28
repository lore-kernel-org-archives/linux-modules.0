Return-Path: <zbyszek@in.waw.pl>
Date: Tue, 28 Oct 2014 14:21:11 +0100
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Tom Gundersen <teg@jklm.no>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] static-nodes: indicate that creation of static nodes
 should only happen at boot
Message-ID: <20141028132111.GH29695@in.waw.pl>
References: <CAG-2HqVHuafFrYSZ3Uobr3ZdcoiqvN0v0OagK3nW3oddmsV73w@mail.gmail.com>
 <CAG-2HqXCQVzrfz5O+ffHvs=wWyFa_VysBvCm4CFn67ZkVEhUBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG-2HqXCQVzrfz5O+ffHvs=wWyFa_VysBvCm4CFn67ZkVEhUBA@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>

On Tue, Oct 28, 2014 at 12:23:53PM +0100, Tom Gundersen wrote:
> On Tue, Oct 28, 2014 at 12:16 PM, Tom Gundersen <teg@jklm.no> wrote:
> > On Tue, Oct 28, 2014 at 3:31 AM, Lucas De Marchi
> > <lucas.de.marchi@gmail.com> wrote:
> >> On Mon, Oct 27, 2014 at 2:55 PM, Tom Gundersen <teg@jklm.no> wrote:
> >>> udev will only manage static nodes that exist at the time udev is started, so
> >>> creating static nodes later on will likely not behave as expected. In
> >>> particular, recreating the static nodes at run-time will reset any permissions
> >>> udev may have applied to the nodes at boot.
> >>>
> >>> See <https://bugzilla.redhat.com/show_bug.cgi?id=1147248> and the discussion
> >>> following <http://permalink.gmane.org/gmane.comp.sysutils.systemd.devel/23795>.
> >>>
> >>> Note that this requires (the yet to be released) systemd v217 or a backport
> >>> of systemd patch 8c94052ee543c3598a3c7b0c46688150aa2c6168.
> >>
> >> Is this patch going to systemd-stable?
> >
> > I think that makes sense, as the current status is broken in distros.
> > Not entirely sure though, as the --boot logic is new functionality.
> > Zbigniew, what do you think?
Yeah, I'll pull it into -stable.

(But the kmod patch doesn't really depend on your patch 'units:
tmpfiles-setup-dev - allow unsafe file creation to happen in /dev at
boot', just on the --boot functionality, which I think was done for F20,
so can be considered available.)

Zbyszek

> Sorry, I misread the commit logs. The --boot logic is already in
> stable, and I think my follow up patch should also go there.
