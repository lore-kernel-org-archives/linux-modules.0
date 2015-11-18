MIME-Version: 1.0
Date: Tue, 17 Nov 2015 22:22:49 -0200
Message-ID: <CAKi4VA+YGLYr_yciXOnwsACd69CZ+R86SsZr4eAWe-3KEJcpaA@mail.gmail.com>
Subject: [ANNOUNCE] kmod 22
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

kmod 22 is out:

        ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-22.tar.xz
        ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-22.tar.sign

Tiny release:

- Tools:
        - Change defaul log level for tools to WARNING rather than
ERROR and update
          some log levels for current messages

        - depmod doesn't fallback to uname if a bad version is passed
in the command
          line anymore. We just exit with an error.

        - insmod was taught the -f flag, just like in modprobe. It was
previously
          silently ignoring it.

- libkmod
        - New kmod_get_dirname() API to get the module directory set in the
          context

- Bug fixes:
        - Fix return code in error path of kmod_module_insert_module(). We were
          previously returning ENOSYS rather than ENOENT.


Shortlog:
Laura Abbott (5):
      README: Indicate cython requirements
      modprobe: Update error message when path is missing
      Change default log level
      depmod: Remove unprinted debug messages
      depmod: Don't fall back to uname on bad version

Lucas De Marchi (4):
      Add README.md file with build details
      libkmod-module: fix return code in error path
      libkmod: export new kmod_get_dirname() function
      kmod 22

Natanael Copa (1):
      build: let sed use posix ERE instead of GNU extension

Philippe De Swert (1):
      insmod: do support -f


Lucas De Marchi
