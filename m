MIME-Version: 1.0
Date: Mon, 8 Jan 2018 17:54:42 -0800
Message-ID: <CAKi4VAKLMDhxZYq8mskO_EQWTHQKX+ikWHBK39DEDtM=R+H=QQ@mail.gmail.com>
Subject: [ANNOUNCE] kmod 25
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

kmod 25 is out:

        https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-25.tar.xz
        https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-25.tar.sign

- Improvements
        - Add module signature to modinfo output

        - Add support for external directories in depmod: now there's a new
          "external" keyword parsed by depmod when calculating the dependen=
cies.
          It allows to add modules to other directories which are not relat=
ive
          to where the modules are commonly installed.  This results in
          modules.dep and friends now understanding absolute paths rather t=
han
          relative paths only. For more information see depmod.d(1).

        - Add support for CONFIG_MODULE_REL_CRCS

        - Add missing documentation references in man pages

        - Handle the case in which module has a .TOC symbol already while
          calculating dependencies

        - Improve testsuite and allow to use mkosi to run testsuite in diff=
erent
          distros

Shortlog is below:

Yauheni Kaliuta (14):
      libkmod: modinfo: fix sig_id output
      libkmod: modinfo: use own function for sig_key hex output
      libkmod: modinfo: implement line splitting in hex_to_str
      libkmod: modinfo: implement signature output
      depmod: fix errorpath memleaks in report cycles logic
      depmod: search key: move builtin detection under the add function
      depmod: create depmod dir independent search function
      depmod: rewrite depmod modules search with scratchbuf
      depmod: implement external directories support
      testsuite: add tests for external directory support
      man/depmod.d: add external keyword description
      libkmod-elf: resolve CRC if module is built with MODULE_REL_CRCS
      testsuite: depmod: add override test
      depmod: module_is_higher_priority: fix modname length calculation

Lucas De Marchi (9):
      test-depmod: avoid warning when we don't have zlib
      build: add mkosi hooks
      build: use tool from configure
      testsuite: generalize mkosi support for other distros
      testsuite: add Fedora's mkosi configuration
      testsuite: add missing error handling
      testsuite: explain why overriding function may fail
      testsuite: also wrap gettid in syscall()
      kmod 25

Christopher D=C3=ADaz Riveros (1):
      man/depmod: Add references in other man pages

Michal Suchanek (1):
      depmod: Don't add .TOC. when it's in the kernel.

Thomas Petazzoni (1):
      shared/util.c: assert_cc() can only be used inside functions


Lucas De Marchi
