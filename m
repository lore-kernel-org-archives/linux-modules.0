Return-Path: <andi@rhlx01.hs-esslingen.de>
Date: Thu, 4 Jun 2015 21:53:34 +0200
From: Andreas Mohr <andi@lisas.de>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andreas Mohr <andi@lisas.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bertrand Jacquin <beber@meleeweb.net>, Marco d'Itri <md@linux.it>,
	linux-modules <linux-modules@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH] modules: CONFIG_MODULE_COMPRESS: add hint that userspace
 support may easily be missing.
Message-ID: <20150604195334.GA15890@rhlx01.hs-esslingen.de>
References: <20150531152932.GA16337@rhlx01.hs-esslingen.de>
 <87r3pwgd0b.fsf@rustcorp.com.au>
 <CAKi4VAJfhM0UMOmFkQ40RW5gJGKch8AH8QEvuiYtj93O+YTNwA@mail.gmail.com>
 <87h9qouuny.fsf@rustcorp.com.au>
 <CAKi4VA+4mFsg7VCqr+3wd4dCqUtCW02YP7KYmVYF0prH5bet0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKi4VA+4mFsg7VCqr+3wd4dCqUtCW02YP7KYmVYF0prH5bet0g@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jun 03, 2015 at 11:31:20PM -0300, Lucas De Marchi wrote:
> On Wed, Jun 3, 2015 at 10:30 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 968a001790af..5422c44be5f0 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1948,26 +1948,22 @@ config MODULE_COMPRESS
> >         bool "Compress modules on installation"
> >         depends on MODULES
> >         help
> > -         This option compresses the kernel modules when 'make
> > -         modules_install' is run.
> >
> > -         The modules will be compressed either using gzip or xz depend on the
> > -         choice made in "Compression algorithm".
> > +         Compresses kernel modules when 'make modules_install' is run; gzip or
> > +         xz depending on "Compression algorithm" below.
> >
> > -         module-init-tools has support for gzip format while kmod handle gzip
> > -         and xz compressed modules.
> > +         module-init-tools supports gzip, and kmod can be configured to handle
> > +         gzip and xz (but doesn't by default, at least as of version 18!).
> 
> This is pretty much misleading. There's no such a default option. It's
> like saying kernel doesn't support feature X, Y or Z by default
> because make defconfig doesn't turn them on.
> 
> The option is there since the beginning for the distros to adapt to their needs.

Hmm? Perhaps I'm misunderstanding something in this discussion,
but Debian kmod-20 (kmod_20.orig.tar.xz - BTW side note:
noted the .xz file rather than .gz? ;))
configure.ac contains:

AC_ARG_WITH([xz],
        AS_HELP_STRING([--with-xz], [handle Xz-compressed modules
@<:@default=disabled@:>@]),
        [], [with_xz=no])
AS_IF([test "x$with_xz" != "xno"], [
        PKG_CHECK_MODULES([liblzma], [liblzma >= 4.99])
        AC_DEFINE([ENABLE_XZ], [1], [Enable Xz for modules.])
], [
        AC_MSG_NOTICE([Xz support not requested])
])

AC_ARG_WITH([zlib],
        AS_HELP_STRING([--with-zlib], [handle gzipped modules
@<:@default=disabled@:>@]),
        [], [with_zlib=no])

So it clearly seems there *is* a specific
(hard-coded, as opposed to system introspection) default
(i.e., the usual way of getting defaults, namely to simply not specify
--with-something configure options),
and that is (drumroll...) "disabled".

Andreas
