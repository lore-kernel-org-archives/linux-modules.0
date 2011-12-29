Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4EFC9872.7000708@suse.cz>
References: <1325173819-26274-1-git-send-email-lucas.demarchi@profusion.mobi> <4EFC9872.7000708@suse.cz>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 29 Dec 2011 14:55:23 -0200
Message-ID: <CAMOw1v5+6DOgjZAZ=YjYrp8geqwLpYu=e2SMY4V7+LYZAMMUeA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: add target to install gzipped modules
To: Michal Marek <mmarek@suse.cz>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

2011/12/29 Michal Marek <mmarek@suse.cz>:
> Dne 29.12.2011 16:50, Lucas De Marchi napsal(a):
>> Add target in Makefile to compress the module after it's installed.
>> Module-init-tools and libkmod can handle gzipped modules.
>
> I am not convinced that this is a needed feature. Compressing elf files
> means that depmod and modinfo need to read the whole compressed file
> from disk and unpack it, while only a couple of bytes need to be read.
> Those concerned about disk space either compile only the few needed
> modules and/or use some compressed filesystem, which allows for random
> access.
>
>
>> This is not much useful for distributions because the package will gzip
>> the modules and call depmod in a install rule. However for those
>> compiling the kernel on their own and debugging module loading, it's
>> useful so depmod doesn't have to be called twice and we don't have to
>> manually compress the modules.
>
> I understand that you need *.ko.gz support in kmod for the sake of
> feature parity and that such patch would help you with debugging. But I
> doubt there is use for it apart of developing kmod. Wouldn't an external
> script like this do the same job for you?
>
> #!/bin/sh
> make "$@" modules_install
> rel="$(make -s "$@" kernelrelease)"
> find "/lib/modules/$rel" -name '*.ko' -exec gzip '{}' ';'
> depmod "$rel"

Sure, but it has the same problem of running depmod twice. I was
thinking that compressed modules might be useful for others, not
developing kmod. At least I know Archlinux uses gzipped modules by
default and probably gentoo guys, too.


Lucas De Marchi
