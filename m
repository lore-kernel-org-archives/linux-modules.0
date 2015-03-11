Return-Path: <jdub@bethesignal.org>
MIME-Version: 1.0
In-Reply-To: <CAKi4VAKfYP8uYuXb6kwULikjySq7ZD-nBK+1i2-AfK1ARCaJdQ@mail.gmail.com>
References: <20150305210547.GA24297@ubuntu>
	<CAKi4VAKfYP8uYuXb6kwULikjySq7ZD-nBK+1i2-AfK1ARCaJdQ@mail.gmail.com>
Date: Wed, 11 Mar 2015 11:30:45 +1100
Message-ID: <CAGAEFzKRYZ=EySFfg3A_Hf6xKtjF7pqe+Nt9490dcs=9hnp0mw@mail.gmail.com>
Subject: Re: [PATCH] build: generate libkmod.pc during autoconf
From: Jeff Waugh <jdub@bethesignal.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Lucas,

On Wed, Mar 11, 2015 at 4:04 AM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> what exactly are you solving here? What's the problem with doing it
> during make not during configure?


It certainly affects cross-compiling. Possibly other stuff.


Here's the relevant part of libkmod.pc when produced during make:

prefix=/usr
exec_prefix=/usr
libdir=/usr/lib
includedir=/usr/include


And during configure:

prefix=/usr
exec_prefix=/usr
libdir=${exec_prefix}/lib
includedir=${prefix}/include


> > like other packages do. (Patch from OpenWrt's contributed packages project.)
>
> others do like we do, too:
> https://git.kernel.org/cgit/linux/kernel/git/kay/libabc.git/tree/Makefile.am
> http://cgit.freedesktop.org/systemd/systemd/tree/Makefile.am
>
> should they be changed, too?


Yes! I was just about to send a fix for systemd, as that burned me too. :-)

(If you check any of the libraries on git.gnome.org, their pkg-config
files are generated during configure.)

Thanks,
Jeff
