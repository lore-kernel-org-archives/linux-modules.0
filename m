Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,  Ard Biesheuvel <ard.biesheuvel@linaro.org>,  lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libkmod-elf: resolve CRC if module is built with MODULE_REL_CRCS
References: <20170719145649.20334-1-yauheni.kaliuta@redhat.com>
	<CAKi4VA+oMMXajB7_xF2qraye9h7k-JqG5h9Fk7fv9xenW_nvcA@mail.gmail.com>
Date: Wed, 19 Jul 2017 22:04:19 +0300
In-Reply-To: <CAKi4VA+oMMXajB7_xF2qraye9h7k-JqG5h9Fk7fv9xenW_nvcA@mail.gmail.com>
	(Lucas De Marchi's message of "Wed, 19 Jul 2017 10:51:44 -0700")
Message-ID: <xunyh8y8qmdo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Wed, 19 Jul 2017 10:51:44 -0700, Lucas De Marchi  wrote:
 > On Wed, Jul 19, 2017 at 7:56 AM, Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> Normally exported symbol's crc is stored as absolute (SHN_ABS)
 >> value of special named symbol __crc_<symbol name>.
 >> 
 >> When the kernel and modules are built with the config option
 >> CONFIG_MODULE_REL_CRCS, all the CRCs are put in a special section
 >> and the __crc_<symbol name> symbols values are offsets in the
 >> section. See patch description of the commit:
 >> 
 >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=56067812d5b0e737ac2063e94a50f76b810d6ca3
 >> 
 >> Add kmod support of this configuration.

[...]

 > LGTM. I'll give this a try and apply.

Thanks! I would also like to get some feedback from the kernel feature
author, Ard Biesheuvel, that this does not miss other usecases.

 > Do you think it's possible to build an out-of-tree module with this
 > option so we can add one to the testsuite?

I'll check what I can do.

The problem is seen if you run depmod with -e -E, which I guess is not used
too often.

-- 
WBR,
Yauheni Kaliuta
