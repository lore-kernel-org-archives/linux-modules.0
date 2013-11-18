Return-Path: <lucas.de.marchi@gmail.com>
Received: from localhost.localdomain (ip-64-134-188-214.public.wayport.net. [64.134.188.214])
        by mx.google.com with ESMTPSA id u52sm27473992yhg.5.2013.11.18.06.04.50
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 06:04:53 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH 0/9] use cleanup attribute + misc patches
Date: Mon, 18 Nov 2013 12:04:18 -0200
Message-Id: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
List-ID: <linux-modules.vger.kernel.org>

With this patch set libkmod is now using attribute cleanup. It's working here
for me, but please give it a look.

There are also some minor improvements, such as adding OOM checks.

Lucas De Marchi (9):
  testsuite: Move test-alias to test-util
  util: Add cleanup attribute
  config: Use _cleanup_free_
  util: use _cleanup_free_ on path_make_absolute_cwd()
  testsuite: add basic test for getline_wrapped
  util: Be OOM-safe and use _cleanup_free_
  array: avoid duplicate code to reallocate
  file: use _cleanup_free_
  module: use _cleanup_free and remove useless call to free()

 Makefile.am                                        |   6 +-
 libkmod/libkmod-array.c                            |  38 ++++----
 libkmod/libkmod-config.c                           |  62 +++++-------
 libkmod/libkmod-file.c                             |   8 +-
 libkmod/libkmod-module.c                           |  14 +--
 libkmod/libkmod-util.c                             |  52 ++++++----
 libkmod/libkmod-util.h                             |   7 ++
 libkmod/macro.h                                    |   1 +
 testsuite/.gitignore                               |   6 +-
 testsuite/rootfs-pristine/test-alias/correct.txt   |  25 -----
 .../rootfs-pristine/test-util/alias-correct.txt    |  25 +++++
 .../test-util/getline_wrapped-correct.txt          |   6 ++
 .../test-util/getline_wrapped-input.txt            |   6 ++
 testsuite/test-alias.c                             |  75 ---------------
 testsuite/test-util.c                              | 106 +++++++++++++++++++++
 15 files changed, 238 insertions(+), 199 deletions(-)
 delete mode 100644 testsuite/rootfs-pristine/test-alias/correct.txt
 create mode 100644 testsuite/rootfs-pristine/test-util/alias-correct.txt
 create mode 100644 testsuite/rootfs-pristine/test-util/getline_wrapped-correct.txt
 create mode 100644 testsuite/rootfs-pristine/test-util/getline_wrapped-input.txt
 delete mode 100644 testsuite/test-alias.c
 create mode 100644 testsuite/test-util.c

-- 
1.8.4.2
