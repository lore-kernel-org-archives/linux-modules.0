Return-Path: <teg@jklm.no>
MIME-Version: 1.0
In-Reply-To: <CAG-2HqVHuafFrYSZ3Uobr3ZdcoiqvN0v0OagK3nW3oddmsV73w@mail.gmail.com>
References: <1414428903-2381-1-git-send-email-teg@jklm.no> <CAKi4VAKu27u=9=Fu_TUqRakrbWCUOPHMVoiimPJM3UfhgD0EyA@mail.gmail.com>
 <CAG-2HqVHuafFrYSZ3Uobr3ZdcoiqvN0v0OagK3nW3oddmsV73w@mail.gmail.com>
From: Tom Gundersen <teg@jklm.no>
Date: Tue, 28 Oct 2014 12:23:53 +0100
Message-ID: <CAG-2HqXCQVzrfz5O+ffHvs=wWyFa_VysBvCm4CFn67ZkVEhUBA@mail.gmail.com>
Subject: Re: [PATCH] static-nodes: indicate that creation of static nodes
 should only happen at boot
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Zbyszek Jedrzejewski-Szmek <zbyszek@in.waw.pl>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Oct 28, 2014 at 12:16 PM, Tom Gundersen <teg@jklm.no> wrote:
> On Tue, Oct 28, 2014 at 3:31 AM, Lucas De Marchi
> <lucas.de.marchi@gmail.com> wrote:
>> On Mon, Oct 27, 2014 at 2:55 PM, Tom Gundersen <teg@jklm.no> wrote:
>>> udev will only manage static nodes that exist at the time udev is started, so
>>> creating static nodes later on will likely not behave as expected. In
>>> particular, recreating the static nodes at run-time will reset any permissions
>>> udev may have applied to the nodes at boot.
>>>
>>> See <https://bugzilla.redhat.com/show_bug.cgi?id=1147248> and the discussion
>>> following <http://permalink.gmane.org/gmane.comp.sysutils.systemd.devel/23795>.
>>>
>>> Note that this requires (the yet to be released) systemd v217 or a backport
>>> of systemd patch 8c94052ee543c3598a3c7b0c46688150aa2c6168.
>>
>> Is this patch going to systemd-stable?
>
> I think that makes sense, as the current status is broken in distros.
> Not entirely sure though, as the --boot logic is new functionality.
> Zbigniew, what do you think?

Sorry, I misread the commit logs. The --boot logic is already in
stable, and I think my follow up patch should also go there.

Cheers,

Tom
