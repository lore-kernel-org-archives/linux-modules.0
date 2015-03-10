MIME-Version: 1.0
In-Reply-To: <20150305210547.GA24297@ubuntu>
References: <20150305210547.GA24297@ubuntu>
Date: Tue, 10 Mar 2015 14:04:33 -0300
Message-ID: <CAKi4VAKfYP8uYuXb6kwULikjySq7ZD-nBK+1i2-AfK1ARCaJdQ@mail.gmail.com>
Subject: Re: [PATCH] build: generate libkmod.pc during autoconf
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Jeff Waugh <jdub@bethesignal.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Jeff,

On Thu, Mar 5, 2015 at 6:05 PM, Jeff Waugh <jdub@bethesignal.org> wrote:
> The pkgconfig file is generated at make-time, leading to absolute /usr/include
> & /usr/lib search paths. The patch lets autoconf handle pkgconfig file subst,

what exactly are you solving here? What's the problem with doing it
during make not during configure?
We have it in Makefile.am exactly so it's processed by make, not
configure. Make runs after configure so it will use whatever is
configured to make the substitution.

$ ./configure --includedir=/tmp/bla
$ make
$ grep includedir= ./libkmod/libkmod.pc
$ includedir=/tmp/bla

> like other packages do. (Patch from OpenWrt's contributed packages project.)

others do like we do, too:
https://git.kernel.org/cgit/linux/kernel/git/kay/libabc.git/tree/Makefile.am
http://cgit.freedesktop.org/systemd/systemd/tree/Makefile.am

should they be changed, too?

-- 
Lucas De Marchi
