Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbcKKLm2 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Nov 2016 06:42:28 -0500
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules@vger.kernel.org
Cc: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        bjorn.andersson@linaro.org, Jessica Yu <jeyu@redhat.com>
Subject: [PATCH RFC 0/3] Proposal for cycles handling
Date: Fri, 11 Nov 2016 13:43:18 +0200
Message-Id: <1478864601-3259-1-git-send-email-yauheni.kaliuta@redhat.com>
In-Reply-To: <1478683053.4155.8.camel@suse.com>
References: <1478683053.4155.8.camel@suse.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Back to the discussion, does it make any sense?

This is an RFC proposal of dependency loops reporting.

Yauheni Kaliuta (3):
  testsuite: depmod: check netsted loops reporting
  libkmod: list: export list handling functions
  depmod: handle nested loops

 Makefile.am                                        |   4 +
 libkmod/libkmod-internal.h                         |   4 -
 libkmod/libkmod-list.c                             |  36 ++-
 libkmod/libkmod.h                                  |   5 +
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
 tools/depmod.c                                     | 287 +++++++++++++++------
 17 files changed, 367 insertions(+), 91 deletions(-)
 create mode 100644 testsuite/module-playground/cache/mod-loop-h.ko
 create mode 100644 testsuite/module-playground/cache/mod-loop-i.ko
 create mode 100644 testsuite/module-playground/cache/mod-loop-j.ko
 create mode 100644 testsuite/module-playground/cache/mod-loop-k.ko
 create mode 100644 testsuite/module-playground/mod-loop-h.c
 create mode 100644 testsuite/module-playground/mod-loop-i.c
 create mode 100644 testsuite/module-playground/mod-loop-j.c
 create mode 100644 testsuite/module-playground/mod-loop-k.c

-- 
2.7.4

