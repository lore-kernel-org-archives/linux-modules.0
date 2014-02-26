MIME-Version: 1.0
In-Reply-To: <4873416.CU5HjpvjRz@kru>
References: <1627264.ihO3vEG55s@kru>
	<4873416.CU5HjpvjRz@kru>
Date: Wed, 26 Feb 2014 17:06:47 -0300
Message-ID: <CAKi4VAJzSVnFT9gUGu-2kg5Zpbj7+EPxRkzc9FjSLdjQT6m2og@mail.gmail.com>
Subject: Re: [PATCH] Re: modprobe documentation discrepancy (modules.dep support)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Andrej Krutak <andrej.krutak@sysgo.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 26, 2014 at 1:19 PM, Andrej Krutak <andrej.krutak@sysgo.com> wrote:
> Hi again,
>
> below is a patch to (re-)add support for modules.dep (in addition to
> modules.dep.bin), in a very dirty way. Basically I just took parts of the
> original code from module-init-tools...
>
> Also, it fixes the CHECK_ERR_AND_FINISH macro.
>
>
> However, this doesn't fix the whole "problem" - 'modprobe nonexistingmodule'
> is called, no error is printed, because of the faulty processing of subsequent
> non-existent files (like modules.builtin.bin etc. - which depmod.pl doesn't
> generate).
>
> To fully fix this, one would have to also add support for the other
> legacy files. Well, at least a support to handle the missing files gracefully.
>
> Fixing this is important for when you want to cross-compile the kernel in a
> non-linux environment. I didn't find find any other tool than depmod.pl that
> could generate all the files required by modprobe (but depmod.pl, as mentioned
> before, doesn't generate other .bin files) - and kmod/module-init-tools can't
> be cross-compiled for cygwin/mingw32...

I think it's better to just remove the reference in the man page. We
don't support other tools poking /lib/modules/* files. They are
private to kmod and we can break them in a future version.

I'd rather advise you to fix your setup so you don't need to
cross-compile depmod. If you want to cross-compile... well, you need
to provide the patches to at least adding the stubs for things that
doesn't exist there... But this patch would probably never be accepted
upstream since it's such a weird thing to do, sorry.

Lucas De Marchi
