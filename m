Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: [PATCH 0/2] depmod: fix override lookup
Date: Thu,  7 Dec 2017 21:16:06 +0200
Message-Id: <20171207191608.14293-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

Add override test.
Fix a relative path calculation mistake.


Yauheni Kaliuta (2):
  testsuite: depmod: add override test
  depmod: module_is_higher_priority: fix modname length calculation

 testsuite/populate-modules.sh                      |  2 ++
 .../etc/depmod.d/override.conf                     |  1 +
 .../search-order-override/etc/depmod.d/search.conf |  1 +
 .../lib/modules/4.4.4/correct-modules.dep          |  1 +
 testsuite/test-depmod.c                            | 26 ++++++++++++++++++++++
 tools/depmod.c                                     |  4 ++--
 6 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-override/etc/depmod.d/override.conf
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-override/etc/depmod.d/search.conf
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-override/lib/modules/4.4.4/correct-modules.dep

-- 
2.15.1
