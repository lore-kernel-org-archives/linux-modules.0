Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        bjorn.andersson@linaro.org
Subject: [PATCH RFC v2 0/2] Proposal for cycles handling
Date: Mon, 20 Feb 2017 16:18:58 +0200
Message-Id: <20170220141900.8705-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <CAKi4VA+dTLSTqk2T4jY8T=BgsGzzzGJ6P2zQfGpcXT=MtquXYg@mail.gmail.com>
References: <CAKi4VA+dTLSTqk2T4jY8T=BgsGzzzGJ6P2zQfGpcXT=MtquXYg@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>

This is an RFC proposal of dependency loops reporting.

V1->V2:

- use libkmod-internal.h and access list value directly;
- initially create reverse array with 3 elements;
- use memcpy() instead of strcpy() in depmod_report_one_cycle();
- replace "because" with "since" in comment about single branch.

Yauheni Kaliuta (2):
  testsuite: depmod: check netsted loops reporting
  depmod: handle nested loops

 Makefile.am                                        |   4 +
 testsuite/module-playground/Makefile               |   7 +
 testsuite/module-playground/cache/mod-loop-h.ko    | Bin 0 -> 197808 bytes
 testsuite/module-playground/cache/mod-loop-i.ko    | Bin 0 -> 197808 bytes
 testsuite/module-playground/cache/mod-loop-j.ko    | Bin 0 -> 197968 bytes
 testsuite/module-playground/cache/mod-loop-k.ko    | Bin 0 -> 197808 bytes
 testsuite/module-playground/mod-loop-h.c           |  25 ++
 testsuite/module-playground/mod-loop-i.c           |  25 ++
 testsuite/module-playground/mod-loop-j.c           |  26 ++
 testsuite/module-playground/mod-loop-k.c           |  25 ++
 testsuite/module-playground/mod-loop.h             |   4 +
 testsuite/populate-modules.sh                      |   4 +
 .../test-depmod/detect-loop/correct.txt            |   6 +-
 tools/depmod.c                                     | 292 +++++++++++++++------
 14 files changed, 332 insertions(+), 86 deletions(-)
 create mode 100644 testsuite/module-playground/cache/mod-loop-h.ko
 create mode 100644 testsuite/module-playground/cache/mod-loop-i.ko
 create mode 100644 testsuite/module-playground/cache/mod-loop-j.ko
 create mode 100644 testsuite/module-playground/cache/mod-loop-k.ko
 create mode 100644 testsuite/module-playground/mod-loop-h.c
 create mode 100644 testsuite/module-playground/mod-loop-i.c
 create mode 100644 testsuite/module-playground/mod-loop-j.c
 create mode 100644 testsuite/module-playground/mod-loop-k.c

-- 
2.9.2.368.g08bb350
