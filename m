MIME-Version: 1.0
In-Reply-To: <1535753429.343743.1423556796294.JavaMail.open-xchange@oxbaltgw03.schlund.de>
References: <20150209222251.GA22303@localhost>
	<CAKi4VAK4Bp43VDTRhY7dETZ+sdnvh886vicUrASdCmn9+dtUqA@mail.gmail.com>
	<1535753429.343743.1423556796294.JavaMail.open-xchange@oxbaltgw03.schlund.de>
Date: Tue, 10 Feb 2015 08:31:00 -0200
Message-ID: <CAKi4VA+0PBrFc728HdpdmaKGr-B5+uPmQ5QKk2igMHqJTCpcrA@mail.gmail.com>
Subject: Re: [PATCH] Prevent offset + size overflow.
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: =?UTF-8?Q?Tobias_St=C3=B6ckmann?= <tobias@stoeckmann.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Feb 10, 2015 at 6:26 AM, Tobias St=C3=B6ckmann <tobias@stoeckmann.o=
rg> wrote:
> Hi,
>
>> On February 10, 2015 at 3:56 AM Lucas De Marchi <lucas.de.marchi@gmail.c=
om>
>> wrote:
>> > -       if (min_size > elf->size) {
>> > +       if (ULLONG_MAX - *offset < *size || min_size > elf->size) {
>
>> -       min_size =3D *offset + *size;
>> -       if (min_size > elf->size) {
>> +       if (__builtin_uaddl_overflow(*offset, *size, &min_size)
>> +           || min_size > elf->size) {
>
> If at all, it would have to be __builtin_uaddll_overflow due to uint64_t =
even on
> 32 bit systems. But even then the prototype looks a bit off to me:

sizeof(uint64_t) =3D=3D sizeof(unsigned long) both on 32 and 64 bits... no
need to use long long.

> from https://gcc.gnu.org/onlinedocs/gcc/Integer-Overflow-Builtins.html
> __builtin_uaddll_overflow (unsigned long long int a, unsigned long long i=
nt b,
> unsigned long int *res)
>
> I hope it's a typo and they meant "unsigned long long int *res", otherwis=
e that
> built-in function by itself is prone to truncation.

yep, it seems to be a typo

> If it works, i.e. the poc.ko module doesn't trigger a segmentation fault,=
 I am
> fine with that solution. When it's in the tree, I will create fixes for t=
he
> other occurrences in that style as well.

are you going to submit the patch or you're waiting on me?

> Please keep in mind that these libkmod issues are not limited to just mod=
info.
> The tool modinfo is just the easiest way to trigger them, because it does=
n't
> need any advanced permissions.

yep, it'd be good to have the other fixes, even more than this one. If
this is pointed out by any static analysis tool, feel free to add that
in the commit message.


thanks

--=20
Lucas De Marchi
