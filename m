MIME-Version: 1.0
In-Reply-To: <52B33B88.2090306@mageta.org>
References: <52B33B88.2090306@mageta.org>
Date: Sun, 22 Dec 2013 19:16:45 -0200
Message-ID: <CAKi4VAKHuVKnWzo0qU5dy+WcYMogFZv67V6gy9OqobjuiETP-g@mail.gmail.com>
Subject: Re: Can't load modules with parameters given
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: bebl@mageta.org
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Benjamin,


On Thu, Dec 19, 2013 at 4:31 PM, Benjamin Block <bebl@mageta.org> wrote:
> Hi,
>
> I have a rather strange problem currently. I am trying to load a module

strange indeed

> with some parameters (bnx2x with disable_tpa=1) and it fails because
> this parameter is unknown according to dmesg. But modinfo lists this
> exact paramter and it is also included in the source. And while this is
> not an in-tree driver, I could also replicate the same behavior with

are you sure modinfo and modprobe are reading the same module? maybe
you updated your modules between the operations?


> in-tree device drivers (like bonding with the parameter tx_queues):
>
> $ modprobe bonding # works fine
> $ rmmod bonding
> $ modprobe bonding tx_queues=32
> modprobe: ERROR: could not insert 'bonding': Unknown symbol in module,
> or unknown parameter (see dmesg)
>
> and dmesg tells me:
>         bonding: Unknown parameter `tx_queues'
> and nothing else (as with bnx2x, this parameter is listed by modinfo).
>
> Is there some obvious kernel-config-option I could have messed up or
> something else like this?

So... this changed in recent kernels (3.11 -- see the commit message
that introduced this behavior below)... we don't fail to load a module
anymore due to unknown option. So if/when you upgrade you won't see
this problem anymore.

Anyway, it shouldn't fail for you like it did, but it might as well be
a problem of the particularly patched kernel you are using... not
sure.


>
> I am using a Gentoo-Userspace kmod (v15) with a Ubuntu-Kernel (3.8.13.13
> - this is a version with some ubuntu-patches applied) - I know, the
> combination is rather strange. Any ideas?

the combination is not a problem and should work just fine.



Lucas De Marchi



---
commit 54041d8a73337411b485ff76957fb106cb5d40d0
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Tue Jul 2 15:35:12 2013 +0930

    modules: don't fail to load on unknown parameters.

    Although parameters are supposed to be part of the kernel API, experimental
    parameters are often removed.  In addition, downgrading a kernel might cause
    previously-working modules to fail to load.

    On balance, it's probably better to warn, and load the module anyway.
    This may let through a typo, but at least the logs will show it.

    Reported-by: Andy Lutomirski <luto@amacapital.net>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
