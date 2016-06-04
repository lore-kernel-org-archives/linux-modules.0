MIME-Version: 1.0
In-Reply-To: <1464526136.2762.84.camel@decadent.org.uk>
References: <20160405001611.GJ21187@decadent.org.uk>
	<20160405003237.GK21187@decadent.org.uk>
	<CAKi4VAK64gR8U2n6=fO8o9Y1m7bTJsmeDLQcpegjF+57=_e8VA@mail.gmail.com>
	<1460541612.2705.32.camel@decadent.org.uk>
	<CAKi4VAKQecNsdVUXV0dR8_0GTKBirZq8NR7b32xMY+ar3Dn4Uw@mail.gmail.com>
	<1463857278.2613.7.camel@decadent.org.uk>
	<1464526136.2762.84.camel@decadent.org.uk>
Date: Sat, 4 Jun 2016 11:13:04 -0300
Message-ID: <CAKi4VAK-qtLHxwRd8gp78FNU9D9V2crfzxT+8-nGD20_ir8NSA@mail.gmail.com>
Subject: Re: [PATCH v2] libkmod: Add support for detached module signatures
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-modules <linux-modules@vger.kernel.org>, 820010-done@bugs.debian.org,
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sun, May 29, 2016 at 9:48 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
> I'm withdrawing this patch for reasons explained in
> http://lists.debian.org/1464525520.2762.80.camel@decadent.org.uk

quoting some parts:

> This is blocked on upstream acceptance in kmod, and it's not clear
> whether that's ever going to happen."

I'm more against the impact of how this is implemented, not against
the idea of reproducible builds you are pursuing. From the points you
raised there:


> 1. Attach module signatures at installation time, in a subdirectory.
>    Change kmod to prefer this subdirectory (this is purely a
>    configuration change).  It would also be possible to check during
>    installation that signatures match the installed unsigned modules,
>    and if not then abort and leave any older signed modules in place.

Yep, this is a mere change to depmod.d config files.

> 2. Attach module signatures at package build time, making the
>    linux-image-signed packages provide/conflict/replace the
>    corresponding linux-image packages.  For architectures with
>    signed modules, udebs would be built from linux-signed and not
>    from linux.

very reasonable, too.


Lucas De Marchi
