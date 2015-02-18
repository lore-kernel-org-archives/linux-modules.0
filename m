MIME-Version: 1.0
In-Reply-To: <1638446242.528951.1424008374804.JavaMail.open-xchange@oxbaltgw01.schlund.de>
References: <20150214233547.GB7778@localhost>
	<CAKi4VAKoA0TNXOj_C9+4fdsc-X6oee2EOB3Piu5PtDE7FSxRmQ@mail.gmail.com>
	<1638446242.528951.1424008374804.JavaMail.open-xchange@oxbaltgw01.schlund.de>
Date: Wed, 18 Feb 2015 15:55:37 -0200
Message-ID: <CAKi4VA+RFrQwrWys+VRNMBPOp3KA=dk9yi442sxoWiiL5jRKEQ@mail.gmail.com>
Subject: Re: [PATCH] Out of bounds signature access with 32 bit off_t
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: =?UTF-8?Q?Tobias_St=C3=B6ckmann?= <tobias@stoeckmann.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sun, Feb 15, 2015 at 11:52 AM, Tobias St=C3=B6ckmann
<tobias@stoeckmann.org> wrote:
> Hi,
>
>> On February 15, 2015 at 12:43 PM Lucas De Marchi <lucas.de.marchi@gmail.=
com>
>> wrote:
>> There's no "validation check" in kmod. This is done by the kernel, no
>> the userspace tools. The fix looks correct, but not the assumption
>> this is a security risk. modinfo is only used to get information  from
>> the module and the only bad thing that can happen is it crashing.
>
> It's definitely not a security risk to the kernel. What I mean is that mo=
dinfo
> (which of course does not interact with the kernel) can be directed to ot=
her
> parts of the memory, which an attacker _might_ use to trigger other effec=
ts --
> with the user permission of modinfo caller.
>
> Crashing is the best thing to happen, but I haven't investigated this fur=
ther.
> After all the range check (in modinfo) should be corrected and the issue =
is
> gone. Also, a 32 bit off_t is too unlikely to encounter to further invest=
igate
> here.
>
>> > Due to the unlikeliness of people using --disable-largefile, this is
>> > a mere validation fix. With an explicit signed 64 bit cast, there is
>> > no binary change for 99.9% of Linux systems out there. ;)
>> >
>> > Attached please find a proof of concept, which will most likely result=
 in
>> > a segmentation fault (works fine with 64 bit off_t builds):
>>
>> Is it "most likely" or is it certain to get a segfault?
>
> As written before, if the memory layout of the system is known, it doesn'=
t have
> to segfault. In most cases, it will. On my system with the supplied modul=
e, it
> does.

Ok. I reworded the commit message a little bit and applied.

>> Could you send the source code of this module so I can add it to the
>> testsuite? I realize you had to poke the module after it was compiled
>> in order to corrupt it to produce segfaults, then send the command you
>> use, too.
>
> There is no source code for these files, because I wrote them with hexedi=
t. As I
> wrote them, you are free to take them for the test suite.

I agree with you. Unfortunately not everybody (or every distribution)
agrees. If you take a look on recent commits to testsuite, I'm
removing all the pre-compiled modules from there. When I finish the
remaining modules I'll figure out a way to add a test for it.

thanks

--=20
Lucas De Marchi
