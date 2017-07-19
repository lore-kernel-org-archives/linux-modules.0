Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,  linux-modules <linux-modules@vger.kernel.org>,  lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libkmod-elf: resolve CRC if module is built with MODULE_REL_CRCS
References: <20170719145649.20334-1-yauheni.kaliuta@redhat.com>
	<CAKi4VA+oMMXajB7_xF2qraye9h7k-JqG5h9Fk7fv9xenW_nvcA@mail.gmail.com>
	<xunyh8y8qmdo.fsf@redhat.com>
	<CAKv+Gu-Mvk_VPT1L8NUvJNrAcoyA5RMX8FjkV4VYJTfHKTtyZQ@mail.gmail.com>
Date: Wed, 19 Jul 2017 22:33:23 +0300
In-Reply-To: <CAKv+Gu-Mvk_VPT1L8NUvJNrAcoyA5RMX8FjkV4VYJTfHKTtyZQ@mail.gmail.com>
	(Ard Biesheuvel's message of "Wed, 19 Jul 2017 20:10:17 +0100")
Message-ID: <xuny7ez4ql18.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Hi, Ard!

>>>>> On Wed, 19 Jul 2017 20:10:17 +0100, Ard Biesheuvel  wrote:

 > On 19 July 2017 at 20:04, Yauheni Kaliuta <yauheni.kaliuta@redhat.com> wrote:
 >> Hi, Lucas!
 >> 
 >>>>>>> On Wed, 19 Jul 2017 10:51:44 -0700, Lucas De Marchi  wrote:
 >> > On Wed, Jul 19, 2017 at 7:56 AM, Yauheni Kaliuta
 >> > <yauheni.kaliuta@redhat.com> wrote:
 >> >> Normally exported symbol's crc is stored as absolute (SHN_ABS)
 >> >> value of special named symbol __crc_<symbol name>.
 >> >>
 >> >> When the kernel and modules are built with the config option
 >> >> CONFIG_MODULE_REL_CRCS, all the CRCs are put in a special section
 >> >> and the __crc_<symbol name> symbols values are offsets in the
 >> >> section. See patch description of the commit:
 >> >>
 >> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=56067812d5b0e737ac2063e94a50f76b810d6ca3
 >> >>
 >> >> Add kmod support of this configuration.
 >> 
 >> [...]
 >> 
 >> > LGTM. I'll give this a try and apply.
 >> 
 >> Thanks! I would also like to get some feedback from the kernel feature
 >> author, Ard Biesheuvel, that this does not miss other usecases.
 >> 

 > The patch looks correct to me. My only comment is that
 > kmod_elf_resolve_crc() should probably return a uint32_t instead,
 > given the size of a CRC32.

Well, it's a specific of the internal libkmod implementation. Both
struct kmod_modversion::crc and return value of elf_get_uint()
are uint64_t, but in the patch elf_get_uint() reads correct
sizeof(uint32_t) value from the ELF.

 > In any case,

 > Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks a lot!

-- 
WBR,
Yauheni Kaliuta
