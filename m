MIME-Version: 1.0
In-Reply-To: <560282C6.6050702@ahsoftware.de>
References: <560282C6.6050702@ahsoftware.de>
Date: Wed, 23 Sep 2015 22:24:05 -0300
Message-ID: <CAKi4VAJAmCP7jEoVYzjm4yQLsEZPC6+GGLDtm7pM-2i=-CnXPQ@mail.gmail.com>
Subject: Re: depmod (kmod 21 and older) fails for allmodconfig on ARM
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-modules <linux-modules@vger.kernel.org>, linux-arm@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Sep 23, 2015 at 7:45 AM, Alexander Holler <holler@ahsoftware.de> wrote:
> Hello,
>
> make allmodconfig
> make -j4 zImage modules && make modules_install
>
> fails here on an ARM system with a malloc bug in depmod (after finding some
> circles).

The bug in kmod should be fixed indeed, but if you have dep cycles you
have other things to fix too.  What tree are you building? Do you have
any changes on top? malloc bug... looks like corrupted memory, but
very difficult to debug any further without more info.


Lucas De Marchi
