MIME-Version: 1.0
In-Reply-To: <CACB1AetiZoOOVLNPVpjF42R6B2okW121FwMh7QCBXxwsWNQtOw@mail.gmail.com>
References: <CACB1Aes6O1+Obj3Kp5cesoLbUN3uNKNvmQc1Q=8yQTFqkbtf8g@mail.gmail.com>
	<CAKi4VAKbosbmvXae_pSCX8NMSpR7XsYzqw8bkchYXXeoR63o+g@mail.gmail.com>
	<CACB1AetiZoOOVLNPVpjF42R6B2okW121FwMh7QCBXxwsWNQtOw@mail.gmail.com>
Date: Sun, 18 May 2014 16:54:34 -0300
Message-ID: <CAKi4VA+hHbnok3nYKqRAEVCoDgz0y3rY=PpQy+jDqp=_sUODTw@mail.gmail.com>
Subject: Re: [PATCH] Fix use-after-free in libkmod / depmod fails to deal with symlinks
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Lukas Anzinger <l.anzinger@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sun, May 18, 2014 at 4:40 PM, Lukas Anzinger <l.anzinger@gmail.com> wrote:
> Hi Lucas,
>
> I've updated the post to reflect your concerns, at least I hope so.
>
>> It's a nice blog post, but with lots of unnecessary noise accusing kmod of NIH for such a simple bug caused by out-of-tree modules (thus not really tested).
>
> The bug might be caused by out-of-tree modules but it's still a
> use-after-free. Don't get me wrong, the code quality of kmod seems

yep and the patch you sent is already applied.

> quite high and way above average to me. I was just a bit "disappointed
> that the hash implementation is part of the core that makes the
> impression of NIH because it's not really documented (no doxygen

The doxygen documentation is more focused on the exposed API, not the
internal implementation. We do have some documentation on some of the
functions, but documenting all the internal implementation is not
really a goal.

> comments or something similar) and no unit tests although kmod ships a
> testsuite.

Adding test cases for the hash implementation would be really good.
Bare in mind the testsuite was added much later (kmod 5 I think) and
focused on testing the libkmod API and the tools (modprobe, modinfo,
depmod, etc). There are some tests for internal functions, but they
were added after we found bugs in them.

Lucas De Marchi
