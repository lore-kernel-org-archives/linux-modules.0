Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:63082 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeACW3d (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 3 Jan 2018 17:29:33 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules@vger.kernel.org
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 0/6] prepare for release
Date: Wed,  3 Jan 2018 14:29:18 -0800
Message-Id: <20180103222924.26347-1-lucas.demarchi@intel.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

I already applied the first patch since I was thinking about just
quickly testing in a pristine environment before releasing.
However I went ahead and 1) added support for more than one distro
using mkosi and 2) debugged why the testsuite was failing for me.

After this I think we are safe to do a new release.


Lucas De Marchi (6):
  build: add mkosi hooks
  build: use tool from configure
  testsuite: generalize mkosi support for other distros
  testsuite: add Fedora's mkosi configuration
  testsuite: add missing error handling
  testsuite: explain why overriding function may fail

 Makefile.am                  | 10 ++++++++++
 configure.ac                 |  1 +
 testsuite/init_module.c      |  9 +++++++--
 testsuite/mkosi/.gitignore   |  3 +++
 testsuite/mkosi/mkosi.arch   | 25 +++++++++++++++++++++++++
 testsuite/mkosi/mkosi.build  | 38 ++++++++++++++++++++++++++++++++++++++
 testsuite/mkosi/mkosi.fedora | 26 ++++++++++++++++++++++++++
 testsuite/testsuite.h        |  2 ++
 8 files changed, 112 insertions(+), 2 deletions(-)
 create mode 100644 testsuite/mkosi/.gitignore
 create mode 100644 testsuite/mkosi/mkosi.arch
 create mode 100755 testsuite/mkosi/mkosi.build
 create mode 100644 testsuite/mkosi/mkosi.fedora

-- 
2.14.3

