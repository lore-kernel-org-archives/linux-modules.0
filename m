MIME-Version: 1.0
In-Reply-To: <20170605102237.4dd489c2@free-electrons.com>
References: <1496502202-9832-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKi4VA+3azA-8pyNS0F73d_0ahCA7=n_opwnxp9A-2Y67oLe8w@mail.gmail.com>
	<20170605102237.4dd489c2@free-electrons.com>
Date: Mon, 5 Jun 2017 10:06:30 -0700
Message-ID: <CAKi4VA+CLw_QnPpMaiaRpAo+8oohNXha8CDdPR6sAn+DPDmJjw@mail.gmail.com>
Subject: Re: [PATCH kmod] shared/util.c: assert_cc() can only be used inside functions
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Mon, Jun 5, 2017 at 1:22 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello Lucas,
>
> Thanks for your feedback!
>
> On Mon, 5 Jun 2017 01:04:46 -0700, Lucas De Marchi wrote:
>
>> The changes look simple, but going forward I'd like to understand
>> this. kmod requires C11 that contains _Static_assert().
>
> kmod seems to build fine with a compiler that isn't C11.

This is pure luck :) - C11 is a requirement. We don't enforce it in
the configure because there wasn't a way to do so with autoconf macros
without creating our own back in the time when C11 started to be a
requirement.


>> Is there a compelling reason to support a compiler that old? GCC 4.3.0
>> has been released 9 years ago.
>
> As you know, I'm contributing to Buildroot, an embedded Linux build
> system, that allows to build from scratch lightweight, configurable
> Linux systems through cross-compilation.

Yep, I think I even may have 1 or 2 patches to buildroot :)

> Buildroot is widely used in enterprise contexts, where sometimes very
> old Linux distributions are used on build servers. As an example, we
> even have to look at the version of the 'tar' utility available on the
> host, and build our own if it's too old, because some old RHEL distros
> have a tar version that is bogus.
>
> In order to make sure our users in this situation don't face problems,
> we run test builds on old distros, and one of my automated build
> machine has a Debian old enough to still be based on gcc 4.3.

I don't want to personally maintain compatibility with that old
compiler. I'll apply this, but it may break again in future.  If
breakage is too often, then I'll ask for you to maintain those patches
as downstream patches, ok?

thanks
Lucas De Marchi
