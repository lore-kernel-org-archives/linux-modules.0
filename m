Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        bjorn.andersson@linaro.org
Subject: [PATCH v3 0/2] Proposal for cycles handling
Date: Wed, 22 Feb 2017 11:41:57 +0200
Message-Id: <20170222094159.3187-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <CAKi4VA+4KsvtNje0TVBfp2PtPtyLOBVvYfC5uMJZHBnynWfP=g@mail.gmail.com>
References: <CAKi4VA+4KsvtNje0TVBfp2PtPtyLOBVvYfC5uMJZHBnynWfP=g@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>

V3->V2:

- depmod.c: undefine ERR and DBG macros, included by libkmod-internal.h

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
 tools/depmod.c                                     | 295 +++++++++++++++------
 14 files changed, 335 insertions(+), 86 deletions(-)
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
