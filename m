Return-Path: <tobias@stoeckmann.org>
Date: Sun, 15 Feb 2015 14:52:54 +0100 (CET)
From: =?UTF-8?Q?Tobias_St=C3=B6ckmann?= <tobias@stoeckmann.org>
Reply-To: =?UTF-8?Q?Tobias_St=C3=B6ckmann?= <tobias@stoeckmann.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Message-ID: <1638446242.528951.1424008374804.JavaMail.open-xchange@oxbaltgw01.schlund.de>
In-Reply-To: <CAKi4VAKoA0TNXOj_C9+4fdsc-X6oee2EOB3Piu5PtDE7FSxRmQ@mail.gmail.com>
References: <20150214233547.GB7778@localhost> <CAKi4VAKoA0TNXOj_C9+4fdsc-X6oee2EOB3Piu5PtDE7FSxRmQ@mail.gmail.com>
Subject: Re: [PATCH] Out of bounds signature access with 32 bit off_t
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

> On February 15, 2015 at 12:43 PM Lucas De Marchi <lucas.de.marchi@gmail.com>
> wrote:
> There's no "validation check" in kmod. This is done by the kernel, no
> the userspace tools. The fix looks correct, but not the assumption
> this is a security risk. modinfo is only used to get information  from
> the module and the only bad thing that can happen is it crashing.

It's definitely not a security risk to the kernel. What I mean is that modinfo
(which of course does not interact with the kernel) can be directed to other
parts of the memory, which an attacker _might_ use to trigger other effects --
with the user permission of modinfo caller.

Crashing is the best thing to happen, but I haven't investigated this further.
After all the range check (in modinfo) should be corrected and the issue is
gone. Also, a 32 bit off_t is too unlikely to encounter to further investigate
here.

> > Due to the unlikeliness of people using --disable-largefile, this is
> > a mere validation fix. With an explicit signed 64 bit cast, there is
> > no binary change for 99.9% of Linux systems out there. ;)
> >
> > Attached please find a proof of concept, which will most likely result in
> > a segmentation fault (works fine with 64 bit off_t builds):
> 
> Is it "most likely" or is it certain to get a segfault?

As written before, if the memory layout of the system is known, it doesn't have
to segfault. In most cases, it will. On my system with the supplied module, it
does.

> Could you send the source code of this module so I can add it to the
> testsuite? I realize you had to poke the module after it was compiled
> in order to corrupt it to produce segfaults, then send the command you
> use, too.

There is no source code for these files, because I wrote them with hexedit. As I
wrote them, you are free to take them for the test suite.


Tobias
