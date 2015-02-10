Return-Path: <tobias@stoeckmann.org>
Date: Tue, 10 Feb 2015 09:26:36 +0100 (CET)
From: =?UTF-8?Q?Tobias_St=C3=B6ckmann?= <tobias@stoeckmann.org>
Reply-To: =?UTF-8?Q?Tobias_St=C3=B6ckmann?= <tobias@stoeckmann.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Message-ID: <1535753429.343743.1423556796294.JavaMail.open-xchange@oxbaltgw03.schlund.de>
In-Reply-To: <CAKi4VAK4Bp43VDTRhY7dETZ+sdnvh886vicUrASdCmn9+dtUqA@mail.gmail.com>
References: <20150209222251.GA22303@localhost> <CAKi4VAK4Bp43VDTRhY7dETZ+sdnvh886vicUrASdCmn9+dtUqA@mail.gmail.com>
Subject: Re: [PATCH] Prevent offset + size overflow.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

> On February 10, 2015 at 3:56 AM Lucas De Marchi <lucas.de.marchi@gmail.com>
> wrote:
> > -       if (min_size > elf->size) {
> > +       if (ULLONG_MAX - *offset < *size || min_size > elf->size) {

> -       min_size = *offset + *size;
> -       if (min_size > elf->size) {
> +       if (__builtin_uaddl_overflow(*offset, *size, &min_size)
> +           || min_size > elf->size) {

If at all, it would have to be __builtin_uaddll_overflow due to uint64_t even on
32 bit systems. But even then the prototype looks a bit off to me:

from https://gcc.gnu.org/onlinedocs/gcc/Integer-Overflow-Builtins.html
__builtin_uaddll_overflow (unsigned long long int a, unsigned long long int b,
unsigned long int *res)

I hope it's a typo and they meant "unsigned long long int *res", otherwise that
built-in function by itself is prone to truncation.

If it works, i.e. the poc.ko module doesn't trigger a segmentation fault, I am
fine with that solution. When it's in the tree, I will create fixes for the
other occurrences in that style as well.

Please keep in mind that these libkmod issues are not limited to just modinfo.
The tool modinfo is just the easiest way to trigger them, because it doesn't
need any advanced permissions.


Tobias
