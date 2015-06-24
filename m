Return-Path: <ncopa@alpinelinux.org>
Date: Wed, 24 Jun 2015 14:11:07 +0200
From: Natanael Copa <ncopa@alpinelinux.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] build: let sed use posix ERE instead of GNU extension
Message-ID: <20150624141107.5f37698e@ncopa-desktop.alpinelinux.org>
In-Reply-To: <CAKi4VALhw3+irr7vbwDtYjBmU_fC7_SxPeYK=2b1Frn7eS=b8A@mail.gmail.com>
References: <1434974957-2995-1-git-send-email-ncopa@alpinelinux.org>
	<CAKi4VA+ORsVxeQTRoUa7DhisaAW=uPuWr=U-Ernuek64mymPXQ@mail.gmail.com>
	<CAKi4VALhw3+irr7vbwDtYjBmU_fC7_SxPeYK=2b1Frn7eS=b8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-modules.vger.kernel.org>

On Mon, 22 Jun 2015 11:30:40 -0300
Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

> On Mon, Jun 22, 2015 at 11:20 AM, Lucas De Marchi
> <lucas.de.marchi@gmail.com> wrote:
> > Hi,
> >
> > On Mon, Jun 22, 2015 at 9:09 AM, Natanael Copa <ncopa@alpinelinux.org> wrote:
> >> Use POSIX Extended Regular Expression (ERE) instead of the GNU extension
> >> \| in the install-exec-hook. This makes it create the symlink properly
> >> with busybox sed built with musl libc. It will silently create a broken
> >> symlink otherwise.
> >
> >
> > Oh... so you are running "make install" in a system with only busybox
> > built with musl? :-o

yes. i think i have built 1000+ packages with busybox sed only.

> > Anyway, this change seems sane enough so it's applied.
> 
> when pushing the CI alerted me it was failing.
> 
>         Makefile.am:111: error: blank line following trailing backslash
> 
> I fixed this up myself, but now I'm wondering if this has been at
> least compile-tested.
> 

My bad. sorry about that.

I did "unit" test it, eg copy paste and tested that the sed line worked
with both GNU sed and busybox sed.

I have now also compile and make install tested it. It works as
expected after removing the blank line.


ncopa-desktop:~/src/kmod$ ls -l /tmp/kmod/lib/
total 448
lrwxrwxrwx 1 ncopa ncopa     17 Jun 23 13:52 libkmod.so.2 -> libkmod.so.2.2.11
-rwxr-xr-x 1 ncopa ncopa 454880 Jun 23 13:52 libkmod.so.2.2.11
ncopa-desktop:~/src/kmod$ ls -l /tmp/kmod/usr/lib/
total 8
-rwxr-xr-x 1 ncopa ncopa  903 Jun 23 13:52 libkmod.la
lrwxrwxrwx 1 ncopa ncopa   27 Jun 23 13:52 libkmod.so -> ../../lib/libkmod.so.2.2.11
drwxr-xr-x 2 ncopa ncopa 4096 Jun 23 13:52 pkgconfig

Thanks!

-nc
