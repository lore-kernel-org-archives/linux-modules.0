Return-Path: <tobias@stoeckmann.org>
Date: Tue, 10 Feb 2015 11:44:19 +0100 (CET)
From: =?UTF-8?Q?Tobias_St=C3=B6ckmann?= <tobias@stoeckmann.org>
Reply-To: =?UTF-8?Q?Tobias_St=C3=B6ckmann?= <tobias@stoeckmann.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Message-ID: <428397718.353502.1423565059923.JavaMail.open-xchange@oxbaltgw03.schlund.de>
In-Reply-To: <CAKi4VA+0PBrFc728HdpdmaKGr-B5+uPmQ5QKk2igMHqJTCpcrA@mail.gmail.com>
References: <20150209222251.GA22303@localhost> <CAKi4VAK4Bp43VDTRhY7dETZ+sdnvh886vicUrASdCmn9+dtUqA@mail.gmail.com> <1535753429.343743.1423556796294.JavaMail.open-xchange@oxbaltgw03.schlund.de> <CAKi4VA+0PBrFc728HdpdmaKGr-B5+uPmQ5QKk2igMHqJTCpcrA@mail.gmail.com>
Subject: Re: [PATCH] Prevent offset + size overflow.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi again,

> On February 10, 2015 at 11:31 AM Lucas De Marchi <lucas.de.marchi@gmail.com>
> wrote:
> sizeof(uint64_t) == sizeof(unsigned long) both on 32 and 64 bits... no
> need to use long long.

long on 32 bit systems (at least my i686) is 32 bit -- granted, the C standard
doesn't explicitly require that. Yet I didn't encounter a 32 bit Linux with 64
bit long, please correct me if I'm wrong and there are such systems out there.
long long would be 64 bit on both.

> are you going to submit the patch or you're waiting on me?

I have no commit access, so I am waiting for you. :)
As stated before, please use the long long variant.

> If this is pointed out by any static analysis tool, feel free to add that
> in the commit message.

It's a review by hand. But speaking of analysis, I wonder what afl could come up
with...


Tobias
