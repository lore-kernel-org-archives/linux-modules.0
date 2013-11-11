MIME-Version: 1.0
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC7A40ECEF7D1@xmail3.se.axis.com>
References: <A612847CFE53224C91B23E3A5B48BAC7A40ECEF7D1@xmail3.se.axis.com>
Date: Sun, 10 Nov 2013 23:43:33 -0200
Message-ID: <CAKi4VA+PpeN=9csRHWOE32RfhQ7VJqTyiHJvhSy954U8m72JqA@mail.gmail.com>
Subject: Re: Patch to allow disabling maintainer mode
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Anders Olofsson <anders.olofsson@axis.com>
Cc: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Anders,

On Sat, Nov 9, 2013 at 7:57 PM, Anders Olofsson
<anders.olofsson@axis.com> wrote:
> The attached patch will allow make rules for generated build files (i.e. =
configure, Makefile.in, ... ) to be skipped.
> This is useful when the source is stored without timestamps (for example =
in CVS or GIT).
>
> When the build rules trigger to regenerate the build files, it tries to u=
se the same autotools version (currently 1.14) as was originally used for t=
he release. Since many of our build machines run Debian Squeeze, they only =
have autotools 1.11 available and the build fails.
>
> Currently, we have to work around this by touching all the generated file=
s before building to avoid triggering the make rule. With this patch, we wo=
uld be able to just run configure with --disable-maintainer-mode instead.
> The patch sets the default to enable to not change the default behavior.

The patch has been applied. Please next time send a properly
git-formatted patch so I don't have to hand edit it.

Thanks

Lucas De Marchi
