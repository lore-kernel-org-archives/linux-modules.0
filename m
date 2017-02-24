MIME-Version: 1.0
Date: Thu, 23 Feb 2017 23:46:01 -0800
Message-ID: <CAKi4VAJkWdvPf_q=mKVKvh2i10zMtgBU5_vH8hW=uEZ425pq7g@mail.gmail.com>
Subject: [ANNOUNCE] kmod 24
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	Jessica Yu <jeyu@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

kmod 24 is out:

        ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-24.tar.xz
        ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-24.tar.sign

- Improvements:
        - Add more information on dependency loop

        - Sanitize use of strcpy and allow to grow from small strings on stack
          (common case) to bigger strings on heap when needed

- Bug fixes
        - Fix wrong dependency loops being reported by depmod

        - Fix crashes when reporting dependency loops

        - Fix parsing kernel command line containing quotes

        - Fix leaks on error paths

Shortlog is below

Bartosz Golaszewski (1):
      module: fix a memory leak

James Minor (1):
      libkmod: Fix handling of quotes in kernel command line

Lucas De Marchi (15):
      libkmod: fix use of strcpy
      util: fix warning of equal values on logical OR
      testsuite: include stdio.h
      Add scratchbuf implementation
      depmod: fix string overflow
      build: fix build with disabled test modules
      testsuite: fix typo in description
      testsuite: add test for kernel cmdline with quotes
      libkmod-config: replace 0/1 with bool
      libkmod-config: fix parsing quoted kernel cmdline on params
      build: add missing header
      man: make error message clearer for missing xstlproc
      depmod: fix leak on error path
      build: update autogen
      kmod 24

Mian Yousaf Kaukab (2):
      testsuite: depmod: add module dependency outside cyclic chain
      depmod: ignore related modules in depmod_report_cycles

Yauheni Kaliuta (4):
      testsuite: fix test_array_sort pointers inderection
      shared: make scratchbuf_str static
      testsuite: depmod: check netsted loops reporting
      depmod: handle nested loops



Lucas De Marchi
