MIME-Version: 1.0
In-Reply-To: <428397718.353502.1423565059923.JavaMail.open-xchange@oxbaltgw03.schlund.de>
References: <20150209222251.GA22303@localhost>
	<CAKi4VAK4Bp43VDTRhY7dETZ+sdnvh886vicUrASdCmn9+dtUqA@mail.gmail.com>
	<1535753429.343743.1423556796294.JavaMail.open-xchange@oxbaltgw03.schlund.de>
	<CAKi4VA+0PBrFc728HdpdmaKGr-B5+uPmQ5QKk2igMHqJTCpcrA@mail.gmail.com>
	<428397718.353502.1423565059923.JavaMail.open-xchange@oxbaltgw03.schlund.de>
Date: Tue, 10 Feb 2015 10:55:56 -0200
Message-ID: <CAKi4VALAp47Mvp80VLgcj9EZseWxqbj48ghFBzNUk5zRRpd-Rw@mail.gmail.com>
Subject: Re: [PATCH] Prevent offset + size overflow.
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: =?UTF-8?Q?Tobias_St=C3=B6ckmann?= <tobias@stoeckmann.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Feb 10, 2015 at 8:44 AM, Tobias St=C3=B6ckmann <tobias@stoeckmann.o=
rg> wrote:
> Hi again,
>
>> On February 10, 2015 at 11:31 AM Lucas De Marchi <lucas.de.marchi@gmail.=
com>
>> wrote:
>> sizeof(uint64_t) =3D=3D sizeof(unsigned long) both on 32 and 64 bits... =
no
>> need to use long long.
>
> long on 32 bit systems (at least my i686) is 32 bit -- granted, the C sta=
ndard
> doesn't explicitly require that. Yet I didn't encounter a 32 bit Linux wi=
th 64
> bit long, please correct me if I'm wrong and there are such systems out t=
here.
> long long would be 64 bit on both.

oohh... I blame the lack of coffee early in the morning for my stupid
comment. Indeed, you are right.

>
>> are you going to submit the patch or you're waiting on me?
>
> I have no commit access, so I am waiting for you. :)
> As stated before, please use the long long variant.

well, you could submit to the mailing list a patch series :-)

Anyway, I applied this patch, added addu64_overflow() abstracting if
the compiler has the builtin and converted your patch to use this new
function.

Let me know of the other problems you talked about.

thanks

--=20
Lucas De Marchi
