MIME-Version: 1.0
In-Reply-To: <1399659299-31241-1-git-send-email-lucas.demarchi@intel.com>
References: <1399659299-31241-1-git-send-email-lucas.demarchi@intel.com>
Date: Thu, 15 May 2014 00:02:46 -0300
Message-ID: <CAKi4VAJ9uDw9+qFWUXKsUeX-cpGpjvR0AmoUEz-+kvCPFADGuw@mail.gmail.com>
Subject: Re: [PATCH] depmod: Make dependency loops be fatal
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	"Matwey V. Kornilov" <matwey.kornilov@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>,
	Gustavo Sverzut Barbieri <barbieri@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, May 9, 2014 at 3:14 PM, Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
> Since the beginning depmod just warned about dependency loops and upon
> creation of modules.dep{,.bin} it skipped the modules that were part of
> a loop. However just skipping the modules may come as a surprise to
> kernel module developers: they will need to try to load the module (or
> to pay attention to the log messages) to notice thavt the module has not
> been put in the index. Also, differently from module-init-tools we were
> not skipping modules that depend on modules with dependency loops,
> leading to a segfault in depmod.
>
> So this is a summary of the change in behavior with this patch:
>
> Loop 1)
>     A -> B -> C -
>     ^           |
>     '------------
>
>     Before:
>         depmod: WARNING: found 3 modules in dependency cycles!
>         depmod: WARNING: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleB.ko in dependency cycle!
>         depmod: WARNING: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleC.ko in dependency cycle!
>         depmod: WARNING: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleA.ko in dependency cycle!
>
>         return code: 0
>
>     After:
>         depmod: ERROR: Found 3 modules in dependency cycles!
>         depmod: ERROR: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleB.ko in dependency cycle!
>         depmod: ERROR: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleC.ko in dependency cycle!
>         depmod: ERROR: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleA.ko in dependency cycle!
>
>         return code: 2
>
> Loop 2)
>     A -> B -> C -
>          ^      |
>          '-------
>
>     Before:
>         depmod: WARNING: found 2 modules in dependency cycles!
>         depmod: WARNING: /tmp/test-kmod//lib/modules/3.14.2-1-ARCH/kernel/moduleB.ko in dependency cycle!
>         depmod: WARNING: /tmp/test-kmod//lib/modules/3.14.2-1-ARCH/kernel/moduleC.ko in dependency cycle!
>         Segmentation fault (core dumped)
>
>     After:
>         depmod: ERROR: Found 2 modules in dependency cycles!
>         depmod: ERROR: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleB.ko in dependency cycle!
>         depmod: ERROR: /tmp/test-kmod/lib/modules/3.14.2-1-ARCH/kernel/moduleC.ko in dependency cycle!
>
>         return code: 2
>
> The segfault above could be fixed, but let's just fail everything
> because dependency cycles should be fixed in the modules rather than
> just be skipped in the index.
> ---
>  tools/depmod.c | 55 +++++++++----------------------------------------------
>  1 file changed, 9 insertions(+), 46 deletions(-)

This is now applied. It's better to fail the upgrade than to provide
the user a broken setup, that maybe can't even boot successfully. The
old behavior can be achieved by just disabling the module in the
kernel config.

--
Lucas De Marchi
