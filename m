MIME-Version: 1.0
In-Reply-To: <9BA84827B30CBE4996725F98F7DC912342962FC2@SMExchange01.siebmeyer.org>
References: <9BA84827B30CBE4996725F98F7DC912342962FC2@SMExchange01.siebmeyer.org>
Date: Thu, 16 Apr 2015 08:25:18 -0300
Message-ID: <CAKi4VA++ym4Ry84hRUCf6MpLoxwo59V910Y5DKbWKavW1SS0_g@mail.gmail.com>
Subject: Re: modules out of tree issue
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: =?UTF-8?Q?H=C3=A4nel=2DBaas=2C_Alexander?= <alexander.haenel-baas@sieb-meyer.de>
Cc: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Thu, Apr 16, 2015 at 6:41 AM, H=C3=A4nel-Baas, Alexander
<alexander.haenel-baas@sieb-meyer.de> wrote:
> Hi,
>
> I cross compile my own kernelmodule out of tree.
> Now I changed the kernel to 3.18.1 and when I compile my own module I get=
 the error:
> -ld: no input files

could you share your makefile? otherwise it's difficult to say what's happe=
ning.


> The first call is the ld and not the compiler. This is the problem.
>
> With kernel 3.14 and older always compiled good.
>
> Is there any changes in the kernel makefile to build the kernel out of tr=
ee?

Not that I'm aware of.  I compile out-of-tree modules just fine. See
https://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/tree/testsuite/modul=
e-playground/Makefile
for an example.


> Any ideas?
>
> I'm not sure is this the right group, sorry.

You probably should CC lkml as well. Doing it now.


--=20
Lucas De Marchi
