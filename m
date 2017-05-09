Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: [PATCHv2 0/4] depmod: implement external directories support
Date: Tue,  9 May 2017 22:09:20 +0300
Message-Id: <20170509190924.9087-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
References: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>


This is a pretty simple extention of existing logic, since now
depmod already is able to:

a) scan modules with full path from command line without -a
switch;
b) detects broken symbol dependencies and broken modversions,
what assumes, that modules are already are not built for the
existing kernel.

See PATCH3 description.


V1->V2:

- rewrite directory scanning code to use scratchbuf;
- add tests.

Yauheni Kaliuta (4):
  depmod: create depmod dir independent search function
  depmod: rewrite depmod modules search with scratchbuf
  depmod: implement external directories support
  testsuite: add tests for external directory support

 testsuite/populate-modules.sh                      |   8 +
 .../etc/depmod.d/external.conf                     |   1 +
 .../etc/depmod.d/search.conf                       |   1 +
 .../lib/modules/4.4.4/correct-modules.dep          |   1 +
 .../etc/depmod.d/external.conf                     |   1 +
 .../etc/depmod.d/search.conf                       |   1 +
 .../lib/modules/4.4.4/correct-modules.dep          |   1 +
 .../test-modinfo/correct-external.txt              |   1 +
 .../external/lib/modules/4.4.4/modules.alias       |   1 +
 .../external/lib/modules/4.4.4/modules.alias.bin   | Bin 0 -> 12 bytes
 .../external/lib/modules/4.4.4/modules.builtin.bin |   0
 .../external/lib/modules/4.4.4/modules.dep         |   1 +
 .../external/lib/modules/4.4.4/modules.dep.bin     | Bin 0 -> 73 bytes
 .../external/lib/modules/4.4.4/modules.devname     |   0
 .../external/lib/modules/4.4.4/modules.softdep     |   1 +
 .../external/lib/modules/4.4.4/modules.symbols     |   1 +
 .../external/lib/modules/4.4.4/modules.symbols.bin | Bin 0 -> 12 bytes
 .../external/lib/modules/4.4.4/modules.alias       |   1 +
 .../external/lib/modules/4.4.4/modules.alias.bin   | Bin 0 -> 12 bytes
 .../external/lib/modules/4.4.4/modules.builtin.bin |   0
 .../external/lib/modules/4.4.4/modules.dep         |   1 +
 .../external/lib/modules/4.4.4/modules.dep.bin     | Bin 0 -> 73 bytes
 .../external/lib/modules/4.4.4/modules.devname     |   0
 .../external/lib/modules/4.4.4/modules.softdep     |   1 +
 .../external/lib/modules/4.4.4/modules.symbols     |   1 +
 .../external/lib/modules/4.4.4/modules.symbols.bin | Bin 0 -> 12 bytes
 .../test-modprobe/external/proc/modules            |   0
 testsuite/test-depmod.c                            |  52 +++++
 testsuite/test-modinfo.c                           |  21 ++
 testsuite/test-modprobe.c                          |  22 ++
 tools/depmod.c                                     | 232 +++++++++++++++++----
 31 files changed, 309 insertions(+), 41 deletions(-)
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-external-first/etc/depmod.d/external.conf
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-external-first/etc/depmod.d/search.conf
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-external-first/lib/modules/4.4.4/correct-modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-external-last/etc/depmod.d/external.conf
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-external-last/etc/depmod.d/search.conf
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-external-last/lib/modules/4.4.4/correct-modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/correct-external.txt
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modinfo/external/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/external/proc/modules

-- 
2.12.2.639.g584f8975d2d9
