MIME-Version: 1.0
Date: Wed, 20 Jul 2016 02:19:55 -0300
Message-ID: <CAKi4VAL9QDTH64gbLRiVOhwqoucpjzwO1SRwb=MvKhgpPWF2Pw@mail.gmail.com>
Subject: [ANNOUNCE] kmod 23
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

kmod 23 is out:

        ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-23.tar.xz
        ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-23.tar.sign

- Improvements:
        - Don't add comment to modules.devname if it would otherwise be emp=
ty
          to play nice with tools detecting empty files

        - Allow building with BSD sed, that doesn't have -E flag

        - Ignore .TOC. symbols in depmod parsing as it's for PPC64 the
          equivalent of _GLOBAL_OFFSET_TABLE_

        - Teach modinfo about PKCS#7 module signatures: it doesn't add any
          other info besides telling the user the module is signed since
          kernel doesn't add other info on the module section

- Bug fixes

        - Fix -s and -p compat options to insmod triggering force flag

        - Fix long lines from /proc/modules not being handled correctly by
          kmod_module_new_from_loaded() and kmod_module_get_size() and seve=
ral
          other library functions that use them

        - Fix crash on modinfo while checking for available signature of
          unknown type

        - Fix documentation generation with gtk-doc


Shortlog is below

Anton Blanchard (1):
      depmod: Ignore PowerPC64 ABIv2 .TOC. symbol

H=C3=A9ctor Or=C3=B3n Mart=C3=ADnez (1):
      kmod: compiling with old sed version (!ERE support)

Josh Triplett (1):
      depmod: Don't insert comment in modules.devname if otherwise empty

Lucas De Marchi (8):
      travis: workaround bug in environment setup
      README: add link to patchwork
      libkmod-module: do not crash modinfo on 0 key id len
      libkmod-signature: handle PKCS#7
      libkmod-module: modinfo: print signature id
      libkmod: fix integration with gtk-doc
      NEWS: add items for kmod 23
      kmod 23

Marc-Antoine Perennou (1):
      insmod: fix wron fallthrough of -f

Michal Marek (1):
      libkmod: Handle long lines in /proc/modules

Peter Wu (1):
      kmod_module_get_refcnt: fix documentation


Lucas De Marchi
