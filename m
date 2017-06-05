Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Mon, 5 Jun 2017 10:22:37 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod] shared/util.c: assert_cc() can only be used inside
 functions
Message-ID: <20170605102237.4dd489c2@free-electrons.com>
In-Reply-To: <CAKi4VA+3azA-8pyNS0F73d_0ahCA7=n_opwnxp9A-2Y67oLe8w@mail.gmail.com>
References: <1496502202-9832-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKi4VA+3azA-8pyNS0F73d_0ahCA7=n_opwnxp9A-2Y67oLe8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-modules.vger.kernel.org>

Hello Lucas,

Thanks for your feedback!

On Mon, 5 Jun 2017 01:04:46 -0700, Lucas De Marchi wrote:

> The changes look simple, but going forward I'd like to understand
> this. kmod requires C11 that contains _Static_assert().

kmod seems to build fine with a compiler that isn't C11.

> Is there a compelling reason to support a compiler that old? GCC 4.3.0
> has been released 9 years ago.

As you know, I'm contributing to Buildroot, an embedded Linux build
system, that allows to build from scratch lightweight, configurable
Linux systems through cross-compilation.

Buildroot is widely used in enterprise contexts, where sometimes very
old Linux distributions are used on build servers. As an example, we
even have to look at the version of the 'tar' utility available on the
host, and build our own if it's too old, because some old RHEL distros
have a tar version that is bogus.

In order to make sure our users in this situation don't face problems,
we run test builds on old distros, and one of my automated build
machine has a Debian old enough to still be based on gcc 4.3.

Of course, for the target compiler, we use something more modern (we
recently switched to gcc 6.x as our default compiler version). But the
host compiler is whatever is provided on the user's system, which we
don't control.

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
