Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4EFC9872.7000708@suse.cz>
References: <1325173819-26274-1-git-send-email-lucas.demarchi@profusion.mobi> <4EFC9872.7000708@suse.cz>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 29 Dec 2011 15:35:34 -0200
Message-ID: <CAMOw1v6GhA+B2oXcVK4YZULb6kq=-NFTv-=-4eYB0ukZ9acP-w@mail.gmail.com>
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

How many times do you need to call depmod / modinfo?

The operation that is used most of the time is to load modules. The
reason for having modules gzipped is the same one as for kernel image:
fast bootup on slow disks and less disk space used per installed
kernel.


Lucas De Marchi
