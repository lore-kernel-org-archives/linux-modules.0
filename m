Return-Path: <tobias@stoeckmann.org>
Date: Tue, 10 Feb 2015 14:23:12 +0100 (CET)
From: =?UTF-8?Q?Tobias_St=C3=B6ckmann?= <tobias@stoeckmann.org>
Reply-To: =?UTF-8?Q?Tobias_St=C3=B6ckmann?= <tobias@stoeckmann.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Message-ID: <1822445287.359056.1423574592995.JavaMail.open-xchange@oxbaltgw06.schlund.de>
In-Reply-To: <CAKi4VALAp47Mvp80VLgcj9EZseWxqbj48ghFBzNUk5zRRpd-Rw@mail.gmail.com>
References: <20150209222251.GA22303@localhost> <CAKi4VAK4Bp43VDTRhY7dETZ+sdnvh886vicUrASdCmn9+dtUqA@mail.gmail.com> <1535753429.343743.1423556796294.JavaMail.open-xchange@oxbaltgw03.schlund.de> <CAKi4VA+0PBrFc728HdpdmaKGr-B5+uPmQ5QKk2igMHqJTCpcrA@mail.gmail.com> <428397718.353502.1423565059923.JavaMail.open-xchange@oxbaltgw03.schlund.de> <CAKi4VALAp47Mvp80VLgcj9EZseWxqbj48ghFBzNUk5zRRpd-Rw@mail.gmail.com>
Subject: Re: [PATCH] Prevent offset + size overflow.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

> On February 10, 2015 at 1:55 PM Lucas De Marchi <lucas.de.marchi@gmail.com>
> wrote:
> well, you could submit to the mailing list a patch series :-)
> 
> Anyway, I applied this patch, added addu64_overflow() abstracting if
> the compiler has the builtin and converted your patch to use this new
> function.
> 
> Let me know of the other problems you talked about.

Sure thing, I will send patches with the addu64_overflow() merged into them when
I'm back home.


Thanks for your fast response,

Tobias
