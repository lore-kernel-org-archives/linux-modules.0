MIME-Version: 1.0
In-Reply-To: <20140826120442.8223.80618.stgit@kbuild-fedora.novalocal>
References: <53FC52DA.9000303@hitachi.com>
	<20140826120442.8223.80618.stgit@kbuild-fedora.novalocal>
Date: Mon, 1 Sep 2014 19:17:48 -0300
Message-ID: <CAKi4VAJH-oYuDrW1nvNrQ409D0ZQHxexuVwWq8arGRQwbU+ycA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] kmod: Support lockup option to make module un-removable
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Lucas De Marchi <lucas.demarchi@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-modules <linux-modules@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Aug 26, 2014 at 9:04 AM, Masami Hiramatsu
<masami.hiramatsu.pt@hitachi.com> wrote:
> Hi,
>
> Here is a pair of patches which adds --lockup option to
> modprobe and libkmod.
>
> As I sent a series of patches which removes stop_machine()
> from module removal: https://lkml.org/lkml/2014/8/25/142
> it also adds lockup option which lock up the module in
> the kernel and makes it un-removable.
>
> These patches enables us to use that option when loading
> modules. Module lockup may be good for BIG SMP machines
> since the kernel skips module refcounting if the module
> is locked up :)
>
> Anyway, this is not needed if the lockup option is dropped
> from the series. I send this for testing.

Ok. I'm not sure it's clear... I'm waiting for feedback on the kernel
patches in order to proceed with any review here. I'm not really
convinced we want this option when loading a module.

Rusty, what do you think?

-- 
Lucas De Marchi
