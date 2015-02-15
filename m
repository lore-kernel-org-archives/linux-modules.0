MIME-Version: 1.0
In-Reply-To: <20150214233547.GB7778@localhost>
References: <20150214233547.GB7778@localhost>
Date: Sun, 15 Feb 2015 09:43:53 -0200
Message-ID: <CAKi4VAKoA0TNXOj_C9+4fdsc-X6oee2EOB3Piu5PtDE7FSxRmQ@mail.gmail.com>
Subject: Re: [PATCH] Out of bounds signature access with 32 bit off_t
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sat, Feb 14, 2015 at 9:35 PM, Tobias Stoeckmann
<tobias@stoeckmann.org> wrote:
> Hi,
>
> if kmod has been configured with --disable-largefile on a 32 bit
> system, off_t will be 32 bit. In that case, the parsed sig_len can
> bypass a validation check (it's _unsigned_ 32 bit), allowing a
> an attacker to perform out of boundary access through a malicious module.

There's no "validation check" in kmod. This is done by the kernel, no
the userspace tools. The fix looks correct, but not the assumption
this is a security risk. modinfo is only used to get information  from
the module and the only bad thing that can happen is it crashing.

> Due to the unlikeliness of people using --disable-largefile, this is
> a mere validation fix. With an explicit signed 64 bit cast, there is
> no binary change for 99.9% of Linux systems out there. ;)
>
> Attached please find a proof of concept, which will most likely result in
> a segmentation fault (works fine with 64 bit off_t builds):

Is it "most likely" or is it certain to get a segfault?

Could you send the source code of this module so I can add it to the
testsuite? I realize you had to poke the module after it was compiled
in order to corrupt it to produce segfaults, then send the command you
use, too.

thanks
Lucas De Marchi
